Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F78865FF43
	for <lists+linux-arch@lfdr.de>; Fri,  6 Jan 2023 12:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjAFLAg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Jan 2023 06:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjAFLA2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Jan 2023 06:00:28 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07CB6E404;
        Fri,  6 Jan 2023 03:00:25 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id g13so1480805lfv.7;
        Fri, 06 Jan 2023 03:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SW/9INdwr3DrYb2M+rAGHTyplFx8OBOFvhB2p2FQ81g=;
        b=YGZG6HLlJTM1TzVguVykMUMISCXM7q+UjvSMdJu/JFbstAbEhmX9zl00Ot/vdYlHuH
         mrJUYxN9aUmEEleOI9XqYREcIYdFSO+LLDNEgVyPSxP7xyAoM7nLyz91bZytDg2ipyc5
         rtwFPcccNTAwDlleo1/tNnRxRxQJcbPhO/EUY+utFjnaQ5G8YUsUQo+EpNvx0N56BSfU
         XiFwyB5XuIA2W0aoSt6ge2GPqrLvOg8Ro6OjBbkqaZ19kQgwc9WqvXOKIy2YVsOC2Srd
         r+XSOeF5ZBhhIERbaAJKzzW3e04msgG05KCqpE2MatkdcMGTsxLYC8Lyhr6yqn+HuSE6
         sA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SW/9INdwr3DrYb2M+rAGHTyplFx8OBOFvhB2p2FQ81g=;
        b=MigHEXRsipuFD/cs9fYuHxSNtZn5RqAgW3N5JXWboly4BEIK4H6t3eI0EMpEXd95Jo
         n7t9N8a2UldLecsUDxGmIyniZ9A3vezqEHdK/nPR1af0r0rAP1Sv0auODLYUd7S5nDRs
         VWEMvap8Cmw/9wHWMiYAYTUjPbjxNmrAX5NMdAxS3OWNcIWVXCWyfQos8HVXBdyV4rsc
         45EPYteeA5wu4NwnKiXNfrX4fpdW56SgrFQBRU6O+mtcYgYYlbSWs7hdZ4d2AwPBTxga
         9i1RiLGgEPnBarqw65eIIYefW97gY1LQXuCtWD8ovmfhiWvAtREHOmEL7Rl9/46hQ79/
         Diwg==
X-Gm-Message-State: AFqh2kqEeEpoiYGdjaCsUvKHzVUmyHOQtjRqZKFgkJQTONoydLZ0g9K1
        b/r9dXNSspGoWj+n7jyPAic=
X-Google-Smtp-Source: AMrXdXtDMayUSEW9gWTi7+nisJn78bTVn/CPWxx9tXKewtHzILbf4J0iJs41oTm9pCVVia9rc5OSIg==
X-Received: by 2002:a19:f513:0:b0:4b5:731f:935a with SMTP id j19-20020a19f513000000b004b5731f935amr3441875lfb.0.1673002823960;
        Fri, 06 Jan 2023 03:00:23 -0800 (PST)
Received: from localhost (88-115-161-74.elisa-laajakaista.fi. [88.115.161.74])
        by smtp.gmail.com with ESMTPSA id a22-20020a2e9816000000b0027fc54f8bf0sm69016ljj.35.2023.01.06.03.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 03:00:23 -0800 (PST)
Date:   Fri, 6 Jan 2023 13:00:21 +0200
From:   Zhi Wang <zhi.wang.linux@gmail.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
        kys@microsoft.com, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] Drivers: hv: vmbus: Support TDX guests
Message-ID: <20230106130021.00006c94@gmail.com>
In-Reply-To: <20221121195151.21812-7-decui@microsoft.com>
References: <20221121195151.21812-1-decui@microsoft.com>
        <20221121195151.21812-7-decui@microsoft.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 21 Nov 2022 11:51:51 -0800
Dexuan Cui <decui@microsoft.com> wrote:

