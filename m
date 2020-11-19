Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068C62B9B7B
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 20:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgKSTZ7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 14:25:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727905AbgKSTZ6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Nov 2020 14:25:58 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7AF6221FE;
        Thu, 19 Nov 2020 19:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605813958;
        bh=tpiSO13FbNyZ42kAbeVAMN0z3Q1MzKH9/3qggLww0uQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7Gvj5r18o4ajlJFxbZptgsKAjyvN81ac7Vl0PWWW7vgY0S4IhHlyeIc5GLyIIw/h
         pJN+A48yxUDNPeT2M/RVFraejiLdehZ5T+GwLeGCdGiZ/aPb/eGZ19Tm36d84efeEe
         W3kpJD0CA6Sxju9AI3YUc85X4mQR6ey0TYoH/F3I=
Date:   Thu, 19 Nov 2020 19:25:51 +0000
From:   Will Deacon <will@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v3 07/14] sched: Introduce restrict_cpus_allowed_ptr() to
 limit task CPU affinity
Message-ID: <20201119192550.GD4906@willie-the-truck>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-8-will@kernel.org>
 <jhj8saxwm1l.mognet@arm.com>
 <20201119131319.GE4331@willie-the-truck>
 <20201119160944.GP3121392@hirez.programming.kicks-ass.net>
 <jhj4kllwahv.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhj4kllwahv.mognet@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 19, 2020 at 04:57:22PM +0000, Valentin Schneider wrote:
> 
> On 19/11/20 16:09, Peter Zijlstra wrote:
> > On Thu, Nov 19, 2020 at 01:13:20PM +0000, Will Deacon wrote:
> >
> >> Sure, but I was talking about what userspace sees, and I don't think it ever
> >> sees CPUs that have been hotplugged off, right? That is, sched_getaffinity()
> >> masks its result with the active_mask.
> >
> > # for i in /sys/devices/system/cpu/cpu*/online; do echo -n $i ":"; cat $i; done
> > /sys/devices/system/cpu/cpu1/online :0
> > /sys/devices/system/cpu/cpu2/online :1
> > /sys/devices/system/cpu/cpu3/online :1
> > /sys/devices/system/cpu/cpu4/online :1
> > /sys/devices/system/cpu/cpu5/online :1
> > /sys/devices/system/cpu/cpu6/online :1
> > /sys/devices/system/cpu/cpu7/online :1
> >
> > # grep Cpus_allowed /proc/self/status
> > Cpus_allowed:   ff
> > Cpus_allowed_list:      0-7
> >
> >
> > :-)
> 
> Harumph, so there is that...
> 
> $ while true; do continue; done &
> $ PID=$!
> $ taskset -pc 0-1 $PID
>   pid 849's current affinity list: 0-5
>   pid 849's new affinity list: 0,1
> $ echo 0 > /sys/devices/system/cpu/cpu1/online
>   [12578.545726] CPU1: shutdown
>   [12578.548454] psci: CPU1 killed (polled 0 ms)
> $ taskset -pc $PID
>   pid 849's current affinity list: 0
> $ cat /proc/$PID/status | grep Cpus
>   Cpus_allowed:   03
>   Cpus_allowed_list:      0-1

Yeah, I'm not sure this is worth tackling tbh. sched_getaffinity() does the
right thing, but poking around in /proc and /sys is always going to defeat
the illusion and I don't see what we gain in reporting CPUs on which the
task is _never_ going to run anyway. But I'll revise my stance on it being
identical to hotplug :) (I would've gotten away with it too, if it wasn't
for those pesky hackers).

Will
