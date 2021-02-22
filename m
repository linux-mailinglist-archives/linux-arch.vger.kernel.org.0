Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84F03217E8
	for <lists+linux-arch@lfdr.de>; Mon, 22 Feb 2021 14:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhBVND2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Feb 2021 08:03:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35511 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230518AbhBVNBw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Feb 2021 08:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613998823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TRfCGo+d4jZVJhCFZnvsjweX1KWQd9768AoENBDOGlQ=;
        b=BEFr2n7xBBnCb9uC8PuhWmDBOJkeS2l2UIByrJQS1HifEHmiJJgkPYY1Ylq3CR5xEC9lBk
        GtRHvXVLsmUTuS7hzqnVAjNi5gJ/XIWBt/rgL+xBKPFABcEdGafhBBEdttExQhJ1qi9EOd
        Ow7MJnGJKGncXe+ysFTPiyMScAS7/+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-1hH8o-AHMaSAy3fNzDzl1g-1; Mon, 22 Feb 2021 08:00:09 -0500
X-MC-Unique: 1hH8o-AHMaSAy3fNzDzl1g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E7EF8799EC;
        Mon, 22 Feb 2021 13:00:06 +0000 (UTC)
Received: from [10.36.115.16] (ovpn-115-16.ams2.redhat.com [10.36.115.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5648872F85;
        Mon, 22 Feb 2021 12:59:56 +0000 (UTC)
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
 <640738b5-a47e-448b-586d-a1fb80131891@redhat.com>
 <YDOqA9nQHiuIrKBu@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <73f73cf2-1b4e-bfa9-9a4c-3192d7b7a5ec@redhat.com>
Date:   Mon, 22 Feb 2021 13:59:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDOqA9nQHiuIrKBu@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 22.02.21 13:56, Michal Hocko wrote:
> On Sat 20-02-21 10:12:26, David Hildenbrand wrote:
> [...]
>> Thinking about MADV_POPULATE vs. MADV_POPULATE_WRITE I wonder if it would be
>> more versatile to break with existing MAP_POPULATE semantics and directly go
>> with
>>
>> MADV_POPULATE_READ: simulate user space read access without actually
>> reading. Trigger a read fault if required.
>>
>> MADV_POPULATE_WRITE: simulate user space write access without actually
>> writing. Trigger a write fault if required.
>>
>> For my use case, I could use MADV_POPULATE_WRITE on anonymous memory and
>> RAM-backed files (shmem/hugetlb) - I would not have a minor fault when the
>> guest inside the VM first initializes memory. This mimics how QEMU currently
>> preallocates memory.
>>
>> However, I would use MADV_POPULATE_READ on any !RAM-backed files where we
>> actually have to write-back to a (slow?) device. Dirtying everything
>> although the guest might not actually consume it in the near future might be
>> undesired.
> 
> Isn't what the current mm_populate does?
>          if ((vma->vm_flags & (VM_WRITE | VM_SHARED)) == VM_WRITE)
>                  gup_flags |= FOLL_WRITE;
> 
> So it will write fault to shared memory mappings but it will touch
> others.

Exactly. But for hugetlbfs/shmem ("!RAM-backed files") this is not what 
we want.

-- 
Thanks,

David / dhildenb

