Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2961466D8
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 12:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgAWLfz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 06:35:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:48480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgAWLfz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jan 2020 06:35:55 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBD9224125;
        Thu, 23 Jan 2020 11:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579779354;
        bh=NgRc4r3/WU3L+AaQZpJg9EMLS9NAgkFiIf8N0LyNC+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jjE8q2j+F9NR+6NUtDnw5ybuvoh3/gXOO538RDz1Cem8SjaEsHRMDFEkXXNJm+lm+
         fkLMODHS28CRnHPazsbkpUlIDTtq7FnPNF9s0Uch7YSSCvgesocygv7IoYAlNFTQaB
         dJDXbBQRVrNqvf5CCLb60sDENtvFOlIBGjPB4vRk=
Date:   Thu, 23 Jan 2020 11:35:47 +0000
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Lihao Liang <lihaoliang@google.com>,
        Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com, dave.dice@oracle.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
Message-ID: <20200123113547.GD18991@willie-the-truck>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <CAC4j=Y8rCeTX9oKKbh+dCdTP8Ud4hW1ybu+iE7t_nxMSYBOR5w@mail.gmail.com>
 <4e15fa1d-9540-3274-502a-4195a0d46f63@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e15fa1d-9540-3274-502a-4195a0d46f63@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi folks,

(I think Lihao is travelling at the moment, so he may be delayed in his
replies)

On Wed, Jan 22, 2020 at 12:24:58PM -0500, Waiman Long wrote:
> On 1/22/20 6:45 AM, Lihao Liang wrote:
> > On Wed, Jan 22, 2020 at 10:28 AM Alex Kogan <alex.kogan@oracle.com> wrote:
> >> Summary
> >> -------
> >>
> >> Lock throughput can be increased by handing a lock to a waiter on the
> >> same NUMA node as the lock holder, provided care is taken to avoid
> >> starvation of waiters on other NUMA nodes. This patch introduces CNA
> >> (compact NUMA-aware lock) as the slow path for qspinlock. It is
> >> enabled through a configuration option (NUMA_AWARE_SPINLOCKS).
> >>
> > Thanks for your patches. The experimental results look promising!
> >
> > I understand that the new CNA qspinlock uses randomization to achieve
> > long-term fairness, and provides the numa_spinlock_threshold parameter
> > for users to tune. As Linux runs extremely diverse workloads, it is not
> > clear how randomization affects its fairness, and how users with
> > different requirements are supposed to tune this parameter.
> >
> > To this end, Will and I consider it beneficial to be able to answer the
> > following question:
> >
> > With different values of numa_spinlock_threshold and
> > SHUFFLE_REDUCTION_PROB_ARG, how long do threads running on different
> > sockets have to wait to acquire the lock? This is particularly relevant
> > in high contention situations when new threads keep arriving on the same
> > socket as the lock holder.
> >
> > In this email, I try to provide some formal analysis to address this
> > question. Let's assume the probability for the lock to stay on the
> > same socket is *at least* p, which corresponds to the probability for
> > the function probably(unsigned int num_bits) in the patch to return *false*,
> > where SHUFFLE_REDUCTION_PROB_ARG is passed as the value of num_bits to the
> > function.
> 
> That is not strictly true from my understanding of the code. The
> probably() function does not come into play if a secondary queue is
> present. Also calling cna_scan_main_queue() doesn't guarantee that a
> waiter in the same node can be found. So the simple mathematical
> analysis isn't that applicable in this case. One will have to do an
> actual simulation to find out what the actual behavior will be.

It's certainly true that the analysis is based on the worst-case scenario,
but I think it's still worth considering. For example, the secondary queue
does not exist initially so it seems a bit odd that we only instantiate it
with < 1% probability.

That said, my real concern with any of this is that it makes formal
modelling and analysis of the qspinlock considerably more challenging. I
would /really/ like to see an update to the TLA+ model we have of the
current implementation [1] and preferably also the userspace version I
hacked together [2] so that we can continue to test and validate changes
to the code outside of the usual kernel stress-testing.

Will

[1] https://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/kernel-tla.git/
[2] https://mirrors.edge.kernel.org/pub/linux/kernel/people/will/spinbench/
