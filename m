Return-Path: <linux-arch+bounces-13925-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F16BBBDAC2
	for <lists+linux-arch@lfdr.de>; Mon, 06 Oct 2025 12:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A5F1892822
	for <lists+linux-arch@lfdr.de>; Mon,  6 Oct 2025 10:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D99222DA08;
	Mon,  6 Oct 2025 10:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="InQdX/pQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C34F22B8AB;
	Mon,  6 Oct 2025 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759746157; cv=none; b=IksYwJjcSWN9nTRPC2o7ElH+7qKI37Hfo5/ittdlyz1+qw6X8zfURkGOG5nuQeSyCMGHFD6RzWcqeW6aYV5x4ey727jG/PYjOFLY9jYyYef0f2gl2nRuJmmzO1ulBgM20ByXvefpWr2vONGZFQ1B46GFipf48aaNpgvCtqNRUAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759746157; c=relaxed/simple;
	bh=RWB8LdLzeKP9Rj8M796qQePt0MqCr8q+l9MZCniVCkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prmjNT8bmnHudsYhV7dCrqH24mAhRKPFaE+DAolg0aeriHHsCrrmTdg3eQtSLAemVkjYctAetdsM9TmzFS/vW2bAWtRHL3MCUeJ1WVoOH8p0Tqx84GpWihnebD/sVMOTsKKCf96KEn8XTi1peWlXaV3IHtYmdsSPOHt97kefjdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=InQdX/pQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SeCyiSXFpxhnjR3QB+ng4nXlKTTmpqXiFGZBf0t4NWI=; b=InQdX/pQ+ItKhGdnROX2jwBeL6
	WUh8BnnvAV8uvo6jJQlXpL27GKvqHKjbVzOIjb/p4ETjEqd8/4gp71INIyCNGzEUuOF0wAM9+Rtme
	+2kSlD9nRZ9SHijekYjOmpWHjhm2QjEhrP+Eu0DX8NTc+a7ioBn/tV3URslvLTR/s5fjJp1DbJgy0
	nnzbnKxPl7zlmXx1lf4hhkIl7zyJvcVE1YFNIsxzSYYOKYKU355WY4xXYMEs7LG0oDyP5Xe2YTUR0
	Dq6GaBgJcXQP89dewm3jNl+xgjvbuIjw1hBaNn2LATNhR0MHoqo+Pr/YIejP5ceBpeCY5pvJQWsq5
	mjNnK2Kg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5iMO-00000009bJH-38AL;
	Mon, 06 Oct 2025 10:22:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A09E8300212; Mon, 06 Oct 2025 12:22:28 +0200 (CEST)
Date: Mon, 6 Oct 2025 12:22:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Finn Thain <fthain@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and
 atomic64_t
Message-ID: <20251006102228.GT3245006@noisy.programming.kicks-ass.net>
References: <cover.1757810729.git.fthain@linux-m68k.org>
 <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
 <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com>
 <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org>
 <57ac401b-222b-4c85-b719-9e671a4617cf@app.fastmail.com>
 <86be5cf0-065e-d55d-fdb6-b9cf6655165e@linux-m68k.org>
 <ec2982e3-2996-918e-f406-32f67a0decfe@linux-m68k.org>
 <e02f861b-706c-4f6d-bded-002601da954a@app.fastmail.com>
 <257a045a-f39d-8565-608f-f01f7914be21@linux-m68k.org>
 <d9e3f41e-d152-4382-bb99-7b134ff9f26f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9e3f41e-d152-4382-bb99-7b134ff9f26f@app.fastmail.com>

On Mon, Oct 06, 2025 at 12:07:24PM +0200, Arnd Bergmann wrote:

> It looks like Mark Rutland fixed the try_cmpxchg() function this
> way in commit ec570320b09f ("locking/atomic: Correct (cmp)xchg()
> instrumentation"), but for some reason we still have the wrong
> annotation on the atomic_try_cmpxchg() helpers.

> Mark, I've tried to modify your script to produce that output,
> the output looks correct to me, but it makes the script more
> complex than I liked and I'm not sure that matching on
> "${type}"="p" is the best way to check for this.

I don't see anything wrong with this. The result looks good.

> diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
> index 592f3ec89b5f..9c1d53f81eb2 100755
> --- a/scripts/atomic/gen-atomic-instrumented.sh
> +++ b/scripts/atomic/gen-atomic-instrumented.sh
> @@ -12,7 +12,7 @@ gen_param_check()
>  	local arg="$1"; shift
>  	local type="${arg%%:*}"
>  	local name="$(gen_param_name "${arg}")"
> -	local rw="write"
> +	local rw="atomic_write"
>  
>  	case "${type#c}" in
>  	i) return;;
> @@ -20,14 +20,17 @@ gen_param_check()
>  
>  	if [ ${type#c} != ${type} ]; then
>  		# We don't write to constant parameters.
> -		rw="read"
> +		rw="atomic_read"
> +	elif [ "${type}" = "p" ] ; then
> +		# The "old" argument in try_cmpxchg() gets accessed non-atomically
> +		rw="read_write"
>  	elif [ "${meta}" != "s" ]; then
>  		# An atomic RMW: if this parameter is not a constant, and this atomic is
>  		# not just a 's'tore, this parameter is both read from and written to.
> -		rw="read_write"
> +		rw="atomic_read_write"
>  	fi
>  
> -	printf "\tinstrument_atomic_${rw}(${name}, sizeof(*${name}));\n"
> +	printf "\tinstrument_${rw}(${name}, sizeof(*${name}));\n"
>  }
>  
>  #gen_params_checks(meta, arg...)
> 

