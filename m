Return-Path: <linux-arch+bounces-6992-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CA996ADB7
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 03:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB91B2491E
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 01:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A480F646;
	Wed,  4 Sep 2024 01:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gtEuMQcK"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EC91EBFF0;
	Wed,  4 Sep 2024 01:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725412627; cv=none; b=l0HtfmMbrLiKRqgF2Dx0Jno7JhZOb7RV73Ic3FPvEl+Fy6wiu0Fn8pejz9mqrgH4vqnSCehtyZi2KLd1rFxK8zPinoYQluhMSGg4ULM537p2m3mD7hFfNKFnjaJZNlCEm6bNAcjDXwdvFHa4bzkfregfyuEgyXYHv8Z+lxfBmFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725412627; c=relaxed/simple;
	bh=NCc+vL4Xf17rwfZm0pBFIaqDinZRRvObBmVqQAT7A6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIXZkTx3R8eEHKpacxr9Mi6rmlP21t5SvtqDxLKSjD+fbSGIfqQIMl0ONfnku50I+pJmlahrlbQxT9q5Lrodo3wKwtcxj+5w+tb5BU+TxkN+cMA62V2IpOiMACnOHuI49FExgqlpbyBGm+eITtT1r5/EmH9+PSss2zyZXa8citw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gtEuMQcK; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 3 Sep 2024 21:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725412620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQzYOHMyrq7t59Ykk0pAhpV7+DRQum6wY5MPwnLcic4=;
	b=gtEuMQcK45L8judrF5ka80VaQCtIaWgD5a4OzH+xUHPET9XKz83gNn6GCOX84C3e3mq9rO
	rFUei0M4L39R6xeJMY9/20AMzJI2jfbIssaZzgOqbDOOA3j0zhD24smbPjgXriKR3CNOYf
	wUpxTIhmvpLv9a8ZrpbX+9sIt7jDXqo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, willy@infradead.org, 
	liam.howlett@oracle.com, pasha.tatashin@soleen.com, souravpanda@google.com, 
	keescook@chromium.org, dennis@kernel.org, jhubbard@nvidia.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 5/6] alloc_tag: make page allocation tag reference
 size configurable
Message-ID: <3kfgku2oxdcnqgtsevsc6digb2zyapbvchbcarrjipyxgytv2n@7tolozzacukf>
References: <20240902044128.664075-1-surenb@google.com>
 <20240902044128.664075-6-surenb@google.com>
 <20240901220931.53d3ad335ae9ac3fe7ef3928@linux-foundation.org>
 <CAJuCfpHL04DyQn5WLz0GZ_zMYyg1b6UwKd_+8DSko843uSk7Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHL04DyQn5WLz0GZ_zMYyg1b6UwKd_+8DSko843uSk7Ww@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 03, 2024 at 06:07:28PM GMT, Suren Baghdasaryan wrote:
> On Sun, Sep 1, 2024 at 10:09 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Sun,  1 Sep 2024 21:41:27 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > > Introduce CONFIG_PGALLOC_TAG_REF_BITS to control the size of the
> > > page allocation tag references. When the size is configured to be
> > > less than a direct pointer, the tags are searched using an index
> > > stored as the tag reference.
> > >
> > > ...
> > >
> > > +config PGALLOC_TAG_REF_BITS
> > > +     int "Number of bits for page allocation tag reference (10-64)"
> > > +     range 10 64
> > > +     default "64"
> > > +     depends on MEM_ALLOC_PROFILING
> > > +     help
> > > +       Number of bits used to encode a page allocation tag reference.
> > > +
> > > +       Smaller number results in less memory overhead but limits the number of
> > > +       allocations which can be tagged (including allocations from modules).
> > > +
> >
> > In other words, "we have no idea what's best for you, you're on your
> > own".
> >
> > I pity our poor users.
> >
> > Can we at least tell them what they should look at to determine whether
> > whatever random number they chose was helpful or harmful?
> 
> At the end of my reply in
> https://lore.kernel.org/all/CAJuCfpGNYgx0GW4suHRzmxVH28RGRnFBvFC6WO+F8BD4HDqxXA@mail.gmail.com/#t
> I suggested using all unused page flags. That would simplify things
> for the user at the expense of potentially using more memory than we
> need.

Why would that use more memory, and how much?

> In practice 13 bits should be more than enough to cover all
> kernel page allocations with enough headroom for page allocations
> coming from loadable modules. I guess using 13 as the default would
> cover most cases. In the unlikely case a specific system needs more
> tags, the user can increase this value. It can also be set to 64 to
> force direct references instead of indexing for better performance.
> Would that approach be acceptable?

Any knob that has to be kept track of and adjusted is a real hassle -
e.g. lockdep has a bunch of knobs that have to be periodically tweaked,
that's used by _developers_, and they're often wrong.

