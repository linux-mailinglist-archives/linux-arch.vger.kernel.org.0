Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73598224439
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 21:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgGQT3k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 15:29:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42658 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgGQT3k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 15:29:40 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595014176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=epByd5xUArlj64sAwQwDhQ0ku+RyRhUcoJ9aqhT7QZw=;
        b=pOJnlIP89W85WkeayXUyvnSOlcLSwC7H0IKBi1adAhCjyZQZ8ap6hcFeAxrRMuyl1bvCK8
        fZBnF4fLXYdvGFo7FgMdfTl0+ojF3kR37ClLv1hxwtHQ7xyGCK2EF2yfVVA+aXgRxqCFdP
        l6b7H6h9JE8w+01yq5WbN5fvxjqB6r8KvyUgRblFhgz8TtN9hiWijxCTYcHrGfXdFny+Pi
        HJdaz4269YX7A7nbjjwigVzIWHldKqmV7j7lCHnHSd/Q0jet3cbrMUuP3Wze/YGVxOJpMD
        gkDKGeGFG2fAah6fjoVEesLSQxklUa3S7TeYLtc+MfphKcrIarcQ7RCILa/k1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595014176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=epByd5xUArlj64sAwQwDhQ0ku+RyRhUcoJ9aqhT7QZw=;
        b=S3UsK4BQe5+3DBSPnvpLNIWCaUaYjdBOdD/TwxDOUdmqfUwFqJXlwPMQl+PDTogKSBkfSx
        8KaURcHGtkWfcXCg==
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [patch V3 01/13] entry: Provide generic syscall entry functionality
In-Reply-To: <202007171045.FB4A586F1D@keescook>
References: <20200716182208.180916541@linutronix.de> <20200716185424.011950288@linutronix.de> <202007161336.B993ED938@keescook> <87d04vt98w.fsf@nanos.tec.linutronix.de> <202007171045.FB4A586F1D@keescook>
Date:   Fri, 17 Jul 2020 21:29:36 +0200
Message-ID: <87mu3yq6sf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> On Thu, Jul 16, 2020 at 11:55:59PM +0200, Thomas Gleixner wrote:
>> Kees Cook <keescook@chromium.org> writes:
>> >> +/*
>> >> + * Define dummy _TIF work flags if not defined by the architecture or for
>> >> + * disabled functionality.
>> >> + */
>> >
>> > When I was thinking about this last week I was pondering having a split
>> > between the arch-agnositc TIF flags and the arch-specific TIF flags, and
>> > that each arch could have a single "there is agnostic work to be done"
>> > TIF in their thread_info, and the agnostic flags could live in
>> > task_struct or something. Anyway, I'll keep reading...
>> 
>> That's going to be nasty. We rather go and expand the TIF storage to
>> 64bit. And then do the following in a generic header:
>
> I though the point was to make the TIF_WORK check as fast as possible,
> even on the 32-bit word systems. I mean it's not a huge performance hit,
> but *shrug*

For 64bit it's definitely faster to have 64bit flags.

For 32bit it's debatable whether having to fiddle with two words and
taking care about ordering is faster or not. It's a pain on 32bit in any
case.

But what we can do is distangle the flags into those which really need
to be grouped into a single 32bit TIF word and architecture specific
ones which can live in a different place.

Looking at x86 which has the most pressure on TIF bits:

Real TIF bits
TIF_SYSCALL_TRACE       Entry/exit
TIF_SYSCALL_TRACEPOINT	Entry/exit
TIF_NOTIFY_RESUME       Entry/exit
TIF_SIGPENDING          Entry/exit
TIF_NEED_RESCHED        Entry/exit
TIF_SINGLESTEP          Entry/exit
TIF_SYSCALL_EMU         Entry/exit
TIF_SYSCALL_AUDIT       Entry/exit
TIF_SECCOMP             Entry/exit
TIF_USER_RETURN_NOTIFY	Entry/exit      (x86 specific)
TIF_UPROBE		Entry/exit
TIF_PATCH_PENDING       Entry/exit
TIF_POLLING_NRFLAG      Scheduler (related to TIF_NEED_RESCHED)
TIF_MEMDIE              Historical, but not required to be a real one
TIF_FSCHECK		Historical, but not required to be a real one

Context switch group
TIF_NOCPUID             X86 Context switch
TIF_NOTSC               X86 Context switch
TIF_SLD                 X86 Context switch
TIF_BLOCKSTEP           X86 Context switch
TIF_IO_BITMAP           X86 Context switch + Entry/exit (see below)
TIF_NEED_FPU_LOAD       X86 Context switch + Entry/exit (see below)
TIF_SSBD                X86 Context switch
TIF_SPEC_IB             X86 Context switch
TIF_SPEC_FORCE_UPDATE   X86 Context switch

No group requirements
TIF_IA32                X86 random
TIF_FORCED_TF           X86 random
TIF_LAZY_MMU_UPDATES    X86 random
TIF_ADDR32              X86 random
TIF_X32                 X86 random

So the only interesting ones are TIF_IO_BITMAP and TIF_NEED_FPU_LOAD,
but those are really not required to be in the real TIF group because
they are independently evaluated _after_ the real TIF flags on exit to
user space and that requires a reread of the flags anyway. So if we put
the context switch and the random bits into a seperate word right after
thread_info->flags then the second word is in the same cacheline and it
wont matter. That way we gain plenty of free bits on 32 bit and have no
dependency between the two words at all.

The alternative is to play nasty games with TIF_IA32, TIF_ADDR32 and
TIF_X32 to free up bits for 32bit and make the flags field 64 bit on 64
bit kernels, but I prefer to do the above seperation.

Thanks,

        tglx
