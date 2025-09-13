Return-Path: <linux-arch+bounces-13564-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27707B55EB8
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 07:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA191C870C3
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 05:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288A72E2F03;
	Sat, 13 Sep 2025 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9YjWJqQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9AE2E2DEF;
	Sat, 13 Sep 2025 05:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757743065; cv=none; b=J1JiMmf+rM+haMSBjDBeZVSDkV2dfy+n9dRnGe+kQGIIJufQQg3muAJeA+/ab9+gGl1aYRzNspoeOChICxGiVn7gWl1dS05TMbxghP7GhUb3AL/M4I9vYZ/K2RC5OKAHhEMYKGAUhB9BuQPiXZG1vj7RqPCa6nXNuEw8akoyjKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757743065; c=relaxed/simple;
	bh=OJAEM2u1uEA9tyvhQI9g5KaUDyNQX35uKL8whl/KGxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZIvnSzwrdk0wVKbrIwG/mFc58Bb5R8djf0vFRbsu17l5fT5EUjPki8WAZ7DUs+8Y6AvDi7/laExev770GnQSONbZ06Gv9q0GI81PSzuluHO0yaGHAwVogdG9XlwPEuuFoudBD3UDn0zOdEWg7hEROdkvOokcgcaE0sRcdeDTQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9YjWJqQ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757743063; x=1789279063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OJAEM2u1uEA9tyvhQI9g5KaUDyNQX35uKL8whl/KGxI=;
  b=g9YjWJqQ+fJiagk/bHKtHct6QywEoIoirEmgMQNrhO3I4UqpXVTyGiJf
   h56szVTuiY6kZVcanbE0hkOlwQj5Ii8MG1yc/k5uikvyfQYXIt6WgzUcS
   pQr119l6VgNoQNppLxPFf7Ldivv7OeXnttIIzT/4pDRjIIT+5CFjR2zoq
   rdVQsMvIjfF3I9/3hjtLBOJdumlcvgG9P1cKlwS2UDAEhgUinOz1KzkjV
   3ABssCIVO7C3VRlzi3fcmKgsh7axdwy4A69CzGR3iAXEl/TiOQgqFXD8Z
   bq1FgXqjJL3aPvggbBAq9Qj1Z55ICTFxvUtOIkmYUgvYtwNIaAFlfjDCz
   w==;
X-CSE-ConnectionGUID: 4dFRiaLoTPa3B9y8EZ3Yvw==
X-CSE-MsgGUID: WoEIVfj3ScOdNV9BIWqCjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60142416"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60142416"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 22:57:42 -0700
X-CSE-ConnectionGUID: vXuK2sbLRnuA/QWj3UJcXA==
X-CSE-MsgGUID: lSjaxLdMQaOAQGrew2XjuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,261,1751266800"; 
   d="scan'208";a="173753699"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 12 Sep 2025 22:57:38 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uxJGS-0001O4-1f;
	Sat, 13 Sep 2025 05:57:36 +0000
Date: Sat, 13 Sep 2025 13:57:32 +0800
From: kernel test robot <lkp@intel.com>
To: Mukesh Rathor <mrathor@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	arnd@arndb.de
Subject: Re: [PATCH v1 6/6] x86/hyperv: Enable build of hypervisor crashdump
 collection files
Message-ID: <202509131304.WGYf1Sx7-lkp@intel.com>
References: <20250910001009.2651481-7-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910001009.2651481-7-mrathor@linux.microsoft.com>

