Return-Path: <linux-arch+bounces-10038-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FA9A29E93
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2025 02:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4180167D6E
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2025 01:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D18638385;
	Thu,  6 Feb 2025 01:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Emc/IHJV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550054964E;
	Thu,  6 Feb 2025 01:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738807159; cv=none; b=EngiXEuoCO791yp71P1XByfEw0REoqZ7wzLKtBL+ar4/kOTbg3KwA9Bt9eu0pAKZdugjyEFJ3yoeXgw5GstM00j3c0hNo3B/v4AadceFIzhrslPto5fRJenhdA010ucaAXom+/weOEK7UANoCWRBD5MNZiT541nIoCOIyDIRpW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738807159; c=relaxed/simple;
	bh=vBuSbbpEaBblpFthL/DAmTOPtxEdlckQsYIOQlOd1ew=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mJaACGqHRWDZXSIKJGrkilLa/R/pYAKiQBW2s61Y9y5Jti1oCDWkEOkeXVxV5XX/zd0m1geKb/quSCfvUR4R/uvrThlStKI4Z432HA8/ImdQMNjM841RTy5moVcE3GR5GDadB5B2bQDZ1WWh6SaIjMxgeuixnGFakL3Cv2CDKh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Emc/IHJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA170C4CED1;
	Thu,  6 Feb 2025 01:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738807158;
	bh=vBuSbbpEaBblpFthL/DAmTOPtxEdlckQsYIOQlOd1ew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Emc/IHJVJyTZ2raDcGU/OWGq5qQ9CKzXLOCGR3eEtMyWvawfwaH/CgadHnFgh4ZsS
	 +0YclRuAfeIsc01w8K2s3xRH9QU78E01ZNfm8j/62IYoKNBbZW8KXhz6DWddyb4qVC
	 ReJnUy4nEkfMkQr7oPHSnHRVRufQCGietnyrTDVXhJ17RZPZ0yrdK6YWpVYmLvRpTW
	 2H1mp93ds4HUnrsC+tKRoy932bMN3TnUD42zyRJjg+G33jGgK6YMiS9c5nhcUaSl+s
	 Knl5LN246/hg0DtLHAVzO9edaEyJrh1rfaHLiHpLRZv2txavBPvkHTKgoeIGa6+h0z
	 Xj/ZME3/o3Xww==
Date: Thu, 6 Feb 2025 10:59:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Gabriel de Perthuis <g2p.code@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v22 19/20] ftrace: Add ftrace_get_symaddr to convert
 fentry_ip to symaddr
Message-Id: <20250206105915.e2ddadd0c0d2c597bb923495@kernel.org>
In-Reply-To: <CAFEugPfFykYsHqS-J36CNWDn+d34bSQg-e5hJ=AaJPC8=6Ej-g@mail.gmail.com>
References: <173518987627.391279.3307342580035322889.stgit@devnote2>
	<173519011487.391279.5450806886342723151.stgit@devnote2>
	<a87f98bf-45b1-4ef5-aa77-02f7e61203f4@gmail.com>
	<20250204181902.dd6e02416ff5eeec3ea47a79@kernel.org>
	<CAFEugPfFykYsHqS-J36CNWDn+d34bSQg-e5hJ=AaJPC8=6Ej-g@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 4 Feb 2025 15:19:45 +0100
Gabriel de Perthuis <g2p.code@gmail.com> wrote:

> Thank you for the prompt response!
> Sorry, this doesn't build.

Thanks for testing!
OK, so including linux/uaccess.h in asm/ftrace.h will cause another
issue. This is a good information!
I'll move the ftrace_call_adjust() to arch/x86/kernel/ftrace.c then.

Thank you!

