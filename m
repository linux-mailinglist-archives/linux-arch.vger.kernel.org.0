Return-Path: <linux-arch+bounces-6847-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA551966150
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 14:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6511C2389A
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 12:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B4B196D9D;
	Fri, 30 Aug 2024 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QGByS0V+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5453D192D79;
	Fri, 30 Aug 2024 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725019488; cv=none; b=ZO9ka/XSC9e0R22FCmw/egJpLDBUFQ13sWAwFMthw1t78W+j4dQE51FfCBNYHr4v77WaY6gtP0ZnKNJnBwoLLKQuX8Br9wr/6NgL60qaMlFB60IeFm0IcbEzCJWHbq4W1LXhLuD7pWIPt3HJ1S+w8lZyI2gyXsY50WI0bdZ62kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725019488; c=relaxed/simple;
	bh=8zkhsnrRmJglZ1xx/z1Ejoruoi6hMrCb82FeDSEj4z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXSAzAvNUoXvHoLHThjjhR8HQDuXPCJwhmB4Yaq3ehNBPutN8Izi+JZfsrv+Zfmsvlk5WpsXPMEolQ1HbXZ4k4VQBuxLv84QHxTvJTQaV01j0z8mx3NQcx2L+PEwrMgT6tyPr5hVRP9ufpl3CesczNrluv7K/FeTyARCfjZj7Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=QGByS0V+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15F0C4CEC2;
	Fri, 30 Aug 2024 12:04:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QGByS0V+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725019485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8KNtaBYw1xfEjRV2JBKbb5umlz7bXA1hHQfXl06/f4E=;
	b=QGByS0V+qPAy9oKrC/Kbxth3Sv+WWc1ru0JgdaVICM+CgTVUjcLWPC7kDJFMs32UVyJU6d
	pJrB7zn76C7L6Dmj86vFbw1F9xSrq8I8F9huTjnsfvdWdBZDPCMKFXmPsX7pD5n/AZEHDO
	Cxd6LDfIbc5g6tU0WtNGe6G+OcobtOA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b3ef1719 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 12:04:44 +0000 (UTC)
Date: Fri, 30 Aug 2024 14:04:39 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Will Deacon <will@kernel.org>
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, ardb@kernel.org
Subject: Re: [PATCH v2] aarch64: vdso: Wire up getrandom() vDSO implementation
Message-ID: <ZtG1V9me28OvU0Qu@zx2c4.com>
References: <20240829201728.2825-1-adhemerval.zanella@linaro.org>
 <20240830114645.GA8219@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240830114645.GA8219@willie-the-truck>

> > +SYM_FUNC_START(__arch_chacha20_blocks_nostack)
> 
> Is there any way we can reuse the existing code in
> crypto/chacha-neon-core.S for this? It looks to my untrained eye like
> this is an arbitrarily different implementation to what we already have.

Nope, it is indeed different, and not arbitrarily so. This patch is
mirroring exactly what we did on x86.

Jason

