Return-Path: <linux-arch+bounces-12045-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 206B5ABE894
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 02:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7171B64C03
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 00:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDB48834;
	Wed, 21 May 2025 00:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3FHKiDM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99202632
	for <linux-arch@vger.kernel.org>; Wed, 21 May 2025 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747787940; cv=none; b=eEXdRrtF8asPw9xSH4e5AFjJ5DabjO+HSYCQfxdfxi8S+QF+Hvd3zx04O+vuwbCaMapyKAuvqifDc4lZ4CNeAQxgaT/GSx6vUJ6/HopWVkk180Eo7Hk2+nl/s0lYcXYEn9+g3qFpSJtGqajWeE4OoNPpWHAPM0U0NjFMxO7/T1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747787940; c=relaxed/simple;
	bh=U7WreOu0RES9FDjcTDjDH14RGJFWK8lQsifbrWQtRVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qwq81ckDjyEyV2NEl+WRynvIJWLlkkxo1kvaayNjk1G4VDhmGeby+W0DzSOc5Zz+NVXB464lHUynf6E5+TOsqvasSCXpcJyCV/Lw8+ogO7IpGwF5QCG0Mls0sRRngutofkD7xMAiYidAKEqSzWoP4Cc2hjGDntZxfwd3yDe8Zyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l3FHKiDM; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-601a67c6e61so26628a12.0
        for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 17:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747787937; x=1748392737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WspCal8y8NZa4tDmuGWQBUOazVn+kNd9Xx/2Q+XoBxI=;
        b=l3FHKiDMgU03tZ3CjADdwiVBBlpWwxcCNxQDPtgaVJ1hLG4RzwjOUWHLT0G5yFwP32
         77FJgAXhgG1vsOlFEnIP3fk78kT7S+Irh0Bj1czpGVXvUdbMKY1Sfyw+0Kzdw2aqerzT
         Gd6hNYWYrkS5Lfi071mOZVzqdOHbh8dTzXwrhQLwFISK2y/losuh4vkNHV66RtANTpPM
         QA63Yqquan6H5LSY+GacPN+U3y5zLqJ84h5c/ip3GOOByhwbg398ecZf7XKEPEMUJlKE
         uh3k092eh8+R+eYEKejLrSsLjRpcbEE5BnMOVYuMvUiYAz1ZbmaOIXUtZH/teXy/5tpC
         /oLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747787937; x=1748392737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WspCal8y8NZa4tDmuGWQBUOazVn+kNd9Xx/2Q+XoBxI=;
        b=pqoQ9ptvx82kFXSMgYhjd/VuAAQMlVmI0XsMsEUnoBUPq/L5qAFCqvqBY9yv1u8xr+
         XYYibXWUUuKIUbTHjH6glNfar4+/hNvK+nyBLVHByFkolKz1DfvLhfdknoKvnw3rcBZv
         JQ34F/0kUD4p0MWp4Dvof1dl9tn0rqtX45L2v5k7SNDT4jG4V+3TT8dmhgDN4hbUgBb8
         YrKkMMibpJcGPgdeFd3cREjhKHLPs544/g2enDEJ4yaFMt7udg0QF6Jsxk0m/EeKhODq
         fC4Z4DNRDVK8k8VPhQlIEhMR54t26NXM1GzOyt7rOmlT7Qbd2F0bc4Osau7DWdqYUdho
         kX9w==
X-Forwarded-Encrypted: i=1; AJvYcCXiW31sHmXuBSSF5wh1tGMCIBWeFW2/3gWYHdZiaanrDo/bow7ZkLOvDjfgrEZg+nNXnRzpsi1l+hbO@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvj6AJ/DTt8MwkHmC4DC9Iyzn8j16+p/GY9pnPqdQyxN2ABYu1
	oPmhne9IYfBSOumQy25agpmIzZbHGe/zycsk8Ls9EcLBWOpOkZjKChnGjfZSYsMD86FAvVjKIag
	0KwcAHHLUjBLlY3XaYCzNReHX1Th8CsD/foDAIrE0ukL7EgEpxTUvGL/Lv6k=
X-Gm-Gg: ASbGncs2375NRvqN2wuYaUS4ruDdXrNJj+eMXlN+ykN3qXg1QfBMoCJTNLDW+fiiZZj
	IZUwfreyFJY5Cnbh/zq4wJwzz/dgw+5pudYNi0KW4PZplQLoT2DcynSh5afj8ODcoACDtIxzho+
	tegFD8us3uyNb9QxR61yAcVHCewGeYn+Oy18wWA5mBG4dfaooD8xkvpOTV622ck2KEvBMkn8fy
X-Google-Smtp-Source: AGHT+IFGzg1HiyU3iSRyJlcEH+h760Pi+n2Y93HX/OapY6BeDZU3wPr7AjpuGUN09T84tbsasqjEUyHQjDZU2RrY0WM=
X-Received: by 2002:a05:6402:14d5:b0:601:233a:4f4d with SMTP id
 4fb4d7f45d1cf-6019bf2f776mr369506a12.2.1747787936630; Tue, 20 May 2025
 17:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520214813.3946964-1-roman.gushchin@linux.dev>
