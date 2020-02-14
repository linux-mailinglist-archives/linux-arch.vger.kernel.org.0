Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A92215D507
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2020 10:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgBNJzq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Feb 2020 04:55:46 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55058 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgBNJzp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Feb 2020 04:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EIrr9N8HtFKPMFFBjN6WOJykZW1HaFopZKPkRsbYCNk=; b=lc+gtWU10tBCIZpKD430bBSFrF
        jCCEbdppu9dBVJU2kX3w3Gb6BTnhJuugaPkn1dnf04gQlJHU/0yCpL68v1qn8HOFuo5tgtuTwAZ3q
        I42ypa1pu5glbvyI6XK0XcWPeFDjqPHy5oewy3Ls3aDrmifpOYNxCxR8kMerB9w1/VqB6PB3VvohW
        yY+nMf1kvcK6pFciXjdOvJaIDZOY1jfktifgymE+/RvtwKT5JpeaXVAh+42T7tOifWdgxCWnGAb4u
        u6GGMhfT6l0p9Pkf+YEUDI9Ji1LcIVq2mEu4tJNkm91+ZqTw9A9VZaXFx4vArDqxPwPj+TnABRyon
        W4wkenRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2Xgr-0008Og-Lj; Fri, 14 Feb 2020 09:55:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6A3530066E;
        Fri, 14 Feb 2020 10:53:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A779220254E63; Fri, 14 Feb 2020 10:55:13 +0100 (CET)
Date:   Fri, 14 Feb 2020 10:55:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC 0/3] tools/memory-model: Add litmus tests for atomic APIs
Message-ID: <20200214095513.GJ14879@hirez.programming.kicks-ass.net>
References: <20200214040132.91934-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214040132.91934-1-boqun.feng@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 14, 2020 at 12:01:29PM +0800, Boqun Feng wrote:
> A recent discussion raises up the requirement for having test cases for
> atomic APIs:
> 
> 	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/
> 
> , and since we already have a way to generate a test module from a
> litmus test with klitmus[1]. It makes sense that we add more litmus
> tests for atomic APIs into memory-model.
> 
> So I begin to do this and the plan is to add the litmus tests we already
> use in atomic_t.txt, ones from Paul's litmus collection[2], and any
> other valuable litmus test we come up while adding the previous two
> kinds of tests.
> 
> This patchset finishes the first part (adding atomic_t.txt litmus
> tests). I also improve the atomic_t.txt to make it consistent with the
> litmus tests.
> 
> One thing to note is patch #2 requires a modification to herd and I just
> made a PR to Luc's repo:
> 
> 	https://github.com/herd/herdtools7/pull/28
> 
> , so if this patchset looks good to everyone and someone plans to take
> it (and I assume is Paul), please wait until that PR is settled. And
> probably we need to bump the required herd version because of it.
> 
> Comments and suggesions are welcome!

Very nice, thanks!
