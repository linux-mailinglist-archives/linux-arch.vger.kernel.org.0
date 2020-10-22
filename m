Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09B4295C49
	for <lists+linux-arch@lfdr.de>; Thu, 22 Oct 2020 11:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896136AbgJVJzy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Oct 2020 05:55:54 -0400
Received: from foss.arm.com ([217.140.110.172]:52820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896132AbgJVJzy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Oct 2020 05:55:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D827D6E;
        Thu, 22 Oct 2020 02:55:53 -0700 (PDT)
Received: from e123083-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E2A43F66E;
        Thu, 22 Oct 2020 02:55:51 -0700 (PDT)
Date:   Thu, 22 Oct 2020 11:55:48 +0200
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>, surenb@google.com,
        James Morse <james.morse@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, balejs@google.com
Subject: Re: [RFC PATCH v2 4/4] arm64: Export id_aar64fpr0 via sysfs
Message-ID: <20201022095548.GH8004@e123083-lin>
References: <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
 <20201021121559.GB3976@gaia>
 <20201021133316.GF8004@e123083-lin>
 <20201021140945.GD3976@gaia>
 <20201021144542.GB17912@willie-the-truck>
 <20201021151005.GF3976@gaia>
 <20201021153738.GB18071@willie-the-truck>
 <20201021161836.GG3976@gaia>
 <20201021171945.GE18071@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021171945.GE18071@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 06:19:48PM +0100, Will Deacon wrote:
> On Wed, Oct 21, 2020 at 05:18:37PM +0100, Catalin Marinas wrote:
> > On Wed, Oct 21, 2020 at 04:37:38PM +0100, Will Deacon wrote:
> > > On Wed, Oct 21, 2020 at 04:10:06PM +0100, Catalin Marinas wrote:
> > > > On Wed, Oct 21, 2020 at 03:45:43PM +0100, Will Deacon wrote:
> > > > > On Wed, Oct 21, 2020 at 03:09:46PM +0100, Catalin Marinas wrote:
> > > > > > Anyway, if the task placement is entirely off the table, the next thing
> > > > > > is asking applications to set their own mask and kill them if they do
> > > > > > the wrong thing. Here I see two possibilities for killing an app:
> > > > > > 
> > > > > > 1. When it ends up scheduled on a non-AArch32-capable CPU
> > > > > 
> > > > > That sounds fine to me. If we could do the exception return and take a
> > > > > SIGILL, that's what we'd do, but we can't so we have to catch it before.
> > > > 
> > > > Indeed, the illegal ERET doesn't work for this scenario.
> > > > 
> > > > > > 2. If the user cpumask (bar the offline CPUs) is not a subset of the
> > > > > >    aarch32_mask
> > > > > > 
> > > > > > Option 1 is simpler but 2 would be slightly more consistent.
> > > > > 
> > > > > I disagree -- if we did this for something like fpsimd, then the consistent
> > > > > behaviour would be to SIGILL on the cores without the instructions.
> > > > 
> > > > For fpsimd it makes sense since the main ISA is still available and the
> > > > application may be able to do something with the signal. But here we
> > > > can't do much since the entire AArch32 mode is not supported. That's why
> > > > we went for SIGKILL instead of SIGILL but thinking of it, after execve()
> > > > the signals are reset to SIG_DFL so SIGILL cannot be ignored.
> > > > 
> > > > I think it depends on whether you look at this fault as a part of ISA
> > > > not being available or as the overall application not compatible with
> > > > the system it is running on. If the latter, option 2 above makes more
> > > > sense.
> > > 
> > > Hmm, I'm not sure I see the distinction in practice: you still have a binary
> > > application that cannot run on all CPUs in the system. Who cares if some of
> > > the instructions work?
> > 
> > The failure would be more predictable rather than the app running for a
> > while and randomly getting SIGKILL. If it only fails on execve or
> > sched_setaffinity, it may be easier to track down (well, there's the CPU
> > hotplug as well that can change the cpumask intersection outside the
> > user process control).

Migration between cpusets is another failure scenario where the app can
get SIGKILL randomly.

> But it's half-baked, because the moment the 32-bit task changes its affinity
> mask then you're back in the old situation. That's why I'm saying this
> doesn't add anything, because the rest of the series is designed entirely
> around delivering SIGKILL at the last minute rather than preventing us
> getting to that situation in the first place. The execve() case feels to me
> like we're considering doing something because we can, rather than because
> it's actually useful.

Agree.
