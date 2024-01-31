Return-Path: <linux-arch+bounces-1917-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4882784415F
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 15:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84B01F25AAC
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 14:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E0883CBB;
	Wed, 31 Jan 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYQ1foks"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A6983CB7;
	Wed, 31 Jan 2024 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710084; cv=none; b=CKKEvXcFQ1MyEcOdk5IEiC9ipnmqxA2e35iy2DwSnyVaxJKzMiX7Y7KxWLFTOGnlfa1u0mGkQR/zGp668kDnkUdy/PIZRPsu3+pbAOu2Zk1O2AnDjXYASUU/QavJAPg5KMVxSLT3jC2nU8PWyUGZiyID1nxg1JvU3K8IStUb8HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710084; c=relaxed/simple;
	bh=5nR7Ertacn9PuZp1Bn/nWb7jPB+VBrlLCjXLDoq7d5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iL+/gKFNu/tf2/gzRRuF3oqe5nX9sldUGyvIv1r2zy1EBP0wjxfqDwDkgRncpZav8HqrQsvRACiCxkUQMVvHdgbUeCTkNaxU19hkWw4580/B1hMeEwvHvETKFxxv6c13TZ+5isaLf5rqj8Wj5/DAbCFfxGl6rXLWzHAOqH45Joc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYQ1foks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BBCC43601;
	Wed, 31 Jan 2024 14:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706710083;
	bh=5nR7Ertacn9PuZp1Bn/nWb7jPB+VBrlLCjXLDoq7d5k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iYQ1foksziyUWYW8tRQV+ff4NIPx+pD2QLp+msKwoB4/FOncHJiUe52cbJxGW58pZ
	 68GXvryC227ayGT6fc5gJ4pwcggz7j1B53SnHc6AQZsw9aDT87svSQDKuqN7GcIPhm
	 LwFIsszth8jeuDwoCP0AelpQi4yrHXtQMLGpxdx9H38b9rya03pygUvtOM23wpCK7R
	 lACMem1wB+vEOK2igAPErOGXMTlIhdSGettMAy/TI7DUn9VyKqwPegQ0n/kG6nEOGM
	 XL+L4/SmUjBFxNeUMyjvhUCBo6kGUD6NuXgan/80gs6rRn1oK67xRQ328YnLIKfqcB
	 z1BXYU07RZS8g==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51124e31f72so916725e87.0;
        Wed, 31 Jan 2024 06:08:03 -0800 (PST)
X-Gm-Message-State: AOJu0Yw08C8o0f8Gx88lRA7ALlR7OjWEiNfp2rPi2YuZMzwxf/x2m8DK
	ikemLoB6XJsZyInLEamhydVEiurIyoiefiWlqdZ3DJiInXvevEWBBNnjL1D3anTLpqphvILNYCk
	rCTB0h2xjpBM20R2fI/eChrFUtF8=
X-Google-Smtp-Source: AGHT+IEWOX5OhqEdfMQM4e2B9NE+FH+r8iCudVcs4e/r9DjBBtoSKBUY5Wgyaf1OXbZRbRm3omEFOmJJTybR5NzVdxo=
X-Received: by 2002:a19:8c4e:0:b0:511:18e4:89bb with SMTP id
 i14-20020a198c4e000000b0051118e489bbmr1384753lfj.39.1706710081908; Wed, 31
 Jan 2024 06:08:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-24-ardb+git@google.com> <20240131134431.GJZbpOvz3Ibhg4VhCl@fat_crate.local>
 <CAMj1kXF7T4morB+Z3BDy-UaeHoeU6fHtnaa-7HJY_NR3RVC5sg@mail.gmail.com>
In-Reply-To: <CAMj1kXF7T4morB+Z3BDy-UaeHoeU6fHtnaa-7HJY_NR3RVC5sg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 31 Jan 2024 15:07:50 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGk1QivyoK4H5CVp7p-tfYoQSTuethpkm8bWBcTO_UMGw@mail.gmail.com>
Message-ID: <CAMj1kXGk1QivyoK4H5CVp7p-tfYoQSTuethpkm8bWBcTO_UMGw@mail.gmail.com>
Subject: Re: [PATCH v3 03/19] x86/startup_64: Drop long return to initial_code pointer
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jan 2024 at 14:57, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 31 Jan 2024 at 14:45, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Mon, Jan 29, 2024 at 07:05:06PM +0100, Ard Biesheuvel wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Since commit 866b556efa12 ("x86/head/64: Install startup GDT"), the
> > > primary startup sequence sets the code segment register (CS) to __KERNEL_CS
> > > before calling into the startup code shared between primary and
> > > secondary boot.
> > >
> > > This means a simple indirect call is sufficient here.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/x86/kernel/head_64.S | 35 ++------------------
> > >  1 file changed, 3 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> > > index d4918d03efb4..4017a49d7b76 100644
> > > --- a/arch/x86/kernel/head_64.S
> > > +++ b/arch/x86/kernel/head_64.S
> > > @@ -428,39 +428,10 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
> > >       movq    %r15, %rdi
> > >
> > >  .Ljump_to_C_code:
> > > -     /*
> > > -      * Jump to run C code and to be on a real kernel address.
> > > -      * Since we are running on identity-mapped space we have to jump
> > > -      * to the full 64bit address, this is only possible as indirect
> > > -      * jump.  In addition we need to ensure %cs is set so we make this
> > > -      * a far return.
> > > -      *
> > > -      * Note: do not change to far jump indirect with 64bit offset.
> > > -      *
> > > -      * AMD does not support far jump indirect with 64bit offset.
> > > -      * AMD64 Architecture Programmer's Manual, Volume 3: states only
> > > -      *      JMP FAR mem16:16 FF /5 Far jump indirect,
> > > -      *              with the target specified by a far pointer in memory.
> > > -      *      JMP FAR mem16:32 FF /5 Far jump indirect,
> > > -      *              with the target specified by a far pointer in memory.
> > > -      *
> > > -      * Intel64 does support 64bit offset.
> > > -      * Software Developer Manual Vol 2: states:
> > > -      *      FF /5 JMP m16:16 Jump far, absolute indirect,
> > > -      *              address given in m16:16
> > > -      *      FF /5 JMP m16:32 Jump far, absolute indirect,
> > > -      *              address given in m16:32.
> > > -      *      REX.W + FF /5 JMP m16:64 Jump far, absolute indirect,
> > > -      *              address given in m16:64.
> > > -      */
> > > -     pushq   $.Lafter_lret   # put return address on stack for unwinder
> > >       xorl    %ebp, %ebp      # clear frame pointer
> > > -     movq    initial_code(%rip), %rax
> > > -     pushq   $__KERNEL_CS    # set correct cs
> > > -     pushq   %rax            # target address in negative space
> > > -     lretq
> > > -.Lafter_lret:
> > > -     ANNOTATE_NOENDBR
> > > +     ANNOTATE_RETPOLINE_SAFE
> > > +     callq   *initial_code(%rip)
> > > +     int3
> > >  SYM_CODE_END(secondary_startup_64)
> > >
> > >  #include "verify_cpu.S"
> >
> > objtool doesn't like it yet:
> >
> > vmlinux.o: warning: objtool: verify_cpu+0x0: stack state mismatch: cfa1=4+8 cfa2=-1+0
> >
> > Once we've solved this, I'll take this one even now - very nice cleanup!
> >
>
> s/int3/RET seems to do the trick.
>

or ud2, even better,

