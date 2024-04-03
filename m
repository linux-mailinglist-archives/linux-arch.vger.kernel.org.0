Return-Path: <linux-arch+bounces-3400-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1C3897AF4
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 23:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B8EDB24821
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 21:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40225156961;
	Wed,  3 Apr 2024 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lGMlDuct"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69117156870;
	Wed,  3 Apr 2024 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180534; cv=none; b=h6+Ii62YyI7aIIHlYaI4BtzzEzROpi/zu9qJWFyu6+bkbqTkJQIYPHs3ZnWA0pGXO/F6vV334h0qk70jXwe7p6dDHPsyU6iN5EY/69LRttT36q3GNub/E9eFHP/EGtWl+MAA6LJe/pV2R3CB9Cd0D1Kat6ouYb+n4jl6qiZqUPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180534; c=relaxed/simple;
	bh=x+FV5GoB+NEz6+1MxtrN8DBzkMq3eDfL9fgL9YEpHyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gc0ykouNvp2V8YL01pVcapvpR+affyC2QG04JcreWfiQEg32eCWQYf/XCYkpTSvVUO/6qVD28/1VCMhRH4uoyOR8A+1R5DfNiQB+kDe4a+w9XU8MYHbw28stUPz8SBlcLSgadFKzzGqbCIuhs9lQi9xiNYWowA+dRktmyQiWSWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lGMlDuct; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 3 Apr 2024 17:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712180527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I8oAok5It38shVDkwL940Pa8qX3ifwx6XR6MQgkhnY4=;
	b=lGMlDuctByVDszORVgYlbk2emZzNfH18lVbOM3PP8QqASVaLVaaVhE4vLYrvnQGixqKQn+
	JoBwih61WSwFWMdg5hVCAoj/8hdJcJ9cfeJ6GbrYKLCxCnMqAOBy1GlT1ZzritCAT4+N6a
	jWAURONL2YqX3Zp+MfY4wq5MmwF4PmI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, 
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, 
	peterx@redhat.com, david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, 
	masahiroy@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, hughd@google.com, 
	andreyknvl@gmail.com, keescook@chromium.org, ndesaulniers@google.com, 
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, 
	cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, songmuchun@bytedance.com, 
	jbaron@akamai.com, aliceryhl@google.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v6 01/37] fix missing vmalloc.h includes
Message-ID: <4qk7f3ra5lrqhtvmipmacgzo5qwnugrfxn5dd3j4wubzwqvmv4@vzdhpalbmob3>
References: <20240321163705.3067592-1-surenb@google.com>
 <20240321163705.3067592-2-surenb@google.com>
 <20240403211240.GA307137@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403211240.GA307137@dev-arch.thelio-3990X>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 03, 2024 at 02:12:40PM -0700, Nathan Chancellor wrote:
> On Thu, Mar 21, 2024 at 09:36:23AM -0700, Suren Baghdasaryan wrote:
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> > 
> > The next patch drops vmalloc.h from a system header in order to fix
> > a circular dependency; this adds it to all the files that were pulling
> > it in implicitly.
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> 
> I bisected an error that I see when building ARCH=loongarch allmodconfig
> to commit 302519d9e80a ("asm-generic/io.h: kill vmalloc.h dependency")
> in -next, which tells me that this patch likely needs to contain
> something along the following lines, as LoongArch was getting
> include/linux/sizes.h transitively through the vmalloc.h include in
> include/asm-generic/io.h.

gcc doesn't appear to be packaged for loongarch for debian (most other
cross compilers are), so that's going to make it hard for me to test
anything...

> 
> Cheers,
> Nathan
> 
>   In file included from arch/loongarch/include/asm/io.h:11,
>                    from include/linux/io.h:13,
>                    from arch/loongarch/mm/mmap.c:6:
>   include/asm-generic/io.h: In function 'ioport_map':
>   arch/loongarch/include/asm/addrspace.h:124:25: error: 'SZ_32M' undeclared (first use in this function); did you mean 'PS_32M'?
>     124 | #define PCI_IOSIZE      SZ_32M
>         |                         ^~~~~~
>   arch/loongarch/include/asm/addrspace.h:126:26: note: in expansion of macro 'PCI_IOSIZE'
>     126 | #define IO_SPACE_LIMIT  (PCI_IOSIZE - 1)
>         |                          ^~~~~~~~~~
>   include/asm-generic/io.h:1113:17: note: in expansion of macro 'IO_SPACE_LIMIT'
>    1113 |         port &= IO_SPACE_LIMIT;
>         |                 ^~~~~~~~~~~~~~
>   arch/loongarch/include/asm/addrspace.h:124:25: note: each undeclared identifier is reported only once for each function it appears in
>     124 | #define PCI_IOSIZE      SZ_32M
>         |                         ^~~~~~
>   arch/loongarch/include/asm/addrspace.h:126:26: note: in expansion of macro 'PCI_IOSIZE'
>     126 | #define IO_SPACE_LIMIT  (PCI_IOSIZE - 1)
>         |                          ^~~~~~~~~~
>   include/asm-generic/io.h:1113:17: note: in expansion of macro 'IO_SPACE_LIMIT'
>    1113 |         port &= IO_SPACE_LIMIT;
>         |                 ^~~~~~~~~~~~~~
> 
> diff --git a/arch/loongarch/include/asm/addrspace.h b/arch/loongarch/include/asm/addrspace.h
> index b24437e28c6e..7bd47d65bf7a 100644
> --- a/arch/loongarch/include/asm/addrspace.h
> +++ b/arch/loongarch/include/asm/addrspace.h
> @@ -11,6 +11,7 @@
>  #define _ASM_ADDRSPACE_H
>  
>  #include <linux/const.h>
> +#include <linux/sizes.h>
>  
>  #include <asm/loongarch.h>
>  

