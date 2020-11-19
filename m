Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B742E2B90A3
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 12:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgKSLGx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 06:06:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgKSLGx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Nov 2020 06:06:53 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFB2522248;
        Thu, 19 Nov 2020 11:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605784013;
        bh=b8cCQkCQy5W7ziGXPmOkx0Jd36itvYN1twVbH+66fBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oOTfAO/eWZincc5ZJR4RbQaf9A7bNYPCEj71/S73O083IgI42moMXcQSz2+X46rSX
         HyNg0E5wSn6Q/8+yutHMRSZDE2E6YHlF9XCFxLzPD7Ph2z6vTW435lOlqvz/h5uFb/
         Gdnh7NveJdyAfAjj/P1z7ak4oJNUcU1mbfUQdrZs=
Date:   Thu, 19 Nov 2020 11:06:45 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v3 09/14] cpuset: Don't use the cpu_possible_mask as a
 last resort for cgroup v1
Message-ID: <20201119110645.GC3946@willie-the-truck>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-10-will@kernel.org>
 <20201119092922.GC2416649@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119092922.GC2416649@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 19, 2020 at 09:29:22AM +0000, Quentin Perret wrote:
> On Friday 13 Nov 2020 at 09:37:14 (+0000), Will Deacon wrote:
> > If the scheduler cannot find an allowed CPU for a task,
> > cpuset_cpus_allowed_fallback() will widen the affinity to cpu_possible_mask
> > if cgroup v1 is in use.
> > 
> > In preparation for allowing architectures to provide their own fallback
> > mask, just return early if we're not using cgroup v2 and allow
> > select_fallback_rq() to figure out the mask by itself.
> > 
> > Cc: Li Zefan <lizefan@huawei.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Will Deacon <will@kernel.org>
> 
> That makes select_fallback_rq() slightly more expensive if you're using
> cgroup v1, but I don't expect that be really measurable in real-world
> workloads, so:
> 
> Reviewed-by: Quentin Perret <qperret@google.com>

Cheers!

Will
