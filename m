Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6752CB002
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 23:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgLAWbo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 17:31:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:38942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbgLAWbn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Dec 2020 17:31:43 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 368C720671;
        Tue,  1 Dec 2020 22:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606861863;
        bh=2FqELP0kL1gtJg1OgZdi1DE1pZCr06wueem7RmEe9ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8yPkW/jGk0Rof1aFRSlnu+HT5bXjtUslWWaorpHYJtwOfdMUAEKVlXWk5mrLwBlV
         n/4S/aYvK9qw5fHqyP4PTFSaiolKLTqGugnZYxJ9lF1kEPS57nonNGG6my5fRrQZYe
         ycm/49bt3VYwv3FRSYWh0IJzJDSYaWy/82K87u5w=
Date:   Tue, 1 Dec 2020 22:30:56 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
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
Message-ID: <20201201223056.GB28496@willie-the-truck>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201155649.GB1914005@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 01, 2020 at 03:56:49PM +0000, Quentin Perret wrote:
> On Tuesday 01 Dec 2020 at 14:11:21 (+0000), Qais Yousef wrote:
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

I'll look into this -- anything we can do to avoid forcefully resetting the
affinity mask to the arch_task_cpu_possible_mask() is worth considering.

Will
