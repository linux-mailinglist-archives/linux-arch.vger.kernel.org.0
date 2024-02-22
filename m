Return-Path: <linux-arch+bounces-2669-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C9485EE61
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 01:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4831C22539
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 00:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC76F14A8F;
	Thu, 22 Feb 2024 00:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FQI3yFBo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECD410A0A
	for <linux-arch@vger.kernel.org>; Thu, 22 Feb 2024 00:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708563485; cv=none; b=ZWNXu2K9E91Iy2+7uumZeETFAquktPYGaikBqbNOMVRo4MTOIq+NJ0kZCaoGBkJvJJS610/KAvLuxRTphAZR36Av+KqbFG4zuHlagBEw7W0Zh6td6/z9zfQvMOE9J4S8Vtoo5M7QH20eSLB723ZlVcQCnpSdoReuCLz/CoJjo8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708563485; c=relaxed/simple;
	bh=bspwEmj9ztDC3prfWzHxoOOULFAJ2sC2HzPuV2/nx/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdzFPDZDim44YyL3HP9pd0O6u7TLfzPD+6MT/quliQBkS3K4VyFE9yxn2vzT3Sagst3s90T+gHN8O00GkWCO7K4wWgAPz7eAG5ujKnZwlpgUhEWMdxChgFJRVOAxqAXd048g8sTmrgxoFuT1PhKhd4mU0wFpaglECTMoQYl0TxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FQI3yFBo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d7431e702dso72230305ad.1
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 16:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708563480; x=1709168280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ulpOkHFvivSSE+e2M3yzbCAjenVPYV9xC3Luo/BV0yQ=;
        b=FQI3yFBo2hSzyL+RI9F4txpxG1nXYoWK0F5XiZbchbvgJ1FKLK0Mqb6g2vfPmuPY0o
         jxMpNMiNXVAQmeZs+EChJ1bIf7LCaMYzzzFxcpEPD7N+wHS3MVYxsdyNMJnazAsNlsAN
         DGp/CHy4Nf+K/MMUextxwk4Ryy1z05JEJV0Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708563480; x=1709168280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulpOkHFvivSSE+e2M3yzbCAjenVPYV9xC3Luo/BV0yQ=;
        b=ASCyXp+5+xzUqNtNPPlHKz6XaYr38s3GkGDtFgTbPFSsV422o7prvZjgg6WUTbSH9F
         hy7M2UOXUWkFV7ivsR8RVVU8eljyxOt3otveSWeZFOPw09/PoD7hGfx+EpRFMGkhWgKN
         ky6EVyqzGTpgKXDVNH5mFF02s7Yc6y2XOUaCz1p7vtj6b4Tq46ykDWXbq21yTFMvTuWx
         nYvG0AYpaZgEoLhWMNAl1mdJcU4KGK2WJDwxbKBFs8JMjtGFZFlDY5981P7Z+v/IGZ49
         CYKwBPCZVaAk4ATm4gAX7YVm3Zvz6cowfnpU+9/jenSueRuUanDEaQGQKmpAGE4Xr2ej
         2pQA==
X-Forwarded-Encrypted: i=1; AJvYcCXFUPNj4JEaNczM9NwSrMJSmsNqPYdUM7oh2eGneIE7o/nIcJkQS4582tXtvO31Hv7nOVwzD1VPxE+w1jc2z2hPdnid4O5HtJojlA==
X-Gm-Message-State: AOJu0Yx/jz9TQzy4D7iqzTKnIOT1YW+JK4HanrgCX+ckPhScoLQQLPPq
	Ls2lk3JlLw+ieuP71mTnAkFoaLTHbJ+cjcwMbpP89PXyGOg+bFbUQhvo50+Mmw==
X-Google-Smtp-Source: AGHT+IE07ndtCmucLw+AwElpuaWlFxCXEKAdQ2SXPUsu8K/z1cEru3443BCr7LS4IH8cJcRmaUmXqA==
X-Received: by 2002:a17:902:7ed0:b0:1d9:a4bb:29f2 with SMTP id p16-20020a1709027ed000b001d9a4bb29f2mr15732121plb.46.1708563479697;
        Wed, 21 Feb 2024 16:57:59 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902c21100b001dc23e877c9sm2736280pll.106.2024.02.21.16.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 16:57:59 -0800 (PST)
Date: Wed, 21 Feb 2024 16:57:58 -0800
From: Kees Cook <keescook@chromium.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
	willy@infradead.org, liam.howlett@oracle.com,
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net,
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v4 14/36] lib: add allocation tagging support for memory
 allocation profiling
Message-ID: <202402211656.C3644FB@keescook>
References: <20240221194052.927623-1-surenb@google.com>
 <20240221194052.927623-15-surenb@google.com>
 <202402211449.401382D2AF@keescook>
 <4vwiwgsemga7vmahgwsikbsawjq5xfskdsssmjsfe5hn7k2alk@b6ig5v2pxe5i>
 <202402211608.41AD94094@keescook>
 <vxx2o2wdcqjkxauglu7ul52mygu4tti2i3yc2dvmcbzydvgvu2@knujflwtakni>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vxx2o2wdcqjkxauglu7ul52mygu4tti2i3yc2dvmcbzydvgvu2@knujflwtakni>

