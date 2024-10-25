Return-Path: <linux-arch+bounces-8531-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFD69AFB50
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 09:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F098B1C21581
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 07:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798FC1B393B;
	Fri, 25 Oct 2024 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V0NHcwcs"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36C31B2185;
	Fri, 25 Oct 2024 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842181; cv=none; b=DUT7kpGKmFu8Eydc9V1oK1lAHvdP3o2U51Jtt59WtYXEVbGPEj7At8Nyh5sAjsZqRIVPnq3IN6OBdQIc6wG8S1XiXPbE67/neM+KKVcp4Az1xn+TsP76qC3rlTX7Uxv2stsz/B+QgsqMbQQ4xpAp6eAW9ZTPVxjqHLs/mDkxIQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842181; c=relaxed/simple;
	bh=VRcbP3OAbFoSwSqNqfosv/0smAfY8fDeq48XQuD940Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3Yh/7Nisjbj7Lf68GoyMvvFdFCMnRAfRc0lA0aEe8qp6LPffwpCxvf1IwSnzXM+nXvHjiwmJpuvfiCdwknrHg8p4JRsNAQZdJqJ9x5siyDnGeg1aypmY9nOpVtC5zz3VyURw4xkkHi+VWqhfWHXQU+LiFRJ5Ozf41N/tVvD6PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V0NHcwcs; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Oyz3AH73jsvhVuXMvukfXv65WS9wp+HqrXkM26N9vJA=; b=V0NHcwcsuxdvKzX6wLX6w2QjPl
	hwQ9HeHnsPa5m5iToxLcJVUcjwqRu15DO9EAUV0QQzHoW3FWDTkDPB146XOSRbDixULZZdd+sQoB/
	h759sk759Vnxe5iEa6rXDG93SYvAR49+cFxWSPGN+ca9AneGxFt/XCATxAuW/SaGe9WgUvJm0qvTk
	aMF0lxHntpStWCNittH0792WL+K3Ce5zCswq7V2gj2gEyAGSPIKR1sTiU66iCQWBs+4T8fXkJnG1a
	oztq3Xiu24GdhNPG+DtUtRRQvh3z/QNC3n9ZAsVeO6XEVqTjzAFvaraslBH0Il5ZSY30n5Q4UjhSx
	GFrYWFHg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Ey4-00000008r2u-41M1;
	Fri, 25 Oct 2024 07:42:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 96CFE30083E; Fri, 25 Oct 2024 09:42:44 +0200 (CEST)
Date: Fri, 25 Oct 2024 09:42:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] Avoid memory barrier in read_seqcount() through load
 acquire
Message-ID: <20241025074244.GB14555@noisy.programming.kicks-ass.net>
References: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org>
 <20240917071246.GA27290@willie-the-truck>
 <4b546151-d5e1-22a3-a6d5-167a82c5724d@gentwo.org>
 <CAHk-=wgw3UErQuBuUOOfjzejGek6Cao1sSW4AosR9WPZ1dfyZg@mail.gmail.com>
 <CAHk-=wjdOX0t45a7aHerVPv_WBM3AmMi3sEp8xb19jpLFnk0dA@mail.gmail.com>
 <20241023194543.GD11151@noisy.programming.kicks-ass.net>
 <e9fd5ba0-bd84-76a8-a96e-1378c66d0774@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9fd5ba0-bd84-76a8-a96e-1378c66d0774@gentwo.org>

On Wed, Oct 23, 2024 at 04:42:36PM -0700, Christoph Lameter (Ampere) wrote:
> On Wed, 23 Oct 2024, Peter Zijlstra wrote:
> 
> > > I doubt anybody will notice, and smp_load_acquire() is the future. Any
> > > architecture that does badly on it just doesn't matter (and, as
> > > mentioned, I don't think they even exist - "smp_rmb()" is generally at
> > > least as expensive).
> >
> > Do we want to do the complementing patch and make write_seqcount_end()
> > use smp_store_release() ?
> >
> > I think at least ARM (the 32bit thing) has wmb but uses mb for
> > store_release. But I also think I don't really care about that.
> 
> The proper instruction would be something like
> 
> atomic_inc_release(&seqcount)

It would not be, making the increment itself atomic would make the whole
thing far more expensive.

