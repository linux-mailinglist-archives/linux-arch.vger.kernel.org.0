Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6711E1323
	for <lists+linux-arch@lfdr.de>; Mon, 25 May 2020 19:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbgEYRDg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 May 2020 13:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388410AbgEYRDf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 May 2020 13:03:35 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536E2C061A0E;
        Mon, 25 May 2020 10:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XXwDcP3dcHVTH31ED3YGNDr9xfCF6QILoNLYHiAPWHo=; b=ycGpn/y3r7HAJ3xWO1uMSrRHOq
        JLE/YYhMxpqwJK3nsuVG+6K5dhNTriMLZElhL9QB8zWZoMxbANDlFN+YKMVMh8NGtg1lVaj//BsWS
        fZHpgKxDvyNSxJr/Zb1E2cpU2hfPk8zjKSk9ISh/TWl4JfvcIuYJqHQsy6Y1mj4J7UtjUmq+zpBH0
        qjKvb9j9E26PZUWA4WMGnSLhN5Y2Xlof1vMPm2VU8sSrWekAH/wYNUyRyvPXVCNV98TmS8LNbtKEg
        M3GLYpoH/LF0BFp0NMdQyn8fP9fczpHO9vSI98EpIeMMRGAOvSR3TUUMHMbkeKsw4dfWnroWSyDd8
        AqILb3BA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdGVB-0003k4-4V; Mon, 25 May 2020 17:03:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 83142300B38;
        Mon, 25 May 2020 19:02:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6CC8220BD4F39; Mon, 25 May 2020 19:02:57 +0200 (CEST)
Date:   Mon, 25 May 2020 19:02:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
Subject: Re: Some -serious- BPF-related litmus tests
Message-ID: <20200525170257.GA325280@hirez.programming.kicks-ass.net>
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu>
 <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
 <20200525112521.GD317569@hirez.programming.kicks-ass.net>
 <20200525154730.GW2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525154730.GW2869@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 25, 2020 at 08:47:30AM -0700, Paul E. McKenney wrote:
> On Mon, May 25, 2020 at 01:25:21PM +0200, Peter Zijlstra wrote:

> > That is; how can you use a spinlock on the producer side at all?
> 
> So even trylock is now forbidden in NMI handlers?  If so, why?

The litmus tests don't have trylock.

But you made me look at the actual patch:

+static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
+{
+	unsigned long cons_pos, prod_pos, new_prod_pos, flags;
+	u32 len, pg_off;
+	struct bpf_ringbuf_hdr *hdr;
+
+	if (unlikely(size > RINGBUF_MAX_RECORD_SZ))
+		return NULL;
+
+	len = round_up(size + BPF_RINGBUF_HDR_SZ, 8);
+	cons_pos = smp_load_acquire(&rb->consumer_pos);
+
+	if (in_nmi()) {
+		if (!spin_trylock_irqsave(&rb->spinlock, flags))
+			return NULL;
+	} else {
+		spin_lock_irqsave(&rb->spinlock, flags);
+	}

And that is of course utter crap. That's like saying you don't care
about your NMI data.


