Return-Path: <linux-arch+bounces-8533-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EF79AFD64
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 10:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99807B225BA
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 08:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18A81D3628;
	Fri, 25 Oct 2024 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VfbUIXQ1"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948691D363F;
	Fri, 25 Oct 2024 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846712; cv=none; b=mhVUGdOJ8snZlDkUQqyS5wospRzs0vH92sTXrjfmoWfPb+uOTx3xLRARL6gjisP1ZnMAMNB49Cd73Gtc7vHYaYGLDm6FFaHMp0RwlAE3OuKs9ob3sASOaxGgn2zD2LtTQcZIAtMgLXxWRk37G9YZmpBDEyuRmZAKRBGLMr8maxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846712; c=relaxed/simple;
	bh=+uq/niLfEtYf/c6Xlkg9qgvnUOeY+Bos5cq4UWrEjjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTMxMQwUPX5q1e+PQTkwh2Cas4xPA7fh1ca5ohC+OLX6gdovFlyZ2uRyf6xWzafW3Xcy96SMq+jI248/FzU2eBTWmHUmBTyzu41E01bO1vmsZX4oYt8Xth4cWg/YMorQm4KS55ql+y02ySL8cjUqrXkMJdQnXqd1agLl3R16owQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VfbUIXQ1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fM1f2YxrgQ2sEgdNsgOBt8r5ECNfwt7LRPGzmtJRH9U=; b=VfbUIXQ13vdAbkhGHISFVV7/6/
	6xcxH5uE1V4/NNyqD1rm1AA0zKhmTceBIrcHgEkmBVPH+Uq7JqKGMCu4q+avhIP2fDg+5nZPI3RrQ
	bqIPoKqOW5QhP5G4AH+/6JzhQ4LLlwjr93m0Fwi9upbNunph5ZAA4YWZn53KXsAEVLTldlRUFw94n
	7EoH37g9NB4bod4Sa48l67V0LRohtd2g7U5om3/Bbw9FQIw69pbFwOnnyvrwBJ0v0qGmr7lZ+VG1F
	mkcDhSW/s7VwgOeNIdfoKtRz7ieJnk/DWKB91nu86H6biJTsNZrFTwBigDHk8WQiwWeORnyoheue5
	ueCM+3XA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4G9A-00000008sII-3S1k;
	Fri, 25 Oct 2024 08:58:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0CE20300ABE; Fri, 25 Oct 2024 10:58:16 +0200 (CEST)
Date: Fri, 25 Oct 2024 10:58:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: tglx@linutronix.de, axboe@kernel.dk, linux-kernel@vger.kernel.org,
	mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
	andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
	urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
	Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	malteskarupke@web.de
Subject: Re: [PATCH v1 11/14] futex: Implement FUTEX2_NUMA
Message-ID: <20241025085815.GG14555@noisy.programming.kicks-ass.net>
References: <20230721102237.268073801@infradead.org>
 <20230721105744.434742902@infradead.org>
 <9dc04e4c-2adc-5084-4ea1-b200d82be29f@linux.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dc04e4c-2adc-5084-4ea1-b200d82be29f@linux.com>

On Wed, Jun 12, 2024 at 10:23:00AM -0700, Christoph Lameter (Ampere) wrote:

> > When FUTEX2_NUMA is not set, the node is simply an extention of the
> > hash, such that traditional futexes are still interleaved over the
> > nodes.
> 
> Could we follow NUMA policies like with other metadata allocations during
> systen call processing? 

I had a quick look at this, and since the mempolicy stuff is per vma,
and we don't have the vma, this is going to be terribly expensive --
mmap_lock and all that.

Once lockless vma lookups land (soonish, perhaps), this could be
reconsidered. But for now there just isn't a sane way to do this.

Using memory policies is probably okay -- but still risky, since you get
the extra failure case where if you change the mempolicy between WAIT
and WAKE things will not match and sadness happens, but that *SHOULD*
hopefully not happen a lot. Mempolicies are typically fairly static.

> If there is no NUMA task policy then the futex
> should be placed on the local NUMA node.

> That way the placement of the futex can be controlled by the tasks memory
> policy. We could skip the FUTEX2_NUMA option.

That doesn't work. If we don't have storage for the node across
WAIT/WAKE, then the node must be deterministic per futex_hash().
Otherwise wake has no chance of finding the entry.

Consider our random unbound task with no policies etc. (default state)
doing FUTEX_WAIT and going to sleep while on node-0, it's sibling
thread, that happens to run on node-1 issues FUTEX_WAKE.

If they disagree on determining 'node', then they will not find match
and the wakeup doesn't happen and userspace gets really sad.


The current scheme where we determine node based on hash bits is fully
deterministic and WAIT/WAKE will agree on which node-hash to use. The
interleave is no worse than the global hash today -- OTOH it also isn't
better.

