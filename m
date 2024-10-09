Return-Path: <linux-arch+bounces-7941-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197AB99796A
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 01:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CA91C21D3F
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 23:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA711E3DFA;
	Wed,  9 Oct 2024 23:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="l64N++3r"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D65C169397;
	Wed,  9 Oct 2024 23:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518322; cv=none; b=IR9M/h2+HhmAF+VBH5uBFSV9ejV+/FRYMSwSP8TAlPcD9ZlEMotdZxAMUWYtinwUVTTjx6qw5HXZl+puvefVFGa0uNZR/RpXZoVa4bZpgnd0EbUcId5J5zr/niJ+Ctc/4IW0MdzSQid0sZCfyUpBKNiHAoXsDKing8UWusWZ3e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518322; c=relaxed/simple;
	bh=G0Q7iVSRit4yYiO8u/lAs13l2igYRA2gBetLKnUu8h8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OtcaFWqTZ3iyqt5MVvQZG48Hm0rb0KWA+bexzZKPo0gctHOXNedsJYNSkVw6rMkWSTdVK3A1b1jO5bYSyWC7PNsiuyKq+FCMdqJMQ50CnYqsNvb2r9QvtUi2JTA766SvvUFmt7e8YSgw5aEtCbMOEv6OJNoo4wq3Tyqx3806gbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=l64N++3r; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1728518316;
	bh=xGr+bL4hNtQoIXlcdCtPf1LScyxeLuXfkYkS492d+io=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=l64N++3rtLStAQ6xt1IGJliIUx6KKR0K6hTsAnaEPELTVaDsqGX4mgFpl21+1eCqa
	 t3uHSkTXDN/T1GQo4QlNiGhwkyHpy51QnTV7fQBwMvCwNAxNUXejuRkmIPh+27HZso
	 3NO8wHiHQ0MmfvqTvjyaf/IAEYtdeLWMWGcIc9EvsYNPW0/7YS41FhkykngoibHFbz
	 wkTQeJ0lPZfoMI9gYDAs5Racj78K8BMPODTt+ct9LxFsBtcHWvNP2MQWwqr8+dRcCY
	 0MnLxLs5aKS6/AsOA8qkptKRaY9pC9VurMzcaCW2HgUh2dymfFxdsn4Vw/+hgw4RFw
	 0SiHFlVm8QfXQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XP8wl4n0mz4wxm;
	Thu, 10 Oct 2024 10:58:31 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, Andy Lutomirski
 <luto@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H . Peter
 Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann
 <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3 2/2] vdso: Introduce vdso/page.h
In-Reply-To: <87ttdlr3s5.ffs@tglx>
References: <20241003152910.3287259-1-vincenzo.frascino@arm.com>
 <20241003152910.3287259-3-vincenzo.frascino@arm.com> <87wmihr49g.ffs@tglx>
 <87ttdlr3s5.ffs@tglx>
Date: Thu, 10 Oct 2024 10:58:31 +1100
Message-ID: <878quw7rrs.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Gleixner <tglx@linutronix.de> writes:
> On Wed, Oct 09 2024 at 11:53, Thomas Gleixner wrote:
>> On Thu, Oct 03 2024 at 16:29, Vincenzo Frascino wrote:
>
> Hit send too early.
>
>>> +#if defined(CONFIG_PHYS_ADDR_T_64BIT)
>>> +#define PAGE_MASK	(~((1 << CONFIG_PAGE_SHIFT) - 1))
>
> This really wants a comment. The magic reliance on integer sign
> expansion is any thing than obvious.

+1

Vincenzo feel free to take/modify the one from arch/powerpc/include/asm/page.h :)

cheers

