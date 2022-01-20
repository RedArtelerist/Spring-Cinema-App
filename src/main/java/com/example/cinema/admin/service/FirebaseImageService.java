package com.example.cinema.admin.service;

import com.example.cinema.admin.dto.FirebaseCredential;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.storage.Blob;
import com.google.cloud.storage.Bucket;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.cloud.StorageClient;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.EventListener;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import org.apache.commons.io.IOUtils;
import java.util.UUID;

@Service
public class FirebaseImageService {
    @Autowired
    private Properties properties;

    @Autowired
    private Environment environment;

    private String imageURL;


    @EventListener
    public void init(ApplicationReadyEvent event) {
        // initialize Firebase
        try {
            //ClassPathResource serviceAccount = new ClassPathResource("firebase.json");
            InputStream firebaseCredential = createFirebaseCredential();

            FirebaseOptions options = new FirebaseOptions.Builder()
                    //.setCredentials(GoogleCredentials.fromStream(serviceAccount.getInputStream()))
                    .setCredentials(GoogleCredentials.fromStream(firebaseCredential))
                    .setStorageBucket(properties.getBucketName())
                    .build();

            FirebaseApp.initializeApp(options);
            imageURL = properties.getImageUrl();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public String getImageUrl(String name) {
        return String.format(imageURL, URLEncoder.encode(name));
    }

    public String save(MultipartFile file, String folder) throws IOException {
        Bucket bucket = StorageClient.getInstance().bucket();
        String name = generateFileName(file.getOriginalFilename(), folder);
        bucket.create(name, file.getBytes(), file.getContentType());

        return name;
    }

    public void delete(String name) throws IOException {
        Bucket bucket = StorageClient.getInstance().bucket();

        if (StringUtils.isEmpty(name)) {
            throw new IOException("invalid file name");
        }

        Blob blob = bucket.get(name);
        if (blob == null) {
            throw new IOException("file not found");
        }

        blob.delete();
    }

    String generateFileName(String originalFileName, String folder) {
        String uuidFile = UUID.randomUUID().toString();
        return folder + "/" + uuidFile + "." + originalFileName;
    }

    private InputStream createFirebaseCredential() throws Exception {
        FirebaseCredential firebaseCredential = new FirebaseCredential();

        String privateKey = environment.getRequiredProperty("FIREBASE_PRIVATE_KEY").replace("\\n", "\n");

        firebaseCredential.setType(environment.getRequiredProperty("FIREBASE_TYPE"));
        firebaseCredential.setProject_id(environment.getRequiredProperty("FIREBASE_PROJECT_ID"));
        firebaseCredential.setPrivate_key_id("FIREBASE_PRIVATE_KEY_ID");
        firebaseCredential.setPrivate_key(privateKey);
        firebaseCredential.setClient_email(environment.getRequiredProperty("FIREBASE_CLIENT_EMAIL"));
        firebaseCredential.setClient_id(environment.getRequiredProperty("FIREBASE_CLIENT_ID"));
        firebaseCredential.setAuth_uri(environment.getRequiredProperty("FIREBASE_AUTH_URI"));
        firebaseCredential.setToken_uri(environment.getRequiredProperty("FIREBASE_TOKEN_URI"));
        firebaseCredential.setAuth_provider_x509_cert_url(environment.getRequiredProperty("FIREBASE_AUTH_PROVIDER_X509_CERT_URL"));
        firebaseCredential.setClient_x509_cert_url(environment.getRequiredProperty("FIREBASE_CLIENT_X509_CERT_URL"));

        ObjectMapper mapper = new ObjectMapper();
        String jsonString = mapper.writeValueAsString(firebaseCredential);

        return IOUtils.toInputStream(jsonString);
    }


    @Data
    @Configuration
    @ConfigurationProperties(prefix = "firebase")
    public static class Properties {
        private String bucketName;
        private String imageUrl;
    }
}
