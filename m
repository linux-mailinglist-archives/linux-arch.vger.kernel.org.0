Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153D7324C31
	for <lists+linux-arch@lfdr.de>; Thu, 25 Feb 2021 09:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbhBYIm4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Feb 2021 03:42:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40015 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235937AbhBYImz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Feb 2021 03:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614242487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fqVSsomUJyTIz0gYNIicWiu4aghYekNv2Fcx+hAQcqI=;
        b=K/EyGxpKoi/b0hZJq1sY7H7Ow64L9FTGwwv1Mtt1aqbuTQee4dR4SjcoU8oMFhzKNmBql/
        1NN+EPP7O/AE9TNEId3x637Q3J+pz6bLK0Qw2FYKezMu4nhq3AkGrrG/6nUpJ4JsXm28sV
        KZhd1IkBrbeeVS03NjpDfvGiZqXrpjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-PdpzTNHiPv2rFA2I1NLbbQ-1; Thu, 25 Feb 2021 03:41:24 -0500
X-MC-Unique: PdpzTNHiPv2rFA2I1NLbbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 007DA100CCC3;
        Thu, 25 Feb 2021 08:41:19 +0000 (UTC)
Received: from [10.36.114.58] (ovpn-114-58.ams2.redhat.com [10.36.114.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F11318A9E;
        Thu, 25 Feb 2021 08:41:07 +0000 (UTC)
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
Subject: Re: [PATCH RFC] mm/madvise: introduce MADV_POPULATE to
 prefault/prealloc memory
Message-ID: <e78dfe59-3552-91f1-e234-5f37d2600eb6@redhat.com>
Date:   Thu, 25 Feb 2021 09:41:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <4bb9071b-e6c1-a732-0ed6-46aff0eaa70c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
> 
> 
> What sticks out a bit is:
> 
> 3) For MAP_SHARED on anonymous memory, it is fastest to first read and
> then write memory. It's slightly faster than POPULATE_WRITE and quite a
> lot faster than a simple write - what?!. It's even faster than
> POPULATE_WRITE - what?! I assume with the read access we prepare a fresh
> zero page and with the write access we only have to change PTE access
> rights. But why is this faster than writing directly?

Okay, MADV_DONTNEED does not seem to really work on MAP_SHARED of 
anonymous memory. If I use a fresh mmap for each and every iteration the 
numbers make more sense:

**************************************************
4096 MiB MAP_SHARED:
**************************************************
Anonymous      : Read           :  1054.154 ms
Anonymous      : Write          :   924.572 ms
Anonymous      : Read+Write     :  1075.215 ms
Anonymous      : POPULATE       :   911.386 ms
Anonymous      : POPULATE_READ  :   909.392 ms
Anonymous      : POPULATE_WRITE :   793.143 ms


-- 
Thanks,

David / dhildenb

