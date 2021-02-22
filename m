Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D97320FA4
	for <lists+linux-arch@lfdr.de>; Mon, 22 Feb 2021 04:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhBVDGD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Feb 2021 22:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhBVDF6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Feb 2021 22:05:58 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD92C061574;
        Sun, 21 Feb 2021 19:05:12 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id z190so11350127qka.9;
        Sun, 21 Feb 2021 19:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0D9mD/xMW7uHuVkt5hoctYAY2++kuAyvpP1HG14eNxg=;
        b=jeyKjAGy/SlW1CQcuAj3FNvo3BuBQBfEKFRQbvG+edMSwCvJK4lCZ6vD1j2fvIWI2m
         QZVl1GSEsFJs7EYf43qySdYjEA+IXV7zKrTz0+Zr8y8NQrNZp/+OXQ2xk/6cy5nBxIiH
         i/S8LJDjQsj3AToPeQAi2geRFQ00qrzWtEfbVaVadm+50SrCUy+fh/Pd82tAKYpQ8V1V
         54/fm8NTxCx1JpAKwr+ZRXFqhkjNhp5jqALX1iVXgJRrszvhYQ5hnm+wHR1VLDI7xnUM
         TEx81l3lnhP/9P1+9vcCZ4k2w/PE9dG/b3u45omsoL68B/4KLT/JXK9Bu0gcmgk9kZw9
         VNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0D9mD/xMW7uHuVkt5hoctYAY2++kuAyvpP1HG14eNxg=;
        b=jLpmPnKcPfWFqxgTmyKN/STgJ8pUw3rrOnP85LJbRE6trca6xIn4P/iMrfzlvV31a3
         0oW/qE/xePAMqmNLg40eQmKSJZOeNtEcZF7dzUnKgfLPpDq/u45S5H8cAyiijZwN52lw
         /o8kRaAVzZ7IMEFCB64Lg3e4r/R9k8l71gPaxW9mN++p2ZHnf49TKVBGHJZALknWSUNu
         EmWX+haiFMlVubYOovLS0WR4ZBbDJ4jSf5fBd8W/um9/1gXL+2bg4fM7vMq0BshfrKNx
         KytKkUM4zqqgW6BcK3sfcktjUc2vepTL2wdoJabBF9/I57/LhmcNGyUAS/XVyxGKkMhb
         aQaw==
X-Gm-Message-State: AOAM530SaQVYbuW5WSKTEbhYT+51zkuekOwBg5J9+JiOh1DsimhaBkiU
        NfeXuxX8porUK01MO4yqQGA=
X-Google-Smtp-Source: ABdhPJwdikDdv3u6NgPXlV/hu73yb5LrWPaFVWz30FBqP40mtIUVqCG4NuF4GWgMe1Gg3oASZ/KHLQ==
X-Received: by 2002:a05:620a:10aa:: with SMTP id h10mr19684899qkk.53.1613963111981;
        Sun, 21 Feb 2021 19:05:11 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id t71sm11337447qka.86.2021.02.21.19.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 19:05:11 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id A30BA27C0054;
        Sun, 21 Feb 2021 22:05:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 21 Feb 2021 22:05:10 -0500
X-ME-Sender: <xms:YB8zYOO3yvk558BkxNrHeCu5gVAX6Yd5Ohaj_MB85_3KIdla6vcRVg>
    <xme:YB8zYM9ZwCPdGmkavvvmNsfa6d0KzTgUwFP9O20VbV3NfRz79MEeDccbmknrowBk8
    ltDwcQEeczHk8W94g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkedvgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucfkphepudefuddruddtjedrudegjedruddvieenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:YB8zYFSPyk0RlHqFllsIelihx0GmPC4n6ks75nSQ9283PYqSdbewwg>
    <xmx:YB8zYOvqV1owCiiXRZHKC_yaqQwOBlYbCG0jO8qTDO92WSNdk_HiQw>
    <xmx:YB8zYGfsZQseCZoT42gvQ4UkPttmp5GxIz-xJvRU74TIz52Ciy_xGQ>
    <xmx:YR8zYM1SfZGX6ri0fNso0_H9PF_oxSSKgORQ2GYkjvxPSmUpt08o0cznsgU>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7DDC81080063;
        Sun, 21 Feb 2021 22:05:04 -0500 (EST)
Date:   Mon, 22 Feb 2021 11:04:32 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 01/10] Drivers: hv: vmbus: Move Hyper-V page allocator to
 arch neutral code
