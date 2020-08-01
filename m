Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830C9234F64
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 04:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgHACMw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 22:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgHACMw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 22:12:52 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18B1C06174A;
        Fri, 31 Jul 2020 19:12:51 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id b2so4467091qvp.9;
        Fri, 31 Jul 2020 19:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RcNuzy0I0GlSHPsgjAin26OQE0adxaomHrcIgCRJLsA=;
        b=H0j3lwKVrWTDg9Nj6lVX8E+JSdSgFYHExHD3kQRejF/GSPasrUcW4qwkiqAR9d+N3o
         3GyzgqqDKhtfP/fSUb/csNcwcdH2smwmb06YPDfK2hSusUJWXGtMhqYTvkRkpVDRb5yV
         ceHtuJ7ki2HPQiCs63cDIX7EArJ+qR8ExtFfmrJt3FtGWFVv0l3NZ+PN6x3ZlT3zpBEJ
         szBzA2zc3FwnVv39VVBY1dTUaO6w8TWIoyxvZdq55+HccFDvzp33gDoJp8N9CU8v6r0I
         bDHiBKKIR4HXPxu+G7JWYuTrG/UO/eqb2/uIlG7jq1W47h7QmdVsDuESBeNVsyZH51hK
         MW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RcNuzy0I0GlSHPsgjAin26OQE0adxaomHrcIgCRJLsA=;
        b=MmeBFXNEg1AkrrcuaN/ccA7ktcCmiLuEwEzarwyXynHFSTQv5Q1Dq8bDszN5KkotnC
         Od3uqb5vasz5N2vWWLj7i2T1Y/xadjptqDu5512uYfb6r/706E5Vl9AxY7DsAJXGTpX5
         h0WKWApSIZ68Pl6HSGujKILgHzYSoNkV2racMd2aRXnC3DMxh1dredqzyMqh57N1oQMV
         8IDVq+kE8u1SedDwS1Gp2xcPht+jFJcgwocy9GmPU8+AGAsj9AQF6Z4qbYi19KFUgK9n
         08GiqLKKj8JBMYaJQw+//vMtnUKYW3ZC9dmb/QYN0KoHjGYtvzCSYamBI5I0Y+9yvRkl
         BAqw==
X-Gm-Message-State: AOAM531KgMfPi4HARyuSv8umTEOJseyUOMovwcUfEd9lyWaQfVl476/a
        MSuLa4ER6KGSczt0faM5q6k=
X-Google-Smtp-Source: ABdhPJznGsCyCuOqLliE1x4Zh3NMzH7OELuVpjiOV0wBqMg6k32zgEIVZ6p0HuoA1y4AaRJkh9a7eg==
X-Received: by 2002:ad4:500c:: with SMTP id s12mr6997719qvo.101.1596247971068;
        Fri, 31 Jul 2020 19:12:51 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u42sm14062820qtu.48.2020.07.31.19.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 19:12:50 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 31 Jul 2020 22:12:48 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 29/36] x86/build: Enforce an empty .got.plt section
Message-ID: <20200801021248.GB2700342@rani.riverdale.lan>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-30-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200731230820.1742553-30-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 31, 2020 at 04:08:13PM -0700, Kees Cook wrote:
> The .got.plt section should always be zero (or filled only with the
> linker-generated lazy dispatch entry). Enforce this with an assert and
> mark the section as NOLOAD. This is more sensitive than just blindly
> discarding the section.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/kernel/vmlinux.lds.S | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 0cc035cb15f1..7faffe7414d6 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -414,8 +414,20 @@ SECTIONS
>  	ELF_DETAILS
>  
>  	DISCARDS
> -}
>  
> +	/*
> +	 * Make sure that the .got.plt is either completely empty or it
> +	 * contains only the lazy dispatch entries.
> +	 */
> +	.got.plt (NOLOAD) : { *(.got.plt) }
> +	ASSERT(SIZEOF(.got.plt) == 0 ||
> +#ifdef CONFIG_X86_64
> +	       SIZEOF(.got.plt) == 0x18,
> +#else
> +	       SIZEOF(.got.plt) == 0xc,
> +#endif
> +	       "Unexpected GOT/PLT entries detected!")
> +}
>  
>  #ifdef CONFIG_X86_32
>  /*
> -- 
> 2.25.1
> 

Is this actually needed? vmlinux is a position-dependent executable, and
it doesn't get linked with any shared libraries, so it should never have
a .got or .got.plt at all I think? Does it show up as an orphan without
this?
