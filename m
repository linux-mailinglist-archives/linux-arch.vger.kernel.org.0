Return-Path: <linux-arch+bounces-15551-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C87CDAD47
	for <lists+linux-arch@lfdr.de>; Wed, 24 Dec 2025 00:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D064300C14D
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 23:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC64229BDB4;
	Tue, 23 Dec 2025 23:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpvZ8nvq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1s6ehae"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D01F289378
	for <linux-arch@vger.kernel.org>; Tue, 23 Dec 2025 23:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766532218; cv=none; b=rNAQM7up1wfxUN43kTirOsL2dXiJbe+R6flUyOaRaUow05xqOR6/saLzU8ApdSuTLTw5SIpBvwZ1HeKzDGktpY/oAxjKJG+8I3lM8sDjHqhZXTBrCXrkJb6DN1iNGgthiLqMx3tU/+Wxgr+d5pzJ1nUpyB8LDXzq5htZz6h3nuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766532218; c=relaxed/simple;
	bh=j74pz2xp86Own0WTdw5XNAA+fhHwwXAxbc9yYGTvLvM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gj15p305ymwJMUakzjGmaEd6uIoXlKSMux52x2gddcaaepzXm+u73+jqIpkJk2KWGP7slTHGGMuMxo0jrCW8/W/1IKQqPI1c/zQcva2xP9OPJ1yVMJIFv3sr417kUhX3+/WZAJLlGgOWrhdWralqdxjiw+mC6PRkzdNiCjc3hyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RpvZ8nvq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1s6ehae; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766532215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j74pz2xp86Own0WTdw5XNAA+fhHwwXAxbc9yYGTvLvM=;
	b=RpvZ8nvq5eWWBljMZNsrCNVMLV7a9KU3lr1k6tIUehU8K+q4O4OB9AXy5DEbqk3zSRu+BK
	m78Wt6MdR1WICad8fz/EzIMzl0hpR+WVtPJnybwQHt2xGagHvcWBumWOGdJYbqtMVWcasy
	hSgU5Xb9wjTS4qT9gVMwos2qM2YNy8M=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-QhW0vfeRMTCzWhFkTC9iaA-1; Tue, 23 Dec 2025 18:23:34 -0500
X-MC-Unique: QhW0vfeRMTCzWhFkTC9iaA-1
X-Mimecast-MFC-AGG-ID: QhW0vfeRMTCzWhFkTC9iaA_1766532213
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed7591799eso131687761cf.0
        for <linux-arch@vger.kernel.org>; Tue, 23 Dec 2025 15:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766532213; x=1767137013; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j74pz2xp86Own0WTdw5XNAA+fhHwwXAxbc9yYGTvLvM=;
        b=E1s6ehaeECR82x8/Nro57kuwndFX5y4cgDlYTR3DSbj6E4deSfSSoUtXj4dqPpGeC+
         fJAPnyQMSSS+nl0pBof4Q9gsJfjgtgpbiD9O7nFfjzWdkACNkWokl8UpOdwgPcgH7SVE
         aLFXzvoWfpTXZenFPvVdYOZomJ+E8+di3UNrVzIFgHuyaRUSZ3i6E8mjhSczG6NxaABa
         GKXfL2pxfxDzG5t3ygIdB9o9kogBRM7tYVWQYa/EO7LTPfml6rGHLV1OD1XXRM9mXsVs
         pKAFf+bCCQF1L3HOedQKhX2umgMvj7l8jJLYkTjUKmUKFPo+gA2SpIpEbddHvdCM4qPD
         al7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766532213; x=1767137013;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j74pz2xp86Own0WTdw5XNAA+fhHwwXAxbc9yYGTvLvM=;
        b=s/oICs28ZQR5JZXC/Y1lZ12V0xfevA0UU1dJorggGIHSTIp1OVwsA+7jd4JLbpe6If
         Hn0QDIIHV4nI6gscVYaszs+ZWQpktMHTvh4Bg5ZoYc4XBjXTeyzK2F+kgKG+f8q9/gf9
         yA2WhE3R6OqWqjkAaP2TnlOrOpw2lLdnfwE6HoIxUNNZhhGn0z2kTyBJvnL00A3xWQLY
         I7ILDLiKSkGuDdfCJ1XtWXvB0NCc69eck9wzNeiORRvFQPuSRymLbzWNTPjfZxDRwjfm
         XaVJ7pFAm2AE6IOFbLWW+llSPN3c8FSEoF5/Rn2YBNAeJ+SInjJnM3WKRi+opoFwfX1q
         32/g==
