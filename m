Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1EF42B850
	for <lists+linux-arch@lfdr.de>; Wed, 13 Oct 2021 09:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbhJMHEY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Oct 2021 03:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238234AbhJMHES (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Oct 2021 03:04:18 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBCFC061753
        for <linux-arch@vger.kernel.org>; Wed, 13 Oct 2021 00:02:14 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id f189so540416pfg.12
        for <linux-arch@vger.kernel.org>; Wed, 13 Oct 2021 00:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QziJyzXzUKzLt0mT/rAcGmhri2bByqLuVs1mVf2Iq0g=;
        b=NwHbNYolt/EJuuhUNh3gFlhBeQ9ofBjeVTMrGlBvl7Dpq4nY5SGQ+7bZVHVSCPSCvz
         N4ue7iEr/SejEm3Z7dmljFY3Ydw+WZXeuot6L8HdKKtMDeoRppIKuFuYaENN6G0icj3X
         75yWvw4ksMlAy3h2kzjPtg6nuTPvWkdSEorqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QziJyzXzUKzLt0mT/rAcGmhri2bByqLuVs1mVf2Iq0g=;
        b=MYHXxJkWpUm/uiaD2I7PvEOZohNVjVJWoH2MHppERl+AbgidoYv3almNuEwKZhsjEl
         ixpvZWg0TqJwehW983elAjdKGtsTmEsOzbTClgp4Y7Il+mXoAuq7bo1uUEA19mZ7j8B4
         U8ehNwtwpabgM72+aGzrcq3rO89qbqey/fMQbw9GeWfmwm3MN/comU1t1R9AzCPf8Kaf
         uysmN04yQulbxwd7tGAAh1RwUpG/qNf4cGYgsfpqN75AYycifsfORLimX3znClA2dr0n
         kYMSvlt2uaZf7v8FOnc+eBGD7xKIUuzPA+IYwO3c+c2SphID0QhU5ttxAGQoHMPdFcLL
         u4FA==
X-Gm-Message-State: AOAM532j2p+AoeoYU3VLZm7c/xfiBhPmYvoc4Y3DfwDs+QuSKMMwlP+t
        aZtG4ZMnbNL6inM+kPlrQWyWBw==
X-Google-Smtp-Source: ABdhPJyWYEWyfQBfcC/0yIP+D80JqXxmyV0v/CWpa3mlnRn6oeLJSgdmS6Po11cAfGz1rlakmHlfMA==
X-Received: by 2002:a63:ed13:: with SMTP id d19mr26247213pgi.430.1634108533970;
        Wed, 13 Oct 2021 00:02:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k14sm7556115pgt.8.2021.10.13.00.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 00:02:13 -0700 (PDT)
Date:   Wed, 13 Oct 2021 00:02:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 06/10] asm-generic: Refactor
 dereference_[kernel]_function_descriptor()
Message-ID: <202110130002.A7C0A86@keescook>
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
 <c215b244a19a07327ec81bf99f3c5f89c68af7b4.1633964380.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c215b244a19a07327ec81bf99f3c5f89c68af7b4.1633964380.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 11, 2021 at 05:25:33PM +0200, Christophe Leroy wrote:
> dereference_function_descriptor() and
> dereference_kernel_function_descriptor() are identical on the
> three architectures implementing them.
> 
> Make it common.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/ia64/include/asm/sections.h    | 19 -------------------
>  arch/parisc/include/asm/sections.h  |  9 ---------
>  arch/parisc/kernel/process.c        | 21 ---------------------
>  arch/powerpc/include/asm/sections.h | 23 -----------------------
>  include/asm-generic/sections.h      | 18 ++++++++++++++++++
>  5 files changed, 18 insertions(+), 72 deletions(-)

A diffstat to love. :)

Reviewed-by: Kees Cook <keescook@chromium.org>


