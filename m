Return-Path: <linux-arch+bounces-9141-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5249D9D2D10
	for <lists+linux-arch@lfdr.de>; Tue, 19 Nov 2024 18:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002441F22BBE
	for <lists+linux-arch@lfdr.de>; Tue, 19 Nov 2024 17:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A13F1D1F79;
	Tue, 19 Nov 2024 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgq5vDPY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EC91D1E6C;
	Tue, 19 Nov 2024 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038809; cv=none; b=V+FoyqNhsJQX+//pHpyRT+ULrW+tn5Yh4uvzTqxRsNwCVQ7AROAA9jBLlhK+IUspN0zPAsqGdUIaR9PdtZ9OsEEF5upQXkIGrVtN6veSEJpoJTg8i96Mpr8lXf9OIR4izFW+Kh13o+8S/p4b420zeiS/FPutL3oeO9ytaVTjr6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038809; c=relaxed/simple;
	bh=xHBKbFoZ07Ku7Y6Que2kbEg3CxhDB6sSiE/pmczIBCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhkJu1iUobtCULRYlk7EibPmYBXwUq2eEajGQyfv6UJ2ayQ67rW9ScuX0gemgif7v0MbXsSveDS1Z9lEDNpv5lZQPYPwTd/wPB2iW5AwD5bZ5XaL3ajSGtM04vLZjyDhoUgg2OArx/2jtclRTptnDigvWdFNf4uPs6cQ5rhh39c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgq5vDPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A786C4CECF;
	Tue, 19 Nov 2024 17:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732038807;
	bh=xHBKbFoZ07Ku7Y6Que2kbEg3CxhDB6sSiE/pmczIBCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgq5vDPYfQEAp9QcRlppUahsKWsHleIu2nooD2vWUTECini7qwskFf71OtQlAgHob
	 VgwbxcfTrGcj6SaEE0IA3KEVSJVN8o4buBI87cUyTlsrNa829jFX3FU+5LZ4z9dhQq
	 q6cDXdYeeLPq+875LdXusF+1Tdk/dUSpHerioqelqy+4g0QhpIBJX399a7cdJLXkZD
	 6pgVXWvXdZzIwmUu3NbsF9WYzW1YemgHn9pcK3UbbCT0WEWvTXNFg7dC+guUY8i+xq
	 PXnxAuCla2s+P3m8m0/Vmg800NCXq6a16c5ZNJy6umQgOI/GxDr2MKprgwfgns6Q7i
	 /E/BHKcA5Fe2A==
Date: Tue, 19 Nov 2024 17:53:25 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Zhihang Shao <zhihang.shao.iscas@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 00/11] Wire up CRC-T10DIF library functions to
 arch-optimized code
Message-ID: <20241119175325.GB3833976@google.com>
References: <20241117002244.105200-1-ebiggers@kernel.org>
 <860a6acc-2c39-4eb1-8113-a3753f6531fc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <860a6acc-2c39-4eb1-8113-a3753f6531fc@gmail.com>

Hi Zhihang,

On Tue, Nov 19, 2024 at 06:05:58PM +0800, Zhihang Shao wrote:
> 
> I still want to submit an optimization patchabout CRC-T10DIFfor RISC-V.
> 
> I don't know if it would be more appropriate for me to rewrite a patch after
> your patch is officially applied.
> 
> What do you think?

Please go ahead and rebase your patch on top of this patchset, i.e. on top of
the git branch I gave at the beginning of the cover letter.  You'll need to move
your code into arch/riscv/lib/ and drop the shash stuff.  You can test it using
the new KUnit test I added (CONFIG_CRC_KUNIT_TEST=y).

After that I'll be glad to apply your patch when I apply this patchset for 6.14.

Thanks!

- Eric

