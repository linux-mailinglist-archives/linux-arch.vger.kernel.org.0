Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A66430C76
	for <lists+linux-arch@lfdr.de>; Sun, 17 Oct 2021 23:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344723AbhJQVy4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Oct 2021 17:54:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34386 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344711AbhJQVyz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 17 Oct 2021 17:54:55 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634507563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oGU3VBFl0sKrIgl1Sc1KV2BejTNdxNtrrFpg1XupE2M=;
        b=yl9xf3xmBTcy8CntNVG9VTuO+qujh9LZoB7T+Dme/8RtXoXWn2QnzfLNR49/6XAkEnpoQ6
        Lz4FcUJ9Ft/N3B9jNJAQFFhI6cbNDF1n6F2XbAp3nAcygHQ2Q6xyFf7Rs2gZPVtHmXGRYN
        8NF156ek/+bE6ZMROSSN3OgSrwqU1jgLq+b6im1TqoeeGHQSbhasNbBbsT9wlX91aA2wPw
        sOMwD8MskfBr3xiOh4eq2ZJxPcTx/rltPQWXn+VKRPWhEW3uqFdAmZVFj1RIfLSHupUWHz
        esKZ5lO67iSdD/vi7W4r6XMAsUP8VdC9V0tFEV6cdkpIKLnay2qZ4owOPYrumA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634507563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oGU3VBFl0sKrIgl1Sc1KV2BejTNdxNtrrFpg1XupE2M=;
        b=Ebc3IFcDLDCuDjgBjix7OrByUokRy8JGJRwUf6TZQSWlNc6v5TLbtSTC1xpxNb4mLZlG5v
        nyEapizKizRJRiAw==
To:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
Subject: RE: [PATCH v5 12/16] PCI: Add pci_iomap_host_shared(),
 pci_iomap_host_shared_range()
In-Reply-To: <DM8PR11MB5750A40FAA6AFF6A29CF70DAE7B89@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-13-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053103-mutt-send-email-mst@kernel.org>
 <CAPcyv4hDhjRXYCX_aiOboLF0eaTo6VySbZDa5NQu2ed9Ty2Ekw@mail.gmail.com>
 <0e6664ac-cbb2-96ff-0106-9301735c0836@linux.intel.com>
 <DM8PR11MB57501C8F8F5C8B315726882EE7B69@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20211012171016-mutt-send-email-mst@kernel.org>
 <DM8PR11MB5750A40FAA6AFF6A29CF70DAE7B89@DM8PR11MB5750.namprd11.prod.outlook.com>
Date:   Sun, 17 Oct 2021 23:52:42 +0200
Message-ID: <87r1cj2uad.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Elena,

