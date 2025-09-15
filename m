Return-Path: <linux-arch+bounces-13608-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63379B57228
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 10:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A20B17DBA2
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 08:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0851FBEB9;
	Mon, 15 Sep 2025 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uykw+0R9"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBD22D5A0C;
	Mon, 15 Sep 2025 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923267; cv=none; b=PWbuy5omHCYDrqJxlDr0cqMPRwSnEvGHB5q28MnfphbHHrcAsPP6d3Yxit4Wjrb+wYAX1G78XGUhQRxPiy66sEUBbDAV178BV9Dm/MqJIXgbymRA453uLPYU0su1tvagfhp4Tabs7Vmz1RaV+KcvH5uAgUzWVQu0lp1YjLEO9Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923267; c=relaxed/simple;
	bh=0+tz1zj31RfoL32vadKg89/mQT+Ohn5CXj+nVykOgKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzmx3FHxXLOR05BNfXFbjJTk/yQYnwtc0VDYjnoltl/efWPd2SAFbWs+KscJuPn+9fHvB5fd6b9IbWIqrqEY+md4qxHGxu6oeTs2wAUHEINFvh1t2+MwqW0kfQ0c2AwTtCcR/NUYCQ/4i8djC+Rtmsch+8XWmq4tqydatFC0jM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Uykw+0R9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jonmaVcGtJWv0aVkRcTv8ZFU9T2t2UVyNF1hWIKbZtw=; b=Uykw+0R9RibxKo09CI/drghfbl
	tK89vLKwrAk8ZhR82JKtLLeEYB94xBbjhnzUFJqRSyGAxA2EdkNdKQ2VmP6vqZ1RQaCoZmFJDwWnU
	FVUgvM6O5D2Nj+w0SMFMvABs1kPAOxmwWLIWFAU/kVJxCZzJRw5/254AXU29uYHVPBUjSCxK8e+2r
	ZrxJsxrL5tu+En7/uJuSOVF1OT/JqiWRmBFMFhOcq6wwT3kpgrFXcxm2DJMf2oNZGapSXkgxaBzaT
	b+OcDyH9RQqVA9NXH20WrSx9p8YTgr4OU9wIRGqsulBbBfKus4QUn2F6UaUDb96CzEOoZ+KGE7I2Z
	hJUW/Cew==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy48t-00000006trB-1rvp;
	Mon, 15 Sep 2025 08:00:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EF34C300212; Mon, 15 Sep 2025 10:00:54 +0200 (CEST)
Date: Mon, 15 Sep 2025 10:00:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@vger.kernel.org
Subject: Re: [RFC v2 3/3] atomic: Add alignment check to instrumented atomic
 operations
Message-ID: <20250915080054.GS3419281@noisy.programming.kicks-ass.net>
References: <cover.1757810729.git.fthain@linux-m68k.org>
 <e5a38b0ccf2d37185964a69b6e8657c992966ff7.1757810729.git.fthain@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5a38b0ccf2d37185964a69b6e8657c992966ff7.1757810729.git.fthain@linux-m68k.org>

On Sun, Sep 14, 2025 at 10:45:29AM +1000, Finn Thain wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Add a Kconfig option for debug builds which logs a warning when an
> instrumented atomic operation takes place at some location that isn't
> a long word boundary. Some platforms don't trap for this.
> 
> Link: https://lore.kernel.org/lkml/20250901093600.GF4067720@noisy.programming.kicks-ass.net/
> ---
> This patch differs slightly from Peter's code which checked for natural
> alignment.
> ---
>  include/linux/instrumented.h |  4 ++++
>  lib/Kconfig.debug            | 10 ++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> index 711a1f0d1a73..55f5685971a1 100644
> --- a/include/linux/instrumented.h
> +++ b/include/linux/instrumented.h
> @@ -7,6 +7,7 @@
>  #ifndef _LINUX_INSTRUMENTED_H
>  #define _LINUX_INSTRUMENTED_H
>  
> +#include <linux/bug.h>
>  #include <linux/compiler.h>
>  #include <linux/kasan-checks.h>
>  #include <linux/kcsan-checks.h>
> @@ -67,6 +68,7 @@ static __always_inline void instrument_atomic_read(const volatile void *v, size_
>  {
>  	kasan_check_read(v, size);
>  	kcsan_check_atomic_read(v, size);
> +	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (sizeof(long) - 1)));
>  }
>  
>  /**
> @@ -81,6 +83,7 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
>  {
>  	kasan_check_write(v, size);
>  	kcsan_check_atomic_write(v, size);
> +	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (sizeof(long) - 1)));
>  }
>  
>  /**
> @@ -95,6 +98,7 @@ static __always_inline void instrument_atomic_read_write(const volatile void *v,
>  {
>  	kasan_check_write(v, size);
>  	kcsan_check_atomic_read_write(v, size);
> +	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (sizeof(long) - 1)));
>  }

Right, so why aren't we trusting the size argument? And instead
mandating a possibly larger alignment?

Note how things like test_and_set_bit() will use sizeof(long), while
atomic_set() will use sizeof(*v), which, on LP64 architectures are very
much not the same.

The same with atomic_*() vs atomic_long_*() / atomic64_*(), they will
have different alignment requirements.

And then there is cmpxchg(), that can be u8 u16, u32 and u64 depending
on the user. And then there is cmpxchg128().

I really don't see how using long here is correct.



