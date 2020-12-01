Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F822CA2D4
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 13:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgLAMie (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 07:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgLAMie (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Dec 2020 07:38:34 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AE6C0613D4
        for <linux-arch@vger.kernel.org>; Tue,  1 Dec 2020 04:37:53 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id x22so2487226wmc.5
        for <linux-arch@vger.kernel.org>; Tue, 01 Dec 2020 04:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lBUww53RFhoSaA4q+roaei0e4iCTcYgJXrbA2ztPW1s=;
        b=V4UhIUVR2V1Ts6TfWAjd3Xk02gdycLDzXgLKwUvsYOCK3WXCsjGTifjGfsUD2SLFr5
         v4pdCtNjSfhH6lqdkxSv/sK+K3SmbVydOb/PHVBJYlIca6EzsIL1FsjlsyG3HTh3vNen
         G/YCDDpD9p9IIpIM6AnIAuwRylLQ6cJEDsLxkrZctPaFeW6MEx7eod3nzNbxaTsHIkMb
         CKgcLS0dtMfSwHNl2ewGNobaxAEU2+YFS8OvEF7vQhyhhMcrwP9EjvDRE6gmp3eXySOE
         yuISy+nLTfZ0p+NuMpsJI6/gYvhJSBN6FcOQMRaqbpyuOXXcKbgllp5u0gqe93rM78db
         GDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lBUww53RFhoSaA4q+roaei0e4iCTcYgJXrbA2ztPW1s=;
        b=KbAHNNmkb03Pkb7RieTY0rtQuaLmcsQeB6SIDEpKJqClWRYUz+JcjQHwE+F6tL5iiA
         dZ0MAms3VBsTqIvj5odvkMSNdK17fqy76SZaU3FZSHIDx+GTU4fYJxtl9nIrW1KN2CHd
         9CtjL1y829FwkpHig0SmHQM0yxucQ+JlNiiwDq06AKISN2fN3jRr1yZDrtBSiyhmKTZJ
         WtUmEufa0ardZeN7tsor5GknVI2rSHbbSRt8GCqOyJRzcUjrzU+fFofSry48NszT+syN
         v1q6qSDqpMsEydu0U61sRkYuJuXDRQr1tpGkMoV0lnfOfi/KepkDAThDqjDX0uT404qz
         zCbA==
X-Gm-Message-State: AOAM533p7bKy8dznXVYyUnh0sicB9c9gRCiJCDoZhJfgw7M2gCq/3S6w
        tyhMwmZkCQjuqS2uYnUYWLDVWw==
X-Google-Smtp-Source: ABdhPJxVMxM7zxrRtQ5ATPRAIFdYrni8gzqkoCgfysS6KtplDal1I2J1qZu15IQmmDN/O+Q++hoi5g==
X-Received: by 2002:a7b:c05a:: with SMTP id u26mr2471062wmc.159.1606826272146;
        Tue, 01 Dec 2020 04:37:52 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id 21sm3147147wme.0.2020.12.01.04.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 04:37:51 -0800 (PST)
Date:   Tue, 1 Dec 2020 12:37:48 +0000
From:   Quentin Perret <qperret@google.com>
To:     Qais Yousef <qais.yousef@arm.com>
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
Message-ID: <20201201123748.GA1896574@google.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-10-will@kernel.org>
 <20201127133245.4hbx65mo3zinawvo@e107158-lin.cambridge.arm.com>
 <20201130170531.qo67rai5lftskmk2@e107158-lin.cambridge.arm.com>
 <20201130173610.GA1715200@google.com>
 <20201201115842.t77abecneuesd5ih@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201115842.t77abecneuesd5ih@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tuesday 01 Dec 2020 at 11:58:42 (+0000), Qais Yousef wrote:
> On 11/30/20 17:36, Quentin Perret wrote:
> > On Monday 30 Nov 2020 at 17:05:31 (+0000), Qais Yousef wrote:
> > > I create 3 cpusets: 64bit, 32bit and mix. As the name indicates, 64bit contains
> > > all 64bit-only cpus, 32bit contains 32bit-capable ones and mix has a mixture of
> > > both.
> > > 
> > > If I try to move my test binary to 64bit cpuset, it moves there and I see the
> > > WARN_ON_ONCE() triggered. The task has attached to the new cpuset but
> > > set_allowed_cpus_ptr() has failed and we end up with whatever affinity we had
> > > previously. Breaking cpusets effectively.
> > 
> > Right, and so does exec'ing from a 64 bit task into 32 bit executable
> > from within a 64 bit-only cpuset :( . And there is nothing we can really
> 
> True. The kernel can decide to kill the task or force detach it then, no?
> Sending SIGKILL makes more sense.

Yeah but again, we need this to work for existing apps. Just killing it
basically means we have no support, so that doesn't work for the use
case :/

> > do about it, we cannot fail the exec because we need this to work for
> > existing apps, and there is no way the Android framework can know
> > upfront.
> 
> It knows upfront it has enabled asym aarch32. So it needs to make sure not to
> create 'invalid' cpusets?

Problem is, we _really_ don't want to keep a big CPU in the background
cpuset just for that. And even if we did, we'd have to deal with hotplug.

> > 
> > So the only thing we can do really is WARN() and proceed to ignore the
> > cpuset, which is what this series does :/. It's not exactly pretty but I
> > don't think we can do much better than that TBH, and it's the same thing
> > for the example you brought up. Failing cpuset_can_attach() will not
> > help, we can only WARN and proceed ...
> 
> I think for cases where we can prevent userspace from doing something wrong, we
> should. Like trying to attach to a cpuset that will result in an empty mask.
> FWIW, it does something similar with deadline tasks. See task_can_attach().
> 
> Similarly for the case when userspace tries to modify the cpuset.cpus such that
> a task will end up with empty cpumask. We now have the new case that some tasks
> can only run on a subset of cpu_possible_mask. So the definition of empty
> cpumask has gained an extra meaning.

I see this differently, e.g. if you affine a task to a CPU and you
hotunplug it, then the kernel falls back to the remaining online CPUs
for that task. Not pretty, but it keeps things functional. I'm thinking
a similar kind of support would be good enough here.

But yes, this cpuset mess is the part of the series I hate most too.
It's just not clear we have better solutions :/

> > 
> > Now, Android should be fine with that I think. We only need the kernel
> > to implement a safe fallback mechanism when userspace gives
> > contradictory commands, because we know there are edge cases userspace
> > _cannot_ deal with correctly, but this fallback doesn't need to be
> > highly optimized (at least for Android), but I'm happy to hear what
> > others think.
> 
> Why not go with our original patch that fixes affinity then in the arch code if
> the task wakes up on the wrong cpu? It is much simpler approach IMO to achieve
> the same thing.

I personally had no issues with that patch, but as per Peter's original
reply, that's "not going to happen". Will's proposal seems to go one
step further and tries its best to honor the contract with userspace (by
keeping the subset of the affinity mask, ...) when that can be done, so
if that can be acceptable, then be it. But I'd still rather keep this
simple if at all possible. It's just my opinion though :)

Thanks,
Quentin