> 
> diff --git a/arch/ia64/include/asm/sections.h b/arch/ia64/include/asm/sections.h
> index 929b5c535620..d9addaea8339 100644
> --- a/arch/ia64/include/asm/sections.h
> +++ b/arch/ia64/include/asm/sections.h
> @@ -30,23 +30,4 @@ extern char __start_gate_brl_fsys_bubble_down_patchlist[], __end_gate_brl_fsys_b
>  extern char __start_unwind[], __end_unwind[];
>  extern char __start_ivt_text[], __end_ivt_text[];
>  
> -#undef dereference_function_descriptor
> -static inline void *dereference_function_descriptor(void *ptr)
> -{
> -	struct fdesc *desc = ptr;
> -	void *p;
> -
> -	if (!get_kernel_nofault(p, (void *)&desc->addr))
> -		ptr = p;
> -	return ptr;
> -}
> -
> -#undef dereference_kernel_function_descriptor
> -static inline void *dereference_kernel_function_descriptor(void *ptr)
> -{
> -	if (ptr < (void *)__start_opd || ptr >= (void *)__end_opd)
> -		return ptr;
> -	return dereference_function_descriptor(ptr);
> -}
> -
>  #endif /* _ASM_IA64_SECTIONS_H */
> diff --git a/arch/parisc/include/asm/sections.h b/arch/parisc/include/asm/sections.h
> index 329e80f7af0a..b041fb32a300 100644
> --- a/arch/parisc/include/asm/sections.h
> +++ b/arch/parisc/include/asm/sections.h
> @@ -12,13 +12,4 @@ typedef Elf64_Fdesc funct_descr_t;
>  
>  extern char __alt_instructions[], __alt_instructions_end[];
>  
> -#ifdef CONFIG_64BIT
> -
> -#undef dereference_function_descriptor
> -void *dereference_function_descriptor(void *);
> -
> -#undef dereference_kernel_function_descriptor
> -void *dereference_kernel_function_descriptor(void *);
> -#endif
> -
>  #endif
> diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
> index 38ec4ae81239..7382576b52a8 100644
> --- a/arch/parisc/kernel/process.c
> +++ b/arch/parisc/kernel/process.c
> @@ -266,27 +266,6 @@ get_wchan(struct task_struct *p)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_64BIT
> -void *dereference_function_descriptor(void *ptr)
> -{
> -	Elf64_Fdesc *desc = ptr;
> -	void *p;
> -
> -	if (!get_kernel_nofault(p, (void *)&desc->addr))
> -		ptr = p;
> -	return ptr;
> -}
> -
> -void *dereference_kernel_function_descriptor(void *ptr)
> -{
> -	if (ptr < (void *)__start_opd ||
> -			ptr >= (void *)__end_opd)
> -		return ptr;
> -
> -	return dereference_function_descriptor(ptr);
> -}
> -#endif
> -
>  static inline unsigned long brk_rnd(void)
>  {
>  	return (get_random_int() & BRK_RND_MASK) << PAGE_SHIFT;
> diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
> index d0d5287fa568..8f8e95f234e2 100644
> --- a/arch/powerpc/include/asm/sections.h
> +++ b/arch/powerpc/include/asm/sections.h
> @@ -72,29 +72,6 @@ static inline int overlaps_kernel_text(unsigned long start, unsigned long end)
>  		(unsigned long)_stext < end;
>  }
>  
> -#ifdef PPC64_ELF_ABI_v1
> -
> -#undef dereference_function_descriptor
> -static inline void *dereference_function_descriptor(void *ptr)
> -{
> -	struct ppc64_opd_entry *desc = ptr;
> -	void *p;
> -
> -	if (!get_kernel_nofault(p, (void *)&desc->addr))
> -		ptr = p;
> -	return ptr;
> -}
> -
> -#undef dereference_kernel_function_descriptor
> -static inline void *dereference_kernel_function_descriptor(void *ptr)
> -{
> -	if (ptr < (void *)__start_opd || ptr >= (void *)__end_opd)
> -		return ptr;
> -
> -	return dereference_function_descriptor(ptr);
> -}
> -#endif /* PPC64_ELF_ABI_v1 */
> -
>  #endif
>  
>  #endif /* __KERNEL__ */
> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
> index 436412d94054..5baaf9d7c671 100644
> --- a/include/asm-generic/sections.h
> +++ b/include/asm-generic/sections.h
> @@ -60,6 +60,24 @@ extern __visible const void __nosave_begin, __nosave_end;
>  
>  /* Function descriptor handling (if any).  Override in asm/sections.h */
>  #ifdef HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR
> +static inline void *dereference_function_descriptor(void *ptr)
> +{
> +	funct_descr_t *desc = ptr;
> +	void *p;
> +
> +	if (!get_kernel_nofault(p, (void *)&desc->addr))
> +		ptr = p;
> +	return ptr;
> +}
> +
> +static inline void *dereference_kernel_function_descriptor(void *ptr)
> +{
> +	if (ptr < (void *)__start_opd || ptr >= (void *)__end_opd)
> +		return ptr;
> +
> +	return dereference_function_descriptor(ptr);
> +}
> +
>  #else
>  #define dereference_function_descriptor(p) ((void *)(p))
>  #define dereference_kernel_function_descriptor(p) ((void *)(p))
> -- 
> 2.31.1
> 

-- 
Kees Cook
