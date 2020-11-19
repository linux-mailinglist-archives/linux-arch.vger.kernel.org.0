Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DCD2B9779
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 17:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgKSQKF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 11:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgKSQKE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Nov 2020 11:10:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C429C0613CF;
        Thu, 19 Nov 2020 08:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gT+aycviSHZiSVl6jswLbLNrg/uiSiMYLbgQMN7rMto=; b=AI2lVVKrmsVKgsicoDpaTb0HIr
        OzOqlDqCZxXvpG7NHAX7weDFKlljBL6wnqCy//WM6TW/yMtdFKChH4FCSRKwES7Ff2+D5OmmmNjfY
        oUvepoJexunxdO7bbuqOVJhgpQpQ4vcQx8LiDhHixGr1ExZ3Lgsu2g8JAJGEhaHtkpH5xrGxzZE14
        F/1gLv41pIiaiJpC69307E1sUnlFAdn8GscUktxjPy7nxrVQQ9kv4OipQAdoRugjFHmkfhseCvNPk
        SiHL1EpaFewLIJKCSdmywkJsRJUNmzPm42Q4EL9+w2qrefjfnVGh9BSe5w/4d2heVKdBt6EAvtvKS
        cicepZ8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfmVI-0006ei-9y; Thu, 19 Nov 2020 16:09:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 228793019CE;
        Thu, 19 Nov 2020 17:09:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 01C5F200E0A45; Thu, 19 Nov 2020 17:09:44 +0100 (CET)
Date:   Thu, 19 Nov 2020 17:09:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
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
Subject: Re: [PATCH v3 07/14] sched: Introduce restrict_cpus_allowed_ptr() to
 limit task CPU affinity
Message-ID: <20201119160944.GP3121392@hirez.programming.kicks-ass.net>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-8-will@kernel.org>
 <jhj8saxwm1l.mognet@arm.com>
 <20201119131319.GE4331@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119131319.GE4331@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 19, 2020 at 01:13:20PM +0000, Will Deacon wrote:

> Sure, but I was talking about what userspace sees, and I don't think it ever
> sees CPUs that have been hotplugged off, right? That is, sched_getaffinity()
> masks its result with the active_mask.

# for i in /sys/devices/system/cpu/cpu*/online; do echo -n $i ":"; cat $i; done
/sys/devices/system/cpu/cpu1/online :0
/sys/devices/system/cpu/cpu2/online :1
/sys/devices/system/cpu/cpu3/online :1
/sys/devices/system/cpu/cpu4/online :1
/sys/devices/system/cpu/cpu5/online :1
/sys/devices/system/cpu/cpu6/online :1
/sys/devices/system/cpu/cpu7/online :1

# grep Cpus_allowed /proc/self/status
Cpus_allowed:   ff
Cpus_allowed_list:      0-7


:-)
