Return-Path: <linux-arch+bounces-13170-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C47B3B28169
	for <lists+linux-arch@lfdr.de>; Fri, 15 Aug 2025 16:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BE87B670FD
	for <lists+linux-arch@lfdr.de>; Fri, 15 Aug 2025 14:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4F921D3E2;
	Fri, 15 Aug 2025 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PQ0jZW3G"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B621CA1E;
	Fri, 15 Aug 2025 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267372; cv=none; b=bgkM3LXQ5rUiB3Fe0vy/cRBfV/Oxj83EeWvzq9pcipDIE1vsW4Drr6vgTWjHUvKbDVcXO+l155B6SaeEzpbnVDHU6VRgcsPIB03OWd4bEQTsAteS50lD8Yr5zuHjeCyyYwsZQXffuwGRpoOeVugZJtRkHLbsgfazjUOxGnJI8FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267372; c=relaxed/simple;
	bh=s9kJmwCMSziAcLWlTjDKKVLqzB9UYAY5Fd1NiDLoqx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etep9HeGlFxoIv5L6EUDj4El/Gxi525WEAS5zOnfTSV5riuoypT+YWEHWZ48C1Nyh1SBz74FHLzJez+iJrcAaBmGdDcu+SYwd1KO+ksFWa+zvqHEyu5LFW6bzioDGMnK6sdhCvze+D8J5MBy3bDFxMT0+QoI4kp+ElMtNnLNbd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PQ0jZW3G; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XDxHrD3TX9AedrU5KLSEMO2f62ogJmkuypzBhYFI+es=; b=PQ0jZW3Gt/YKfyB7A9r1pgw76l
	rQduqzGPLkQ6qEnBZFb6+RR2IWvSJxDQkyXws/quSXO6w3t0Y/GauRAzWcz+vfu9vAXu8+r9WtEqz
	pO1M0U1IYfbHyn7ovx/CqXvlDxUowuK2hwhgEOC5/5/xSqZaGha3kCpLP1sWAyzpgpLxJ6kIeqhUy
	8N1Ntpnt10+ZtqxNTwXRffrvqjsxlIuwiaqwN4OZu95RYXqeHs6lc2RhU1zyeSMWjzT9B8d81/qL2
	S0LnmRilElUK6EZHNhjBzN7tq3Au2y7CfHhIfaYnLxoi+IPnPoi/JsU02NkSYL7vRkxf5Tryc4mth
	L8aoK0Tg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umvDx-0000000Gje9-2EVx;
	Fri, 15 Aug 2025 14:16:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 83BC03002ED; Fri, 15 Aug 2025 16:16:04 +0200 (CEST)
Date: Fri, 15 Aug 2025 16:16:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-alpha@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 00/17] Add __attribute_const__ to ffs()-family
 implementations
Message-ID: <20250815141604.GD3289052@noisy.programming.kicks-ass.net>
References: <20250804163910.work.929-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804163910.work.929-kees@kernel.org>

On Mon, Aug 04, 2025 at 09:43:56AM -0700, Kees Cook wrote:
> Hi,
> 
> While tracking down a problem where constant expressions used by
> BUILD_BUG_ON() suddenly stopped working[1], we found that an added static
> initializer was convincing the compiler that it couldn't track the state
> of the prior statically initialized value. Tracing this down found that
> ffs() was used in the initializer macro, but since it wasn't marked with
> __attribute_const__, the compiler had to assume the function might
> change variable states as a side-effect (which is not true for ffs(),
> which provides deterministic math results).
> 
> Add KUnit tests for the family of functions and then add __attribute_const__
> to all architecture implementations and wrappers.
> 
> -Kees
> 
> [1] https://github.com/KSPP/linux/issues/364
> 
> Kees Cook (17):
>   KUnit: Introduce ffs()-family tests
>   bitops: Add __attribute_const__ to generic ffs()-family
>     implementations
>   csky: Add __attribute_const__ to ffs()-family implementations
>   x86: Add __attribute_const__ to ffs()-family implementations
>   powerpc: Add __attribute_const__ to ffs()-family implementations
>   sh: Add __attribute_const__ to ffs()-family implementations
>   alpha: Add __attribute_const__ to ffs()-family implementations
>   hexagon: Add __attribute_const__ to ffs()-family implementations
>   riscv: Add __attribute_const__ to ffs()-family implementations
>   openrisc: Add __attribute_const__ to ffs()-family implementations
>   m68k: Add __attribute_const__ to ffs()-family implementations
>   mips: Add __attribute_const__ to ffs()-family implementations
>   parisc: Add __attribute_const__ to ffs()-family implementations
>   s390: Add __attribute_const__ to ffs()-family implementations
>   xtensa: Add __attribute_const__ to ffs()-family implementations
>   sparc: Add __attribute_const__ to ffs()-family implementations
>   KUnit: ffs: Validate all the __attribute_const__ annotations

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

