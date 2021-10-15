Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CF442E995
	for <lists+linux-arch@lfdr.de>; Fri, 15 Oct 2021 09:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbhJOHCW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Oct 2021 03:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbhJOHCW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Oct 2021 03:02:22 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D372C061570;
        Fri, 15 Oct 2021 00:00:16 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so6613510pjb.3;
        Fri, 15 Oct 2021 00:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=DpMJMuOh31BW0TinR6HO0ohowzv9GzyWx4UJCZSiM/E=;
        b=dawJA0plSvi8TVzJFAb5vNAFuFXMNEP6h+yuaSvTk5WkFqLekT1lieQvF2HAsP0WEt
         9QG4m2e0PJrKkLTucfm9iLDGPhnVdXkoUygr8xZhqgZyNgZMS8x2+JJNSUFU+whvAQLF
         JJUdu99bcNwgHbn9rZgSa7Z/xpXiXKpAzwL0j+I1UxO5S5/48isAqNMnRDnHl5y1DafR
         LnArbLoVGQJuyFg4lexUV4bCmV8fOUN0tA+6Hg4ZLdbbpLzAt14hiDEm9AwMxgRIsCoz
         svZ1tJlufDFI4dokEBZFWyEyDF6u1RfBhbUpNhCeytj6NyM2tosKujHuUPhZ7xdXfgwb
         tHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=DpMJMuOh31BW0TinR6HO0ohowzv9GzyWx4UJCZSiM/E=;
        b=EV3HqtPNjLRcQOaKhEg4iKciaFEwoWBrW+xWgoKHrJDlmNv+UQYgWlAWXhQIZKSg4I
         RVKe4bGPAnpPVV16jY9ExwSambfafZzPNsN9rfL55CHe5wDJYcrZzbtg03c/WV2imrQ3
         xHJ4EDmk/S0UwDGud6s2waslPjgddJed/kyRex3+fWvg8PS4O+eyqWRnVseU5yeTFrXu
         SdYBu5OqllPlEK7FW+AyWxDQ+5o5DowWe8xdCIxHZleZTgMAk6F6G9k2+0+Tqo7/2oxp
         Y9+ve1fAYPn4GmRlOLqugSZyHoe00X5lmv7VMeteBA82SK7KR2RHly2sILcv4zreEsjv
         JHWw==
X-Gm-Message-State: AOAM531q9h0FJ4aaFc811USPNwmnS2Dtvygbnqb6021LH1MQoSNga/eo
        cI/ES5QWhIz/9mwRdGXU1Lw=
X-Google-Smtp-Source: ABdhPJxztf44YE8ddyH3Qj/Lj8a78ir7rHdM6+mqT2YW9gHvSekb8o/P4AfBjE43O9k+nVgPDYSovA==
X-Received: by 2002:a17:90b:3588:: with SMTP id mm8mr26098666pjb.238.1634281215876;
        Fri, 15 Oct 2021 00:00:15 -0700 (PDT)
Received: from localhost (14-203-144-177.static.tpgi.com.au. [14.203.144.177])
        by smtp.gmail.com with ESMTPSA id c192sm4160615pfb.110.2021.10.15.00.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 00:00:15 -0700 (PDT)
Date:   Fri, 15 Oct 2021 17:00:10 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 08/13] asm-generic: Refactor
 dereference_[kernel]_function_descriptor()
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1634190022.git.christophe.leroy@csgroup.eu>
        <865b5c872814e3291fe7afabcc110f53b3457b56.1634190022.git.christophe.leroy@csgroup.eu>
In-Reply-To: <865b5c872814e3291fe7afabcc110f53b3457b56.1634190022.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1634279175.w0z6ck2mpb.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Christophe Leroy's message of October 14, 2021 3:49 pm:
> dereference_function_descriptor() and
> dereference_kernel_function_descriptor() are identical on the
> three architectures implementing them.
>=20
> Make them common and put them out-of-line in kernel/extable.c
> which is one of the users and has similar type of functions.

We should be moving more stuff out of extable.c (including all the
kernel address tests). lib/kimage.c or kelf.c or something.=20

It could be after your series though.

