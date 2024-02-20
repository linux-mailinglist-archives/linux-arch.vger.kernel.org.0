Return-Path: <linux-arch+bounces-2527-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACC985CC1C
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 00:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16501C22401
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 23:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B33154451;
	Tue, 20 Feb 2024 23:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxrhSwxu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD8814A0B2;
	Tue, 20 Feb 2024 23:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708472004; cv=none; b=KvP5lsEE370sU9+08YcJu+oIW8U0g3/65zsX9cQMgOqpUhA47KkxJ+RMHJMq98yBvAaS+wh6Jxs0b5GyK19ataN6u9jBI0r9+O1NRDxDrmQ8w0iXV69Znr9+vAe5Wf+UL+p8Nh9CpuKB2kygLnYeD/1Nsk0sYzRP/s8PeEuAhYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708472004; c=relaxed/simple;
	bh=Oh/h2cj0YS4RJY/SZoI+qEFikqUE0enIJADIQGhtwFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9riHinFGdHbqDNn501XOGSgzT3e9dHF9PRtZH/B0S39QvtOMPn2iKJoBY63J+5b/sFhlmt7tHiUvuCEb11Wd0O8V1p4DmKz4Rlsciwz6p8VzxMUnGDBz+Fv+qG3JuJYUZDtfdcf37PBQeK4r0Wv1ydZziUCm9rB/jf1tKrXlxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxrhSwxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA45C43609;
	Tue, 20 Feb 2024 23:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708472004;
	bh=Oh/h2cj0YS4RJY/SZoI+qEFikqUE0enIJADIQGhtwFo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jxrhSwxuVnDXEHxeGI2cKothoQdm2XNc6DspariWSnsqPrHTDXHzP+oO9b6mEh1JP
	 GePHxLj6X8TsqFZV46lkfcbUpQXEwaCUKDL9928VfS02XeJyRLRzLt9AOva30uggrd
	 ViXSfZYX6J+2BtZLWE1xdqUAusxePdeSEmzodfZRoVip4p3vznM96wfOMFkscfqLmp
	 G9t9g5Mx+y2aWSFp+DFezztEDq1zIBkKNjb8egJDlIvXgS2OsF+UOeWgauySxaxE4B
	 XYfSQW5nuP6MtzHxWpnnS4SXeE0Tvgdf1kzm52hrpqC6p6sHGHxykVesI2xMwinlk5
	 3B/FiaPSKMf1A==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512bce554a5so2949571e87.3;
        Tue, 20 Feb 2024 15:33:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfM61AECOsShP6Mtr5XwsNZhuu8Nj9l02QGy5DAeVXasyMv2OWE3Y6UxPVMk0kdv2JfpBFGfBfxMtsP0HB3auKB6KdP5h5O6Hdzw==
X-Gm-Message-State: AOJu0YyQnlPq86dSGP14Lb4LR/tfPTlxr3hkiHJHf76OSw4bWe+kO2Rj
	B831DSqh+vzcQtrAQioZnQ/X0+CB4ZHERo01foBjeg8o5r63o/5Mh11ZDyjFd9cRMmdRiRw49yE
	WlUofoFBq/ybAo8CddTsNHStxpFM=
X-Google-Smtp-Source: AGHT+IGGKb1QYfhmS4BL89Gjr7JP7acVJpMUXlQ6aTbfqpDNvxNKr04Jgn8OxLX5iWG/7bA0RJikrf61Oc1D17UKBEU=
X-Received: by 2002:a19:e009:0:b0:512:b340:a624 with SMTP id
 x9-20020a19e009000000b00512b340a624mr5025522lfg.6.1708472002228; Tue, 20 Feb
 2024 15:33:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-17-ardb+git@google.com> <20240220184513.GAZdTzOQN33Nccwkno@fat_crate.local>
In-Reply-To: <20240220184513.GAZdTzOQN33Nccwkno@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 21 Feb 2024 00:33:08 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF=cGHR4FVUqGrobjB4HxTmm=1upn3TpVEC-_8D9GM=uQ@mail.gmail.com>
Message-ID: <CAMj1kXF=cGHR4FVUqGrobjB4HxTmm=1upn3TpVEC-_8D9GM=uQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Feb 2024 at 19:45, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Feb 13, 2024 at 01:41:48PM +0100, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Assigning the 5-level paging related global variables from the earliest
> > C code using explicit references that use the 1:1 translation of memory
> > is unnecessary, as the startup code itself does not rely on them to
> > create the initial page tables, and this is all it should be doing. So
> > defer these assignments to the primary C entry code that executes via
> > the ordinary kernel virtual mapping.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/kernel/head64.c | 44 +++++++-------------
> >  1 file changed, 14 insertions(+), 30 deletions(-)
>
> Whoops:
>

Right, this is the same issue as in #11 - in both cases, the extern
declaration of __pgtable_l5_enabled needs to be visible regardless of
CONFIG_X86_5LEVEL.

I'll fix both cases for v5.

> arch/x86/kernel/head64.c: In function =E2=80=98x86_64_start_kernel=E2=80=
=99:
> arch/x86/kernel/head64.c:442:17: error: =E2=80=98__pgtable_l5_enabled=E2=
=80=99 undeclared (first use in this function); did you mean =E2=80=98pgtab=
le_l5_enabled=E2=80=99?
>   442 |                 __pgtable_l5_enabled    =3D 1;
>       |                 ^~~~~~~~~~~~~~~~~~~~
>       |                 pgtable_l5_enabled
> arch/x86/kernel/head64.c:442:17: note: each undeclared identifier is repo=
rted only once for each function it appears in
> make[4]: *** [scripts/Makefile.build:243: arch/x86/kernel/head64.o] Error=
 1
> make[3]: *** [scripts/Makefile.build:481: arch/x86/kernel] Error 2
> make[2]: *** [scripts/Makefile.build:481: arch/x86] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/mnt/kernel/kernel/2nd/linux/Makefile:1921: .] Error 2
> make: *** [Makefile:240: __sub-make] Error 2
>
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

