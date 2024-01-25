Return-Path: <linux-arch+bounces-1562-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F5283BF4C
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 11:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB5D28ED68
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 10:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC12B286BC;
	Thu, 25 Jan 2024 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0fQQDUb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22DF482D5;
	Thu, 25 Jan 2024 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179412; cv=none; b=uRKMQxczMgf5iM1lnlNH0eKkjNwi9L5JyS1EPiLZc+oY4fllE7JaD81XTKSp0I9eZu0yJpcPyMGZPhgVQOJ0lzcAnJMxRzcvKHWhIR3qJjXpcV3yg0oScvl2sEjdQhwOx1uB72PotxbQeuEZEL74OhNR6qADa2kJwSAH1NVyutw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179412; c=relaxed/simple;
	bh=Py2LF73U8shcDntKXm/CgbRPin2JI3Z+P47Hz2OLILE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDVDhhGmqTFhu+e4RzZLWFjFNyfdHiMhepABVqZZa5QoSFEVkN7ayo1AtcQ2GdAkFj1I4MxDFIjL7iOhXnIWEbfNAPk2qugbJbrWsnmdA2OvjflPApT2VxQ42Xqd7sHmYDJi5UmedGCCqv01zARWFBCcxdJMLNiIAJsxR/zdaTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0fQQDUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58926C43142;
	Thu, 25 Jan 2024 10:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179412;
	bh=Py2LF73U8shcDntKXm/CgbRPin2JI3Z+P47Hz2OLILE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c0fQQDUbUaQhgtZliLg1cQUQi17sxDSt6cvuB75NXdzyq5Q6hcUYch57y8SZS04Ym
	 EsBMfOCAvBYOZMR+p/HVbLREs40lr94g1LsKP+AZh4iWwDRr576GQCLpHRZuCt3T4H
	 JXPxl4RjJ2jwNy82JGDvsBPZu1CFEusYHFeB571AK4Uqv2YZbFToVgn5bmA/PIvx2g
	 ti2OywY4B1SKvi+R7FWKyaXPQC0SFLBSdgt8WDo7GkE2Ip0irgDhdwyHja76+GcZd+
	 FdSSnBGF6Wav8Dw8e0iVSZbtEV/LBQyDv3s0yd3ICsATiU8Vf4xIOwkLas6cfyDc4/
	 Nt0xeSwn2Wl1w==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5100ed2b33dso2735563e87.0;
        Thu, 25 Jan 2024 02:43:32 -0800 (PST)
X-Gm-Message-State: AOJu0YzyoUCFFNUNboXU66TX5Z0uqqy49OwY29+1DwgdkZDl4dnnYXdr
	oHM7vhobmiSh3suTMr1ptBDcSjDBTL+LV3I+QvfiunVt5W4r215kUwNipOMBUv0COJVCHXzJOQB
	pIU8FnzjQwRuUJMo+wXbkppeV+P0=
X-Google-Smtp-Source: AGHT+IFzqU6KFy5dmynIG7b/rjXy30IO4eSr+xkdm3d1vUzKQXjGUXxD9uNgwDzmUhavcOnStrzpF48+sogOE7LAs2Y=
X-Received: by 2002:ac2:5459:0:b0:50e:76b0:7374 with SMTP id
 d25-20020ac25459000000b0050e76b07374mr320004lfn.32.1706179410416; Thu, 25 Jan
 2024 02:43:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122090851.851120-7-ardb+git@google.com> <20240122090851.851120-11-ardb+git@google.com>
 <CAMzpN2jcWxCy=H-1uvS7kN8gVohee2_cMwyC0SbSEwEoedo3WQ@mail.gmail.com> <20240122224417.GC141255@dev-fedora.aadp>