> Intel folks added the generic code to support a TDX guest in April, 2022.
> This commit and some earlier commits from me add the Hyper-V specific
> code so that a TDX guest can run on Hyper-V.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c      | 19 +++++++++++++++----
>  arch/x86/kernel/cpu/mshyperv.c | 10 ++++++++++
>  arch/x86/mm/pat/set_memory.c   |  2 +-
>  drivers/hv/connection.c        |  4 +++-
>  drivers/hv/hv.c                | 25 +++++++++++++++++++++++++
>  drivers/hv/ring_buffer.c       |  2 +-
>  6 files changed, 55 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 05682c4e327f..694f7fb04e5d 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -77,7 +77,7 @@ static int hyperv_init_ghcb(void)
>  static int hv_cpu_init(unsigned int cpu)
>  {
>  	union hv_vp_assist_msr_contents msr = { 0 };
> -	struct hv_vp_assist_page **hvp =
> &hv_vp_assist_page[smp_processor_id()];
> +	struct hv_vp_assist_page **hvp;
>  	int ret;
>  
>  	ret = hv_common_cpu_init(cpu);
> @@ -87,6 +87,7 @@ static int hv_cpu_init(unsigned int cpu)
>  	if (!hv_vp_assist_page)
>  		return 0;
>  
> +	hvp = &hv_vp_assist_page[smp_processor_id()];
>  	if (!*hvp) {
>  		if (hv_root_partition) {
>  			/*
> @@ -398,11 +399,21 @@ void __init hyperv_init(void)
>  	if (hv_common_init())
>  		return;
>  
> -	hv_vp_assist_page = kcalloc(num_possible_cpus(),
> -				    sizeof(*hv_vp_assist_page),
> GFP_KERNEL);
> +	/*
> +	 * The VP assist page is useless to a TDX guest: the only use we
> +	 * would have for it is lazy EOI, which can not be used with
> TDX.
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
> diff --git a/arch/x86/kernel/cpu/mshyperv.c
> b/arch/x86/kernel/cpu/mshyperv.c index dddccdbc5526..6f597b23ad3e 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -350,7 +350,17 @@ static void __init ms_hyperv_init_platform(void)
>  			case HV_ISOLATION_TYPE_TDX:
>  				static_branch_enable(&isolation_type_tdx);
>  
> +				cc_set_vendor(CC_VENDOR_INTEL);
> +
>  				ms_hyperv.shared_gpa_boundary =
> cc_mkdec(0); +
> +				/* Don't use the unsafe Hyper-V TSC
> page */
> +				ms_hyperv.features &=
> +					~HV_MSR_REFERENCE_TSC_AVAILABLE;
> +
> +				/* HV_REGISTER_CRASH_CTL is unsupported
> */
> +				ms_hyperv.misc_features &=
> +
> ~HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE; break;
>  
>  			default:
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 2e5a045731de..bb44aaddb230 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2120,7 +2120,7 @@ static int __set_memory_enc_pgtable(unsigned long
> addr, int numpages, bool enc) 
>  static int __set_memory_enc_dec(unsigned long addr, int numpages, bool
> enc) {
> -	if (hv_is_isolation_supported())
> +	if (hv_is_isolation_supported() && !hv_isolation_type_tdx())
>  		return hv_set_mem_host_visibility(addr, numpages, !enc);
>  
>  	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))

Let's say there will be four cases:

----
case a. SEV-SNP guest with paravisor

In the code, this case is represented by:

hv_is_isolation_supported() && hv_isolation_type_snp()
hv_is_isolation_supported() && !hv_isolation_type_tdx()

case b. TDX guest with paravisor
?

case c. SEV-SNP guest *without* paravisor
?

case d. TDX guest *without* paravisor

In the code, this case is represented by:

hv_is_isolation_supported() && hv_isolation_type_tdx()
----

1. It would be better to use "hv_is_isolation_supported() &&
hv_isolation_type_snp()" to represent case a to avoid confusion in the
above patch.

2. For now, hv_is_isolation_supported() only shows if the guest is a CC
guest or not. hv_isolation_type_*() only represent SNP or TDX but
not "w/ or w/o paravisor".

How are you going to represent case b and c in __set_memory_enc_dec()?

I think you are looking for something to show if the guest is running
with a paravisor or not here:

if (hv_is_isolation_supported() && hv_is_isolation_with_paravisor())
...

Thanks,
Zhi.


> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 9dc27e5d367a..1ecc3c29e3f7 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -250,12 +250,14 @@ int vmbus_connect(void)
>  		 * Isolation VM with AMD SNP needs to access monitor
> page via
>  		 * address space above shared gpa boundary.
>  		 */
> -		if (hv_isolation_type_snp()) {
> +		if (hv_isolation_type_snp() || hv_isolation_type_tdx())
> { vmbus_connection.monitor_pages_pa[0] +=
>  				ms_hyperv.shared_gpa_boundary;
>  			vmbus_connection.monitor_pages_pa[1] +=
>  				ms_hyperv.shared_gpa_boundary;
> +		}
>  
> +		if (hv_isolation_type_snp()) {
>  			vmbus_connection.monitor_pages[0]
>  				=
> memremap(vmbus_connection.monitor_pages_pa[0], HV_HYP_PAGE_SIZE,
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 4d6480d57546..03b3257bc1ab 100644
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
> +	int ret;
>  
>  	/*
>  	 * First, zero all per-cpu memory areas so hv_synic_free() can
> @@ -168,6 +170,21 @@ int hv_synic_alloc(void)
>  			pr_err("Unable to allocate post msg page\n");
>  			goto err;
>  		}
> +
> +
> +		if (hv_isolation_type_tdx()) {
> +			ret = set_memory_decrypted(
> +				(unsigned
> long)hv_cpu->synic_message_page, 1);
> +			BUG_ON(ret);
> +
> +			ret = set_memory_decrypted(
> +				(unsigned
> long)hv_cpu->synic_event_page, 1);
> +			BUG_ON(ret);
> +
> +			ret = set_memory_decrypted(
> +				(unsigned long)hv_cpu->post_msg_page,
> 1);
> +			BUG_ON(ret);
> +		}
>  	}
>  
>  	return 0;
> @@ -225,6 +242,10 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	} else {
>  		simp.base_simp_gpa =
> virt_to_phys(hv_cpu->synic_message_page)
>  			>> HV_HYP_PAGE_SHIFT;
> +
> +		if (hv_isolation_type_tdx())
> +			simp.base_simp_gpa +=
> ms_hyperv.shared_gpa_boundary
> +				>> HV_HYP_PAGE_SHIFT;
>  	}
>  
>  	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
> @@ -243,6 +264,10 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	} else {
>  		siefp.base_siefp_gpa =
> virt_to_phys(hv_cpu->synic_event_page)
>  			>> HV_HYP_PAGE_SHIFT;
> +
> +		if (hv_isolation_type_tdx())
> +			siefp.base_siefp_gpa +=
> ms_hyperv.shared_gpa_boundary
> +				>> HV_HYP_PAGE_SHIFT;
>  	}
>  
>  	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index c6692fd5ab15..a51da82316ce 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -233,7 +233,7 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info
> *ring_info, 
>  		ring_info->ring_buffer = (struct hv_ring_buffer *)
>  			vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP,
> -				PAGE_KERNEL);
> +				pgprot_decrypted(PAGE_KERNEL_NOENC));
>  
>  		kfree(pages_wraparound);
>  		if (!ring_info->ring_buffer)

