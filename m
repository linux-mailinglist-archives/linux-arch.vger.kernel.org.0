Return-Path: <linux-arch+bounces-7023-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 782D396C433
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 18:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E45B1F23AD4
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 16:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6841F1E00BD;
	Wed,  4 Sep 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="koOz9m7g"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60311E0088;
	Wed,  4 Sep 2024 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467775; cv=none; b=bRalG/X+ucMtKUvV2b5+nQrBHuXeDGy0/R9EibjqII6LTo4+/rZflNOMk6/FUo1bomXXqeKPU+hqWggAtPJ3BsqZOAcPGBGuQGOyK8WmbGHUEoccs1zK1JZ8nC6x4VIwdLwTXPzf5KBYu2m4OY5QyKt3PK1pJ/byT3zcUf9OLIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467775; c=relaxed/simple;
	bh=po2G8h/VNsT+Tv0gCUS1HIxy00BOgAltSE6sYLtFebc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrUJc875VL+60ARzHvh27HL8c+oZ49elOuyzOGbLbGJ5rJUnJh7xnySYmMJ4nV0pDsxgF/KikzfoInCdJWapynBD566Xxv+ubWZYPyQvnNrSUE3kNAugqo/yS56EhrhiFHnDav7+Pco4XW1X4n45OH2AtE7Ye490Bjz8TXyPzgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=koOz9m7g; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6XPP+vV6bLvH9tkmOyPhy11V4N5CNl80JqIj9+LtqX4=; b=koOz9m7gqhq2M4xRkdsR9/GsDt
	tVV7zuMEgQbRVKtQ1MflajD6/qNDnI+XCle52x3IY5ApGwfQ7gLJtwfdqlVUcosdrQCMH1EGw0wHx
	e6GMdDauwQeOCLBtdeIugQDbc4lJfzxYMPqfmqCl1ga+MASOlzY8E72zPCf0Q/oxUNLcMvMYcBBjt
	Ftt3/Vf+HLfo//z4Y48qUnpyyPd2D3TNNvYGLk1XYv9fjcPkt5hL4ObMZOLXrZRIX5EMzAFcqEg0E
	wBS8YS7hMoSk2J/02jP9/WQcBiysE9vAVgVcXbFmxqTlZm36Fsg7y+WMqmz41GhiQHApQg5osCAU4
	qxkrZ+cA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1slsyz-0000000189I-2azW;
	Wed, 04 Sep 2024 16:35:49 +0000
Date: Wed, 4 Sep 2024 17:35:49 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de,
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org,
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de,
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com,
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, dave@stgolabs.net,
	liam.howlett@oracle.com, pasha.tatashin@soleen.com,
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org,
	yuzhao@google.com, vvvvvv@google.com, rostedt@goodmis.org,
	iamjoonsoo.kim@lge.com, rientjes@google.com, minchan@google.com,
	kaleshsingh@google.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH v2 6/6] alloc_tag: config to store page allocation tag
 refs in page flags
Message-ID: <ZtiMZWqht_8Bse-5@casper.infradead.org>
References: <20240902044128.664075-1-surenb@google.com>
 <20240902044128.664075-7-surenb@google.com>
 <20240901221636.5b0af3694510482e9d9e67df@linux-foundation.org>
 <CAJuCfpGNYgx0GW4suHRzmxVH28RGRnFBvFC6WO+F8BD4HDqxXA@mail.gmail.com>
 <47c4ef47-3948-4e46-8ea5-6af747293b18@nvidia.com>
 <ZtfDiH3lZ9ozxm0v@casper.infradead.org>
 <CAJuCfpHJ9PwNOqmFOH373gn6Uqa-orG6zP3rqk-_x=GkpUo2+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHJ9PwNOqmFOH373gn6Uqa-orG6zP3rqk-_x=GkpUo2+Q@mail.gmail.com>

On Wed, Sep 04, 2024 at 09:18:01AM -0700, Suren Baghdasaryan wrote:
> I'm not sure I understand your suggestion, Matthew. We allocate a
> folio and need to store a reference to the tag associated with the
> code that allocated that folio. We are not operating with ranges here.
> Are you suggesting to use a maple tree instead of page_ext to store
> this reference?

I'm saying that a folio has a physical address.  So you can use a physical
address as an index into a maple tree to store additional information
instead of using page_ext or trying to hammer the additional information
into struct page somewhere.

