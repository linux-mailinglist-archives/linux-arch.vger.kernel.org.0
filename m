Return-Path: <linux-arch+bounces-15302-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97478CAAD18
	for <lists+linux-arch@lfdr.de>; Sat, 06 Dec 2025 20:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE54F30616A6
	for <lists+linux-arch@lfdr.de>; Sat,  6 Dec 2025 19:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E032D1916;
	Sat,  6 Dec 2025 19:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVtp9s5z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mDVr8RhB"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2261FF7C7
	for <linux-arch@vger.kernel.org>; Sat,  6 Dec 2025 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765050808; cv=none; b=GaucuepAqVeTOD75ZV9FoI2ky7HnHYQOdudw5JxJM842wM8UKVxEPB03CKR7XlHcyBxo9Gksp/lXrh/M9pZYApQNsK2RbFT4t29UHrqduhcQVsqiRUr85UpDJaTdbseKSi1Pg/FQThy5uWZ3eYk+wA4H2CdOn5PdvKN3RH/xpe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765050808; c=relaxed/simple;
	bh=NCc/R1bNVmzY0LJnU4UrFWR+uh0aAjEdIugQhYqdToM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G9uDZM4xrwWUD9Oz6C84flb+KMb+CQpUdA+nG/euc8MmhMBdxTJoY+fa/EY77rxftk/fSx5F9e7JojwR5g0fPEklgd+YgSa51RuIU/mJhlEOPhKRhJgcDac9mkOjb/Q0UXcymiaTCacJBixDY7UGOYGntdMyEFA47+sktn3m/08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVtp9s5z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mDVr8RhB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765050804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qrpYMWO98nw/C1zuKpSbDBvFxM74soYI7+nWen4/2Ko=;
	b=aVtp9s5zBQqofn3XYjJmtSjRxVWhN7Mo9I21aqktMNu5uovU0RT4D2c/jb3tSH5uKUql/D
	lhtkHB93Yh16vWdG99YkK+ztTNKexAx6vhWwuyw2+7gg+/tMOhLwUgkVouiQaBs+kTmVNf
	9Lh+uO6pXTOveukz3mA13VrfHBcKL4A=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-pls1JsFBMKWE2Qebc4nx6w-1; Sat, 06 Dec 2025 14:53:17 -0500
X-MC-Unique: pls1JsFBMKWE2Qebc4nx6w-1
X-Mimecast-MFC-AGG-ID: pls1JsFBMKWE2Qebc4nx6w_1765050797
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7bf5cdef41dso5755966b3a.0
        for <linux-arch@vger.kernel.org>; Sat, 06 Dec 2025 11:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765050797; x=1765655597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qrpYMWO98nw/C1zuKpSbDBvFxM74soYI7+nWen4/2Ko=;
        b=mDVr8RhBf/r1AYCdiAFmrCJElCEqcjVzGS5kUB64t8fEjYoeQWfhob5FFeTvzzCY0D
         oMVV8bZvoml0R1WoN99rTIzWddVYn45sKs3yGUofZAosn5CAoNyAi9uO+FvcHOUC/PfC
         kwbesfmIKkXDEwbqethiSZF2PnFeQv7qAcOXKdlAD7hocIXUMVm82DKRdmHcGC0oHkUl
         ZGarnMdKDM4c+y2Lv+4T5B8b9aHqvwOxCY6l6nDLqywF9xIK4yejlGVgUTCQY1wyDQWg
         467IzUCkHRkcQP9cL+Q7ewVPHhxle4OFXx46J0Gar8SQv2lXeanWra/zr7ez+unEIiiT
         +jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765050797; x=1765655597;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrpYMWO98nw/C1zuKpSbDBvFxM74soYI7+nWen4/2Ko=;
        b=HtI1c8KFbj0Gs7sSbVpT/j892BfD6GC7VciaYZ0ARtBuLZ88VDAaV2QFlwQ+DGToW8
         yvYn2qU1vBBXIUpOVbsUd0NYKUioxgXfqvYMFyB6+prDlj6US89022y13HeSF8Oowl2n
         9YclPI9DYyOlpk1wmimX5rXqZ6VfJW5/+cMf5nS9Xp+VtswjcZMxPodqFhfhwDujO4/s
         p8Ue34UcXetAsBoEUGy0mkRmR8UaiM2wPd14lXcSr3XdHfLmcbdQq3rIZPNE9qeSlNdA
         EX/KObBXrOGeAaCKD4JXOl6QgdVkub3G5iHD9cwj4BV0SUY0ucm5r8rBWtr2kAuNpBDo
         SCyQ==
X-Gm-Message-State: AOJu0Yz0EX3IKI/gLcf5fXt9JfVugGrABdWkqh5ZGhOHTNGIrqLw1mpa
	Y6FhG0cps62TkAPdKYlph7eqmN3d8uN88O9lDbJQmnZx0I7mlKM/hQLKj0wrKaKvUIaAaOnOxak
	QNU7eCroVRaTqlmguZ864Qqfgw1mW/4xGWdx68hkzDg5vFgHJKkvLjS8rH98QCok=
