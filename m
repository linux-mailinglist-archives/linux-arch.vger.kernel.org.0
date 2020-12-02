Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFD92CBB9A
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 12:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgLBLeA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 06:34:00 -0500
Received: from foss.arm.com ([217.140.110.172]:36844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLBLeA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Dec 2020 06:34:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18E5B101E;
        Wed,  2 Dec 2020 03:33:14 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC0C53F575;
        Wed,  2 Dec 2020 03:33:11 -0800 (PST)
Date:   Wed, 2 Dec 2020 11:33:09 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v4 09/14] cpuset: Don't use the cpu_possible_mask as a
 last resort for cgroup v1
Message-ID: <20201202113309.r37d25u6wjfighns@e107158-lin.cambridge.arm.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-10-will@kernel.org>
 <20201127133245.4hbx65mo3zinawvo@e107158-lin.cambridge.arm.com>
 <20201130170531.qo67rai5lftskmk2@e107158-lin.cambridge.arm.com>
 <20201130173610.GA1715200@google.com>
 <20201201115842.t77abecneuesd5ih@e107158-lin.cambridge.arm.com>
 <20201201123748.GA1896574@google.com>
 <20201201141121.5w2wed3633slo6dw@e107158-lin.cambridge.arm.com>
 <20201201155649.GB1914005@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201155649.GB1914005@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/01/20 15:56, Quentin Perret wrote:
> On Tuesday 01 Dec 2020 at 14:11:21 (+0000), Qais Yousef wrote:
> > AFAIU, OEMs have to define their cpusets. So it makes sense to me for them to
> > define it correctly if they want to enable asym aarch32.
> > 
> > Systems that don't care about this feature shouldn't be affected. If they do,
> > then I'm missing something.
> 
> Right, but there are 2 cases for 32 bit tasks in Android:
> 
>   1. 32 bit apps; these are not an issue, the Android framework knows
>      about them and it's fine to expect it to setup cpusets accordingly
>      IMO.
> 
>   2. 64 bit apps that also happen to have a 32 bit binary payload, and
>      exec into it. The Android framework has no visibility over that,
>      all it sees is a 64 bit app. Sadly we can't detect this stupid
>      pattern, but we need these to remain somewhat functional.
> 
> I was only talking about 2. the whole time, sorry if that wasn't clear.
> With that said, see below for the discussion about cpuset/hotplug.

Yep, I was referring to 2 too. I found out about the app that embeds the 32 bit
binary, it was our major concern if we go with user space managing affinities.

> 
> > We deal with hotplug by not allowing one of the aarch32 cpus from going
> > offline.
> 
> Sure, but that would only work if we have that 32 bit CPU present in
> _all_ cpusets, no? What I'd like to avoid is to keep a (big) 32
> bit CPU in the background cpuset of 64 bit tasks. That would make that
> big CPU available to _all_ 64 bit apps in the background, whether they
> need 32 bit support or not, because again we cannot distinguish them.
> And yeah, I expect this to be not go down well in practice.
> 
> 
> So, if we're going to support this, a requirement for Android is that
> some cpusets will be 64 bit only, and it's possible that we'll exec into
> 32 bit from within these cpusets. It's an edge case, we don't really
> want to optimize for it, but it needs to not fall apart completely.
> I'm not fundamentally against doing smarter things at all, I'm saying we
> (Android) just don't _need_ smarter things ATM, so we may want to keep
> it simple.

Fair enough. But in that case I find it neater to fix the affinities up in the
arch code as a specific solution. I'm not seeing there's a difference in the
end results between the two implementations if we don't address these issues
:(

> 
> My point in the previous message is, if we're accepting this for exec,
> a logical next step could be to accept it for cpuset migrations too.
> Failing the cgroup migration is hard since: there is no guarantee the
> source cpuset has 32 bit CPUs anyway (assuming the exec'd task is kept
> in the same cpuset), so why bother; userspace just doesn't know there
> are 32 bit tasks in an app and would keep trying to migrate it to 64 bit
> cpuset over and over again; you could end up with apps being stuck
> halfway through a top-app->background transition where some tasks have
> migrated but not others, ...
> 
> It's a bit of a mess :/

It is. I think I addressed these concerns in other parts from my previous
email. Judging by your reply below I think you see what I was talking about and
we're more on the same page now :-)

> 
> 
> <snip>
> > For hotplug we have to make sure a single cpu stays alive. The fallback you're
> > talking about should still work the same if the task is not attached to
> > a cpuset. Just it has to take the intersection with the
> > arch_task_cpu_possible_cpu() into account.
> 
> Yep, agreed, there's probably room for improvement there.
> 
> > For cpusets, if hotunplug results in an empty cpuset, then all tasks are moved
> > to the nearest ancestor if I read the code correctly. In our case, only 32bit
> > tasks have to move out to retain this behavior. Since now for the first time we
> > have tasks that can't run on all cpus.
> > 
> > Which by the way might be the right behavior for 64bit tasks execing 32bit
> > binary in a 64bit only cpuset. I suggested SIGKILL'ing them but maybe moving
> > them to the nearest ancestor too is more aligned with the behavior above.
> 
> Hmm, I guess that means putting all 32-bit-execd-from-64-bit tasks in
> the root group in Android. I'll try and check the implications, but that
> might be just fine... Sounds like a sensible behaviour to me anyways.

It'd be only the compat tasks that will have to move to root group. And only
for those minority of apps that embed a 32bit binary. I think the impact is
minimum. And I think the behavior makes sense generically.

Thanks!

--
Qais Yousef
