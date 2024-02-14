Return-Path: <linux-arch+bounces-2381-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43418555AD
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 23:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049211C219F0
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 22:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3E11419AC;
	Wed, 14 Feb 2024 22:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="GOIgzvdr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F4C14199D
	for <linux-arch@vger.kernel.org>; Wed, 14 Feb 2024 22:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707949360; cv=none; b=gkMqNB7KnFA0dyhHIuw7CxRLhootc8c4Vs71ddHWYL7UuXIrj3plFIAtBZkyPRSQMRlB/jDUY7tOAAmrzrdkvZtkuARmDuOy9QJ9iyVV+m0paRdeYDBbSYkj1FvOqRD01hDDmMupqh42rM6dwYDDommRWT2wh2ZKozjIlfS5BbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707949360; c=relaxed/simple;
	bh=Tjfak4zeHO2RhUSUhpoioPVs+jARNcl60hmLZOIqIDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXA/F1/9R1xlKdXZWm7ohx5+mIcroysrOi5UudiBjMeeEa1fnZ9pvgfe6EopU5tzqaJU5UpSafuzNf9HtBHpb+fLuC1sAfzxqCB50uMG24Brw7c24ODOXE22e4cC02+HXUvob6OemQQhag/H+MPKBzMaDWOQtn6tdgU7VdFT2ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=GOIgzvdr; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e0f803d9dfso240662b3a.0
        for <linux-arch@vger.kernel.org>; Wed, 14 Feb 2024 14:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707949358; x=1708554158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ln+OOvGmpFuiRMz6w7NK4oosvSzfGSRKkgDvCaci/QI=;
        b=GOIgzvdrEpOzSeg47eMOE4siXoNP0ukhNR/non+Iru16Vy7bkf5L0ggyiocz+o/4au
         7jy0wBUP+y7dVw6PSpDo5rNJ6yp4fyKsett31PWa3Y2nMd/RE5wY5D5IDaH2Vcald3Yw
         E0sQi/slYrB+9jZj63fyzKIwNELLirugt8tDINfLxMWOH+wgiVkx5LdttrxR3oxsCVGl
         gCuwMdZFgPhH8uAQTOLadpcWbSkkXD1/Agl83sE4/ZMbRh3Z2I1k/qI1plZBQEj6foaR
         Fu3srphsm+2Jj3mrFaW8SrKtgb5Ne4s5sBFe5G8flEIBtCYNvCpC/AFouv9q9OEf94Pu
         24MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707949358; x=1708554158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ln+OOvGmpFuiRMz6w7NK4oosvSzfGSRKkgDvCaci/QI=;
        b=YSe0LekFd9cRSVtTLYqGQRYM5jeV7Jo+XOY6gGaTVk2wUSpy+s4pmHn8R1TsxB8dWe
         xmiijAQa/5UPB9QvpnhDPuYlmL/yM/SfBLX8526avyWElWZ2cqUwjx4zoPju3arKFXE+
         xA9vG5HiCckDZDwnHECP2cV1mu+PfNqWL2lrSS2b6kgKrupPGWMuPv18+M4FQV8MXl7Y
         DEB1z/S1zWbse+eRby6CWbPLl1C55WQtmozOJgI6swMxo/tIdsKr1pAmMQUfQrXN4EEE
         4NaK3fiFb75rxRCNjuo8a9iMpOXKsFMlyym2UPaJ5SkVBHXoAi0TqZyJ1Bzlj6tOxNlH
         65zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgrbOylmksteG7Od2fWzGhUBZiim/hgRjp7tIW04ttRPPvQmiX+QS2QfvndLREvQ8i92sigKZCK74pvDiTlHqIJyNYUC2IYBn7NQ==
X-Gm-Message-State: AOJu0YyLhC9XeF08Jk6QsCAJ+e6wE3a0y0OcEc3JLjs54hn7kjAStPkn
	EK4/RK/Ou2q4xVfyG26dP3pOF2HjAXKiN9PHhLnz4kdGdAGDAW6PphHGEzS9bHk=
