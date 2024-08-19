Return-Path: <linux-arch+bounces-6338-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3FF957481
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 21:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003591C23B94
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 19:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF331DC467;
	Mon, 19 Aug 2024 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S+ehbQTT"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA68188CB5;
	Mon, 19 Aug 2024 19:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096117; cv=none; b=XWOH8NvimagkOZioEqWmixHQz98i4XOzNpMy7G4SV2cgwd0tRY7taCIi/IzIomD9ezZd5u9tStr5WeXH4xEwDVk1eW01vyiKERs9i60sxxMfQ+WsxmP7wnmPidT3BTeHO37fTazXh4EOTlxt6Mdnl5WJ2fvLV0s7gRXwqNNnP7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096117; c=relaxed/simple;
	bh=Q+bTT1LIdx6rvUFMUtXwA6/VxsX+IhQMYF6gDPYwzqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hq+lseo9UN1IYJUY/3xn22eXDztKltlojXRV4JhCbqrMzbnT9u9qUGmHQ1IFVdY25ulFfYC7ToCSDjUKdaFwVz66YcUnTWV9C67jsdvujpJG1hf+TFL9LDZMkiQfr9ZXKx3aI7fTvB99Dwfi5nmoqJEEBAlSX9srdDsoRmCtr8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S+ehbQTT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GgkSbPAh5KOwEoij59vzgPrDRTBo+einBkTJg8LJEK4=; b=S+ehbQTTfQwUW7uPpk8GapUl5B
	UO27g31htpfVF8q0tyK5h/zlnt2RYj7JCfRQUYM5OiyXwoEUmOge9o1JcD96tqAWweRBzatGnfKxH
	VN/YgyIk0y2cYf29wKLGiXYWuCpUb17YjC7ggGWRTyeUu+EDzYPxRDWbzKwAhXqpv3nv5WqGX5ESc
	DbrtlZEny2y0WZ/yHSwFo7U5w3IQYBc0fgxUWBJB7RNJp8CD5J43eaMuxjscMGXg5IP1nbIn0wiOk
	W7XM61Oz0TFCyF49R96gNVaj0RkF/D9/rMcqbxN7Pn8Fhj8yJKD0g1tNyjpwkBvX+mln0qY+xZi8N
	yc+2QiZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg89N-000000076SA-4BDT;
	Mon, 19 Aug 2024 19:34:46 +0000
Date: Mon, 19 Aug 2024 20:34:45 +0100
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
Message-ID: <ZsOeVSlToyhsyDGD@casper.infradead.org>
References: <20240819151512.2363698-1-surenb@google.com>
 <20240819151512.2363698-6-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819151512.2363698-6-surenb@google.com>

On Mon, Aug 19, 2024 at 08:15:11AM -0700, Suren Baghdasaryan wrote:
> @@ -91,7 +97,7 @@
>  #endif
>  
>  #if ZONES_WIDTH + LRU_GEN_WIDTH + SECTIONS_WIDTH + NODES_WIDTH + \
> -	KASAN_TAG_WIDTH + LAST_CPUPID_SHIFT <= BITS_PER_LONG - NR_PAGEFLAGS
> +	KASAN_TAG_WIDTH + ALLOC_TAG_REF_WIDTH + LAST_CPUPID_SHIFT <= BITS_PER_LONG - NR_PAGEFLAGS
>  #define LAST_CPUPID_WIDTH LAST_CPUPID_SHIFT
>  #else
>  #define LAST_CPUPID_WIDTH 0

So if ALLOC_TAG_REF_WIDTH is big enough, it's going to force last_cpupid
into struct page.  That will misalign struct page and disable HVO --
with no warning!


