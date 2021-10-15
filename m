Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5987A42E8C7
	for <lists+linux-arch@lfdr.de>; Fri, 15 Oct 2021 08:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhJOGSZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Oct 2021 02:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhJOGSY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Oct 2021 02:18:24 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D109BC061753;
        Thu, 14 Oct 2021 23:16:17 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id om14so6504742pjb.5;
        Thu, 14 Oct 2021 23:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=YE7nTA2V96Pevc/UvOLQEZXUKaX0lJLTFtXdRp3w5Ps=;
        b=CrFzPHDXpxCtTQkDeVW16flYjdq+s8jnsSTPHvMLMn6glP8lVoC75CrOgBR5LFre4E
         ESlq2c+cqzAkGsZvZTlzyvCDZCyDsackyuz0XOoNL1a7K3X/+fnNhV0HhckNv0Bc2RKL
         ZCpqwBaJFD6NBlxeRiQKAl44uQh9zdUXcdQV4DrpkN1e32i7kUnVxqqJX3Xv+MGdZ5qu
         RnWmvAjvBlA43GmAIWxu+G8YOQprP1SiObu+cLBAu2tzRiEmX763yjFnibUqZ/iPIeWe
         vrh286dsF8lmqN0J7X6k14NRFqwGZUZe514CRrnBhBAB20uAZmqXZaUUOZK2mFwNQ9oN
         tzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=YE7nTA2V96Pevc/UvOLQEZXUKaX0lJLTFtXdRp3w5Ps=;
        b=3F36v26CKhHm1lvg3lrrUVQ3BeyfxTtCFHt0LgVfqRdS2dIb97En4lZy5Xpf1H5BUf
         le6/hdalK7uHUV2R6AEXEzHPfo7nhaJwBCnDb7fyN8yi50aiz7o2qW7wi2Dqi8SqykB/
         XPrtLjBy5VEuaIxyUbHBQ6co/jYIp+DqJIOOVdnA40hHAM9Mj736K8jpyiAl552EyC4R
         W7NEiCta/zHksVzjfS0vAy4vwUiyPalyKQrVMQmD8eonk0Tx1fLSMfmk9qJjR+VnlEP3
         ournU/1rCouAsFvbkUrcDdi2AUEXb1rgmelDEG7vWnyvYELj0Lz0DygWUDuHN0gMkg/r
         ZI1g==
X-Gm-Message-State: AOAM530ue3fwJu0DdK08Dy3JItKKsyUXjZwxAbPNZSPHMEgYjd1Ih3uX
        zX39dP+/kAxozMinYpVn6lQ=
X-Google-Smtp-Source: ABdhPJwYYUl5EQRMuVepLASUxMZmHpBPgBCkyvr9GXt6diHoOjWk1MRhDXh2MAsBwZP8Hx+MTJpsOA==
X-Received: by 2002:a17:90a:708c:: with SMTP id g12mr25440278pjk.13.1634278577314;
        Thu, 14 Oct 2021 23:16:17 -0700 (PDT)
Received: from localhost (14-203-144-177.static.tpgi.com.au. [14.203.144.177])
        by smtp.gmail.com with ESMTPSA id v22sm4156445pff.93.2021.10.14.23.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 23:16:17 -0700 (PDT)
Date:   Fri, 15 Oct 2021 16:16:12 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 06/13] asm-generic: Use HAVE_FUNCTION_DESCRIPTORS to
 define associated stubs
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
        <4fda65cda906e56aa87806b658e0828c64792403.1634190022.git.christophe.leroy@csgroup.eu>
In-Reply-To: <4fda65cda906e56aa87806b658e0828c64792403.1634190022.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1634278340.5yp7xtm7um.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Christophe Leroy's message of October 14, 2021 3:49 pm:
> Replace HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR by
> HAVE_FUNCTION_DESCRIPTORS and use it instead of
> 'dereference_function_descriptor' macro to know
> whether an arch has function descriptors.
>=20
> To limit churn in one of the following patches, use
> an #ifdef/#else construct with empty first part
> instead of an #ifndef in asm-generic/sections.h

