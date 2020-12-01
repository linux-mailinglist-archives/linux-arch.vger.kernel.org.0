Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B5D2CA794
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 17:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391953AbgLAP5l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 10:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389229AbgLAP5k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Dec 2020 10:57:40 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984B0C0613D4
        for <linux-arch@vger.kernel.org>; Tue,  1 Dec 2020 07:56:54 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id g14so3351292wrm.13
        for <linux-arch@vger.kernel.org>; Tue, 01 Dec 2020 07:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yVk5KHBR+Mddw8rCuMxzgEChumqmL4eB1KqK5P0hH5E=;
        b=UlFHk+22AOC3daNQPBuWa/WMNZh1Aip8NACSrVS7zIMCaANpB+k7HZYxRY/53FozG5
         ejfoB5rw0FQIm/4x7tHSlcIZytPxDItsRVPnGd7qrBKCVtkYSq3bsbEn0wieqpSLza+M
         J5P4tX7HOYIWiNwkc4h0gs+0qMY8CyEKgTY2ZohmAZWJCjwibOoXG3Xw/aJhrnDLH0d7
         tQoRF5o1yotOhTPfrhiXDDTIjYasLy0/3zw0CBtfa6Gkeoj3PrvpzNMJFmcYlueLw16X
         nRRH8FJcCl4/tElozP8dUn1P8pWTY4XIxbjDnPtR6vv4TP9yNf4vlMmJq4ISdt0lBAxl
         vvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yVk5KHBR+Mddw8rCuMxzgEChumqmL4eB1KqK5P0hH5E=;
        b=hMD2l7kTaSaB278l/vP7mPJIxKXPkOKQ9RRlQJ7FOTYdBROLPGyslvZIH4+OUxnklT
         nwEmOGTRpEb1tk0VP5T8vluKvWs51z52cteRp5BCeaB4hPZB2FoFLHXihweVHbw11UK+
         ehXh4cF0Gr97nkRzYMrlqwaeJoB8/MHYUK7Y+kiXRvuTa/E+rKhCM0zQC7eSANfnLsDk
         oVc2o6uLRqLw4RItQTVw2BybjUb9QVBo36niV30rulpWWgStYk+1xyQTfXkpXhSKrEll
         Hfi3jm0kRpcDI1nptUY1b9E/o/19azCukPVIgvDQJD/WZW/GGofMPMlZJXXSaALCy88G
         /CSQ==
X-Gm-Message-State: AOAM531+R2DmPmVU28tJDOCMyZXqusPKuNeutz1Im+9YreRHCtytjaQO
        SfpFKr52uQokv/TEnEOoNbRijw==
X-Google-Smtp-Source: ABdhPJy1biYd6YQn7O1yE1QJCAD4BDZLFDdoPnTRU70gL8vejvUzgcP6kviW3MJ5lcRJrE6SWUoDnw==
X-Received: by 2002:adf:e788:: with SMTP id n8mr4738634wrm.84.1606838213044;
        Tue, 01 Dec 2020 07:56:53 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id n4sm376363wmc.30.2020.12.01.07.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 07:56:52 -0800 (PST)
Date:   Tue, 1 Dec 2020 15:56:49 +0000
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
Message-ID: <20201201155649.GB1914005@google.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-10-will@kernel.org>
 <20201127133245.4hbx65mo3zinawvo@e107158-lin.cambridge.arm.com>
 <20201130170531.qo67rai5lftskmk2@e107158-lin.cambridge.arm.com>
 <20201130173610.GA1715200@google.com>
 <20201201115842.t77abecneuesd5ih@e107158-lin.cambridge.arm.com>
 <20201201123748.GA1896574@google.com>
 <20201201141121.5w2wed3633slo6dw@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201141121.5w2wed3633slo6dw@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tuesday 01 Dec 2020 at 14:11:21 (+0000), Qais Yousef wrote:
> AFAIU, OEMs have to define their cpusets. So it makes sense to me for them to
> define it correctly if they want to enable asym aarch32.
> 
> Systems that don't care about this feature shouldn't be affected. If they do,
> then I'm missing something.

Right, but there are 2 cases for 32 bit tasks in Android:

  1. 32 bit apps; these are not an issue, the Android framework knows
     about them and it's fine to expect it to setup cpusets accordingly
     IMO.

  2. 64 bit apps that also happen to have a 32 bit binary payload, and
     exec into it. The Android framework has no visibility over that,
     all it sees is a 64 bit app. Sadly we can't detect this stupid
     pattern, but we need these to remain somewhat functional.

I was only talking about 2. the whole time, sorry if that wasn't clear.
With that said, see below for the discussion about cpuset/hotplug.

> We deal with hotplug by not allowing one of the aarch32 cpus from going
> offline.

Sure, but that would only work if we have that 32 bit CPU present in
_all_ cpusets, no? What I'd like to avoid is to keep a (big) 32
bit CPU in the background cpuset of 64 bit tasks. That would make that
big CPU available to _all_ 64 bit apps in the background, whether they
need 32 bit support or not, because again we cannot distinguish them.
And yeah, I expect this to be not go down well in practice.


So, if we're going to support this, a requirement for Android is that
some cpusets will be 64 bit only, and it's possible that we'll exec into
32 bit from within these cpusets. It's an edge case, we don't really
want to optimize for it, but it needs to not fall apart completely.
I'm not fundamentally against doing smarter things at all, I'm saying we
(Android) just don't _need_ smarter things ATM, so we may want to keep
it simple.

My point in the previous message is, if we're accepting this for exec,
a logical next step could be to accept it for cpuset migrations too.
Failing the cgroup migration is hard since: there is no guarantee the
source cpuset has 32 bit CPUs anyway (assuming the exec'd task is kept
in the same cpuset), so why bother; userspace just doesn't know there
are 32 bit tasks in an app and would keep trying to migrate it to 64 bit
cpuset over and over again; you could end up with apps being stuck
halfway through a top-app->background transition where some tasks have
migrated but not others, ...

It's a bit of a mess :/


<snip>
> For hotplug we have to make sure a single cpu stays alive. The fallback you're
> talking about should still work the same if the task is not attached to
> a cpuset. Just it has to take the intersection with the
> arch_task_cpu_possible_cpu() into account.

Yep, agreed, there's probably room for improvement there.

> For cpusets, if hotunplug results in an empty cpuset, then all tasks are moved
> to the nearest ancestor if I read the code correctly. In our case, only 32bit
> tasks have to move out to retain this behavior. Since now for the first time we
> have tasks that can't run on all cpus.
> 
> Which by the way might be the right behavior for 64bit tasks execing 32bit
> binary in a 64bit only cpuset. I suggested SIGKILL'ing them but maybe moving
> them to the nearest ancestor too is more aligned with the behavior above.

Hmm, I guess that means putting all 32-bit-execd-from-64-bit tasks in
the root group in Android. I'll try and check the implications, but that
might be just fine... Sounds like a sensible behaviour to me anyways.

Thanks,
Quentin
