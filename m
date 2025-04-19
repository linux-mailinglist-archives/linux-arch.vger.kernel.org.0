Return-Path: <linux-arch+bounces-11460-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 391EDA9410B
	for <lists+linux-arch@lfdr.de>; Sat, 19 Apr 2025 04:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6304F8A4D68
	for <lists+linux-arch@lfdr.de>; Sat, 19 Apr 2025 02:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AB81C6B4;
	Sat, 19 Apr 2025 02:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="rmQd0n5F"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A2E5CB8;
	Sat, 19 Apr 2025 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745030466; cv=none; b=V8SSRkrIFrOCw7E0jmJc0cd9RVGGjzj7Icw5pEm3AB16B+N4ASncYWY0spz+wpiT7eUEEN24b8o+WNVqIRMnz1nqwCsSLXwL/5Rgnp+Jm3sMJKvsJTW7wGxEHEuPf/bR9Q5CdcPat3b2quGfP9WuLDC6QtC/xS7u/i6Ssb31/1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745030466; c=relaxed/simple;
	bh=zJ1i0szTujFfqZn7VlvO1q7cBVSlvqSyecXXOuogdHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9wakLmMMijnCydMuQKD7MjIfhyZ2AdQ8XOYRv9AUvxf//h9K6caETYHA1MKpbfUzFlNH/ehMvxudd/rod4vaK2j++rA1tYhuZ73tzebft3PS0jClgqBFL+nc5cmI7XJB7hUocJPGZEvbsiPGUjniCOOslQooWwgltSc9bBqRH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=rmQd0n5F; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=N71ulJFC7EzRy4IJC7JSkf+9aBSGBV5BXmKIuPUJx7U=; b=rmQd0n5Ffd7wgXc5CRfMsYvfej
	vy0M0uiUROHxK3PxU1ELCUZ55bqRS7IKOzdkIx2x/h3kf6i7ueq2uF2iXk+esRyER676Vn8nn6HPl
	/EUIRrt1qKRpgU7dPHA+0/rAdhZq8SqQqgwdPs18fXqmj5Vc6DfqBTMqCH2VeKeOqjtpsk1uVQdTB
	7C97E7AWZ+VRMuouNeTm66I/v/5mhb++Kjp8acKAz23ZX1T1sTBZddTZjuWyEHiOyEpxbSEZiqzYd
	8FLG2KSwbrYBgiH88lXTv2vFiWUXkF2HqN7hW+YAXzbLMgU3rYK+eiYH+SBvpg8M1ru6r24TM8ix6
	GC1QefCQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u5y8W-00Gtuw-1E;
	Sat, 19 Apr 2025 10:40:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 19 Apr 2025 10:40:56 +0800
Date: Sat, 19 Apr 2025 10:40:56 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	x86@kernel.org, Jason@zx2c4.com, ardb@kernel.org
Subject: Re: [PATCH 01/15] crypto: arm - remove CRYPTO dependency of library
 functions
Message-ID: <aAMNOJa-xcxLrmgX@gondor.apana.org.au>
References: <20250417182623.67808-2-ebiggers@kernel.org>
 <aAHDIRlSNLsYYZmW@gondor.apana.org.au>
 <20250418033236.GB38960@quark.localdomain>
 <aAHJRszwcQ4UyQ2e@gondor.apana.org.au>
 <20250418040931.GD38960@quark.localdomain>
 <aAIMhLD3UMM41JkT@gondor.apana.org.au>
 <20250418150149.GB1890@quark.localdomain>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418150149.GB1890@quark.localdomain>

On Fri, Apr 18, 2025 at 08:01:49AM -0700, Eric Biggers wrote:
>
> Doing it as a follow-up when this series hasn't been merged yet would be kind of
> silly, since it would undo a lot of this series.  I'll just send out a v2 of
> this series.

OK that's fine too of course.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

