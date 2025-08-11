Return-Path: <linux-arch+bounces-13114-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DE7B2031D
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 11:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C37637A20BE
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 09:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C0720326;
	Mon, 11 Aug 2025 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lG/fmn9y"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A91FC109;
	Mon, 11 Aug 2025 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904005; cv=none; b=iYFW+eluHQWn55OuHk6IdahtJiWGFGZnY3LLI7rQWSBnNuRpqMhnFQKlzOH+MW0OhYbGLZR4FfXM6FCSrnQzw1jf6Rffvwln75w+Bg08E7JMgsGm8QyOH8QTfXNxPyybFIlJSRR1OeGHWg8Dnm8J5qbY+whqyOstDx2jv7GHGJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904005; c=relaxed/simple;
	bh=kDTUSgEstOg8AcvyHgZdbab++wrodPpsdtlCtIN9Kfs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTzq9xkSGZ1ttYycIvzZJIfSWRoCTOk/1SAhpsNCRxNFPdpl97B0nC3IKhTSULUIJj3p8Udp2fNBL/eaiud2+uvTsXSXQTb6+nBitaWsFgmLXbl3MZBC8rbAI9TDVxRie9RtKxChXiELqzMiP8OZ8BYMzAn2PL4o/ximkiV2wKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lG/fmn9y; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-556fd896c99so3555420e87.3;
        Mon, 11 Aug 2025 02:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754904002; x=1755508802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fLY040Of3yhdDWokuw+L+nE0pmeX/ImH14JZx346nu0=;
        b=lG/fmn9yAWNI+cS35fgI95okvtxKptbW6z2u2PueGTs9vUS/8T1xnz0KNz/I+A631b
         gGIIVhfIodac7ySAXgnogMlqriVvprlpjyIkXvIJTcG8/Y8KQJUF7L0w0vMsdNh/Om86
         5VrdyTwBbFMdP64+T1TeZcrpkDSYvLUEL/or/GtzvfO56yq+I7w9ycgUchVLwB9ZWbg3
         dhwh5XNHFh54FADf2PrQ0ur9yoJt//AKj/3nMtyT6kHLxN5V+FioTPJZSskjEf66W5iQ
         efF292TZRdPTLkaiGH952s46f36zzcy6IGq2F/TGGv1gJ4TUYv9U03SfnwuwDxjtbFep
         Q/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754904002; x=1755508802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLY040Of3yhdDWokuw+L+nE0pmeX/ImH14JZx346nu0=;
        b=gGn1UfaBQ1nYCUEbgqXZqNI/9w5o7wH9Ds2fZkUNXAeWGh/l6R+AyGBTNtPNz3aK3v
         /PH+jxDLfufu3PctHXusafsU5K/2HD0R2/VPjdm13LrUM4hYr0xWGkBaePewJ2StzKAU
         bVUKkSnfWnAjtoQSYkPnLi6XFl00BWCjRpDkmbs248ZThGY46BrWHtsChU31Wj3pEKXo
         bU6bxRo9s/TO1hsQpi5wcV8uP0wR1/k2peG7dYStOZzdpAACyBZdaY5tBK6+lq5H03fI
         ic8YGREr1XVkgyMfBVHrEvuEUE5kQHpt4E+z7uGu5BWcI1jLuwoLCOgSjSCECnerw11y
         6fHw==
X-Forwarded-Encrypted: i=1; AJvYcCUlWDN1c0hokHimpzgOybCWojI7Fnr1LAmmTCWvelL3eYbyV5T9rTx6NH/nHuRkPoxC+s1pgQ4J@vger.kernel.org, AJvYcCW8JQDnxRHeCz5yPzJ9DRK+4nIMslQKfVT1NawUB1JIbe8tFXHjc8i+eb9bc+P2GjbV6BRA41C3Tz+QnG9O@vger.kernel.org, AJvYcCXF2U18rM2c6IJ1a4pEeMrts5pjd03oSdZYcAUAPtNR/YrjRxbVsGgiClJ5ZuvdKDU4Q5ArAu/+Ts+g@vger.kernel.org
X-Gm-Message-State: AOJu0YyjcpFQyeFQt8PStLOqKt8FAqkRXFiH15kFGIqeBauurx7mj9u9
	lKKg2tr7avGI2gfmNu2HgpVpFRS112YiZimTOT1ZTS3fkbLXbMlrbKWE
