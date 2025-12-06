Return-Path: <linux-arch+bounces-15298-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A70CA9EB2
	for <lists+linux-arch@lfdr.de>; Sat, 06 Dec 2025 03:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7D123241986
	for <lists+linux-arch@lfdr.de>; Sat,  6 Dec 2025 02:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCF325C818;
	Sat,  6 Dec 2025 02:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="M7+aYeR7"
X-Original-To: linux-arch@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576FE258EE9;
	Sat,  6 Dec 2025 02:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764987997; cv=none; b=ih3IqLjAL3On85V/hrWKJVMJevdMOrzjtTL2oRQ14k1WrW/U3e6cakl8HN41FNmH4cPtKW9oBd6m4vZsx3JcPzNrs+qgzh6K4f2cZQ/dUFLWAB3p5gpR0MFkRNcFvK+jf7jDSOHZ9SolqEonejPV6lZeoVwLkh6N52CE5TWghA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764987997; c=relaxed/simple;
	bh=4YraZ21sr3pEy95zok5HC/hyqaMU3Jyx/mXxfjHFQH0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KECKCzaz8+XbMpqZEv9cLrEAagMbGBopPXJYK8VGVQ41GZal0sZYLYCGShBHSKemaUAcJSxT/r5ZEkqYNGvNo4P+Cq1OBMcSnZGJrs1rGueB0N1PJB/oRmc7+TD812d4FMawf5s3T0Cn3jyCGT2M4/0vjxaLQ6V9ZKJWpoa0rsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=M7+aYeR7; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4YraZ21sr3pEy95zok5HC/hyqaMU3Jyx/mXxfjHFQH0=; b=M7+aYeR7DGAortFobUdduH7USL
	LqdGydqLAv5JwVi6Z45lZw6tnqK6pZpUfN2NQ1TdRS9BDRO7ZJeff9FPq0dxgDtAt1d9TiZkh3TGL
	u6y/fMcbZi/MceBbe+isJywhaPpBCK/S+1Mqx+GB3qf1iE4AtxTaqWlNluJq4nbAtk2n1ONmZuAL6
	mWNsGo3ebZIJfkUX4UpMcaJjgGHUP5BMIOphaokkON24yOu9PUxA4uxAbsABd4wdcQbs9IZXt/41p
	TotVDCa9I4va5CrG2V5d4Yk/Pm3kcEm89iCBYnwB1aiGX4i55xbx4mun1YvgielcqcAy039yAekuX
	An+kvVsQ==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1vRhzu-000000005aL-3EMY;
	Fri, 05 Dec 2025 21:26:11 -0500
Message-ID: <bf3c6fc4118c5d63b87ace078d94848b19aa16d2.camel@surriel.com>
Subject: Re: [PATCH v1 2/4] mm/hugetlb: fix two comments related to
 huge_pmd_unshare()
From: Rik van Riel <riel@surriel.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, 
	linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, Will Deacon
 <will@kernel.org>,  "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,  Peter
 Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Muchun Song
 <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes	
 <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn	
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Harry Yoo	
 <harry.yoo@oracle.com>, Laurence Oberman <loberman@redhat.com>, Prakash
 Sangappa <prakash.sangappa@oracle.com>, Nadav Amit <nadav.amit@gmail.com>,
 Liu Shixin	 <liushixin2@huawei.com>
Date: Fri, 05 Dec 2025 21:26:11 -0500
In-Reply-To: <20251205213558.2980480-3-david@kernel.org>
References: <20251205213558.2980480-1-david@kernel.org>
	 <20251205213558.2980480-3-david@kernel.org>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-12-05 at 22:35 +0100, David Hildenbrand (Red Hat) wrote:
>=20
> So let's simplify the comments a bit.
>=20
> Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared
> count")
> Cc: Liu Shixin <liushixin2@huawei.com>
> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

