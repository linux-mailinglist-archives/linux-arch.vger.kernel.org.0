Return-Path: <linux-arch+bounces-4851-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A602905A1A
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 19:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DB6285BBF
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 17:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28731802DF;
	Wed, 12 Jun 2024 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kUDtZivw"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101323770D;
	Wed, 12 Jun 2024 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718214289; cv=none; b=ICd8RBWLVjjIAxEScxGMeXOZQZlVzNuL1AMOYomKtXmOvaDCfIiiATQSv9TDUOqpveNfxd6UUjRk87xc0cga0UPllm6s3AvjCjmPzxPJqlxOg90ThNb/Gucs86GadK1JcHhoprKCS9sTZkaDN5PZ05dDc6zg5gSS33AjFQ9Cv0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718214289; c=relaxed/simple;
	bh=s4Zazba734GMhVxkazRxi8YEUVdskrv4pbtTckLjIEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r81boegmJ4j6bGah2IF0BENC9VoEP3jhE/l6RNqGDoffXEmK/y3bGe3mpnH3qOQjSJyhqZ2ptiq9IWvhj6LUx2H2Yi7Av9pUBgC+V8ENZz8NzRfWMG7GHBVshhzGrkHIEI/Ylh9pmSYHEOsFR7itf0JiqW7UkMvR4kyb4v55NQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kUDtZivw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UGHS7yRmHTQpcdPpllQog/ALtBWxo3EIKdMQ5erIzOU=; b=kUDtZivwJ6fU4JobBOJXCgIcfp
	MxDdCt88t41S+TmjpkWbEhQVg9IdxQmPPp11JQShMs85zMW41FR0ejfKS6suWd2ooR7vIWH/qYtmA
	TSkiPHuHMnHLw+KV+75FHOkZo5bWBzMVPlnew4TO0EDgyoyivAzY/jwUS7H7tn93nLH1NbJlGBn2I
	qSk+IDZo552fFzVORQWxiskdqfa7ImeU5H4UcU5LD6ulwZg6m2AarIKQhrn+jC7gkIRR2IiNyUCcE
	evrkXlpXn4mC1i9zqGUpZjkMAHokFreTUKcprwvm3QHv/IWJ7v2wvaxBqNpVqZVD8ObXqSUve4c4B
	FuHtjFXw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHS1R-0000000EvpK-2Nhu;
	Wed, 12 Jun 2024 17:44:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E5781300592; Wed, 12 Jun 2024 19:44:32 +0200 (CEST)
Date: Wed, 12 Jun 2024 19:44:32 +0200
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
Message-ID: <20240612174432.GK8774@noisy.programming.kicks-ass.net>
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
> On Fri, 21 Jul 2023, Peter Zijlstra wrote:
> 
> > Extend the futex2 interface to be numa aware.
> 
> Sorry to be chiming in that late but it seems that this is useful to
> mitigate NUMA issues also for our platform.

I read this like: I tested it and it works for me. Is that a correct
reading of your statement?

If so, I'll look at bumping this on the priority list and I'll look at
the placement suggestion you had when I respin the patches.

Thanks!

