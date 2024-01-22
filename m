Return-Path: <linux-arch+bounces-1433-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16501837675
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 23:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0DE3287116
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 22:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF1D10797;
	Mon, 22 Jan 2024 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLHYMEdJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A19918C20;
	Mon, 22 Jan 2024 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705963460; cv=none; b=HdWqdY6acF/pmZG92JZ2QKm6fSv9v74uosjJmkyLDOoeC5OuekXOLh6IYWGowtaFlPXalgnou1LJKSr86sr8dPAnNyqttvb8seNMYxdHMd890nPLbiHmjXO5eFNc9vur21U3TYIJp9Be+DH3AOVcmS44DmluXj7uQ67N/bL5FU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705963460; c=relaxed/simple;
	bh=3ZJ7NcHOCt+uRRkFfJmhYkl2OuZDA6RPu5bNjKRanJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaORUGjWRCn39VXVSRSu3Zi9MdbJDwc2WeJE1t3odn9z+29BX76a1cFhaNu84Gy13v3+IQCQVMvtjAWZUuSL1u+ZzSCEz+vFqL8OjeZHQOcn3GiatDa8h3LPsQJhdzpLphDelLYYIz2ic4iYHQUX2Bc3PApHRWZTXzxg6KbVozo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLHYMEdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D254BC433F1;
	Mon, 22 Jan 2024 22:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705963459;
	bh=3ZJ7NcHOCt+uRRkFfJmhYkl2OuZDA6RPu5bNjKRanJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TLHYMEdJOaYU4N2nkXJatHz+9NlQBwCFlgDjalZHBKdLUFrKpYZAwJbyzqLoSa4WO
	 TGpfchmYGVFGaRUfdzCH4VM4ydKiZs2OJoUUJTgwW9+D3CE8yZsjtE17Z1+54x17XD
	 /KRqsHzPioAkpcnRMDy8guO9/htmxzlPscrL7IDekXS0bglmUJeoBLb06KgeN5oqA8
	 eJXu/lYfUPEd0Nr73YgKs4Zzai1dKTKzz6DmLHhjj/ELQ5weYQpAF0HXilz/cObz/1
	 0ojyCVVOjazDuR7Tzm+scnQFxX2nckEo1m6/c5aa5tXj1lQZ+eirLkjYShoyMZe38z
	 O4dZTXCYwxk8g==
Date: Mon, 22 Jan 2024 15:44:17 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-arch@vger.kernel.org,
	bpf@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH 4/5] x86/head64: Replace pointer fixups with PIE
 codegen
Message-ID: <20240122224417.GC141255@dev-fedora.aadp>
References: <20240122090851.851120-7-ardb+git@google.com>
 <20240122090851.851120-11-ardb+git@google.com>
 <CAMzpN2jcWxCy=H-1uvS7kN8gVohee2_cMwyC0SbSEwEoedo3WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMzpN2jcWxCy=H-1uvS7kN8gVohee2_cMwyC0SbSEwEoedo3WQ@mail.gmail.com>

On Mon, Jan 22, 2024 at 02:34:46PM -0500, Brian Gerst wrote:
> On Mon, Jan 22, 2024 at 4:14 AM Ard Biesheuvel <ardb+git@google.com> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Some of the C code in head64.c may be called from a different virtual
> > address than it was linked at. Currently, we deal with this by using
> > ordinary, position dependent codegen, and fixing up all symbol
> > references on the fly. This is fragile and tricky to maintain. It is
> > also unnecessary: we can use position independent codegen (with hidden
> > visibility) to ensure that all compiler generated symbol references are
> > RIP-relative, removing the need for fixups entirely.
> >
> > It does mean we need explicit references to kernel virtual addresses to
> > be generated by hand, so generate those using a movabs instruction in
> > inline asm in the handful places where we actually need this.
> >
> > While at it, move these routines to .inittext where they belong.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/Makefile                 |  11 ++
> >  arch/x86/boot/compressed/Makefile |   2 +-
> >  arch/x86/include/asm/init.h       |   2 -
> >  arch/x86/include/asm/setup.h      |   2 +-
> >  arch/x86/kernel/Makefile          |   4 +
> >  arch/x86/kernel/head64.c          | 117 +++++++-------------
> >  6 files changed, 60 insertions(+), 78 deletions(-)
> >
> > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > index 1a068de12a56..bed0850d91b0 100644
> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -168,6 +168,17 @@ else
> >          KBUILD_CFLAGS += -mcmodel=kernel
> >          KBUILD_RUSTFLAGS += -Cno-redzone=y
> >          KBUILD_RUSTFLAGS += -Ccode-model=kernel
> > +
> > +       PIE_CFLAGS := -fpie -mcmodel=small \
> > +                     -include $(srctree)/include/linux/hidden.h
> > +
> > +       ifeq ($(CONFIG_STACKPROTECTOR),y)
> > +               ifeq ($(CONFIG_SMP),y)
> > +                       PIE_CFLAGS += -mstack-protector-guard-reg=gs
> > +               endif
> 
> This compiler flag requires GCC 8.1 or later.  When I posted a patch
> series[1] to convert the stack protector to a normal percpu variable
> instead of the fixed offset, there was pushback over requiring GCC 8.1
> to keep stack protector support.  I added code to objtool to convert
> code from older compilers, but there hasn't been any feedback since.
> Similar conversion code would be needed in objtool for this unless the
> decision is made to require GCC 8.1 for stack protector support going
> forward.
> 
> Brian Gerst
> 
> [1] https://lore.kernel.org/lkml/20231115173708.108316-1-brgerst@gmail.com/

I was going to comment on this as well, as that flag was only supported
in clang 12.0.0 and newer. It should not be too big of a deal for us
though, as I was already planning on bumping the minimum supported
version of clang for building the kernel to 13.0.1 (but there may be
breakage reports if this series lands before that):

https://lore.kernel.org/20240110165339.GA3105@dev-arch.thelio-3990X/

Cheers,
Nathan

