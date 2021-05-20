Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B29238B5B5
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 20:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbhETSEu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 May 2021 14:04:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231648AbhETSEq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 May 2021 14:04:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2210360FF1;
        Thu, 20 May 2021 18:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621533805;
        bh=qBshlKu2zd7WKE8/gF2eNvUhAIN7rsAOhrY25OU7S/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pXsFzpYQH2wzpNYeAwSJlXYpYiHKtKc+CdDvA4bSzh/IBqfPEkK9c8ErOviUmMNob
         nhHnGmlpuHoyOG0HP0UGRxMO435sjFN5rnFTJryVuOdwXyzSFc7pohl6V7/BWvg4l1
         8Jc5Ay5roGEd+cZA2hQ/unaY39j5wQBuTtBAZpEY6fiaCbny+y4v6jotinasOo00lU
         85z63cYie5xvNH+VYAmj4nX8K83rN5cvwKAx8ZspukzuFyvO3swRFO64uvZle5Dupv
         tpB1S5HHW0gM72DHn2gzZPRdG0wXoblF8rFG6/yF39V67hzD0BiJs5ExCxVgNsC2a1
         wYh45KMfEhhjA==
Date:   Thu, 20 May 2021 19:03:18 +0100
From:   Will Deacon <will@kernel.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
Message-ID: <20210520180318.GB10523@willie-the-truck>
References: <YKObZ1GcfVIVWRWt@google.com>
 <20210518105951.GC7770@willie-the-truck>
 <YKO+9lPLQLPm4Nwt@google.com>
 <YKYoQ0ezahSC/RAg@localhost.localdomain>
 <20210520101640.GA10065@willie-the-truck>
 <YKY7FvFeRlXVjcaA@google.com>
 <f9d1a138-3150-d404-7cd5-ddf72e93837b@redhat.com>
 <0dbdfe1e-dede-d33d-ca89-768a1fa3c907@arm.com>
 <eff0f358-d5f3-47c7-539b-527814093f89@redhat.com>
 <8bc24850-3a14-5dd2-fbc2-bf745616949f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bc24850-3a14-5dd2-fbc2-bf745616949f@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dietmar,

On Thu, May 20, 2021 at 07:55:27PM +0200, Dietmar Eggemann wrote:
> On 20/05/2021 18:00, Daniel Bristot de Oliveira wrote:
> > On 5/20/21 5:06 PM, Dietmar Eggemann wrote:
> >> (1) # chrt -d -T 5000000 -P 16666666 0 ./32bit_app
> >>
> >> (2) # ./32bit_app &
> >>
> >>     # chrt -d -T 5000000 -P 16666666 -p 0 pid_of(32bit_app)
> >>
> >>
> >> Wouldn't the behaviour of (1) and (2) be different w/o this patch?
> >>
> >> In (1) __sched_setscheduler() happens before execve so it operates on
> >> p->cpus_ptr equal span.
> >>
> >> In (2) span != p->cpus_ptr so DL AC will fail.
> >>
> > 
> > As far as I got, the case (1) would be spitted in two steps:
> > 
> >  - __sched_setscheduler() will work, then
> >  - execv() would fail because (span != p->cpus_ptr)
> > 
> > So... at the end, both (1) and (2) would result in a failure...
> > 
> > am I missing something?
> 
> Not sure. Reading this thread I was under the assumption that the only
> change would be the drop of this patch. But I assume there is also this
> 'if DL AC is on then let sched_setattr() fail for this 32bit task'.
> 
> IMHO, the current patch-stack w/o this patch should let (1) succeed with
> DL AC.

That's what I'm proposing, yes, but others (including Daniel) prefer to
fail the execve(). See my other reply just now for a summary [1].

Thanks!

Will

[1] https://lore.kernel.org/lkml/20210520180138.GA10523@willie-the-truck/T/#u
