Return-Path: <linux-arch+bounces-8779-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666459B9F2F
	for <lists+linux-arch@lfdr.de>; Sat,  2 Nov 2024 12:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA382823BB
	for <lists+linux-arch@lfdr.de>; Sat,  2 Nov 2024 11:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC4A1714A8;
	Sat,  2 Nov 2024 11:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="ZL/lvV/0"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7B012C54B;
	Sat,  2 Nov 2024 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730545744; cv=none; b=aOqg8bwckBTUdI8RAOKOtAMcOqcDRDwtV/O/6TMZYalVLOJ5jsk61/Mez8jRGJsdicKSwo4JcuXTmda00Ygd+XLHHPQ+9kaXjWhFYweDfY+v/6vPDTjaEipQshFoY6miiRQ4AjMx7ANE7KfjW2V/58wAGJF3J++vEZglK2R7+iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730545744; c=relaxed/simple;
	bh=nclp+VCdHg8h8aYCzOEelCHk0hT48pCQRPeUZOubgD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFaj1HbEeGZ3O+s6PK/ZB1EHES5ZJ4hHgu+Ey/T1glfadREHytred3Y5+wfCMMqGqM98lcxuIdOhiD8CvKB6GkeydMBYpZZobS4lvpL39Ip4rXsHMUh5e8XqrV8STe2+HjtCfgtLLuZfSjcIGh8fWGCPhCE12qcMqen4LzdjWm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=ZL/lvV/0; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rJjP7GEhm9Yido8/2Yi7Kg/9NXfC12+1Hc68o0sqeZo=; b=ZL/lvV/0NG+jnrygJ/ulUipBlK
	qP9nNwqVQWNXM6Mo4bBB3wTvXS6oRzgEKSHf55UXhXhzl6CQWDcLaKiJVFPLfJWGDYzgQucVtLoXu
	EdgtwDpESedu90LNlQ/3ESKbF6ZllB13v5NTAUox4RYWGiwG0gPbhcB9nhH9k15mZ/+NFfBDzBZhT
	ZXkVWdsMEUU+MuBkn0bvppo0elNwSfGET6JHSBcIK+uM55LY9FOpzK7dAKO7wfzB9TVAXeFIWaCKY
	of25XbcMJoe7WP1/TZrB8M9THZkyGx/lpgRJ1Zogfa/NIqKJhYAzvuJg9eOUYUwS6oN1RCWC7zQ1Z
	rIC9NpXA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1t7Bzn-00DyOZ-3A;
	Sat, 02 Nov 2024 19:08:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 02 Nov 2024 19:08:43 +0800
Date: Sat, 2 Nov 2024 19:08:43 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v2 04/18] crypto: crc32 - don't unnecessarily register
 arch algorithms
Message-ID: <ZyYIO6RpjTFteaxH@gondor.apana.org.au>
References: <20241026040958.GA34351@sol.localdomain>
 <ZyX0uGHg4Cmsk2oz@gondor.apana.org.au>
 <CAMj1kXFfPtO0vd1KqTa+QNSkRWNR7SUJ_A_zX6-Hz5HVLtLYtw@mail.gmail.com>
 <ZyX8yEqnjXjJ5itO@gondor.apana.org.au>
 <CAMj1kXHje-BwJVffAxN9G96Gy4Gom3Ca7dJ-_K7sgcrz7_k7Kw@mail.gmail.com>
 <CAMj1kXG8Nqw_f8OsFTq_UKRbca6w58g4uyRAZXCoCr=OwC2sWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG8Nqw_f8OsFTq_UKRbca6w58g4uyRAZXCoCr=OwC2sWA@mail.gmail.com>

On Sat, Nov 02, 2024 at 12:05:01PM +0100, Ard Biesheuvel wrote:
>
> The only issue resulting from *not* taking this patch is that btrfs
> may misidentify the CRC32 implementation as being 'slow' and take an
> alternative code path, which does not necessarily result in worse
> performance.

If we were removing crc32* (or at least crc32*-arch) from the Crypto
API then these patches would be redundant.  But if we're keeping them
because btrfs uses them then we should definitely make crc32*-arch
do the right thing.  IOW they should not be registered if they're
the same as crc32*-generic.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

