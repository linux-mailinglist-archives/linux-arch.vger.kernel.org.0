Return-Path: <linux-arch+bounces-2118-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2757984DCDF
	for <lists+linux-arch@lfdr.de>; Thu,  8 Feb 2024 10:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07841F25DD0
	for <lists+linux-arch@lfdr.de>; Thu,  8 Feb 2024 09:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9CB6BFB8;
	Thu,  8 Feb 2024 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Mx730JTW"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22396BB49;
	Thu,  8 Feb 2024 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384219; cv=none; b=C9pIjx18rlLYRy64HYFnyACvYBkaR4tXpSih578Wkv7Pn+v3bFqO/hDMFQ2X/+9BLt3cD+Qc2EqEWrb3u3B5ytsKXjGU6cEcZQS3NXHs5PTOJeD53M9RcOaUU/SGlUNtIV64xJMZjCUv9a5RLSPAfp9zftc2VhyIoLUxCCgnCyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384219; c=relaxed/simple;
	bh=fnl17jHgJNcwIszysCdLjpjMhTABBL9VRXQDBQS7qQw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qmkcdOH3eczUdKwHolsI+S1UPfyIa0Or5euzhfstNdcRp7GPP9kpBsn3kz4hwWoWHaRp3gpIEhyHZszABWg/pNL5q0hQB0lsiaUw9uvMPf5vEv868etigXOGO2cTFabsDAE8qxPXSRWb6gGVfGyUVZds+bDSDPMNPgT3tMwQF8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Mx730JTW; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1707384209;
	bh=fnl17jHgJNcwIszysCdLjpjMhTABBL9VRXQDBQS7qQw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Mx730JTWcpjC6EEOjrl3nCvfMyqQk6d7jJHkViExyWYqy/IxM3zOswBLGObS35ltR
	 H2LWXuXC9x1TSoNZ9asVn0OJIeERVNJ+5lJwzFabAEOPtVdZf60AlpPuWPlsmhOXlP
	 4IoBKeeS578w+Y0w8LLeSLeRRfpYX+VzIFMnyfUk=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 4587166A3F;
	Thu,  8 Feb 2024 04:23:27 -0500 (EST)
Message-ID: <7636b9072f2b72f6079a65d456c561716c5d90a3.camel@xry111.site>
Subject: Re: [PATCH v2 0/3] Handle delay slot for extable lookup
From: Xi Ruoyao <xry111@xry111.site>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Oleg Nesterov <oleg@redhat.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Andrew Morton
 <akpm@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, Linus Torvalds
	 <torvalds@linux-foundation.org>
Date: Thu, 08 Feb 2024 17:23:24 +0800
In-Reply-To: <63a1738c-5755-4c2e-a4d4-f5047cdb3660@flygoat.com>
References: <20240202-exception_ip-v2-0-e6894d5ce705@flygoat.com>
	 <63a1738c-5755-4c2e-a4d4-f5047cdb3660@flygoat.com>
Autocrypt: addr=xry111@xry111.site; prefer-encrypt=mutual;
 keydata=mDMEYnkdPhYJKwYBBAHaRw8BAQdAsY+HvJs3EVKpwIu2gN89cQT/pnrbQtlvd6Yfq7egugi0HlhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPoiTBBMWCgA7FiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQrKrSDhnnEOPHFgD8D9vUToTd1MF5bng9uPJq5y3DfpcxDp+LD3joA3U2TmwA/jZtN9xLH7CGDHeClKZK/ZYELotWfJsqRcthOIGjsdAPuDgEYnkdPhIKKwYBBAGXVQEFAQEHQG+HnNiPZseiBkzYBHwq/nN638o0NPwgYwH70wlKMZhRAwEIB4h4BBgWCgAgFiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwwACgkQrKrSDhnnEOPjXgD/euD64cxwqDIqckUaisT3VCst11RcnO5iRHm6meNIwj0BALLmWplyi7beKrOlqKfuZtCLbiAPywGfCNg8LOTt4iMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-08 at 09:20 +0000, Jiaxun Yang wrote:
>=20
>=20
> =E5=9C=A8 2024/2/2 12:30, Jiaxun Yang =E5=86=99=E9=81=93:
> > Hi all,
> >=20
> > This series fixed extable handling for architecture delay slot (MIPS).
> >=20
> > Please see previous discussions at [1].
> >=20
> > There are some other places in kernel not handling delay slots properly=
,
> > such as uprobe and kgdb, I'll sort them later.
>=20
> A gentle ping :-)
>=20
> This series fixes a regression, perhaps it should go through fixes tree.

If you have Fixes: {sha} and Cc: stable@vger.kernel.org Greg will pick
it up once it's in Linus tree.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

