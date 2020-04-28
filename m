Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07031BC3AA
	for <lists+linux-arch@lfdr.de>; Tue, 28 Apr 2020 17:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgD1P2v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Apr 2020 11:28:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46298 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728265AbgD1P2u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Apr 2020 11:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588087728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uS5bW1tQf/8QdjoKBzoxx0eucD1SomGr+9LtePI5mU8=;
        b=M7G5N5zOq33wnCRv5PCT2qSE5g0tv3Mj/kHq9mC1j61PAucvXTB0L6OwYQqkEei1/bAY5/
        QfevW2sFByuahf4L4fkGs8dLdc5EGY2X/za/U5m72DOEr0EKOAwG4cedVwlrokoXRzYalT
        G9cbjYq9o+u6N34NgZrcXmh8AbNOW+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-tseay-lCPfqnD1DA0RbCNg-1; Tue, 28 Apr 2020 11:28:46 -0400
X-MC-Unique: tseay-lCPfqnD1DA0RbCNg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF268872FE1;
        Tue, 28 Apr 2020 15:28:44 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-77.gru2.redhat.com [10.97.116.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 29F045D710;
        Tue, 28 Apr 2020 15:28:44 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id ADCC7416C88E; Tue, 28 Apr 2020 11:12:50 -0300 (-03)
Date:   Tue, 28 Apr 2020 11:12:50 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        Alex Belits <abelits@marvell.com>
Cc:     Alex Belits <abelits@marvell.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prasun Kapoor <pkapoor@marvell.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 03/12] task_isolation: userspace hard isolation from
 kernel
Message-ID: <20200428141250.GA28012@fuller.cnet>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
 <36d84b8dd168a38e6a56549dedc15dd6ebf8c09e.camel@marvell.com>
 <20200305183313.GA29033@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305183313.GA29033@lenoir>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


I like the idea as well, especially the reporting infrastructure, and 
would like to see something like this integrated upstream.

On Thu, Mar 05, 2020 at 07:33:13PM +0100, Frederic Weisbecker wrote:
> On Wed, Mar 04, 2020 at 04:07:12PM +0000, Alex Belits wrote:
> > The existing nohz_full mode is designed as a "soft" isolation mode
> > that makes tradeoffs to minimize userspace interruptions while
> > still attempting to avoid overheads in the kernel entry/exit path,
> > to provide 100% kernel semantics, etc.
> > 
> > However, some applications require a "hard" commitment from the
> > kernel to avoid interruptions, in particular userspace device driver
> > style applications, such as high-speed networking code.
> > 
> > This change introduces a framework to allow applications
> > to elect to have the "hard" semantics as needed, specifying
> > prctl(PR_TASK_ISOLATION, PR_TASK_ISOLATION_ENABLE) to do so.
> > 
> > The kernel must be built with the new TASK_ISOLATION Kconfig flag
> > to enable this mode, and the kernel booted with an appropriate
> > "isolcpus=nohz,domain,CPULIST" boot argument to enable
> > nohz_full and isolcpus. The "task_isolation" state is then indicated
> > by setting a new task struct field, task_isolation_flag, to the
> > value passed by prctl(), and also setting a TIF_TASK_ISOLATION
> > bit in the thread_info flags. When the kernel is returning to
> > userspace from the prctl() call and sees TIF_TASK_ISOLATION set,
> > it calls the new task_isolation_start() routine to arrange for
> > the task to avoid being interrupted in the future.
> > 
> > With interrupts disabled, task_isolation_start() ensures that kernel
> > subsystems that might cause a future interrupt are quiesced. If it
> > doesn't succeed, it adjusts the syscall return value to indicate that
> > fact, and userspace can retry as desired. In addition to stopping
> > the scheduler tick, the code takes any actions that might avoid
> > a future interrupt to the core, such as a worker thread being
> > scheduled that could be quiesced now (e.g. the vmstat worker)
> > or a future IPI to the core to clean up some state that could be
> > cleaned up now (e.g. the mm lru per-cpu cache).
> > 
> > Once the task has returned to userspace after issuing the prctl(),
> > if it enters the kernel again via system call, page fault, or any
> > other exception or irq, the kernel will kill it with SIGKILL.

This severely limits usage of the interface. 

I suppose the reason for blocking system calls is to make sure 
userspace does not initiate actions that might generate interruptions, 
such as IPI flushes (memory unmaps or changes), vmstat work items
(page dirtying), or is there any reason for it ?


+/* Only a few syscalls are valid once we are in task isolation mode. */
+static bool is_acceptable_syscall(int syscall)
+{
+       /* No need to incur an isolation signal if we are just exiting. */
+       if (syscall == __NR_exit || syscall == __NR_exit_group)
+               return true;
+       
+       /* Check to see if it's the prctl for isolation. */
+       if (syscall == __NR_prctl) {
+               unsigned long arg[SYSCALL_MAX_ARGS];
+       
+               syscall_get_arguments(current, current_pt_regs(), arg);
+               if (arg[0] == PR_TASK_ISOLATION)
+                       return true;
+       }
+ 
+       return false;
+}


> > In addition to sending a signal, the code supports a kernel
> > command-line "task_isolation_debug" flag which causes a stack
> > backtrace to be generated whenever a task loses isolation.
> > 
> > To allow the state to be entered and exited, the syscall checking
> > test ignores the prctl(PR_TASK_ISOLATION) syscall so that we can
> > clear the bit again later, and ignores exit/exit_group to allow
> > exiting the task without a pointless signal being delivered.
> > 
> > The prctl() API allows for specifying a signal number to use instead
> > of the default SIGKILL, to allow for catching the notification
> > signal; for example, in a production environment, it might be
> > helpful to log information to the application logging mechanism
> > before exiting. Or, the signal handler might choose to reset the
> > program counter back to the code segment intended to be run isolated
> > via prctl() to continue execution.
> 
> Hi Alew,
> 
> I'm glad this patchset is being resurected.
> Reading that changelog, I like the general idea and the direction.
> The diff is a bit scary though but I'll check the patches in detail
> in the upcoming days.
> 
> > 
> > In a number of cases we can tell on a remote cpu that we are
> > going to be interrupting the cpu, e.g. via an IPI or a TLB flush.
> > In that case we generate the diagnostic (and optional stack dump)
> > on the remote core to be able to deliver better diagnostics.
> > If the interrupt is not something caught by Linux (e.g. a
> > hypervisor interrupt) we can also request a reschedule IPI to
> > be sent to the remote core so it can be sure to generate a
> > signal to notify the process.
> 
> I'm wondering if it's wise to run that on a guest at all :-)
> Or we should consider any guest exit to the host as a
> disturbance, we would then need some sort of paravirt
> driver to notify that, etc... That doesn't sound appealing.
> 
> Thanks.

