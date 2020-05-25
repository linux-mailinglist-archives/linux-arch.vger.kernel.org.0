Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E541E0CD8
	for <lists+linux-arch@lfdr.de>; Mon, 25 May 2020 13:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390176AbgEYLZp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 May 2020 07:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390222AbgEYLZf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 May 2020 07:25:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2B9C061A0E;
        Mon, 25 May 2020 04:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ANDzJv60v//5Dwat0pXngs482cz+pE/nrDBtCUUbCnc=; b=JKmmwVcfb+OxJwCjR8JlLiHTiL
        cLHYQstgQJXP6arayZjaNXdaBg3QVX0PiBFwouZg8p/u0uzELExb3XCePi7Mfx0A5LyUAsJ/YfOL+
        J0ZB3CsTq7I0OpnERiJjMzZU3oX31GXbB7e/jW4ZDw5dVf1Y1T7ts9fHdhQ3/oKCaITYRC4J9C8mH
        m5rix7E+G6EAhOhuND9zGic+WD6MkIqXDVeq3qLrVyCvGtU/9vyD1kaHwMEdN/yBEU6L90S8DV+4S
        JDhrhlFkd+5Ar2rnZvjefAuMMtlmqTko8UhZX1OSn46ObtW4wB2PM8aU5/q6SsQ2Co0XfDamzNFyG
        Nj31Neog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdBER-00069t-Kp; Mon, 25 May 2020 11:25:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 71A54302753;
        Mon, 25 May 2020 13:25:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B21D285ECE65; Mon, 25 May 2020 13:25:21 +0200 (CEST)
Date:   Mon, 25 May 2020 13:25:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     paulmck@kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        parri.andrea@gmail.com, will@kernel.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
Subject: Re: Some -serious- BPF-related litmus tests
Message-ID: <20200525112521.GD317569@hirez.programming.kicks-ass.net>
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu>
 <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 22, 2020 at 12:38:21PM -0700, Andrii Nakryiko wrote:
> On 5/22/20 10:43 AM, Paul E. McKenney wrote:
> > On Fri, May 22, 2020 at 10:32:01AM -0400, Alan Stern wrote:

> > > Also, what use is a spinlock that is accessed in only one thread?
> > 
> > Multiple writers synchronize via the spinlock in this case.  I am
> > guessing that his larger 16-hour test contended this spinlock.
> 
> Yes, spinlock is for coordinating multiple producers. 2p1c cases (bounded
> and unbounded) rely on this already. 1p1c cases are sort of subsets (but
> very fast to verify) checking only consumer/producer interaction.

Does that spinlock imply that we can now never fix that atrocious
bpf_prog_active trainwreck ?

How does that spinlock not trigger the USED <- IN-NMI lockdep check:

  f6f48e180404 ("lockdep: Teach lockdep about "USED" <- "IN-NMI" inversions")

?

That is; how can you use a spinlock on the producer side at all?
