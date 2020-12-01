Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B89A2CA92A
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 18:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388080AbgLAQ54 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 11:57:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:42186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391923AbgLAQ5z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Dec 2020 11:57:55 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF72D208FE;
        Tue,  1 Dec 2020 16:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606841835;
        bh=TD1OZINnY67L3Dc0uTdiWI+k0pIiWGWqD8B7hdSEwtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cerhKoK4Goj22/4KIM/bZh+JacRzL+mMtrkqnS6nd/4K2XghIlz8IpR945QMidmyU
         Bv/DyiZUVDLW/UDzs5/v77e4wKdS05kZ6yP0QTdtUrTFOi7XCR9G5bD1WLtJruPVuH
         XPEPDg1fqmG/FzNrr/srx2Q9oL89rLAXy6TgnlHI=
Date:   Tue, 1 Dec 2020 16:57:08 +0000
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH v4 03/14] KVM: arm64: Kill 32-bit vCPUs on systems with
 mismatched EL0 support
Message-ID: <20201201165707.GF27783@willie-the-truck>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-4-will@kernel.org>
 <9bd06b193e7fb859a1207bb1302b7597@kernel.org>
 <20201127115304.GB20564@willie-the-truck>
 <583c4074bbd4cf8b8085037745a5d1c0@kernel.org>
 <20201127172434.GA984327@google.com>
 <9de8639549040b4478b312503fd5a23f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9de8639549040b4478b312503fd5a23f@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 27, 2020 at 06:16:35PM +0000, Marc Zyngier wrote:
> On 2020-11-27 17:24, Quentin Perret wrote:
> > On Friday 27 Nov 2020 at 17:14:11 (+0000), Marc Zyngier wrote:
> 
> [...]
> 
> > > Yeah, the sanitized read feels better, if only because that is
> > > what we are going to read in all the valid cases, unfortunately.
> > > read_sanitised_ftr_reg() is sadly not designed to be called on
> > > a fast path, meaning that 32bit guests will do a bsearch() on
> > > the ID-regs every time they exit...
> > > 
> > > I guess we will have to evaluate how much we loose with this.
> > 
> > Could we use the trick we have for arm64_ftr_reg_ctrel0 to speed this
> > up?
> 
> Maybe. I want to first verify whether this has any measurable impact.
> Another possibility would be to cache the last read_sanitised_ftr_reg()
> access, just to see if that helps. There shouldn't be that many code
> paths hammering it.

We don't have huge numbers of ID registers, so the bsearch shouldn't be
too expensive. However, I'd like to remind myself why we can't index into
the feature register array directly as we _should_ know all of this stuff
at compile time, right?

Will
