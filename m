Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352F031FF47
	for <lists+linux-arch@lfdr.de>; Fri, 19 Feb 2021 20:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhBSTQi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Feb 2021 14:16:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59037 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230001AbhBSTQe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Feb 2021 14:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613762108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GuikDQq1sciUIXGoinMOJrB+j3nRzQ2K1NXhrcaqYcg=;
        b=V+qdyJl+teNWY825F4XzZbZjVNp9iTT8m79yWee3p/LdReW6tsnmVlVR+hf+UpRfnkTroq
        7iNZmsAceylrdcYmo/M87buSk/5KUPRWvYOA9IbHNdJSlNDBsG6ODAbH+FG6prgQfv0jmJ
        YDo/0z8LWy1K8AZ7L1WiJyyZcUAEHqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-On0zvAUYOq6qvarRhkE3xg-1; Fri, 19 Feb 2021 14:15:04 -0500
X-MC-Unique: On0zvAUYOq6qvarRhkE3xg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC82A8030BB;
        Fri, 19 Feb 2021 19:15:00 +0000 (UTC)
Received: from [10.36.113.117] (ovpn-113-117.ams2.redhat.com [10.36.113.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8671B5C1BB;
        Fri, 19 Feb 2021 19:14:46 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
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
 <41444eb8-8bb8-8d5b-4cec-be7fa7530d0e@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH RFC] mm/madvise: introduce MADV_POPULATE to
 prefault/prealloc memory
Message-ID: <4d8e6f55-66a6-d701-6a94-79f5e2b23e46@redhat.com>
Date:   Fri, 19 Feb 2021 20:14:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <41444eb8-8bb8-8d5b-4cec-be7fa7530d0e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>> It's interesting to know about commit 1e356fc14be ("mem-prealloc: reduce large
>> guest start-up and migration time.", 2017-03-14).  It seems for speeding up VM
>> boot, but what I can't understand is why it would cause the delay of hugetlb
>> accounting - I thought we'd fail even earlier at either fallocate() on the
>> hugetlb file (when we use /dev/hugepages) or on mmap() of the memfd which
>> contains the huge pages.  See hugetlb_reserve_pages() and its callers.  Or did
>> I miss something?
> 
> We should fail on mmap() when the reservation happens (unless
> MAP_NORESERVE is passed) I think.
> 
>>
>> I think there's a special case if QEMU fork() with a MAP_PRIVATE hugetlbfs
>> mapping, that could cause the memory accouting to be delayed until COW happens.
> 
> That would be kind of weird. I'd assume the reservation gets properly
> done during fork() - just like for VM_ACCOUNT.
> 
>> However that's definitely not the case for QEMU since QEMU won't work at all as
>> late as that point.
>>
>> IOW, for hugetlbfs I don't know why we need to populate the pages at all if we
>> simply want to know "whether we do still have enough space"..  And IIUC 2)
>> above is the major issue you'd like to solve too.
> 
> To avoid page faults at runtime on access I think. Reservation <=
> Preallocation.

I just learned that there is more to it: (test done on v5.9)

# echo 512 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
# cat /sys/devices/system/node/node*/meminfo | grep HugePages_
Node 0 HugePages_Total:   512
Node 0 HugePages_Free:    512
Node 0 HugePages_Surp:      0
Node 1 HugePages_Total:     0
Node 1 HugePages_Free:      0
Node 1 HugePages_Surp:      0
# cat /proc/meminfo  | grep HugePages_
HugePages_Total:     512
HugePages_Free:      512
HugePages_Rsvd:        0
HugePages_Surp:        0

# /usr/libexec/qemu-kvm -m 1G -smp 1 -object memory-backend-memfd,id=mem0,size=1G,hugetlb=on,hugetlbsize=2M,policy=bind,host-nodes=0 -numa node,nodeid=0,memdev=mem0 -hda Fedora-Cloud-Base-Rawhide-20201004.n.1.x86_64.qcow2 -nographic
-> works just fine

# /usr/libexec/qemu-kvm -m 1G -smp 1 -object memory-backend-memfd,id=mem0,size=1G,hugetlb=on,hugetlbsize=2M,policy=bind,host-nodes=1 -numa node,nodeid=0,memdev=mem0 -hda Fedora-Cloud-Base-Rawhide-20201004.n.1.x86_64.qcow2 -nographic
-> Does not fail nicely but crashes!


See https://bugzilla.redhat.com/show_bug.cgi?id=1686261 for something similar, however, it no longer applies like that on more recent kernels.

Hugetlbfs reservations don't always protect you (especially with NUMA) - that's why e.g., libvirt always tells QEMU to prealloc.

I think the "issue" is that the reservation happens on mmap(). mbind() runs afterwards. Preallocation saves you from that.

I suspect something similar will happen with anonymous memory with mbind() even if we reserved swap space. Did not test yet, though.

-- 
Thanks,

David / dhildenb

