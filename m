Return-Path: <linux-arch+bounces-8650-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 557A59B32E4
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 15:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9E75B24A51
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 14:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8AF1DE3AD;
	Mon, 28 Oct 2024 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="letOBCsL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9148D1DE3A3;
	Mon, 28 Oct 2024 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124643; cv=none; b=I3zCzHsvlw8E7QxygWUhQj0Vkoh2X44utEQK+kinp1cflidfopFdcoDaZ6DQhepkGpt4wqyzyo7OM2uA4ZIryJibeEjJhZSaDJ6l+q6ltqExwBKmiytaDlHtq0yLpzJn0E8rXZ9Gnhy/OvlJ6K+tGRlzGoQi0ZSmBwUtFunpVn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124643; c=relaxed/simple;
	bh=UOyycE1D7kC/7syiC7gLva+nUvimfyrJhVci/Klvmwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOY2I8lqwMRmpxa1yRsPMhHI7q4rp0QoXmJuVzhu8jdPB4yJZDG7iDb6LgWbkj/FVNlrzM6rMnqHx3zGQRlZStbl5b3loh6C3cr3WvGypODEHLBsbVNi/MhyjfmBzEL4dk9K1hIDo4spDfyX/tr75ovaVcoclkShskcTxpHlux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=letOBCsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67F6C4CEC3;
	Mon, 28 Oct 2024 14:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730124643;
	bh=UOyycE1D7kC/7syiC7gLva+nUvimfyrJhVci/Klvmwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=letOBCsLztxv7UCD3XJKGDi7cTdMqeJTGtS+t30wGG7u2sNrOjFZIozVUe3TPE6nh
	 ADe77XWlYc/slaPb1vm9mNmMbrF+rcEgTE0uOLVlu+7chTisdoWdZXDY72nJXWrdlQ
	 KfLaFHJhrUO5VDtj85QZR85bXz+NNwqAIDf76mVTdnPylLZf0z8c6DCQi9/7A+6KX+
	 uyau4g2alEkwFItib62BUjyvzk8hNt5DL05ZiDRnlX/+8cNoVbzKA7oCLHU5TLjQ00
	 VBd2TOQrwFySRiWneU5P/pw4VG6DkVE2R9A2Be4y1AysQS4rgdCbwxU7uZYaOgMrIm
	 +gVR9X0EBVplA==
Date: Mon, 28 Oct 2024 14:10:37 +0000
From: Will Deacon <will@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] Avoid memory barrier in read_seqcount() through load
 acquire
Message-ID: <20241028141036.GA2008@willie-the-truck>
References: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org>
 <20240917071246.GA27290@willie-the-truck>
 <4b546151-d5e1-22a3-a6d5-167a82c5724d@gentwo.org>
 <CAHk-=wgw3UErQuBuUOOfjzejGek6Cao1sSW4AosR9WPZ1dfyZg@mail.gmail.com>
 <CAHk-=wjdOX0t45a7aHerVPv_WBM3AmMi3sEp8xb19jpLFnk0dA@mail.gmail.com>
 <20241023194543.GD11151@noisy.programming.kicks-ass.net>
 <CAHk-=wi=Ji6-xi32167i3M1JL_YyRj6tgUAJS=YQ94GKzMBvkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi=Ji6-xi32167i3M1JL_YyRj6tgUAJS=YQ94GKzMBvkg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Oct 23, 2024 at 01:34:16PM -0700, Linus Torvalds wrote:
> On Wed, 23 Oct 2024 at 12:45, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Do we want to do the complementing patch and make write_seqcount_end()
> > use smp_store_release() ?
> >
> > I think at least ARM (the 32bit thing) has wmb but uses mb for
> > store_release. But I also think I don't really care about that.
> 
> So unlike the "acquire vs rmb", there are architectures where "wmb" is
> noticeably cheaper than a "store release".
> 
> Just as an example, on alpha, a "store release" is a full memory
> barrier followed by the store, because it needs to serialize previous
> loads too. But wmp_wmb() is lightweight.
> 
> Typically in traditional (pre acquire/release) architectures "wmb"
> only ordered the CPU write queues, so "wmb" has always been cheap
> pretty much everywhere.
> 
> And I *suspect* that alpha isn't the outlier in having a much cheaper
> wmb than store-release.
> 
> But yeah, it's kind of ugly how we now have three completely different
> orderings for seqcounts:
> 
>  - the initial load is done with the smp_read_acquire
> 
>  - the final load (the "retry") is done with a smp_rmb (because an
> acquire orders _subsequent_ loads, not the ones inside the lock: we'd
> actually want a "smp_load_release()", but such a thing doesn't exist)
> 
>  - the writer side uses smp_wmb
> 
> (and arguably there's a fourth pattern: the latching cases uses double
> smp_wmb, because it orders the sequence count wrt both preceding and
> subsequent stores)
> 
> Anyway, obviously on x86 (and s390) none of this matters.
> 
> On arm64, I _suspect_ they are mostly the same, but it's going to be
> very microarchitecture-dependent. Neither should be expensive, but wmb
> really is a fundamentally lightweight operation.

I agree here. An STLR additionally orders PO-prior loads on arm64, so
I'd stick with the wmb().

Will

