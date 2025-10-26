Return-Path: <linux-arch+bounces-14348-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD62AC0B6BC
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 00:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1C854E96E5
	for <lists+linux-arch@lfdr.de>; Sun, 26 Oct 2025 23:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2BC2FFFA6;
	Sun, 26 Oct 2025 23:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=surgut.co.uk header.i=@surgut.co.uk header.b="hsRGQOKt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBE62FFFA9
	for <linux-arch@vger.kernel.org>; Sun, 26 Oct 2025 23:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761519958; cv=none; b=KL7fxnnpPM7voJw1/Ox4kY6Qk0dCAXjr5wH7bM1ki6YONXirKMCxd8f/wj8f6fT6jZaSCODFZ00Gl3aBR0QMNpGcxTuMdOX60DMVLKBOZGuiiSnzfpXesqHf5fveGtxgUmHUZCCrUv/igTguDp9ffAckF7loryiNxW1LAPEFovo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761519958; c=relaxed/simple;
	bh=PPxjfgh0ouB1LEh9FfKbHQ8cr7KijaRuWZO7sOvIlmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khYVUhCfgJXtbmsr7RBe/dM1D9PMKf6c2VhuijqKVTUlz41feuqK+XWT0tY6jadZKf9WEWHUW8uSqcWM9f9WshQgXWYXuGekhSi++3E+X9ijAOJTyKIs25WeSCzTkIv1v1VaJhywFQoOt+ZFd/x+rrYfEhMALuuSuINA7Jg5XJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surgut.co.uk; spf=pass smtp.mailfrom=surgut.co.uk; dkim=pass (1024-bit key) header.d=surgut.co.uk header.i=@surgut.co.uk header.b=hsRGQOKt; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surgut.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surgut.co.uk
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b5c18993b73so723350166b.0
        for <linux-arch@vger.kernel.org>; Sun, 26 Oct 2025 16:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=surgut.co.uk; s=google; t=1761519953; x=1762124753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=is27natm4q82ZfjRueAlfHtVSyQtOlMyTtv22WIryvc=;
        b=hsRGQOKtsSEjTRu6s5t/zHvqNcX0sCsq8Kf6xuP6PWBeV6RPobjEeCz9bADYTOTxAP
         5BNfJSOYYxalwx1oyMUxc66d2ru+sIM32G566vggWn1MbG+SAc5ioifeGBsSrwUQ4PF5
         MdF3ZTZloo4VJYIh/Sr8EuCqX84rpJqjQ3iOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761519953; x=1762124753;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=is27natm4q82ZfjRueAlfHtVSyQtOlMyTtv22WIryvc=;
        b=FE0krukGP1644GzxKPyNeqfc3t3iS13M9dKcGupjdwF931jborwE60te3PL2NsrUS/
         X7CBbx8tPY6lSLWcQ5ytLC/JN0T44eth/p+jZz6T8///CUFkHvzt5MGy3Pl0xQMLBgh6
         L6lk12RLjzB0d6ecvAGn2PnLkEA4v4g8vMGcq0ihnLF14/h1mk2t+RyhO//pcQwb0nt1
         8Hj+mD3ItEo9Un6XjvXX9fn/vH1ARXQH0wVLrdTyh8KG8S1rXxipNu+0qTWQTmAQLZ8q
         ojczXC9ZZaMcVTRcGnfwUWg96TfbLD1CoWBbzBQq0rkYNk3CQrB7M4I8y4/Urczvi6Zd
         CHfA==
X-Forwarded-Encrypted: i=1; AJvYcCWfsqBHI9Oghxr6S+nmmW1u9lr0O3xyRvq4ODQUr066J/OhUAqqIzfSa+MsTw28VMlxiMkz2eAxL58Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl43i13sriR2fS+Mx8+u7OuH4+S3UchJt278mS1+scvJSKvR9z
	LryH9ShQbwYwSth3kWMT116PRPz1sAg2t0RUcJkD1m/RnFb+3IXconv4d/A3tzvkk3awoAwiMiP
	nn/Nl6ntSH8dIl7Qgn5sxz9/g8SgaZVx6NMA8wqwkTdXN3CRIa5vGqkQ=
X-Gm-Gg: ASbGncs70lUxDbX32t9+Vz9xBDiIb2dPbduE07WY3wV3kD5SfbPLEAVdPpJ/Y9SxsEn
	3YsUB8X3mhrqkk5Rt5LmLElwYQLpjYcwxfby4JCE4SIEMTPQmso9QQkhR/v06ZIReGjrNLbbDHk
	BEwOndSnoJ40P99cFS8n0oPPtn3ZUIAWz0szogmo2i1titcZZ0xB1xiCCmKVCFjNNzjPz2vHOmT
	vayctRE3REouHD5qkRKo/7NeDjwP+wgzPQKpScphhm/3pUb7YGk/Xw88etQaHEeGemnEYucIdf+
	p7aPrp5V20Yh5yR8xN4=
X-Google-Smtp-Source: AGHT+IE2qeiv6wtEHcxfHTxcz3+g4CqNYkc3SG8aYvr97lhf/t3X5J9M5LV1kA1IPHQlfzD1kGLF4Bc3T0T6p5XwUH0=
X-Received: by 2002:a17:907:1b18:b0:b6d:4080:fdf0 with SMTP id
 a640c23a62f3a-b6d6ff6e411mr962713966b.50.1761519952882; Sun, 26 Oct 2025
 16:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026202100.679989-1-dimitri.ledkov@surgut.co.uk> <20251026215635.GA2368369@ax162>
