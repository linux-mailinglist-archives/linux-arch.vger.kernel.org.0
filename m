Return-Path: <linux-arch+bounces-2487-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3665F85A99D
	for <lists+linux-arch@lfdr.de>; Mon, 19 Feb 2024 18:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA45A1F22F29
	for <lists+linux-arch@lfdr.de>; Mon, 19 Feb 2024 17:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76BE44C9C;
	Mon, 19 Feb 2024 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJE1PI/+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3FF446AD;
	Mon, 19 Feb 2024 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362380; cv=none; b=Bd/YH6TDVE9yDeFcchWVLVAGuuI8O3t4Dft99n1E/V+YOG0Owq59O+7RgpFDNJw77iJM+sM2sfiOy7GEIpuiUOUfbSBLqrLXVEFuVg7FwViryohmlZvrQckrMwvPhI1YolT5+rRPngTIZ2qDYhC0Jrc7t5XQrpOsVwszoKY3qlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362380; c=relaxed/simple;
	bh=t+TSvmeYQx4nVmUvJDq+bLSSfN+BKXaCGdPbAufGsFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uE0bI5CRs9fZdSnSvjHQ/2vU5D92SJu0D9v50pLQAaR6glrSgHKmyAAH2smL892TPkxNWbMYodQydu1bV836SHHU8bHBl90F0Tn0qvLUiEvRQCq9cHYakhPZ+ktUu90+zsv5zHmPh54EsSR16ogvkoacmg24UbMkAk58FIQ5GlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJE1PI/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A083C43609;
	Mon, 19 Feb 2024 17:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708362380;
	bh=t+TSvmeYQx4nVmUvJDq+bLSSfN+BKXaCGdPbAufGsFg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rJE1PI/+3hoO27FdW4q7tsFBt/I0zEuTp5T/LKC61VwsnclDdQ2jxuHpkFNqKk/WS
	 eba/2NPvoIOLi1278fh7IWUKSKX5/1NDQKIwg3mF344ZaoZPLzt2nEp4TOzaVeqQme
	 09/xjyJ8yTaiv3eMABoYkNHp31J4AJBIstoYGB6++xZjzEONNaksVmWMJPJsrh2V/T
	 KR4UR6EpJpkHGuStpgw7oUwRTUMLh+ru1gVMuGyuzgtX5+8SFcpG+oP+vAQhbAawaG
	 g5Yz3GDofnu59C2hOMvGFiVJ8pNDqooZLz8SrYgXrdreSSgQQZMWLdzXLatCCUNnF0
	 omnsdHQw48h3w==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d1094b549cso67536011fa.3;
        Mon, 19 Feb 2024 09:06:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUf4WXQzNv5Df7LBXlCMlc90hlJhuUuJRP95skH7hQ/z5zgoTQ+yctsbXTig87trxjttQ1hE2g3eyy0/36VDxJfNjynA3jF/eZf8BrAxZU82I/JzTK5YYgPEHHmOzmPBzIrHvz0thi3YA==
X-Gm-Message-State: AOJu0Yy1uJowFDAGM/nOVTZJjj9ZxLNrFwMCsQKPNtOuinDmVBH+L8Ti
	z58IJ+LlwJzr+pagoGRmk3KnQXdmiIb+1jKbLeONQycU8BZkwZmB/zRweog+C2C7oU8W/YAqEYw
	0SEhZdw6Z9Nx28dAeSQdtOhb1z0k=
X-Google-Smtp-Source: AGHT+IH2PehXtcBecdoz6FD+9gOMdsvZTGp/cMIAioAJ8CZAcqtAkx87TjovFZ3twblzIGJe3mOkNVQ3IA3xHKolxwI=
X-Received: by 2002:ac2:4a91:0:b0:511:a803:7e63 with SMTP id
 l17-20020ac24a91000000b00511a8037e63mr8154400lfp.54.1708362378413; Mon, 19
 Feb 2024 09:06:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-20-ardb+git@google.com> <b2e0b647-b5a7-4c66-bb00-7907a2318f58@amd.com>
In-Reply-To: <b2e0b647-b5a7-4c66-bb00-7907a2318f58@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 19 Feb 2024 18:06:07 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG_sQ-+ULtvE7SqD0DYe3p9=tP8K9VPgfiR-0Z55A9vVw@mail.gmail.com>
Message-ID: <CAMj1kXG_sQ-+ULtvE7SqD0DYe3p9=tP8K9VPgfiR-0Z55A9vVw@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] efi/libstub: Add generic support for parsing mem_encrypt=
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Kevin Loughlin <kevinloughlin@google.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Feb 2024 at 18:00, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 2/13/24 06:41, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Parse the mem_encrypt= command line parameter from the EFI stub if
> > CONFIG_ARCH_HAS_MEM_ENCRYPT=y, so that it can be passed to the early
> > boot code by the arch code in the stub.
> >
> > This avoids the need for the core kernel to do any string parsing very
> > early in the boot.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >   drivers/firmware/efi/libstub/efi-stub-helper.c | 8 ++++++++
> >   drivers/firmware/efi/libstub/efistub.h         | 2 +-
> >   2 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > index bfa30625f5d0..3dc2f9aaf08d 100644
> > --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > @@ -24,6 +24,8 @@ static bool efi_noinitrd;
> >   static bool efi_nosoftreserve;
> >   static bool efi_disable_pci_dma = IS_ENABLED(CONFIG_EFI_DISABLE_PCI_DMA);
> >
> > +int efi_mem_encrypt;
> > +
> >   bool __pure __efi_soft_reserve_enabled(void)
> >   {
> >       return !efi_nosoftreserve;
> > @@ -75,6 +77,12 @@ efi_status_t efi_parse_options(char const *cmdline)
> >                       efi_noinitrd = true;
> >               } else if (IS_ENABLED(CONFIG_X86_64) && !strcmp(param, "no5lvl")) {
> >                       efi_no5lvl = true;
> > +             } else if (IS_ENABLED(CONFIG_ARCH_HAS_MEM_ENCRYPT) &&
> > +                        !strcmp(param, "mem_encrypt") && val) {
> > +                     if (parse_option_str(val, "on"))
> > +                             efi_mem_encrypt = 1;
> > +                     else if (parse_option_str(val, "off"))
> > +                             efi_mem_encrypt = -1;
>
> With CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT having recently been
> removed, I'm not sure what parsing for mem_encrypt=off does.
>
> (Same thing in the next patch.)
>

We have to deal with both mem_encrypt=on and mem_encrypt=off occurring
on the command line. efi_parse_options() may be called more than once,
i.e., when there is a default command line baked into the image that
can be overridden at runtime. So if the baked in one has
mem_encrypt=on, mem_encrypt=off appearing later should counter that.

The same applies to the next patch, although the decompressor appears
to ignore the built-in command line entirely (I made a note of that in
the commit log)

