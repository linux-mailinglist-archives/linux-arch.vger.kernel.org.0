Return-Path: <linux-arch+bounces-2702-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D064A86124E
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 14:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796C31F21113
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 13:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26DB7E76C;
	Fri, 23 Feb 2024 13:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ebvv/7s7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B924B7CF07;
	Fri, 23 Feb 2024 13:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693884; cv=none; b=fLPNoUNBTSwRW38adsmNl3zg92UBohMqppR4zed7v5htowuWvMJUg75fWx8kd6I2j/QrfPUGuBLAnUsJU9td768ZL60PwHxmUEiwq8+WbJZ5WOS0pofai5Qto8spfgJD2ifsugF9FSLvmj/uH2iE/nPXyvdckMk0DJP+ht3BNxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693884; c=relaxed/simple;
	bh=d1m6ANOqwKXrv9+LcTPfoOJ4sArWK9YSnVhDFXtLuLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lx3JZ3NrSGH5qSMgB0bp/trvwUk2afuc74ueeysJJlH/vE8GmpPOAZKX43KShrJsuDqxGzusgadzAdsylOL8WIuD2odA2aq9UZjIZYt77992T4pgvwSvS4SEmYdLwoi25lhI+UDgea7hHj14Nt0pdXqSq+NMjl6lzN2Jn4CIkAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ebvv/7s7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614C8C433C7;
	Fri, 23 Feb 2024 13:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708693884;
	bh=d1m6ANOqwKXrv9+LcTPfoOJ4sArWK9YSnVhDFXtLuLM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ebvv/7s7jWF2knmh/ApfiKPoZn0oY+OtXfdntU0JDB3IRn1weaXAs2oj5e6FgE6if
	 NoDIAxh0S3r3CUya7AwGYF9zOp2ptIjiZ0WVjv3lyE/GLlfTtrocbBYJCTPYPjDMo5
	 yX9reo68M+CS5EW2gtEs/r6Ugly+IiRj6qzESy192jTFPuXzWKCplHVM4PqFnA+r6z
	 qX15Gq/aeAGQCmxRN49SvTNgOgLwUZOxSxsik0hVu6/LszsF2D/r17uQyat1VpDDGm
	 KdCEO9JbZ/sdem6Ci+kX7Y5sXggbUrtPFdFOvQ/mThTS8xliNN6jOZEi0tMoFI+PZo
	 1gjKojxyEhgrQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d204e102a9so8642121fa.0;
        Fri, 23 Feb 2024 05:11:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUd2ZUENFtg0IXpxW6BNuFwxULIdRrjxJ11bvZsYB++uZGwd9qulkPjuTKWBnEQAoAS9XPtZxdlZCRDlQe4HTgac1+MAasjISQ9zg==
X-Gm-Message-State: AOJu0Yxsut8/N5nSqmdOxVEvlttqqsBH+SCIb3bYLJ6toRalUKPL4gYJ
	LsC5v7ACSN0MNUFX2l1V1JRQ3jPZt0ux9p8Un30cU26PnXKzGdBR5qSOYkP4Abrr9A164qo8Bg8
	G6wcYTMDVttjHl21TG3GcxX1nid4=
X-Google-Smtp-Source: AGHT+IEsCg2Q0TwrKd0cog82aTVDxFfxFpKuZiqhdev7tD/NUay4QE8lNuoY0iLfx2wJjeRraE2dvnF5myz898EFVRQ=
X-Received: by 2002:a05:651c:204f:b0:2d2:3f1d:92ec with SMTP id
 t15-20020a05651c204f00b002d23f1d92ecmr1220780ljo.40.1708693882639; Fri, 23
 Feb 2024 05:11:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221113506.2565718-18-ardb+git@google.com> <20240221113506.2565718-28-ardb+git@google.com>
In-Reply-To: <20240221113506.2565718-28-ardb+git@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 23 Feb 2024 14:11:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGFP0oz=7_4sW=Cd-n2k5=M6Nzzrst-dAdkYtmdeTqYrg@mail.gmail.com>
Message-ID: <CAMj1kXGFP0oz=7_4sW=Cd-n2k5=M6Nzzrst-dAdkYtmdeTqYrg@mail.gmail.com>
Subject: Re: [PATCH v5 10/16] x86/startup_64: Simplify virtual switch on
 primary boot
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 12:36, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The secondary startup code is used on the primary boot path as well, but
> in this case, the initial part runs from a 1:1 mapping, until an
> explicit cross-jump is made to the kernel virtual mapping of the same
> code.
>
> On the secondary boot path, this jump is pointless as the code already
> executes from the mapping targeted by the jump. So combine this
> cross-jump with the jump from startup_64() into the common boot path.
> This simplifies the execution flow, and clearly separates code that runs
> from a 1:1 mapping from code that runs from the kernel virtual mapping.
>
> Note that this requires a page table switch, so hoist the CR3 assignment
> into startup_64() as well. And since absolute symbol references will no
> longer be permitted in .head.text once we enable the associated build
> time checks, a RIP-relative memory operand is used in the JMP
> instruction, referring to an absolute constant in the .init.rodata
> section.
>
> Given that the secondary startup code does not require a special
> placement inside the executable, move it to the .noinstr.text section.

This should be the .text section, or we get

vmlinux.o: warning: objtool: early_setup_idt+0x4: call to
startup_64_load_idt() leaves .noinstr.text section

It would be better to have the secondary startup code in
.noinstr.text, but it is only a very minor improvement. I'll be
looking into teaching objtool to be strict about .head.text code and
reject references that use absolute addressing, so I might be able to
tweak it to permit this use case as well but at this point we should
probably just move it into ordinary .text


> This requires the use of a subsection so that the payload is placed
> after the page aligned Xen hypercall page, as otherwise, objtool will
> complain about the resulting JMP instruction emitted by the assembler
> being unreachable.
>

^^^ this bit can be dropped, and the following hunk applied (apologies
if my gmail mangles this - i can resend the patch or the series)


diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 4bee33d8e1dc..e16df01791be 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -515,7 +515,7 @@
 }

 /* This is used when running on kernel addresses */
-void noinstr early_setup_idt(void)
+void early_setup_idt(void)
 {
        void *handler = NULL;

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 32fefb23f4df..c9ee92550508 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -139,8 +139,7 @@
        __INITRODATA
 0:     .quad   common_startup_64

-       .section .noinstr.text, "ax"
-       .subsection 1
+       .text
 SYM_CODE_START(secondary_startup_64)
        UNWIND_HINT_END_OF_STACK
        ANNOTATE_NOENDBR

