Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11912CB69D
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 09:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgLBISq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 03:18:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:54394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgLBISq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Dec 2020 03:18:46 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CE08221FA;
        Wed,  2 Dec 2020 08:18:05 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kkNKt-00FHEK-BO; Wed, 02 Dec 2020 08:18:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 02 Dec 2020 08:18:03 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
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
In-Reply-To: <20201201165707.GF27783@willie-the-truck>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-4-will@kernel.org>
 <9bd06b193e7fb859a1207bb1302b7597@kernel.org>
 <20201127115304.GB20564@willie-the-truck>
 <583c4074bbd4cf8b8085037745a5d1c0@kernel.org>
 <20201127172434.GA984327@google.com>
 <9de8639549040b4478b312503fd5a23f@kernel.org>
 <20201201165707.GF27783@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <5e59a8f5bc84403ce2c8f26aa874cb1b@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, qperret@google.com, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, gregkh@linuxfoundation.org, peterz@infradead.org, morten.rasmussen@arm.com, qais.yousef@arm.com, surenb@google.com, tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org, mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-12-01 16:57, Will Deacon wrote:
> On Fri, Nov 27, 2020 at 06:16:35PM +0000, Marc Zyngier wrote:
>> On 2020-11-27 17:24, Quentin Perret wrote:
>> > On Friday 27 Nov 2020 at 17:14:11 (+0000), Marc Zyngier wrote:
>> 
>> [...]
>> 
>> > > Yeah, the sanitized read feels better, if only because that is
>> > > what we are going to read in all the valid cases, unfortunately.
>> > > read_sanitised_ftr_reg() is sadly not designed to be called on
>> > > a fast path, meaning that 32bit guests will do a bsearch() on
>> > > the ID-regs every time they exit...
>> > >
>> > > I guess we will have to evaluate how much we loose with this.
>> >
>> > Could we use the trick we have for arm64_ftr_reg_ctrel0 to speed this
>> > up?
>> 
>> Maybe. I want to first verify whether this has any measurable impact.
>> Another possibility would be to cache the last 
>> read_sanitised_ftr_reg()
>> access, just to see if that helps. There shouldn't be that many code
>> paths hammering it.
> 
> We don't have huge numbers of ID registers, so the bsearch shouldn't be
> too expensive. However, I'd like to remind myself why we can't index 
> into
> the feature register array directly as we _should_ know all of this 
> stuff
> at compile time, right?

Simply because it's not indexed by ID reg. It's just an ordered 
collection,
similar to the for sys_reg emulation in KVM. You can compute the index
ahead of time, but just not at compile time. At least not with the
way the arm64_ftr_regs array is built.

         M.
-- 
Jazz is not dead. It just smells funny...