X-Gm-Gg: ASbGncs997kRoe8VDEXHlr+rD4T4hz5J/3F2Ja+1oFvbNXEpR6PmKakPKwUZApudIVI
	1GcBjuSQL/xIewGKg0I0Y/DcO7M4OKYEcrl7CJ+AJlTn6UHJsGcAX1rFJCovoFZsAEMPQOTfHGW
	H5rnazyLEm4jMQOe0xU073b04m+yqCcVJSSaEZG57rf5CPK7QqJBP10oCLtU5d1U9qm470jROhd
	l6F1A8UoCwokpgz5pwSa5Wg9IlDph02SS76TuU73+/U5LbrmSfSR2VZETUglwQ9H/e/kN3p5v9y
	fHt3iT9B2tp/mIfw5Gq7GtEU43gCi59T70Onucj/1PF2rkPxHbgT3SU61GucbLuSEiYk7D9HW71
	J+2X+5QZj065ocYzojgyuhPCJtsPcjirYSYD9tH4LYSVEVaxS6vyvYx5hVgNW0Z4qtW04ZV5srw
	hD494=
X-Received: by 2002:a05:7023:b01:b0:11b:d4a8:d24d with SMTP id a92af1059eb24-11e03260ecamr2282825c88.12.1765050796768;
        Sat, 06 Dec 2025 11:53:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2aPGE6vYb1dltrITpg8eumtVfZJj4Id5GKymqQwmguys9MRcgGbHoYX1yIz3YPyGVGfbLsw==
X-Received: by 2002:a05:7023:b01:b0:11b:d4a8:d24d with SMTP id a92af1059eb24-11e03260ecamr2282813c88.12.1765050796257;
        Sat, 06 Dec 2025 11:53:16 -0800 (PST)
Received: from syn-2600-6c64-4e7f-603b-9b92-b2ac-3267-27e9.biz6.spectrum.com ([2600:6c64:4e7f:603b:9b92:b2ac:3267:27e9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7703bd7sm35128784c88.10.2025.12.06.11.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 11:53:15 -0800 (PST)
Message-ID: <6640379f1ef7e9305b77d1e322b04d9534a3fff5.camel@redhat.com>
Subject: Re: [PATCH v1 0/4] mm/hugetlb: fixes for PMD table sharing (incl.
 using mmu_gather)
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
Date: Sat, 06 Dec 2025 14:53:02 -0500
In-Reply-To: <20251205213558.2980480-1-david@kernel.org>
References: <20251205213558.2980480-1-david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-11.el9_6.1) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2025-12-05 at 22:35 +0100, David Hildenbrand (Red Hat) wrote:
> One functional fix, one performance regression fix, and two related
> comment fixes.
> 
> I cleaned up my prototype I recently shared [1] for the performance
> fix,
> deferring most of the cleanups I had in the prototype to a later
> point.
> While doing that I identified the other things.
> 
> The goal of this patch set is to be backported to stable trees
> "fairly"
> easily. At least patch #1 and #4.
> 
> Patch #1 fixes hugetlb_pmd_shared() not detecting any sharing
> Patch #2 + #3 are simple comment fixes that patch #4 interacts with.
> Patch #4 is a fix for the reported performance regression due to
> excessive
> IPI broadcasts during fork()+exit().
> 
> The last patch is all about TLB flushes, IPIs and mmu_gather.
> Read: complicated
> 
> I added as much comments + description that I possibly could, and I
> am
> hoping for review from Jann.
> 
> There are plenty of cleanups in the future to be had + one reasonable
> optimization on x86. But that's all out of scope for this series.
> 
> Compile tested on plenty of architectures.
> 
> Runtime tested, with a focus on fixing the performance regression
> using
> the original reproducer [2] on x86.
> 
> I'm still busy with more testing (making sure that my TLB flushing
> changes
> are good), but sending this out already so people can test and review
> while I am soon heading for LPC.
> 
> [1]
> https://lore.kernel.org/all/8cab934d-4a56-44aa-b641-bfd7e23bd673@kernel.org/
> [2]
> https://lore.kernel.org/all/8cab934d-4a56-44aa-b641-bfd7e23bd673@kernel.org/
> 
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
> 
> David Hildenbrand (Red Hat) (4):
>   mm/hugetlb: fix hugetlb_pmd_shared()
>   mm/hugetlb: fix two comments related to huge_pmd_unshare()
>   mm/rmap: fix two comments related to huge_pmd_unshare()
>   mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables
>     using mmu_gather
> 
>  include/asm-generic/tlb.h |  69 +++++++++++++++++++-
>  include/linux/hugetlb.h   |  21 ++++---
>  mm/hugetlb.c              | 129 ++++++++++++++++++++----------------
> --
>  mm/mmu_gather.c           |   6 ++
>  mm/mprotect.c             |   2 +-
>  mm/rmap.c                 |  45 +++++++------
>  6 files changed, 178 insertions(+), 94 deletions(-)
> 

For the Series passed generic testing with a focus on the CVE
regression and looks good.

Tested-by: Laurence Oberman <loberman@redhat.com>



