Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDC642D316
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 08:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhJNHAA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 03:00:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26242 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229949AbhJNG77 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Oct 2021 02:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634194674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=brR+Nu52gz51xmOIV3uiryZgXbmWSUKhM3aMVpybh7g=;
        b=S++LKLLiL+eJhkD0hJiawOrYKRoB7J4kN25m+TfYcqPhi63biAAlpXQvWCKOM/FNMTBxG8
        Lp5FUP1OQmlcQoqGmtKW/Mf5t+MthC6g1x6LG5o3gcqK6G5gfPmNZNTDsdbfXbabp56WFD
        8R5zXb95g/QhfdiIn92ValDrd4ayyzM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-5BCsTRHxOBWzU_hkk09NBg-1; Thu, 14 Oct 2021 02:57:53 -0400
X-MC-Unique: 5BCsTRHxOBWzU_hkk09NBg-1
Received: by mail-ed1-f70.google.com with SMTP id x5-20020a50f185000000b003db0f796903so4329427edl.18
        for <linux-arch@vger.kernel.org>; Wed, 13 Oct 2021 23:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=brR+Nu52gz51xmOIV3uiryZgXbmWSUKhM3aMVpybh7g=;
        b=xxeuq8xsVLwb94HFV3FOFM36GqtqUkrcJk23oJ7+3pgSWjfoOvGNJLtZwnIkxguPYm
         +hBNSefkqx97FLYpesLddmvvs4T3J17cwxtnAmI6VIEZyN1ucrPMykvgm4zyZk5QR+ph
         O8bddAR31lqYjiWCzH/x8Vaz+cfu925yeWXZZ8o0URKKVa7SOumrLlAvPKC1xanPpTUC
         g0CeLCjorK7vTZlFYA9ptKpnbMRZMtOwTCFY/cjRolsskpE8ZmhNdFPZ5htt1QCqb8aQ
         CRW8hn+R56TQuhgG4154Q0Rkzf9zo369pJ5z/6LR68+C1ameSfFW+7j+str2fwgAgw27
         PnnQ==
X-Gm-Message-State: AOAM532u0lFGm5zqCjGmbNS9j4jz8qCDW1Z+jjqZgg/wxTXRCJXy4qDS
        7RZYiR5HG6RBZ0nW/ThN3Qe0HLtSBSeKB7hfCVe3Bnz0W7q2MCmXPgkWtq+aUkcWf5srz6+1B89
        ay7RZrCuE6XaewWRxqxCrrw==
X-Received: by 2002:a05:6402:1914:: with SMTP id e20mr6174248edz.304.1634194671789;
        Wed, 13 Oct 2021 23:57:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdhRhC66j5h6JfIv4gT4rh08QxWtQdl3riq/bWkvwrpI8BhldDFz+YLp7cxUAacziNZLOOyw==
X-Received: by 2002:a05:6402:1914:: with SMTP id e20mr6174217edz.304.1634194671479;
        Wed, 13 Oct 2021 23:57:51 -0700 (PDT)
Received: from redhat.com ([2.55.16.227])
        by smtp.gmail.com with ESMTPSA id eg42sm1358355edb.61.2021.10.13.23.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 23:57:50 -0700 (PDT)
Date:   Thu, 14 Oct 2021 02:57:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter H Anvin <hpa@zytor.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
Message-ID: <20211014025514-mutt-send-email-mst@kernel.org>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
 <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
 <DM8PR11MB57501C8F8F5C8B315726882EE7B69@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20211012171016-mutt-send-email-mst@kernel.org>
 <DM8PR11MB5750A40FAA6AFF6A29CF70DAE7B89@DM8PR11MB5750.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5750A40FAA6AFF6A29CF70DAE7B89@DM8PR11MB5750.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 14, 2021 at 06:32:32AM +0000, Reshetova, Elena wrote:
