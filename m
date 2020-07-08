Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1F22182C5
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jul 2020 10:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgGHIpL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jul 2020 04:45:11 -0400
Received: from casper.infradead.org ([90.155.50.34]:57900 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgGHIpK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2020 04:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZJNpnEdpSwAOlQcxfZwII1itlZxmBIrNUFOl9UFQI0s=; b=Ya9qiXHHrdyTWGPp032YRnzFIH
        6MPYm0BEoMc8ncfqqgb17R+Q1Yuv0iN4WdS/fxjtUiznK3bLbXquZDs7sSVGogtzLN++DsaGuBaJ+
        qxeWf0cuxdCtPe/HsGMvplOVk4llp07clkobZcvBYbO9+adWvLV/Hbov12TR7dC+IhsmIB0z9Yw2T
        h9JG4XlquyLth3icw8mMkkAJA+hfeaw90jRoPMbh7DqJSBErC0cwQQ0pwFWtmhCEul0BDB0WstS46
        RzcRgZc2lOT/SzvFOdYKUM8hfD52L0Dsui/qWIIQ1E2spaJ5v3/tsywLBG9gTevjRjwSFW6I+TOuB
        k1AQxs/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jt5VF-0007ob-RZ; Wed, 08 Jul 2020 08:32:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DF5B6300739;
        Wed,  8 Jul 2020 10:32:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB50D2BDFCA5B; Wed,  8 Jul 2020 10:32:10 +0200 (CEST)
Date:   Wed, 8 Jul 2020 10:32:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        Anton Blanchard <anton@ozlabs.org>,
        Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
Message-ID: <20200708083210.GD597537@hirez.programming.kicks-ass.net>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
 <1594101082.hfq9x5yact.astroid@bobo.none>
 <de3ead58-7f81-8ebd-754d-244f6be24af4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de3ead58-7f81-8ebd-754d-244f6be24af4@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 07, 2020 at 11:33:45PM -0400, Waiman Long wrote:
> From 5d7941a498935fb225b2c7a3108cbf590114c3db Mon Sep 17 00:00:00 2001
> From: Waiman Long <longman@redhat.com>
> Date: Tue, 7 Jul 2020 22:29:16 -0400
> Subject: [PATCH 2/9] locking/pvqspinlock: Introduce
>  CONFIG_PARAVIRT_QSPINLOCKS_LITE
> 
> Add a new PARAVIRT_QSPINLOCKS_LITE config option that allows
> architectures to use the PV qspinlock code without the need to use or
> implement a pv_kick() function, thus eliminating the atomic unlock
> overhead. The non-atomic queued_spin_unlock() can be used instead.
> The pv_wait() function will still be needed, but it can be a dummy
> function.
> 
> With that option set, the hybrid PV queued/unfair locking code should
> still be able to make it performant enough in a paravirtualized

How is this supposed to work? If there is no kick, you have no control
over who wakes up and fairness goes out the window entirely.

You don't even begin to explain...
