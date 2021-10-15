Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4574C42E8A1
	for <lists+linux-arch@lfdr.de>; Fri, 15 Oct 2021 08:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhJOGDj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Oct 2021 02:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhJOGDi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Oct 2021 02:03:38 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5440CC061570;
        Thu, 14 Oct 2021 23:01:32 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 66so7632849pgc.9;
        Thu, 14 Oct 2021 23:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=DRXHnGOtNMfw8OWo78ntmmDlXjC+sRWdxkm3O7xJKjA=;
        b=m7MXudFQQqL1/k+ClP+ZXqn1o6SFyJ1f66Q3Bu5Odc8OBiFPiJ13cAIC7Bb91L57Qa
         wg5htfRXIvWmL1XBYWjt/KapNQJ484jheOqT4laWX+5LN25duemH5efLGCCw1ezRbE2D
         oHMydeL853jKYzvsuglxlc6/9GhP1bSqW16TyWHFANeiap8ne6FIAs3VXM7FPdZAJDPr
         hU16Gs2Zstt6WT2sdSKZuMLxHFbekr7X7SOwkFRSxnKP5z+P1yr4gzJjxpUvxVIfW4aP
         QUYuse0SEylu3+vPw+KSZUvOf1cy/kCU1ZZUBIG6P0gbZ5pbPXMIlVRrCdBvd6rsYHuZ
         EXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=DRXHnGOtNMfw8OWo78ntmmDlXjC+sRWdxkm3O7xJKjA=;
        b=c61tfo9B2mqFZLPsi/oP043cu7aJD6igHju2A76vzFluFnsMaIO8H1Tkv1H3e20jm6
         y6X2aTHEQxYO9tcOACPfcmcrLIbKPSqi8Ngdklj9L6Uz6YLd9vexllnJF7CqK/+UZ80I
         Gu/9VKvhxW6u5utqWLNeakF5znYMo/ClD2rIh4yWDoghqLrOqMeSh/vdYeRbTxfPXctN
         8i/l5ObXmGISMGYfDnku0zvoExVlYXi4mn6DlwLVuGDBuzrbn3pUqrhPKfsw35MmpptJ
         74jDdSvXkluEtGRLHVciqmr5l6bafcQzI1GhYPcKq8hmKMKZ7byFVjMhWptlo5rNxkFl
         TmTQ==
X-Gm-Message-State: AOAM533lYEysCwentAmTxn8txfVQK4t4uGT7b5okj23biGdWjIJeDn6G
        KMnBrxC9alErUQeYZ7K+zI8=
X-Google-Smtp-Source: ABdhPJyx9VH+hAArTXbMzhj3941MCZEg4aTo2VOCQWAyZHa9YGltTOulV3JGtxxAcgJGHi5zyYTL3Q==
X-Received: by 2002:a05:6a00:1487:b0:44d:c51:c88b with SMTP id v7-20020a056a00148700b0044d0c51c88bmr10003874pfu.32.1634277691871;
        Thu, 14 Oct 2021 23:01:31 -0700 (PDT)
Received: from localhost (14-203-144-177.static.tpgi.com.au. [14.203.144.177])
        by smtp.gmail.com with ESMTPSA id v6sm3998303pfv.83.2021.10.14.23.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 23:01:31 -0700 (PDT)
Date:   Fri, 15 Oct 2021 16:01:26 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 02/13] powerpc: Rename 'funcaddr' to 'addr' in 'struct
 ppc64_opd_entry'
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
        <49f59a8bf2c4d95cfaa03bd3dd3c1569822ad6ba.1634190022.git.christophe.leroy@csgroup.eu>
In-Reply-To: <49f59a8bf2c4d95cfaa03bd3dd3c1569822ad6ba.1634190022.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1634277517.7t2t049cd5.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Christophe Leroy's message of October 14, 2021 3:49 pm:
> There are three architectures with function descriptors, try to
> have common names for the address they contain in order to
> refactor some functions into generic functions later.
>=20
> powerpc has 'funcaddr'
> ia64 has 'ip'
> parisc has 'addr'
>=20
> Vote for 'addr' and update 'struct ppc64_opd_entry' accordingly.

It is the "address of the entry point of the function" according to=20
powerpc ELF spec, so addr seems fine.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/elf.h      | 2 +-
>  arch/powerpc/include/asm/sections.h | 2 +-
>  arch/powerpc/kernel/module_64.c     | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/el=
f.h
> index a4406714c060..bb0f278f9ed4 100644
> --- a/arch/powerpc/include/asm/elf.h
> +++ b/arch/powerpc/include/asm/elf.h
> @@ -178,7 +178,7 @@ void relocate(unsigned long final_address);
> =20
>  /* There's actually a third entry here, but it's unused */
>  struct ppc64_opd_entry {
> -	unsigned long funcaddr;
> +	unsigned long addr;
>  	unsigned long r2;
>  };
> =20
> diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/a=
sm/sections.h
> index 6e4af4492a14..32e7035863ac 100644
> --- a/arch/powerpc/include/asm/sections.h
> +++ b/arch/powerpc/include/asm/sections.h
> @@ -77,7 +77,7 @@ static inline void *dereference_function_descriptor(voi=
d *ptr)
>  	struct ppc64_opd_entry *desc =3D ptr;
>  	void *p;
> =20
> -	if (!get_kernel_nofault(p, (void *)&desc->funcaddr))
> +	if (!get_kernel_nofault(p, (void *)&desc->addr))
>  		ptr =3D p;
>  	return ptr;
>  }
> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module=
_64.c
> index 6baa676e7cb6..82908c9be627 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -72,11 +72,11 @@ static func_desc_t func_desc(unsigned long addr)
>  }
>  static unsigned long func_addr(unsigned long addr)
>  {
> -	return func_desc(addr).funcaddr;
> +	return func_desc(addr).addr;
>  }
>  static unsigned long stub_func_addr(func_desc_t func)
>  {
> -	return func.funcaddr;
> +	return func.addr;
>  }
>  static unsigned int local_entry_offset(const Elf64_Sym *sym)
>  {
> @@ -187,7 +187,7 @@ static int relacmp(const void *_x, const void *_y)
>  static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
>  				    const Elf64_Shdr *sechdrs)
>  {
> -	/* One extra reloc so it's always 0-funcaddr terminated */
> +	/* One extra reloc so it's always 0-addr terminated */
>  	unsigned long relocs =3D 1;
>  	unsigned i;
> =20
> --=20
> 2.31.1
>=20
>=20
>=20
