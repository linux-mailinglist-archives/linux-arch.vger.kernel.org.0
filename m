Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8CB295096
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 18:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408858AbgJUQSp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 12:18:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408951AbgJUQSn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 12:18:43 -0400
Received: from gaia (unknown [95.145.162.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 322D720665;
        Wed, 21 Oct 2020 16:18:40 +0000 (UTC)
Date:   Wed, 21 Oct 2020 17:18:37 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Marc Zyngier <maz@kernel.org>, linux-arch@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 4/4] arm64: Export id_aar64fpr0 via sysfs
Message-ID: <20201021161836.GG3976@gaia>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
 <20201021121559.GB3976@gaia>
 <20201021133316.GF8004@e123083-lin>
 <20201021140945.GD3976@gaia>
 <20201021144542.GB17912@willie-the-truck>
 <20201021151005.GF3976@gaia>
 <20201021153738.GB18071@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021153738.GB18071@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 04:37:38PM +0100, Will Deacon wrote:
> On Wed, Oct 21, 2020 at 04:10:06PM +0100, Catalin Marinas wrote:
> > On Wed, Oct 21, 2020 at 03:45:43PM +0100, Will Deacon wrote:
> > > On Wed, Oct 21, 2020 at 03:09:46PM +0100, Catalin Marinas wrote:
> > > > Anyway, if the task placement is entirely off the table, the next thing
> > > > is asking applications to set their own mask and kill them if they do
> > > > the wrong thing. Here I see two possibilities for killing an app:
> > > > 
> > > > 1. When it ends up scheduled on a non-AArch32-capable CPU
> > > 
> > > That sounds fine to me. If we could do the exception return and take a
> > > SIGILL, that's what we'd do, but we can't so we have to catch it before.
> > 
> > Indeed, the illegal ERET doesn't work for this scenario.
> > 
> > > > 2. If the user cpumask (bar the offline CPUs) is not a subset of the
> > > >    aarch32_mask
> > > > 
> > > > Option 1 is simpler but 2 would be slightly more consistent.
> > > 
> > > I disagree -- if we did this for something like fpsimd, then the consistent
> > > behaviour would be to SIGILL on the cores without the instructions.
> > 
> > For fpsimd it makes sense since the main ISA is still available and the
> > application may be able to do something with the signal. But here we
> > can't do much since the entire AArch32 mode is not supported. That's why
> > we went for SIGKILL instead of SIGILL but thinking of it, after execve()
> > the signals are reset to SIG_DFL so SIGILL cannot be ignored.
> > 
> > I think it depends on whether you look at this fault as a part of ISA
> > not being available or as the overall application not compatible with
> > the system it is running on. If the latter, option 2 above makes more
> > sense.
> 
> Hmm, I'm not sure I see the distinction in practice: you still have a binary
> application that cannot run on all CPUs in the system. Who cares if some of
> the instructions work?

The failure would be more predictable rather than the app running for a
while and randomly getting SIGKILL. If it only fails on execve or
sched_setaffinity, it may be easier to track down (well, there's the CPU
hotplug as well that can change the cpumask intersection outside the
user process control).

> > > > There's also the question on whether the kernel should allow an ELF32 to
> > > > be loaded (and potentially killed subsequently) if the user mask is not
> > > > correct on execve().
> > > 
> > > I don't see the point in distinguishing between "you did execve() on a core
> > > without 32-bit" and "you did execve() on a core with 32-bit and then
> > > migrated to a core without 32-bit".
> > 
> > In the context of option 2 above, its more about whether execve()
> > returns -ENOEXEC or the process gets a SIGKILL immediately.
> 
> I just don't see what we gain by returning -ENOEXEC except for extra code
> and behaviour in the ABI (and if you wanted consistentcy you'd also need
> to fail attempts to widen the affinity mask to include 64-bit-only cores
> from a 32-bit task).

The -ENOEXEC is more in line with the current behaviour not allowing
ELF32 on systems that are not fully symmetric. So basically you'd have
a global opt-in as sysctl and a per-application opt-in via the affinity
mask.

I do agree that it complicates the kernel implementation.

> In other words, I don't think the kernel needs to hold userspace's hand
> for an opt-in feature that requires userspace to handle scheduling for
> optimal power/performance _anyway_. Allowing the affinity to be set
> arbitrarily and then killing the task if it ends up trying to run on the
> wrong CPU is both simple and sufficient.

Fine by me if you want to keep things simple, less code to maintain.

However, it would be good to know if the Android kernel/user guys are
happy with this approach. If the Android kernel ends up carrying
additional patches for task placement, I'd question why we need to merge
this (partial) series at all.

-- 
Catalin