On Thu, Oct 14 2021 at 06:32, Elena Reshetova wrote:
>> On Tue, Oct 12, 2021 at 06:36:16PM +0000, Reshetova, Elena wrote:
> It does not make any difference really for the content of the /drivers/*:
> gives 408 __init style functions doing IO (.probe & builtin/module_
>> > _platform_driver_probe excluded) for 5.15 with allmodconfig:
>
> ['doc200x_ident_chip',
> 'doc_probe', 'doc2001_init', 'mtd_speedtest_init',
> 'mtd_nandbiterrs_init', 'mtd_oobtest_init', 'mtd_pagetest_init',
> 'tort_init', 'mtd_subpagetest_init', 'fixup_pmc551',
> 'doc_set_driver_info', 'init_amd76xrom', 'init_l440gx',
> 'init_sc520cdp', 'init_ichxrom', 'init_ck804xrom', 'init_esb2rom',
> 'ubi_gluebi_init', 'ubiblock_init'
> 'ubi_init', 'mtd_stresstest_init',

All of this is MTD and can just be disabled wholesale.

Aside of that, most of these depend on either platform devices or device
tree enumerations which are not ever available on X86.

> 'probe_acpi_namespace_devices',

> 'amd_iommu_init_pci', 'state_next',
> 'init_dmars', 'iommu_init_pci', 'early_amd_iommu_init',
> 'late_iommu_features_init', 'detect_ivrs',
> 'intel_prepare_irq_remapping', 'intel_enable_irq_remapping',
> 'intel_cleanup_irq_remapping', 'detect_intel_iommu',
> 'parse_ioapics_under_ir', 'si_domain_init',
> 'intel_iommu_init', 'dmar_table_init',
> 'enable_drhd_fault_handling',
> 'check_tylersburg_isoch', 

None of this is reachable because the initial detection which is ACPI
table based will fail for TDX. If not, it's a guest firmware problem.

> 'fb_console_init', 'xenbus_probe_backend_init',
> 'xenbus_probe_frontend_init', 'setup_vcpu_hotplug_event',
> 'balloon_init',

XEN, that's relevant because magically the TDX guest will assume that it
is a XEN instance?

> 'ostm_init_clksrc', 'ftm_clockevent_init', 'ftm_clocksource_init',
> 'kona_timer_init', 'mtk_gpt_init', 'samsung_clockevent_init',
> 'samsung_clocksource_init', 'sysctr_timer_init', 'mxs_timer_init',
> 'sun4i_timer_init', 'at91sam926x_pit_dt_init', 'owl_timer_init',
> 'sun5i_setup_clockevent',
> 'mt7621_clk_init',
> 'samsung_clk_register_mux', 'samsung_clk_register_gate',
> 'samsung_clk_register_fixed_rate', 'clk_boston_setup',
> 'gemini_cc_init', 'aspeed_ast2400_cc', 'aspeed_ast2500_cc',
> 'sun6i_rtc_clk_init', 'phy_init', 'ingenic_ost_register_clock',
> 'meson6_timer_init', 'atcpit100_timer_init',
> 'npcm7xx_clocksource_init', 'clksrc_dbx500_prcmu_init',
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
> 'of_fixed_mmio_clk_setup',
> 'arm_v7s_do_selftests', 'arm_lpae_run_tests', 'init_iommu_one',

ARM based drivers are initialized on x86 in which way?

> 'hv_init_tsc_clocksource', 'hv_init_clocksource',

HyperV. See XEN

> 'skx_init',
> 'i10nm_init', 'sbridge_init', 'i82975x_init', 'i3000_init',
> 'x38_init', 'ie31200_init', 'i3200_init', 'amd64_edac_init',
> 'pnd2_init', 'edac_init', 'adummy_init',

EDAC has already hypervisor checks

> 'init_acpi_pm_clocksource',

Requires ACPI table entry or command line override

> 'intel_rng_mod_init',

Has an old style PCI table which is searched via pci_get_device(). Could
do with a cleanup which converts it to proper PCI probing.

<SNIP>

So I stop here, because it would be way simpler to have the file names
but so far I could identify all of it from the top of my head.

So what are you trying to tell me? That you found tons of ioremaps in
__init functions which are completely irrelevant.

Please stop making arguments based on completely nonsensical data. It
took me less than 5 minutes to eliminate more than 50% of that list and
I'm pretty sure that I could have eliminated the bulk of the rest as
well.

The fact that a large part of this is ARM only, the fact that nobody
bothered to look at how e.g. IOMMU detection works and whether those
ioremaps actually can't be reached is hillarious.

So of these 400 instances are at least 30% ARM specific and those
cannot be reached on ARM nilly willy either because they are either
device tree or ACPI enumerated.

Claiming that it is soo much work to analyze 400 at least to the point:

  - whether they are relevant for x86 and therefore potentially TDX at
    all

  - whether they have some form of enumeration or detection which makes
    the ioremaps unreachable when the trusted BIOS is implemented
    correctly

Ijust can laugh at that, really:

  Two of my engineers have done an inventory of hundreds of cpu hotplug
  notifier instances in a couple of days some years ago. Ditto for a
  couple of hundred seqcount and a couple of hundred tasklet usage
  sites.

Sure, but it makes more security handwaving and a nice presentation to
tell people how much unsecure code there is based on half thought out
static analysis. To do a proper static analysis of this, you really
have to do a proper brain based analysis first of:

  1) Which code is relevant for x86

  2) What are the mechanisms which are used across the X86 relevant
     driver space to make these ioremap/MSR accesses actually reachable.

And of course this will not be complete, but this eliminates the vast
majority of your list. And looking at the remaining ones is not rocket
science either.

I can't take that serious at all. Come back when you have a properly
compiled list of drivers which:

  1) Can even be built for X86

  2) Do ioremap/MSR based poking unconditionally.

  3) Cannot be easily guarded off at the subsystem level

It's not going to be a huge list.

Then we can talk about facts and talk about the work required to fix
them or blacklist them in some way.

Thanks,

        tglx
