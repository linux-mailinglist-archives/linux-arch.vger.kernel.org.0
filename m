Return-Path: <linux-arch+bounces-15647-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E63ECF04DD
	for <lists+linux-arch@lfdr.de>; Sat, 03 Jan 2026 20:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F39CB3007E48
	for <lists+linux-arch@lfdr.de>; Sat,  3 Jan 2026 19:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E55A246762;
	Sat,  3 Jan 2026 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngReHhb0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E01217C220;
	Sat,  3 Jan 2026 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767468213; cv=none; b=UEbgsCGgc2t5NAUK49yS96HjRNqKHXxpZXvW6jjqH1uVWSfR0cbZChlsmQSzVkwZKutLiW+TLXpQ8jgmj1dAnOTdsh1iriBcL9fzHjMTmsiyppW5e3EpDL6cCkykst4KKdUacgjOBIhQsW8Ms+0rBVKHlOFg7n6It9go4FWA3zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767468213; c=relaxed/simple;
	bh=kFPBzT8l+WwHu+3My5hbLBVwoqHKka5P/1LTiFfRdf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzef/c9M9RvuBIT9wjPtea1Itbkds1prcCftI0SZfP9fEK04e9XMakl31fZLe0XCN0VJUtJQZ4AB9X9e60Ysh/9leNbnDw+1oDQCEiuzkiRlX5qhfW139hxXTvyliPQZNquYEGpVbmJIS4Li1IPlZ9AP0vEj74E0dEWD0/S+RQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngReHhb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DA3C113D0;
	Sat,  3 Jan 2026 19:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767468212;
	bh=kFPBzT8l+WwHu+3My5hbLBVwoqHKka5P/1LTiFfRdf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ngReHhb0xBx1x5fvYtOfgcpLEILzqu49lQW1bMb2wRc3+BW1vWJdoV/liivSukWbi
	 Wr1u0+WC02baG/7qzxuTHFHic6PVnSamdiPxhEqTgA1S2pA1eqYyInnK8Yq7O5/pa1
	 cl2RU6O4se6+wNz0wv5fa0sTosXv7JI6nHpQxOqCzUdzlR3V5lzLornbt5v4CC52Wv
	 K6NU1UCrStxzBWELoCL6XaOEUwgpoF1/dezzddv3CKdw8etbedWu0aGGeJ5bgKxD0h
	 Hx+Y7xYCdQlhaa0yCF5YVhge9J70WfDqFLK3pVNIX1+38Kw2MCSO0IgV/T3FqAtpNA
	 9fVyAIlQ2ZFFg==
Date: Sat, 3 Jan 2026 21:23:21 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
	pmladek@suse.com, rdunlap@infradead.org, corbet@lwn.net,
	david@redhat.com, mhocko@suse.com, tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, jonechou@google.com,
	rostedt@goodmis.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org, tony.luck@intel.com, kees@kernel.org
Subject: Re: [PATCH 18/26] mm/memblock: Add MEMBLOCK_INSPECT flag
Message-ID: <aVlsqdgXSBLIE9Xi@kernel.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
 <20251119154427.1033475-19-eugen.hristev@linaro.org>
 <aVImIneFgOngYdSn@kernel.org>
 <4b8953ac-567b-4d68-9c25-72a69afdf1b3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b8953ac-567b-4d68-9c25-72a69afdf1b3@linaro.org>

On Sat, Jan 03, 2026 at 08:36:40AM +0200, Eugen Hristev wrote:
> 
> 
> On 12/29/25 08:56, Mike Rapoport wrote:
> > Hi Eugen,
> > 
> > On Wed, Nov 19, 2025 at 05:44:19PM +0200, Eugen Hristev wrote:
> >> This memblock flag indicates that a specific block is registered
> >> into an inspection table.
> >> The block can be marked for inspection using memblock_mark_inspect()
> >> and cleared with memblock_clear_inspect()
> > 
> > Can you explain why memblock should treat memory registered for inspection
> > differently?
> 
> It should not, at a first glance.
> 
> The purpose of the flag is to let memblock be aware of it.
> The flag is there to have a "memblock way" of registering the memory,
> which inside memblock , it can translate to a meminspect way of
> registering the memory. It's just an extra layer on top of meminspect.
> With this, it would be avoided to call meminspect all over the places it
> would be required, but rather use the memblock API.

memblock APIs are not available after boot on many architectures, most
notable being x86.

But regardless, I can't say I understand why using memblock APIs for
meminspect is better than using meminspect directly.
I'd imagine that using meminspect register APIs would actually make it more
consistent and it would be easier to identify what memory is registered
with meminspect.

In the end, memblock_alloc*() returns dynamically allocated memory, just
like kmalloc(), the difference is that memblock is active very early at
boot and disappears after core MM initialization.

> And further, inside memblock, it would be a single point where
> meminspect can be disabled (while preserving a no-op memblock flag), or
> easily changed to another API if needed.
> Ofcourse, one can call here directly the meminspect API if this is desired.
> Do you think it would be better to have it this way ?
> 
> Thanks for looking into it,
> Eugen

-- 
Sincerely yours,
Mike.

