Return-Path: <linux-arch+bounces-12157-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F10EFAC91E6
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 16:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFAF1189E667
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 14:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067A123182E;
	Fri, 30 May 2025 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EfsWaHgt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EB933987
	for <linux-arch@vger.kernel.org>; Fri, 30 May 2025 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748617037; cv=none; b=l+v6oikTGKyu9bQ08QPAEUxPFkVBup0mFFgrSN+05VR98EvBkW2U86QdWYBTRLZq/XZ0ufgWM64NNJA8wn6L3tVJwMkh44nSnMR2NudJcjOzEaDOxG0oIgk6JDdooIkovnO8S7FfpHjEGmPFwxZt3k6K9/GqAm3V9jbrgNigx0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748617037; c=relaxed/simple;
	bh=2bKoqGkTK8TGfOw3TU7zJS2dU0yhvXeqK4PS3k36Lvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ki+VjmCqAAEDTuVMMTpZq1TleKDEMYxLGBlrXGZiiBXKw2YezNyIBhfZLYxrSSTzQM9aZntHlDYaYIaCVUvQKg+m1Cvv8aoP78uMpG0aU9JqbLM/NwBM+Re2gGTmYYa+sZSMohFawvPnhTRXKthTdM80ZeF7Lh8AyLV3yhe1sPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EfsWaHgt; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6000791e832so9622a12.1
        for <linux-arch@vger.kernel.org>; Fri, 30 May 2025 07:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748617033; x=1749221833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYR9KSVXGeLcD6aMhoTQngJaFUt3s4XvW1lNxkA24To=;
        b=EfsWaHgtU38oZL7F2kYZYCzuUJQP+URxvaVP4iTlvbT3LWyQgqOvENx6Xf7t8nAq3Y
         NeEpqf3xUXbyK18W4B9p4n0553t0JtqmVDZH4QCXYJWPrFx/mIWJlw6yeP4gDwkl9GSO
         Nl187uGBofx46ry1j43MKRGLt2n6Uo1fs2S1z+oV1EzlHyMb8USYR5amoIVYiMwCzYNu
         U6i4Cs5hl0Uu7rZqZdlLGMkSQyDTWn+uQdKX21hpfDRSYSdydocS/tBNgBYQ/Ch/SXLD
         bWnhTQcoOV5c3iPj3Win/OyU4uc8K4/v4dFeuFtk3FLho1V8KAMVaeD1rjp5mHcehs3q
         cX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748617033; x=1749221833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYR9KSVXGeLcD6aMhoTQngJaFUt3s4XvW1lNxkA24To=;
        b=O6YDeWI3XxpfVS82PG0P+fAHoaeJDb/Bz9WN/xe6mqSMHA9nwZRpen4NbrdMo/o3Bc
         BK8zeVXj/LQmJIGxRBV2vpZT/3ndfvJQhIzcHXluIVz00iHCFQNNkujvnHalfwcl691T
         38Goakb+Zi+XFLXM94kUnR8w+NQfJhlIel2HpGo/rNus955VqaM60SwsP3dQQa4oUl2H
         Q8R7thEBPOsibFRGXkQMXzKtUMPdE97+XPPgOcq/7bGvBjBYgyaBVU6v8e9MrixV+EgM
         icqcRx3Jdb2geOD8FpEoVYpyJBpr3P+m8KdUADrogNRhy6q6yfjiuMeYdfJ+4U6oeY5l
         OsXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+w+OY0qUkLETIVYitc4SoDXeyOYvvzU2oMuDUx+LgPTqbciRRaEXjd2H1JmgQwqb5bfORFIcL9AgF@vger.kernel.org
X-Gm-Message-State: AOJu0YyG1SQSqSNL+bI9N8Ih39hvgHcLEx4s8exx78DnaqY2KRzuPJbP
	n/Gocl3d49yNxLHTIwHuozNgxucIU+CB1hZX3uyfYeUPqNeB/czUf+IrSLqpdnPzaemMz/C/RtT
	m9IDN1vEivUFQKMbzfkaaD1fl5qC1SCYl77j5ZkyD
