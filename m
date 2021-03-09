Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16075332097
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 09:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCIIcI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 03:32:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhCIIbi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Mar 2021 03:31:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615278698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GfRwAlMZCg89ixlFNqb8ULyiVLWTEnJ0ZTo2SVvckic=;
        b=CH+i4QPkunJX/NZXYNqQi4Ubq96hhT7rM+LYoka3gH0+in8L9h386UxGMiw48WNKcTZstj
        sm7tvwHV+B8TIIUQg1ej5OMweDxFO2aFxwB9fSU0nk00/t/AoRRh174tJ/56+pHKKwg2I+
        PqL9ef12+fAGVx/Ce+zIS020+LIErNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-MC5HpSYcPlGBNWdwQsIzjw-1; Tue, 09 Mar 2021 03:31:34 -0500
X-MC-Unique: MC5HpSYcPlGBNWdwQsIzjw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B8C580432D;
        Tue,  9 Mar 2021 08:31:30 +0000 (UTC)
Received: from [10.36.114.143] (ovpn-114-143.ams2.redhat.com [10.36.114.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D1BF6062F;
        Tue,  9 Mar 2021 08:31:14 +0000 (UTC)
Subject: Re: [PATCH RFCv2] mm/madvise: introduce MADV_POPULATE_(READ|WRITE) to
 prefault/prealloc memory
To:     Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
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
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
References: <20210308164520.18323-1-david@redhat.com>
 <6ecd754406fffe851be6543025203b6b@sf-tec.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <00fcfc37-e288-8ffe-a443-c2f5054deee9@redhat.com>
Date:   Tue, 9 Mar 2021 09:31:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <6ecd754406fffe851be6543025203b6b@sf-tec.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 09.03.21 08:35, Rolf Eike Beer wrote:
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 9902648f2206..a5c4ed23b1db 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -340,6 +340,9 @@ void __vma_unlink_list(struct mm_struct *mm,
>> struct vm_area_struct *vma);
>>   #ifdef CONFIG_MMU
>>   extern long populate_vma_page_range(struct vm_area_struct *vma,
>>   		unsigned long start, unsigned long end, int *nonblocking);
>> +extern long faultin_vma_page_range(struct vm_area_struct *vma,
>> +				   unsigned long start, unsigned long end,
>> +				   bool write, int *nonblocking);
>>   extern void munlock_vma_pages_range(struct vm_area_struct *vma,
>>   			unsigned long start, unsigned long end);
>>   static inline void munlock_vma_pages_all(struct vm_area_struct *vma)
> 
> The parameter name does not match the one in the implementation.
> 
> Otherwise the implementation looks fine AFAICT.

Hehe, you can tell how I copy-pasted from populate_vma_page_range(), 
because there, the variable names are messed up, too :)

Will fix (most probably populate_vma_page_range() as well in a cleanup 
patch), thanks!

-- 
Thanks,

David / dhildenb