In-Reply-To: <20240122224417.GC141255@dev-fedora.aadp>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 25 Jan 2024 11:43:18 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG+97DPc9Ws-5=QrrHmf+KyvfqgoDFwLCV2Afy3ZJQM2Q@mail.gmail.com>
Message-ID: <CAMj1kXG+97DPc9Ws-5=QrrHmf+KyvfqgoDFwLCV2Afy3ZJQM2Q@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] x86/head64: Replace pointer fixups with PIE codegen
To: Nathan Chancellor <nathan@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>, Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jan 2024 at 23:44, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, Jan 22, 2024 at 02:34:46PM -0500, Brian Gerst wrote:
> > On Mon, Jan 22, 2024 at 4:14=E2=80=AFAM Ard Biesheuvel <ardb+git@google=
.com> wrote:
> > >
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Some of the C code in head64.c may be called from a different virtual
> > > address than it was linked at. Currently, we deal with this by using
> > > ordinary, position dependent codegen, and fixing up all symbol
> > > references on the fly. This is fragile and tricky to maintain. It is
> > > also unnecessary: we can use position independent codegen (with hidde=
n
> > > visibility) to ensure that all compiler generated symbol references a=
re
> > > RIP-relative, removing the need for fixups entirely.
> > >
> > > It does mean we need explicit references to kernel virtual addresses =
to
> > > be generated by hand, so generate those using a movabs instruction in
> > > inline asm in the handful places where we actually need this.
> > >
> > > While at it, move these routines to .inittext where they belong.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/x86/Makefile                 |  11 ++
> > >  arch/x86/boot/compressed/Makefile |   2 +-
> > >  arch/x86/include/asm/init.h       |   2 -
> > >  arch/x86/include/asm/setup.h      |   2 +-
> > >  arch/x86/kernel/Makefile          |   4 +
> > >  arch/x86/kernel/head64.c          | 117 +++++++-------------
> > >  6 files changed, 60 insertions(+), 78 deletions(-)
> > >
> > > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > > index 1a068de12a56..bed0850d91b0 100644
> > > --- a/arch/x86/Makefile
> > > +++ b/arch/x86/Makefile
> > > @@ -168,6 +168,17 @@ else
> > >          KBUILD_CFLAGS +=3D -mcmodel=3Dkernel
> > >          KBUILD_RUSTFLAGS +=3D -Cno-redzone=3Dy
> > >          KBUILD_RUSTFLAGS +=3D -Ccode-model=3Dkernel
> > > +
> > > +       PIE_CFLAGS :=3D -fpie -mcmodel=3Dsmall \
> > > +                     -include $(srctree)/include/linux/hidden.h
> > > +
> > > +       ifeq ($(CONFIG_STACKPROTECTOR),y)
> > > +               ifeq ($(CONFIG_SMP),y)
> > > +                       PIE_CFLAGS +=3D -mstack-protector-guard-reg=
=3Dgs
> > > +               endif
> >
> > This compiler flag requires GCC 8.1 or later.  When I posted a patch
> > series[1] to convert the stack protector to a normal percpu variable
> > instead of the fixed offset, there was pushback over requiring GCC 8.1
> > to keep stack protector support.  I added code to objtool to convert
> > code from older compilers, but there hasn't been any feedback since.
> > Similar conversion code would be needed in objtool for this unless the
> > decision is made to require GCC 8.1 for stack protector support going
> > forward.
> >
> > Brian Gerst
> >
> > [1] https://lore.kernel.org/lkml/20231115173708.108316-1-brgerst@gmail.=
com/
>
> I was going to comment on this as well, as that flag was only supported
> in clang 12.0.0 and newer. It should not be too big of a deal for us
> though, as I was already planning on bumping the minimum supported
> version of clang for building the kernel to 13.0.1 (but there may be
> breakage reports if this series lands before that):
>

Thanks for pointing this out.

Given that building the entire kernel with fPIC is neither necessary
nor sufficient, I am going to abandon this approach.

If we apply fPIC to only a handful of compilation units containing
code that runs from the 1:1 mapping, it is not unreasonable to simply
disable the stack protector altogether for those pieces too. This
works around the older GCC issue.