X-Gm-Message-State: AOJu0YzZUdy2Xuk30oZjhvfEPaiLoCfG6tyVmt/iP5LxOw1D7UfAly0c
	j1LS0zysM29pSYZUo0I9qjNYUUJQcS9PXGBwHnXiMFrxWgMvQqGOJvHCRfsH+Au76yEksI7suC6
	kMURzenSXDNMfNoD9RjLi6CuAjko8IhuqiHW4LhJR5YNq+UJUC5WNHfUidc+I3NM=
X-Gm-Gg: AY/fxX7K1nxnvKRCXf5Screyo2w/ler3Ijk1z43cBQP0TViMfo2PCVtj3+BzcVBATZR
	xhFNFB15UjstpG7HJaBPS+TXQrDqMYW1DV1/U8b5flvOIXMVYlOnK4LALoFr7xP7jKdbkJkk02z
	Li4UTbE9APdFb/lMMxA6sNh+ms+pDvWMYdlvez2axxHo7tu1iL4A4gcBL55v7lLtNhxAYmOB3b1
	j6/Pkx4YOp/GSmf2HBlRZD1iAMkb7ONeotP7WiObw+yYutrZFOSg0D/sCuHrqsIbmvJSGsI59kj
	ZtLEmlbfPS+shh0v4Wof/FTG++OOdFfObP5GmxUhM0yMQDRfN8R6hfTTsvGYJoewq+xOBLPUGJe
	QyPaf/Qb+Xyl7bx5C4D5MPNkfZqyI9LWeVQMhBtKn0D2Jshh/q1UACU9YWC/d
X-Received: by 2002:a05:622a:1f13:b0:4ed:67bc:50de with SMTP id d75a77b69052e-4f4abd1c387mr231162971cf.24.1766532213589;
        Tue, 23 Dec 2025 15:23:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAdHI2wD3ND1t7fPXe6qFtFHAW/7/HH1wOn3/aC4okrHJxh5+0pzdgAVbVs+yHegTNouqegw==
X-Received: by 2002:a05:622a:1f13:b0:4ed:67bc:50de with SMTP id d75a77b69052e-4f4abd1c387mr231162611cf.24.1766532213196;
        Tue, 23 Dec 2025 15:23:33 -0800 (PST)
Received: from ?IPv6:2600:6c64:4e7f:603b:1cec:a44a:989a:9980? ([2600:6c64:4e7f:603b:1cec:a44a:989a:9980])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac66865asm115070091cf.31.2025.12.23.15.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 15:23:31 -0800 (PST)
Message-ID: <11ab64528debf3b3515e863610fc8b679a39189c.camel@redhat.com>
Subject: Re: [PATCH RESEND v3 0/4] mm/hugetlb: fixes for PMD table sharing
 (incl. using mmu_gather)
From: Laurence Oberman <loberman@redhat.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, 
	linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, Will Deacon
 <will@kernel.org>,  "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,  Peter
 Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Muchun Song
 <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes	
 <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn	
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Rik van Riel	
 <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, Prakash Sangappa	
 <prakash.sangappa@oracle.com>, Nadav Amit <nadav.amit@gmail.com>
