Return-Path: <linux-arch+bounces-3948-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989EB8B197A
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 05:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393D71F22DCB
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 03:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5E5225D0;
	Thu, 25 Apr 2024 03:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SB/UBFh9"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE881CF8A
	for <linux-arch@vger.kernel.org>; Thu, 25 Apr 2024 03:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015574; cv=none; b=hMTrCMfgPRwdwb2C0ImogOvIUuYD/bQD6qGNtp/yCDCR6SyV6faM90UAQ965G8r6LNgIpTerJZx6f4YeKjH55ZwO5rv6sb9qOeK43/PqeExJZtjSEpiy2tgsQZ62rqLloBCbyMRhmoQegDTQwnewXEeN1eyI0Qh2iH43VQGdqWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015574; c=relaxed/simple;
	bh=88mSEe2XHZvT1rBs/fYya7T2WNxPEAzzgRRezEnLHpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nzr35g+JRr/BwlAc1y+eW+9f9dXunvTvHG5coq4SGetTCnf9teean13EsSPqRj4OCKFtSWeRrjU/9/QlYh/gqBvj2d6YM6HpshlRgiK3GFmwjQe5O4eBFzt3JoxScahDzO4lFNLJ1jeoTkBjp/lKf3lUbCNPn9FEdSdJtmnJ+2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SB/UBFh9; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Apr 2024 23:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714015569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B4E11bh0mnSYCbs7XlFu6X7DBUDw+NgzQF2QoLRfZq4=;
	b=SB/UBFh9p4EtaUdmuFy3Y/2llf6hAFYeqTBTCq9EEsoT+vbVj3Dlf1lTZDFcjgmVyftRCV
	Waevx5gMLX6VuaMH0g7owkCnFmE0q6eqUFo94c3PjotScdKb99fpqHnymmit8v+7TmVjp+
	fv6zDMYTkmqCw9Lze8Tza4V/pRVw9Ow=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, 
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, 
	peterx@redhat.com, david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, 
	masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, 
	tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, songmuchun@bytedance.com, jbaron@akamai.com, 
	aliceryhl@google.com, rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Subject: Re: [PATCH v6 00/37] Memory allocation profiling
Message-ID: <3eyvxqihylh4st6baagn6o6scw3qhcb6lapgli4wsic2fvbyzu@h66mqxcikmcp>
References: <20240321163705.3067592-1-surenb@google.com>
 <202404241852.DC4067B7@keescook>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404241852.DC4067B7@keescook>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 24, 2024 at 06:59:01PM -0700, Kees Cook wrote:
> On Thu, Mar 21, 2024 at 09:36:22AM -0700, Suren Baghdasaryan wrote:
> > Low overhead [1] per-callsite memory allocation profiling. Not just for
> > debug kernels, overhead low enough to be deployed in production.
> 
> Okay, I think I'm holding it wrong. With next-20240424 if I set:
> 
> CONFIG_CODE_TAGGING=y
> CONFIG_MEM_ALLOC_PROFILING=y
> CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=y
> 
> My test system totally freaks out:
> 
> ...
> SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> Oops: general protection fault, probably for non-canonical address 0xc388d881e4808550: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 0 PID: 0 Comm: swapper Not tainted 6.9.0-rc5-next-20240424 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> RIP: 0010:__kmalloc_node_noprof+0xcd/0x560
> 
> Which is:
> 
> __kmalloc_node_noprof+0xcd/0x560:
> __slab_alloc_node at mm/slub.c:3780 (discriminator 2)
> (inlined by) slab_alloc_node at mm/slub.c:3982 (discriminator 2)
> (inlined by) __do_kmalloc_node at mm/slub.c:4114 (discriminator 2)
> (inlined by) __kmalloc_node_noprof at mm/slub.c:4122 (discriminator 2)
> 
> Which is:
> 
>         tid = READ_ONCE(c->tid);
> 
> I haven't gotten any further than that; I'm EOD. Anyone seen anything
> like this with this series?

I certainly haven't. That looks like some real corruption, we're in slub
internal data structures and derefing a garbage address. Check kasan and
all that?

