Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4AF38E7FA
	for <lists+linux-arch@lfdr.de>; Mon, 24 May 2021 15:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhEXNrg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 09:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232409AbhEXNrf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 May 2021 09:47:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBE1861090;
        Mon, 24 May 2021 13:46:04 +0000 (UTC)
Date:   Mon, 24 May 2021 14:46:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: Re: [PATCH v6 02/21] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <20210524134602.GA14645@arm.com>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-3-will@kernel.org>
 <20210521104155.GC6675@arm.com>
 <20210524120959.GB14913@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524120959.GB14913@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 24, 2021 at 01:09:59PM +0100, Will Deacon wrote:
> On Fri, May 21, 2021 at 11:41:56AM +0100, Catalin Marinas wrote:
> > On Tue, May 18, 2021 at 10:47:06AM +0100, Will Deacon wrote:
> > > +static int enable_mismatched_32bit_el0(unsigned int cpu)
> > > +{
> > > +	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
> > > +	bool cpu_32bit = id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0);
> > > +
> > > +	if (cpu_32bit) {
> > > +		cpumask_set_cpu(cpu, cpu_32bit_el0_mask);
> > > +		static_branch_enable_cpuslocked(&arm64_mismatched_32bit_el0);
> > 
> > It may be worth only calling static_branch_enable_cpuslocked() if not
> > already set, in case you try this on a system with lots of CPUs.
> 
> static_key_enable_cpuslocked() already checks this early on, so I don't
> think we need another check here (note that we're not calling stop_machine()
> here _anyway_; the '_cpuslocked' suffix just says that we're already holding
> cpu_hotplug_lock via the notifier).

Ah, you are right, no need for an additional check.

-- 
Catalin
