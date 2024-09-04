Return-Path: <linux-arch+bounces-6997-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AD996AEB5
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 04:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5638D1C2328A
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 02:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849553EA9A;
	Wed,  4 Sep 2024 02:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wp8WEIrm"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF362576F;
	Wed,  4 Sep 2024 02:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725417691; cv=none; b=rY3/G0krrpVXF+YiK47nF5TgEUcvBlkBJNeBzVcgKNy5UcFhr5LEY6XwkxjFtgXOQ70JvF4w6Zdh05GnokqGdPcHbbjIhkg+KTV5rt5xlEGmCM++3ojvxwjEUYZwpcSNhO3rtQaQ35r8sj8mtMnn+xRBG4fZMzLoM25BiPPMX6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725417691; c=relaxed/simple;
	bh=czaSQk+ILp2AWrhPzq7PzAoHNxKMEho37QKX6cBTNhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0dknPNU/iMEffqsMb/X6lCyOa3/rGoFBuEqMzFq5zITloFUeLL9tqTJCjg8/Y2ige/HddXjpmRT+0zeJr2trdNm6r1a7ovteBL7Onr2jJNoqo7cjiqR2tz8GXjTVcVkWqBQNvmL4YrxmsmK0V11wUH9pPTFkLl3O2IsCyduoeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wp8WEIrm; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 3 Sep 2024 22:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725417686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bbtBqo1EZbK6Re3xFNuGqtBqb/6K6cAryDz++MpLXTo=;
	b=Wp8WEIrmkReXG4RhZ12/r6AgNRaXvsgdQozHpFAg+EXC7PtTK3bO/7edG48d/BdlIvY5QG
	XhudROR/T2cPC2zMEQYpk3yS+E4RhiSIvj2qCHNCmjaGkXTE64LZ2D/jWaZBbc6vIYdOvP
	rbDsuFPLABfR5j0x1zfq5OKMKc3wI20=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net, arnd@arndb.de, mcgrof@kernel.org, 
	rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, tglx@linutronix.de, 
	bp@alien8.de, xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	yuzhao@google.com, vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 6/6] alloc_tag: config to store page allocation tag
 refs in page flags
Message-ID: <6nyab6mvkda6qwq7pk22osychqwnogecw2nhk3tv7dbhxs6yob@zhnfndo5bh4f>
References: <20240902044128.664075-1-surenb@google.com>
 <20240902044128.664075-7-surenb@google.com>
 <20240901221636.5b0af3694510482e9d9e67df@linux-foundation.org>
 <CAJuCfpGNYgx0GW4suHRzmxVH28RGRnFBvFC6WO+F8BD4HDqxXA@mail.gmail.com>
 <47c4ef47-3948-4e46-8ea5-6af747293b18@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47c4ef47-3948-4e46-8ea5-6af747293b18@nvidia.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 03, 2024 at 06:25:52PM GMT, John Hubbard wrote:
> On 9/3/24 11:19 AM, Suren Baghdasaryan wrote:
> > On Sun, Sep 1, 2024 at 10:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > On Sun,  1 Sep 2024 21:41:28 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> ...
> > > We shouldn't be offering things like this to our users.  If we cannot decide, how
> > > can they?
> > 
> > Thinking about the ease of use, the CONFIG_PGALLOC_TAG_REF_BITS is the
> > hardest one to set. The user does not know how many page allocations
> > are there. I think I can simplify this by trying to use all unused
> > page flag bits for addressing the tags. Then, after compilation we can
> > follow the rules I mentioned before:
> > - If the available bits are not enough to address all kernel page
> > allocations, we issue an error. The user should disable
> > CONFIG_PGALLOC_TAG_USE_PAGEFLAGS.
> > - If there are enough unused bits but we have to push last_cpupid out
> > of page flags, we issue a warning and continue. The user can disable
> > CONFIG_PGALLOC_TAG_USE_PAGEFLAGS if last_cpupid has to stay in page
> > flags.
> > - If we run out of addressing space during module loading, we disable
> > allocation tagging and continue. The user should disable
> > CONFIG_PGALLOC_TAG_USE_PAGEFLAGS.
> 
> If the computer already knows what to do, it should do it, rather than
> prompting the user to disable a deeply mystifying config parameter.
> 
> > 
> > This leaves one outstanding case:
> > - If we run out of addressing space during module loading but we would
> > not run out of space if we pushed last_cpupid out of page flags during
> > compilation.
> > In this case I would want the user to have an option to request a
> > larger addressing space for page allocation tags at compile time.
> > Maybe I can keep CONFIG_PGALLOC_TAG_REF_BITS for such explicit
> > requests for a larger space? This would limit the use of
> > CONFIG_PGALLOC_TAG_REF_BITS to this case only. In all other cases the
> > number of bits would be set automatically. WDYT?
> 
> Manually dealing with something like this is just not going to work.
> 
> The more I read this story, the clearer it becomes that this should be
> entirely done by the build system: set it, or don't set it, automatically.

The difficulty is that we don't know how many modules are going to be
loaded, and an allyesconfig or allmodconfig is going to require quite a
few bits - it's not something we can really predict or calculate.

So there is some genuine trickyness here.

