Return-Path: <linux-arch+bounces-8641-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A4E9B2BA5
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 10:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1834D28240D
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 09:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB841922DE;
	Mon, 28 Oct 2024 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ipnchwCv"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7263B155744;
	Mon, 28 Oct 2024 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108321; cv=none; b=X6dVchwxhhIyyiCpuYI0j/oquiA+HJ6sXg5K6Jjl+nDjnPQPKJURS0XsjdrKGhZ5VF6APrMGzbPNj236WL/TWKLuZSORo0AXE1KjM1ZhJ52B/IDocGzBX+FE/Vwzkl1pzOavIl07yayTc9LYfUKMNMZs7k3m+etPKVjxNTh2CXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108321; c=relaxed/simple;
	bh=TTzDaDISSTXKhoI13t5qVj7ZDIOkYQKbwOtUI03eJpw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjCN1aHR/AmNQCCZ+ZUvHzG+/ljaOhquuWOD4sy/xsvajVAOBjH5sgZ5o/peHnDQdnrcIvme08+cwueBwChPBBdkN1vvKIar1ckN5qoQvacAUgrrEAOHoSiNLRL4UwKssn0hcv2fVL3XuJrAkO2QYWUUxTPG6Bu+iQ+73TzaFGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ipnchwCv; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YsVgrVYidjdLoY8ut0hhSwdO11cYdvJtoCYBOkZVwdg=; b=ipnchwCv5ZZNCwBnChIKjpeyvx
	vBsJv+AtNzZD8IfYJtizz1JKY1PKdJNtwFD2On5M3DNe7h2Kb6LRGzJ6AY2LnAoAiVKHUmQA+gbQv
	Ka53ZcHVJOM852ZIv4ejGsgeDDSCwY/fbiY5A/6CSU1BALECS0v7aWTmoNlyE0+PAZI7HNa+KFYMd
	7LsjSD8atHwTeflrl7SeQgPtW6mKEQNHdvzpM4hqebiloT7D0YGMwphCQsufdwMxgJZoK2CIg+j2y
	wOckw6B6Ig5Vr1XL2Mu/k4v2+0NRwu0I07Bckb+WS7IJn7Q34eSpbUTnTG/IeOKODrVN9NJq7lJ5o
	dRVGTlHA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5MCj-00000009cRx-2S76;
	Mon, 28 Oct 2024 09:38:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3EB4930083E; Mon, 28 Oct 2024 10:38:29 +0100 (CET)
Date: Mon, 28 Oct 2024 10:38:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@redhat.com,
	dvhart@infradead.org, andrealmeid@igalia.com,
	Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
	hch@infradead.org, lstoakes@gmail.com,
	Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	malteskarupke@web.de, cl@linux.com, llong@redhat.com
Subject: Re: [PATCH 2/6] futex: Implement FUTEX2_NUMA
Message-ID: <20241028093829.GK9767@noisy.programming.kicks-ass.net>
References: <20241025090347.244183920@infradead.org>
 <20241025093944.485691531@infradead.org>
 <i4ljhfndmqrdg5zevd4gf2chmzesfieflxvfj2io2qfhfj4vb7@nicvpjmcdtyu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i4ljhfndmqrdg5zevd4gf2chmzesfieflxvfj2io2qfhfj4vb7@nicvpjmcdtyu>

On Fri, Oct 25, 2024 at 11:30:26AM -0700, Davidlohr Bueso wrote:
> On Fri, 25 Oct 2024, Peter Zijlstra wrote:\n
> 
> > static int __init futex_init(void)
> > {
> > -	unsigned int futex_shift;
> > -	unsigned long i;
> > +	unsigned int order, n;
> > +	unsigned long size, i;
> > 
> > #ifdef CONFIG_BASE_SMALL
> > 	futex_hashsize = 16;
> > #else
> > -	futex_hashsize = roundup_pow_of_two(256 * num_possible_cpus());
> > +	futex_hashsize = 256 * num_possible_cpus();
> > +	futex_hashsize /= num_possible_nodes();
> > +	futex_hashsize = roundup_pow_of_two(futex_hashsize);
> > #endif
> > +	futex_hashshift = ilog2(futex_hashsize);
> > +	size = sizeof(struct futex_hash_bucket) * futex_hashsize;
> > +	order = get_order(size);
> > +
> > +	for_each_node(n) {
> 
> Probably want to skip nodes that don't have CPUs, those will never
> have the remote for .node value.

What if the CPU-less node is placed equidistant between two (or more)
regular nodes and it is the best location for a futex that is spanning
those nodes?

That is to say, just because it doesn't have CPUs, doesn't mean it is
never the right node.

Hmm?