In-Reply-To: <20251026215635.GA2368369@ax162>
From: Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>
Date: Sun, 26 Oct 2025 23:05:41 +0000
X-Gm-Features: AWmQ_bk-C6yqRcXuQFysCvIdDTFpFqbzjo0WJC8EN1TlWFS6dNkNgds3DoFI9WM
Message-ID: <CANBHLUikrwQS2UcMa1Ryde3r8mPSTCL1WrObF1qKa+o-=MjN=A@mail.gmail.com>
Subject: Re: [PATCH] kbuild: align modinfo section for Secureboot Authenticode
 EDK2 compat
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	masahiroy@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, 
	legion@kernel.org, nsc@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Oct 2025 at 21:56, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Dimitri,
>
> On Sun, Oct 26, 2025 at 08:21:00PM +0000, Dimitri John Ledkov wrote:
> > Previously linker scripts would always generate vmlinuz that has sections
> > aligned. And thus padded (correct Authenticode calculation) and unpadded
>
> Was this something that was guaranteed to happen or did it just always
> happen by coincidence? Is there a way to enforce this?

I don't believe this was ever guaranteed, but out of convenience /
performance / compatibility various sections are aligned and padded
already. Thus it is possible that it was an unwritten contract that
all kernels' sections so far have been padded/aligned on many if not
all UEFI platforms.

From time to time, roughly every 3-5 years since 2012, I experience
this class of bugs in various EFI tooling and/or projects. In all
cases projects agree to produce aligned&padded binaries.
Because it is almost no cost to do so, and it prevents head-scratching
debugging.

I don't know of a good way to enforce this, the pesign tool is a good
way to check this -> as it implements the known padded/nopadding
options to calculate the hashes. Maybe some pefile walk script can be
written to validate/test sections at the end of the kernel build. If
such a tool exists, it would be useful for gnu-efi, grub,
systemd-boot, fwupd, and all kernels.

>
> > calculation would be same. As in https://github.com/rhboot/pesign userspace
> > tool would produce the same authenticode digest for both of the following
> > commands:
> >
> >     pesign --padding --hash --in ./arch/x86_64/boot/bzImage
> >     pesign --nopadding --hash --in ./arch/x86_64/boot/bzImage
> >
> > The commit 3e86e4d74c04 ("kbuild: keep .modinfo section in
> > vmlinux.unstripped") added .modinfo section of variable length. Depending
> > on kernel configuration it may or may not be aligned.
> >
> > All userspace signing tooling correctly pads such section to calculation
> > spec compliant authenticode digest.
>
> I might be missing something here but .modinfo should not be in the
> final vmlinux since it gets stripped out via the strip_relocs rule in
> scripts/Makefile.vmlinux. Does this matter because an unaligned .modinfo
> section could potentially leave sections after it in the linker scripts
> unaligned as well?

I am out of my depth here as well, but yes I too am surprised how the
change in question affected the binary.
Note that .modinfo doesn't declare 0 VMA address, and if one sets it
as .modinfo 0 => linking fails due to overlap.
Thus yes, my naive understanding is that presence of this unaligned
section pushed something else to start on an unaligned address, and
that itself was not padded.
Or maybe strip doesn't recalculate things..... but then is it really
strip at this point if we want it to move sections about and
align/padd them, sounds more like linker script at this point.

When I look with objdump at two vmlinux the working and non-working
one, they look almost identical with nothing standing out. But of
course I only see the top level pefile

Possibly a better way to do this is to indeed have dedicated linker
scripts for uncompressed image with extra metadata and debug info;
uncompressed image without extra metadata/debug; compressed image with
debug info; compressed image without debug info => as direct link
targets, rather than link - then - strip.

>
> > However, if bzImage is not further processed and is attempted to be loaded
> > directly by EDK2 firmware, it calculates unpadded Authenticode digest and
>
> Could this affect other bootloaders as well?

Yes. It can affect lots of tooling that works with EFI binaries such
as signing tools, efivars creation tooling, parsing/wrapper tools,
bootloaders, and boot firmware. Given how niche all of this is, and
because the majority of EFI binaries are padded & aligned, it is
highly unusual when an unagling and/or unpadded one is encountered.

> I noticed this report about
> rEFInd and pointed them here in case it was related:
>
> https://lore.kernel.org/CAB95QARfqSUNJCCgyPcTPu0-hk10e-sOVVMrnpKd6OdV_PHrGA@mail.gmail.com/
>
> > fails to correct accept/reject such kernel builds even when propoer
> > Authenticode values are enrolled in db/dbx. One can say EDK2 requires
> > aligned/padded kernels in Secureboot.
> >
> > Thus add ALIGN(8) to the .modinfo section, to esure kernels irrespective of
> > modinfo contents can be loaded by all existing EDK2 firmware builds.
> >
> > Fixes: 3e86e4d74c04 ("kbuild: keep .modinfo section in vmlinux.unstripped")
>
> I took this change via the Kbuild tree for 6.18-rc1 so I can pick this
> up for kbuild-fixes or Arnd can take this if he has anything pending for
> fixes in the asm-generic tree.
>

This would be very appreciated. Thank you.

> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>
> > ---
> >  include/asm-generic/vmlinux.lds.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index 8a9a2e732a65b..e04d56a5332e6 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -832,7 +832,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
> >
> >  /* Required sections not related to debugging. */
> >  #define ELF_DETAILS                                                  \
> > -             .modinfo : { *(.modinfo) }                              \
> > +             .modinfo : { *(.modinfo) . = ALIGN(8); }                \
> >               .comment 0 : { *(.comment) }                            \
> >               .symtab 0 : { *(.symtab) }                              \
> >               .strtab 0 : { *(.strtab) }                              \
> > --
> > 2.51.0
> >

-- 
Regards,

Dimitri.

