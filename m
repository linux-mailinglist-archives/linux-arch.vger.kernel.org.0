Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E823D3F0220
	for <lists+linux-arch@lfdr.de>; Wed, 18 Aug 2021 12:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhHRK7j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Aug 2021 06:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbhHRK7h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Aug 2021 06:59:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC88C0617A8;
        Wed, 18 Aug 2021 03:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SBtDwSLN4ZP4oN8nC7bQ74uVN27LxCyARNgZcE6t0bU=; b=vS0WEdliZ6cTSfKSm4x9AVOA/D
        MFfJWMSetPkCBvvwH9fUWhUH/JxmoB9Ip/4JTyGAYeT0oZ869mmqjIG2MPHWF+QFQ5cJ83RXk5Ph4
        XtN1cPPg7Y/OFO3qKPIljD9pLxUCV44ntTa0VzzAgAQO09oTJzmED47r7T+wXQCVao7Bg3NHU3Moh
        ZvpyDMsJxqDsdY3DEucu9YId3QzoITxCgmg7/abq6U7Wytly+fRgIbXOLuOLWySWQ1+acnQQeVuei
        I8835gNNV6QXTOGtyAUv17jFf6Pl60nI88yv0MhZE5C45J6MVTch2Nw7heYBJACZzYT41OC6bGJlP
        idM17XKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGJFC-003jXO-Fu; Wed, 18 Aug 2021 10:56:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0004730009A;
        Wed, 18 Aug 2021 12:56:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D156D2027DC66; Wed, 18 Aug 2021 12:56:24 +0200 (CEST)
Date:   Wed, 18 Aug 2021 12:56:24 +0200
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
Message-ID: <YRznWDtF/doFRm0/@hirez.programming.kicks-ass.net>
References: <20210730112443.23245-1-will@kernel.org>
 <20210730112443.23245-8-will@kernel.org>
 <YRvYaGa4QnhV2q51@hirez.programming.kicks-ass.net>
 <20210818105029.GC13828@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818105029.GC13828@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 18, 2021 at 11:50:30AM +0100, Will Deacon wrote:
> On Tue, Aug 17, 2021 at 05:40:24PM +0200, Peter Zijlstra wrote:
> > On Fri, Jul 30, 2021 at 12:24:34PM +0100, Will Deacon wrote:
> > > In preparation for replaying user affinity requests using a saved mask,
> > > split sched_setaffinity() up so that the initial task lookup and
> > > security checks are only performed when the request is coming directly
> > > from userspace.
> > > 
> > > Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > 
> > Should not sched_setaffinity() update user_cpus_ptr when it isn't NULL,
> > such that the upcoming relax_compatible_cpus_allowed_ptr() preserve the
> > full user mask?
> 
> The idea is that force_compatible_cpus_allowed_ptr() and
> relax_compatible_cpus_allowed_ptr() are used as a pair, with the former
> setting ->user_cpus_ptr and the latter restoring it. An intervening call
> to sched_setaffinity() must _clear_ the saved mask, as we discussed
> before at:
> 
> https://lore.kernel.org/r/YK53kDtczHIYumDC@hirez.programming.kicks-ass.net

Clearly that deserves a comment somewhere, because I keep trying to make
it more consistent than it can be :/ I'll see if I can find a spot.
