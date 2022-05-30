package com.example.cinema.main.service;

import com.example.cinema.main.model.ContactUsMessage;
import com.example.cinema.main.repository.ContactUsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ContactUsService {
    @Autowired
    private ContactUsRepository contactUsRepository;

    public Page<ContactUsMessage> findAll(int pageNum){
        Pageable pageable = PageRequest.of(pageNum,40,
                Sort.by(Sort.Direction.DESC, "createdAt")
        );

        return contactUsRepository.findAll(pageable);
    }

    public List<ContactUsMessage> messageList(){
        return contactUsRepository.findAll();
    }

    public ContactUsMessage getById(Long id){
        Optional<ContactUsMessage> messageOptional = contactUsRepository.findById(id);
        return messageOptional.orElse(null);
    }

    public void saveMessage(ContactUsMessage message){
        contactUsRepository.save(message);
    }

    public void deleteMessage(ContactUsMessage message){
        contactUsRepository.delete(message);
    }
}
