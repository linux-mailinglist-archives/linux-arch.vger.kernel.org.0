Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBBB320FC4
	for <lists+linux-arch@lfdr.de>; Mon, 22 Feb 2021 04:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhBVDbi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Feb 2021 22:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhBVDbd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Feb 2021 22:31:33 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A378DC061574;
        Sun, 21 Feb 2021 19:30:53 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id q9so1622818qvo.8;
        Sun, 21 Feb 2021 19:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uA+m8NZNWmXsGFEB/EalT7miEM7TlkoAJOSMtgOtTM4=;
        b=Mbxm/NRo6mFO2oP+NSJQWuq+sGddW3OzqXzTTEPENzyKygIQOTtH03PPSfYldJ0lRB
         xmK36sJIw2e3UNg7j8cGyohUEY77xWgj0KMLBeAGCmTEyQ7kFIpcmUHByZoM4rA6dwaL
         2cpHl0DNChhg8g3GXF4DKS6XjqQVmEXcpz0tXXaUMfCYPFmecWyvFqreA/h0SKwGtg8L
         EwKloaPJI0H4BdNa/mm3PD99As0CvGfbTJLJkMSTMfxwo0kCMr+V7Cc5qR0vWkpdyhVD
         nKHt86ERQhh916J4x4JNzoxikxBOlAbJ1J7LZEJajZRfZjCJvwfM+5XDta1uvSV45jI1
         bQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uA+m8NZNWmXsGFEB/EalT7miEM7TlkoAJOSMtgOtTM4=;
        b=sAV2no7qnDSxdS0Z6mcvB4IoB9RAeDZa6BoTYSXSdBTCgOz2QimEJEdfbgib/Y2mSB
         rh6fuMJWFlpAcrTgleniY3SBD9mfUSyCJE8ATrt0D2ievwF1Bjn29ZLNPrhJNhoCk8h4
         oWYQiQHVXOLJAugrMfhRArFT9wmROg2UfeutYf3yF1ode1qcDUeEMmOzWA949DnQIfPA
         Q/l0qFnYbKFL1Tmq84j77yFy+gFcujad7pBAAu4gimicQSymcgVIQZndQeSOCuCM+Rav
         MAPrhXlsdmin1t4ypp8fjhbxpTbZAyuQjiuPK2TeQTr99Dw0XuMLSWaFHKEG9gU+v2/D
         aZmA==
X-Gm-Message-State: AOAM531C1EjI2lozkpxmVXLdsV//AnbsZcRkRqllLaoXuls60f3ItHsE
        52TkGarr0Qb7IILQ0K4heKk=
X-Google-Smtp-Source: ABdhPJwsU2KjbRmtztXiYx5K9ee4nXH8TenYbLNp0cWOsHAU/l58MTsNDgBMm2yt/GPcJ2177stbUw==
X-Received: by 2002:ad4:52c2:: with SMTP id p2mr19027375qvs.39.1613964652954;
        Sun, 21 Feb 2021 19:30:52 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id j20sm2224918qtl.36.2021.02.21.19.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 19:30:52 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0750A27C0054;
        Sun, 21 Feb 2021 22:30:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 21 Feb 2021 22:30:52 -0500
X-ME-Sender: <xms:ayUzYDmc_1xJevj2wuWK3678MXFyFGwpbnAAPPfC7AxyNIMIWYPGUQ>
    <xme:ayUzYG3Wsvk_CyYsanw3zIRRlxX5ao4O-woVIVR3nBnM7AzQu1NEmVuImqFVG7834
    PbyFN2DSD2pBRTnvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkedvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucfkphepudefuddruddtjedrudegjedruddvieenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ayUzYJqSpycvnzTxxBv1eGV3ZAWOWByse2nBg5AEzN6csc4a3ukHpA>
    <xmx:ayUzYLkz62YPsJD482otL9qKqbuLwupvbgoag8-jX0hVG9aPlY8a0w>
    <xmx:ayUzYB0AbXsTgx7Z6yFBGp6tNVZzvUE8Mtcny8YsRgrtcoLHC0-Gyw>
    <xmx:bCUzYPM5ETocTXHp9hdwDu0Wo-7u7KDywPbUTjdI4AEQeTdH82QEC990pW4>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 739DF108005C;
        Sun, 21 Feb 2021 22:30:51 -0500 (EST)
Date:   Mon, 22 Feb 2021 11:30:19 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 05/10] Drivers: hv: vmbus: Handle auto EOI quirk inline
Message-ID: <YDMlS+Dnid6VwZJN@boqun-archlinux>
References: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
 <1611779025-21503-6-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611779025-21503-6-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 27, 2021 at 12:23:40PM -0800, Michael Kelley wrote:
> On x86/x64, Hyper-V provides a flag to indicate auto EOI functionality,
> but it doesn't on ARM64. Handle this quirk inline instead of calling
> into code under arch/x86 (and coming, under arch/arm64).
> 
> No functional change.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  arch/x86/include/asm/mshyperv.h |  3 ---
>  drivers/hv/hv.c                 | 12 +++++++++++-
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index eba637d1..d12a188 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -27,9 +27,6 @@ static inline u64 hv_get_register(unsigned int reg)
>  	return value;
>  }
>  
> -#define hv_recommend_using_aeoi() \
> -	(!(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED))
> -
>  #define hv_set_clocksource_vdso(val) \
>  	((val).vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK)
>  #define hv_enable_vdso_clocksource() \
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 0c1fa69..afe7a62 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -219,7 +219,17 @@ void hv_synic_enable_regs(unsigned int cpu)
>  
>  	shared_sint.vector = hv_get_vector();
>  	shared_sint.masked = false;
> -	shared_sint.auto_eoi = hv_recommend_using_aeoi();
> +
> +	/*
> +	 * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
> +	 * it doesn't provide a recommendation flag and AEOI must be disabled.
> +	 */
> +#ifdef HV_DEPRECATING_AEOI_RECOMMENDED
> +	shared_sint.auto_eoi =
> +			!(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED);
> +#else
> +	shared_sint.auto_eoi = 0;
> +#endif
>  	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
>  				shared_sint.as_uint64);
>  
> -- 
> 1.8.3.1
> 