>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/ia64/include/asm/sections.h    | 19 -------------------
>  arch/parisc/include/asm/sections.h  |  9 ---------
>  arch/parisc/kernel/process.c        | 21 ---------------------
>  arch/powerpc/include/asm/sections.h | 23 -----------------------
>  include/asm-generic/sections.h      |  2 ++
>  kernel/extable.c                    | 23 ++++++++++++++++++++++-
>  6 files changed, 24 insertions(+), 73 deletions(-)
>=20
> diff --git a/arch/ia64/include/asm/sections.h b/arch/ia64/include/asm/sec=
tions.h
> index 1aaed8882294..96c9bb500c34 100644
> --- a/arch/ia64/include/asm/sections.h
> +++ b/arch/ia64/include/asm/sections.h
> @@ -31,23 +31,4 @@ extern char __start_gate_brl_fsys_bubble_down_patchlis=
t[], __end_gate_brl_fsys_b
>  extern char __start_unwind[], __end_unwind[];
>  extern char __start_ivt_text[], __end_ivt_text[];
> =20
> -#undef dereference_function_descriptor
> -static inline void *dereference_function_descriptor(void *ptr)
> -{
> -	struct fdesc *desc =3D ptr;
> -	void *p;
> -
> -	if (!get_kernel_nofault(p, (void *)&desc->addr))
> -		ptr =3D p;
> -	return ptr;
> -}
> -
> -#undef dereference_kernel_function_descriptor
> -static inline void *dereference_kernel_function_descriptor(void *ptr)
> -{
> -	if (ptr < (void *)__start_opd || ptr >=3D (void *)__end_opd)
> -		return ptr;
> -	return dereference_function_descriptor(ptr);
> -}
> -
>  #endif /* _ASM_IA64_SECTIONS_H */
> diff --git a/arch/parisc/include/asm/sections.h b/arch/parisc/include/asm=
/sections.h
> index 37b34b357cb5..6b1fe22baaf5 100644
> --- a/arch/parisc/include/asm/sections.h
> +++ b/arch/parisc/include/asm/sections.h
> @@ -13,13 +13,4 @@ typedef Elf64_Fdesc func_desc_t;
> =20
>  extern char __alt_instructions[], __alt_instructions_end[];
> =20
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
> =20
> -#ifdef CONFIG_64BIT
> -void *dereference_function_descriptor(void *ptr)
> -{
> -	Elf64_Fdesc *desc =3D ptr;
> -	void *p;
> -
> -	if (!get_kernel_nofault(p, (void *)&desc->addr))
> -		ptr =3D p;
> -	return ptr;
> -}
> -
> -void *dereference_kernel_function_descriptor(void *ptr)
> -{
> -	if (ptr < (void *)__start_opd ||
> -			ptr >=3D (void *)__end_opd)
> -		return ptr;
> -
> -	return dereference_function_descriptor(ptr);
> -}
> -#endif
> -
>  static inline unsigned long brk_rnd(void)
>  {
>  	return (get_random_int() & BRK_RND_MASK) << PAGE_SHIFT;
> diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/a=
sm/sections.h
> index 1322d7b2f1a3..fbfe1957edbe 100644
> --- a/arch/powerpc/include/asm/sections.h
> +++ b/arch/powerpc/include/asm/sections.h
> @@ -72,29 +72,6 @@ static inline int overlaps_kernel_text(unsigned long s=
tart, unsigned long end)
>  		(unsigned long)_stext < end;
>  }
> =20
> -#ifdef PPC64_ELF_ABI_v1
> -
> -#undef dereference_function_descriptor
> -static inline void *dereference_function_descriptor(void *ptr)
> -{
> -	struct ppc64_opd_entry *desc =3D ptr;
> -	void *p;
> -
> -	if (!get_kernel_nofault(p, (void *)&desc->addr))
> -		ptr =3D p;
> -	return ptr;
> -}
> -
> -#undef dereference_kernel_function_descriptor
> -static inline void *dereference_kernel_function_descriptor(void *ptr)
> -{
> -	if (ptr < (void *)__start_opd || ptr >=3D (void *)__end_opd)
> -		return ptr;
> -
> -	return dereference_function_descriptor(ptr);
> -}
> -#endif /* PPC64_ELF_ABI_v1 */
> -
>  #endif
> =20
>  #endif /* __KERNEL__ */
> diff --git a/include/asm-generic/sections.h b/include/asm-generic/section=
s.h
> index cbec7d5f1678..76163883c6ff 100644
> --- a/include/asm-generic/sections.h
> +++ b/include/asm-generic/sections.h
> @@ -60,6 +60,8 @@ extern __visible const void __nosave_begin, __nosave_en=
d;
> =20
>  /* Function descriptor handling (if any).  Override in asm/sections.h */
>  #ifdef HAVE_FUNCTION_DESCRIPTORS
> +void *dereference_function_descriptor(void *ptr);
> +void *dereference_kernel_function_descriptor(void *ptr);
>  #else
>  #define dereference_function_descriptor(p) ((void *)(p))
>  #define dereference_kernel_function_descriptor(p) ((void *)(p))
> diff --git a/kernel/extable.c b/kernel/extable.c
> index b0ea5eb0c3b4..013ccffade11 100644
> --- a/kernel/extable.c
> +++ b/kernel/extable.c
> @@ -3,6 +3,7 @@
>     Copyright (C) 2001 Rusty Russell, 2002 Rusty Russell IBM.
> =20
>  */
> +#include <linux/elf.h>
>  #include <linux/ftrace.h>
>  #include <linux/memory.h>
>  #include <linux/extable.h>
> @@ -159,12 +160,32 @@ int kernel_text_address(unsigned long addr)
>  }
> =20
>  /*
> - * On some architectures (PPC64, IA64) function pointers
> + * On some architectures (PPC64, IA64, PARISC) function pointers
>   * are actually only tokens to some data that then holds the
>   * real function address. As a result, to find if a function
>   * pointer is part of the kernel text, we need to do some
>   * special dereferencing first.
>   */
> +#ifdef HAVE_FUNCTION_DESCRIPTORS
> +void *dereference_function_descriptor(void *ptr)
> +{
> +	func_desc_t *desc =3D ptr;
> +	void *p;
> +
> +	if (!get_kernel_nofault(p, (void *)&desc->addr))
> +		ptr =3D p;

I know you're just copying existing code. This seems a bit risky though.=20
I don't think anything good could come of just treating the descriptor
address like a function entry address if we failed to load from it for
whatever reason.

Existing callers might be benign but the API is not good. It should
give a nice fail return or BUG. If we change that then we should also
change the name and pass the correct type to it too.

Thanks,
Nick
