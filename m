Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BAC31FDBA
	for <lists+linux-arch@lfdr.de>; Fri, 19 Feb 2021 18:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhBSRPr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Feb 2021 12:15:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20431 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229784AbhBSRPk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Feb 2021 12:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613754853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nOq6obPMpKNx+xpOHX66/BOR1Jhu9sxgWKkPOBd406Y=;
        b=H7UHUbwnBldHPIGhR2Q3B2txTrPfqlQFCAjGNlA2RxvXEvfpvt+ZkTQv86YfUM51PJv0Aw
        OJK/Dn5+yRLacYMf6uDG6pSgdyJAZx5EDvmgBbSCnOFjpp76itX050C7fyZBgumop6QVz5
        z7F0akmVA0twzjutlpYAKoVzn5ouI/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-nldniRpjOUixcYtuqIdmbw-1; Fri, 19 Feb 2021 12:14:10 -0500
X-MC-Unique: nldniRpjOUixcYtuqIdmbw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 595B3107ACE3;
        Fri, 19 Feb 2021 17:14:05 +0000 (UTC)
Received: from [10.36.113.117] (ovpn-113-117.ams2.redhat.com [10.36.113.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C71895D9C2;
        Fri, 19 Feb 2021 17:13:50 +0000 (UTC)
To:     Peter Xu <peterx@redhat.com>
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
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
References: <20210217154844.12392-1-david@redhat.com>
 <20210218225904.GB6669@xz-x1>
 <b24996a6-7652-f88c-301e-28417637fd02@redhat.com>
 <20210219163157.GF6669@xz-x1>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH RFC] mm/madvise: introduce MADV_POPULATE to
 prefault/prealloc memory
Message-ID: <41444eb8-8bb8-8d5b-4cec-be7fa7530d0e@redhat.com>
Date:   Fri, 19 Feb 2021 18:13:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210219163157.GF6669@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 19.02.21 17:31, Peter Xu wrote:
> On Fri, Feb 19, 2021 at 09:20:16AM +0100, David Hildenbrand wrote:
>> On 18.02.21 23:59, Peter Xu wrote:
>>> Hi, David,
>>>
>>> On Wed, Feb 17, 2021 at 04:48:44PM +0100, David Hildenbrand wrote:
>>>> When we manage sparse memory mappings dynamically in user space - also
>>>> sometimes involving MADV_NORESERVE - we want to dynamically populate/
>>>> discard memory inside such a sparse memory region. Example users are
>>>> hypervisors (especially implementing memory ballooning or similar
>>>> technologies like virtio-mem) and memory allocators. In addition, we want
>>>> to fail in a nice way if populating does not succeed because we are out of
>>>> backend memory (which can happen easily with file-based mappings,
>>>> especially tmpfs and hugetlbfs).
>>>
>>> Could you explain a bit more on how do you plan to use this new interface for
>>> the virtio-balloon scenario?
>>
>> Sure, that will bring up an interesting point to discuss
>> (MADV_POPULATE_WRITE).
>>
>> I'm planning on using it in virtio-mem: whenever the guests requests the
>> hypervisor (via a virtio-mem device) to make specific blocks available
>> ("plug"), I want to have a configurable option ("populate=on" /
>> "prealloc="on") to perform safety checks ("prealloc") and populate page
>> tables.
> 
> As you mentioned in the commit message, the original goal for MADV_POPULATE
> should be for performance's sake, which I can understand.  But for safety
> check, I'm curious whether we'd have better way to do that besides populating
> the whole memory.

Well, it's 100% what I want for "populate=on"/"prealloc=on" semantics.

There is no real memory overcommit for huge pages, so any lacy 
allocation ("reserve only") only saves you boot time - which is not 
really an issue for virtio-mem, as the memory gets added and initialized 
asynchronously as the guest boots up.

"reserve=on,prealloc=off" is another future use case I have in mind - 
possible only for some memory backends (esp. anonymous memory - below).


> 
> E.g., can we simply ask the kernel "how much memory this process can still
> allocate", then get a number out of it?  I'm not sure whether it can be done

Anything like that is completely racy and unreliable.

> already by either cgroup or any other facilities, or maybe it's still missing.
> But I'd raise this question up, since these two requirements seem to be two
> standalone issues to solve at least to me.  It could be an overkill to populate
> all the memory just for a sanity check.

For anonymous memory I have something in the works to dynamically 
reserve swap space per process for the memory reservation for not 
accounted private writable MAP_DONTRESERVE memory.

However, it works because swap space is per-system, not per-node or 
anything else. Doing that for file systems/hugetlbfs is a different beast.

And anonymous memory is right now less of my concern, as we're used to 
overcommitting there - limited pool sizes are more of an issue.

>> --- Ways to populate/preallocate ---
>>
>> I see the following ways to populate/preallocate:
>>
>> a) MADV_POPULATE: write fault on writable MAP_PRIVATE, read fault on
>>     MAP_SHARED
>> b) Writing to MAP_PRIVATE | MAP_SHARED from user space.
>> c) (below) MADV_POPULATE_WRITE: write fault on writable MAP_PRIVATE |
>>     MAP_SHARED
>>
>> Especially, 2) is kind of weird as implemented in QEMU
>> (util/oslib-posix.c:do_touch_pages):
>>
>> "Read & write back the same value, so we don't corrupt existing user/app
>> data ... TODO: get a better solution from kernel so we don't need to write
>> at all so we don't cause wear on the storage backing the region..."
> 
> It's interesting to know about commit 1e356fc14be ("mem-prealloc: reduce large
> guest start-up and migration time.", 2017-03-14).  It seems for speeding up VM
> boot, but what I can't understand is why it would cause the delay of hugetlb
> accounting - I thought we'd fail even earlier at either fallocate() on the
> hugetlb file (when we use /dev/hugepages) or on mmap() of the memfd which
> contains the huge pages.  See hugetlb_reserve_pages() and its callers.  Or did
> I miss something?