X-Gm-Gg: ASbGnct7eBpm3j7q5qD/T0q73jwJ08fJvTR7+9f0pj4yQhv9x1vD2VwHmPcKNvsVlfh
	b9Z6UwdximAAQlzzwdEEOJVnbtm9C4r0STobF9l7m5fVHT5/P4Eat8SFyWQvIJjSxGNajMzCSs3
	pzjKgsRmPMwjlBVOx+y4cx7FQbcdZywoOpFn866+MPIQcWqtxh52ZZB4yMtEVimHbSNio3XS/zf
	LbyXpk29hQTnJBGe8Usxb7bH1KIXjpdruqh2NI67LWNZ7Czieg+sbfDsF/eF5+MeXqW7S07Mf6N
	dIR+UzfcSPyhJsbJCXN6iDH2Aosh13lg0raJpRj9MWtRgTPBLStbLedTdrDslVgaSsXUQ4ZY77K
	VnYF0cUbH1RZHJx4tCQPZPProMIpeaTx7V+PgG2twss1aspTYhg==
X-Google-Smtp-Source: AGHT+IGpCY6KOvg3QSYUnRILfbfaaXOePg+07gXfRkMy51cNJOdQvFG2SnzuWEcAl0oD7au0pSO4/A==
X-Received: by 2002:a05:6512:10d6:b0:55c:ad2a:aa7c with SMTP id 2adb3069b0e04-55cc0094c9cmr3053586e87.22.1754904001692;
        Mon, 11 Aug 2025 02:20:01 -0700 (PDT)
Received: from pc636 (host-95-203-26-173.mobileonline.telia.com. [95.203.26.173])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cce15c650sm806954e87.103.2025.08.11.02.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:20:01 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 11 Aug 2025 11:19:57 +0200
To: Mike Rapoport <rppt@kernel.org>, Harry Yoo <harry.yoo@oracle.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, Dennis Zhou <dennis@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Hildenbrand <david@redhat.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	Alexander Potapenko <glider@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Huth <thuth@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Oscar Salvador <osalvador@suse.de>, Jane Chu <jane.chu@oracle.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Alistair Popple <apopple@nvidia.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	linux-arch@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH V4 mm-hotfixes 1/3] mm: move page table sync declarations
 to linux/pgtable.h
Message-ID: <aJm1vQ2D1YOhipos@pc636>
References: <20250811053420.10721-1-harry.yoo@oracle.com>
 <20250811053420.10721-2-harry.yoo@oracle.com>
 <aJmkX3JBhH3F0PEC@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJmkX3JBhH3F0PEC@kernel.org>

On Mon, Aug 11, 2025 at 11:05:51AM +0300, Mike Rapoport wrote:
> On Mon, Aug 11, 2025 at 02:34:18PM +0900, Harry Yoo wrote:
> > Move ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings() to
> > linux/pgtable.h so that they can be used outside of vmalloc and ioremap.
> > 
> > Cc: <stable@vger.kernel.org>
> > Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> >  include/linux/pgtable.h | 16 ++++++++++++++++
> >  include/linux/vmalloc.h | 16 ----------------
> >  2 files changed, 16 insertions(+), 16 deletions(-)
> > 
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index 4c035637eeb7..ba699df6ef69 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -1467,6 +1467,22 @@ static inline void modify_prot_commit_ptes(struct vm_area_struct *vma, unsigned
> >  }
> >  #endif
> >  
> > +/*
> > + * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
> > + * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
> 
> If ARCH_PAGE_TABLE_SYNC_MASK can be used outside vmalloc(), the comment
> needs an update, maybe
> 
> ... and let the generic code that modifies kernel page tables
> 
> Other than that
> 
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> > + * needs to be called.
> > + */
> > +#ifndef ARCH_PAGE_TABLE_SYNC_MASK
> > +#define ARCH_PAGE_TABLE_SYNC_MASK 0
> > +#endif
> > +
> > +/*
> > + * There is no default implementation for arch_sync_kernel_mappings(). It is
> > + * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
> > + * is 0.
> > + */
> > +void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
> > +
> >  #endif /* CONFIG_MMU */
> >  
> >  /*
> > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > index fdc9aeb74a44..2759dac6be44 100644
> > --- a/include/linux/vmalloc.h
> > +++ b/include/linux/vmalloc.h
> > @@ -219,22 +219,6 @@ extern int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
> >  int vmap_pages_range(unsigned long addr, unsigned long end, pgprot_t prot,
> >  		     struct page **pages, unsigned int page_shift);
> >  
> > -/*
> > - * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
> > - * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
> > - * needs to be called.
> > - */
> > -#ifndef ARCH_PAGE_TABLE_SYNC_MASK
> > -#define ARCH_PAGE_TABLE_SYNC_MASK 0
> > -#endif
> > -
> > -/*
> > - * There is no default implementation for arch_sync_kernel_mappings(). It is
> > - * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
> > - * is 0.
> > - */
> > -void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
> > -
> >  /*
> >   *	Lowlevel-APIs (not for driver use!)
> >   */
> > -- 
> > 2.43.0
> > 
> 
LGTM,

Reviewed-by: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

--
Uladzislau Rezki