Message-ID: <YDMfQEHuU7yVqsEz@boqun-archlinux>
References: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
 <1611779025-21503-2-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611779025-21503-2-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 27, 2021 at 12:23:36PM -0800, Michael Kelley wrote:
> The Hyper-V page allocator functions are implemented in an architecture
> neutral way.  Move them into the architecture neutral VMbus module so
> a separate implementation for ARM64 is not needed.
> 
> No functional change.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  arch/x86/hyperv/hv_init.c       | 22 ----------------------
>  arch/x86/include/asm/mshyperv.h |  5 -----
>  drivers/hv/hv.c                 | 36 ++++++++++++++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h  |  4 ++++
>  4 files changed, 40 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index e04d90a..2d1688e 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -44,28 +44,6 @@
>  u32 hv_max_vp_index;
>  EXPORT_SYMBOL_GPL(hv_max_vp_index);
>  
> -void *hv_alloc_hyperv_page(void)
> -{
> -	BUILD_BUG_ON(PAGE_SIZE != HV_HYP_PAGE_SIZE);
> -
> -	return (void *)__get_free_page(GFP_KERNEL);
> -}
> -EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
> -
> -void *hv_alloc_hyperv_zeroed_page(void)
> -{
> -        BUILD_BUG_ON(PAGE_SIZE != HV_HYP_PAGE_SIZE);
> -
> -        return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> -}
> -EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
> -
> -void hv_free_hyperv_page(unsigned long addr)
> -{
> -	free_page(addr);
> -}
> -EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
> -
>  static int hv_cpu_init(unsigned int cpu)
>  {
>  	u64 msr_vp_index;
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index ffc2899..29d0414 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -224,9 +224,6 @@ static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
>  
>  void __init hyperv_init(void);
>  void hyperv_setup_mmu_ops(void);
> -void *hv_alloc_hyperv_page(void);
> -void *hv_alloc_hyperv_zeroed_page(void);
> -void hv_free_hyperv_page(unsigned long addr);
>  void set_hv_tscchange_cb(void (*cb)(void));
>  void clear_hv_tscchange_cb(void);
>  void hyperv_stop_tsc_emulation(void);
> @@ -255,8 +252,6 @@ static inline void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
>  #else /* CONFIG_HYPERV */
>  static inline void hyperv_init(void) {}
>  static inline void hyperv_setup_mmu_ops(void) {}
> -static inline void *hv_alloc_hyperv_page(void) { return NULL; }
> -static inline void hv_free_hyperv_page(unsigned long addr) {}
>  static inline void set_hv_tscchange_cb(void (*cb)(void)) {}
>  static inline void clear_hv_tscchange_cb(void) {}
>  static inline void hyperv_stop_tsc_emulation(void) {};
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index f202ac7..cca8d5e 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -37,6 +37,42 @@ int hv_init(void)
>  }
>  
>  /*
> + * Functions for allocating and freeing memory with size and
> + * alignment HV_HYP_PAGE_SIZE. These functions are needed because
> + * the guest page size may not be the same as the Hyper-V page
> + * size. We depend upon kmalloc() aligning power-of-two size
> + * allocations to the allocation size boundary, so that the
> + * allocated memory appears to Hyper-V as a page of the size
> + * it expects.
> + */
> +
> +void *hv_alloc_hyperv_page(void)
> +{
> +	BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
> +
> +	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
> +		return (void *)__get_free_page(GFP_KERNEL);
> +	else
> +		return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> +}
> +
> +void *hv_alloc_hyperv_zeroed_page(void)
> +{
> +	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
> +		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> +	else
> +		return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> +}
> +
> +void hv_free_hyperv_page(unsigned long addr)
> +{
> +	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
> +		free_page(addr);
> +	else
> +		kfree((void *)addr);
> +}
> +
> +/*
>   * hv_post_message - Post a message using the hypervisor message IPC.
>   *
>   * This involves a hypercall.
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index c577996..762d3ac 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -114,6 +114,10 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
>  /* Sentinel value for an uninitialized entry in hv_vp_index array */
>  #define VP_INVAL	U32_MAX
>  
> +void *hv_alloc_hyperv_page(void);
> +void *hv_alloc_hyperv_zeroed_page(void);
> +void hv_free_hyperv_page(unsigned long addr);
> +
>  /**
>   * hv_cpu_number_to_vp_number() - Map CPU to VP.
>   * @cpu_number: CPU number in Linux terms
> -- 
> 1.8.3.1
> 
