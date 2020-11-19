Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706B32B9781
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 17:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgKSQLn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 11:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbgKSQLm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Nov 2020 11:11:42 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875B3C0613CF;
        Thu, 19 Nov 2020 08:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6MTwaR9Uwxv6I9jWAPKmEAukai8cAc1ii1NIFetSveM=; b=iFFXD9LOUJTUuOIwSGJcX8s55o
        RdojCxDLq4uKg6qX1pYYDhDQZyJkPeST9qBGnnKhmh9J/zk6GF2xyY5yYyM8IVmScRjhmXpIdQgAG
        BnG5HKq25g1X61DAkuTO7RO53cX1JWWbeJZNTE/Cvz8eBnfjLrWB5QwqqOrIOqCeQCLtf6oo/SNUA
        5OlammQkJ3+Zqi0f9rzJD40X7VIuGvMGzXFSfS17DoldMEH2X/SUOcD8DXgXwY0yrPCrJtZv5rNWA
        6zmTtNUdSdgkOHrfspeHhOhZk2IKPimb899Vg9RPXavtiIJKpx3zkn96TuBSfIgZhbb2g7lH/yW93
        36DFwnPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfmWw-0001Xy-06; Thu, 19 Nov 2020 16:11:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 346B33011C6;
        Thu, 19 Nov 2020 17:11:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20385203C45DF; Thu, 19 Nov 2020 17:11:27 +0100 (CET)
Date:   Thu, 19 Nov 2020 17:11:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
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
Subject: Re: [PATCH v3 00/14] An alternative series for asymmetric AArch32
 systems
Message-ID: <20201119161127.GQ3121392@hirez.programming.kicks-ass.net>
References: <20201113093720.21106-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113093720.21106-1-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 13, 2020 at 09:37:05AM +0000, Will Deacon wrote:

> The aim of this series is to allow 32-bit ARM applications to run on
> arm64 SoCs where not all of the CPUs support the 32-bit instruction set.
> 
> There are some major changes in v3:
> 
>   * Add some scheduler hooks for restricting a task's affinity mask
>   * Implement these hooks for arm64 so that we can avoid 32-bit tasks
>     running on 64-bit-only cores
>   * Restrict affinity mask of 32-bit tasks on execve()
>   * Prevent hot-unplug of all 32-bit CPUs if we have a mismatched system
>   * Ensure 32-bit EL0 cpumask is zero-initialised (oops)
> 
> It's worth mentioning that this approach goes directly against my
> initial proposal for punting the affinity management to userspace,
> because it turns out that doesn't really work. There are cases where the
> kernel has to muck with the affinity mask explicitly, such as execve(),
> CPU hotplug and cpuset balancing. Ensuring that these don't lead to
> random SIGKILLs as far as userspace is concerned means avoiding any

Mooo, I thought we were okay with that... Use does stupid, user gets
SIGKIL. What changed?

> 64-bit-only CPUs appearing in the affinity mask for a 32-bit task, at
> which point it's easier just to handle everything in the kernel anyway.
