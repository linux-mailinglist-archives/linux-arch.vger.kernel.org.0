Return-Path: <linux-arch+bounces-2337-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0035785436A
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 08:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7BCD1F2317F
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 07:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BC111C80;
	Wed, 14 Feb 2024 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYP0N+9w"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294E311731;
	Wed, 14 Feb 2024 07:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707895735; cv=none; b=iirkwHxLWzNIMICHrlIu60Z7sriL4KYhaepY285aabKAE/x9mHQ7dyhCupiatqk7g90GeloQR8T3Uio05F8XT7ruDKfGYnmRnfIoXul8oXoO19bv2WpzM5dTvFSZgw/L7/vYRSMQpz65wUKDrJGXqYCX5PcWmQzH9PNOO+VgFTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707895735; c=relaxed/simple;
	bh=193v/W9i2ERfHNUMgfSABTMbWEw8kJdYQvvqGCxRdl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VU5z7pTNuOVqm+cRwZT6IB7dDqSYgg6ye2hXTsBDK8/C9y1F8TRhSfbyaHllgbYpqaWLZzH1dX6iEjuZQbPNYZ4N7aBduylQD91eH97LPE+CBF4AMqc8BzWG6p3sTaFhKV+l2u0l/U69WxMgyYkAE0SZMJOBJ2WVtKP0zA3mVPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYP0N+9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8CBC43601;
	Wed, 14 Feb 2024 07:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707895734;
	bh=193v/W9i2ERfHNUMgfSABTMbWEw8kJdYQvvqGCxRdl0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uYP0N+9wBwi/1g/8CtcqR4KmpTKXE7wAa+NSqQoOiXCZ4T2v/xCqqT+BK3SaQC3pX
	 VpyR898Vg3HqW7VzkohGBgCi7O/IkL0OaNHr2DZFXrsU0j/Q5V0WKTU6wuVsGuGAkN
	 ON5dzOd5STH1PkweByWFMGTnu28Yjn+shjv1f9+z6yDalZpE0fvX1MSm9AJTPZM7ta
	 u0HdyZzZE+boIF5AwcJ9WjKBH8yexnmoQc2hSxEMSpCLNoN4tI6XVjYwbKl514rlZz
	 MEtSAZXvuA2KIijq64oGhmzy1g6Z75dFTGK4qAeKWvzBPR7AphdXRITvAlvRfcWmFd
	 3qikjoF2JQV0g==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d0cd9871b3so3956941fa.1;
        Tue, 13 Feb 2024 23:28:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXppXOyhZstcJceFofxLRWnW2QIqHNMjarjVEwjs+FqbCgUldm8Y7tA5TXw3wOtHyyFjRc/ojO/0aOGriDpIuWs7+gQnNmdEgHjvbUzEYUkOGqO+0AAA7CKd8KwXZGHWsB7V7POTjZUgA==
X-Gm-Message-State: AOJu0YzBFXkTbvjtlYU+RTR7BWaiuX4iXFTSJfkqsrsvVYvf8vXugqwa
	hZqKBGlB9sFcZvgCrUrnfO4x1y4MxJdaWakAJRpzZAztGxuqupmIzypgDRCdPbTLNG8XHmkt044
	aQe2VbPkplgAzGeu+NPU8WUz8p0I=
X-Google-Smtp-Source: AGHT+IEqt4BKQ9Y/nYdGfYCcllEmArSxZqjfK/gjK0QYvvSclBfPOgFcv1FCWgqasjjJ/YUMyF8T/FNuzwzM8YrBMq8=
X-Received: by 2002:a19:655e:0:b0:511:9f53:3974 with SMTP id
 c30-20020a19655e000000b005119f533974mr373057lfj.2.1707895732786; Tue, 13 Feb
 2024 23:28:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-14-ardb+git@google.com> <20240213200553.GYZcvLoYUNJOPGxoid@fat_crate.local>
 <CAMj1kXG4rSGaB8Q2qFcgOH=dqS0yvR8Ofur=h5C-jq_TqiFzVg@mail.gmail.com>
In-Reply-To: <CAMj1kXG4rSGaB8Q2qFcgOH=dqS0yvR8Ofur=h5C-jq_TqiFzVg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 14 Feb 2024 08:28:41 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFdUD_kCh0h1HcpOVoQJNcP11OHB+FJ-=HGfP3RRdy81w@mail.gmail.com>
Message-ID: <CAMj1kXFdUD_kCh0h1HcpOVoQJNcP11OHB+FJ-=HGfP3RRdy81w@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] x86/startup_64: Simplify global variable
 accesses in GDT/IDT programming
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

On Tue, 13 Feb 2024 at 22:53, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 13 Feb 2024 at 21:06, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Tue, Feb 13, 2024 at 01:41:45PM +0100, Ard Biesheuvel wrote:
> > > @@ -632,5 +616,5 @@ void __head startup_64_setup_env(unsigned long physbase)
> > >                    "movl %%eax, %%ss\n"
> > >                    "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
> > >
> > > -     startup_64_load_idt(physbase);
> > > +     startup_64_load_idt(&RIP_REL_REF(vc_no_ghcb));
> >
> > It took me a while to figure out that even if we pass in one of the two
> > GHCB handler pointers, we only set it if CONFIG_AMD_MEM_ENCRYPT.
> >
> > I think this ontop of yours is a bit more readable as it makes it
> > perfectly clear *when* the pointer is valid.
> >
>
> Looks fine to me.
>
> > Yeah, if handler is set, we set it for the X86_TRAP_VC vector
> > unconditionally but that can be changed later, if really needed.
> >
>
> We might call the parameter 'vc_handler' to make this clearer.

Actually, we can merge set_bringup_idt_handler() into its caller as well:

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index aee99cfda4eb..804ba9a2214f 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -501,30 +501,22 @@ void __init __noreturn
x86_64_start_reservations(char *real_mode_data)
  */
 static gate_desc bringup_idt_table[NUM_EXCEPTION_VECTORS] __page_aligned_data;

-static void __head set_bringup_idt_handler(gate_desc *idt, int n,
void *handler)
-{
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-       struct idt_data data;
-       gate_desc desc;
-
-       init_idt_data(&data, n, handler);
-       idt_init_desc(&desc, &data);
-       native_write_idt_entry(idt, n, &desc);
-#endif
-}
-
 /* This may run while still in the direct mapping */
-static void __head startup_64_load_idt(void *handler)
+static void __head startup_64_load_idt(void *vc_handler)
 {
        struct desc_ptr desc = {
                .address        = (unsigned
long)&RIP_REL_REF(bringup_idt_table),
                .size           = sizeof(bringup_idt_table) - 1,
        };
-       gate_desc *idt = (gate_desc *)desc.address;
+       struct idt_data data;
+       gate_desc idt_desc;

-       if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
-               /* VMM Communication Exception */
-               set_bringup_idt_handler(idt, X86_TRAP_VC, handler);
+       if (vc_handler) {
+               init_idt_data(&data, X86_TRAP_VC, vc_handler);
+               idt_init_desc(&idt_desc, &data);
+               native_write_idt_entry((gate_desc *)desc.address,
+                                      X86_TRAP_VC, &idt_desc);
+       }

        native_load_idt(&desc);
 }


(^^^ plus your changes boot tested on SEV-SNP)

