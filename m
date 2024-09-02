Return-Path: <linux-arch+bounces-6894-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A61C3967EB5
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 07:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4621F21EA4
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 05:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BD9143889;
	Mon,  2 Sep 2024 05:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D7vMA9VJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6EA382;
	Mon,  2 Sep 2024 05:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725254198; cv=none; b=tQu3m2AV94XH/V1kMUGcf260A0Jg4B+TdKL7HDnM0FsxVrcPg5hP8Sxr8gy0WUOQuTBKfFX/o3JWPxP4XLIqtOZoJ73nPbxarlRthUMZTH6FTjqxErXVJgwUWHwEO4F8Wh+0+95u7Nq5MF3NAMaI+o4fs6/QMhIj9Uxzzv4QIqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725254198; c=relaxed/simple;
	bh=1xlmn1CCleSTfCBgJB3zCP9jQCY2zoK1n5+MoF/CsVU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GzdD+A/0dmeP1LqV4h+8ruvd6xTNpRDP+HB8V4v+zKZ43wRIdvt6YEshFbLabEksqOmRK3WPQrcXYC85fBVv6miuGOtRSa3/Ha/vDejpMee0Ta2KvT1ekVleXjcnhCHzjWFsZfFU3GvbbXwhYyDknHR+3/IBBUEMfrEvmDaZPc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D7vMA9VJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0515C4CEC2;
	Mon,  2 Sep 2024 05:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725254198;
	bh=1xlmn1CCleSTfCBgJB3zCP9jQCY2zoK1n5+MoF/CsVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D7vMA9VJUJwFXhuMZYsQF8m20GzI1hPhtdRH9/AJItHhYVyfbxTGYjTNs4EgrKr+z
	 4oxLvWk1zZnbWAgN0QtpFQjhan7mhGNBNRprVxLtaoEBTVU38iT4cc3vu+TsODLC7D
	 3HCiPp9GKDuq//9oLoJR1Wrwr7fSNpHIqtabIbh8=
Date: Sun, 1 Sep 2024 22:16:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de,
 mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com,
 tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com,
 ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com,
 souravpanda@google.com, keescook@chromium.org, dennis@kernel.org,
 jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com,
 rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 6/6] alloc_tag: config to store page allocation tag
 refs in page flags
Message-Id: <20240901221636.5b0af3694510482e9d9e67df@linux-foundation.org>
In-Reply-To: <20240902044128.664075-7-surenb@google.com>
References: <20240902044128.664075-1-surenb@google.com>
	<20240902044128.664075-7-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Sep 2024 21:41:28 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Add CONFIG_PGALLOC_TAG_USE_PAGEFLAGS to store allocation tag
> references directly in the page flags. This removes dependency on
> page_ext and results in better performance for page allocations as
> well as reduced page_ext memory overhead.
> CONFIG_PGALLOC_TAG_REF_BITS controls the number of bits required
> to be available in the page flags to store the references. If the
> number of page flag bits is insufficient, the build will fail and
> either CONFIG_PGALLOC_TAG_REF_BITS would have to be lowered or
> CONFIG_PGALLOC_TAG_USE_PAGEFLAGS should be disabled.
> 
> ...
>
> +config PGALLOC_TAG_USE_PAGEFLAGS
> +	bool "Use pageflags to encode page allocation tag reference"
> +	default n
> +	depends on MEM_ALLOC_PROFILING
> +	help
> +	  When set, page allocation tag references are encoded inside page
> +	  flags, otherwise they are encoded in page extensions.
> +
> +	  Setting this flag reduces memory and performance overhead of memory
> +	  allocation profiling but also limits how many allocations can be
> +	  tagged. The number of bits is set by PGALLOC_TAG_USE_PAGEFLAGS and
> +	  they must fit in the page flags field.

Again.  Please put yourself in the position of one of the all-minus-two
people in this world who aren't kernel-memory-profiling-developers. 
How the heck are they to decide whether or not to enable this?  OK, 59%
of them are likely to say "yes" because reasons.  But then what?  How
are they to determine whether it was the correct choice for them?  If
we don't tell them, who will?

>  config PGALLOC_TAG_REF_BITS
>  	int "Number of bits for page allocation tag reference (10-64)"
>  	range 10 64
> -	default "64"
> +	default "16" if PGALLOC_TAG_USE_PAGEFLAGS
> +	default "64" if !PGALLOC_TAG_USE_PAGEFLAGS
>  	depends on MEM_ALLOC_PROFILING
>  	help
>  	  Number of bits used to encode a page allocation tag reference.
> @@ -1011,6 +1027,13 @@ config PGALLOC_TAG_REF_BITS
>  	  Smaller number results in less memory overhead but limits the number of
>  	  allocations which can be tagged (including allocations from modules).
>  
> +	  If PGALLOC_TAG_USE_PAGEFLAGS is set, the number of requested bits should
> +	  fit inside the page flags.

What does "should fit" mean?  "It is your responsibility to make it
fit"?  "We think it will fit but we aren't really sure"?

> +	  If PGALLOC_TAG_USE_PAGEFLAGS is not set, the number of bits used to store
> +	  a reference is rounded up to the closest basic type. If set higher than 32,
> +	  a direct pointer to the allocation tag is stored for performance reasons.
> +

We shouldn't be offering things like this to our users.  If we cannot decide, how
can they?

