Return-Path: <linux-arch+bounces-1915-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A35844123
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 14:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E36528733E
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 13:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5D87BAFA;
	Wed, 31 Jan 2024 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMJM9ktc"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7349B7866F;
	Wed, 31 Jan 2024 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709451; cv=none; b=AmsAIh3a1JX/HTHPzpuphY/YzYacyl0VHxLH/9sD18YAo0VAD4BcqSKfmatzYfPbvYvL0Jq02N9zyRQ5p0MY67h9aV7CczKhThkV6znDdeIQTciAL4b1brXEFsSgm9N+bVFvcZALqPO19k9BzHFmi6XH/a9i/e/MPpb23G4CJ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709451; c=relaxed/simple;
	bh=nLvzwb6WYwRoyrFoBK7xr3Ig0dOYx8JY28+OYqJ4wAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJv8ZnVc4xjA1ydXvNJtIygLXyT6pgHC7IobtQ35weA7bl8tUSSXjZrMJisvYGTmNFygTObgF11zOc6F/heZs0tRx8Z9NWA6xc86pSo4zzlGeP16orqJi0YXRppQNs+ReVDD7s+PXPwBO80AeyGxw6QrHl58fvwTCsgmT8Pr/f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMJM9ktc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482A5C433C7;
	Wed, 31 Jan 2024 13:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706709451;
	bh=nLvzwb6WYwRoyrFoBK7xr3Ig0dOYx8JY28+OYqJ4wAE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JMJM9ktcnrmUtDHOzMgMydX0TzI+TQgzOdnVQZlAwuF7himMX6COXvBqgs785UpQ6
	 O0jSx/fOukXyp+nn4TIEkZAhXE/96/L3bRebV/UC+givnL9IvqbHa9H5Ma/9ZzpqcK
	 /15dYAELntgCU2xsAEY2xaTFs1jedkULLNmdi7f40VdAP+iS/WXdRoalRK4z3VID3t
	 UCYeJtmrER5z/4xL1bz/BTphqkQLQvbFlQsx08bkI7oMBSnnRCTvD52ujkJIByE35N
	 OMGqTxI01L+tvZoc41J3ghLjPobM61vnrgrXXrXw2S7fVMMNVv0t6IwFgk/ghbk8vk
	 UpZyn7atMR6RQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cf588c4dbcso50606941fa.1;
        Wed, 31 Jan 2024 05:57:31 -0800 (PST)
X-Gm-Message-State: AOJu0Ywiu5QCo/4CW8TcDLKr0GwNTdAZMW08w/ZN8RAtjtGCcObzXcyE
	+uTzk6okXyFNrvAVMDWCYBuBz2kKGrSwcyUaIerRmRWqxuC3/ugr0mP18Rqn3a91mIylHLtLqyE
	Db0MHpxUi0KrPNBSrL0VF8eFMD4A=
X-Google-Smtp-Source: AGHT+IE5KOp/oqYq4S5cBEtKvQDaGkC8zXIG3DeDsiZ++cOC6WwUL+DXRU3gVuk676tBxlVNSAp8wTW59zMONGU7b3I=
X-Received: by 2002:a05:651c:19a8:b0:2ce:fa00:9b0a with SMTP id
 bx40-20020a05651c19a800b002cefa009b0amr1505548ljb.16.1706709449515; Wed, 31
 Jan 2024 05:57:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-24-ardb+git@google.com> <20240131134431.GJZbpOvz3Ibhg4VhCl@fat_crate.local>
In-Reply-To: <20240131134431.GJZbpOvz3Ibhg4VhCl@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 31 Jan 2024 14:57:18 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF7T4morB+Z3BDy-UaeHoeU6fHtnaa-7HJY_NR3RVC5sg@mail.gmail.com>
Message-ID: <CAMj1kXF7T4morB+Z3BDy-UaeHoeU6fHtnaa-7HJY_NR3RVC5sg@mail.gmail.com>
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

On Wed, 31 Jan 2024 at 14:45, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Jan 29, 2024 at 07:05:06PM +0100, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Since commit 866b556efa12 ("x86/head/64: Install startup GDT"), the
> > primary startup sequence sets the code segment register (CS) to __KERNEL_CS
> > before calling into the startup code shared between primary and
> > secondary boot.
> >
> > This means a simple indirect call is sufficient here.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/kernel/head_64.S | 35 ++------------------
> >  1 file changed, 3 insertions(+), 32 deletions(-)
> >
> > diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> > index d4918d03efb4..4017a49d7b76 100644
> > --- a/arch/x86/kernel/head_64.S
> > +++ b/arch/x86/kernel/head_64.S
> > @@ -428,39 +428,10 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
> >       movq    %r15, %rdi
> >
> >  .Ljump_to_C_code:
> > -     /*
> > -      * Jump to run C code and to be on a real kernel address.
> > -      * Since we are running on identity-mapped space we have to jump
> > -      * to the full 64bit address, this is only possible as indirect
> > -      * jump.  In addition we need to ensure %cs is set so we make this
> > -      * a far return.
> > -      *
> > -      * Note: do not change to far jump indirect with 64bit offset.
> > -      *
> > -      * AMD does not support far jump indirect with 64bit offset.
> > -      * AMD64 Architecture Programmer's Manual, Volume 3: states only
> > -      *      JMP FAR mem16:16 FF /5 Far jump indirect,
> > -      *              with the target specified by a far pointer in memory.
> > -      *      JMP FAR mem16:32 FF /5 Far jump indirect,
> > -      *              with the target specified by a far pointer in memory.
> > -      *
> > -      * Intel64 does support 64bit offset.
> > -      * Software Developer Manual Vol 2: states:
> > -      *      FF /5 JMP m16:16 Jump far, absolute indirect,
> > -      *              address given in m16:16
> > -      *      FF /5 JMP m16:32 Jump far, absolute indirect,
> > -      *              address given in m16:32.
> > -      *      REX.W + FF /5 JMP m16:64 Jump far, absolute indirect,
> > -      *              address given in m16:64.
> > -      */
> > -     pushq   $.Lafter_lret   # put return address on stack for unwinder
> >       xorl    %ebp, %ebp      # clear frame pointer
> > -     movq    initial_code(%rip), %rax
> > -     pushq   $__KERNEL_CS    # set correct cs
> > -     pushq   %rax            # target address in negative space
> > -     lretq
> > -.Lafter_lret:
> > -     ANNOTATE_NOENDBR
> > +     ANNOTATE_RETPOLINE_SAFE
> > +     callq   *initial_code(%rip)
> > +     int3
> >  SYM_CODE_END(secondary_startup_64)
> >
> >  #include "verify_cpu.S"
>
> objtool doesn't like it yet:
>
> vmlinux.o: warning: objtool: verify_cpu+0x0: stack state mismatch: cfa1=4+8 cfa2=-1+0
>
> Once we've solved this, I'll take this one even now - very nice cleanup!
>

s/int3/RET seems to do the trick.

As long as there is an instruction that follows the callq, the
unwinder will see secondary_startup_64 at the base of the call stack.
We never return here anyway.

