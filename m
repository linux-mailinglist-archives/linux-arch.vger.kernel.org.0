Return-Path: <linux-arch+bounces-13923-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EB0BBD75D
	for <lists+linux-arch@lfdr.de>; Mon, 06 Oct 2025 11:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1F13AABD7
	for <lists+linux-arch@lfdr.de>; Mon,  6 Oct 2025 09:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0661F1527;
	Mon,  6 Oct 2025 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SB176wS0"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C178334BA22;
	Mon,  6 Oct 2025 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759743489; cv=none; b=WEg9kwYj2ps9L2meKabcTM4MtaOGB+kV+bfKr9I2+mqaOH1f6joAgA+hSxGQBPwPiWV6vsx0YOMPWoSUVY4nWMrsPLEHH70zLKei7Xc+QC2WZozifFj9qaD18A6AZ4Zw5SN9oIemOB9yFWUEsyouJiuQcCjp77k4AYaJmBGLzAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759743489; c=relaxed/simple;
	bh=3bY/L5aghdcNB66sp48uVDqRmO1kkKiC+qet1S+ZyZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjI+19ykknuccw2ucejm+f9W7sZ+6tmE9HQnarBMAj+15AD52ld9PA67cM1GVaPVi2WYDv6f37w44dzjRt3rXPMkihDLImxxgJphrQB5ARZEMT3IJSDgmbksTGi05AXHNfpWqapo76ATpFMmJVEyw2EEo+u+S2pr990k0cf0v6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SB176wS0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y5TY2TZIKLKMFiomNIjuuWWnOcQIwufRxhpHlV9/Lg4=; b=SB176wS0kXFDcXePeqNMUxfkpI
	Z46Tbn4BWr1WYLZivxXM0yeG96TLxHBU9Ok/wR1hkHH9gbwhmpxaRxErP0FXhYP2Z1zLHlP4VROIH
	SZMJbCNIslwA1AEF9m8q07wk97f3fQAq+4P/mBGRiHVNbDQXFUN/t9x9kC3dLYhMfjbAeIh9z7OAZ
	UvUVCtL49ASFfNPRQ3Tp1OEZG2HHojv1sVDLIdXlHJjQMpeabLKcftj8B62V6dKtTLGWi7tTDw+9p
	pzSYuOQ9VH+P5zTOeIHFZZyNGm4VfmrAlOH0hAAdqCJm1zD0VJ76eZlE+b+f9tEexIomRjt1Wkus5
	oE3pVd0w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5hfC-00000008s8Y-1xeZ;
	Mon, 06 Oct 2025 09:37:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A7961300289; Mon, 06 Oct 2025 11:37:50 +0200 (CEST)
Date: Mon, 6 Oct 2025 11:37:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Finn Thain <fthain@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>, elver@google.com
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and
 atomic64_t
Message-ID: <20251006093750.GS3245006@noisy.programming.kicks-ass.net>
References: <cover.1757810729.git.fthain@linux-m68k.org>
 <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
 <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com>
 <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org>
 <57ac401b-222b-4c85-b719-9e671a4617cf@app.fastmail.com>
 <86be5cf0-065e-d55d-fdb6-b9cf6655165e@linux-m68k.org>
 <ec2982e3-2996-918e-f406-32f67a0decfe@linux-m68k.org>
 <e02f861b-706c-4f6d-bded-002601da954a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e02f861b-706c-4f6d-bded-002601da954a@app.fastmail.com>

On Tue, Sep 30, 2025 at 08:35:55AM +0200, Arnd Bergmann wrote:
> Since there is nothing telling the compiler that
> the 'old' argument to atomic*_try_cmpcxchg() needs to
> be naturally aligned, maybe that check should be changed
> to only test for the ABI-guaranteed alignment? I think
> that would still be needed on x86-32.
>  
>       Arnd
> 
> diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
> index 9409a6ddf3e0..e57763a889bd 100644
> --- a/include/linux/atomic/atomic-instrumented.h
> +++ b/include/linux/atomic/atomic-instrumented.h
> @@ -1276,7 +1276,7 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
>  {
>  	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
> -	instrument_atomic_read_write(old, sizeof(*old));
> +	instrument_atomic_read_write(old, alignof(*old));
>  	return raw_atomic_try_cmpxchg(v, old, new);
>  }

That's wrong. The argument there really is size, it tells KASAN how wide
the access is.

Arguably we could switch old to instrument_read_write() since the target
is not actually an atomic.

