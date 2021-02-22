Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6312A320FBE
	for <lists+linux-arch@lfdr.de>; Mon, 22 Feb 2021 04:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhBVD2U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Feb 2021 22:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhBVD2U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Feb 2021 22:28:20 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5644CC061574;
        Sun, 21 Feb 2021 19:27:34 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 2so5498539qvd.0;
        Sun, 21 Feb 2021 19:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mbD8hy9Yy3C6SJqlClP5sesBWnkhT/EtrY5hBmv5k5U=;
        b=BVK0gJsPDQ0o7t/USDBP172E6JLHTpNgdxMLXVuXF/IaH1P+Rw8VktFzl5N4inlZ7U
         XHw0K+H+/LV76LETngAix65NhegnvgdkIgME5K/FZ3CbVX4hQWa1OplE5F2IhcuUjtin
         1o16GdBRapfHYlGjISzJkCRV50HMqJMOy6AZH1cKmhsxD/i9eJUQF4KtnZqXYbZdYTDU
         zCP67m1+o2rgUYqUkiRrVCxvbaZ3/Z3Kj3y7nc2W9cZyQLByc+hanp/cFSuzPXtzFT+L
         MJtfpiXXi3TGXgWm10tgX9FuNv1SCVDkIxE2k2kWFjDeUFB2MPEj++Ks99UUrIWUTnjP
         u0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mbD8hy9Yy3C6SJqlClP5sesBWnkhT/EtrY5hBmv5k5U=;
        b=FW4Lc03PEa8oSChndFUJy5NV+ggt7i+7LRf79/EvflbfTSpWwX358EmWPbcoPFAZ4a
         r2bGM8ttW5RlHDyMaf7GbaqRCkKwIgINnhc76y+9xI2Vc5IrWGg53eiqANPuHv300mPr
         e79GCyaxUhpH7ItOCKi+P0LbuteyoweCHGKY88suJ3AoqPMXAN1/aJHE3MOsgXx0AMZx
         mxNyOWqhn2/lm8mksl86mRhEzwvpp77DM8/BIVzAzNd6gL9mrdOhp/qJyLboisd6vGDZ
         fZJUQiug8vKjFR7h6BWmGRMrlUL84s37ffG6Qfet2q2R8m3ERJd+YSfnHCcLur6tKEzS
         LHHA==
X-Gm-Message-State: AOAM530IAUhxqmfEEOErIU5MTt9XMq9dw5U9nbQ7QUvNaHGXImYQb31/
        iJpi083fGhe3p3pTZW0qbW4=
X-Google-Smtp-Source: ABdhPJzEWCdeUUhjRd7lDL8GpEZ2ElEay14skTBihcQi7VoYU/YGIenSJ1299MCgUKfSKSE8UOW8Ew==
X-Received: by 2002:a0c:90ae:: with SMTP id p43mr19150256qvp.47.1613964453592;
        Sun, 21 Feb 2021 19:27:33 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id t6sm11398274qkd.127.2021.02.21.19.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 19:27:33 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id AE38F27C0054;
        Sun, 21 Feb 2021 22:27:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 21 Feb 2021 22:27:32 -0500
X-ME-Sender: <xms:pCQzYK4LU77zfxF4fnlrkgXlDSevOvkJNSkNWf400xtXJGyPN8Bhmw>
    <xme:pCQzYD5pOJYihStlwLjyDF2iQSI360uRqGuetrBTUNuUVu-jjry3TR5f_BiYH8CvW
    8BT3MEGx4mUBg3AVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkedvgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucfkphepudefuddruddtjedrudegjedruddvieenucevlhhushhtvghrufhiiigvpe
    dunecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:pCQzYJfbGmWdnYWArb-ZzlUeU-1ip9IEL_9_wBVKRWyoFOTEp084ng>
    <xmx:pCQzYHKV0NPbKoHBScYGfX-87wiOnywUg6F0ClWME2XeWqDONmV_tg>
    <xmx:pCQzYOLRb3OJ9DpPXU0s_DqLrbZpQDO66sjqI31dykc4SnpqoD8_uA>
    <xmx:pCQzYACDFXh7oeuXpJOxlRHd_oMZ_NRrrk1DdRn0-FDRWsQ0o9TXkyixeN0>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5118C1080063;
        Sun, 21 Feb 2021 22:27:32 -0500 (EST)
Date:   Mon, 22 Feb 2021 11:27:00 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 04/10] Drivers: hv: vmbus: Move hyperv_report_panic_msg
 to arch neutral code
