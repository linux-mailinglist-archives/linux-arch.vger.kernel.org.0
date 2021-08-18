Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049F73F025F
	for <lists+linux-arch@lfdr.de>; Wed, 18 Aug 2021 13:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbhHRLMi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Aug 2021 07:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235782AbhHRLMf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Aug 2021 07:12:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2940261058;
        Wed, 18 Aug 2021 11:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629285120;
        bh=O5UMSQA6GpBj2EJn6x+svkI8YojZoSoRp7OiToO77gQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tr1DV6m7gqZHQi1Jia+eMgoIYmsG0BoKw1M8PPeZVNMJgzFyJbPV5qUVHxjF8Ti1C
         lcH2/MmWAJyZ974o0dTOSgZpCfYfWmazSrmpwztNstdscGrLRnqOLI3kWfvo7i4Qqc
         CSpu4W/nunsxjpWaRkQw/EAEz8R14ZQklw8szAqyFxLV433iCGp3BOMtOwxClRkvG0
         Vq8jNd7s0g9XygCfc5QKTRXekiy+uXTb4DTYu94EpYlwrIDf5drsbS4bUSQrgWxfZ0
         C63PmW3iOZANRK8FPBiY1UWv73zF6azpQnbOWt3Xc6raaFlv5mMR50aPI6leE5hmnP
         v67k/bLa75GqQ==
Date:   Wed, 18 Aug 2021 12:11:53 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com
Subject: Re: [PATCH v11 07/16] sched: Split the guts of sched_setaffinity()
 into a helper function
Message-ID: <20210818111153.GA13999@willie-the-truck>
References: <20210730112443.23245-1-will@kernel.org>
 <20210730112443.23245-8-will@kernel.org>
 <YRvYaGa4QnhV2q51@hirez.programming.kicks-ass.net>
 <20210818105029.GC13828@willie-the-truck>
 <YRznWDtF/doFRm0/@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRznWDtF/doFRm0/@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 18, 2021 at 12:56:24PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 18, 2021 at 11:50:30AM +0100, Will Deacon wrote:
> > On Tue, Aug 17, 2021 at 05:40:24PM +0200, Peter Zijlstra wrote:
> > > On Fri, Jul 30, 2021 at 12:24:34PM +0100, Will Deacon wrote:
> > > > In preparation for replaying user affinity requests using a saved mask,
> > > > split sched_setaffinity() up so that the initial task lookup and
> > > > security checks are only performed when the request is coming directly
> > > > from userspace.
> > > > 
> > > > Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
> > > > Signed-off-by: Will Deacon <will@kernel.org>
> > > 
> > > Should not sched_setaffinity() update user_cpus_ptr when it isn't NULL,
> > > such that the upcoming relax_compatible_cpus_allowed_ptr() preserve the
> > > full user mask?
> > 
> > The idea is that force_compatible_cpus_allowed_ptr() and
> > relax_compatible_cpus_allowed_ptr() are used as a pair, with the former
> > setting ->user_cpus_ptr and the latter restoring it. An intervening call
> > to sched_setaffinity() must _clear_ the saved mask, as we discussed
> > before at:
> > 
> > https://lore.kernel.org/r/YK53kDtczHIYumDC@hirez.programming.kicks-ass.net
> 
> Clearly that deserves a comment somewhere, because I keep trying to make
> it more consistent than it can be :/ I'll see if I can find a spot.

Agreed. The relax/force functions are already commented, so maybe alongside
SCA_USER?

Will
