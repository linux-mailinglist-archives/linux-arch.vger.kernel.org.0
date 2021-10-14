Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD0042E40F
	for <lists+linux-arch@lfdr.de>; Fri, 15 Oct 2021 00:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhJNWTn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 18:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhJNWTm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Oct 2021 18:19:42 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C91EC061570
        for <linux-arch@vger.kernel.org>; Thu, 14 Oct 2021 15:17:37 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so7956388pjc.3
        for <linux-arch@vger.kernel.org>; Thu, 14 Oct 2021 15:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=/gn1naYin2rxewmNR+UQ+4Ua2Az6pxvVd0XA2L6nJ+U=;
        b=ONfSismG4d04naWppWaw5fFBIKSKKMAy0gVJiXZrFConvnU5E8d2Ayd3VDh0kKxPlM
         KfYheVy3VZqFxW7C3SyDj3kHRI0/KpnkFFKB2eHymwNvTlk77B8NEvbREKsCxf/hUfZR
         66TL6htytJE5V6/HVu+C2OZbv0Cu9cqLYCK78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/gn1naYin2rxewmNR+UQ+4Ua2Az6pxvVd0XA2L6nJ+U=;
        b=SIfsiGQBtmJwdoj1xlza4i4leblVYryJXGOMDfuRPgQypP/ES8lLbybiiWcOn+46lx
         rojJOBhREwhsCTnRTKnr51ZxCOq0rRBuG7QlN0e4Zegr+vY8bPa5hBRPA87k0Ve0BWnP
         T9soaEXipnE8gFXLYMCp9SR7Y/j3dh548NZfrUKmLMF9C/Ss2sVk4N84INrNA6y7G+9d
         nVRTShHM9oIh48BY1hpmOTFvsmQau5fYw013fErRE9BoVyRXA27lFOG7mvtw92DFA1Xu
         DZ27hrwTpZxmQ4tnNKy+V1yjSanir37DqEJZrvBxE7aufIejpTsA2NvWkvz9WIRJjdIH
         gSNg==
X-Gm-Message-State: AOAM531wAQ5J0ACw7oWT3fvueu0CMT/1pRE5BYN3sod/0T7KDFPm6dNh
        Zd033s3M5E3ZGp7LIF0O1mRrZ/PncRCUqw==
X-Google-Smtp-Source: ABdhPJzab2EpHK7Q/T8QXwpqraVUPmAWt0eL0woPg5T6pMmI9UAwBAQkaSq8CsyFo20UObxGkQ6Z9w==
X-Received: by 2002:a17:90b:224e:: with SMTP id hk14mr9005831pjb.224.1634249856727;
        Thu, 14 Oct 2021 15:17:36 -0700 (PDT)
Received: from localhost ([2001:4479:e300:600:4901:2fb9:ed97:3a3e])
        by smtp.gmail.com with ESMTPSA id x27sm3586622pfo.90.2021.10.14.15.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 15:17:36 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 03/13] powerpc: Remove func_descr_t
In-Reply-To: <16eef6afbf7322d0c07760ebf827b8f9f50f7c6e.1634190022.git.christophe.leroy@csgroup.eu>
References: <cover.1634190022.git.christophe.leroy@csgroup.eu>
 <16eef6afbf7322d0c07760ebf827b8f9f50f7c6e.1634190022.git.christophe.leroy@csgroup.eu>
Date:   Fri, 15 Oct 2021 09:17:33 +1100
Message-ID: <874k9j45fm.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> 'func_descr_t' is redundant with 'struct ppc64_opd_entry'

So, if I understand the overall direction of the series, you're
consolidating powerpc around one single type for function descriptors,
and then you're creating a generic typedef so that generic code can
always do ((func_desc_t)x)->addr to get the address of a function out of
a function descriptor regardless of arch. (And regardless of whether the
arch uses function descriptors or not.)

So:

 - why pick ppc64_opd_entry over func_descr_t?

 - Why not make our struct just called func_desc_t - why have a
   ppc64_opd_entry type or a func_descr_t typedef?

 - Should this patch wait until after you've made the generic
   func_desc_t change and move directly to that new interface? (rather
   than move from func_descr_t -> ppc64_opd_entry -> ...) Or is there a
   particular reason arch specific code should use an arch-specific
   struct or named type?

> Remove it.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/code-patching.h | 2 +-
>  arch/powerpc/include/asm/types.h         | 6 ------
>  arch/powerpc/kernel/signal_64.c          | 8 ++++----
>  3 files changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
> index 4ba834599c4d..f3445188d319 100644
> --- a/arch/powerpc/include/asm/code-patching.h
> +++ b/arch/powerpc/include/asm/code-patching.h
> @@ -110,7 +110,7 @@ static inline unsigned long ppc_function_entry(void *func)
>  	 * function's descriptor. The first entry in the descriptor is the
>  	 * address of the function text.
>  	 */
> -	return ((func_descr_t *)func)->entry;
> +	return ((struct ppc64_opd_entry *)func)->addr;
>  #else
>  	return (unsigned long)func;
>  #endif
> diff --git a/arch/powerpc/include/asm/types.h b/arch/powerpc/include/asm/types.h
> index f1630c553efe..97da77bc48c9 100644
> --- a/arch/powerpc/include/asm/types.h
> +++ b/arch/powerpc/include/asm/types.h
> @@ -23,12 +23,6 @@
>  
>  typedef __vector128 vector128;
>  
> -typedef struct {
> -	unsigned long entry;
> -	unsigned long toc;
> -	unsigned long env;
> -} func_descr_t;

I was a little concerned about going from a 3-element struct to a
2-element struct (as ppc64_opd_entry doesn't have an element for env) -
but we don't seem to take the sizeof this anywhere, nor do we use env
anywhere, nor do we do funky macro stuff with it in the signal handling
code that might implictly use the 3rd element, so I guess this will
work. Still, func_descr_t seems to describe the underlying ABI better
than ppc64_opd_entry...

>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_POWERPC_TYPES_H */
> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
> index 1831bba0582e..63ddbe7b108c 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -933,11 +933,11 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
>  		 * descriptor is the entry address of signal and the second
>  		 * entry is the TOC value we need to use.
>  		 */
> -		func_descr_t __user *funct_desc_ptr =
> -			(func_descr_t __user *) ksig->ka.sa.sa_handler;
> +		struct ppc64_opd_entry __user *funct_desc_ptr =
> +			(struct ppc64_opd_entry __user *)ksig->ka.sa.sa_handler;
>  
> -		err |= get_user(regs->ctr, &funct_desc_ptr->entry);
> -		err |= get_user(regs->gpr[2], &funct_desc_ptr->toc);
> +		err |= get_user(regs->ctr, &funct_desc_ptr->addr);
> +		err |= get_user(regs->gpr[2], &funct_desc_ptr->r2);

Likewise, r2 seems like a worse name than toc. I guess we could clean
that up another time though.

Kind regards,
Daniel

>  	}
>  
>  	/* enter the signal handler in native-endian mode */
> -- 
> 2.31.1
