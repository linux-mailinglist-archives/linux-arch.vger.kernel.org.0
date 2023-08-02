Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F93C76DBAE
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 01:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjHBXkF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 19:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjHBXkC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 19:40:02 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5957B30D7;
        Wed,  2 Aug 2023 16:39:59 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1b8ad356f03so3147855ad.1;
        Wed, 02 Aug 2023 16:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691019599; x=1691624399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svTvNz159AaCyrUgUAq3HgCMBUXBdNbsOaqP72bL5to=;
        b=jnIBrwtVm5I8pfEwGTEl4pjFK4y/MkuUsmctgHxSe8EscRwAzdXayVPsBKgHKWJSav
         zDoB2GNbftdlPiJqXL6P+3nspT9NDnxThnTvX/ft1NH7J1CLh3T7QvSXGNimXG/tWwab
         C7qOt7SG96jE93B0d1R9L2LQuWTX/zUymxd6t0ijGpy0yHDyy/LdjRaNXPr7dSyaaI5W
         FogOW705dhP+56qAd8jJs522zdWLloiCk2Ds1A/5+Aa7YfL3FhJ6IZp2/Mgfd0UskGxy
         7e/2BHPmo028DG3ZdEz1CVsgAYR8t/tMY2vTqVtYqFldc2xGofQwDyGQwiK9Ys61jVaG
         V+sw==
X-Gm-Message-State: ABy/qLagF+7nzB11Hjfc6woBo3agADe+IG5YJ0m0DlbU9xlNBgfPe8CP
        Vk2XfhvUwocGfJlrVwPF9ow=
X-Google-Smtp-Source: APBJJlG1uOUyQUrFLMdzBFWbuNH9pxnVvRMgfR8wuhEpkllv76Ur02kXn/lPuND1QVsekBiGM47H8g==
X-Received: by 2002:a17:902:aa46:b0:1b8:9002:c9ee with SMTP id c6-20020a170902aa4600b001b89002c9eemr15084777plr.1.1691019598604;
        Wed, 02 Aug 2023 16:39:58 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id e14-20020a17090301ce00b001bba373919bsm12966366plh.261.2023.08.02.16.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 16:39:58 -0700 (PDT)
Date:   Wed, 2 Aug 2023 23:39:52 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, mikelley@microsoft.com,
        kys@microsoft.com, wei.liu@kernel.org, haiyangz@microsoft.com,
        decui@microsoft.com, ssengar@linux.microsoft.com,
        mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
        jinankjain@linux.microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, vkuznets@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH 02/15] mshyperv: Introduce hv_get_hypervisor_version
Message-ID: <ZMrpSJvedrLqg6xK@liuwe-devbox-debian-v2>
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1690487690-2428-3-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690487690-2428-3-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 27, 2023 at 12:54:37PM -0700, Nuno Das Neves wrote:
> x86_64 and arm64 implementations to get the hypervisor version
> information.
> Also introduce hv_hypervisor_version_info structure to simplify parsing
> the fields.
> Replace the existing parsing when printing the version numbers.

The line wrapping looks odd. When you resend, please fix it. If you
meant to use multiple paragraphs, please insert a blank line between
them.

x86 and ARM maintainers, I don't think there is anything particularly
interesting to you, but I guess you're CC'ed because some of the files
fall under the respective directories. Feel free to ignore this patch.

The code looks fine to me -- it is mostly just refactoring.

Thanks,
Wei.

> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c      | 23 +++++++++++-------
>  arch/x86/kernel/cpu/mshyperv.c    | 40 ++++++++++++++++++++-----------
>  include/asm-generic/hyperv-tlfs.h | 23 ++++++++++++++++++
>  include/asm-generic/mshyperv.h    |  2 ++
>  4 files changed, 66 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index a406454578f0..d44c358ce45c 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -19,10 +19,19 @@
>  
>  static bool hyperv_initialized;
>  
> +int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
> +{
> +	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION,
> +			 (struct hv_get_vp_registers_output *)info);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
> +
>  static int __init hyperv_init(void)
>  {
> -	struct hv_get_vp_registers_output	result;
> -	u32	a, b, c, d;
> +	struct hv_get_vp_registers_output result;
> +	union hv_hypervisor_version_info version;
>  	u64	guest_id;
>  	int	ret;
>  
> @@ -55,13 +64,11 @@ static int __init hyperv_init(void)
>  		ms_hyperv.misc_features);
>  
>  	/* Get information about the Hyper-V host version */
> -	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION, &result);
> -	a = result.as32.a;
> -	b = result.as32.b;
> -	c = result.as32.c;
> -	d = result.as32.d;
> +	hv_get_hypervisor_version(&version);
>  	pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
> -		b >> 16, b & 0xFFFF, a,	d & 0xFFFFFF, c, d >> 24);
> +		version.major_version, version.minor_version,
> +		version.build_number, version.service_number,
> +		version.service_pack, version.service_branch);
>  
>  	ret = hv_common_init();
>  	if (ret)
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 57f6a5879b30..e44291e902ae 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -328,13 +328,30 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
>  }
>  #endif
>  
> +int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
> +{
> +	unsigned int hv_max_functions;
> +
> +	hv_max_functions = cpuid_eax(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS);
> +	if (hv_max_functions < HYPERV_CPUID_VERSION) {
> +		pr_err("%s: Could not detect Hyper-V version\n",
> +			__func__);
> +		return -ENODEV;
> +	}
> +
> +	info->eax = cpuid_eax(HYPERV_CPUID_VERSION);
> +	info->ebx = cpuid_ebx(HYPERV_CPUID_VERSION);
> +	info->ecx = cpuid_ecx(HYPERV_CPUID_VERSION);
> +	info->edx = cpuid_edx(HYPERV_CPUID_VERSION);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
> +
>  static void __init ms_hyperv_init_platform(void)
>  {
>  	int hv_max_functions_eax;
> -	int hv_host_info_eax;
> -	int hv_host_info_ebx;
> -	int hv_host_info_ecx;
> -	int hv_host_info_edx;
> +	union hv_hypervisor_version_info version;
>  
>  #ifdef CONFIG_PARAVIRT
>  	pv_info.name = "Hyper-V";
> @@ -388,16 +405,11 @@ static void __init ms_hyperv_init_platform(void)
>  	/*
>  	 * Extract host information.
>  	 */
> -	if (hv_max_functions_eax >= HYPERV_CPUID_VERSION) {
> -		hv_host_info_eax = cpuid_eax(HYPERV_CPUID_VERSION);
> -		hv_host_info_ebx = cpuid_ebx(HYPERV_CPUID_VERSION);
> -		hv_host_info_ecx = cpuid_ecx(HYPERV_CPUID_VERSION);
> -		hv_host_info_edx = cpuid_edx(HYPERV_CPUID_VERSION);
> -
> -		pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
> -			hv_host_info_ebx >> 16, hv_host_info_ebx & 0xFFFF,
> -			hv_host_info_eax, hv_host_info_edx & 0xFFFFFF,
> -			hv_host_info_ecx, hv_host_info_edx >> 24);
> +	if (hv_get_hypervisor_version(&version) == 0) {
> +		pr_info("Hyper-V Host Build:%d-%d.%d-%d-%d.%d\n",
> +			version.build_number, version.major_version,
> +			version.minor_version, version.service_pack,
> +			version.service_branch, version.service_number);
>  	}
>  
>  	if (ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index f4e4cc4f965f..373f26efa18a 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -786,6 +786,29 @@ struct hv_input_unmap_device_interrupt {
>  #define HV_SOURCE_SHADOW_NONE               0x0
>  #define HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE   0x1
>  
> +/*
> + * Version info reported by hypervisor
> + */
> +union hv_hypervisor_version_info {
> +	struct {
> +		u32 build_number;
> +
> +		u32 minor_version : 16;
> +		u32 major_version : 16;
> +
> +		u32 service_pack;
> +
> +		u32 service_number : 24;
> +		u32 service_branch : 8;
> +	};
> +	struct {
> +		u32 eax;
> +		u32 ebx;
> +		u32 ecx;
> +		u32 edx;
> +	};
> +};
> +
>  /*
>   * The whole argument should fit in a page to be able to pass to the hypervisor
>   * in one hypercall.
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 094c57320ed1..233c976344e5 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -153,6 +153,8 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
>  	}
>  }
>  
> +int hv_get_hypervisor_version(union hv_hypervisor_version_info *info);
> +
>  void hv_setup_vmbus_handler(void (*handler)(void));
>  void hv_remove_vmbus_handler(void);
>  void hv_setup_stimer0_handler(void (*handler)(void));
> -- 
> 2.25.1
> 
