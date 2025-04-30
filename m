Return-Path: <linux-arch+bounces-11752-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223D2AA4112
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 04:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F64A466249
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 02:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF001C5F2C;
	Wed, 30 Apr 2025 02:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="slhfLJxH"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E516288CC;
	Wed, 30 Apr 2025 02:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745981048; cv=none; b=o131H/w1nK7tUlYAH7ZPzrXvk9Rjbl9uedRsNlnluIPh5YWlJlCjiV1t1fa3CQIMcBPU369E9UQHwbMbD319VpyKcoeTQRrlghlvyluULJa6fXhR2FRMmu3ZasMV6Nqerpnt6syGhA9w5IhPYz2DdlFhe+4STp3gzBGZ1ZaclMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745981048; c=relaxed/simple;
	bh=ZH8vXkEAnQXMIA7Jipu3JJx8Fr/AAiDgW97m9wY7+pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cqr6Gp1Vy24HtmZQg/bMDpFHbcA8DIkCBwPC5YepRMQZBoXX2yzmqWrwctTLcvpzj6WSmwZFmWQGZ0S0eIQgdl+db3/L0VVuIqvM/qqFGuxsjlzzBkB018/QBcpxHv8tsfgJA4g3ihEIEJngPAkYXAejkSO74S0OX2oHdFo1uoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=slhfLJxH; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=m9QkBZZevuauHxVFsy3Xp8pLr99dnXjzdN0XHxuFEuE=; b=slhfLJxHOtOfQ65Qhl8JSbPCcb
	XqkmyPT58SSpWJ7pD9KS7SxPajdJZ4dHGDlXKtXsR8gTS6XQAFgAP6ZYpFU3rKnoW0/9byyYAwJ/R
	GD8f4Zg1TqF0P+e9AlHd9q6ggqDu+W9ZGp/7BGKVyH2/DYezWwEWFFHvPjZcG89v4s+4o/5l4DTdz
	uzFd2vqfrtvbZbuCXjHrgZ39HSV2EJU71upABqo3N09RZ1o6SSudTUB2KoCSfytn0eM8ufQZC7TW2
	SvSbDJ9gOEk9vkgraa8eIcRuXVysE5xkBgpzhM8QKW8NjaqdOEP80zLQHXmMTMUbtTJecf2EHL+D6
	4WxmKkyA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u9xQU-0028z1-2i;
	Wed, 30 Apr 2025 10:43:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 30 Apr 2025 10:43:58 +0800
Date: Wed, 30 Apr 2025 10:43:58 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
	x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld " <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [v3 PATCH 00/13] Architecture-optimized SHA-256 library API
Message-ID: <aBGObifCORhrBXz1@gondor.apana.org.au>
References: <cover.1745816372.git.herbert@gondor.apana.org.au>
 <20250429165749.GC1743@sol.localdomain>
 <aBGKg5bq0zLkhy3-@gondor.apana.org.au>
 <20250430023849.GA275186@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430023849.GA275186@sol.localdomain>

On Tue, Apr 29, 2025 at 07:38:49PM -0700, Eric Biggers wrote:
>
> Nothing requires that the export formats be consistent, but also the fact that
> padlock-sha uses a weird format in the first place is an artificial problem that
> you introduced just a couple weeks ago.  And even if we *must* use the same
> format as padlock-sha, that can be done by using your crypto_sha256_export_lib
> and crypto_sha256_import_lib, without all your other changes.

That was just the reason of why I can't take your first patch as
is and then add my changes as incremental patches.

I do still want to bypass the partial block handling in lib/crypto.

But alright I will do it like this:

Patch 1 is just your existing patch + my export/import functions.

Then I will add the rest of my changes as incremental patches.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

