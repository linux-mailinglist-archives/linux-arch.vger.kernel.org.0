Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBEA294EEA
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 16:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440191AbgJUOly (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 10:41:54 -0400
Received: from foss.arm.com ([217.140.110.172]:36144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440037AbgJUOlx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 10:41:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10F47D6E;
        Wed, 21 Oct 2020 07:41:53 -0700 (PDT)
Received: from e123083-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 938F83F66B;
        Wed, 21 Oct 2020 07:41:51 -0700 (PDT)
Date:   Wed, 21 Oct 2020 16:41:49 +0200
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arch@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 4/4] arm64: Export id_aar64fpr0 via sysfs
Message-ID: <20201021144149.GG8004@e123083-lin>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
 <20201021121559.GB3976@gaia>
 <20201021133316.GF8004@e123083-lin>
 <20201021140945.GD3976@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021140945.GD3976@gaia>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 03:09:46PM +0100, Catalin Marinas wrote:
> On Wed, Oct 21, 2020 at 03:33:29PM +0200, Morten Rasmussen wrote:
> > On Wed, Oct 21, 2020 at 01:15:59PM +0100, Catalin Marinas wrote:
> > > one, though not as easy as automatic task placement by the scheduler (my
> > > first preference, followed by the id_* regs and the aarch32 mask, though
> > > not a strong preference for any).
> > 
> > Automatic task placement by the scheduler would mean giving up the
> > requirement that the user-space affinity mask must always be honoured.
> > Is that on the table?
> 
> I think Peter rejected it but I still find it a nicer interface from a
> dumb application perspective. It may interact badly with cpusets though
> (at least on Android).

Agree that it would be nice for supporting legacy applications. Due to
the cpuset interaction I think there is fair chance that user-space
would want to know the aarch32 cpumask anyway though.

> 
> > Killing aarch32 tasks with an empty intersection between the
> > user-space mask and aarch32_mask is not really "automatic" and would
> > require the aarch32 capability to be exposed anyway.
> 
> I agree, especially if overriding the user mask is not desirable. But if
> one doesn't play around with cpusets, 32-bit apps would run "fine" with
> the scheduler transparently placing them on the correct CPU.

Ruling out user-space setting affinity is another way of solving the
problem ;-)

> Anyway, if the task placement is entirely off the table, the next thing
> is asking applications to set their own mask and kill them if they do
> the wrong thing. Here I see two possibilities for killing an app:
> 
> 1. When it ends up scheduled on a non-AArch32-capable CPU
> 
> 2. If the user cpumask (bar the offline CPUs) is not a subset of the
>    aarch32_mask
> 
> Option 1 is simpler but 2 would be slightly more consistent.

I don't have strong preference. More consistent killing is probably nice
for debugging purposes. If we go with 2, we would go round and kill all
tasks in cpuset (both running and sleeping) if the cpuset mask was
changed to not include aarch32 CPUs?

> There's also the question on whether the kernel should allow an ELF32 to
> be loaded (and potentially killed subsequently) if the user mask is not
> correct on execve().

I wonder how many apps that would handle execve() failing? If we allow
killing, the simplest solution if there is any doubt seems to be just
to kill the task :-)

Morten