Date: Tue, 23 Dec 2025 18:23:30 -0500
In-Reply-To: <20251223214037.580860-1-david@kernel.org>
References: <20251223214037.580860-1-david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-23 at 22:40 +0100, David Hildenbrand (Red Hat) wrote:
> One functional fix, one performance regression fix, and two related
> comment fixes.
>=20
> I cleaned up my prototype I recently shared [1] for the performance
> fix,
> deferring most of the cleanups I had in the prototype to a later
> point.
> While doing that I identified the other things.
>=20
> The goal of this patch set is to be backported to stable trees
> "fairly"
> easily. At least patch #1 and #4.
>=20
> Patch #1 fixes hugetlb_pmd_shared() not detecting any sharing
> Patch #2 + #3 are simple comment fixes that patch #4 interacts with.
> Patch #4 is a fix for the reported performance regression due to
> excessive
> IPI broadcasts during fork()+exit().
>=20
> The last patch is all about TLB flushes, IPIs and mmu_gather.
> Read: complicated
>=20
> I added as much comments + description that I possibly could, and I
> am
> hoping for review from Jann.
>=20
> There are plenty of cleanups in the future to be had + one reasonable
> optimization on x86. But that's all out of scope for this series.
>=20
> Compile tested on plenty of architectures.
>=20
> Runtime tested, with a focus on fixing the performance regression
> using
> the original reproducer [2] on x86.
>=20
> [1]
> https://lore.kernel.org/all/8cab934d-4a56-44aa-b641-bfd7e23bd673@kernel.o=
rg/
> [2]
> https://lore.kernel.org/all/8cab934d-4a56-44aa-b641-bfd7e23bd673@kernel.o=
rg/
>=20
> --
>=20
> v2 -> v3:
> * Rebased to 6.19-rc2 and retested on x86
> * Changes on last patch:
> =C2=A0* Introduce and use tlb_gather_mmu_vma() for properly setting up
> mmu_gather
> =C2=A0=C2=A0 for hugetlb -- thanks to Harry for pointing me once again at=
 the
> nasty
> =C2=A0=C2=A0 hugetlb integration in mmu_gather
> =C2=A0* Move tlb_remove_huge_tlb_entry() after move_huge_pte()
> =C2=A0* For consistency, always call tlb_gather_mmu_vma() after
> =C2=A0=C2=A0 flush_cache_range()
> =C2=A0* Don't pass mmu_gather to hugetlb_change_protection(), simply use
> =C2=A0=C2=A0 a local one for now. (avoids messing with tlb_start_vma() /
> =C2=A0=C2=A0 tlb_start_end())
> =C2=A0* Dropped Lorenzo's RB due to the changes
>=20
> v1 -> v2:
> * Picked RB's/ACK's, hopefully I didn't miss any
> * Added the initialization of fully_unshared_tables in
> __tlb_gather_mmu()
> =C2=A0 (Thanks Nadav!)
> * Refined some comments based on Lorenzo's feedback.
>=20
> Cc: Will Deacon <will@kernel.org>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nick Piggin <npiggin@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jann Horn <jannh@google.com>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Harry Yoo <harry.yoo@oracle.com>
> Cc: Uschakow, Stanislav" <suschako@amazon.de>
> Cc: Laurence Oberman <loberman@redhat.com>
> Cc: Prakash Sangappa <prakash.sangappa@oracle.com>
> Cc: Nadav Amit <nadav.amit@gmail.com>
>=20
> David Hildenbrand (Red Hat) (4):
> =C2=A0 mm/hugetlb: fix hugetlb_pmd_shared()
> =C2=A0 mm/hugetlb: fix two comments related to huge_pmd_unshare()
> =C2=A0 mm/rmap: fix two comments related to huge_pmd_unshare()
> =C2=A0 mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables
> =C2=A0=C2=A0=C2=A0 using mmu_gather
>=20
> =C2=A0include/asm-generic/tlb.h |=C2=A0 77 +++++++++++++++++++++-
> =C2=A0include/linux/hugetlb.h=C2=A0=C2=A0 |=C2=A0 17 +++--
> =C2=A0include/linux/mm_types.h=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0mm/hugetlb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 131 +++++++++++++++++++++---------------
> --
> =C2=A0mm/mmu_gather.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 33 ++++++++++
> =C2=A0mm/rmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 45 ++++++-------
> =C2=A06 files changed, 213 insertions(+), 91 deletions(-)
>=20
>=20
> base-commit: b927546677c876e26eba308550207c2ddf812a43
Hello David

For the V3 series, I re-ran the tests and the original reproducer and
its clean. I see the same almost 6x improvement for the original
reproducer

# uname -r
6.19.0-rc2-hugetlbv3+

Un-patched Result of reproducer Iteration completed in 3436 ms
V3 Patched Result of reproducer Iteration completed in 639 ms

I also ran a test to map every hugepage I could access (460GB of them)
then fill and validate and had no issues.

Tested-by: Laurence Oberman <loberman@redhat.com>