Hi Mukesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250909]
[also build test ERROR on v6.17-rc5]
[cannot apply to tip/x86/core tip/master linus/master arnd-asm-generic/master tip/auto-latest v6.17-rc5 v6.17-rc4 v6.17-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mukesh-Rathor/x86-hyperv-Rename-guest-crash-shutdown-function/20250910-081309
base:   next-20250909
patch link:    https://lore.kernel.org/r/20250910001009.2651481-7-mrathor%40linux.microsoft.com
patch subject: [PATCH v1 6/6] x86/hyperv: Enable build of hypervisor crashdump collection files
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20250913/202509131304.WGYf1Sx7-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250913/202509131304.WGYf1Sx7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509131304.WGYf1Sx7-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/hyperv/hv_init.c: In function 'hyperv_init':
>> arch/x86/hyperv/hv_init.c:550:17: error: implicit declaration of function 'hv_root_crash_init' [-Wimplicit-function-declaration]
     550 |                 hv_root_crash_init();
         |                 ^~~~~~~~~~~~~~~~~~


vim +/hv_root_crash_init +550 arch/x86/hyperv/hv_init.c

   431	
   432	/*
   433	 * This function is to be invoked early in the boot sequence after the
   434	 * hypervisor has been detected.
   435	 *
   436	 * 1. Setup the hypercall page.
   437	 * 2. Register Hyper-V specific clocksource.
   438	 * 3. Setup Hyper-V specific APIC entry points.
   439	 */
   440	void __init hyperv_init(void)
   441	{
   442		u64 guest_id;
   443		union hv_x64_msr_hypercall_contents hypercall_msr;
   444		int cpuhp;
   445	
   446		if (x86_hyper_type != X86_HYPER_MS_HYPERV)
   447			return;
   448	
   449		if (hv_common_init())
   450			return;
   451	
   452		/*
   453		 * The VP assist page is useless to a TDX guest: the only use we
   454		 * would have for it is lazy EOI, which can not be used with TDX.
   455		 */
   456		if (hv_isolation_type_tdx())
   457			hv_vp_assist_page = NULL;
   458		else
   459			hv_vp_assist_page = kcalloc(nr_cpu_ids,
   460						    sizeof(*hv_vp_assist_page),
   461						    GFP_KERNEL);
   462		if (!hv_vp_assist_page) {
   463			ms_hyperv.hints &= ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
   464	
   465			if (!hv_isolation_type_tdx())
   466				goto common_free;
   467		}
   468	
   469		if (ms_hyperv.paravisor_present && hv_isolation_type_snp()) {
   470			/* Negotiate GHCB Version. */
   471			if (!hv_ghcb_negotiate_protocol())
   472				hv_ghcb_terminate(SEV_TERM_SET_GEN,
   473						  GHCB_SEV_ES_PROT_UNSUPPORTED);
   474	
   475			hv_ghcb_pg = alloc_percpu(union hv_ghcb *);
   476			if (!hv_ghcb_pg)
   477				goto free_vp_assist_page;
   478		}
   479	
   480		cpuhp = cpuhp_setup_state(CPUHP_AP_HYPERV_ONLINE, "x86/hyperv_init:online",
   481					  hv_cpu_init, hv_cpu_die);
   482		if (cpuhp < 0)
   483			goto free_ghcb_page;
   484	
   485		/*
   486		 * Setup the hypercall page and enable hypercalls.
   487		 * 1. Register the guest ID
   488		 * 2. Enable the hypercall and register the hypercall page
   489		 *
   490		 * A TDX VM with no paravisor only uses TDX GHCI rather than hv_hypercall_pg:
   491		 * when the hypercall input is a page, such a VM must pass a decrypted
   492		 * page to Hyper-V, e.g. hv_post_message() uses the per-CPU page
   493		 * hyperv_pcpu_input_arg, which is decrypted if no paravisor is present.
   494		 *
   495		 * A TDX VM with the paravisor uses hv_hypercall_pg for most hypercalls,
   496		 * which are handled by the paravisor and the VM must use an encrypted
   497		 * input page: in such a VM, the hyperv_pcpu_input_arg is encrypted and
   498		 * used in the hypercalls, e.g. see hv_mark_gpa_visibility() and
   499		 * hv_arch_irq_unmask(). Such a VM uses TDX GHCI for two hypercalls:
   500		 * 1. HVCALL_SIGNAL_EVENT: see vmbus_set_event() and _hv_do_fast_hypercall8().
   501		 * 2. HVCALL_POST_MESSAGE: the input page must be a decrypted page, i.e.
   502		 * hv_post_message() in such a VM can't use the encrypted hyperv_pcpu_input_arg;
   503		 * instead, hv_post_message() uses the post_msg_page, which is decrypted
   504		 * in such a VM and is only used in such a VM.
   505		 */
   506		guest_id = hv_generate_guest_id(LINUX_VERSION_CODE);
   507		wrmsrq(HV_X64_MSR_GUEST_OS_ID, guest_id);
   508	
   509		/* With the paravisor, the VM must also write the ID via GHCB/GHCI */
   510		hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
   511	
   512		/* A TDX VM with no paravisor only uses TDX GHCI rather than hv_hypercall_pg */
   513		if (hv_isolation_type_tdx() && !ms_hyperv.paravisor_present)
   514			goto skip_hypercall_pg_init;
   515	
   516		hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1, MODULES_VADDR,
   517				MODULES_END, GFP_KERNEL, PAGE_KERNEL_ROX,
   518				VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
   519				__builtin_return_address(0));
   520		if (hv_hypercall_pg == NULL)
   521			goto clean_guest_os_id;
   522	
   523		rdmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
   524		hypercall_msr.enable = 1;
   525	
   526		if (hv_root_partition()) {
   527			struct page *pg;
   528			void *src;
   529	
   530			/*
   531			 * For the root partition, the hypervisor will set up its
   532			 * hypercall page. The hypervisor guarantees it will not show
   533			 * up in the root's address space. The root can't change the
   534			 * location of the hypercall page.
   535			 *
   536			 * Order is important here. We must enable the hypercall page
   537			 * so it is populated with code, then copy the code to an
   538			 * executable page.
   539			 */
   540			wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
   541	
   542			pg = vmalloc_to_page(hv_hypercall_pg);
   543			src = memremap(hypercall_msr.guest_physical_address << PAGE_SHIFT, PAGE_SIZE,
   544					MEMREMAP_WB);
   545			BUG_ON(!src);
   546			memcpy_to_page(pg, 0, src, HV_HYP_PAGE_SIZE);
   547			memunmap(src);
   548	
   549			hv_remap_tsc_clocksource();
 > 550			hv_root_crash_init();
   551		} else {
   552			hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
   553			wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
   554		}
   555	
   556		hv_set_hypercall_pg(hv_hypercall_pg);
   557	
   558	skip_hypercall_pg_init:
   559		/*
   560		 * hyperv_init() is called before LAPIC is initialized: see
   561		 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
   562		 * apic_bsp_setup() -> setup_local_APIC(). The direct-mode STIMER
   563		 * depends on LAPIC, so hv_stimer_alloc() should be called from
   564		 * x86_init.timers.setup_percpu_clockev.
   565		 */
   566		old_setup_percpu_clockev = x86_init.timers.setup_percpu_clockev;
   567		x86_init.timers.setup_percpu_clockev = hv_stimer_setup_percpu_clockev;
   568	
   569		hv_apic_init();
   570	
   571		x86_init.pci.arch_init = hv_pci_init;
   572	
   573		register_syscore_ops(&hv_syscore_ops);
   574	
   575		if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
   576			hv_get_partition_id();
   577	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

