Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D009738C5A5
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 13:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbhEUL1o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 07:27:44 -0400
Received: from foss.arm.com ([217.140.110.172]:45100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhEUL1n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 07:27:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 449281424;
        Fri, 21 May 2021 04:26:20 -0700 (PDT)
Received: from [192.168.1.16] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C42573F73D;
        Fri, 21 May 2021 04:26:16 -0700 (PDT)
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
To:     Will Deacon <will@kernel.org>
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
References: <YKObZ1GcfVIVWRWt@google.com>
 <20210518105951.GC7770@willie-the-truck> <YKO+9lPLQLPm4Nwt@google.com>
 <YKYoQ0ezahSC/RAg@localhost.localdomain>
 <20210520101640.GA10065@willie-the-truck> <YKY7FvFeRlXVjcaA@google.com>
 <f9d1a138-3150-d404-7cd5-ddf72e93837b@redhat.com>
 <0dbdfe1e-dede-d33d-ca89-768a1fa3c907@arm.com>
 <eff0f358-d5f3-47c7-539b-527814093f89@redhat.com>
 <8bc24850-3a14-5dd2-fbc2-bf745616949f@arm.com>
 <20210520180318.GB10523@willie-the-truck>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <2055b1d4-ef42-0f49-6a0c-40c8415ef945@arm.com>
Date:   Fri, 21 May 2021 13:26:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520180318.GB10523@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 20/05/2021 20:03, Will Deacon wrote:
> Hi Dietmar,
> 
> On Thu, May 20, 2021 at 07:55:27PM +0200, Dietmar Eggemann wrote:
>> On 20/05/2021 18:00, Daniel Bristot de Oliveira wrote:
>>> On 5/20/21 5:06 PM, Dietmar Eggemann wrote:
>>>> (1) # chrt -d -T 5000000 -P 16666666 0 ./32bit_app
>>>>
>>>> (2) # ./32bit_app &
>>>>
>>>>     # chrt -d -T 5000000 -P 16666666 -p 0 pid_of(32bit_app)
>>>>
>>>>
>>>> Wouldn't the behaviour of (1) and (2) be different w/o this patch?
>>>>
>>>> In (1) __sched_setscheduler() happens before execve so it operates on
>>>> p->cpus_ptr equal span.
>>>>
>>>> In (2) span != p->cpus_ptr so DL AC will fail.
>>>>
>>>
>>> As far as I got, the case (1) would be spitted in two steps:
>>>
>>>  - __sched_setscheduler() will work, then
>>>  - execv() would fail because (span != p->cpus_ptr)
>>>
>>> So... at the end, both (1) and (2) would result in a failure...
>>>
>>> am I missing something?
>>
>> Not sure. Reading this thread I was under the assumption that the only
>> change would be the drop of this patch. But I assume there is also this
>> 'if DL AC is on then let sched_setattr() fail for this 32bit task'.
>>
>> IMHO, the current patch-stack w/o this patch should let (1) succeed with
>> DL AC.
> 
> That's what I'm proposing, yes, but others (including Daniel) prefer to
> fail the execve(). See my other reply just now for a summary [1].

[...]

Thanks, Will ... Now I understand. Or at least I think I do ;-)

> [1] https://lore.kernel.org/lkml/20210520180138.GA10523@willie-the-truck/T/#u

