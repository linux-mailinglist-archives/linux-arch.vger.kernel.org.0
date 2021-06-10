Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3330A3A2940
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jun 2021 12:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFJKWe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Jun 2021 06:22:34 -0400
Received: from foss.arm.com ([217.140.110.172]:56194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230086AbhFJKWe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Jun 2021 06:22:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A12CD6E;
        Thu, 10 Jun 2021 03:20:38 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 051873F694;
        Thu, 10 Jun 2021 03:20:35 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        kernel-team@android.com
Subject: Re: [PATCH v8 11/19] sched: Allow task CPU affinity to be restricted on asymmetric systems
In-Reply-To: <20210607225202.GB8215@willie-the-truck>
References: <20210602164719.31777-1-will@kernel.org> <20210602164719.31777-12-will@kernel.org> <87zgw5d05b.mognet@arm.com> <20210607225202.GB8215@willie-the-truck>
Date:   Thu, 10 Jun 2021 11:20:33 +0100
Message-ID: <87eedac972.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 07/06/21 23:52, Will Deacon wrote:
> On Fri, Jun 04, 2021 at 06:12:32PM +0100, Valentin Schneider wrote:
>> On 02/06/21 17:47, Will Deacon wrote:
>> > +	/*
>> > +	 * Forcefully restricting the affinity of a deadline task is
>> > +	 * likely to cause problems, so fail and noisily override the
>> > +	 * mask entirely.
>> > +	 */
>> > +	if (task_has_dl_policy(p) && dl_bandwidth_enabled()) {
>> > +		err = -EPERM;
>> > +		goto err_unlock;
>> > +	}
>> > +
>> > +	if (!cpumask_and(new_mask, &p->cpus_mask, subset_mask)) {
>> > +		err = -EINVAL;
>> > +		goto err_unlock;
>> > +	}
>> > +
>> > +	/*
>> > +	 * We're about to butcher the task affinity, so keep track of what
>> > +	 * the user asked for in case we're able to restore it later on.
>> > +	 */
>> > +	if (user_mask) {
>> > +		cpumask_copy(user_mask, p->cpus_ptr);
>> > +		p->user_cpus_ptr = user_mask;
>> > +	}
>> > +
>>
>> Shouldn't that be done before any of the bailouts above, so we can
>> potentially restore the mask even if we end up forcefully expanding the
>> affinity?
>
> I don't think so. I deliberately only track the old mask if we've managed
> to take a subset for the 32-bit task. If we end up having to override the
> mask entirely, then I treat it the same way as an explicit affinity change
> (only with a warning printed) and don't then try to restore the old mask --
> it feels like we'd be overriding the affinity twice if we tried to do that.
>

Put in this way, it does make sense to me. Thanks!
