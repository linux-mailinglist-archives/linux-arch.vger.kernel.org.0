Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF5761648DC
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 16:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgBSPlB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 10:41:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35848 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgBSPlA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 10:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aX1loyukyRVuKDcP3LIvT0iuhzXpU/DP1PNtnnUEHM0=; b=QtSjpKxKaJ8RrxzJNwr5sukAst
        hdvv1pyawFQqyPQ+4UKFJKRvfwIS1c4cM5l+SXEuLBWW10GHie6Nz4tLDgcG4xIUmfjZ11DPChvxT
        OItYv0mz1KMopSn9MEDRAnc1wkZFLPOZvdGyYyvfwjKkFoigTkV2xGkjwXVYIdrT1gxQoEAooQTx9
        Plf1BNJAZnFJ6csRV0OU64C1yt4Sh1HmhsWT1KAZbkeNUoQXmL5cdgjK+9D6A8+KAIIY0pDssI7IS
        +T0ZYTajLayqc5wSQ6yM9Rer/vexow7QhSXsHfrrbdQU31p4lKG+vEJJurWOleTST6K5KpKGGPYyd
        FKnsTrwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4RSj-0007Jx-RQ; Wed, 19 Feb 2020 15:40:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 87B7A30610C;
        Wed, 19 Feb 2020 16:38:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE41B201AC435; Wed, 19 Feb 2020 16:40:31 +0100 (CET)
Date:   Wed, 19 Feb 2020 16:40:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 04/22] x86/doublefault: Make memmove() notrace/NOKPROBE
Message-ID: <20200219154031.GE18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.604459293@infradead.org>
 <20200219103614.2299ff61@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219103614.2299ff61@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 10:36:14AM -0500, Steven Rostedt wrote:
> On Wed, 19 Feb 2020 15:47:28 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > --- a/arch/x86/lib/memcpy_32.c
> > +++ b/arch/x86/lib/memcpy_32.c
> > @@ -21,7 +21,7 @@ __visible void *memset(void *s, int c, s
> >  }
> >  EXPORT_SYMBOL(memset);
> >  
> > -__visible void *memmove(void *dest, const void *src, size_t n)
> > +__visible notrace void *memmove(void *dest, const void *src, size_t n)
> >  {
> >  	int d0,d1,d2,d3,d4,d5;
> >  	char *ret = dest;
> > @@ -207,3 +207,8 @@ __visible void *memmove(void *dest, cons
> >  
> >  }
> >  EXPORT_SYMBOL(memmove);
> 
> Hmm, for things like this, which is adding notrace because of a single
> instance of it (although it is fine to trace in any other instance), it
> would be nice to have a gcc helper that could call "memmove+5" which
> would skip the tracing portion.

Or just open-code the memmove() in do_double_fault() I suppose. I don't
think we care about super optimized code there. It's the bloody ESPFIX
trainwreck.
