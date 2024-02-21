Return-Path: <linux-arch+bounces-2583-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814CD85E057
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 15:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25330B28F2A
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 14:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D457FBA9;
	Wed, 21 Feb 2024 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBjZWblP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0697FBB8;
	Wed, 21 Feb 2024 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527188; cv=none; b=JX7XsvoQVpwOpNHWROCIEHXalf9hMSK43pByv+8W1wAqqvz0Ajlj/Z1iXv1/CAtQ8QHdopg0l7qcQvjPPIrDnzWzHQxQ3rkRCKMMD/QHeG/PK5Flu5eexxQuaxoqQSm4nMptLd2mxM7leTK77GJuGaqxWyQa+uUZ8cZ/MQV0Lww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527188; c=relaxed/simple;
	bh=GFG4jC7AMNHM9If0p4IbWL9b/Wg/EsXkiJXlP51yvcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVka0KtHubJHvbqDmAWQ6VkSCzteAOkKWCRyjZBuf3IHoWB1jNqpFQdvy+6NlWFVvMVML/j2NfB5c8ICsDQLItRsG5ZYgQaMoCgB1T5Qt2QOPMtNTTzOaD0sZEmVY4I4jVyuqCozBR6VU5OlOBcBdRxYU5cyFYmYjOucipMFNhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBjZWblP; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d09cf00214so75688401fa.0;
        Wed, 21 Feb 2024 06:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708527184; x=1709131984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePZHUj5LUCPpE5Mosu90DBz2D4k7SKlgOf7UzKRj0RI=;
        b=fBjZWblP/JbgAMOhCRrVKe8jWetlISDn9YEc3FZ18++H9/CVvho5AIb3TjkOlProUW
         ce9+MK3vGW4TcDmo+NLvQ/lsyXZRa2qEZctNs8+F/BpPk1yu/DU2lT+2EMO+usI3lcJ6
         1WNYjC4jLgtKAb9Ne5+3wjWGbtt7txQ4Q4CxSx+nA2RRJ3cBPxNZVHinAxhdMV9s0smm
         wViMOdtwCrvBG5QqvPLC8PL3ttQ1r4pHfusIrZNKkHGn/9MGGIR0jeUXeCmZr10pjoQS
         Dtcif7s4/KXrST5LBWBKg7+8Iw2Az1SPcGnm4+7lz4FNj2PM921XflhVKxizPab70uv8
         7XuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708527184; x=1709131984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePZHUj5LUCPpE5Mosu90DBz2D4k7SKlgOf7UzKRj0RI=;
        b=t+Su6IDeyLufaYFKIVzntmXghYlXPMWWKaj6IiLOnf5aj1+eSuaoc1ykDm1fixng98
         N6bWLbL3/uy5HjDpYIthm9gLhF7aLOEKQG9s8L2tGcqciBkt+Y0qRvJaRX4JjtOquoFF
         AZHAB6p/gvcVsOpxSLWM7LTroQoXuY0wHg3bcW4K79k1+bbE8yqLIoFWEIdbjithioF7
         wGa1Pmwz+mWfIl7etIxU1OYObuqs5sIZtadu6GpWfvwd7H16xQ59LHsK7wwMn3l1bEZL
         LVt2AAKHciuN2/z+taqC/y6TEW6Ub56tCpzyS0veIN5Luw65lr6q7jMhZWqiYDDqFGku
         wMMw==
X-Forwarded-Encrypted: i=1; AJvYcCUR6s+1JMBF4fLeS9c/hQM6rH4kunlh0IIYua7jHBcaLGgdkkDLdrc5h0y8vV4cNL2WaG6mcvixTMHH2gUSRmwmIAq5Neb2mjFnvQ==
X-Gm-Message-State: AOJu0Ywf+1TzBPwdXyRCfjoJiX3lrRxRvNiUD5zh7D8Y9Z+tdNdx7ptI
	40TUOoWqQ99DVZlTbyj+9dQ1s254PK/H2T5sOi1NDEK63wTYV0Or+ij2yOTJHfLrOew+/N28z5T
	XFOl1dUwz2dc283Oie6KRiUz66w==
