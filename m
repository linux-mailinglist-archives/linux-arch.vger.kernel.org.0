Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9922B98BF
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 18:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgKSQ5a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 11:57:30 -0500
Received: from foss.arm.com ([217.140.110.172]:35034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbgKSQ5a (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Nov 2020 11:57:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5C441396;
        Thu, 19 Nov 2020 08:57:29 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 868F53F718;
        Thu, 19 Nov 2020 08:57:27 -0800 (PST)
References: <20201113093720.21106-1-will@kernel.org> <20201113093720.21106-8-will@kernel.org> <jhj8saxwm1l.mognet@arm.com> <20201119131319.GE4331@willie-the-truck> <20201119160944.GP3121392@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH v3 07/14] sched: Introduce restrict_cpus_allowed_ptr() to limit task CPU affinity
Message-ID: <jhj4kllwahv.mognet@arm.com>
In-reply-to: <20201119160944.GP3121392@hirez.programming.kicks-ass.net>
Date:   Thu, 19 Nov 2020 16:57:22 +0000
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 19/11/20 16:09, Peter Zijlstra wrote:
> On Thu, Nov 19, 2020 at 01:13:20PM +0000, Will Deacon wrote:
>
>> Sure, but I was talking about what userspace sees, and I don't think it ever
>> sees CPUs that have been hotplugged off, right? That is, sched_getaffinity()
>> masks its result with the active_mask.
>
> # for i in /sys/devices/system/cpu/cpu*/online; do echo -n $i ":"; cat $i; done
> /sys/devices/system/cpu/cpu1/online :0
> /sys/devices/system/cpu/cpu2/online :1
> /sys/devices/system/cpu/cpu3/online :1
> /sys/devices/system/cpu/cpu4/online :1
> /sys/devices/system/cpu/cpu5/online :1
> /sys/devices/system/cpu/cpu6/online :1
> /sys/devices/system/cpu/cpu7/online :1
>
> # grep Cpus_allowed /proc/self/status
> Cpus_allowed:   ff
> Cpus_allowed_list:      0-7
>
>
> :-)

Harumph, so there is that...

$ while true; do continue; done &
$ PID=$!
$ taskset -pc 0-1 $PID
  pid 849's current affinity list: 0-5
  pid 849's new affinity list: 0,1
$ echo 0 > /sys/devices/system/cpu/cpu1/online
  [12578.545726] CPU1: shutdown
  [12578.548454] psci: CPU1 killed (polled 0 ms)
$ taskset -pc $PID
  pid 849's current affinity list: 0
$ cat /proc/$PID/status | grep Cpus
  Cpus_allowed:   03
  Cpus_allowed_list:      0-1
