Return-Path: <linux-arch+bounces-7896-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BD4996617
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 11:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707231F236DC
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 09:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1371F1917C7;
	Wed,  9 Oct 2024 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wTv2PEY2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xfV2vvxK"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F921191473;
	Wed,  9 Oct 2024 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467632; cv=none; b=diIiPFm1/dkqhyCGjcBMKghGUs1Sishrz0fd28aFnwUaFN/MAWp/ILCcLaYPvewtZV1FoYlX+LgdDzVeZ9qNdHV7RCKcplBSeV9CL4ClhJoDDMYkDRTJecOoycol17isoIQ16jOVKrk9EYDjumN5kmKMagIqhjmG0c932oueFfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467632; c=relaxed/simple;
	bh=APXoPI3sAa0KzUuaFaTkeExBRaD6Rs7QrzhV8+V+BWI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h1qbVObNG06hIukyQ3R7BfTkLsiNasBnYRPOY228QP5yna5w4oBYmnOuR5ih8dwqf3EXx0RL+l0vj7EcanZCxVf1+P+2G0PwKLV6gTQbaa22wCHW8JGlUL7sOIXtNWvixfUaRPCm5ne1SLDDgdwo4HOVM6Cc023ujBSP2bJTdcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wTv2PEY2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xfV2vvxK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728467628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V6wmZgNbeW2JvNpgS3a2aAd/BziZrZJXCOv9QKhyUbc=;
	b=wTv2PEY2kWMLaAJKXKiBpf9A5u9zDq+2sj7mN3+o5DZzQXNoig2aWKyM9WUX6vo1MMwo4m
	JZVwAc5nAGBXC43dXPfUj1ciKSZPvpAvpH5eFOxpRy1cxdUAh1qHX1nPeMiWtaPYqB0l5m
	BOAd7tAFfY48yqstgeQZv1zSU8BiVaRhefAneA/3rfdFXKGqY7MzNNRdBwdsP4nq/Ktlks
	uhQzW0aOiPFdgdQg3+k5eu/cRsXQWsX/IfxyiqxViDThlm01uFvyGlT2OAqJtFQnoCq1es
	voVbesIDlGVMNXv/Sdlq0R/s4AE3Kg2hQ2Az8a9wSOJJKY+U++mUynZVc7gzpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728467628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V6wmZgNbeW2JvNpgS3a2aAd/BziZrZJXCOv9QKhyUbc=;
	b=xfV2vvxKqwHS3e2NZf+o4Ycj3Rylk+sm6QJKNHUG69+ZDGMo9G6Yy6aQV4AKWWDur5Dmz7
	4uVMoCJvvWoSNSDw==
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, Andy Lutomirski
 <luto@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter
 Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann
 <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3 2/2] vdso: Introduce vdso/page.h
In-Reply-To: <20241003152910.3287259-3-vincenzo.frascino@arm.com>
References: <20241003152910.3287259-1-vincenzo.frascino@arm.com>
 <20241003152910.3287259-3-vincenzo.frascino@arm.com>
Date: Wed, 09 Oct 2024 11:53:47 +0200
Message-ID: <87wmihr49g.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 03 2024 at 16:29, Vincenzo Frascino wrote:
> The VDSO implementation includes headers from outside of the
> vdso/ namespace.
>
> Introduce vdso/page.h to make sure that the generic library
> uses only the allowed namespace.
>
> Note: on a 32-bit architecture UL is an unsigned 32 bit long. Hence when
> it supports 64-bit phys_addr_t we might end up in situation in which
> the

We end up with nothing.

> top 32 bit are cleared. To prevent this issue this patch provides
> separate macros for PAGE_MASK.

'this patch' is redundant information.

git grep 'This patch' Documentation/process/

> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __VDSO_PAGE_H
> +#define __VDSO_PAGE_H
> +
> +#include <uapi/linux/const.h>
> +
> +/*
> + * PAGE_SHIFT determines the page size.
> + *
> + * Note: This definition is required because PAGE_SHIFT is used
> + * in several places throuout the codebase.
> + */
> +#define PAGE_SHIFT      CONFIG_PAGE_SHIFT
> +
> +#define PAGE_SIZE	(_AC(1,UL) << CONFIG_PAGE_SHIFT)
> +
> +#if defined(CONFIG_PHYS_ADDR_T_64BIT)
> +#define PAGE_MASK	(~((1 << CONFIG_PAGE_SHIFT) - 1))
> +#else
> +#define PAGE_MASK	(~(PAGE_SIZE-1))

#define PAGE_MASK	(~(PAGE_SIZE - 1))

please.

Thanks,

        tglx

