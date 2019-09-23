Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 380C5BAFCE
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2019 10:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfIWIkw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Sep 2019 04:40:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57513 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfIWIkw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Sep 2019 04:40:52 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iCJtk-0008Mq-Ow; Mon, 23 Sep 2019 10:40:44 +0200
Date:   Mon, 23 Sep 2019 10:40:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC patch 03/15] x86/entry: Use generic syscall entry
 function
In-Reply-To: <20190923083114.GF2349@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1909231040270.2003@nanos.tec.linutronix.de>
References: <20190919150314.054351477@linutronix.de> <20190919150808.724554170@linutronix.de> <CALCETrUhH9_ZGn=-FMKYvTswQ7g0deVJif2xUihsu5tpJg0xSA@mail.gmail.com> <20190923083114.GF2349@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 23 Sep 2019, Peter Zijlstra wrote:

> On Fri, Sep 20, 2019 at 04:41:03PM -0700, Andy Lutomirski wrote:
> > On Thu, Sep 19, 2019 at 8:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > Replace the syscall entry work handling with the generic version, Provide
> > > the necessary helper inlines to handle the real architecture specific
> > > parts, e.g. audit and seccomp invocations.
> > 
> > > -       if (work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
> > > -               ret = tracehook_report_syscall_entry(regs);
> > > -               if (ret || (work & _TIF_SYSCALL_EMU))
> > > -                       return -1L;
> > > -       }
> > 
> > Unless I missed something, you lost the _TIF_SYSCALL_EMU abomination.
> 
> IIUC that's actually in patch #1.

Correct:

+       if (ti_work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
+               ret = arch_syscall_enter_tracehook(regs);
+               if (ret || (ti_work & _TIF_SYSCALL_EMU))
+                       return -1L;
+       }

