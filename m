Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 645F715310E
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 13:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgBEMtM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 07:49:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgBEMtM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 07:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XXGcIXrjaDU4gOfl8pG8t1zJu2UJWnPLKCFWD7lOQTk=; b=moUU6cLQmKfy0121zb6OO8d/p4
        emVP6yD8LxypIcwJKdBvxtz8q3wgcMLhmWQzaSVeekXl6jSr22Gfcw7g1H8NTkE1ARQR9YKVamj6X
        opwUS7DDY6CdPV+NE6tMjkss5vEV2hc4R8R+WMGge97jEjvlU/FyKn8UQBR4xlUfdzvQpzD+BMHQf
        hT3w1g/J5fhINNIAX2cO66NDWlN6CgzZaTbGnuqltzqVIVMjg7ZBHa/FI4ieWxGz4OEVvf7MgdyrI
        kVUPn1eD64Nnr4dv5Drl4wb3FAX7regkCWJuOKWKBGTDcEStlWVxD9LgtxCZBrAi72wL7pF6bJrmr
        ZYCNCdAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izK7C-00027O-4s; Wed, 05 Feb 2020 12:49:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5F9513011C6;
        Wed,  5 Feb 2020 13:47:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D9032B77760E; Wed,  5 Feb 2020 13:49:08 +0100 (CET)
Date:   Wed, 5 Feb 2020 13:49:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Octavian Purdila <tavi.purdila@gmail.com>
Cc:     Hajime Tazaki <thehajime@gmail.com>,
        linux-um <linux-um@lists.infradead.org>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC v3 01/26] asm-generic: atomic64: allow using generic
 atomic64 on 64bit platforms
Message-ID: <20200205124908.GL14879@hirez.programming.kicks-ass.net>
References: <cover.1580882335.git.thehajime@gmail.com>
 <39e1313ff3cf3eab6ceb5ae322fcd3e5d4432167.1580882335.git.thehajime@gmail.com>
 <20200205093454.GG14879@hirez.programming.kicks-ass.net>
 <CAMoF9u3Jhqyvp3SpA3mUqPhS4zDuXP9GCUu_XsYx2etE0KGkcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMoF9u3Jhqyvp3SpA3mUqPhS4zDuXP9GCUu_XsYx2etE0KGkcQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 05, 2020 at 02:24:38PM +0200, Octavian Purdila wrote:
> I was not aware that not allowing GENERIC_ATOMIC64 was intentional. I

It might not have been, but presented with this patch, I feel like it
should've been :-)

> understand your point that a 64 bit architecture that can't handle 64
> bit atomic operation is broken.

(sadly they actually exist, I shall name no names)

> One way to deal with this in LKL would be to use GCC atomic builtins
> or if that doesn't work expose them as host operations. This would
> keep LKL as a meta-arch that can run on multiple physical
> architectures. I'll give it a try.

What is this LKL you speak of and how does it do the 32bit atomics?

One thing to keep in mind is that the C11 atomics (_Atomic) don't
trivially map to the LKMM -- although I keep forgetting the exact
details, there is a paper on it somewhere.  Also, once you're limited to
a specific arch the issue also becomes much easier than C11 vs LKMM in
general.
