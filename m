Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D77E2DCFE3
	for <lists+linux-arch@lfdr.de>; Thu, 17 Dec 2020 11:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgLQK4d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Dec 2020 05:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLQK4c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Dec 2020 05:56:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BCBC061794;
        Thu, 17 Dec 2020 02:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ycg1OWAhAt+ZzpKUE25E7HoWCVHWxaXFmMVVBcTRYoc=; b=NX0krpKMDNxEPEbp50YVfpAz4B
        hyMdM2+iQL70Wd2u931sbt7vRbCXKNXaBjRhXJptWC11dhxVFLsaBcKUDNVWwn5DtkuUar0yPhU3b
        8xLaBCsCa5Agp8bQGosbLmujhoHo+gATn89UWeH1Ok+FZiMFDCFI/VKJJlnxFiGUdhRu/lAjI8ESE
        MdaoVigvRXpekClccOpK2+UWLGEjnjvCamelEi6uRV3r9VeL85PlTrXJiDz760jRD64NnT2mK6GQw
        t+80Xn9VhHbYMiTq3g/WumfWH+8VD+dyHACE8qhA+xB1DDsIm5fR23eG/WIOmQ52WiIe0PuYlbxSG
        THr/Gwow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpqwZ-0004TP-58; Thu, 17 Dec 2020 10:55:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9246D305C11;
        Thu, 17 Dec 2020 11:55:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67014202395BD; Thu, 17 Dec 2020 11:55:33 +0100 (CET)
Date:   Thu, 17 Dec 2020 11:55:33 +0100
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
Message-ID: <20201217105533.GV3040@hirez.programming.kicks-ass.net>
References: <20201208132835.6151-1-will@kernel.org>
 <20201215173645.GJ3040@hirez.programming.kicks-ass.net>
 <20201215185012.GA15566@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215185012.GA15566@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 15, 2020 at 06:50:12PM +0000, Will Deacon wrote:
> On Tue, Dec 15, 2020 at 06:36:45PM +0100, Peter Zijlstra wrote:

> > IOW, any (accidental or otherwise) trip through a 32bit helper, will
> > destroy user state (the affinity mask: 0x3c).
> 
> Yes, that's correct, and I agree that it's a rough edge. If you're happy
> with the idea of adding an extra mask to make this work, then I can start
> hacking that up

Yeah, I'm afraid we'll have to, this asymmetric muck is only going to
get worse from here on.

Anyway, I think we can avoid adding another cpumask_t to task_struct and
do with a cpumask_t * insteads. After all, for 'normal' tasks, the
task_cpu_possible_mask() will be cpu_possible_mask and we don't need to
carry anything extra.

Only once we hit one of these assymetric ISA things, can the task
allocate the additional cpumask and retain the full mask.

> (although I doubt I'll get something out before the new
> year at this point).

Yeah, we're all about to shut down for a bit, I'll not be looking at
email for 2 weeks either, so even if you send it, I might not see it
until the next year.

