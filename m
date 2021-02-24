Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC4332416D
	for <lists+linux-arch@lfdr.de>; Wed, 24 Feb 2021 17:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbhBXP4F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Feb 2021 10:56:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41775 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233765AbhBXPIN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Feb 2021 10:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614179169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hE/JW8Dw5e6ABCMHC+aiwNgbhT17E1ZqRTDBWqvHAHE=;
        b=cfyexALChXT7zf6RREJ6miqZmVm7cMzstEPTMK/60c0vQpYfudYhR/1wnmhOp1U8bOmvlw
        iMfhOLHmwQWwHCQmdt8KONIfQeSZDG+NCNYjOnt4rsadI0dpuWps7iNJt4Tsr7vUqoaQZi
        j3SyFP/HVH0FdusxSM6519z7aILY9HY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-WeJ4SY0uNIOI_e9AL1yUkw-1; Wed, 24 Feb 2021 10:06:05 -0500
X-MC-Unique: WeJ4SY0uNIOI_e9AL1yUkw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A17918C6C52;
        Wed, 24 Feb 2021 14:38:34 +0000 (UTC)
Received: from [10.36.114.83] (ovpn-114-83.ams2.redhat.com [10.36.114.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B293D19D9C;
        Wed, 24 Feb 2021 14:38:25 +0000 (UTC)
Subject: Re: [PATCH RFC] mm/madvise: introduce MADV_POPULATE to
 prefault/prealloc memory
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>,
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
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
References: <20210217154844.12392-1-david@redhat.com>
 <4bb9071b-e6c1-a732-0ed6-46aff0eaa70c@redhat.com>
Organization: Red Hat GmbH
Message-ID: <0f1c6f39-6a51-f8a6-8542-be1eb9c6fa0a@redhat.com>
Date:   Wed, 24 Feb 2021 15:38:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <4bb9071b-e6c1-a732-0ed6-46aff0eaa70c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 24.02.21 15:25, David Hildenbrand wrote:
>> +		tmp_end = min_t(unsigned long, end, vma->vm_end);
>> +		pages = populate_vma_page_range(vma, start, tmp_end, &locked);
>> +		if (!locked) {
>> +			mmap_read_lock(mm);
>> +			*prev = NULL;
>> +			vma = NULL;
> 
> ^ locked = 1; is missing here.
> 
> 
> --- Simple benchmark ---
> 
> I implemented MADV_POPULATE_READ and MADV_POPULATE_WRITE and performed
> some simple measurements to simulate memory preallocation with empty files:
> 
> 1) mmap a 2 MiB/128 MiB/4 GiB region (anonymous, memfd, memfd hugetlb)
> 2) Discard all memory using fallocate/madvise
> 3) Prefault memory using different approaches and measure the time this
>      takes.
> 
> I repeat 2)+3) 10 times and compute the average. I only use a single thread.
> 
> Read: Read from each page a byte.
> Write: Write one byte of each page (0).
> Read/Write: Read one byte and write the value back for each page
> POPULATE: MADV_POPULATE (this patch)
> POPULATE_READ: MADV_POPULATE_READ
> POPULATE_WRITE: MADV_POPULATE_WRITE
> 
> --- Benchmark results ---
> 
> Measuring 10 iterations each:
> ==================================================
> 2 MiB MAP_PRIVATE:
> **************************************************
> Anonymous      : Read           :     0.159 ms
> Anonymous      : Write          :     0.244 ms
> Anonymous      : Read+Write     :     0.383 ms
> Anonymous      : POPULATE       :     0.167 ms
> Anonymous      : POPULATE_READ  :     0.064 ms
> Anonymous      : POPULATE_WRITE :     0.165 ms
> Memfd 4 KiB    : Read           :     0.401 ms
> Memfd 4 KiB    : Write          :     0.056 ms
> Memfd 4 KiB    : Read+Write     :     0.075 ms
> Memfd 4 KiB    : POPULATE       :     0.057 ms
> Memfd 4 KiB    : POPULATE_READ  :     0.337 ms
> Memfd 4 KiB    : POPULATE_WRITE :     0.056 ms
> Memfd 2 MiB    : Read           :     0.041 ms
> Memfd 2 MiB    : Write          :     0.030 ms
> Memfd 2 MiB    : Read+Write     :     0.031 ms
> Memfd 2 MiB    : POPULATE       :     0.031 ms
> Memfd 2 MiB    : POPULATE_READ  :     0.031 ms
> Memfd 2 MiB    : POPULATE_WRITE :     0.031 ms
> **************************************************
> 2 MiB MAP_SHARED:
> **************************************************
> Anonymous      : Read           :     0.071 ms
> Anonymous      : Write          :     0.181 ms
> Anonymous      : Read+Write     :     0.081 ms
> Anonymous      : POPULATE       :     0.069 ms
> Anonymous      : POPULATE_READ  :     0.069 ms
> Anonymous      : POPULATE_WRITE :     0.115 ms
> Memfd 4 KiB    : Read           :     0.401 ms
> Memfd 4 KiB    : Write          :     0.351 ms
> Memfd 4 KiB    : Read+Write     :     0.414 ms
> Memfd 4 KiB    : POPULATE       :     0.338 ms
> Memfd 4 KiB    : POPULATE_READ  :     0.339 ms
> Memfd 4 KiB    : POPULATE_WRITE :     0.279 ms
> Memfd 2 MiB    : Read           :     0.031 ms
> Memfd 2 MiB    : Write          :     0.031 ms
> Memfd 2 MiB    : Read+Write     :     0.031 ms
> Memfd 2 MiB    : POPULATE       :     0.031 ms
> Memfd 2 MiB    : POPULATE_READ  :     0.031 ms
> Memfd 2 MiB    : POPULATE_WRITE :     0.031 ms
> **************************************************
> 128 MiB MAP_PRIVATE:
> **************************************************
> Anonymous      : Read           :     7.517 ms
> Anonymous      : Write          :    22.503 ms
> Anonymous      : Read+Write     :    33.186 ms
> Anonymous      : POPULATE       :    18.381 ms
> Anonymous      : POPULATE_READ  :     3.952 ms
> Anonymous      : POPULATE_WRITE :    18.354 ms
> Memfd 4 KiB    : Read           :    34.300 ms
> Memfd 4 KiB    : Write          :     4.659 ms
> Memfd 4 KiB    : Read+Write     :     6.531 ms
> Memfd 4 KiB    : POPULATE       :     5.219 ms
> Memfd 4 KiB    : POPULATE_READ  :    29.744 ms
> Memfd 4 KiB    : POPULATE_WRITE :     5.244 ms
> Memfd 2 MiB    : Read           :    10.228 ms
> Memfd 2 MiB    : Write          :    10.130 ms
> Memfd 2 MiB    : Read+Write     :    10.190 ms
> Memfd 2 MiB    : POPULATE       :    10.007 ms
> Memfd 2 MiB    : POPULATE_READ  :    10.008 ms
> Memfd 2 MiB    : POPULATE_WRITE :    10.010 ms
> **************************************************
> 128 MiB MAP_SHARED:
> **************************************************
> Anonymous      : Read           :     7.295 ms
> Anonymous      : Write          :    15.234 ms
> Anonymous      : Read+Write     :     7.460 ms
> Anonymous      : POPULATE       :     5.196 ms
> Anonymous      : POPULATE_READ  :     5.190 ms
> Anonymous      : POPULATE_WRITE :     8.245 ms
> Memfd 4 KiB    : Read           :    34.412 ms
> Memfd 4 KiB    : Write          :    30.586 ms
> Memfd 4 KiB    : Read+Write     :    35.157 ms
> Memfd 4 KiB    : POPULATE       :    29.643 ms
> Memfd 4 KiB    : POPULATE_READ  :    29.691 ms
> Memfd 4 KiB    : POPULATE_WRITE :    25.790 ms
> Memfd 2 MiB    : Read           :    10.210 ms
> Memfd 2 MiB    : Write          :    10.074 ms
> Memfd 2 MiB    : Read+Write     :    10.068 ms
> Memfd 2 MiB    : POPULATE       :    10.034 ms
> Memfd 2 MiB    : POPULATE_READ  :    10.037 ms
> Memfd 2 MiB    : POPULATE_WRITE :    10.031 ms
> **************************************************
> 4096 MiB MAP_PRIVATE:
> **************************************************
> Anonymous      : Read           :   240.947 ms
> Anonymous      : Write          :   712.941 ms
> Anonymous      : Read+Write     :  1027.636 ms
> Anonymous      : POPULATE       :   571.816 ms
> Anonymous      : POPULATE_READ  :   120.215 ms
> Anonymous      : POPULATE_WRITE :   570.750 ms
> Memfd 4 KiB    : Read           :  1054.739 ms
> Memfd 4 KiB    : Write          :   145.534 ms
> Memfd 4 KiB    : Read+Write     :   202.275 ms
> Memfd 4 KiB    : POPULATE       :   162.597 ms
> Memfd 4 KiB    : POPULATE_READ  :   914.747 ms
> Memfd 4 KiB    : POPULATE_WRITE :   161.281 ms
> Memfd 2 MiB    : Read           :   351.818 ms
> Memfd 2 MiB    : Write          :   352.357 ms
> Memfd 2 MiB    : Read+Write     :   352.762 ms
> Memfd 2 MiB    : POPULATE       :   351.471 ms
> Memfd 2 MiB    : POPULATE_READ  :   351.553 ms
> Memfd 2 MiB    : POPULATE_WRITE :   351.931 ms
> **************************************************
> 4096 MiB MAP_SHARED:
> **************************************************
> Anonymous      : Read           :   229.338 ms
> Anonymous      : Write          :   478.964 ms
> Anonymous      : Read+Write     :   234.546 ms
> Anonymous      : POPULATE       :   161.635 ms
> Anonymous      : POPULATE_READ  :   160.943 ms
> Anonymous      : POPULATE_WRITE :   252.686 ms
> Memfd 4 KiB    : Read           :  1052.828 ms
> Memfd 4 KiB    : Write          :   929.237 ms
> Memfd 4 KiB    : Read+Write     :  1074.494 ms
> Memfd 4 KiB    : POPULATE       :   915.663 ms
> Memfd 4 KiB    : POPULATE_READ  :   915.001 ms
> Memfd 4 KiB    : POPULATE_WRITE :   787.388 ms
> Memfd 2 MiB    : Read           :   353.580 ms
> Memfd 2 MiB    : Write          :   353.197 ms
> Memfd 2 MiB    : Read+Write     :   353.172 ms
> Memfd 2 MiB    : POPULATE       :   353.686 ms
> Memfd 2 MiB    : POPULATE_READ  :   353.465 ms
> Memfd 2 MiB    : POPULATE_WRITE :   352.776 ms
> **************************************************
> 
> 
> --- Discussion ---
> 
> 1) With huge pages, the performance benefit is negligible with the sizes
> I tried, because there are little actual page faults. Most time is spent
> zeroing huge pages I guess. It will take quite a lot of memory to pay off.
> 
> 2) In all 4k cases, the POPULATE_READ/POPULATE_WRITE variants are faster
> than manually reading or writing from user space.

Forgot to mention one case: Except on Memfd 4 KiB with MAP_PRIVATE: 
POPULATE_WRITE is slower than a simple write. And a read fault is 
exceptionally slower than a write fault (what?).

-- 
Thanks,

David / dhildenb

