Return-Path: <linux-arch+bounces-11615-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC094A9DE9A
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 04:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7695B7A7B3F
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 02:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5041F78F2;
	Sun, 27 Apr 2025 02:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="bL/C1Qcv"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B541DE4C8;
	Sun, 27 Apr 2025 02:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745719748; cv=none; b=lt3aUEvcwjVPk0PGZuvELOzFTM65jmOy2ejvWFhciq4Bog1TjaT/H8dnT89T9ko0QBNt5ZdacT/GVuK61qH37kwwegrqZ+NrU024h/sFQIJKX6fTzOeO2nux94mWoxogpWpUWXEyx/VrZG768rppVnm+lNVkAe/gTqoj0f3Yaac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745719748; c=relaxed/simple;
	bh=IkDhm/b3MVpQQ+omlOa9k0KNQHFp5h3F+Lfrp6VFaJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/iK0F3k63qECGcOdTopcypzZZF0omfMZBhd+o1mek5UO3p137/K6E6O1OT/hLiMRw3RXv6a09JFebVtYEQClTY9Kujb3m1YgsNlMODsaRyZVPND5RFaLHrseuuSVZa+HbQgdL2G0Aa34a4d+MPFtPg3agGHmR7aoC25ypOVMeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=bL/C1Qcv; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mCSGe0hd9nC0wheXB+gSEHvBf5j2sNZqM+duHcgxviI=; b=bL/C1Qcvgn5BWiPkJ27+dJ7Es8
	wwSoSEMzq4YcvjJsWSmMepkvcU0C+LR+JcK4d4+iSMjdzlqhOGHE3AF2kMOhQHHx5zatXSJemRQUa
	+4h6wO0WkFQUX9WdKq6GRaJ9/mZ17PlsiqC0wdJhCc9trhF25UN90ckF1QyCHeZRx0n89B0uSwkLG
	uUSof0rmZhN5waLKmnv8FlDyjrKsMtYRIDRqFgglTsQWEPgcKsVVxKbPbA5yOE0L7Ivk2Ohmjs+Gm
	LWKBoqlKkfHG+z5IZWuBDTy+jUSYT0zXWKQ2YQGCxsKc4gNCr1zLOsKj79gKZojc877uD54ab34ip
	84RfoZpA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u8rRz-001Jud-1b;
	Sun, 27 Apr 2025 10:09:00 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 27 Apr 2025 10:08:59 +0800
Date: Sun, 27 Apr 2025 10:08:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
	linux-s390@vger.kernel.org, x86@kernel.org, ardb@kernel.org,
	Jason@zx2c4.com, torvalds@linux-foundation.org
Subject: Re: [PATCH 01/13] crypto: sha256 - support arch-optimized lib and
 expose through shash
Message-ID: <aA2Ru1SHXRB-ZAc3@gondor.apana.org.au>
References: <20250426065041.1551914-2-ebiggers@kernel.org>
 <aA2DKzOh8xhCYY8C@gondor.apana.org.au>
 <20250427011228.GC68006@quark>
 <aA2FqGSHWNO8cRLD@gondor.apana.org.au>
 <20250427015041.GF68006@quark>
 <aA2N6oJ9fQYQUtD4@gondor.apana.org.au>
 <20250427020550.GG68006@quark>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427020550.GG68006@quark>

On Sat, Apr 26, 2025 at 07:05:50PM -0700, Eric Biggers wrote:
>
> Why?  And how is that relevant here, when the export format should just be

Because I want to be able to fall back from an ahash to shash in
the middle of a hash, i.e., I need to be able to export from the
ahash, import it into an shash, and then continue hashing.

> struct sha256_state, as it was before?

Because I've already changed the shash export format to use a
generic partial buffer for all algorithms and it's not the same
as struct sha256_state.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

