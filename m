Return-Path: <linux-arch+bounces-2554-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD8685D555
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 11:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CAE01F2308D
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 10:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B773E3D970;
	Wed, 21 Feb 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nj/lNYal"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E64B3C493;
	Wed, 21 Feb 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510827; cv=none; b=pMdJFugv4OyxPOZQsDdMGS47aJetcem2IQrJB7Zs+DHm2tlgBHcrJpC2+BRBgJERL/y/0GaIPan2yDG2RGU8hsiOTDSxl+pVkAifwLDEldinG/RSOobNTCCoBPaIpuAb9KPMdzllmxWH3skifMYmCuSdAmTQBEvsCZv5ALC+EiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510827; c=relaxed/simple;
	bh=J/Fg/zm/+n9uEnP0C0R0wz9xzbBtvG5jZMNnhEcMT20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKfer3W/vTcApRwQqTRaX0YahMLGdov6DlFxqUF8l8Rg4b5vBgOF5UaePvYpbS8Zi8TO48SsNNpqA/iWcYLWsolgCezKchh0WN7zg0QOGoxs+1EI0jdn9y01UbdKNZIPzySPYfE5FWCFkI8zIAhOXKw/YJi4jgfvVTS5Xp5OKNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nj/lNYal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CEBC43399;
	Wed, 21 Feb 2024 10:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708510827;
	bh=J/Fg/zm/+n9uEnP0C0R0wz9xzbBtvG5jZMNnhEcMT20=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nj/lNYaliWoEYd+4sH9piCA9d/x1dVqhiCeG8ZlF64RIgjb+5ceUHp28DmaTBne5n
	 j6IiSfg71QrgNZsSdMhxSduBKni0wN7oEXP0+9xa9YUK+N4UCE63RgDTXDiwHoDqOG
	 P5+xsqOolGumxMBkZrRiEt/kkqOtRAJgtIO48g1DhHqZu7gb6Ibxype+5kyoePLWck
	 mRsz4P5pXk78GJzykgJFXdovEacpa8qlOVl8nGlzNmWDRpphWEobIUpVZU9hHpsfFZ
	 wpzUJPwnXVjGOPe6qNdUtbTyhtKfFuGXKASXftKqQPdy6Jb3p/hDF8wYK3wOIVECHk
	 Pm/1QM1K095Ug==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d10ad265d5so70812021fa.0;
        Wed, 21 Feb 2024 02:20:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWg7ncb1+/oZkFmmqSKUlg0imh0WE07AtVTQc2LsthiqbtW485prHnW3TQcBSIYaVXkscrBN0GhYtuoudul+VoibWSQOuDx4Nd6gg==
X-Gm-Message-State: AOJu0YzwAc/tjLy8LTVivpLHtVHTD7RtXbd31QEuV6Y5KDOLNE4Nx9bc
	UF4KztKvkbAdFAFr0yohh/OUSeKHyCa++29ePk4rGJiFDLWfclK0e5hu/AsEwVJU8Tj2zOig6oK
	TqFMwOVML4bx1PapWi75SVq2eSrM=
X-Google-Smtp-Source: AGHT+IFXVRr6o+Ds+H6VMoLX3MlKc1OGh8SqQ0XgmfrWQ13UTJ9FYKk2LR8mqqmAIPxFvRQzIZcbdxnonFCsbBc9zFY=
X-Received: by 2002:a2e:2c01:0:b0:2d2:4778:c825 with SMTP id
 s1-20020a2e2c01000000b002d24778c825mr3470473ljs.41.1708510825347; Wed, 21 Feb
 2024 02:20:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-17-ardb+git@google.com> <20240220184513.GAZdTzOQN33Nccwkno@fat_crate.local>
 <CAMj1kXF=cGHR4FVUqGrobjB4HxTmm=1upn3TpVEC-_8D9GM=uQ@mail.gmail.com> <20240221100916.GCZdXLzHb-31GMw-f-@fat_crate.local>
In-Reply-To: <20240221100916.GCZdXLzHb-31GMw-f-@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 21 Feb 2024 11:20:13 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGqHf3b3zho_0CPccTkgXRnTrxsG_qDjhP9P+US-u2AGw@mail.gmail.com>
Message-ID: <CAMj1kXGqHf3b3zho_0CPccTkgXRnTrxsG_qDjhP9P+US-u2AGw@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] x86/startup_64: Defer assignment of 5-level
 paging global variables
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 11:09, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Feb 21, 2024 at 12:33:08AM +0100, Ard Biesheuvel wrote:
> > Right, this is the same issue as in #11 - in both cases, the extern
> > declaration of __pgtable_l5_enabled needs to be visible regardless of
> > CONFIG_X86_5LEVEL.
>
> Yap, I don't mind something like below.
>
> 5LEVEL will be practically enabled everywhere.
>
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 158da0fd01d2..eeb1744215f2 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -52,13 +52,11 @@ extern pmd_t early_dynamic_pgts[EARLY_DYNAMIC_PAGE_TABLES][PTRS_PER_PMD];
>  static unsigned int __initdata next_early_pgt;
>  pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
>
> -#ifdef CONFIG_X86_5LEVEL
>  unsigned int __pgtable_l5_enabled __ro_after_init;
>  unsigned int pgdir_shift __ro_after_init = 39;
>  EXPORT_SYMBOL(pgdir_shift);
>  unsigned int ptrs_per_p4d __ro_after_init = 1;
>  EXPORT_SYMBOL(ptrs_per_p4d);
> -#endif
>

Just the below should be sufficient

--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -22,7 +22,7 @@ typedef struct { pteval_t pte; } pte_t;
 typedef struct { pmdval_t pmd; } pmd_t;

-#ifdef CONFIG_X86_5LEVEL
 extern unsigned int __pgtable_l5_enabled;

+#ifdef CONFIG_X86_5LEVEL
 #ifdef USE_EARLY_PGTABLE_L5
 /*

