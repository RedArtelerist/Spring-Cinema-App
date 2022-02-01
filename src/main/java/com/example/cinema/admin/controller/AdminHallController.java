package com.example.cinema.admin.controller;

import com.example.cinema.cinema.model.Hall;
import com.example.cinema.cinema.model.Row;
import com.example.cinema.cinema.model.Type;
import com.example.cinema.cinema.service.HallService;
import com.example.cinema.cinema.service.RowService;
import com.example.cinema.utils.ControllerUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.Map;

@RequestMapping("/admin")
@Controller
public class AdminHallController {
    @Autowired
    private HallService hallService;

    @Autowired
    private RowService rowService;

    @GetMapping("/hall/{id}")
    public String detail(@PathVariable Long id, Model model, RedirectAttributes redirect){
        Hall hall = hallService.getById(id);

        if(hall == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Hall not found");

            return "redirect:/admin/cinemas";
        }
        model.addAttribute("hall", hall);
        model.addAttribute("rows", rowService.findByHall(hall));
        model.addAttribute("types", Type.values());

        return "admin/cinema/hall";
    }

    @PostMapping("/hall/{hallId}")
    public String addRow(@PathVariable("hallId") Long hallId, @Valid Row row, BindingResult bindingResult,
                         Model model, RedirectAttributes redirect){
        Hall hall = hallService.getById(hallId);

        if(hall == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Hall not found");

            return "redirect:/admin/cinemas";
        }

        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("hall", hall);
            model.addAttribute("rows", rowService.findByHall(hall));
            model.addAttribute("row", row);
            model.addAttribute("types", Type.values());

            return "admin/cinema/hall";
        }

        row.setHall(hall);

        if(row.getId() != null){
            Row editRow = rowService.findById(row.getId());

            if(editRow == null)
                return "redirect:/admin/hall/" + hall.getId();

            if(!editRow.getName().equals(row.getName()) && rowService.getIfExist(row) != null){
                model.addAttribute("nameError", "Duplicate row");
                model.addAttribute("hall", hall);
                model.addAttribute("rows", rowService.findByHall(hall));
                model.addAttribute("row", row);
                model.addAttribute("types", Type.values());

                return "admin/cinema/hall";
            }

            try {
                rowService.updateRow(editRow, row);
                return "redirect:/admin/hall/" + hall.getId();
            }
            catch (Exception ex){
                model.addAttribute("numSeatsError", ex.getMessage());
                model.addAttribute("hall", hall);
                model.addAttribute("rows", rowService.findByHall(hall));
                model.addAttribute("row", row);
                model.addAttribute("types", Type.values());

                return "admin/cinema/hall";
            }

        } else {

            if (rowService.getIfExist(row) != null) {
                model.addAttribute("nameError", "Duplicate row");
                model.addAttribute("hall", hall);
                model.addAttribute("rows", rowService.findByHall(hall));
                model.addAttribute("row", row);
                model.addAttribute("types", Type.values());

                return "admin/cinema/hall";
            }

            try {
                rowService.saveRow(row);
                return "redirect:/admin/hall/" + hall.getId();
            } catch (Exception ex) {
                model.addAttribute("numSeatsError", ex.getMessage());
                model.addAttribute("hall", hall);
                model.addAttribute("rows", rowService.findByHall(hall));
                model.addAttribute("row", row);
                model.addAttribute("types", Type.values());

                return "admin/cinema/hall";
            }
        }
    }

    @PostMapping("/row/{rowId}/delete")
    public String deleteRow(@PathVariable("rowId") Long rowId, RedirectAttributes redirect){
        Row row = rowService.findById(rowId);

        if(row == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Row not found");

            return "redirect:/admin/cinemas";
        }

        rowService.deleteRow(row);

        return "redirect:/admin/hall/" + row.getHall().getId();
    }
}