X-Google-Smtp-Source: AGHT+IHTGeIRIsITdPStGM5mFftKvPz626lejWEKKG4hpUncJNP4ImSALCuOSyfVaorY4mjRZpEnMA==
X-Received: by 2002:a05:6a20:d703:b0:19e:9b19:96c0 with SMTP id iz3-20020a056a20d70300b0019e9b1996c0mr191489pzb.7.1707949357817;
        Wed, 14 Feb 2024 14:22:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; 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
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id t29-20020a62d15d000000b006e0a55790easm9168222pfl.216.2024.02.14.14.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 14:22:36 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1raNeD-006ZVB-2T;
	Thu, 15 Feb 2024 09:22:33 +1100
Date: Thu, 15 Feb 2024 09:22:33 +1100
From: Dave Chinner <david@fromorbit.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com,
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
Subject: Re: [PATCH v3 25/35] xfs: Memory allocation profiling fixups
Message-ID: <Zc09KRo7nMlSGpG6@dread.disaster.area>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-26-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-26-surenb@google.com>

On Mon, Feb 12, 2024 at 01:39:11PM -0800, Suren Baghdasaryan wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> This adds an alloc_hooks() wrapper around kmem_alloc(), so that we can
> have allocations accounted to the proper callsite.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  fs/xfs/kmem.c |  4 ++--
>  fs/xfs/kmem.h | 10 ++++------
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/xfs/kmem.c b/fs/xfs/kmem.c
> index c557a030acfe..9aa57a4e2478 100644
> --- a/fs/xfs/kmem.c
> +++ b/fs/xfs/kmem.c
> @@ -8,7 +8,7 @@
>  #include "xfs_trace.h"
>  
>  void *
> -kmem_alloc(size_t size, xfs_km_flags_t flags)
> +kmem_alloc_noprof(size_t size, xfs_km_flags_t flags)
>  {
>  	int	retries = 0;
>  	gfp_t	lflags = kmem_flags_convert(flags);
> @@ -17,7 +17,7 @@ kmem_alloc(size_t size, xfs_km_flags_t flags)
>  	trace_kmem_alloc(size, flags, _RET_IP_);
>  
>  	do {
> -		ptr = kmalloc(size, lflags);
> +		ptr = kmalloc_noprof(size, lflags);
>  		if (ptr || (flags & KM_MAYFAIL))
>  			return ptr;
>  		if (!(++retries % 100))
> diff --git a/fs/xfs/kmem.h b/fs/xfs/kmem.h
> index b987dc2c6851..c4cf1dc2a7af 100644
> --- a/fs/xfs/kmem.h
> +++ b/fs/xfs/kmem.h
> @@ -6,6 +6,7 @@
>  #ifndef __XFS_SUPPORT_KMEM_H__
>  #define __XFS_SUPPORT_KMEM_H__
>  
> +#include <linux/alloc_tag.h>
>  #include <linux/slab.h>
>  #include <linux/sched.h>
>  #include <linux/mm.h>
> @@ -56,18 +57,15 @@ kmem_flags_convert(xfs_km_flags_t flags)
>  	return lflags;
>  }
>  
> -extern void *kmem_alloc(size_t, xfs_km_flags_t);
>  static inline void  kmem_free(const void *ptr)
>  {
>  	kvfree(ptr);
>  }
>  
> +extern void *kmem_alloc_noprof(size_t, xfs_km_flags_t);
> +#define kmem_alloc(...)			alloc_hooks(kmem_alloc_noprof(__VA_ARGS__))
>  
> -static inline void *
> -kmem_zalloc(size_t size, xfs_km_flags_t flags)
> -{
> -	return kmem_alloc(size, flags | KM_ZERO);
> -}
> +#define kmem_zalloc(_size, _flags)	kmem_alloc((_size), (_flags) | KM_ZERO)
>  
>  /*
>   * Zone interfaces
> -- 
> 2.43.0.687.g38aa6559b0-goog

These changes can be dropped - the fs/xfs/kmem.[ch] stuff is now
gone in linux-xfs/for-next.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

