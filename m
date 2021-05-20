Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA5B38B28F
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 17:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhETPIO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 May 2021 11:08:14 -0400
Received: from foss.arm.com ([217.140.110.172]:53480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231764AbhETPIN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 May 2021 11:08:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC3FD101E;
        Thu, 20 May 2021 08:06:51 -0700 (PDT)
Received: from [192.168.1.16] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D5E53F73B;
        Thu, 20 May 2021 08:06:48 -0700 (PDT)
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Will Deacon <will@kernel.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
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
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-14-will@kernel.org> <YKOU9onXUxVLPGaB@google.com>
 <20210518102833.GA7770@willie-the-truck> <YKObZ1GcfVIVWRWt@google.com>
 <20210518105951.GC7770@willie-the-truck> <YKO+9lPLQLPm4Nwt@google.com>
 <YKYoQ0ezahSC/RAg@localhost.localdomain>
 <20210520101640.GA10065@willie-the-truck> <YKY7FvFeRlXVjcaA@google.com>
 <f9d1a138-3150-d404-7cd5-ddf72e93837b@redhat.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <0dbdfe1e-dede-d33d-ca89-768a1fa3c907@arm.com>
Date:   Thu, 20 May 2021 17:06:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f9d1a138-3150-d404-7cd5-ddf72e93837b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 20/05/2021 14:38, Daniel Bristot de Oliveira wrote:
> On 5/20/21 12:33 PM, Quentin Perret wrote:
>> On Thursday 20 May 2021 at 11:16:41 (+0100), Will Deacon wrote:
>>> Ok, thanks for the insight. In which case, I'll go with what we discussed:
>>> require admission control to be disabled for sched_setattr() but allow
>>> execve() to a 32-bit task from a 64-bit deadline task with a warning (this
>>> is probably similar to CPU hotplug?).
>>
>> Still not sure that we can let execve go through ... It will break AC
>> all the same, so it should probably fail as well if AC is on IMO
>>
> 
> If the cpumask of the 32-bit task is != of the 64-bit task that is executing it,
> the admission control needs to be re-executed, and it could fail. So I see this
> operation equivalent to sched_setaffinity(). This will likely be true for future
> schedulers that will allow arbitrary affinities (AC should run on affinity
> change, and could fail).
> 
> I would vote with Juri: "I'd go with fail hard if AC is on, let it
> pass if AC is off (supposedly the user knows what to do)," (also hope nobody
> complains until we add better support for affinity, and use this as a motivation
> to get back on this front).
> 
> -- Daniel

(1) # chrt -d -T 5000000 -P 16666666 0 ./32bit_app

(2) # ./32bit_app &

    # chrt -d -T 5000000 -P 16666666 -p 0 pid_of(32bit_app)


Wouldn't the behaviour of (1) and (2) be different w/o this patch?

In (1) __sched_setscheduler() happens before execve so it operates on
p->cpus_ptr equal span.

In (2) span != p->cpus_ptr so DL AC will fail.
