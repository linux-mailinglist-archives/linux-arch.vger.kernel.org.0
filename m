Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3F931F789
	for <lists+linux-arch@lfdr.de>; Fri, 19 Feb 2021 11:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBSKpf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Feb 2021 05:45:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhBSKpf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Feb 2021 05:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613731448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/qnTAKaudqj6ibNGsa7QgwKptXTuW5gHmbzgrK/ICxg=;
        b=AfLxL38byS238BmR8QkdWWQFdnzr+o9b1cT2FR6hWjljtxH8EAOSPiINwRQgE1mo/azwGS
        f24bEbZV2/9s6QmXUgn+aslZCvqHsbfTGIINoB0WwFHGWy0VGCHgzyC/CKJT2iRy6APs4T
        smdvCJ1ZVcPjOFRWcN1lLVvOawGvP9w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-CUgcwet2PZq5HCsyQx6W5A-1; Fri, 19 Feb 2021 05:44:06 -0500
X-MC-Unique: CUgcwet2PZq5HCsyQx6W5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78A86106BAA8;
        Fri, 19 Feb 2021 10:44:02 +0000 (UTC)
Received: from [10.36.113.117] (ovpn-113-117.ams2.redhat.com [10.36.113.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24E99171FE;
        Fri, 19 Feb 2021 10:43:50 +0000 (UTC)
Subject: Re: [PATCH RFC] mm/madvise: introduce MADV_POPULATE to
 prefault/prealloc memory
To:     Michal Hocko <mhocko@suse.com>
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
References: <20210217154844.12392-1-david@redhat.com>
 <YC+UaTVUn0o4Zynz@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <6e5a5bde-cedb-9d0a-f8c1-22406085b6b9@redhat.com>
Date:   Fri, 19 Feb 2021 11:43:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YC+UaTVUn0o4Zynz@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 19.02.21 11:35, Michal Hocko wrote:
> On Wed 17-02-21 16:48:44, David Hildenbrand wrote:
> [...]
> 
> I only got  to the implementation now.
> 
>> +static long madvise_populate(struct vm_area_struct *vma,
>> +			     struct vm_area_struct **prev,
>> +			     unsigned long start, unsigned long end)
>> +{
>> +	struct mm_struct *mm = vma->vm_mm;
>> +	unsigned long tmp_end;
>> +	int locked = 1;
>> +	long pages;
>> +
>> +	*prev = vma;
>> +
>> +	while (start < end) {
>> +		/*
>> +		 * We might have temporarily dropped the lock. For example,
>> +		 * our VMA might have been split.
>> +		 */
>> +		if (!vma || start >= vma->vm_end) {
>> +			vma = find_vma(mm, start);
>> +			if (!vma)
>> +				return -ENOMEM;
>> +		}
> 
> Why do you need to find a vma when you already have one. do_madvise will
> give you your vma already. I do understand that you want to finish the
> vma for some errors but that shouldn't require handling vmas. You should
> be in the shope of one here unless I miss anything.

See below, we might temporary drop the lock while not having processed 
all pages

> 
>> +
>> +		/* Bail out on incompatible VMA types. */
>> +		if (vma->vm_flags & (VM_IO | VM_PFNMAP) ||
>> +		    !vma_is_accessible(vma)) {
>> +			return -EINVAL;
>> +		}
>> +
>> +		/*
>> +		 * Populate pages and take care of VM_LOCKED: simulate user
>> +		 * space access.
>> +		 *
>> +		 * For private, writable mappings, trigger a write fault to
>> +		 * break COW (i.e., shared zeropage). For other mappings (i.e.,
>> +		 * read-only, shared), trigger a read fault.
>> +		 */
>> +		tmp_end = min_t(unsigned long, end, vma->vm_end);
>> +		pages = populate_vma_page_range(vma, start, tmp_end, &locked);
>> +		if (!locked) {
>> +			mmap_read_lock(mm);
>> +			*prev = NULL;
>> +			vma = NULL;

^ here

so, the VMA might have been replaced/split/... in the meantime.

So to make forward progress, I have to lookup again. (similar. but 
different to madvise_dontneed_free()).

-- 
Thanks,

David / dhildenb

