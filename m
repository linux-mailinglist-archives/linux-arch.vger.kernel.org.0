Return-Path: <linux-arch+bounces-6341-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9AF9575DA
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 22:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3804F283FE0
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 20:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BB41598EC;
	Mon, 19 Aug 2024 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YJUfES/u"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B576158A36;
	Mon, 19 Aug 2024 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724100060; cv=none; b=Ft6kIjtFY981GNQLnnNuB1/GxMElH1ZBQ6IjsUzz+ojKioNUorzQl/ptVe1GcAHRKKNl53HOyR08F82rtfYsYyIUQJHZvv4fwtWBI6ZpRRwN/jHCQ3GJCHoE04Rcjny68qSLZUQ+CWsJBDnhKihdq85hky9QJaJKWBdlvhdbLgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724100060; c=relaxed/simple;
	bh=J9DYvjOTNMlPj8lUuRSwuumR69rHflgqAun/m3FrUfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYQyoSX415ItF4taKdh5He9GqBb4wAcJRC7lUoITG/eecz0nNdgUY7HqfQgB0uc5VLucOfGiOk+OIOWHIw7a0k/QRhNjd+KobVCkIyIyLT9xDMtjwGdF/ovgbKyfX7aq0juTH1z1w+dHq2o5+sbNPq54Mu1RYpcbp+i2kkZFt5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YJUfES/u; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=LR6gvp9HK2PILfTwueGWU5zqNdGWBxGU2nJl4V1AU5w=; b=YJUfES/uXnOPWqvoLRT4IA16LY
	E2sDhQrmGnA+ej3QJ7G8AwZLUKpmn7Oy8XmfWGc2RAO20izOrDIe8PTnnEO1+q5XLiF7Hjh7IvFRk
	VQR6yYcvzSVent7qK2wDkUPn7M7LRUSn0rDUx6xTM9EP8BFooJaXqfPT/QmrLF894OKm+uvYasrj4
	OAbRHEX/VcOmDRuW9JBmjXEMPsueiTvBwQddu1bJYNOvAQR/RudrviNHypci/dXjY/PS9OFvdspDN
	EuYKGy4xtRANSUtr0T2kxuhFzRz0fS47Fp9+50O6Y4ilw8rWchVLgMJSn7XPCiGq0NCNcfBaf/Clv
	q2rhdYkA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg9B4-000000079lt-26nJ;
	Mon, 19 Aug 2024 20:40:34 +0000
Date: Mon, 19 Aug 2024 21:40:34 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net,
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org,
	paulmck@kernel.org, thuth@redhat.com, tglx@linutronix.de,
	bp@alien8.de, xiongwei.song@windriver.com, ardb@kernel.org,
	david@redhat.com, vbabka@suse.cz, mhocko@suse.com,
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net,
	liam.howlett@oracle.com, pasha.tatashin@soleen.com,
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org,
	jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com,
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 5/5] alloc_tag: config to store page allocation tag refs
 in page flags
Message-ID: <ZsOtwhWC_JpgWe_J@casper.infradead.org>
References: <20240819151512.2363698-1-surenb@google.com>
 <20240819151512.2363698-6-surenb@google.com>
 <ZsOeVSlToyhsyDGD@casper.infradead.org>
 <CAJuCfpH4yFw6RNKVDK0hqXQQhAhMsyGNp5A50E+c2PZd+_vOgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpH4yFw6RNKVDK0hqXQQhAhMsyGNp5A50E+c2PZd+_vOgw@mail.gmail.com>

On Mon, Aug 19, 2024 at 01:39:16PM -0700, Suren Baghdasaryan wrote:
> On Mon, Aug 19, 2024 at 12:34 PM Matthew Wilcox <willy@infradead.org> wrote:
> > So if ALLOC_TAG_REF_WIDTH is big enough, it's going to force last_cpupid
> > into struct page.
> 
> Thanks for taking a look!
> Yes, but how is this field different from say KASAN_TAG_WIDTH which
> can also force last_cpupid out of page flags?

Because KASAN isn't for production use?

> >  That will misalign struct page and disable HVO -- with no warning!
> 
> mminit_verify_pageflags_layout already has a mminit_dprintk() to
> indicate this condition. Is that not enough?

Fair.

