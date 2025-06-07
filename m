Return-Path: <linux-arch+bounces-12280-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB76AD1076
	for <lists+linux-arch@lfdr.de>; Sun,  8 Jun 2025 01:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B541C16BE49
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 23:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E8F25CC6E;
	Sat,  7 Jun 2025 23:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jsPgU/cc"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFF8219A95;
	Sat,  7 Jun 2025 23:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749340029; cv=none; b=K5kGQFJ9238INzLdGDjLe9LuPx32GggC7b1+1/lfDapEikW86Qya6cQHmCtfWzkQoyAIsVS7x1B5dKhne4Uc616fBjf+ECk1FraGHBNGyay5oFB5ZQrIcykO3s4sOAOMtrkwUNMF+ig2hRPKlZRkuOI507Tc1G92AcqubIl/ms8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749340029; c=relaxed/simple;
	bh=LLYBi6lLM9yrrhCbb5rR61lngl1sYzAS5pqk0JZQ3I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUpe3PYSdQhbTmbYCTae+0v7gRWNjAYmt46+BbQwm3yYJkRYGF4gqBcnQU4s4hAmaSMazds1vLrNItY4G/73iL1m1nBuRND8EsH5Gnag+mwK+VVgu99pkWfp3v6rFpExXZLRzXYvo0+nx+RmdxGixK5ZYbEXp7IOMi88kzF5yGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=jsPgU/cc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE6DC4CEE4;
	Sat,  7 Jun 2025 23:47:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jsPgU/cc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1749340025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9BLd3zVhm1uyr2zWfOpGUqAHdfaRE3TGpoHRN6aaMSk=;
	b=jsPgU/ccygnXS60vh3VCJ8IeDnGtsomv+dciNUeunJ0SO8LqmCcTqPcJBkB2QFrLru1ll1
	E9OF1lkNEqMRShrw2za9BAoJsJQKmF9rvzmtd3v/rLI1EduGNSPRtry+Kyl+tncxIkS+aK
	UrU1VhYkP4pcQtnNoKmPvrZIA/DIb6Q=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 669734c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 7 Jun 2025 23:47:04 +0000 (UTC)
Date: Sat, 7 Jun 2025 17:47:02 -0600
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, x86@kernel.org,
	linux-arch@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 00/12] lib/crc: improve how arch-optimized code is
 integrated
Message-ID: <aETPdvg8qXv18MDu@zx2c4.com>
References: <20250607200454.73587-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250607200454.73587-1-ebiggers@kernel.org>

On Sat, Jun 07, 2025 at 01:04:42PM -0700, Eric Biggers wrote:
> Having arch-specific code outside arch/ was somewhat controversial when
> Zinc proposed it back in 2018.  But I don't think the concerns are
> warranted.  It's better from a technical perspective, as it enables the
> improvements mentioned above.  This model is already successfully used
> in other places in the kernel such as lib/raid6/.  The community of each
> architecture still remains free to work on the code, even if it's not in
> arch/.  At the time there was also a desire to put the library code in
> the same files as the old-school crypto API, but that was a mistake; now
> that the library is separate, that's no longer a constraint either.

I can't express how happy I am to see this revived. It's clearly the
right way forward and makes it a lot simpler for us to dispatch to
various arch implementations and also is organizationally simpler.

Jason