> > On Tue, Oct 12, 2021 at 06:36:16PM +0000, Reshetova, Elena wrote:
> > > > The 5.15 tree has something like ~2.4k IO accesses (including MMIO and
> > > > others) in init functions that also register drivers (thanks Elena for
> > > > the number)
> > >
> > > To provide more numbers on this. What I can see so far from a smatch-based
> > > analysis, we have 409 __init style functions (.probe & builtin/module_
> > > _platform_driver_probe excluded) for 5.15 with allyesconfig.
> > 
> > I don't think we care about allyesconfig at all though.
> > Just don't do that.
> > How about allmodconfig? This is closer to what distros actually do.
> 
> It does not make any difference really for the content of the /drivers/*:
> gives 408 __init style functions doing IO (.probe & builtin/module_
> > > _platform_driver_probe excluded) for 5.15 with allmodconfig:
> 
> ['doc200x_ident_chip',
> 'doc_probe', 'doc2001_init', 'mtd_speedtest_init',
> 'mtd_nandbiterrs_init', 'mtd_oobtest_init', 'mtd_pagetest_init',
> 'tort_init', 'mtd_subpagetest_init', 'fixup_pmc551',
> 'doc_set_driver_info', 'init_amd76xrom', 'init_l440gx',
> 'init_sc520cdp', 'init_ichxrom', 'init_ck804xrom', 'init_esb2rom',
> 'probe_acpi_namespace_devices', 'amd_iommu_init_pci', 'state_next',
> 'arm_v7s_do_selftests', 'arm_lpae_run_tests', 'init_iommu_one',

Um. ARM? Which architecture is this build for?


> 'init_dmars', 'iommu_init_pci', 'early_amd_iommu_init',
> 'late_iommu_features_init', 'detect_ivrs',
> 'intel_prepare_irq_remapping', 'intel_enable_irq_remapping',
> 'intel_cleanup_irq_remapping', 'detect_intel_iommu',
> 'parse_ioapics_under_ir', 'si_domain_init', 'ubi_init',
> 'fb_console_init', 'xenbus_probe_backend_init',
> 'xenbus_probe_frontend_init', 'setup_vcpu_hotplug_event',
> 'balloon_init', 'intel_iommu_init', 'intel_rng_mod_init',
> 'check_tylersburg_isoch', 'dmar_table_init',
> 'enable_drhd_fault_handling', 'init_acpi_pm_clocksource',
> 'ostm_init_clksrc', 'ftm_clockevent_init', 'ftm_clocksource_init',
> 'kona_timer_init', 'mtk_gpt_init', 'samsung_clockevent_init',
> 'samsung_clocksource_init', 'sysctr_timer_init', 'mxs_timer_init',
> 'sun4i_timer_init', 'at91sam926x_pit_dt_init', 'owl_timer_init',
> 'sun5i_setup_clockevent', 'ubi_gluebi_init', 'ubiblock_init',
> 'hv_init_tsc_clocksource', 'hv_init_clocksource', 'mt7621_clk_init',
> 'samsung_clk_register_mux', 'samsung_clk_register_gate',
> 'samsung_clk_register_fixed_rate', 'clk_boston_setup',
> 'gemini_cc_init', 'aspeed_ast2400_cc', 'aspeed_ast2500_cc',
> 'sun6i_rtc_clk_init', 'phy_init', 'ingenic_ost_register_clock',
> 'meson6_timer_init', 'atcpit100_timer_init',
> 'npcm7xx_clocksource_init', 'clksrc_dbx500_prcmu_init', 'skx_init',
> 'i10nm_init', 'sbridge_init', 'i82975x_init', 'i3000_init',
> 'x38_init', 'ie31200_init', 'i3200_init', 'amd64_edac_init',
> 'pnd2_init', 'edac_init', 'adummy_init', 'mtd_stresstest_init',
> 'bxt_idle_state_table_update', 'sklh_idle_state_table_update',
> 'skx_idle_state_table_update',
> 'acpi_gpio_handle_deferred_request_irqs', 'smc_findirq', 'ltpc_probe',
> 'com90io_probe', 'com90xx_probe', 'pcnet32_init_module',
> 'it87_gpio_init', 'f7188x_find', 'it8712f_wdt_find', 'f71808e_find',
> 'it87_wdt_init', 'f71882fg_find', 'it87_find', 'f71805f_find',
> 'parport_pc_init', 'asic3_irq_probe', 'sch311x_detect',
> 'amd_gpio_init', 'dvb_init', 'dvb_register', 'em28xx_alsa_register',
> 'em28xx_dvb_register', 'em28xx_rc_register', 'em28xx_video_register',
> 'blackbird_init', 'bttv_check_chipset', 'ivtvfb_callback_init',
> 'init_control', 'con_init', 'cr_pll_init',
> 'clk_disable_unused_subtree', 'fmi_init', 'cadet_init', 'pcm20_init',
> 'airo_init_module', 'bnx2i_mod_init', 'bnx2fc_mod_init',
> 'timer_of_irq_exit', 'init', 'kempld_init', 'ivtvfb_init',
> 'brcmf_core_init', 'comedi_test_init', 'tlan_eisa_probe',
> 'timer_probe', 'of_clk_init', '__reserved_mem_init_node',
> 'of_irq_init', 'mace_init', 'vortex_eisa_init', 'reset_chip',
> 'atp_init', 'atp_probe1', 'smc_probe', 'osi_setup', 'led_init',
> 'el3_init_module', 'clk_sp810_of_setup', 'ltpc_probe_dma',
> 'com90io_found', 'check_mirror', 'arcrimi_found', 'com90xx_found',
> 'intel_soc_thermal_init', 'thermal_register_governors',
> 'thermal_unregister_governors', 'therm_lvt_init', 'tcc_cooling_init',
> 'powerclamp_probe', 'intel_init', 'qcom_geni_serial_earlycon_setup',
> 'kgdboc_early_init', 'lpuart_console_setup', 'speakup_init',
> 'early_console_setup', 'init_port', 'early_serial8250_setup',
> 'linflex_console_setup', 'register_earlycon', 'of_setup_earlycon',
> 'slgt_init', 'moxa_init', 'parport_pc_init_superio',
> 'parport_pc_find_ports', 'mousedev_init', 'ses_init', 'riocm_init',
> 'efi_rci2_sysfs_init', 'blogic_probe', 'blogic_init',
> 'blogic_init_mm_probeinfo', 'blogic_init_probeinfo_list',
> 'blogic_checkadapter', 'blogic_rdconfig', 'blogic_inquiry',
> 'adpt_init', 'clk_unprepare_unused_subtree', 'aspeed_socinfo_init',
> 'rcar_sysc_pd_setup', 'r8a779a0_sysc_pd_setup', 'renesas_soc_init',
> 'rcar_rst_init', 'rmobile_setup_pm_domain', 'mcp_write_pairing_set',
> 'a72_b53_rac_enable_all', 'mcp_a72_b53_set',
> 'brcmstb_soc_device_early_init', 'imx8mq_soc_revision',
> 'imx8mm_soc_uid', 'imx8mm_soc_revision', 'qe_init',
> 'exynos5x_clk_init', 'exynos5250_clk_init', 'exynos4_get_xom',
> 'create_one_cmux', 'create_one_pll', 'p2041_init_periph',
> 'p4080_init_periph', 'p5020_init_periph', 'p5040_init_periph',
> 'r9a06g032_clocks_probe', 'r8a73a4_cpg_clocks_init',
> 'sh73a0_cpg_clocks_init', 'cpg_div6_register',
> 'r8a7740_cpg_clocks_init', 'cpg_mssr_register_mod_clk',
> 'cpg_mssr_register_core_clk', 'rcar_gen3_cpg_clk_register',
> 'cpg_sd_clk_register', 'r7s9210_update_clk_table',
> 'rz_cpg_read_mode_pins', 'rz_cpg_clocks_init',
> 'rcar_r8a779a0_cpg_clk_register', 'rcar_gen2_cpg_clk_register',
> 'sun8i_a33_ccu_setup', 'sun8i_a23_ccu_setup', 'sun5i_ccu_init',
> 'suniv_f1c100s_ccu_setup', 'sun6i_a31_ccu_setup',
> 'sun8i_v3_v3s_ccu_init', 'sun50i_h616_ccu_setup',
> 'sunxi_h3_h5_ccu_init', 'sun4i_ccu_init', 'kona_ccu_init',
> 'ns2_genpll_scr_clk_init', 'ns2_genpll_sw_clk_init',
> 'ns2_lcpll_ddr_clk_init', 'ns2_lcpll_ports_clk_init',
> 'nsp_genpll_clk_init', 'nsp_lcpll0_clk_init',
> 'cygnus_genpll_clk_init', 'cygnus_lcpll0_clk_init',
> 'cygnus_mipipll_clk_init', 'cygnus_audiopll_clk_init',
> 'of_fixed_mmio_clk_setup', 'xdbc_map_pci_mmio', 'xdbc_find_dbgp',
> 'xdbc_bios_handoff', 'xdbc_early_setup', 'ehci_setup',
> 'early_xdbc_parse_parameter', 'find_cap', '__find_dbgp',
> 'nvidia_set_debug_port', 'detect_set_debug_port',
> 'early_ehci_bios_handoff', 'early_dbgp_init', 'dbgp_init',
> 'ulpi_init', 'hidg_init', 'xdbc_init', 'brcmstb_usb_pinmap_probe',
> 'dell_init', 'eisa_init_device', 'mlxcpld_led_probe', 'nas_gpio_init',
> 'asic3_mfd_probe', 'asic3_probe', 'watchdog_init', 'ssb_modinit',
> 'pt_init', 'thinkpad_acpi_module_init', 'kbd_init', 'joydev_init',
> 'evdev_init', 'evbug_init', 'input_leds_init', 'mk712_init',
> 'l4_add_card', 'ns558_init', 'apanel_init', 'ct82c710_detect',
> 'i8042_check_aux', 'i8042_check_mux', 'i8042_probe', 'i8042_init',
> 'i8042_aux_test_irq', 'ocrdma_init_module', 'input_apanel_init',
> 'cs5535_mfgpt_init', 'geodewdt_probe', 'duramar2150_c2port_init',
> 'init_ohci1394_dma_on_all_controllers', 'init_ohci1394_controller',
> 'rionet_init', 'nonstatic_sysfs_init', 'init_pcmcia_bus',
> 'devlink_class_init', 'switchtec_ntb_init', 'mport_init',
> 'drivetemp_init', 'omap_vout_probe', 'probe_opti_vlb',
> 'probe_chip_type', 'legacy_check_special_cases',
> 'qdi65_identify_port', 'probe_qdi_vlb', 'comedi_init', 'hv_acpi_init',
> 'pcistub_init_devices_late', 'bcma_host_soc_register',
> 'bcma_bus_early_register', 'vga_arb_device_init',
> 'vga_arb_select_default_device', 'zf_init',
> 'watchdog_deferred_registration', 'wb_smsc_wdt_init',
> 'w83977f_wdt_init', 'ali_find_watchdog', 'pc87413_init',
> 'alim7101_wdt_init', 'at91_wdt_init', 'sc1200wdt_probe',
> 'asr_get_base_address', 'dmi_walk_early', 'dmi_sysfs_init',
> 'dell_smbios_init', 'acer_wmi_init', 'get_thinkpad_model_data',
> 'dmi_scan_machine', 'pci_assign_unassigned_resources',
> 'cpcihp_generic_init', 'pnpacpi_init', 'acpi_early_processor_osc',
> 'acpi_processor_check_duplicates', 'acpi_early_processor_set_pdc',
> 'acpi_ec_dsdt_probe', 'cros_ec_lpc_init', 'tpacpi_acpi_handle_locate',
> 'ks_pcie_init_id', 'ks_pcie_host_init', 'pci_apply_final_quirks',
> 'intel_uncore_init', 'qedr_init_module', 'isapnp_peek',
> 'isapnp_isolate', 'init_ipmi_si', 'isapnp_build_device_list',
> 'pnpacpi_add_device', 'erst_init', 'intel_idle_acpi_cst_extract',
> 'xen_acpi_processor_init', 'acpi_scan_init', 's3_wmi_probe',
> 'intel_opregion_present', 'extlog_init', 'intel_pstate_init',
> 'via_rng_mod_init', 'amd_rng_mod_init', 'ccp_init', 'init_nsc',
> 'init_atmel', 'intel_rng_hw_init', 'intel_init_hw_struct',
> 'tlclk_init', 'mwave_init', 'applicom_init', 'hdaps_init',
> 'tink_board_init', 'ibm_rtl_init', 'samsung_sabi_init',
> 'samsung_init', 'samsung_backlight_init', 'samsung_rfkill_init_swsmi',
> 'samsung_lid_handling_init', 'samsung_leds_init', 'samsung_sabi_diag',
> 'samsung_sabi_infos', 'isst_if_mbox_init', 'pmc_atom_init',
> 'abituguru_detect', 'hwmon_pci_quirks', 'applesmc_init',
> 'abituguru3_detect', 'w83627ehf_probe', 'dme1737_isa_detect',
> 'smsc47m1_probe', 'pcc_cpufreq_init', 'cpufreq_p4_init',
> 'centrino_init', 'acpi_cpufreq_init', 'pcc_cpufreq_probe',
> 'intel_pstate_msrs_not_valid',
> 'intel_pstate_platform_pwr_mgmt_exists', 'acpi_cpufreq_boost_init',
> 'amd_freq_sensitivity_init', 'gic_fixup_resource', 'do_floppy_init',
> 'get_fdc_version', 'pf_init', 'pg_init', 'pd_init', 'pcd_init',
> 'rio_basic_attach']

