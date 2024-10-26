Return-Path: <linux-arch+bounces-8620-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AF99B15CE
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 09:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DBF28311A
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 07:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BA017A589;
	Sat, 26 Oct 2024 07:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nyQhGN6h"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C064158205;
	Sat, 26 Oct 2024 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729927291; cv=none; b=naKJyey+5k9st7NzroOOrBeW2DH8a12S4aBaAs/otJhUIyxPySjqK+nf+/cW/Rh6XXjbfAGOuIeQDV9P5flm9I0CpNdXhlD1oARCWu5atQmfJuuNUa3zK61FKG6lbzx9OmP3Y+hgJsutLfyzD/9ORDYY/UiLiJl+YZJMtuUrrrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729927291; c=relaxed/simple;
	bh=qVpgoWPDVM3dm1V57iZw0tIl9KfrQhqGl+bwoAp4puE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1uKc7CVRXrhzCeOEkZSPj24EblCscOB+A8cai2qDmcIhxOwB1nN67N3r45/A3k58Y3Ps7odZnXNtIjBDM/veARkduR8TXYPguBgm8+7lX6G0vC5smAwyY1W7QNvoizKq4GHIx/AXLvEWrFtnbGHe+eBdwBrV6eh2mQW4lJxTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nyQhGN6h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LIXr6hISEoWtn/tdGHEodzPt+7XKY517Fvb738CQsSM=; b=nyQhGN6hiv1Ufc4RjT6hI4KCe7
	JxIYo0rkSycQPwIOuM0oiyisLySBLdGJep5ePw/s3wBIYvFhIArQ3/2Rut4EhseOGwV0CBYmQiHqH
	TqzdJAm54F1v+uWYk6yse2YGtnlLO1vAyV9Q3HWdZsWAtB0lXd4k4THcLzKKa5H6X2JLhSJt4tbV+
	sE8nMTRZvq6yeqFEq53Ry4l+jFdw2mNMwcHOlv0FcgFPD8EKFTcFqLKCNNLN/wIrSNtwipn4LEDGG
	aXF87GIl/UBQ6KvJtyNIDBAW6xiANZg2YfllRfiGtuZNABTbKmkcL6DpevJ08U+BJFq8UA1ZkkJrg
	vRiL6QUQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4b6s-0000000632U-3wRT;
	Sat, 26 Oct 2024 07:21:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2A2C4300777; Sat, 26 Oct 2024 09:21:19 +0200 (CEST)
Date: Sat, 26 Oct 2024 09:21:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: tglx@linutronix.de, axboe@kernel.dk, linux-kernel@vger.kernel.org,
	mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
	andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
	urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
	Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	malteskarupke@web.de
Subject: Re: [PATCH v1 11/14] futex: Implement FUTEX2_NUMA
Message-ID: <20241026072119.GH9767@noisy.programming.kicks-ass.net>
References: <20230721102237.268073801@infradead.org>
 <20230721105744.434742902@infradead.org>
 <9dc04e4c-2adc-5084-4ea1-b200d82be29f@linux.com>
 <20241025085815.GG14555@noisy.programming.kicks-ass.net>
 <887eadb6-6142-3edf-0a25-d33b2219b90d@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <887eadb6-6142-3edf-0a25-d33b2219b90d@gentwo.org>

On Fri, Oct 25, 2024 at 12:36:28PM -0700, Christoph Lameter (Ampere) wrote:
> 
> Sorry saw this after the other email.
> 
> On Fri, 25 Oct 2024, Peter Zijlstra wrote:
> 
> > > Could we follow NUMA policies like with other metadata allocations during
> > > systen call processing?
> >
> > I had a quick look at this, and since the mempolicy stuff is per vma,
> > and we don't have the vma, this is going to be terribly expensive --
> > mmap_lock and all that.
> 
> There is a memory policy for the task as a whole that is used for slab
> allocations and allocations that are not vma bound in current->mempolicy.
> Use that.

> You can get a node number following the current task mempolicy by calling
> mempolicy_slab_node() and keep using that node for the future.

I'll look into the per task thing, which I'm hoping means per-process.
We need something that is mm wide consistent.

But since futexes play in the address space, I was really rather
thinking we ought to use the vma policy.

