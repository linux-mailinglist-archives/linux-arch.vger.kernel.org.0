Return-Path: <linux-arch+bounces-13112-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD5DB20259
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 10:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 118307ADED1
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 08:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AC82DCC01;
	Mon, 11 Aug 2025 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKswWXSD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69942DCBF4;
	Mon, 11 Aug 2025 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902360; cv=none; b=bNazRd80hNxxONAmXfeX3J+YZcxIuzoT1auGPqP3JOAcQKrd0d5eDVAXtm+WNtS9O15l/TuPhxJwB/YVnDIBGqSqF16BPxzkb4T3tstawSeMxCd/Kb+CeiM/yMh/xsy2dzhSE5nMxaiH2q1no2ShHs72qlwDrqP+I+PZ50ybEzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902360; c=relaxed/simple;
	bh=3W7y2DSI+b+/NU/9fMvMcZ7Git3/YhU7rwsTKEuKhak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFukI4w3WbZlRERN/bEWCQdGjt/juAw75D/zUCaqkiyqGZAuNeXShUm+8HOyHwHO9IQ/6oSz3ZdacKZxvtuTxGlkQbU9T7JuWVdnM7zBMe79B8UFMf9hRKpDxeZMAGkODg/0B9J63SX78V6Uqb+zg7ZgvHt4RafO7a4b2DzpmnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKswWXSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B104C4CEED;
	Mon, 11 Aug 2025 08:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754902360;
	bh=3W7y2DSI+b+/NU/9fMvMcZ7Git3/YhU7rwsTKEuKhak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKswWXSDs8HligSv6I7X8TlRBaJTUYhj/n7fHdG1oe59j5so4v1z+qlk8ZCDJb4ud
	 NCWPA/ImWhMlfbMQ9eRX2/DISkTjV7vnmjihTP9atKiP0wPf4RsGvcszZ5od76OhgO
	 Scx4BYZWgcbI8ikoVLb5QZsRdd9nz6qRZXO/99WPYxnwgrNgvJMQOb56vJhUE3hCs3
	 xKaUqK1Ys+FCYEQ9k7jCV9uY1waWLHTRugMVYYKFfeMjbpoJn2j0ARIeWnBEPqDZVS
	 gXNPey55jmq0CWrZEL3jHhweH3xtUr+QegSdaQZe1gk4lyTS/L1JrEQdHlXOpG/Umn
	 mQHBS+oPTamRw==
Date: Mon, 11 Aug 2025 11:52:23 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Dennis Zhou <dennis@kernel.org>,
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
Message-ID: <aJmvR5mRJ2htKoss@kernel.org>
References: <20250811053420.10721-1-harry.yoo@oracle.com>
 <20250811053420.10721-2-harry.yoo@oracle.com>
 <aJmkX3JBhH3F0PEC@kernel.org>
 <aJmrpaeKKeNCV3G_@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJmrpaeKKeNCV3G_@hyeyoo>

On Mon, Aug 11, 2025 at 05:36:53PM +0900, Harry Yoo wrote:
> On Mon, Aug 11, 2025 at 11:05:51AM +0300, Mike Rapoport wrote:
> > On Mon, Aug 11, 2025 at 02:34:18PM +0900, Harry Yoo wrote:
> > > Move ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings() to
> > > linux/pgtable.h so that they can be used outside of vmalloc and ioremap.
> > > 
> > > Cc: <stable@vger.kernel.org>
> > > Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
> > > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > > ---
> > >  include/linux/pgtable.h | 16 ++++++++++++++++
> > >  include/linux/vmalloc.h | 16 ----------------
> > >  2 files changed, 16 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > > index 4c035637eeb7..ba699df6ef69 100644
> > > --- a/include/linux/pgtable.h
> > > +++ b/include/linux/pgtable.h
> > > @@ -1467,6 +1467,22 @@ static inline void modify_prot_commit_ptes(struct vm_area_struct *vma, unsigned
> > >  }
> > >  #endif
> > >  
> > > +/*
> > > + * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
> > > + * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
> > 
> > If ARCH_PAGE_TABLE_SYNC_MASK can be used outside vmalloc(), the comment
> > needs an update, maybe
> > 
> > ... and let the generic code that modifies kernel page tables
> 
> Right, and patch 2 updates the comment as it uses it outside vmalloc():
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index ba699df6ef69..0cf5c6c3e483 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1469,8 +1469,8 @@ static inline void modify_prot_commit_ptes(struct vm_area_struct *vma, unsigned
> 
>  /*
>   * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
> - * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
> - * needs to be called.
> + * and let generic vmalloc, ioremap and page table update code know when
> + * arch_sync_kernel_mappings() needs to be called.
>   */
>  #ifndef ARCH_PAGE_TABLE_SYNC_MASK
>  #define ARCH_PAGE_TABLE_SYNC_MASK 0
> 
> Or if you think "page table update code" is unclear, please let me know.

It's fine :)
 
> > Other than that
> > 
> > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> Thanks a lot for all the reviews, Mike!
> 
> -- 
> Cheers,
> Harry / Hyeonggon

-- 
Sincerely yours,
Mike.