Is it worth putting this into Kconfig if you're going to
change it? In any case

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/ia64/include/asm/sections.h    | 5 +++--
>  arch/parisc/include/asm/sections.h  | 6 ++++--
>  arch/powerpc/include/asm/sections.h | 6 ++++--
>  include/asm-generic/sections.h      | 3 ++-
>  include/linux/kallsyms.h            | 2 +-
>  5 files changed, 14 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/ia64/include/asm/sections.h b/arch/ia64/include/asm/sec=
tions.h
> index 35f24e52149a..6e55e545bf02 100644
> --- a/arch/ia64/include/asm/sections.h
> +++ b/arch/ia64/include/asm/sections.h
> @@ -9,6 +9,9 @@
> =20
>  #include <linux/elf.h>
>  #include <linux/uaccess.h>
> +
> +#define HAVE_FUNCTION_DESCRIPTORS 1
> +
>  #include <asm-generic/sections.h>
> =20
>  extern char __phys_per_cpu_start[];
> @@ -27,8 +30,6 @@ extern char __start_gate_brl_fsys_bubble_down_patchlist=
[], __end_gate_brl_fsys_b
>  extern char __start_unwind[], __end_unwind[];
>  extern char __start_ivt_text[], __end_ivt_text[];
> =20
> -#define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
> -
>  #undef dereference_function_descriptor
>  static inline void *dereference_function_descriptor(void *ptr)
>  {
> diff --git a/arch/parisc/include/asm/sections.h b/arch/parisc/include/asm=
/sections.h
> index bb52aea0cb21..85149a89ff3e 100644
> --- a/arch/parisc/include/asm/sections.h
> +++ b/arch/parisc/include/asm/sections.h
> @@ -2,6 +2,10 @@
>  #ifndef _PARISC_SECTIONS_H
>  #define _PARISC_SECTIONS_H
> =20
> +#ifdef CONFIG_64BIT
> +#define HAVE_FUNCTION_DESCRIPTORS 1
> +#endif
> +
>  /* nothing to see, move along */
>  #include <asm-generic/sections.h>
> =20
> @@ -9,8 +13,6 @@ extern char __alt_instructions[], __alt_instructions_end=
[];
> =20
>  #ifdef CONFIG_64BIT
> =20
> -#define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
> -
>  #undef dereference_function_descriptor
>  void *dereference_function_descriptor(void *);
> =20
> diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/a=
sm/sections.h
> index 32e7035863ac..bba97b8c38cf 100644
> --- a/arch/powerpc/include/asm/sections.h
> +++ b/arch/powerpc/include/asm/sections.h
> @@ -8,6 +8,10 @@
> =20
>  #define arch_is_kernel_initmem_freed arch_is_kernel_initmem_freed
> =20
> +#ifdef PPC64_ELF_ABI_v1
> +#define HAVE_FUNCTION_DESCRIPTORS 1
> +#endif
> +
>  #include <asm-generic/sections.h>
> =20
>  extern bool init_mem_is_free;
> @@ -69,8 +73,6 @@ static inline int overlaps_kernel_text(unsigned long st=
art, unsigned long end)
> =20
>  #ifdef PPC64_ELF_ABI_v1
> =20
> -#define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
> -
>  #undef dereference_function_descriptor
>  static inline void *dereference_function_descriptor(void *ptr)
>  {
> diff --git a/include/asm-generic/sections.h b/include/asm-generic/section=
s.h
> index d16302d3eb59..b677e926e6b3 100644
> --- a/include/asm-generic/sections.h
> +++ b/include/asm-generic/sections.h
> @@ -59,7 +59,8 @@ extern char __noinstr_text_start[], __noinstr_text_end[=
];
>  extern __visible const void __nosave_begin, __nosave_end;
> =20
>  /* Function descriptor handling (if any).  Override in asm/sections.h */
> -#ifndef dereference_function_descriptor
> +#ifdef HAVE_FUNCTION_DESCRIPTORS
> +#else
>  #define dereference_function_descriptor(p) ((void *)(p))
>  #define dereference_kernel_function_descriptor(p) ((void *)(p))
>  #endif
> diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
> index a1d6fc82d7f0..9f277baeb559 100644
> --- a/include/linux/kallsyms.h
> +++ b/include/linux/kallsyms.h
> @@ -57,7 +57,7 @@ static inline int is_ksym_addr(unsigned long addr)
> =20
>  static inline void *dereference_symbol_descriptor(void *ptr)
>  {
> -#ifdef HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR
> +#ifdef HAVE_FUNCTION_DESCRIPTORS
>  	struct module *mod;
> =20
>  	ptr =3D dereference_kernel_function_descriptor(ptr);
> --=20
> 2.31.1
>=20
>=20
>=20
