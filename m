Return-Path: <linux-arch+bounces-8498-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE0C9AD527
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 21:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26972861E8
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 19:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CEF1D1F51;
	Wed, 23 Oct 2024 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h/yD9D/8"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E97D1CDFD1;
	Wed, 23 Oct 2024 19:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729712757; cv=none; b=EZTj+A03G53R62+xgC64DoEd7MfJvNLf4Rgd5KpgaOvVmeyc1JPonEU4EXF9GNYr6IlQ+8+g9/PeLGdG8nnwjdLWvVeJb32xXsHKwLJMEsJIiFvs7pwmgOtskOSRaG1QfWZE6Ragpraix1ZUVwM1gFaBQW1Xp8gSn6Yv6x4XhDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729712757; c=relaxed/simple;
	bh=Av8oDA592bMyPw+8/tqp5bVgIPkVhDoLsgzw4ibiyfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/tXMH/UsBNea0ctG66ANuFm4xrX6utEXEU65DzDpoppAIfb1k2K14Se0VWeHGk9/z3JZ2Wx3le+BJvTrmytstq2S4l9w0t9X/mdhJSzEgwiV9A2niPmVOihfKt9km5tIFVMSvfz92Rr2btPycSf+17PUQjLHA3PJSrPz6djBJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h/yD9D/8; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pnofjtWFRW1a3Ex4iamW6Sy5pqigg3kUWm7+B1kI9+Q=; b=h/yD9D/860kV5yyshWWgMIMGPr
	5Y/QxMgy8Qx7w2cTYX6kRQhdlB3KqN+MY4cNRvt94WqfJu2NixJ9fxTo1FARn0AAqDH8Vuz6Y9hDy
	yCCJe/z8FtwFDDV/NMRQtAnkEH9L7b9ZtlOem2aYepMOLYuKN1/PuTkAA4FZsxMpz0mCfVgCAuGbS
	+/bRgSqshAfX0KzU0kSNf8eN2HeVbC4k3Oic4VlOhr/Lol8SLWQ/Omq7d2xnGf5jC9cbiwoOSffm1
	MN/J8bsc2HGzEjpkaTJRCjv0ggYmOAfUtDFpWrw7IXY8d755vXZRD4V+VugCbNw/JRk7466sntgBS
	o71bzRkw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3hIe-00000008XNO-3Dyc;
	Wed, 23 Oct 2024 19:45:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D8E61301171; Wed, 23 Oct 2024 21:45:43 +0200 (CEST)
Date: Wed, 23 Oct 2024 21:45:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] Avoid memory barrier in read_seqcount() through load
 acquire
Message-ID: <20241023194543.GD11151@noisy.programming.kicks-ass.net>
References: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org>
 <20240917071246.GA27290@willie-the-truck>
 <4b546151-d5e1-22a3-a6d5-167a82c5724d@gentwo.org>
 <CAHk-=wgw3UErQuBuUOOfjzejGek6Cao1sSW4AosR9WPZ1dfyZg@mail.gmail.com>
 <CAHk-=wjdOX0t45a7aHerVPv_WBM3AmMi3sEp8xb19jpLFnk0dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjdOX0t45a7aHerVPv_WBM3AmMi3sEp8xb19jpLFnk0dA@mail.gmail.com>

On Mon, Sep 23, 2024 at 09:28:31AM -0700, Linus Torvalds wrote:
> On Wed, 18 Sept 2024 at 08:22, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, 18 Sept 2024 at 13:15, Christoph Lameter (Ampere) <cl@gentwo.org> wrote:
> > >
> > > Other arches do not have acquire / release and will create additional
> > > barriers in the fallback implementation of smp_load_acquire. So it needs
> > > to be an arch config option.
> >
> > Actually, I looked at a few cases, and it doesn't really seem to be true.
> 
> Bah. I ended up just committing the minimal version of this all. I
> gave Christoph credit for the commit, because I stole his commit
> message, and he did most of the work, I just ended up going "simplify,
> simplify, simplify".
> 
> I doubt anybody will notice, and smp_load_acquire() is the future. Any
> architecture that does badly on it just doesn't matter (and, as
> mentioned, I don't think they even exist - "smp_rmb()" is generally at
> least as expensive).

Do we want to do the complementing patch and make write_seqcount_end()
use smp_store_release() ?

I think at least ARM (the 32bit thing) has wmb but uses mb for
store_release. But I also think I don't really care about that.

