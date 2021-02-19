Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D746E31F75C
	for <lists+linux-arch@lfdr.de>; Fri, 19 Feb 2021 11:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBSKgP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Feb 2021 05:36:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:39766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhBSKgO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Feb 2021 05:36:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613730927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7EbNQMFcSNI0oMItBkDkX6r6vOi1t5rzTfwIGyjH8mk=;
        b=NNrBTsfniB4NnydtCSgc8ZsIFoWLIMNsTMJUjTrG2N9/X9kOUGuSMsm0kIrNGWfZy8Ik0c
        V2RTEJyYrvOlxtcC7JiV4cm5jwugeQTy+CvzXaXIFvOJRB3HCp9B4g3N2Gc7kfqiWAwgGp
        9Bjxeh8YcPgEkWrYVdU3mSW+cXWDcUg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9AEDBAC6E;
        Fri, 19 Feb 2021 10:35:27 +0000 (UTC)
Date:   Fri, 19 Feb 2021 11:35:21 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>, Jann Horn <jannh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH RFC] mm/madvise: introduce MADV_POPULATE to
 prefault/prealloc memory
Message-ID: <YC+UaTVUn0o4Zynz@dhcp22.suse.cz>
References: <20210217154844.12392-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217154844.12392-1-david@redhat.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed 17-02-21 16:48:44, David Hildenbrand wrote:
[...]

I only got  to the implementation now.

> +static long madvise_populate(struct vm_area_struct *vma,
> +			     struct vm_area_struct **prev,
> +			     unsigned long start, unsigned long end)
> +{
> +	struct mm_struct *mm = vma->vm_mm;
> +	unsigned long tmp_end;
> +	int locked = 1;
> +	long pages;
> +
> +	*prev = vma;
> +
> +	while (start < end) {
> +		/*
> +		 * We might have temporarily dropped the lock. For example,
> +		 * our VMA might have been split.
> +		 */
> +		if (!vma || start >= vma->vm_end) {
> +			vma = find_vma(mm, start);
> +			if (!vma)
> +				return -ENOMEM;
> +		}

Why do you need to find a vma when you already have one. do_madvise will
give you your vma already. I do understand that you want to finish the
vma for some errors but that shouldn't require handling vmas. You should
be in the shope of one here unless I miss anything.

> +
> +		/* Bail out on incompatible VMA types. */
> +		if (vma->vm_flags & (VM_IO | VM_PFNMAP) ||
> +		    !vma_is_accessible(vma)) {
> +			return -EINVAL;
> +		}
> +
> +		/*
> +		 * Populate pages and take care of VM_LOCKED: simulate user
> +		 * space access.
> +		 *
> +		 * For private, writable mappings, trigger a write fault to
> +		 * break COW (i.e., shared zeropage). For other mappings (i.e.,
> +		 * read-only, shared), trigger a read fault.
> +		 */
> +		tmp_end = min_t(unsigned long, end, vma->vm_end);
> +		pages = populate_vma_page_range(vma, start, tmp_end, &locked);
> +		if (!locked) {
> +			mmap_read_lock(mm);
> +			*prev = NULL;
> +			vma = NULL;
> +		}
> +		if (pages < 0) {
> +			switch (pages) {
> +			case -EINTR:
> +			case -ENOMEM:
> +				return pages;
> +			case -EHWPOISON:
> +				/* Skip over any poisoned pages. */
> +				start += PAGE_SIZE;
> +				continue;
> +			case -EBUSY:
> +			case -EAGAIN:
> +				continue;
> +			default:
> +				pr_warn_once("%s: unhandled return value: %ld\n",
> +					     __func__, pages);
> +				return -ENOMEM;
> +			}
> +		}
> +		start += pages * PAGE_SIZE;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * Application wants to free up the pages and associated backing store.
>   * This is effectively punching a hole into the middle of a file.
> @@ -934,6 +1001,8 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
>  	case MADV_FREE:
>  	case MADV_DONTNEED:
>  		return madvise_dontneed_free(vma, prev, start, end, behavior);
> +	case MADV_POPULATE:
> +		return madvise_populate(vma, prev, start, end);
>  	default:
>  		return madvise_behavior(vma, prev, start, end, behavior);
>  	}
> @@ -954,6 +1023,7 @@ madvise_behavior_valid(int behavior)
>  	case MADV_FREE:
>  	case MADV_COLD:
>  	case MADV_PAGEOUT:
> +	case MADV_POPULATE:
>  #ifdef CONFIG_KSM
>  	case MADV_MERGEABLE:
>  	case MADV_UNMERGEABLE:
> -- 
> 2.29.2
> 

-- 
Michal Hocko
SUSE Labs
