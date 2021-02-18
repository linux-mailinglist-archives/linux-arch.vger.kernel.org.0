Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB0431E940
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 12:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhBRLqU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Feb 2021 06:46:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24521 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232572AbhBRKq2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Feb 2021 05:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613645097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BMH8S4T7u+QFmoTuKd8zzsW1EwjP83j2mvXgWWp0OT0=;
        b=Vmzoml9op7IljJb0pjv1FpP+bP1ZrGbG6nu4BcAm+/LsKK9j/BDgwtFPnM6inDMOgAgb7I
        X2mA8XLv9msN5kfRcah7fDqxSWRigJdOMx0dQOu1Gljf9teKHentTLINRccsE7kLwuLOI9
        6Wq9vHsRjhtw28SOL/CH+ngW08LjF9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-EbN0LvXNPNW1e9tnCjCIdA-1; Thu, 18 Feb 2021 05:44:55 -0500
X-MC-Unique: EbN0LvXNPNW1e9tnCjCIdA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11B17107ACE6;
        Thu, 18 Feb 2021 10:44:52 +0000 (UTC)
Received: from [10.36.114.59] (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4016110016FD;
        Thu, 18 Feb 2021 10:44:42 +0000 (UTC)
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
 <YC5Am6a4KMSA8XoK@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH RFC] mm/madvise: introduce MADV_POPULATE to
 prefault/prealloc memory
Message-ID: <3763a505-02d6-5efe-a9f5-40381acfbdfd@redhat.com>
Date:   Thu, 18 Feb 2021 11:44:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YC5Am6a4KMSA8XoK@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 18.02.21 11:25, Michal Hocko wrote:
> On Wed 17-02-21 16:48:44, David Hildenbrand wrote:
>> When we manage sparse memory mappings dynamically in user space - also
>> sometimes involving MADV_NORESERVE - we want to dynamically populate/
> 
> Just wondering what is MADV_NORESERVE? I do not see anything like that
> in the Linus tree. Did you mean MAP_NORESERVE?

Most certainly, thanks :)

> 
>> discard memory inside such a sparse memory region. Example users are
>> hypervisors (especially implementing memory ballooning or similar
>> technologies like virtio-mem) and memory allocators. In addition, we want
>> to fail in a nice way if populating does not succeed because we are out of
>> backend memory (which can happen easily with file-based mappings,
>> especially tmpfs and hugetlbfs).
> 
> by "fail in a nice way" you mean before a #PF would fail and SIGBUS
> which would be harder to handle?

Yes.

> 
> [...]
>> Because we don't have a proper interface, what applications
>> (like QEMU and databases) end up doing is touching (i.e., writing) all
>> individual pages. However, it requires expensive signal handling (SIGBUS);
>> for example, this is problematic in hypervisors like QEMU where SIGBUS
>> handlers might already be used by other subsystems concurrently to e.g,
>> handle hardware errors. "Simply" doing preallocation from another thread
>> is not that easy.
> 
> OK, that clarifies my above question.
> 
>>
>> Let's introduce MADV_POPULATE with the following semantics
>> 1. MADV_POPULATED does not work on PROT_NONE and special VMAs. It works
>>     on everything else.
> 
> This would better clarify what "does not work" means. I assume those are
> ignored and do not report any error?

I'm currently preparing the man page. "Fail with -ENOMEM" (like 
MADV_DONTNEED or MADV_REMOVE)

> 
>> 2. Errors during MADV_POPULATED (especially OOM) are reported.
> 
> How do you want to achieve that? gup/page fault handler will allocate
> memory and trigger the oom without caller noticing that. You would
> somehow have to weaken the allocation context to GFP_RETRY_MAYFAIL or
> NORETRY to achieve the error handling.

Okay, I should be more clear here (again, I'm realizing this as well 
while I create the man page), OOM is confusing: avoid SIGBUS at runtime 
- like we would get on actual file systems/shmem/hugetlbfs when 
preallocating.

It cannot save us from the actual OOM killer. To handle anonymous memory 
more reliable I'll need other means as well (dynamic swap space 
allocation for sparse mappings).

> 
>>     If we hit
>>     hardware errors on pages, ignore them - nothing we really can or
>>     should do.
>> 3. On errors during MADV_POPULATED, some memory might have been
>>     populated. Callers have to clean up if they care.
> 
> How does caller find out? madvise reports 0 on success so how do you
> find out how much has been populated?

If there is an error, something might have been populated. In my QEMU 
implementation, I simply discard the range again, good enough. I don't 
think we need to really indicate "error and populated" or "error and not 
populated".


> 
>> 4. Concurrent changes to the virtual memory layour are tolerated - we
>>     process each and every PFN only once, though.
> 
> I do not understand this. madvise is about virtual address space not a
> physical address space.

What I wanted to express: if we detect a change in the mapping we don't 
restart at the beginning, we always make forward progress. We process 
each virtual address once (on a per-page basis, thus I accidentally used 
"PFN").

> 
>> 5. If MADV_POPULATE succeeds, all memory in the range can be accessed
>>     without SIGBUS. (of course, not if user space changed mappings in the
>>     meantime or KSM kicked in on anonymous memory).
> 
> I do not see how KSM would change anything here and maybe it is not
> really important to mention it. KSM should be really transparent from
> the users space POV. Parallel and destructive virtual address space
> operations are also expected to change the outcome and there is nothing
> kernel do about at and provide any meaningful guarantees. I guess we
> want to assume a reasonable userspace behavior here.

It's just a note that we cannot protect from someone interfering 
(discard/ksm/whatever). I'm making that clearer in the cover letter.

Thanks!

-- 
Thanks,

David / dhildenb