X-Google-Smtp-Source: AGHT+IE/K+XcvoI/LcNmvDCJKjlr9B99h7U5y79IwVKbsvm+c8sY8t8FI9nhGhEJalOoimheBDOIbnrA6j+mw1hlCB0=
X-Received: by 2002:a2e:b006:0:b0:2d2:3695:c18 with SMTP id
 y6-20020a2eb006000000b002d236950c18mr6696084ljk.19.1708527184231; Wed, 21 Feb
 2024 06:53:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221113506.2565718-18-ardb+git@google.com> <20240221113506.2565718-25-ardb+git@google.com>
In-Reply-To: <20240221113506.2565718-25-ardb+git@google.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 21 Feb 2024 09:52:53 -0500
Message-ID: <CAMzpN2iu52yJWv3w1SgDXXGdvbfGi8cHRkip_qqrAO_89-4+sQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/16] x86/startup_64: Simplify CR4 handling in startup code
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, linux-arch@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 6:35=E2=80=AFAM Ard Biesheuvel <ardb+git@google.com=
> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> When paging is enabled, the CR4.PAE and CR4.LA57 control bits cannot be
> changed, and so they can simply be preserved rather than reason about
> whether or not they need to be set. CR4.MCE should be preserved unless
> the kernel was built without CONFIG_X86_MCE, in which case it must be
> cleared.
>
> CR4.PSE should be set explicitly, regardless of whether or not it was
> set before.
>
> CR4.PGE is set explicitly, and then cleared and set again after
> programming CR3 in order to flush TLB entries based on global
> translations. This makes the first assignment redundant, and can
> therefore be omitted.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/kernel/head_64.S | 24 +++++++-------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index fb2a98c29094..426f6fdc0075 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -185,6 +185,8 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L=
_GLOBAL)
>         addq    $(init_top_pgt - __START_KERNEL_map), %rax
>  1:
>
> +       /* Create a mask of CR4 bits to preserve */
> +       movl    $(X86_CR4_PAE | X86_CR4_LA57), %edx
>  #ifdef CONFIG_X86_MCE
>         /*
>          * Preserve CR4.MCE if the kernel will enable #MC support.
> @@ -193,20 +195,13 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM=
_L_GLOBAL)
>          * configured will crash the system regardless of the CR4.MCE val=
ue set
>          * here.
>          */
> -       movq    %cr4, %rcx
> -       andl    $X86_CR4_MCE, %ecx
> -#else
> -       movl    $0, %ecx
> +       orl     $X86_CR4_MCE, %edx
>  #endif
> +       movq    %cr4, %rcx
> +       andl    %edx, %ecx
>
> -       /* Enable PAE mode, PSE, PGE and LA57 */
> -       orl     $(X86_CR4_PAE | X86_CR4_PSE | X86_CR4_PGE), %ecx
> -#ifdef CONFIG_X86_5LEVEL
> -       testb   $1, __pgtable_l5_enabled(%rip)
> -       jz      1f
> -       orl     $X86_CR4_LA57, %ecx
> -1:
> -#endif
> +       /* Even if ignored in long mode, set PSE uniformly on all logical=
 CPUs. */
> +       btsl    $X86_CR4_PSE_BIT, %ecx
>         movq    %rcx, %cr4

This CR4 write now does the global flush - see below.

>
>         /* Setup early boot stage 4-/5-level pagetables. */
> @@ -226,11 +221,8 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_=
L_GLOBAL)
>          * Do a global TLB flush after the CR3 switch to make sure the TL=
B
>          * entries from the identity mapping are flushed.
>          */

This comment is misleading now since it's the first CR4 write above
(with PGE clear) that actually does the global flush.

> -       movq    %cr4, %rcx
> -       movq    %rcx, %rax
> -       xorq    $X86_CR4_PGE, %rcx
> +       btsl    $X86_CR4_PGE_BIT, %ecx
>         movq    %rcx, %cr4
> -       movq    %rax, %cr4
>
>         /* Ensure I am executing from virtual addresses */
>         movq    $1f, %rax
> --
> 2.44.0.rc0.258.g7320e95886-goog
>

Brian Gerst