In-Reply-To: <20250520214813.3946964-1-roman.gushchin@linux.dev>
From: Jann Horn <jannh@google.com>
Date: Wed, 21 May 2025 02:38:20 +0200
X-Gm-Features: AX0GCFu94sdnWGHTjJDGScJi6wHq5LLBJs6G1BkmzL4E483Bo3JMeYGYzyLmFEI
Message-ID: <CAG48ez39SaJe=cwq3JZ6UM0BLMHEj76Kdmd9=Ho1nr17fAco6Q@mail.gmail.com>
Subject: Re: [PATCH v5] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
To: Roman Gushchin <roman.gushchin@linux.dev>, Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Nick Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 11:50=E2=80=AFPM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
> Commit b67fbebd4cf9 ("mmu_gather: Force tlb-flush VM_PFNMAP vmas")
> added a forced tlbflush to tlb_vma_end(), which is required to avoid a
> race between munmap() and unmap_mapping_range(). However it added some
> overhead to other paths where tlb_vma_end() is used, but vmas are not
> removed, e.g. madvise(MADV_DONTNEED).
>
> Fix this by moving the tlb flush out of tlb_end_vma() into new
> tlb_flush_vmas() called from free_pgtables(), somewhat similar to the
> stable version of the original commit:
> commit 895428ee124a ("mm: Force TLB flush for PFNMAP mappings before
> unlink_file_vma()").
>
> Note, that if tlb->fullmm is set, no flush is required, as the whole
> mm is about to be destroyed.
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Jann Horn <jannh@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nick Piggin <npiggin@gmail.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
>
> ---
> v5:
>   - tlb_free_vma() -> tlb_free_vmas() to avoid extra checks
>
> v4:
>   - naming/comments update (by Peter Z.)
>   - check vma->vma->vm_flags in tlb_free_vma() (by Peter Z.)
>
> v3:
>   - added initialization of vma_pfn in __tlb_reset_range() (by Hugh D.)
>
> v2:
>   - moved vma_pfn flag handling into tlb.h (by Peter Z.)
>   - added comments (by Peter Z.)
>   - fixed the vma_pfn flag setting (by Hugh D.)
> ---
>  include/asm-generic/tlb.h | 49 +++++++++++++++++++++++++++++++--------
>  mm/memory.c               |  2 ++
>  2 files changed, 41 insertions(+), 10 deletions(-)
>
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 88a42973fa47..8a8b9535a930 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -58,6 +58,11 @@
>   *    Defaults to flushing at tlb_end_vma() to reset the range; helps wh=
en
>   *    there's large holes between the VMAs.
>   *
> + *  - tlb_free_vmas()
> + *
> + *    tlb_free_vmas() marks the start of unlinking of one or more vmas
> + *    and freeing page-tables.
> + *
>   *  - tlb_remove_table()
>   *
>   *    tlb_remove_table() is the basic primitive to free page-table direc=
tories
> @@ -399,7 +404,10 @@ static inline void __tlb_reset_range(struct mmu_gath=
er *tlb)
>          * Do not reset mmu_gather::vma_* fields here, we do not
>          * call into tlb_start_vma() again to set them if there is an
>          * intermediate flush.
> +        *
> +        * Except for vma_pfn, that only cares if there's pending TLBI.
>          */
> +       tlb->vma_pfn =3D 0;

This looks dodgy to me. Can you explain here in more detail why this
is okay? Looking at current mainline, tlb->vma_pfn is only set to 1
when tlb_start_vma() calls into tlb_update_vma_flags(); it is never
set again after tlb_start_vma(), so I don't think it's legal to just
clear it in the middle of a VMA.

If we had something like this callgraph on a VM_MIXEDMAP mapping, with
an intermediate TLB flush in the middle of the VM_MIXEDMAP mapping:

tlb_start_vma()
  [sets tlb->vma_pfn]
zap_pte_range
  tlb_flush_mmu_tlbonly
    __tlb_reset_range
      [clears tlb->vma_pfn]
zap_pte_range
  [zaps more PTEs and queues a pending TLB flush]
tlb_end_vma()
free_pgtables
  tlb_free_vmas
    [checks for tlb->vma_pfn]

then tlb_free_vmas() will erroneously not do a flush when it should've
done one, right?

Why does it even matter to you whether tlb->vma_pfn ever gets reset? I
think more or less at worst you do one extra TLB flush in some case
involving a munmap() across multiple VMAs including a mix of
VM_PFNMAP/VM_MIXEDMAP and non-VM_PFNMAP/VM_MIXEDMAP VMAs (which is
already a fairly weird scenario on its own), with the region being
operated on large enough or complicated enough that you already did at
least one TLB flush, and the unmap sufficiently large or with
sufficient address space around it that page tables are getting freed,
or something like that? That seems like a scenario in which one more
flush isn't going to be a big deal.

If you wanted to do this properly, I think you could do something like:

 - add another flag tlb->current_vma_pfn that tracks whether the
current vma is pfnmap/mixedmap
 - reset tlb->vma_pfn on TLB flush
 - set tlb->vma_pfn again if a TLB flush is enqueued while
tlb->current_vma_pfn is true

But that seems way too complicated, so I would just delete these three
lines from the patch.

