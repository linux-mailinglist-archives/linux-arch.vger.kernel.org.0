Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B083320FBA
	for <lists+linux-arch@lfdr.de>; Mon, 22 Feb 2021 04:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhBVD03 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Feb 2021 22:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhBVD02 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Feb 2021 22:26:28 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C06C061786;
        Sun, 21 Feb 2021 19:25:48 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id q85so11389685qke.8;
        Sun, 21 Feb 2021 19:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J6xkxeHkpJMe9Py/SlzusHmuzVn7oMeqYGyJNTpxiPc=;
        b=MGDsXen01a2BUhcRBDuy004RGG2yPgr3DlD+E0vLJEyNaNV955WN6s700Rcy1UMBGc
         3qA6hXeEvytLdpIFchCPAG4OPXElDYoJoESDAY6NtPkuhz0dgpCIjO1wWkLbcfoyofUp
         EIgU4pw5vQnGsZJTzuUX7mt0CKAu3wRjRYdcxFx6RrWIBx8TjSWE2i+81dGwlgoY20ES
         VCVTTCvR3G6lWWPFRNpHNiaVRXsRFv3pNNTDQrBl1LLM5aNuELEItMYA9MMUJFMN3V5z
         JdtfrcWjs7yxpOhskD+WJy9AGiWQ+oFkr2KnobI3Al8EJx4coBs+SpwdeBzknWdovC+D
         NOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J6xkxeHkpJMe9Py/SlzusHmuzVn7oMeqYGyJNTpxiPc=;
        b=jZeSVThYMK1txhF6o2R+1P9GXfD/7q6RtijBnXWOw77shRualTU47inVSfXBTbjRsw
         Zbd1W3b0d4HD1b1u0zP/jpMsVpKYqtAcPFZpVG6l+DCDuOgdkY5PhShhz/X0xgfi/AJU
         sDmRT+Dd6YwYZxxALy+lWATFIm+oH0Gfg4ESU+73nMw32uGoaOnGTvb0yH1bXaDeq7lv
         kVRnfKzl4yHOvtxmgQDIzbC7IqacBHmeU/yOWjERyyJ3LlIZKuvx4oORDCvZTsxZ2rgL
         D4XKjgqf4lZutKk3sN6x8PnME5kKx2imbs7Ed2Z8OzIGhg0GXtIwUrl0Oj/1rLtmkZlh
         u/gQ==
X-Gm-Message-State: AOAM532pBuqE6b/+VIBcRh1SH/ZRsPEHRUx+oh2F6kxVMP3+qngFGKEj
        5MhY8GLH4H8H12XklUXD4/E=
X-Google-Smtp-Source: ABdhPJzrFuxPcWCEMcQFYSHOhBHPpJEYgtG5xUMd2+kbMXEKgFUk7cCUeYEUmAPkuSWsj5nAjv7HjQ==
X-Received: by 2002:ae9:f502:: with SMTP id o2mr18762648qkg.422.1613964347378;
        Sun, 21 Feb 2021 19:25:47 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id a16sm9869353qta.69.2021.02.21.19.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 19:25:47 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7FF7127C0054;
        Sun, 21 Feb 2021 22:25:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 21 Feb 2021 22:25:46 -0500
X-ME-Sender: <xms:OSQzYGytGht2OYZC07MNsu1uMCWEJCWr0aWLxNLq7-Al3uxvaAsgXw>
    <xme:OSQzYCT7sFFNHKRzqaKRZQMblVdD5ILmauqpm-WYuEQubwfnpCpUbz5T1PTCfwerd
    Mqnh7MYolBZFGwemw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkedvgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucfkphepudefuddruddtjedrudegjedruddvieenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:OSQzYIWejX6IPOxLk-GWYgSiZiIscpkjX1Sc161369vjmIlypPmajw>
    <xmx:OSQzYMhoN9wy-xjAarXn94B4vWGkTgmYuQXunNWfFVCRy_8e6O9LCw>
    <xmx:OSQzYIARX9AjE9P7zFrL6HCAlnwPI0CYQ9h6rQ-hd6Nr7B4A9xi8SA>
    <xmx:OiQzYE5WIw1kXlz0ewcoh6XKjEshqN32xs6tsdyEI7OkSrtvN7frpr9X1aY>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 12D85108005B;
        Sun, 21 Feb 2021 22:25:45 -0500 (EST)
