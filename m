Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2BB42E0B8
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 20:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhJNSFX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 14:05:23 -0400
Received: from foss.arm.com ([217.140.110.172]:58522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233806AbhJNSFW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Oct 2021 14:05:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD85611D4;
        Thu, 14 Oct 2021 11:03:15 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CFD13F66F;
        Thu, 14 Oct 2021 11:03:09 -0700 (PDT)
Date:   Thu, 14 Oct 2021 19:03:07 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     keescook@chromium.org, jannh@google.com,
        linux-kernel@vger.kernel.org, vcaputo@pengaru.com,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, amistry@google.com,
        Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, axboe@kernel.dk,
        metze@samba.org, laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, jpoimboe@redhat.com,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        vgupta@kernel.org, linux@armlinux.org.uk, will@kernel.org,
        guoren@kernel.org, bcain@codeaurora.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        jonas@southpole.se, mpe@ellerman.id.au, paul.walmsley@sifive.com,
        hca@linux.ibm.com, ysato@users.sourceforge.jp, davem@davemloft.net,
        chris@zankel.net
Subject: Re: [PATCH 6/7] arch: __get_wchan || STACKTRACE_SUPPORT
Message-ID: <20211014180307.GB39276@lakrids.cambridge.arm.com>
References: <20211008111527.438276127@infradead.org>
 <20211008111626.392918519@infradead.org>
 <20211008124052.GA976@C02TD0UTHF1T.local>
 <YWBLl0mMTGPE/7hM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWBLl0mMTGPE/7hM@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 08, 2021 at 03:45:59PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 08, 2021 at 01:40:52PM +0100, Mark Rutland wrote:
> > [Adding Josh, since there might be a concern here from a livepatch pov]
> > 
> 
> > > +static unsigned long __get_wchan(struct task_struct *p)
> > > +{
> > > +	unsigned long entry = 0;
> > > +
> > > +	stack_trace_save_tsk(p, &entry, 1, 0);
> > 
> > This assumes stack_trace_save_tsk() will skip sched functions, but I
> > don't think that's ever been a requirement? It's certinaly not
> > documented anywhere that I could find, and arm64 doesn't do so today,
> > and this patch causes wchan to just log `__switch_to` for everything.
> 
> Confused, arm64 has arch_stack_walk() and should thus use
> kernel/stacktrace.c's stack_trace_consume_entry_nosched.

Looking at this arm64's *current* get_wchan() unwinds once before
checking in_sched_functions(), so it skips __switch_to(). As of this
patch, we check in_sched_functions() first, which stops the unwind
immediately as __switch_to() isn't marked as __sched.

I think x86 gets away with this because switch_to() is asm, and that
tail-calls __switch_to() when returning.

Does switch_to() and below need to be marked __sched?

Thanks,
Mark.
