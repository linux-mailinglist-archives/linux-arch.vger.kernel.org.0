Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDDC38E809
	for <lists+linux-arch@lfdr.de>; Mon, 24 May 2021 15:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhEXNuy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 09:50:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232409AbhEXNuy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 May 2021 09:50:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A67761370;
        Mon, 24 May 2021 13:49:23 +0000 (UTC)
Date:   Mon, 24 May 2021 14:49:21 +0100
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
Message-ID: <20210524134920.GB14645@arm.com>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-3-will@kernel.org>
 <20210521102523.GB6675@arm.com>
 <20210524120550.GA14913@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524120550.GA14913@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 24, 2021 at 01:05:50PM +0100, Will Deacon wrote:
> On Fri, May 21, 2021 at 11:25:23AM +0100, Catalin Marinas wrote:
> > On Tue, May 18, 2021 at 10:47:06AM +0100, Will Deacon wrote:
> > > +static bool has_32bit_el0(const struct arm64_cpu_capabilities *entry, int scope)
> > > +{
> > > +	if (!has_cpuid_feature(entry, scope))
> > > +		return allow_mismatched_32bit_el0;
> > > +
> > > +	if (scope == SCOPE_SYSTEM)
> > > +		pr_info("detected: 32-bit EL0 Support\n");
> > > +
> > > +	return true;
> > > +}
> > 
> > We may have discussed this before: AFAICT this will print 32-bit EL0
> > detected even if there's no 32-bit EL0 on any CPU. Should we instead
> > print 32-bit EL0 detected on CPU X when allow_mismatched_32bit_el0 is
> > passed? It would also give us an indication of the system configuration
> > when people start reporting bugs.
> 
> The function above only runs if we've detected 32-bit support via
> aa64pfr0_el1, so I think we're ok. We also have a print when we detect the
> mismatch (see enable_mismatched_32bit_el0()).

It makes sense, you removed the .desc from the arm64_features entry as
well.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
