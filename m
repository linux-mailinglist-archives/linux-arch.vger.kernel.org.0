Return-Path: <linux-arch+bounces-11443-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14138A930AC
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 05:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B981E1B660F0
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 03:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F051267F52;
	Fri, 18 Apr 2025 03:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="lB9E6cNu"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38404267F61;
	Fri, 18 Apr 2025 03:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744945959; cv=none; b=rcEfor8l243IPoXY+mexYEFAVOfOIHFU9HEaQ3wOW/QadOTms6nB4HoZ3rpGBN/Zjzamj0p8JTzPV64FjkWs9I6DRIUjlGQmWzURKv2Nes61/b8zcbei6ZJk6R3h5FJlcX5NgGN41ez1sySpydX4CP4Zyt4kXzj4Y2rf9c37Cdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744945959; c=relaxed/simple;
	bh=4ex6FyLQ/Vb/QweVloEYl+7EtT2oyd+yA46KuHB2smE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=koJz5oBSKEUxhxT/MBiq/O8JKjA4WLneV0v9svdGtjFP8/URFxt3Gz/MwZPFh1uoj1yzrhRmkKkG9mL1T7XjGVpWBLHInWaZkXlXqQ3Kd/M5sOc2znaoOYFeGmDWcar3R6zzAHqcO6GiGjzeg+AjtO6yPAvAdAsKvg7IUCZUeqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=lB9E6cNu; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qq3IJ8JynJU7O/u61XzBFurm3qauuCX8QJaB8lmSmMc=; b=lB9E6cNuSpcyi+wIu4AqMWeil0
	alzcTCb8M0sQjC3ocdCcpRZ7ehcuXZCrNwyx1ktrooWWCIj9iFB6ayBnatRwq92K37AmhyCcFpXLM
	OR9e6IryCcw4t9lLbx+iOgIT/J6/Nf7SPfzVxH+nsHHDbyUlxK9gArH9xK0tEh68vW8tpZqshwV60
	srqfoeG+JXGqwaRw7MJ5peD3FZ4dVqaCTIk4WCfXtFicKq71IJL7/pd35ZfY6eJZdKDcfGOtNV+RZ
	uMoaQcAjSWR5DbCKLE+VpsD4RlHlZGjqodehTXvdjY2oZGusKWENmpVPPhYzvxILIptYXb2DLX0SE
	9vbdVKHg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u5c9Z-00GeXp-1B;
	Fri, 18 Apr 2025 11:12:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Apr 2025 11:12:33 +0800
Date: Fri, 18 Apr 2025 11:12:33 +0800
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
Message-ID: <aAHDIRlSNLsYYZmW@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417182623.67808-2-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel

Eric Biggers <ebiggers@kernel.org> wrote:
>
> config CRYPTO_CURVE25519_NEON
>        tristate
> -       depends on KERNEL_MODE_NEON
> +       depends on CRYPTO && KERNEL_MODE_NEON

Rather than adding CRYPTO to each symbol, how about grouping all
the CRYPTO symbols together under one if statement?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