> New, different errors:
> 
>   AS      arch/x86/kernel/ftrace_64.o
> In file included from ./include/linux/kcsan-checks.h:13,
>                  from ./include/linux/instrumented.h:12,
>                  from ./include/linux/uaccess.h:6,
>                  from ./arch/x86/include/asm/ftrace.h:20,
>                  from arch/x86/kernel/ftrace_64.S:11:
> ./include/linux/compiler_attributes.h:91:20: error: missing binary
> operator before token "("
>    91 | #if __has_attribute(__copy__)
>       |                    ^
> ./include/linux/compiler_attributes.h:103:20: error: missing binary
> operator before token "("
>   103 | #if __has_attribute(__diagnose_as_builtin__)
>       |                    ^
> ./include/linux/compiler_attributes.h:126:20: error: missing binary
> operator before token "("
>   126 | #if __has_attribute(__designated_init__)
>       |                    ^
> ./include/linux/compiler_attributes.h:137:20: error: missing binary
> operator before token "("
>   137 | #if __has_attribute(__error__)
>       |                    ^
> ./include/linux/compiler_attributes.h:148:20: error: missing binary
> operator before token "("
>   148 | #if __has_attribute(__externally_visible__)
>       |                    ^
> ./include/linux/compiler_attributes.h:185:20: error: missing binary
> operator before token "("
>   185 | #if __has_attribute(__no_caller_saved_registers__)
>       |                    ^
> ./include/linux/compiler_attributes.h:196:20: error: missing binary
> operator before token "("
>   196 | #if __has_attribute(__noclone__)
>       |                    ^
> ./include/linux/compiler_attributes.h:213:20: error: missing binary
> operator before token "("
>   213 | #if __has_attribute(__fallthrough__)
>       |                    ^
> ./include/linux/compiler_attributes.h:239:20: error: missing binary
> operator before token "("
>   239 | #if __has_attribute(__nonstring__)
>       |                    ^
> ./include/linux/compiler_attributes.h:251:20: error: missing binary
> operator before token "("
>   251 | #if __has_attribute(__no_profile_instrument_function__)
>       |                    ^
> ./include/linux/compiler_attributes.h:270:20: error: missing binary
> operator before token "("
>   270 | #if __has_attribute(__no_stack_protector__)
>       |                    ^
> ./include/linux/compiler_attributes.h:281:20: error: missing binary
> operator before token "("
>   281 | #if __has_attribute(__overloadable__)
>       |                    ^
> ./include/linux/compiler_attributes.h:300:20: error: missing binary
> operator before token "("
>   300 | #if __has_attribute(__pass_dynamic_object_size__)
>       |                    ^
> ./include/linux/compiler_attributes.h:305:20: error: missing binary
> operator before token "("
>   305 | #if __has_attribute(__pass_object_size__)
>       |                    ^
> ./include/linux/compiler_attributes.h:329:20: error: missing binary
> operator before token "("
>   329 | #if __has_attribute(__uninitialized__)
>       |                    ^
> ./include/linux/compiler_attributes.h:375:20: error: missing binary
> operator before token "("
>   375 | #if __has_attribute(__warning__)
>       |                    ^
> ./include/linux/compiler_attributes.h:392:20: error: missing binary
> operator before token "("
>   392 | #if __has_attribute(disable_sanitizer_instrumentation)
>       |                    ^
> In file included from ./include/linux/mm_types_task.h:11,
>                  from ./include/linux/sched.h:38,
>                  from ./include/linux/uaccess.h:9:
> ./include/linux/align.h:8:9: warning: "ALIGN" redefined
>     8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
>       |         ^~~~~
> In file included from ./include/linux/export.h:6,
>                  from arch/x86/kernel/ftrace_64.S:6:
> ./include/linux/linkage.h:103:9: note: this is the location of the
> previous definition
>   103 | #define ALIGN __ALIGN
>       |         ^~~~~
> make[7]: *** [scripts/Makefile.build:339: arch/x86/kernel/ftrace_64.o] Error 1
> 
> Am attaching the .config so you can reproduce these easily.
> 
> Le mar. 4 févr. 2025 à 10:19, Masami Hiramatsu <mhiramat@kernel.org> a écrit :
> >
> > On Mon, 3 Feb 2025 22:33:48 +0100
> > Gabriel de Perthuis <g2p.code@gmail.com> wrote:
> >
> > > Hello,
> > >
> > > I got errors building Linux 6.14-rc1 that were solved by reverting this
> > > patch and the one after (19/20 and 20/20).
> > >
> > > Errors look like:
> > >
> > > In file included from ./arch/x86/include/asm/asm-prototypes.h:2,
> > >                   from <stdin>:3:
> > > ./arch/x86/include/asm/ftrace.h: In function 'arch_ftrace_get_symaddr':
> > > ./arch/x86/include/asm/ftrace.h:46:21: error: implicit declaration of
> > > function 'get_kernel_nofault' [-Wimplicit-function-declaration]
> > >     46 |                 if (get_kernel_nofault(instr, (u32 *)(fentry_ip
> > > - ENDBR_INSN_SIZE)))
> > >        | ^~~~~~~~~~~~~~~~~~
> > >
> > > Will send .config on request if needed.
> >
> >
> > Thanks for the report!
> >
> > -------<arch/x86/include/asm/asm-prototypes.h>
> > /* SPDX-License-Identifier: GPL-2.0 */
> > #include <asm/ftrace.h>
> > #include <linux/uaccess.h>
> > -----
> >
> > Ah, that's why... get_kernel_nofault() is defined in linux/uaccess.h.
> > I also found that is_endbr() is in asm/ibt.h.
> >
> > Can you try this?
> >
> > Thank you,
> >
> > diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> > index f9cb4d07df58..d24d7c71253f 100644
> > --- a/arch/x86/include/asm/ftrace.h
> > +++ b/arch/x86/include/asm/ftrace.h
> > @@ -16,24 +16,9 @@
> >  # include <asm/ibt.h>
> >  /* Add offset for endbr64 if IBT enabled */
> >  # define FTRACE_MCOUNT_MAX_OFFSET      ENDBR_INSN_SIZE
> > -#endif
> > -
> > -#ifdef CONFIG_DYNAMIC_FTRACE
> > -#define ARCH_SUPPORTS_FTRACE_OPS 1
> > -#endif
> > -
> > -#ifndef __ASSEMBLY__
> > -extern void __fentry__(void);
> > -
> > -static inline unsigned long ftrace_call_adjust(unsigned long addr)
> > -{
> > -       /*
> > -        * addr is the address of the mcount call instruction.
> > -        * recordmcount does the necessary offset calculation.
> > -        */
> > -       return addr;
> > -}
> >
> > +#include <linux/uaccess.h>
> > +/* This only supports fentry based ftrace. */
> >  static inline unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
> >  {
> >  #ifdef CONFIG_X86_KERNEL_IBT
> > @@ -55,6 +40,24 @@ static inline unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
> >  }
> >  #define ftrace_get_symaddr(fentry_ip)  arch_ftrace_get_symaddr(fentry_ip)
> >
> > +#endif
> > +
> > +#ifdef CONFIG_DYNAMIC_FTRACE
> > +#define ARCH_SUPPORTS_FTRACE_OPS 1
> > +#endif
> > +
> > +#ifndef __ASSEMBLY__
> > +extern void __fentry__(void);
> > +
> > +static inline unsigned long ftrace_call_adjust(unsigned long addr)
> > +{
> > +       /*
> > +        * addr is the address of the mcount call instruction.
> > +        * recordmcount does the necessary offset calculation.
> > +        */
> > +       return addr;
> > +}
> > +
> >  #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> >
> >  #include <linux/ftrace_regs.h>
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

