Return-Path: <linux-arch+bounces-15303-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1F2CAB405
	for <lists+linux-arch@lfdr.de>; Sun, 07 Dec 2025 13:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CA55303463E
	for <lists+linux-arch@lfdr.de>; Sun,  7 Dec 2025 12:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840B6230BDB;
	Sun,  7 Dec 2025 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhSkg754"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12DF1991CB
	for <linux-arch@vger.kernel.org>; Sun,  7 Dec 2025 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765109765; cv=none; b=XKKgONf3BwoP+G4tWDtG2/FYf8DCSLjx/aZ0akV3QaiWmy+1MTnZmjFk7J3C5mvrOMlTyNv0NmerWR7eksXA36zlzw7/6bygcug7NYiXykVbBBx0nrJLDN9kkw94qUUN1+wdIstrpu2UhB5suSmIBdkRBKqTidwBwqGaj0Wxw2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765109765; c=relaxed/simple;
	bh=FEbxVk7wmKJ4CC4mXv63i7iPIqvwX42991mwrYLOP9A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YDzPMNQY57v5J+JLILuPspUp7MZoyGQiJLuhquAcEb/+1HWMOSxgibyqzNBGQrpuY6qsHAAKbYktEDgbQECavaRaLhduS5Vi+GfhoWWRX5mJYzOppKywPGUS59I0Ze+DhN7vq73XXY/6IbA6xykPYOH6Qaznk0A6TjpR822VVV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhSkg754; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477632b0621so26162925e9.2
        for <linux-arch@vger.kernel.org>; Sun, 07 Dec 2025 04:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765109762; x=1765714562; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QT4cc6ryECaLEhMTXcgpX95Fpt+0IiUEEALeoLDPVjE=;
        b=XhSkg754tkUXStSL0vmaw0JsKZ6eF48IZ3n7GUskD215RpVmMnh5yrOiGNmiuahhf1
         rBeJMvmkoSgTl9WMoV4kpool1D4DT4K9QaMxC4iOMGJ/D3N0oJWK4grhr05F25qFbTrm
         TExxG9wPxoqP2uuhsx9CE54vBCLog+RvWGCzfvONsgHXaRMBCulX04HQWzk3dDb9vLrD
         oR0oTwvEzXlTTnIqEVa8ZC2BVHoZlwWMWtrY/cUX9doojeYhv1QdWJsb8eEAIzl4wWYb
         juVt9GgsRBa7jFvD/wMQP3gLQ56EGU9TO+WCdVk5cgmSDhxy+GcmUetsS5Zfg+j3cRCj
         OIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765109762; x=1765714562;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QT4cc6ryECaLEhMTXcgpX95Fpt+0IiUEEALeoLDPVjE=;
        b=dOq4fBWmTjfuif9xYOg334C7FIHOTvRNIlGJzOtIwjvJL98N9O8WJhQgHUEUkadNKw
         36jtgtUSTw2yTuBxD/vokHL0Njom7NUxELFCkJ5h5TXvyUeNPkZI+zvCprs6rs1Dwhqa
         Nij62CWyKJcC25Xq58nG4CeM7ucxkHWfQDsIc6VZnYieBbBzBrDmmONWj26Sv0UA3qUY
         8gW84vZcIIKyQWAGtKgEa+5JoCsU2ZCJE6EsuYXeOMUn5IaelycL26lmxWiS7uKDdIKw
         yRtL90QM1tKUh09K6HfciRSv0JRUhhA3oL8rQzCj8gsRRHa1Kz7c7JSDQf9mncZN6vU7
         GxtA==
X-Forwarded-Encrypted: i=1; AJvYcCXfNKcIdGWF2CYDZiwrxZrNGR9ttBM/+V5t/6QMKED5r8cAXSj6ZXu5VWIn1hv0CmBnfn076gJB1XZm@vger.kernel.org
X-Gm-Message-State: AOJu0YzCM1/hKG9wwcaqhokIstEHTTJ/4Ytrm3KvdyLrfuK+Vfkivccx
	ZsQaLQ3Y6ExTu947U6+RTV4DQwVezZHVUTb3HhuocxZYlSU0WbmG3aU4
X-Gm-Gg: ASbGncs2icMgPfoxaXqzC2SuzePyE8Sdr2X98G8OWGLiL5P/tvKvAWraZgfaAr+Zkr8
	Bmc9VSASbVSOCNHZzjLelA+7PwLM1QPZfiysS9/OFCZWNJSciRvlKzcebcFtXSRtkVroBRSpxn8
	vv6Vt75R/CqWzAb4sP328vFhZmQcPFAlEnqL4xz8DbCoznwsQ7RVIsSfBsByZNidegpn9zinO3I
	4Da74GilZ2/TXj5fyhnd34QHcyLEQbQ80by9TnYtKnqPr5IuBqPNYvkxTvcqO8j5puFTxLUHme6
	DpJRDGEmOdcFLw3YRh4ksdn1T/acWE1blu3ccojPJ1kEUs/lpDWxOwjf0Q/OCaV0eFMfuWKgRt/
	5aqxnDTVcvm6xXTVm4BTw2d3BdpQDTReknuvMHw2CgEnZsjbxWKBxp7IV19VMgZ5eAXmur574QC
	NLIm7KK40CwQ8Z5xKMxDoZC8fH5ze/usI=
X-Google-Smtp-Source: AGHT+IHC8ivIALeWoT4SzaWmpNaTZ5behrXBR6LHuS1Z2YNL9+AnBuHGkZlkWoEmSgwayqVBsaaMLw==
X-Received: by 2002:a05:600c:524a:b0:477:9b35:3e36 with SMTP id 5b1f17b1804b1-47939df1419mr40530125e9.2.1765109761978;
        Sun, 07 Dec 2025 04:16:01 -0800 (PST)
Received: from smtpclient.apple ([212.59.70.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479311e707asm181916185e9.10.2025.12.07.04.15.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Dec 2025 04:16:00 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: Re: [PATCH v1 4/4] mm/hugetlb: fix excessive IPI broadcasts when
 unsharing PMD tables using mmu_gather
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20251205213558.2980480-5-david@kernel.org>
Date: Sun, 7 Dec 2025 14:15:47 +0200
Cc: linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org,
 linux-mm@kvack.org,
 Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>,
 Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>,
 Laurence Oberman <loberman@redhat.com>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0914A8DB-447C-4E62-B151-62E5E4E99749@gmail.com>
References: <20251205213558.2980480-1-david@kernel.org>
 <20251205213558.2980480-5-david@kernel.org>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
X-Mailer: Apple Mail (2.3864.200.81.1.6)


> On 5 Dec 2025, at 23:35, David Hildenbrand (Red Hat) =
<david@kernel.org> wrote:
>=20
> @@ -400,6 +411,7 @@ static inline void __tlb_reset_range(struct =
mmu_gather *tlb)
> 	tlb->cleared_pmds =3D 0;
> 	tlb->cleared_puds =3D 0;
> 	tlb->cleared_p4ds =3D 0;
> +	tlb->unshared_tables =3D 0;
> 	/*
> 	 * Do not reset mmu_gather::vma_* fields here, we do not
> 	 * call into tlb_start_vma() again to set them if there is an

I understand you don=E2=80=99t want to initialize fully_unshared_tables =
here, but
tlb_gather_mmu() needs to happen somewhere. So you probably want it to
take place in tlb_gather_mmu(), no?


