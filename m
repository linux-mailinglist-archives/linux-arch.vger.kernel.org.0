Return-Path: <linux-arch+bounces-15304-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4E5CAB457
	for <lists+linux-arch@lfdr.de>; Sun, 07 Dec 2025 13:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B5463003127
	for <lists+linux-arch@lfdr.de>; Sun,  7 Dec 2025 12:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA1F2EA154;
	Sun,  7 Dec 2025 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT1+hQAf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB6B29D269
	for <linux-arch@vger.kernel.org>; Sun,  7 Dec 2025 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765110289; cv=none; b=gWNT+f3arFKC43c52Z4D/kfymEzP5SF5Lb0E4/TfrdjoQEIOkED3fb1ixJWEwleeJcpnI5PI7fe3n2yKkqgYfba/GjsefP+n2gHBQSbH5o+uURVOLRj+8LSYn1HsC4bvjP1VzTc87da3lDCpBgSc0Mlv8gFY4TrnQx0FdtcBK+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765110289; c=relaxed/simple;
	bh=77jv+KFNbqJ5gbQ0yMtkfIpBkMu3Ba/WQ5SaNdqlD8M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jU7S2ELrfHI4Aa5v4IRgaes79A9eXrpjXMzl9s55pf8187pOrdG2ifUnXQxzGuiWU4GZdw4BjsiON+xZq41LOEVSBg64rNDh7oy1kO0dSxqJd4POy3Q1VyKQnjjxl2DI5YCRqplp90edkjeQu2slg93S8Q3S3H5jvdwCyBuAqNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LT1+hQAf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so40454625e9.3
        for <linux-arch@vger.kernel.org>; Sun, 07 Dec 2025 04:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765110286; x=1765715086; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fl1kkKhpVPyl0p4GnJfcedu4IBpEFqXBvrIdqh+PkaI=;
        b=LT1+hQAfwlW2c1/a8FNWnMauIRpNTRgnK2orwZt33pqd7j50o/fDk3aWE7xJljq7Md
         ioKuJJk1R4KrbIAXlsh7Ak0oUyL58ZVfIPJpmlaWH/If2a7d5G2NgEujgE/g3aFcagry
         BaTe1E2Fe8m31afbOB0ic2Ku+DfAIOnau1gIPp9jf45aDMRAOT+/CLFN+q3wtdVzaIRk
         tpfmDEv3vhu3jFwkx5mQwogzTDaP+J50eT695UQ1PiFl5h+IfqB9fPrKN+iwXkLQ+7ql
         X1M26hFbNCkJKUgI4Kh5XnfU7kE9ZVQm7vNBZrwJJjhgxsK28c2rSFOLxp6ImRPNDlhP
         Ymqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765110286; x=1765715086;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fl1kkKhpVPyl0p4GnJfcedu4IBpEFqXBvrIdqh+PkaI=;
        b=nBB8RD1lZm+5Qon6w8yvDx1HW35GkAkeiNFQtXluY//KvwjdcC+5pKUKaxhGYyPq3f
         9b5A9NLW4LhdQMkRhHZcQOd7037dqfw820jCZVJqp/PourCPi566RB5tCX6s/FdDIAr7
         MgllT0xQ2AKSbO4wnH+rMN3RAHHOQ9RjnUfzSgKpvml7H4hwWcGfm+RgFbeuBR11dWoM
         CK65zYLTGXrMisnRZD5RWb+2iJmdnS69sGEHnKLyuGeHZ6AaGU3Y2Z1dVhj3bK3aregk
         dwhvMYJ/K54X9PbxZYIAmVW/zpTB3BdTjE3nhcSyREhPgqVbEfuZ6gsC94Qks+UKg97R
         5nJA==
X-Forwarded-Encrypted: i=1; AJvYcCUApIQlEQg0ePFC4MXMCsCQbsAbYKluyGJ9RaaWSKFv1QXPF3dYbnwY9px61LnvfSDQgIWnVc2DfbzB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8n21LWSoQJtiBX9paO55nE2772L6e2usJeqxS7BWmbr89NBE2
	kZjfPrMeI2p/81i4dmCDeRGATSnUNB2KSsD9i9t6jRYb/XGNdrMkLN9t
X-Gm-Gg: ASbGncukWIaK6E+wPgtoX5kUdYZ8FRp5SZdOHq4pxQFcqwUPxzyJVJnC48mQAGxrSbP
	KBE7OtAE41KmAm73wYuVL+OzBeAxEoKK433MvMsY3pAl77Zj5YstlVl0fXpW4he+J07Q3/cpWy3
	k0TXZfV+Krkna/lypFYMaAivzzVh6Fhp8s+ASvkvkIqkTXB+5hNCJhHHiDGvReRRXgMjS3NgEIP
	pfkSaGbALd92en/5qV1fxd3Yyy5eWTjY0D4STODlg/QjkHTINNeHRHOL/ZmkXwjWGRyIa0+P6rn
	mLO/xhW9EYNLwOi/019P6CsU8USSybGYxrG36s0mB2lMotsVmBhwtZDmEO4SJyJhDrxr6WGk+GA
	VC5SDIsbbS43Q/F5KtTsIWyUGmdSK2RWjlSfCoQMDhb3quGejG+FaxGfZZl6CvtmiUYMII0vE49
	lpLFZISH4LdbEUZv4X4LEsluSdHZhmai/XOFsbePc+zw==
X-Google-Smtp-Source: AGHT+IFYNytRWOoRWAn3wuIAxlT2l9Sf9Gj3BBpCG6lKrrYKjNp1jrrzXLs8UNkcqC+phor02o5mjQ==
X-Received: by 2002:a05:600c:19cf:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-47939e3a6c6mr53136075e9.24.1765110286247;
        Sun, 07 Dec 2025 04:24:46 -0800 (PST)
Received: from smtpclient.apple ([212.59.70.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47933aef61fsm148718095e9.7.2025.12.07.04.24.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Dec 2025 04:24:44 -0800 (PST)
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
In-Reply-To: <0914A8DB-447C-4E62-B151-62E5E4E99749@gmail.com>
Date: Sun, 7 Dec 2025 14:24:32 +0200
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
Message-Id: <C9D5EFFF-05D9-435C-96C1-4B13134E2904@gmail.com>
References: <20251205213558.2980480-1-david@kernel.org>
 <20251205213558.2980480-5-david@kernel.org>
 <0914A8DB-447C-4E62-B151-62E5E4E99749@gmail.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
X-Mailer: Apple Mail (2.3864.200.81.1.6)



> On 7 Dec 2025, at 14:15, Nadav Amit <nadav.amit@gmail.com> wrote:
>=20
>=20
>> On 5 Dec 2025, at 23:35, David Hildenbrand (Red Hat) =
<david@kernel.org> wrote:
>>=20
>> @@ -400,6 +411,7 @@ static inline void __tlb_reset_range(struct =
mmu_gather *tlb)
>>=20
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
>=20
> I understand you don=E2=80=99t want to initialize =
fully_unshared_tables here, but
> tlb_gather_mmu() needs to happen somewhere. So you probably want it to
> take place in tlb_gather_mmu(), no?

To clarify my messed up response: the code needs to initialize =
fully_unshared_tables
somewhere during tlb_gather_mmu() invocation.