Message-ID: <YDMkhCYDNvZmVR2u@boqun-archlinux>
References: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
 <1611779025-21503-5-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611779025-21503-5-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 27, 2021 at 12:23:39PM -0800, Michael Kelley wrote:
> With the new Hyper-V MSR set function, hyperv_report_panic_msg() can be
> architecture neutral, so move it out from under arch/x86 and merge into
> hv_kmsg_dump(). This move also avoids needing a separate implementation
> under arch/arm64.
> 
> No functional change.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  arch/x86/hyperv/hv_init.c      | 27 ---------------------------
>  drivers/hv/vmbus_drv.c         | 24 +++++++++++++++++++-----
>  include/asm-generic/mshyperv.h |  1 -
>  3 files changed, 19 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 9b2cdbe..22e9557 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -452,33 +452,6 @@ void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
>  }
>  EXPORT_SYMBOL_GPL(hyperv_report_panic);
>  
> -/**
> - * hyperv_report_panic_msg - report panic message to Hyper-V
> - * @pa: physical address of the panic page containing the message
> - * @size: size of the message in the page
> - */
> -void hyperv_report_panic_msg(phys_addr_t pa, size_t size)
> -{
> -	/*
> -	 * P3 to contain the physical address of the panic page & P4 to
> -	 * contain the size of the panic data in that page. Rest of the
> -	 * registers are no-op when the NOTIFY_MSG flag is set.
> -	 */
> -	wrmsrl(HV_X64_MSR_CRASH_P0, 0);
> -	wrmsrl(HV_X64_MSR_CRASH_P1, 0);
> -	wrmsrl(HV_X64_MSR_CRASH_P2, 0);
> -	wrmsrl(HV_X64_MSR_CRASH_P3, pa);
> -	wrmsrl(HV_X64_MSR_CRASH_P4, size);
> -
> -	/*
> -	 * Let Hyper-V know there is crash data available along with
> -	 * the panic message.
> -	 */
> -	wrmsrl(HV_X64_MSR_CRASH_CTL,
> -	       (HV_CRASH_CTL_CRASH_NOTIFY | HV_CRASH_CTL_CRASH_NOTIFY_MSG));
> -}
> -EXPORT_SYMBOL_GPL(hyperv_report_panic_msg);
> -
>  bool hv_is_hyperv_initialized(void)
>  {
>  	union hv_x64_msr_hypercall_contents hypercall_msr;
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 089f165..8affe68 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1365,22 +1365,36 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
>  			 enum kmsg_dump_reason reason)
>  {
>  	size_t bytes_written;
> -	phys_addr_t panic_pa;
>  
>  	/* We are only interested in panics. */
>  	if ((reason != KMSG_DUMP_PANIC) || (!sysctl_record_panic_msg))
>  		return;
>  
> -	panic_pa = virt_to_phys(hv_panic_page);
> -
>  	/*
>  	 * Write dump contents to the page. No need to synchronize; panic should
>  	 * be single-threaded.
>  	 */
>  	kmsg_dump_get_buffer(dumper, false, hv_panic_page, HV_HYP_PAGE_SIZE,
>  			     &bytes_written);
> -	if (bytes_written)
> -		hyperv_report_panic_msg(panic_pa, bytes_written);
> +	if (!bytes_written)
> +		return;
> +	/*
> +	 * P3 to contain the physical address of the panic page & P4 to
> +	 * contain the size of the panic data in that page. Rest of the
> +	 * registers are no-op when the NOTIFY_MSG flag is set.
> +	 */
> +	hv_set_register(HV_REGISTER_CRASH_P0, 0);
> +	hv_set_register(HV_REGISTER_CRASH_P1, 0);
> +	hv_set_register(HV_REGISTER_CRASH_P2, 0);
> +	hv_set_register(HV_REGISTER_CRASH_P3, virt_to_phys(hv_panic_page));
> +	hv_set_register(HV_REGISTER_CRASH_P4, bytes_written);
> +
> +	/*
> +	 * Let Hyper-V know there is crash data available along with
> +	 * the panic message.
> +	 */
> +	hv_set_register(HV_REGISTER_CRASH_CTL,
> +	       (HV_CRASH_CTL_CRASH_NOTIFY | HV_CRASH_CTL_CRASH_NOTIFY_MSG));
>  }
>  
>  static struct kmsg_dumper hv_kmsg_dumper = {
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 10c97a9..6a8072f 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -170,7 +170,6 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
>  }
>  
>  void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
> -void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
>  bool hv_is_hyperv_initialized(void);
>  bool hv_is_hibernation_supported(void);
>  void hyperv_cleanup(void);
> -- 
> 1.8.3.1
> 
