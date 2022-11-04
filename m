Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600D4619467
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 11:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiKDKY4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 06:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiKDKYz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 06:24:55 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3AB96162;
        Fri,  4 Nov 2022 03:24:54 -0700 (PDT)
Received: from anrayabh-desk (unknown [167.220.238.193])
        by linux.microsoft.com (Postfix) with ESMTPSA id EFC91205DA4D;
        Fri,  4 Nov 2022 03:24:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EFC91205DA4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667557494;
        bh=8CZc6ie+M2e82JGKPjhLdxrXq0jJEkH38UjNhjZSp6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pN/agJ8c4ZP+qZ372rMTv3NFHY0P8aBaBlOUt4QrgPVaB76YE9mboq+JcfbztS4Kw
         SHPB+xNqgvfk473M1yCg5JlAUvhf3TRTaILi0Hxt80qeY22EEmS8SWe+Afe9UFLNIA
         9SnxOKyDUIofgZr0br524hTF0Rs0l1P+sYHAcudo=
Date:   Fri, 4 Nov 2022 15:54:44 +0530
From:   Anirudh Rayabharam <anrayabh@linux.microsoft.com>
To:     Jinank Jain <jinankjain@linux.microsoft.com>
Cc:     jinankjain@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        arnd@arndb.de, peterz@infradead.org, jpoimboe@kernel.org,
        seanjc@google.com, kirill.shutemov@linux.intel.com,
        ak@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH v3 1/5] x86/hyperv: Add support for detecting nested
 hypervisor
Message-ID: <Y2TobFUO2dM1yVmq@anrayabh-desk>
References: <cover.1667480257.git.jinankjain@linux.microsoft.com>
 <285b15b90ac6f29ef8ab6b6ececeeef7d7c6f380.1667480257.git.jinankjain@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <285b15b90ac6f29ef8ab6b6ececeeef7d7c6f380.1667480257.git.jinankjain@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 03, 2022 at 01:04:03PM +0000, Jinank Jain wrote:
> When Linux runs as a root partition for Microsoft Hypervisor. It is
> possible to detect if it is running as nested hypervisor using
> hints exposed by mshv. While at it expose a new variable called
> hv_nested which can be used later for making decisions specific to
> nested use case.
> 
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 3 +++
>  arch/x86/include/asm/mshyperv.h    | 2 ++
>  arch/x86/kernel/cpu/mshyperv.c     | 7 +++++++
>  drivers/hv/hv_common.c             | 7 +++++--
>  4 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 3089ec352743..d9a611565859 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -114,6 +114,9 @@
>  /* Recommend using the newer ExProcessorMasks interface */
>  #define HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED		BIT(11)
>  
> +/* Indicates that the hypervisor is nested within a Hyper-V partition. */
> +#define HV_X64_HYPERV_NESTED				BIT(12)
> +
>  /* Recommend using enlightened VMCS */
>  #define HV_X64_ENLIGHTENED_VMCS_RECOMMENDED		BIT(14)
>  
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 61f0c206bff0..3c39923e5969 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -26,6 +26,8 @@ void hyperv_vector_handler(struct pt_regs *regs);
>  #if IS_ENABLED(CONFIG_HYPERV)
>  extern int hyperv_init_cpuhp;
>  
> +extern bool hv_nested;
> +
>  extern void *hv_hypercall_pg;
>  
>  extern u64 hv_current_partition_id;
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 831613959a92..9a4204139490 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -37,6 +37,8 @@
>  
>  /* Is Linux running as the root partition? */
>  bool hv_root_partition;
> +/* Is Linux running on nested Microsoft Hypervisor */
> +bool hv_nested;
>  struct ms_hyperv_info ms_hyperv;
>  
>  #if IS_ENABLED(CONFIG_HYPERV)
> @@ -301,6 +303,11 @@ static void __init ms_hyperv_init_platform(void)
>  		pr_info("Hyper-V: running as root partition\n");
>  	}
>  
> +	if (ms_hyperv.hints & HV_X64_HYPERV_NESTED) {
> +		hv_nested = true;
> +		pr_info("Hyper-V: running on a nested hypervisor\n");
> +	}
> +
>  	/*
>  	 * Extract host information.
>  	 */
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index ae68298c0dca..dcb336ce374f 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -25,8 +25,8 @@
>  #include <asm/mshyperv.h>
>  
>  /*
> - * hv_root_partition and ms_hyperv are defined here with other Hyper-V
> - * specific globals so they are shared across all architectures and are
> + * hv_root_partition, ms_hyperv and hv_nested are defined here with other
> + * Hyper-V specific globals so they are shared across all architectures and are
>   * built only when CONFIG_HYPERV is defined.  But on x86,
>   * ms_hyperv_init_platform() is built even when CONFIG_HYPERV is not
>   * defined, and it uses these two variables.  So mark them as __weak
> @@ -36,6 +36,9 @@
>  bool __weak hv_root_partition;
>  EXPORT_SYMBOL_GPL(hv_root_partition);
>  
> +bool __weak hv_nested;
> +EXPORT_SYMBOL_GPL(hv_nested);
> +
>  struct ms_hyperv_info __weak ms_hyperv;
>  EXPORT_SYMBOL_GPL(ms_hyperv);
>  
> -- 
> 2.25.1

Reviewed-by: <anrayabh@linux.microsoft.com>

