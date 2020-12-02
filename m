Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B2A2CBB9C
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 12:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgLBLfA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 06:35:00 -0500
Received: from foss.arm.com ([217.140.110.172]:36874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgLBLfA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Dec 2020 06:35:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9934101E;
        Wed,  2 Dec 2020 03:34:14 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77F6D3F575;
        Wed,  2 Dec 2020 03:34:12 -0800 (PST)
Date:   Wed, 2 Dec 2020 11:34:10 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Quentin Perret <qperret@google.com>,
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
Message-ID: <20201202113410.dx4m2gb7zkyregys@e107158-lin.cambridge.arm.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-10-will@kernel.org>
 <20201127133245.4hbx65mo3zinawvo@e107158-lin.cambridge.arm.com>
 <20201130170531.qo67rai5lftskmk2@e107158-lin.cambridge.arm.com>
 <20201130173610.GA1715200@google.com>
 <20201201115842.t77abecneuesd5ih@e107158-lin.cambridge.arm.com>
 <20201201123748.GA1896574@google.com>
 <20201201141121.5w2wed3633slo6dw@e107158-lin.cambridge.arm.com>
 <20201201155649.GB1914005@google.com>
 <20201201223056.GB28496@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201223056.GB28496@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/01/20 22:30, Will Deacon wrote:
> On Tue, Dec 01, 2020 at 03:56:49PM +0000, Quentin Perret wrote:
> > On Tuesday 01 Dec 2020 at 14:11:21 (+0000), Qais Yousef wrote:
> > > For cpusets, if hotunplug results in an empty cpuset, then all tasks are moved
> > > to the nearest ancestor if I read the code correctly. In our case, only 32bit
> > > tasks have to move out to retain this behavior. Since now for the first time we
> > > have tasks that can't run on all cpus.
> > > 
> > > Which by the way might be the right behavior for 64bit tasks execing 32bit
> > > binary in a 64bit only cpuset. I suggested SIGKILL'ing them but maybe moving
> > > them to the nearest ancestor too is more aligned with the behavior above.
> > 
> > Hmm, I guess that means putting all 32-bit-execd-from-64-bit tasks in
> > the root group in Android. I'll try and check the implications, but that
> > might be just fine... Sounds like a sensible behaviour to me anyways.
> 
> I'll look into this -- anything we can do to avoid forcefully resetting the
> affinity mask to the arch_task_cpu_possible_mask() is worth considering.

Happy to lend a hand, just let me know.

Thanks

--
Qais Yousef
