Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E8F6DE189
	for <lists+linux-arch@lfdr.de>; Tue, 11 Apr 2023 18:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjDKQxY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 11 Apr 2023 12:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjDKQxQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2023 12:53:16 -0400
Received: from NAM06-BL2-obe.outbound.protection.outlook.com (mail-bl2nam06on2113.outbound.protection.outlook.com [40.107.65.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344BD5582;
        Tue, 11 Apr 2023 09:53:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbIyZtdnPHO/e94+d5RYGyG58v1YFyLVCb0MPv5KZpWs3wU893UjW2xKD9aG9cTeIWGljiGXIo4eLySOtclonHc8ld9PKLdgL4SpadPWeep1FE7UwMUxH/ao3wQGOu4VNEmTwU/+O6wBHvZ1Jp+ljJQdsTC4bBj6jaxgO7JfxjBWWJ70zGMFbfJSFSeQnIBbuu3H9q2j4pLKTAZolANtwbqIcq6rNv7a19rXdtVPnovtVPvsRJM8+3BxIFpknHW7SFrGR2Wt6yZqMN7TtqeLKj23489atz9rD8zdia1qCsiaENhy0O4n/jiOs1dI8LE6uHMZmLCHxTC+ktkiQprJtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gFemz0mGq9DlfhgHer/ROaIxhLZLdltgAgyXcnQLRo=;
 b=IlFM0/hBmHrytaqrKlT7pgf4zlg8c6L3+GyYapQRxABzxEBV23JiHzyP6eC/sxKz16awzQxagCj3Bur0ZX66mxc3hBR6tQoeYbd7PaXPWEuenNJW3zUXdN4lHZE23BRxEEc0SMJ6OMWGLu64rCHg9Ov1GKO7GhqkKTdfzBQAx8uKIPSh07575WgWo/BrWJLJLHweJLJjewheKUIWfyKYXBmtgeyQ4QeIyiwKEPS3Wc3lRRBph8hOsAPq7QXhBfDnuFu8VwrOow1CYPjk4ywmOC//yOuJN2Qb0ZiqxhkuH1OSuI4H7V4ekGNK4+/FekJHxWtHy+69SnhEha0SzYbZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MWH0PF80656AAAA.namprd21.prod.outlook.com (2603:10b6:30f:fff1:0:3:0:d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Tue, 11 Apr
 2023 16:53:07 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.003; Tue, 11 Apr 2023
 16:53:07 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: RE: [PATCH v4 5/6] Drivers: hv: vmbus: Support TDX guests
Thread-Topic: [PATCH v4 5/6] Drivers: hv: vmbus: Support TDX guests
Thread-Index: AQHZaluiU1mCuu/uekyGswn5O4Hjua8mUv6Q
Date:   Tue, 11 Apr 2023 16:53:07 +0000
Message-ID: <BYAPR21MB16889D8C10AC1FC94BA6BC3BD79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230408204759.14902-1-decui@microsoft.com>
 <20230408204759.14902-6-decui@microsoft.com>
In-Reply-To: <20230408204759.14902-6-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=06d623f3-0b1f-4f70-9600-5a205fdc39fd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-11T16:37:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MWH0PF80656AAAA:EE_
x-ms-office365-filtering-correlation-id: 3fd82fe4-665a-4cc3-00ad-08db3aad39d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199021)(8990500004)(786003)(54906003)(66556008)(4326008)(186003)(2906002)(55016003)(66446008)(478600001)(41300700001)(10290500003)(83380400001)(52536014)(26005)(9686003)(107886003)(7416002)(6506007)(110136005)(8936002)(8676002)(7696005)(64756008)(5660300002)(316002)(76116006)(66946007)(71200400001)(66476007)(82950400001)(82960400001)(122000001)(38100700002)(86362001)(33656002)(921005)(38070700005)(66899021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd82fe4-665a-4cc3-00ad-08db3aad39d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 16:53:07.7060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vcD3m0sdq+2ONqQ0F1aUzyMcUoOXHKJEuKcF5onCOX4JrObqNmuXaNodL8Km2gcujraQ0SEfAJlXvgT6KVIxG76u3h3Xt/S8bP8PbpRLvJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWH0PF80656AAAA
X-Spam-Status: No, score=1.0 required=5.0 tests=FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Saturday, April 8, 2023 1:48 PM
> 
> Add Hyper-V specific code so that a TDX guest can run on Hyper-V:
>   No need to use hv_vp_assist_page.
>   Don't use the unsafe Hyper-V TSC page.
>   Don't try to use HV_REGISTER_CRASH_CTL.
>   Don't trust Hyper-V's TLB-flushing hypercalls.
>   Don't use lazy EOI.
>   Share SynIC Event/Message pages and VMBus Monitor pages with the host.
>   Use pgprot_decrypted(PAGE_KERNEL)in hv_ringbuffer_init().
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> Changes in v2:
>   Used a new function hv_set_memory_enc_dec_needed() in
>     __set_memory_enc_pgtable().
>   Added the missing set_memory_encrypted() in hv_synic_free().
> 
> Changes in v3:
>   Use pgprot_decrypted(PAGE_KERNEL)in hv_ringbuffer_init().
>   (Do not use PAGE_KERNEL_NOENC, which doesn't exist for ARM64).
> 
>   Used cc_mkdec() in hv_synic_enable_regs().
> 
>   ms_hyperv_init_platform():
>     Explicitly do not use HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED.
>     Explicitly do not use HV_X64_APIC_ACCESS_RECOMMENDED.
> 
>   Enabled __send_ipi_mask() and __send_ipi_one() for TDX guests.
> 
> Changes in v4:
>   A minor rebase to Michael's v7 DDA patchset. I'm very happy that
>     I can drop my v3 change to arch/x86/mm/pat/set_memory.c due to
>     Michael's work.
> 
>  arch/x86/hyperv/hv_apic.c      |  6 ++--
>  arch/x86/hyperv/hv_init.c      | 19 ++++++++---
>  arch/x86/kernel/cpu/mshyperv.c | 21 +++++++++++-
>  drivers/hv/hv.c                | 62 +++++++++++++++++++++++++++++++---
>  4 files changed, 96 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index fb8b2c088681a..16919c7b3196e 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -173,7 +173,8 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector,
>  	    (exclude_self && weight == 1 && cpumask_test_cpu(this_cpu, mask)))
>  		return true;
> 
> -	if (!hv_hypercall_pg)
> +	/* A TDX guest doesn't use hv_hypercall_pg. */
> +	if (!hv_isolation_type_tdx() && !hv_hypercall_pg)
>  		return false;
> 
>  	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
> @@ -227,7 +228,8 @@ static bool __send_ipi_one(int cpu, int vector)
> 
>  	trace_hyperv_send_ipi_one(cpu, vector);
> 
> -	if (!hv_hypercall_pg || (vp == VP_INVAL))
> +	/* A TDX guest doesn't use hv_hypercall_pg. */
> +	if ((!hv_isolation_type_tdx() && !hv_hypercall_pg) || (vp == VP_INVAL))
>  		return false;
> 
>  	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index f175e0de821c3..f28357ecad7d9 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -79,7 +79,7 @@ static int hyperv_init_ghcb(void)
>  static int hv_cpu_init(unsigned int cpu)
>  {
>  	union hv_vp_assist_msr_contents msr = { 0 };
> -	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[cpu];
> +	struct hv_vp_assist_page **hvp;
>  	int ret;
> 
>  	ret = hv_common_cpu_init(cpu);
> @@ -89,6 +89,7 @@ static int hv_cpu_init(unsigned int cpu)
>  	if (!hv_vp_assist_page)
>  		return 0;
> 
> +	hvp = &hv_vp_assist_page[cpu];
>  	if (hv_root_partition) {
>  		/*
>  		 * For root partition we get the hypervisor provided VP assist
> @@ -398,11 +399,21 @@ void __init hyperv_init(void)
>  	if (hv_common_init())
>  		return;
> 
> -	hv_vp_assist_page = kcalloc(num_possible_cpus(),
> -				    sizeof(*hv_vp_assist_page), GFP_KERNEL);
> +	/*
> +	 * The VP assist page is useless to a TDX guest: the only use we
> +	 * would have for it is lazy EOI, which can not be used with TDX.
> +	 */
> +	if (hv_isolation_type_tdx())
> +		hv_vp_assist_page = NULL;
> +	else
> +		hv_vp_assist_page = kcalloc(num_possible_cpus(),
> +					    sizeof(*hv_vp_assist_page),
> +					    GFP_KERNEL);
>  	if (!hv_vp_assist_page) {
>  		ms_hyperv.hints &= ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
> -		goto common_free;
> +
> +		if (!hv_isolation_type_tdx())
> +			goto common_free;
>  	}
> 
>  	if (hv_isolation_type_snp()) {
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index a87fb934cd4b4..e9106c9d92f81 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -405,8 +405,27 @@ static void __init ms_hyperv_init_platform(void)
> 
>  		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP)
>  			static_branch_enable(&isolation_type_snp);
> -		else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX)
> +		else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX) {
>  			static_branch_enable(&isolation_type_tdx);
> +
> +			/*
> +			 * The GPAs of SynIC Event/Message pages and VMBus
> +			 * Moniter pages need to be added by this offset.
> +			 */
> +			ms_hyperv.shared_gpa_boundary = cc_mkdec(0);
> +
> +			/* Don't use the unsafe Hyper-V TSC page */
> +			ms_hyperv.features &= ~HV_MSR_REFERENCE_TSC_AVAILABLE;
> +
> +			/* HV_REGISTER_CRASH_CTL is unsupported */
> +			ms_hyperv.misc_features &= ~HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
> +
> +			/* Don't trust Hyper-V's TLB-flushing hypercalls */
> +			ms_hyperv.hints &= ~HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED;
> +
> +			/* A TDX VM must use x2APIC and doesn't use lazy EOI */
> +			ms_hyperv.hints &= ~HV_X64_APIC_ACCESS_RECOMMENDED;
> +		}
>  	}
> 
>  	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 008234894d287..22ecb79d21efd 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -18,6 +18,7 @@
>  #include <linux/clockchips.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> +#include <linux/set_memory.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/mshyperv.h>
>  #include "hyperv_vmbus.h"
> @@ -119,6 +120,7 @@ int hv_synic_alloc(void)
>  {
>  	int cpu;
>  	struct hv_per_cpu_context *hv_cpu;
> +	int ret = -ENOMEM;
> 
>  	/*
>  	 * First, zero all per-cpu memory areas so hv_synic_free() can
> @@ -168,6 +170,30 @@ int hv_synic_alloc(void)
>  			pr_err("Unable to allocate post msg page\n");
>  			goto err;
>  		}
> +
> +
> +		if (hv_isolation_type_tdx()) {
> +			ret = set_memory_decrypted(
> +				(unsigned long)hv_cpu->synic_message_page, 1);
> +			if (ret) {
> +				pr_err("Failed to decrypt SYNIC msg page\n");
> +				goto err;
> +			}
> +
> +			ret = set_memory_decrypted(
> +				(unsigned long)hv_cpu->synic_event_page, 1);
> +			if (ret) {
> +				pr_err("Failed to decrypt SYNIC event page\n");
> +				goto err;
> +			}
> +
> +			ret = set_memory_decrypted(
> +				(unsigned long)hv_cpu->post_msg_page, 1);
> +			if (ret) {
> +				pr_err("Failed to decrypt post msg page\n");
> +				goto err;
> +			}
> +		}

The error path here doesn't always work correctly.  If one or more of the
three pages is decrypted, and then one of the decryptions fails, we're left
in a state where all three pages are allocated, but some are decrypted
and some are not.  hv_synic_free() won't know which pages are allocated
but still encrypted, and will try to re-encrypt a page that wasn't
successfully decrypted.

The code to clean up from an error is messy because there are three pages
involved.   You've posted a separate patch to eliminate the need for the
post_msg_page.  If that patch came before this patch series (or maybe
incorporated into this series), the code here only has to deal with two
pages instead of three, making the cleanup of decryption errors easier.

>  	}
> 
>  	return 0;
> @@ -176,18 +202,42 @@ int hv_synic_alloc(void)
>  	 * Any memory allocations that succeeded will be freed when
>  	 * the caller cleans up by calling hv_synic_free()
>  	 */
> -	return -ENOMEM;
> +	return ret;
>  }
> 
> 
>  void hv_synic_free(void)
>  {
>  	int cpu;
> +	int ret;
> 
>  	for_each_present_cpu(cpu) {
>  		struct hv_per_cpu_context *hv_cpu
>  			= per_cpu_ptr(hv_context.cpu_context, cpu);
> 
> +		if (hv_isolation_type_tdx()) {
> +			ret = set_memory_encrypted(
> +				(unsigned long)hv_cpu->synic_message_page, 1);
> +			if (ret) {
> +				pr_err("Failed to encrypt SYNIC msg page\n");
> +				continue;
> +			}
> +
> +			ret = set_memory_encrypted(
> +				(unsigned long)hv_cpu->synic_event_page, 1);
> +			if (ret) {
> +				pr_err("Failed to encrypt SYNIC event page\n");
> +				continue;
> +			}
> +
> +			ret = set_memory_encrypted(
> +				(unsigned long)hv_cpu->post_msg_page, 1);
> +			if (ret) {
> +				pr_err("Failed to encrypt post msg page\n");
> +				continue;
> +			}

If any of the three re-encryptions fails, we'll leak all three pages.  That's
probably OK.  Eliminating the post_msg_page will help.

> +		}
> +
>  		free_page((unsigned long)hv_cpu->synic_event_page);
>  		free_page((unsigned long)hv_cpu->synic_message_page);
>  		free_page((unsigned long)hv_cpu->post_msg_page);
> @@ -225,8 +275,9 @@ void hv_synic_enable_regs(unsigned int cpu)
>  		if (!hv_cpu->synic_message_page)
>  			pr_err("Fail to map synic message page.\n");
>  	} else {
> -		simp.base_simp_gpa = virt_to_phys(hv_cpu->synic_message_page)
> -			>> HV_HYP_PAGE_SHIFT;
> +		simp.base_simp_gpa =
> +			cc_mkdec(virt_to_phys(hv_cpu->synic_message_page)) >>
> +			HV_HYP_PAGE_SHIFT;
>  	}
> 
>  	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
> @@ -244,8 +295,9 @@ void hv_synic_enable_regs(unsigned int cpu)
>  		if (!hv_cpu->synic_event_page)
>  			pr_err("Fail to map synic event page.\n");
>  	} else {
> -		siefp.base_siefp_gpa = virt_to_phys(hv_cpu->synic_event_page)
> -			>> HV_HYP_PAGE_SHIFT;
> +		siefp.base_siefp_gpa =
> +			cc_mkdec(virt_to_phys(hv_cpu->synic_event_page)) >>
> +			HV_HYP_PAGE_SHIFT;
>  	}
> 
>  	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
> --
> 2.25.1

