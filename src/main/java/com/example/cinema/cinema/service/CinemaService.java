package com.example.cinema.cinema.service;

import com.example.cinema.admin.service.FirebaseImageService;
import com.example.cinema.cinema.model.Cinema;
import com.example.cinema.cinema.model.City;
import com.example.cinema.cinema.model.ImageCinema;
import com.example.cinema.cinema.repository.CinemaRepository;
import com.example.cinema.cinema.repository.ImageCinemaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@Service
public class CinemaService {
    @Autowired
    private CinemaRepository cinemaRepository;

    @Autowired
    private ImageCinemaRepository imageCinemaRepository;

    @Autowired
    private FirebaseImageService firebaseImageService;

    public List<Cinema> cinemaList() {
        return cinemaRepository.findAll(Sort.by(Sort.Direction.ASC, "name"));
    }

    public Page<Cinema> findForAdmin(String sort, String search, int pageNum) {
        Sort sorting = Sort.by(Sort.Direction.ASC, "name");
        if(sort.equals("rating"))
            sorting = Sort.by(Sort.Direction.DESC, "rating");

        Pageable pageable = PageRequest.of(pageNum, 20, sorting);
        return cinemaRepository.findCinemasForAdmin(search.toLowerCase(), pageable);
    }

    public List<Cinema> getCinemas(String sort, String search, String city){
        Sort sorting = Sort.by(Sort.Direction.ASC, "name");

        if(sort.equals("rating"))
            sorting = Sort.by(Sort.Direction.DESC, "rating");

        List<Cinema> cinemas;
        try {
            cinemas = cinemaRepository.findByCity(City.valueOf(city), search, sorting);
        }
        catch (Exception ex){
            cinemas = cinemaRepository.findAll(search, sorting);
        }
        return cinemas;
    }

    public Cinema getById(Long id){
        Optional<Cinema> cinemaOptional = cinemaRepository.findById(id);
        return cinemaOptional.orElse(null);
    }

    public Cinema findById(Long id){
        Optional<Cinema> cinemaOptional = cinemaRepository.findActiveById(id);
        return cinemaOptional.orElse(null);
    }

    public void createCinema(Cinema cinema, MultipartFile image, MultipartFile[] gallery) throws IOException {
        if(image != null && !image.getOriginalFilename().isEmpty()) {
            String name = firebaseImageService.save(image, "cinemas");
            String imageUrl = firebaseImageService.getImageUrl(name);
            cinema.setImageName(name);
            cinema.setImageUrl(imageUrl);
        }

        if(gallery.length > 0){
            setGallery(gallery, cinema);
        }

        cinemaRepository.save(cinema);
    }

    public void editCinema(Cinema cinema, Cinema editCinema, MultipartFile image, MultipartFile[] gallery) throws IOException {
        editCinema.setName(cinema.getName());
        editCinema.setCity(cinema.getCity());
        editCinema.setAddress(cinema.getAddress());
        editCinema.setPhone(cinema.getPhone());
        editCinema.setRating(cinema.getRating());
        editCinema.setActive(cinema.isActive());
        editCinema.setLatitude(cinema.getLatitude());
        editCinema.setLongitude(cinema.getLongitude());

        if(image != null && !image.getOriginalFilename().isEmpty()) {
            if(editCinema.getImageName() != null && !editCinema.getImageName().isEmpty())
                firebaseImageService.delete(editCinema.getImageName());

            String name = firebaseImageService.save(image, "cinemas");
            String imageUrl = firebaseImageService.getImageUrl(name);
            editCinema.setImageName(name);
            editCinema.setImageUrl(imageUrl);
        }

        if(gallery.length > 0){
            setGallery(gallery, editCinema);
        }

        cinemaRepository.save(editCinema);
    }

    public void deleteCinema(Cinema cinema) throws IOException {
        if(cinema.getImageName() != null)
            firebaseImageService.delete(cinema.getImageName());

        deleteGallery(cinema);

        cinemaRepository.delete(cinema);
    }

    private void setGallery(MultipartFile[] gallery, Cinema cinema) throws IOException {
        for(var item : gallery){
            if(item != null && !item.getOriginalFilename().isEmpty()) {
                ImageCinema img = new ImageCinema();
                String name = firebaseImageService.save(item, "cinemas");
                String url = firebaseImageService.getImageUrl(name);
                img.setImageName(name);
                img.setImageUrl(url);
                img.setCinema(cinema);
                cinema.getGallery().add(img);
            }
        }
    }

    public ImageCinema getImageById(Long id){
        Optional<ImageCinema> imageCinemaOptional = imageCinemaRepository.findById(id);
        return imageCinemaOptional.orElse(null);
    }

    public void deleteImage(Cinema cinema, ImageCinema image) throws IOException {
        if(cinema.getGallery().contains(image)) {
            firebaseImageService.delete(image.getImageName());
            cinema.getGallery().remove(image);
            imageCinemaRepository.delete(image);
        }
        cinemaRepository.save(cinema);
    }

    public void deleteGallery(Cinema cinema) throws IOException {
        for(var image : cinema.getGallery()) {
            firebaseImageService.delete(image.getImageName());
            imageCinemaRepository.delete(image);
        }
    }
}
