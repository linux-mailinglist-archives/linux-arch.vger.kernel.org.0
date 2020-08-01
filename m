Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D877234F52
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 03:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgHABr7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 21:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgHABr7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 21:47:59 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEE5C06174A;
        Fri, 31 Jul 2020 18:47:59 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x69so30662244qkb.1;
        Fri, 31 Jul 2020 18:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DfgKTVMFpic0lvlFw/heJsrWIE3jTqCxvCbC4XpQbAk=;
        b=rweOnJ01nmAYHvLiHAsMtHB4+7hGTuaJgfJNv4cNQR23MLI6XWzYJm998XxMdchzjb
         XP4uBBQ5hwdPxd6HssESos6Ze2840JD+nBoiNC1+o6lDoNSW1crF6SQerJ0gxEdFCuLG
         LH7QCe3A1iy1DnieHTPYK9cI7zjJPIfI2QGcedKZHgo5MPVbSs8LdkHi+57rF6ZYYnaQ
         gVj6YGiUijeqhq0UUv6/w4xWUaTZctRZMRrItn2ELY5/fdRCXk3ectjVDoZxiNeGJ1hG
         2qyBdH7NzqeWpPTNaPbRmxqcasJlNT8Bb+rJr04NECEWL5n1970lqzlt/DWOLOWSsARa
         mF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=DfgKTVMFpic0lvlFw/heJsrWIE3jTqCxvCbC4XpQbAk=;
        b=Bc/58wkr8DjVghcyxvgsBD84cBNxkxthf2XHUcq1MXnjltWjsOrWfbqXvkwF/hetS6
         IAtVU3ALP5555VxYlh8Sv3Or+DGVy0N93YKyPJb4EtSNJVaicEUdXHnmCsfAuhmb63jT
         hjvREU/QECyCR6kRRMyRi4ADpHBgBMKytx0SZ7ruGHg2TVY5Dnx3I2PEaXOU9uycnZ18
         ZKHUstnEIbLdNMU95eV55qYI+50eAHqWUEFJIhfhffBFvwL3RANJcHgbVZZkKMMtz+o5
         YntkquouBiSycxDGNwvwG+t17cvNk4BifPQ/yXbVWxX8EnSViAH87jOh4Ti7RrhOFaHD
         W0HQ==
X-Gm-Message-State: AOAM532ZvgCNyMaTo/YpjIM3eN7U+kasPU7d+o9iRHVHP2njmEcpcqaa
        ugNxR60W9a2vfNvcAYOcjjg=
X-Google-Smtp-Source: ABdhPJxliEC7tkuTaMnDy7cW9516HhJz7m8xvAVOsPuOEMr9SnyUOcCZu77gHA7uT4OL8j3TRvlNSQ==
X-Received: by 2002:a37:62d4:: with SMTP id w203mr6547799qkb.463.1596246478260;
        Fri, 31 Jul 2020 18:47:58 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o37sm12377089qte.9.2020.07.31.18.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 18:47:57 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 31 Jul 2020 21:47:55 -0400
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
Subject: Re: [PATCH v5 32/36] x86/boot/compressed: Reorganize zero-size
 section asserts
Message-ID: <20200801014755.GA2700342@rani.riverdale.lan>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-33-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200731230820.1742553-33-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 31, 2020 at 04:08:16PM -0700, Kees Cook wrote:
> For readability, move the zero-sized sections to the end after DISCARDS
> and mark them NOLOAD for good measure.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/boot/compressed/vmlinux.lds.S | 42 +++++++++++++++-----------
>  1 file changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 3c2ee9a5bf43..42dea70a5091 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -42,18 +42,16 @@ SECTIONS
>  		*(.rodata.*)
>  		_erodata = . ;
>  	}
> -	.rel.dyn : {
> -		*(.rel.*)
> -	}
> -	.rela.dyn : {
> -		*(.rela.*)
> -	}
> -	.got : {
> -		*(.got)
> -	}
>  	.got.plt : {
>  		*(.got.plt)
>  	}
> +	ASSERT(SIZEOF(.got.plt) == 0 ||
> +#ifdef CONFIG_X86_64
> +	       SIZEOF(.got.plt) == 0x18,
> +#else
> +	       SIZEOF(.got.plt) == 0xc,
> +#endif
> +	       "Unexpected GOT/PLT entries detected!")
>  
>  	.data :	{
>  		_data = . ;
> @@ -85,13 +83,23 @@ SECTIONS
>  	ELF_DETAILS
>  
>  	DISCARDS
> -}
>  
> -ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
> -#ifdef CONFIG_X86_64
> -ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
> -#else
> -ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
> -#endif
> +	/*
> +	 * Sections that should stay zero sized, which is safer to
> +	 * explicitly check instead of blindly discarding.
> +	 */
> +	.got (NOLOAD) : {
> +		*(.got)
> +	}
> +	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
>  
> -ASSERT(SIZEOF(.rel.dyn) == 0 && SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations detected!")
> +	/* ld.lld does not like .rel* sections being made "NOLOAD". */
> +	.rel.dyn : {
> +		*(.rel.*)
> +	}
> +	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
> +	.rela.dyn : {
> +		*(.rela.*)
> +	}
> +	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
> +}
> -- 
> 2.25.1
> 

There's no point in marking zero-size sections NOLOAD -- if the ASSERT's
passed, they won't be present in the file at all anyway.

The only section for which there might be a point is .got.plt, which is
non-empty on 32-bit, and only if it is first moved to the end. That
saves a few bytes.
