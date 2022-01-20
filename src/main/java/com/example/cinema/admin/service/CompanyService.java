package com.example.cinema.admin.service;

import com.example.cinema.admin.model.Company;
import com.example.cinema.admin.repository.CompanyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CompanyService {
    @Autowired
    private CompanyRepository companyRepository;


    public List<Company> companyList(){
        return companyRepository.findAll(Sort.by(Sort.Direction.ASC, "name"));
    }

    public Page<Company> findAll(String search, Pageable pageable){
        return companyRepository.findAll(search.toLowerCase(), pageable);
    }

    public Company getCompanyById(Long id){
        Optional<Company> optionalCompany = companyRepository.findById(id);
        return optionalCompany.orElse(null);
    }

    public Company getCompanyByName(String name){
        Optional<Company> optionalCompany = companyRepository.findByName(name);
        return optionalCompany.orElse(null);
    }

    public void createCompany(Company company) throws Exception {
        Company dbCompany = getCompanyByName(company.getName());

        if(dbCompany != null){
            throw new Exception("Company with this name already exist");
        }

        companyRepository.save(company);
    }

    public void editCompany(Company company, Company editCompany) throws Exception {
        if(!company.getName().equals(editCompany.getName())) {
            Company dbCompany = getCompanyByName(company.getName());

            if (dbCompany != null) {
                throw new Exception("Company with this name already exist");
            }
        }

        editCompany.setName(company.getName());
        companyRepository.save(editCompany);
    }

    public void deleteCompany(Company company){
        for(var movie : company.getMovies()){
            movie.getCompanies().remove(company);
        }
        companyRepository.delete(company);
    }
}