We should fail on mmap() when the reservation happens (unless 
MAP_NORESERVE is passed) I think.

> 
> I think there's a special case if QEMU fork() with a MAP_PRIVATE hugetlbfs
> mapping, that could cause the memory accouting to be delayed until COW happens.

That would be kind of weird. I'd assume the reservation gets properly 
done during fork() - just like for VM_ACCOUNT.

> However that's definitely not the case for QEMU since QEMU won't work at all as
> late as that point.
> 
> IOW, for hugetlbfs I don't know why we need to populate the pages at all if we
> simply want to know "whether we do still have enough space"..  And IIUC 2)
> above is the major issue you'd like to solve too.

To avoid page faults at runtime on access I think. Reservation <= 
Preallocation.

[...]

>> --- HOW MADV_POPULATE_WRITE might be useful ---
>>
>> With 3) 4) 5) MADV_POPULATE does partially what I want: preallocate memory
>> and populate page tables. But as it's a read fault, I think we'll have
>> another minor fault on access. Not perfect, but better than failing with
>> SIGBUS. One way around that would be having an additional
>> MADV_POPULATE_WRITE, to use in cases where it makes sense (I think at least
>> 3) and 4), most probably not on actual files like 5) ).
> 
> Right, it seems when populating memories we'll read-fault on file-backed.
> However that'll be another performance issue to think about.  So I'd hope we
> can start with the current virtio-mem issue on memory accounting, then we can
> discuss them separately.

MADV_POPULATE is certainly something I want and what fits nicely into 
the existing model of MAP_POPULATE. Doing reservation only is a 
different topic - and is most probably only possible for anonymous 
memory in a clean way.

> Btw, thanks for the long write-up, it definitely helps me to understand what
> you wanted to achieve.

Sure! Thanks!


-- 
Thanks,

David / dhildenb

