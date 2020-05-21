Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AFF1DD5BC
	for <lists+linux-arch@lfdr.de>; Thu, 21 May 2020 20:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgEUSLX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 May 2020 14:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgEUSLW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 May 2020 14:11:22 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93D5C061A0F
        for <linux-arch@vger.kernel.org>; Thu, 21 May 2020 11:11:21 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m7so3156902plt.5
        for <linux-arch@vger.kernel.org>; Thu, 21 May 2020 11:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QnbqNy9EV06MW5CdU8p7rG6H8xARB4MCiMEyZtqlPZY=;
        b=g/kstoEF7jBH50MDuXScB/Wy07PeKyWkq6ndhA3tjBPgWJ0fihAAPJUK0c+ShkSt/7
         wNJiwUfFT3bKmn3+xX8i8/Aqrw/2AHceGXIuENBN9r3NnYy7oCRDmrpBRbLHh6v6yWO8
         bVxXeURBoZhPWu0Orftx1teKFHlJomMID6Lbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QnbqNy9EV06MW5CdU8p7rG6H8xARB4MCiMEyZtqlPZY=;
        b=NOadgonB62Qd2yDlp36x9q8p6D0JdjQQPEOqLAgX9MfFnQQgrxxFgtVKE2SNhKLcGU
         4ZQj+mQg1W3Kfu41zHtz+enWiCnx/1O1hVDYZvu/2ZKNeMH/eavsPpEl+oYMvTzwdReR
         i7RUbgz5KdsoHnPzddVQms5yhQ7FJ6U0vVwrJ9qlz0dE4n6JfWv1DkAFNjyR8Tgdg+bl
         oXc6Txy2C6kpZ9oIJl2JTQTt7fTIUgcrPX55ZXnWbi9947Vy5LSO908IoYAR6nm0cBxt
         UJEtOJfB9lE3i99uMOQDLr00WgMw94eSK0CCxDOxDXbnHsAhUF1Z39Cc81QibQUAL0/2
         apsQ==
X-Gm-Message-State: AOAM530rK7AXxKPIdnmqdsRVKX63w1qfy+j8n2iCi1Z34ikMFh0mI5gg
        bkwCyfSWgqBE5TXJMvH3yu40HA==
X-Google-Smtp-Source: ABdhPJy113rjg4c4EN6iCv8PasCClmRYQtUFgwcjDCT+6DDqbtZLHo/8b4GBbIQvhAQar9rQTc/TEw==
X-Received: by 2002:a17:902:bf43:: with SMTP id u3mr10554884pls.240.1590084681259;
        Thu, 21 May 2020 11:11:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v1sm4969026pjn.9.2020.05.21.11.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 11:11:20 -0700 (PDT)
Date:   Thu, 21 May 2020 11:11:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com,
        Tony Luck <tony.luck@intel.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 5/9] x86: Make sure _etext includes function sections
Message-ID: <202005211109.4EE4DCBA3@keescook>
References: <20200521165641.15940-1-kristen@linux.intel.com>
 <20200521165641.15940-6-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521165641.15940-6-kristen@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 21, 2020 at 09:56:36AM -0700, Kristen Carlson Accardi wrote:
> When using -ffunction-sections to place each function in
> it's own text section so it can be randomized at load time, the
> linker considers these .text.* sections "orphaned sections", and
> will place them after the first similar section (.text). In order
> to accurately represent the end of the text section and the
> orphaned sections, _etext must be moved so that it is after both
> .text and .text.* The text size must also be calculated to
> include .text AND .text.*
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/vmlinux.lds.S     | 18 +++++++++++++++++-
>  include/asm-generic/vmlinux.lds.h |  2 +-
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 1bf7e312361f..044f7528a2f0 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -147,8 +147,24 @@ SECTIONS
>  #endif
>  	} :text =0xcccc
>  
> -	/* End of text section, which should occupy whole number of pages */
> +#ifdef CONFIG_FG_KASLR
> +	/*
> +	 * -ffunction-sections creates .text.* sections, which are considered
> +	 * "orphan sections" and added after the first similar section (.text).
> +	 * Adding this ALIGN statement causes the address of _etext
> +	 * to be below that of all the .text.* orphaned sections
> +	 */
> +	. = ALIGN(PAGE_SIZE);
> +#endif
>  	_etext = .;
> +
> +	/*
> +	 * the size of the .text section is used to calculate the address
> +	 * range for orc lookups. If we just use SIZEOF(.text), we will
> +	 * miss all the .text.* sections. Calculate the size using _etext
> +	 * and _stext and save the value for later.
> +	 */
> +	text_size = _etext - _stext;
>  	. = ALIGN(PAGE_SIZE);

I don't think there's any need for this #ifdef (nor the trailing ALIGN).
I think leave the comment to explain why the ALIGN is being moved before
the _etext.

A repeated ALIGN won't move the position:

--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -147,9 +147,11 @@ SECTIONS
 #endif
        } :text =0xcccc
 
+       . = ALIGN(PAGE_SIZE);
        /* End of text section, which should occupy whole number of * pages */
        _etext = .;
        . = ALIGN(PAGE_SIZE);
+       _ktext = .;
 
        X86_ALIGN_RODATA_BEGIN
        RO_DATA(PAGE_SIZE)


$ nm vmlinux | grep '_[ek]text'
ffffffff81e02000 R _etext
ffffffff81e02000 R _ktext

-- 
Kees Cook
