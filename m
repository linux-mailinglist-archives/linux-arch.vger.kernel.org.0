Return-Path: <linux-arch+bounces-11634-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9C4A9E33A
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 15:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2311898F48
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 13:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D10153BD9;
	Sun, 27 Apr 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Js5eBBxo"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A71714D428;
	Sun, 27 Apr 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745759493; cv=none; b=MDOG15CH2SzoDighq2w+KaQ+a6G7bGVurvCxox/SAqfcPQ/w9CffGT7p+xkkxkEdLrvIFloWv3bqM2BMqX9whI0Ht5TiK6vCBee/jfBXOGiUEMhQyZAPo7Jb7OS97rmpToP3xbNBWTJc8ZeXJrkBA6qxRNYUnAcZ9P/gZ/i+QeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745759493; c=relaxed/simple;
	bh=hIg9xiL1wTkWBQvd+WTVpN2UA7enXw1novSCVk6FraQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O05llTusSEKQ01B6aQKVYvFTNAC/3+ILXeUPzeRUPaD40q9R/fHrNKNKPz1fTByoRKIfnQLMmPIw5Qf5VuZ7E2+S0q4vB6BozN5qF6J0CiEje7ARBXrhJE7FGO9w42uhgYXXVvErC1LRxwgjKSQ4JfT/oSWdgZQgfbmjpLPLW50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Js5eBBxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8414C4CEE3;
	Sun, 27 Apr 2025 13:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745759493;
	bh=hIg9xiL1wTkWBQvd+WTVpN2UA7enXw1novSCVk6FraQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Js5eBBxoHlcS56/LWyr45u7eRowNxoCYA6Md7I33bPaPRQLs3baLIHPlyTp0csghf
	 mNCXTEbu1yNMtMOT7JTf854tXYRVvArrq3HZEnVUBQlFqylkwky2LSYaFxEK8/Kw5X
	 Z/AcD9AseJYp4rgJMRwQ8XY9rmHzUm+sI/ac4vuLvW0OU9Ii9N2xfO9Puzy+QkAVof
	 Nyn3ibUt23OszHmj1FWPHbibu4rE+VmW/6hBdidH2RcSqJWI7TquPP9TueEjIP/oSw
	 /d5OvCZ/JlLLJjOP3DLWAlgxyVxgFiRpBDxeOK061Pq27N2K0t8Z0HoPDa2VNsTeb+
	 FuI4gqQiU6ppA==
Date: Sun, 27 Apr 2025 06:11:38 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
	x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld " <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [v2 PATCH 00/13] Architecture-optimized SHA-256 library API
Message-ID: <20250427131138.GC1161@quark>
References: <cover.1745734678.git.herbert@gondor.apana.org.au>
 <20250427123514.GA1161@quark>
 <aA4mAlozk3RvxvTe@gondor.apana.org.au>
 <20250427125641.GB1161@quark>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427125641.GB1161@quark>

On Sun, Apr 27, 2025 at 05:56:43AM -0700, Eric Biggers wrote:
> On Sun, Apr 27, 2025 at 08:41:38PM +0800, Herbert Xu wrote:
> > On Sun, Apr 27, 2025 at 05:35:14AM -0700, Eric Biggers wrote:
> > >
> > > Well, barely a day and you've already ruined my patch series.  Now instead of a
> > > clean design where the crypto_shash API is built on top of the normal library
> > > API (sha256_update() etc.), there's now a special low-level API
> > > "sha256_choose_blocks()" just for shash that it's built on top of instead, for
> > > no good reason.  You're also still pushing your broken BLOCK_HASH_UPDATE_BLOCKS
> > > macro that doesn't work with size_t, and putting my name on your broken code
> > > that uses it.
> > 
> > Your design is unacceptable because you're forcing the partial block
> > handling on shash where it's not needed,
> 
> Excuse me?  It's the other way around.  In my version the partial block handling
> is only in the library, not shash.  In your version you've forced it into the
> shash layer, even though the library does it already.  I understand that you've
> added support for partial block handling to crypto/shash.c and you want to feel
> like your work is useful, but in this case it's not, since the libray has to
> handle arbitrary-length inputs anyway.
> 
> > just as you're forcing the hardirq support on everything.
> 
> If you want crypto_shash to warn on hardirq usage you should just put a
> WARN_ON(in_hardirq()) in crypto_shash_*(), which will actually achieve that.
> Not add a shash-specific non-hardirq-safe low-level API to the library that can
> silently corrupt random tasks' SIMD registers on production systems.

By the way, as I mentioned in my cover letter:

    For now the SHA-256 library is well-covered by the crypto_shash
    self-tests, but I plan to add a test for the library directly later.

But due to your gratuitous changes where crypto_shash is no longer built on top
of the normal SHA-256 library API, that's no longer the case.

So while I do still plan to add a SHA-256 library test anyway, I don't see the
reason for not also making crypto_shash just do the right thing.

- Eric

