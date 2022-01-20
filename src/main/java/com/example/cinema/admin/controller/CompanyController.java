package com.example.cinema.admin.controller;

import com.example.cinema.admin.model.Company;
import com.example.cinema.admin.service.CompanyService;
import com.example.cinema.utils.ControllerUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.Map;

@RequestMapping("/admin")
@Controller
public class CompanyController {
    @Autowired
    private CompanyService companyService;

    @GetMapping("/companies")
    public String companyList(Model model, @RequestParam(required = false, defaultValue = "") String search,
                              @PageableDefault(sort = { "name" }, size = 30, direction = Sort.Direction.ASC) Pageable pageable){
        var companies = companyService.findAll(search, pageable);

        if(pageable.getPageNumber() < 0 || pageable.getPageNumber() > companies.getTotalPages())
            return "admin/company/list";

        model.addAttribute("title", "companies");
        model.addAttribute("url", "/admin/companies");
        model.addAttribute("page", companies);
        model.addAttribute("total", companyService.companyList().size());
        model.addAttribute("size", companies.getTotalElements());

        if (!search.equals("")) {
            model.addAttribute("search", search);
        }

        return "admin/company/list";
    }

    @GetMapping("/company/create")
    public String companyCreate(Model model){
        return "admin/company/form";
    }

    @PostMapping("/company/create")
    public String companyCreate(@Valid Company company, BindingResult bindingResult, Model model){
        if(bindingResult.hasErrors()){
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "admin/company/form";
        }

        try {
            companyService.createCompany(company);
        }
        catch (Exception ex){
            model.addAttribute("nameError", ex.getMessage());
            return "admin/company/form";
        }

        return "redirect:/admin/companies";
    }

    @GetMapping("/company/{id}/edit")
    public String companyCreate(@PathVariable Long id, Model model, RedirectAttributes redirect){
        Company company = companyService.getCompanyById(id);

        if(company == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Company not found");
            return "redirect:/admin/companies";
        }

        model.addAttribute("company", company);

        return "admin/company/form";
    }

    @PostMapping("/company/{id}/edit")
    public String companyEdit(@PathVariable Long id, @Valid Company company,
                                BindingResult bindingResult, Model model, RedirectAttributes redirect){
        Company editCompany = companyService.getCompanyById(id);

        if(editCompany == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Company not found");
            return "redirect:/admin/companies";
        }

        if(bindingResult.hasErrors()){
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            model.addAttribute("company", company);

            return "admin/company/form";
        }

        try {
            companyService.editCompany(company, editCompany);
        }
        catch (Exception ex){
            model.addAttribute("nameError", ex.getMessage());
            model.addAttribute("company", company);

            return "admin/company/form";
        }

        return "redirect:/admin/companies";
    }

    @PostMapping("/company/{id}/delete")
    public String companyDelete(@PathVariable Long id, RedirectAttributes redirect){
        Company company = companyService.getCompanyById(id);

        if(company == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Company not found");
            return "redirect:/admin/companies";
        }

        companyService.deleteCompany(company);
        redirect.addFlashAttribute("messageType", "success");
        redirect.addFlashAttribute("message", "Company was successfully delete");

        return "redirect:/admin/companies";
    }
}
