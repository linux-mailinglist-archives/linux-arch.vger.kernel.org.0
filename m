Return-Path: <linux-arch+bounces-11967-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0F0AB91DA
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 23:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08407A00114
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 21:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E08525A2B4;
	Thu, 15 May 2025 21:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="I/AQCSdY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D4B1E5B68;
	Thu, 15 May 2025 21:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747345337; cv=none; b=qyipdTG8C8Lplw3lf940+WwWdUDESbjocM8xCY7wqyuf61j2nTCcJwXYHnq23QLwWffnKhz+Pxvg1mRp+uo62gvMUsEHWBIAHR9Hr68sPfUJ92FDRGmbwgtuXcedlY1T+DW0vFo2uwKDUE+zsRsU8D/UsJQouWh3SJoLKRn15+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747345337; c=relaxed/simple;
	bh=0lGdYALht8jvtlMHBqLWcThLCKg27MFdj9Q9bOAupyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HngCFVz/omEkfiHY+xZL4iVWmtIKGsUB0iWebx5+TEv0/vPc0zar6cdqbwomrIzAEqXw8YGjx39BWvJwXM6mVql9+2HHeFXtFY1zL0LEcaFZ4Rzwd7MGGsWiNnXSzd/m3XJCLIbo77u3uCzS3FC7430a9VOwd3lag6gVJp19x9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=I/AQCSdY; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9485:60b7:882d:1594:8b0f] ([IPv6:2601:646:8081:9485:60b7:882d:1594:8b0f])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54FLg6993722619
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 15 May 2025 14:42:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54FLg6993722619
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1747345327;
	bh=5+5WQLOmPU1IMN95uvu1FCVxLzPElT5oiZ9DbCKSWFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I/AQCSdYHV7iuhzylCcR/IxbmVI/F8Yx+VvNTvNCZ9JIFNskW+9xn5tOpQoQ1iCNv
	 D8NlX+bu8GrqLC/f3JSHVzOnPM/IZIuxeX2HWbRnGs9SlHQTrylbw6bJLnCZ2SHIxM
	 +NNguh7t+15ub0VT4bdrxtW+bmJN8Sy4Lq3yRI+Rfo6gz5rPW/QtGPMWrseSV5WJlm
	 twdxES5q+dA6WvdOuTw4+xkFKpDgAwmQBCuvtVV+ELsUaGqyQ/WyzkqI845MAVXob7
	 32hWcPx83HXSQ3ppbUGb8fCkVAiIBzbL9dHJpzsd6jCJzMM3dwUHTPLR7I4QHEjtmY
	 ZcWRkDNmOW61w==
Message-ID: <425880dd-e694-4428-999e-a787a666de5f@zytor.com>
Date: Thu, 15 May 2025 14:42:01 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Metalanguage for the Linux UAPI
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org
References: <feb98a0f-8d17-495c-b556-b4fe19446d5d@zytor.com>
 <CAHk-=wi7sLm+zHUkyFO8V6QNghLQn0yiWsHfm8WU=V15K7K07Q@mail.gmail.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CAHk-=wi7sLm+zHUkyFO8V6QNghLQn0yiWsHfm8WU=V15K7K07Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/25 14:20, Linus Torvalds wrote:
> 
> If you _really_ want to do a Metalanguage for these things, and want
> to support lots of different namespace issues, several different
> languages etc, I have a very practical suggestion: make that
> metalanguage have a very strict and traditional syntax. Make it look
> like C with the C pre-processor.
> 
> There are lots of libraries and tools to parse C, and turn it into
> other forms. Making up a new language when we already *have* a good
> language is all kinds of silly. Just use the language it already is
> in, and take advantage of the fact that there's lots of infrastructure
> for that language.
> 

Yes, and I looked at using sparse for this purpose. It is not a bad
choice all things considered, but there is definitely metadata that we
simply don't provide.

Building it on top of sparse might still very well be The Right Thing.

It doesn't just affect libc, either; it also affects tools like strace,
sanitizer, and so on. The situation with ioctls is by far the worst.

	-hpa


