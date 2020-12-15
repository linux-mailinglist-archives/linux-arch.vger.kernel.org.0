Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC29D2DB2C9
	for <lists+linux-arch@lfdr.de>; Tue, 15 Dec 2020 18:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgLORhr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Dec 2020 12:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731320AbgLORhq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Dec 2020 12:37:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08D9C06179C;
        Tue, 15 Dec 2020 09:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OpLblT8P1Hbc/QDHxOcAOdfaojoLZC8gmneeEU8P1oA=; b=Zq90lByVQFOlblPa+1n23PFbSz
        zlDzGPVyXT2+SJ/VlKY6GGI3QQV9XloT+gcykGnLvf91P4/NuR+Wo9T9ifxki47g0RPayNF3x0hnh
        tairrq14GdttYSRGdfkFoK6qHlRbF5ezrqA3tiOyd3t+yo9Vq4NPu56/hpquGbRTDKhOP+WoHwqGh
        JdY1uRJSadgYCgyW/pJAadoc4M2pQGPRTw96t94xlZ3B9sazpi3QOGkikQIRROkEsshqdIh/WmSjF
        jXsN1kuCvgdMS4qdGb7EJS008M2/VIeKiFLXGzNbav5BGmuiPouOE/rm8HQpcrGWM1RFLTJN+OeNe
        DNuXTc+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpEFk-0006vz-KL; Tue, 15 Dec 2020 17:36:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B6BD3070AB;
        Tue, 15 Dec 2020 18:36:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F432203EE86F; Tue, 15 Dec 2020 18:36:45 +0100 (CET)
Date:   Tue, 15 Dec 2020 18:36:45 +0100
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
Subject: Re: [PATCH v5 00/15] An alternative series for asymmetric AArch32
 systems
Message-ID: <20201215173645.GJ3040@hirez.programming.kicks-ass.net>
References: <20201208132835.6151-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208132835.6151-1-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 08, 2020 at 01:28:20PM +0000, Will Deacon wrote:
> The aim of this series is to allow 32-bit ARM applications to run on
> arm64 SoCs where not all of the CPUs support the 32-bit instruction set.
> Unfortunately, such SoCs are real and will continue to be productised
> over the next few years at least. I can assure you that I'm not just
> doing this for fun.
> 
> Changes in v5 include:
> 
>   * Teach cpuset_cpus_allowed() about task_cpu_possible_mask() so that
>     we can avoid returning incompatible CPUs for a given task. This
>     means that sched_setaffinity() can be used with larger masks (like
>     the online mask) from userspace and also allows us to take into
>     account the cpuset hierarchy when forcefully overriding the affinity
>     for a task on execve().
> 
>   * Honour task_cpu_possible_mask() when attaching a task to a cpuset,
>     so that the resulting affinity mask does not contain any incompatible
>     CPUs (since it would be rejected by set_cpus_allowed_ptr() otherwise).
> 
>   * Moved overriding of the affinity mask into the scheduler core rather
>     than munge affinity masks directly in the architecture backend.

Hurmph... so if I can still read, this thing will auto truncate the
affinity mask to something that only contains compatible CPUs, right?

Assuming our system has 8 CPUs (0xFF), half of which are 32bit capable
(0x0F), then, when our native task (with affinity 0x3c) does a
fork()+execve() of a 32bit thingy the resulting task has 0x0c.

If that in turn does fork()+execve() of a native task, it will retain
the trucated affinity mask (0x0c), instead of returning to the wider
mask (0x3c).

IOW, any (accidental or otherwise) trip through a 32bit helper, will
destroy user state (the affinity mask: 0x3c).


Should we perhaps split task_struct::cpus_mask, one to keep an original
copy of the user state, and one to be an effective cpumask for the task?
That way, the moment a task constricts or widens it's
task_cpu_possible_mask() we can re-compute the effective mask without
loss of information.
