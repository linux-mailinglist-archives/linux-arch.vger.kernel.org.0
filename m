Return-Path: <linux-arch+bounces-11601-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA34A9DA39
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 12:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B401F16ED71
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 10:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4A521883E;
	Sat, 26 Apr 2025 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="FQPHHqJJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4097E9;
	Sat, 26 Apr 2025 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745664661; cv=none; b=kDY+PMGu6SxxQUFRr4/9J/ai/hFa9miFZxqGRFu3DSB1/PArTwT/6yXX9aAbfOpriFs4+5Jz8UPDwQ6Hozb+LG/91UXRqXPTNhCFzakBuGjMzOAGM3bimaEc37OCa5RJeNKCAeoeOYqFoeY3O8UT5Bti5ojSJQgaqOcriaCLXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745664661; c=relaxed/simple;
	bh=82EFHgsGXct3Xlo/vKGQ90HR3hnzp19zozeQ27cd++k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=efuxm+UOq8iya7xWujOuZVoQ5zja293Qve9Eq20UNaKbwbixqxb+foOr7D9K3ZOaHQ3JqFZkvY8iW8DRw4qbUlPxG71qqtjrfgGmea7Jl1vmzZ+nAsU26Dgx0TF7MUYC2Gn+yAD8nerA+MxPyBPozbYoVwPCKWlAanXEyaHDUs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=FQPHHqJJ; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r/BRgULQpLgk5YaJQHiFfQ2T48zm7WZ1sUrce8geWiQ=; b=FQPHHqJJ4Yp8xo1uAdrbIDyO/e
	+BeauuZagD3c6w+tzPWasqnF44Xz1u41rfxeZt31BrsWb4sbITdmFC5S4/OrY8vhIvTZ/a5BNLm33
	ZkQr1v5nqim7o3ovlQFYoK0XcuQ3ntQUG6T5hc7E23aM0Igezsg2g1BRcr1VXpv1uiU1P5G9RMIsY
	Z0BBvdThrLHvb9tbmeMgnNIMXxWEI/MvsANPU2DsWSqlTcfSIt+mlLeo5b6AJh4I6ZEq1l0nSLHaN
	hTnppKLHw5w4hLDrM6g2raOMJ8TIQa14U85c3jGYzRtS02nib6cJdDcxF0CYxwfHa5ahLdr03R7Mb
	0oUSHsgA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u8d7L-001CiC-1a;
	Sat, 26 Apr 2025 18:50:44 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 26 Apr 2025 18:50:43 +0800
Date: Sat, 26 Apr 2025 18:50:43 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
	linux-s390@vger.kernel.org, x86@kernel.org, ardb@kernel.org,
	Jason@zx2c4.com, torvalds@linux-foundation.org
Subject: Re: [PATCH 11/13] crypto: x86/sha256 - implement library instead of
 shash
Message-ID: <aAy6g3nblKtRj1l3@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426065041.1551914-12-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel

Eric Biggers <ebiggers@kernel.org> wrote:
>
> +void sha256_blocks_arch(u32 state[SHA256_STATE_WORDS],
> +                       const u8 *data, size_t nblocks)
> +{
> +       if (static_branch_likely(&have_sha256_x86) && crypto_simd_usable()) {
> +               kernel_fpu_begin();
> +               static_call(sha256_blocks_x86)(state, data, nblocks);
> +               kernel_fpu_end();
> +       } else {
> +               sha256_blocks_generic(state, data, nblocks);
> +       }

Why did you restore the SIMD fallback path? Please provide a real
use-case for doing SHA2 in a hardirq or I'll just remove it again.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

