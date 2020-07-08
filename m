Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5603A2182BD
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jul 2020 10:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgGHIl4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jul 2020 04:41:56 -0400
Received: from casper.infradead.org ([90.155.50.34]:57892 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgGHIl4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2020 04:41:56 -0400
X-Greylist: delayed 512 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jul 2020 04:41:55 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S32XUF0JR40sOoi2lYA1Jt2WlEew0VlzGuJ1gwYbhcU=; b=s35D4xLyvnkYZU4YcWf+9NjRFK
        qAGphMcWSVhYkoJc8aLz2jh51DodnUkao4ypjVVvtlh5fcEIsMpk6UdXCby8V2qdZA2gSM5VTx11d
        ejcgbzpQUBqwaR783SFDpecCm7eKgFdgoL4fECk9Qy30bGquxIr924rnywePvDNug5/GOl4mBqpIf
        yhYDUhFAoVr+rZtcrUHltrwRK7hN7qpv20iSjblFycKsMdUlki/Rvlx96bthlu203IRbVK2rv+Qyz
        fe6lVWcbvlapeHkqUU1cRfS5tDsGg7qLw6HfdJdLjRTuWghNE1CJUhLCA2Q5UKIbSoK08YZTIcjeG
        XvtIgbgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jt5df-0008Ee-Rc; Wed, 08 Jul 2020 08:41:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BAE6F304D58;
        Wed,  8 Jul 2020 10:41:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7CDA203D34DE; Wed,  8 Jul 2020 10:41:06 +0200 (CEST)
Date:   Wed, 8 Jul 2020 10:41:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, Waiman Long <longman@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
Message-ID: <20200708084106.GE597537@hirez.programming.kicks-ass.net>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
 <1594101082.hfq9x5yact.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594101082.hfq9x5yact.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 07, 2020 at 03:57:06PM +1000, Nicholas Piggin wrote:
> Yes, powerpc could certainly get more performance out of the slow
> paths, and then there are a few parameters to tune.

Can you clarify? The slow path is already in use on ARM64 which is weak,
so I doubt there's superfluous serialization present. And Will spend a
fair amount of time on making that thing guarantee forward progressm, so
there just isn't too much room to play.

> We don't have a good alternate patching for function calls yet, but
> that would be something to do for native vs pv.

Going by your jump_label implementation, support for static_call should
be fairly straight forward too, no?

  https://lkml.kernel.org/r/20200624153024.794671356@infradead.org
