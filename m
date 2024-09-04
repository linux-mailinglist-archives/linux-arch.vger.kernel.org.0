Return-Path: <linux-arch+bounces-7020-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A154196C407
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 18:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E4B1F26E94
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 16:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110781E0B79;
	Wed,  4 Sep 2024 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZKalQCs2"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4501DB55E
	for <linux-arch@vger.kernel.org>; Wed,  4 Sep 2024 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466895; cv=none; b=SXKAmI5BM7peg0m33R1lsDlYEk5re2vS8o9zJrdKOIczWr5cwQk3kp523hSYLSH0mOuPY5lHuLyh3RRidyjSwwUKFu41oCUqaXNTaOVH0c04iIOjmZY8hbdlMxDBZH0pZRghO08XJpBrZZJTjKBttn4xB6e31tIHQ3PNtEItVvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466895; c=relaxed/simple;
	bh=markrjA3z1G5idjSO3AOLF7Kyzv0iKrWHhN4KqLaT0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehCiHsvKhPfU4fBLWPrClQ9ZRFn726NYq/4Q7ijC7JiPiZSGGxrkJ1ZYwmwvcA39RlNnQzECGgCQrtlEfg2zH9eIXfj6hHN1mRBRoZqky8rwgyS+eZxnMLLx0XsayfLwYA9Tbc92HVxlPOMpj+PX2ddRzmrsCJ2uTiUce/KmM0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZKalQCs2; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 4 Sep 2024 12:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725466890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+JqXoB8jLlVYHGDq0AwOaLEhKJQ+zif2aGJ3V0UPjuU=;
	b=ZKalQCs2XotYejr6ODhzpK5d5qiOQWI8fG2cLDtbYmw4IONIaNYn93REWMvnH0cYeVpIuJ
	z8GxAv+Z11/wJApNg/ocfoL/qBl2DwkEyz+sBVXzPUS2l/HBzmGieWMNONTsg3YM6qeJ/O
	jzTf6aWAGuxeII5QaZa9L3t3Ov8Z6jc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, 
	John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	liam.howlett@oracle.com, pasha.tatashin@soleen.com, souravpanda@google.com, 
	keescook@chromium.org, dennis@kernel.org, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	kernel-team@android.com
Subject: Re: [PATCH v2 6/6] alloc_tag: config to store page allocation tag
 refs in page flags
Message-ID: <slcih7wenfxtffnamxehvipcwnrq4hgrfu4btssezykr6ow3ww@af5jlsc3t52e>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHJ9PwNOqmFOH373gn6Uqa-orG6zP3rqk-_x=GkpUo2+Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 04, 2024 at 09:18:01AM GMT, Suren Baghdasaryan wrote:
> On Tue, Sep 3, 2024 at 7:19 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Sep 03, 2024 at 06:25:52PM -0700, John Hubbard wrote:
> > > The more I read this story, the clearer it becomes that this should be
> > > entirely done by the build system: set it, or don't set it, automatically.
> > >
> > > And if you can make it not even a kconfig item at all, that's probably even
> > > better.
> > >
> > > And if there is no way to set it automatically, then that probably means
> > > that the feature is still too raw to unleash upon the world.
> >
> > I'd suggest that this implementation is just too whack.
> >
> > What if you use a maple tree for this?  For each allocation range, you
> > can store a pointer to a tag instead of storing an index in each folio.
> 
> I'm not sure I understand your suggestion, Matthew. We allocate a
> folio and need to store a reference to the tag associated with the
> code that allocated that folio. We are not operating with ranges here.
> Are you suggesting to use a maple tree instead of page_ext to store
> this reference?

yeah, I don't think the maple tree idea makes any sense either

we already have a way of going from index -> alloc tag, this is just
about how we store the index

