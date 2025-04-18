Return-Path: <linux-arch+bounces-11447-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF35A930EB
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 05:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E4527AFD90
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 03:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8E1267AEB;
	Fri, 18 Apr 2025 03:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="MWds7QQ5"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C9F1E4AB;
	Fri, 18 Apr 2025 03:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744947566; cv=none; b=IOSxR8kpm/ouZEKF9nBXGStAvjoIO2F7Lo9EB4PTUhRcv4lboMYEJgQDCiqN5/wDL9J550aG5EUxkzyTrRBPQIST34hXOCGSEm+lw1i7qWX1noRDI1IkPahrDUWJmAh7GPKl2SfV46in0ri7bA9TSh+av/h166BFl2kL4KMDf78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744947566; c=relaxed/simple;
	bh=FiLwTV4w5vG6lrJ0MGvhyx0sTo6O6zakxWVpGMyNPNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5ka6F+vGQoAHPN28szS+EotqrBkC1IEmBf+OKvqQLjcGzsvBTiuTCWhjKUBk3WekzR/SqjgV8EM5Nn6cgyzlIGOpw/BZORk/1ejHNNU8r010umNYey+wFFY23bAj23mrBYnjxQOEUVHnyqPLZ1iEmn4HM0yBAIayuXzujndn8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=MWds7QQ5; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ypo01vEghGy27nPQeItYqzxY2hP/jSSCN3P/bWLwnyg=; b=MWds7QQ5JPbuMv2nNP62mZrmbF
	Bq+va6ic3n9cE4To97pskQEOiYEgsVK/Xh8YuuAOKuIIID1z2Vq3HbZxQR+CYja/g25SPlAkVRUl+
	H9u9EF0MzbL5Mi8IsgXzItMNafiBhN+YDzET3Y9HViK1SEU7axHGeYqC9LhSPKWfG7EfR+Nvr10pf
	3g47jJR3eiFrDSksGYzS1b0S2RXn9rrEZ0+/URVOKCvjVfjHiqO3FGvkTbRRop+Bjj9y62pQPQXVh
	sey566NEI3Y5b5FUM0KMzQX/NoqvpplvIJxlE3X8eh9UpsQuZaJN/320owLJMMOldzgO3/MGmbseG
	rBqKJH2Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u5cZU-00Gejm-1k;
	Fri, 18 Apr 2025 11:39:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Apr 2025 11:39:20 +0800
Date: Fri, 18 Apr 2025 11:39:20 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	x86@kernel.org, Jason@zx2c4.com, ardb@kernel.org,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH 01/15] crypto: arm - remove CRYPTO dependency of library
 functions
Message-ID: <aAHJaH69Ngr0Ojh2@gondor.apana.org.au>
References: <20250417182623.67808-2-ebiggers@kernel.org>
 <aAHCIL_sYIS_1JQH@gondor.apana.org.au>
 <20250418032845.GA38960@quark.localdomain>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418032845.GA38960@quark.localdomain>

On Thu, Apr 17, 2025 at 08:28:45PM -0700, Eric Biggers wrote:
>
> Only x86 and s390 support KMSAN.

OK that's subtle but I'm glad it's not an issue.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