On Wed, Feb 21, 2024 at 07:34:44PM -0500, Kent Overstreet wrote:
> On Wed, Feb 21, 2024 at 04:25:02PM -0800, Kees Cook wrote:
> > On Wed, Feb 21, 2024 at 06:29:17PM -0500, Kent Overstreet wrote:
> > > On Wed, Feb 21, 2024 at 03:05:32PM -0800, Kees Cook wrote:
> > > > On Wed, Feb 21, 2024 at 11:40:27AM -0800, Suren Baghdasaryan wrote:
> > > > > [...]
> > > > > +struct alloc_tag {
> > > > > +	struct codetag			ct;
> > > > > +	struct alloc_tag_counters __percpu	*counters;
> > > > > +} __aligned(8);
> > > > > [...]
> > > > > +#define DEFINE_ALLOC_TAG(_alloc_tag)						\
> > > > > +	static DEFINE_PER_CPU(struct alloc_tag_counters, _alloc_tag_cntr);	\
> > > > > +	static struct alloc_tag _alloc_tag __used __aligned(8)			\
> > > > > +	__section("alloc_tags") = {						\
> > > > > +		.ct = CODE_TAG_INIT,						\
> > > > > +		.counters = &_alloc_tag_cntr };
> > > > > [...]
> > > > > +static inline struct alloc_tag *alloc_tag_save(struct alloc_tag *tag)
> > > > > +{
> > > > > +	swap(current->alloc_tag, tag);
> > > > > +	return tag;
> > > > > +}
> > > > 
> > > > Future security hardening improvement idea based on this infrastructure:
> > > > it should be possible to implement per-allocation-site kmem caches. For
> > > > example, we could create:
> > > > 
> > > > struct alloc_details {
> > > > 	u32 flags;
> > > > 	union {
> > > > 		u32 size; /* not valid after __init completes */
> > > > 		struct kmem_cache *cache;
> > > > 	};
> > > > };
> > > > 
> > > > - add struct alloc_details to struct alloc_tag
> > > > - move the tags section into .ro_after_init
> > > > - extend alloc_hooks() to populate flags and size:
> > > > 	.flags = __builtin_constant_p(size) ? KMALLOC_ALLOCATE_FIXED
> > > > 					    : KMALLOC_ALLOCATE_BUCKETS;
> > > > 	.size = __builtin_constant_p(size) ? size : SIZE_MAX;
> > > > - during kernel start or module init, walk the alloc_tag list
> > > >   and create either a fixed-size kmem_cache or to allocate a
> > > >   full set of kmalloc-buckets, and update the "cache" member.
> > > > - adjust kmalloc core routines to use current->alloc_tag->cache instead
> > > >   of using the global buckets.
> > > > 
> > > > This would get us fully separated allocations, producing better than
> > > > type-based levels of granularity, exceeding what we have currently with
> > > > CONFIG_RANDOM_KMALLOC_CACHES.
> > > > 
> > > > Does this look possible, or am I misunderstanding something in the
> > > > infrastructure being created here?
> > > 
> > > Definitely possible, but... would we want this?
> > 
> > Yes, very very much. One of the worst and mostly unaddressed weaknesses
> > with the kernel right now is use-after-free based type confusion[0], which
> > depends on merged caches (or cache reuse).
> > 
> > This doesn't solve cross-allocator (kmalloc/page_alloc) type confusion
> > (as terrifyingly demonstrated[1] by Jann Horn), but it does help with
> > what has been a very common case of "use msg_msg to impersonate your
> > target object"[2] exploitation.
> 
> We have a ton of code that references PAGE_SIZE and uses the page
> allocator completely unnecessarily - that's something worth harping
> about at conferences; if we could motivate people to clean that stuff up
> it'd have a lot of positive effects.
> 
> > > That would produce a _lot_ of kmem caches
> > 
> > Fewer than you'd expect, but yes, there is some overhead. However,
> > out-of-tree forks of Linux have successfully experimented with this
> > already and seen good results[3].
> 
> So in that case - I don't think there's any need for a separate
> alloc_details; we'd just add a kmem_cache * to alloc_tag and then hook
> into the codetag init/unload path to create and destroy the kmem caches.

Okay, sounds good. There needs to be a place to track "is this a fixed
size or a run-time size" choice.

> No need to adjust the slab code either; alloc_hooks() itself could
> dispatch to kmem_cache_alloc() instead of kmalloc() if this is in use.

Right, it'd go to either kmem_cache_alloc() directly, or to a modified
kmalloc() that used the passed-in cache is the base for an array of sized
buckets, rather than the global (or 16-way global) buckets.

Yay for the future!

-- 
Kees Cook