Date:   Mon, 22 Feb 2021 11:25:12 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 03/10] Drivers: hv: Redo Hyper-V synthetic MSR get/set
 functions
Message-ID: <YDMkGCtL6BWBZzWQ@boqun-archlinux>
References: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
 <1611779025-21503-4-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611779025-21503-4-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 27, 2021 at 12:23:38PM -0800, Michael Kelley wrote:
> Current code defines a separate get and set macro for each Hyper-V
> synthetic MSR used by the VMbus driver. Furthermore, the get macro
> can't be converted to a standard function because the second argument
> is modified in place, which is somewhat bad form.
> 
> Redo this by providing a single get and a single set function that
> take a parameter specifying the MSR to be operated on. Fixup usage
> of the get function. Calling locations are no more complex than before,
> but the code under arch/x86 and the upcoming code under arch/arm64
> is significantly simplified.
> 
> Also standardize the names of Hyper-V synthetic MSRs that are
> architecture neutral. But keep the old x86-specific names as aliases
> that can be removed later when all references (particularly in KVM
> code) have been cleaned up in a separate patch series.
> 
> No functional change.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  arch/x86/hyperv/hv_init.c          |   2 +-
>  arch/x86/include/asm/hyperv-tlfs.h | 102 +++++++++++++++++++++++--------------
>  arch/x86/include/asm/mshyperv.h    |  39 ++++----------
>  drivers/clocksource/hyperv_timer.c |  26 +++++-----
>  drivers/hv/hv.c                    |  37 ++++++++------
>  drivers/hv/vmbus_drv.c             |   2 +-
>  include/asm-generic/mshyperv.h     |   2 +-
>  7 files changed, 110 insertions(+), 100 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 2d1688e..9b2cdbe 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -58,7 +58,7 @@ static int hv_cpu_init(unsigned int cpu)
>  		return -ENOMEM;
>  	*input_arg = page_address(pg);
>  
> -	hv_get_vp_index(msr_vp_index);
> +	msr_vp_index = hv_get_register(HV_REGISTER_VP_INDEX);
>  
>  	hv_vp_index[smp_processor_id()] = msr_vp_index;
>  
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index dd74066..545026e 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -131,7 +131,7 @@
>  #define HV_X64_MSR_HYPERCALL			0x40000001
>  
>  /* MSR used to provide vcpu index */
> -#define HV_X64_MSR_VP_INDEX			0x40000002
> +#define HV_REGISTER_VP_INDEX			0x40000002
>  
>  /* MSR used to reset the guest OS. */
>  #define HV_X64_MSR_RESET			0x40000003
> @@ -140,10 +140,10 @@
>  #define HV_X64_MSR_VP_RUNTIME			0x40000010
>  
>  /* MSR used to read the per-partition time reference counter */
> -#define HV_X64_MSR_TIME_REF_COUNT		0x40000020
> +#define HV_REGISTER_TIME_REF_COUNT		0x40000020
>  
>  /* A partition's reference time stamp counter (TSC) page */
> -#define HV_X64_MSR_REFERENCE_TSC		0x40000021
> +#define HV_REGISTER_REFERENCE_TSC		0x40000021
>  
>  /* MSR used to retrieve the TSC frequency */
>  #define HV_X64_MSR_TSC_FREQUENCY		0x40000022
> @@ -158,50 +158,50 @@
>  #define HV_X64_MSR_VP_ASSIST_PAGE		0x40000073
>  
>  /* Define synthetic interrupt controller model specific registers. */
> -#define HV_X64_MSR_SCONTROL			0x40000080
> -#define HV_X64_MSR_SVERSION			0x40000081
> -#define HV_X64_MSR_SIEFP			0x40000082
> -#define HV_X64_MSR_SIMP				0x40000083
> -#define HV_X64_MSR_EOM				0x40000084
> -#define HV_X64_MSR_SINT0			0x40000090
> -#define HV_X64_MSR_SINT1			0x40000091
> -#define HV_X64_MSR_SINT2			0x40000092
> -#define HV_X64_MSR_SINT3			0x40000093
> -#define HV_X64_MSR_SINT4			0x40000094
> -#define HV_X64_MSR_SINT5			0x40000095
> -#define HV_X64_MSR_SINT6			0x40000096
> -#define HV_X64_MSR_SINT7			0x40000097
> -#define HV_X64_MSR_SINT8			0x40000098
> -#define HV_X64_MSR_SINT9			0x40000099
> -#define HV_X64_MSR_SINT10			0x4000009A
> -#define HV_X64_MSR_SINT11			0x4000009B
> -#define HV_X64_MSR_SINT12			0x4000009C
> -#define HV_X64_MSR_SINT13			0x4000009D
> -#define HV_X64_MSR_SINT14			0x4000009E
> -#define HV_X64_MSR_SINT15			0x4000009F
> +#define HV_REGISTER_SCONTROL			0x40000080
> +#define HV_REGISTER_SVERSION			0x40000081
> +#define HV_REGISTER_SIEFP			0x40000082
> +#define HV_REGISTER_SIMP			0x40000083
> +#define HV_REGISTER_EOM				0x40000084
> +#define HV_REGISTER_SINT0			0x40000090
> +#define HV_REGISTER_SINT1			0x40000091
> +#define HV_REGISTER_SINT2			0x40000092
> +#define HV_REGISTER_SINT3			0x40000093
> +#define HV_REGISTER_SINT4			0x40000094
> +#define HV_REGISTER_SINT5			0x40000095
> +#define HV_REGISTER_SINT6			0x40000096
> +#define HV_REGISTER_SINT7			0x40000097
> +#define HV_REGISTER_SINT8			0x40000098
> +#define HV_REGISTER_SINT9			0x40000099
> +#define HV_REGISTER_SINT10			0x4000009A
> +#define HV_REGISTER_SINT11			0x4000009B
> +#define HV_REGISTER_SINT12			0x4000009C
> +#define HV_REGISTER_SINT13			0x4000009D
> +#define HV_REGISTER_SINT14			0x4000009E
> +#define HV_REGISTER_SINT15			0x4000009F
>  
>  /*
>   * Synthetic Timer MSRs. Four timers per vcpu.
>   */
> -#define HV_X64_MSR_STIMER0_CONFIG		0x400000B0
> -#define HV_X64_MSR_STIMER0_COUNT		0x400000B1
> -#define HV_X64_MSR_STIMER1_CONFIG		0x400000B2
> -#define HV_X64_MSR_STIMER1_COUNT		0x400000B3
> -#define HV_X64_MSR_STIMER2_CONFIG		0x400000B4
> -#define HV_X64_MSR_STIMER2_COUNT		0x400000B5
> -#define HV_X64_MSR_STIMER3_CONFIG		0x400000B6
> -#define HV_X64_MSR_STIMER3_COUNT		0x400000B7
> +#define HV_REGISTER_STIMER0_CONFIG		0x400000B0
> +#define HV_REGISTER_STIMER0_COUNT		0x400000B1
> +#define HV_REGISTER_STIMER1_CONFIG		0x400000B2
> +#define HV_REGISTER_STIMER1_COUNT		0x400000B3
> +#define HV_REGISTER_STIMER2_CONFIG		0x400000B4
> +#define HV_REGISTER_STIMER2_COUNT		0x400000B5
> +#define HV_REGISTER_STIMER3_CONFIG		0x400000B6
> +#define HV_REGISTER_STIMER3_COUNT		0x400000B7
>  
>  /* Hyper-V guest idle MSR */
>  #define HV_X64_MSR_GUEST_IDLE			0x400000F0
>  
>  /* Hyper-V guest crash notification MSR's */
> -#define HV_X64_MSR_CRASH_P0			0x40000100
> -#define HV_X64_MSR_CRASH_P1			0x40000101
> -#define HV_X64_MSR_CRASH_P2			0x40000102
> -#define HV_X64_MSR_CRASH_P3			0x40000103
> -#define HV_X64_MSR_CRASH_P4			0x40000104
> -#define HV_X64_MSR_CRASH_CTL			0x40000105
> +#define HV_REGISTER_CRASH_P0			0x40000100
> +#define HV_REGISTER_CRASH_P1			0x40000101
> +#define HV_REGISTER_CRASH_P2			0x40000102
> +#define HV_REGISTER_CRASH_P3			0x40000103
> +#define HV_REGISTER_CRASH_P4			0x40000104
> +#define HV_REGISTER_CRASH_CTL			0x40000105
>  
>  /* TSC emulation after migration */
>  #define HV_X64_MSR_REENLIGHTENMENT_CONTROL	0x40000106
> @@ -211,6 +211,32 @@
>  /* TSC invariant control */
>  #define HV_X64_MSR_TSC_INVARIANT_CONTROL	0x40000118
>  
> +/* Register name aliases for architecture independence */
> +#define HV_X64_MSR_STIMER0_COUNT	HV_REGISTER_STIMER0_COUNT
> +#define HV_X64_MSR_STIMER0_CONFIG	HV_REGISTER_STIMER0_CONFIG
> +#define HV_X64_MSR_STIMER1_COUNT	HV_REGISTER_STIMER1_COUNT
> +#define HV_X64_MSR_STIMER1_CONFIG	HV_REGISTER_STIMER1_CONFIG
> +#define HV_X64_MSR_STIMER2_COUNT	HV_REGISTER_STIMER2_COUNT
> +#define HV_X64_MSR_STIMER2_CONFIG	HV_REGISTER_STIMER2_CONFIG
> +#define HV_X64_MSR_STIMER3_COUNT	HV_REGISTER_STIMER3_COUNT
> +#define HV_X64_MSR_STIMER3_CONFIG	HV_REGISTER_STIMER3_CONFIG
> +#define HV_X64_MSR_SCONTROL		HV_REGISTER_SCONTROL
> +#define HV_X64_MSR_SVERSION		HV_REGISTER_SVERSION
> +#define HV_X64_MSR_SIMP			HV_REGISTER_SIMP
> +#define HV_X64_MSR_SIEFP		HV_REGISTER_SIEFP
> +#define HV_X64_MSR_VP_INDEX		HV_REGISTER_VP_INDEX
> +#define HV_X64_MSR_EOM			HV_REGISTER_EOM
> +#define HV_X64_MSR_SINT0		HV_REGISTER_SINT0
> +#define HV_X64_MSR_SINT15		HV_REGISTER_SINT15
> +#define HV_X64_MSR_CRASH_P0		HV_REGISTER_CRASH_P0
> +#define HV_X64_MSR_CRASH_P1		HV_REGISTER_CRASH_P1
> +#define HV_X64_MSR_CRASH_P2		HV_REGISTER_CRASH_P2
> +#define HV_X64_MSR_CRASH_P3		HV_REGISTER_CRASH_P3
> +#define HV_X64_MSR_CRASH_P4		HV_REGISTER_CRASH_P4
> +#define HV_X64_MSR_CRASH_CTL		HV_REGISTER_CRASH_CTL
> +#define HV_X64_MSR_TIME_REF_COUNT	HV_REGISTER_TIME_REF_COUNT
> +#define HV_X64_MSR_REFERENCE_TSC	HV_REGISTER_REFERENCE_TSC
> +
>  /*
>   * Declare the MSR used to setup pages used to communicate with the hypervisor.
>   */
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 29d0414..eba637d1 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -14,41 +14,22 @@ typedef int (*hyperv_fill_flush_list_func)(
>  		struct hv_guest_mapping_flush_list *flush,
>  		void *data);
>  
> -#define hv_init_timer(timer, tick) \
> -	wrmsrl(HV_X64_MSR_STIMER0_COUNT + (2*timer), tick)
> -#define hv_init_timer_config(timer, val) \
> -	wrmsrl(HV_X64_MSR_STIMER0_CONFIG + (2*timer), val)
> -
> -#define hv_get_simp(val) rdmsrl(HV_X64_MSR_SIMP, val)
> -#define hv_set_simp(val) wrmsrl(HV_X64_MSR_SIMP, val)
> -
> -#define hv_get_siefp(val) rdmsrl(HV_X64_MSR_SIEFP, val)
> -#define hv_set_siefp(val) wrmsrl(HV_X64_MSR_SIEFP, val)
> -
> -#define hv_get_synic_state(val) rdmsrl(HV_X64_MSR_SCONTROL, val)
> -#define hv_set_synic_state(val) wrmsrl(HV_X64_MSR_SCONTROL, val)
> +static inline void hv_set_register(unsigned int reg, u64 value)
> +{
> +	wrmsrl(reg, value);
> +}
>  
> -#define hv_get_vp_index(index) rdmsrl(HV_X64_MSR_VP_INDEX, index)
> +static inline u64 hv_get_register(unsigned int reg)
> +{
> +	u64 value;
>  
> -#define hv_signal_eom() wrmsrl(HV_X64_MSR_EOM, 0)
> +	rdmsrl(reg, value);
> +	return value;
> +}
>  
> -#define hv_get_synint_state(int_num, val) \
> -	rdmsrl(HV_X64_MSR_SINT0 + int_num, val)
> -#define hv_set_synint_state(int_num, val) \
> -	wrmsrl(HV_X64_MSR_SINT0 + int_num, val)
>  #define hv_recommend_using_aeoi() \
>  	(!(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED))
>  
> -#define hv_get_crash_ctl(val) \
> -	rdmsrl(HV_X64_MSR_CRASH_CTL, val)
> -
> -#define hv_get_time_ref_count(val) \
> -	rdmsrl(HV_X64_MSR_TIME_REF_COUNT, val)
> -
> -#define hv_get_reference_tsc(val) \
> -	rdmsrl(HV_X64_MSR_REFERENCE_TSC, val)
> -#define hv_set_reference_tsc(val) \
> -	wrmsrl(HV_X64_MSR_REFERENCE_TSC, val)
>  #define hv_set_clocksource_vdso(val) \
>  	((val).vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK)
>  #define hv_enable_vdso_clocksource() \
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index ba04cb3..9425308 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -68,14 +68,14 @@ static int hv_ce_set_next_event(unsigned long delta,
>  
>  	current_tick = hv_read_reference_counter();
>  	current_tick += delta;
> -	hv_init_timer(0, current_tick);
> +	hv_set_register(HV_REGISTER_STIMER0_COUNT, current_tick);
>  	return 0;
>  }
>  
>  static int hv_ce_shutdown(struct clock_event_device *evt)
>  {
> -	hv_init_timer(0, 0);
> -	hv_init_timer_config(0, 0);
> +	hv_set_register(HV_REGISTER_STIMER0_COUNT, 0);
> +	hv_set_register(HV_REGISTER_STIMER0_CONFIG, 0);
>  	if (direct_mode_enabled)
>  		hv_disable_stimer0_percpu_irq(stimer0_irq);
>  
> @@ -105,7 +105,7 @@ static int hv_ce_set_oneshot(struct clock_event_device *evt)
>  		timer_cfg.direct_mode = 0;
>  		timer_cfg.sintx = stimer0_message_sint;
>  	}
> -	hv_init_timer_config(0, timer_cfg.as_uint64);
> +	hv_set_register(HV_REGISTER_STIMER0_CONFIG, timer_cfg.as_uint64);
>  	return 0;
>  }
>  
> @@ -331,7 +331,7 @@ static u64 notrace read_hv_clock_tsc(void)
>  	u64 current_tick = hv_read_tsc_page(hv_get_tsc_page());
>  
>  	if (current_tick == U64_MAX)
> -		hv_get_time_ref_count(current_tick);
> +		current_tick = hv_get_register(HV_REGISTER_TIME_REF_COUNT);
>  
>  	return current_tick;
>  }
> @@ -352,9 +352,9 @@ static void suspend_hv_clock_tsc(struct clocksource *arg)
>  	u64 tsc_msr;
>  
>  	/* Disable the TSC page */
> -	hv_get_reference_tsc(tsc_msr);
> +	tsc_msr = hv_get_register(HV_REGISTER_REFERENCE_TSC);
>  	tsc_msr &= ~BIT_ULL(0);
> -	hv_set_reference_tsc(tsc_msr);
> +	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
>  }
>  
>  
> @@ -364,10 +364,10 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
>  	u64 tsc_msr;
>  
>  	/* Re-enable the TSC page */
> -	hv_get_reference_tsc(tsc_msr);
> +	tsc_msr = hv_get_register(HV_REGISTER_REFERENCE_TSC);
>  	tsc_msr &= GENMASK_ULL(11, 0);
>  	tsc_msr |= BIT_ULL(0) | (u64)phys_addr;
> -	hv_set_reference_tsc(tsc_msr);
> +	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
>  }
>  
>  static int hv_cs_enable(struct clocksource *cs)
> @@ -389,14 +389,12 @@ static int hv_cs_enable(struct clocksource *cs)
>  
>  static u64 notrace read_hv_clock_msr(void)
>  {
> -	u64 current_tick;
>  	/*
>  	 * Read the partition counter to get the current tick count. This count
>  	 * is set to 0 when the partition is created and is incremented in
>  	 * 100 nanosecond units.
>  	 */
> -	hv_get_time_ref_count(current_tick);
> -	return current_tick;
> +	return hv_get_register(HV_REGISTER_TIME_REF_COUNT);
>  }
>  
>  static u64 notrace read_hv_clock_msr_cs(struct clocksource *arg)
> @@ -436,10 +434,10 @@ static bool __init hv_init_tsc_clocksource(void)
>  	 * (which already has at least the low 12 bits set to zero since
>  	 * it is page aligned). Also set the "enable" bit, which is bit 0.
>  	 */
> -	hv_get_reference_tsc(tsc_msr);
> +	tsc_msr = hv_get_register(HV_REGISTER_REFERENCE_TSC);
>  	tsc_msr &= GENMASK_ULL(11, 0);
>  	tsc_msr = tsc_msr | 0x1 | (u64)phys_addr;
> -	hv_set_reference_tsc(tsc_msr);
> +	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
>  
>  	hv_set_clocksource_vdso(hyperv_cs_tsc);
>  	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index cca8d5e..0c1fa69 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -198,34 +198,36 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	union hv_synic_scontrol sctrl;
>  
>  	/* Setup the Synic's message page */
> -	hv_get_simp(simp.as_uint64);
> +	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
>  	simp.simp_enabled = 1;
>  	simp.base_simp_gpa = virt_to_phys(hv_cpu->synic_message_page)
>  		>> HV_HYP_PAGE_SHIFT;
>  
> -	hv_set_simp(simp.as_uint64);
> +	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
>  
>  	/* Setup the Synic's event page */
> -	hv_get_siefp(siefp.as_uint64);
> +	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
>  	siefp.siefp_enabled = 1;
>  	siefp.base_siefp_gpa = virt_to_phys(hv_cpu->synic_event_page)
>  		>> HV_HYP_PAGE_SHIFT;
>  
> -	hv_set_siefp(siefp.as_uint64);
> +	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
>  
>  	/* Setup the shared SINT. */
> -	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
> +	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
> +					VMBUS_MESSAGE_SINT);
>  
>  	shared_sint.vector = hv_get_vector();
>  	shared_sint.masked = false;
>  	shared_sint.auto_eoi = hv_recommend_using_aeoi();
> -	hv_set_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
> +	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
> +				shared_sint.as_uint64);
>  
>  	/* Enable the global synic bit */
> -	hv_get_synic_state(sctrl.as_uint64);
> +	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
>  	sctrl.enable = 1;
>  
> -	hv_set_synic_state(sctrl.as_uint64);
> +	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
>  }
>  
>  int hv_synic_init(unsigned int cpu)
> @@ -247,32 +249,35 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	union hv_synic_siefp siefp;
>  	union hv_synic_scontrol sctrl;
>  
> -	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
> +	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
> +					VMBUS_MESSAGE_SINT);
>  
>  	shared_sint.masked = 1;
>  
>  	/* Need to correctly cleanup in the case of SMP!!! */
>  	/* Disable the interrupt */
> -	hv_set_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
> +	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
> +				shared_sint.as_uint64);
>  
> -	hv_get_simp(simp.as_uint64);
> +	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
>  	simp.simp_enabled = 0;
>  	simp.base_simp_gpa = 0;
>  
> -	hv_set_simp(simp.as_uint64);
> +	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
>  
> -	hv_get_siefp(siefp.as_uint64);
> +	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
>  	siefp.siefp_enabled = 0;
>  	siefp.base_siefp_gpa = 0;
>  
> -	hv_set_siefp(siefp.as_uint64);
> +	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
>  
>  	/* Disable the global synic bit */
> -	hv_get_synic_state(sctrl.as_uint64);
> +	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
>  	sctrl.enable = 0;
> -	hv_set_synic_state(sctrl.as_uint64);
> +	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
>  }
>  
> +
>  int hv_synic_cleanup(unsigned int cpu)
>  {
>  	struct vmbus_channel *channel, *sc;
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 502f8cd..089f165 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1494,7 +1494,7 @@ static int vmbus_bus_init(void)
>  		 * Register for panic kmsg callback only if the right
>  		 * capability is supported by the hypervisor.
>  		 */
> -		hv_get_crash_ctl(hyperv_crash_ctl);
> +		hyperv_crash_ctl = hv_get_register(HV_REGISTER_CRASH_CTL);
>  		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
>  			hv_kmsg_dump_register();
>  
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 762d3ac..10c97a9 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -85,7 +85,7 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
>  		 * possibly deliver another msg from the
>  		 * hypervisor
>  		 */
> -		hv_signal_eom();
> +		hv_set_register(HV_REGISTER_EOM, 0);
>  	}
>  }
>  
> -- 
> 1.8.3.1
> 