X-Gm-Gg: ASbGncspVykGDr+NPd/3qJ5eeEGSrNza3FLL5VEVMaSNEoMggpBLibiPQo/Og+LRAUH
	3mgcAO1DMf0Wwf/9Drfi1Dn7POGJVTE74+qJRuM2wPOfiJjBi00Iyllv13oSP9kgx7W4HDYJ6Xt
	HmXKUNrMj+UI0Jdxa5/lUlWY5oR3iNWmLVJ9L5U0Zki73+M8i0iFFpWN2a9mNkWzN7mqx7ND4=
X-Google-Smtp-Source: AGHT+IGtLgtmO5+VAn+ilNY65s7bK5aPk8FoylUaz7kb6+EtS0xNQceBbHcJ/v5ufPboiu58SJqssv3PWYXJ8bWNBj4=
X-Received: by 2002:a50:f608:0:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-60577a55f40mr80215a12.7.1748617033078; Fri, 30 May 2025
 07:57:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404021902.48863-1-anthony.yznaga@oracle.com> <20250404021902.48863-13-anthony.yznaga@oracle.com>
In-Reply-To: <20250404021902.48863-13-anthony.yznaga@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 30 May 2025 16:56:37 +0200
X-Gm-Features: AX0GCFvi1yc7NtKBfRl9VGi7Izwkw6ZmWdTqjh7DsYfRRlKYZBj3cwJ62DAsuQ8
Message-ID: <CAG48ez0gzjbumcECmE39dxsF9TTtR0ED3L7WdKdW4RupZDRyWA@mail.gmail.com>
Subject: Re: [PATCH v2 12/20] mm/mshare: prepare for page table sharing support
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com, 
	viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org, 
	andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org, 
	brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com, 
	catalin.marinas@arm.com, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org, 
	rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com, 
	pcc@google.com, neilb@suse.de, maz@kernel.org, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Liam Howlett <liam.howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 4:18=E2=80=AFAM Anthony Yznaga <anthony.yznaga@oracl=
e.com> wrote:
> In preparation for enabling the handling of page faults in an mshare
> region provide a way to link an mshare shared page table to a process
> page table and otherwise find the actual vma in order to handle a page
> fault. Modify the unmap path to ensure that page tables in mshare regions
> are unlinked and kept intact when a process exits or an mshare region
> is explicitly unmapped.
>
> Signed-off-by: Khalid Aziz <khalid@kernel.org>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
[...]
> diff --git a/mm/memory.c b/mm/memory.c
> index db558fe43088..68422b606819 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
[...]
> @@ -259,7 +260,10 @@ static inline void free_p4d_range(struct mmu_gather =
*tlb, pgd_t *pgd,
>                 next =3D p4d_addr_end(addr, end);
>                 if (p4d_none_or_clear_bad(p4d))
>                         continue;
> -               free_pud_range(tlb, p4d, addr, next, floor, ceiling);
> +               if (unlikely(shared_pud))
> +                       p4d_clear(p4d);
> +               else
> +                       free_pud_range(tlb, p4d, addr, next, floor, ceili=
ng);
>         } while (p4d++, addr =3D next, addr !=3D end);
>
>         start &=3D PGDIR_MASK;
[...]
> +static void mshare_vm_op_unmap_page_range(struct mmu_gather *tlb,
> +                               struct vm_area_struct *vma,
> +                               unsigned long addr, unsigned long end,
> +                               struct zap_details *details)
> +{
> +       /*
> +        * The msharefs vma is being unmapped. Do not unmap pages in the
> +        * mshare region itself.
> +        */
> +}

Unmapping a VMA has three major phases:

1. unlinking the VMA from the VMA tree
2. removing the VMA contents
3. removing unneeded page tables

The MM subsystem broadly assumes that after phase 2, no stuff is
mapped in the region anymore and therefore changes to the backing file
don't need to TLB-flush this VMA anymore, and unlinks the mapping from
rmaps and such. If munmap() of an mshare region only removes the
mapping of shared page tables in step 3, as implemented here, that
means things like TLB flushes won't be able to discover all
currently-existing mshare mappings of a host MM through rmap walks.

I think it would make more sense to remove the links to shared page
tables in step 2 (meaning in mshare_vm_op_unmap_page_range), just like
hugetlb does, and not modify free_pgtables().

>  static const struct vm_operations_struct msharefs_vm_ops =3D {
>         .may_split =3D mshare_vm_op_split,
>         .mprotect =3D mshare_vm_op_mprotect,
> +       .unmap_page_range =3D mshare_vm_op_unmap_page_range,
>  };
>
>  /*
> --
> 2.43.5
>

