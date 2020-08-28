Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD692255DE2
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 17:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgH1PaO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 11:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgH1PaN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 11:30:13 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9766C061264;
        Fri, 28 Aug 2020 08:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0zFcRLKj8ImMCcxbtxiQYDljXZ++TUrgC02+xq5Z1lM=; b=annfokD/Of/+tc7NAID/pa8TGk
        HhUHWxQbCb9vUFIi0nEEwEz3Zpsg1jhgSOIdw9b+SQ86JNA3dVRgLPJ2YXxwh6rvR+ZBQROXsvoSj
        J5X/+AAGPuKQAI+kJcdQbGXdXzvb2+aUbm7Z+vZNs0xlYXIbGp70W00SeGZ0XtyrwzGFOCwK+d+Sf
        t0NhCiOIYSU/zxqTae5rbrVt7hU/tIKpdJz0/1wPlaGFz4/ph21pUMfNV5/I9ps699SMPUMC32z/k
        wdLy7d/eQR8kNV4Cyk1NQv7VfkFmOvqcfbuN3DdNdjsDIyFZobBspz8cCfqKzlmDB35gRg7lFvVQa
        xVR3Sa1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBgK5-0002ff-2A; Fri, 28 Aug 2020 15:29:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C83D3003E5;
        Fri, 28 Aug 2020 17:29:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 659E02C5FEF2B; Fri, 28 Aug 2020 17:29:46 +0200 (CEST)
Date:   Fri, 28 Aug 2020 17:29:46 +0200
From:   peterz@infradead.org
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [RFC][PATCH 6/7] freelist: Lock less freelist
Message-ID: <20200828152946.GG1362448@hirez.programming.kicks-ass.net>
References: <20200827161237.889877377@infradead.org>
 <20200827161754.535381269@infradead.org>
 <20200828144650.GF28468@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828144650.GF28468@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 28, 2020 at 04:46:52PM +0200, Oleg Nesterov wrote:
> On 08/27, Peter Zijlstra wrote:
> >
> >  1 file changed, 129 insertions(+)
> 
> 129 lines! And I spent more than 2 hours trying to understand these
> 129 lines ;) looks correct...

Yes, even though it already has a bunch of comments, I do feel we can
maybe improve on that a little.

For now I went for a 1:1 transliteration of the blog post though.

> > +			/*
> > +			 * Yay, got the node. This means it was on the list,
> > +			 * which means should-be-on-freelist must be false no
> > +			 * matter the refcount (because nobody else knows it's
> > +			 * been taken off yet, it can't have been put back on).
> > +			 */
> > +			WARN_ON_ONCE(atomic_read(&head->refs) & REFS_ON_FREELIST);
> > +
> > +			/*
> > +			 * Decrease refcount twice, once for our ref, and once
> > +			 * for the list's ref.
> > +			 */
> > +			atomic_fetch_add(-2, &head->refs);
> 
> Do we the barriers implied by _fetch_? Why can't atomic_sub(2, refs) work?

I think we can, the original has std::memory_order_relaxed here. So I
should've used atomic_fetch_add_relaxed() but since we don't use the
return value, atomic_sub() would work just fine too.

> > +		/*
> > +		 * OK, the head must have changed on us, but we still need to decrement
> > +		 * the refcount we increased.
> > +		 */
> > +		refs = atomic_fetch_add(-1, &prev->refs);
> 
> Cosmetic, but why not atomic_fetch_dec() ?

The original had that, I didn't want to risk more bugs by 'improving'
things. But yes, that can definitely become dec().
