Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CB131E947
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 12:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhBRLsu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Feb 2021 06:48:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44322 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232008AbhBRLkN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Feb 2021 06:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613648326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3A4zaSGP/jDU0jQya7nJb+PtO132rNXYV3X5vurWHRM=;
        b=FsnxXWc2e03gNM9vf6/ZY/Yo7E9exlCDot+KyryDAdQ2JH3jarJj+EpjyHE1+DvUCQVup8
        ruVnGUhFmzEx1y/JrlRJ9ko6K/iUOsnq5hh/NMrucNOPrVVyjvSihc7lQZVxqot01/fVmd
        8hLWbHxsl5xzjkam9TZ7EQaVOA5WyIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-fC5elPu5OAqWLO01C1hoPg-1; Thu, 18 Feb 2021 06:38:42 -0500
X-MC-Unique: fC5elPu5OAqWLO01C1hoPg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A5F3801965;
        Thu, 18 Feb 2021 11:38:39 +0000 (UTC)
Received: from [10.36.114.59] (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B12B16F7EC;
        Thu, 18 Feb 2021 11:38:28 +0000 (UTC)
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
 <3763a505-02d6-5efe-a9f5-40381acfbdfd@redhat.com>
 <YC5PEBiGKT5LUt/I@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH RFC] mm/madvise: introduce MADV_POPULATE to
 prefault/prealloc memory
Message-ID: <740cdd51-137b-2b08-8b7f-9757d8d847cb@redhat.com>
Date:   Thu, 18 Feb 2021 12:38:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YC5PEBiGKT5LUt/I@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>>>>      If we hit
>>>>      hardware errors on pages, ignore them - nothing we really can or
>>>>      should do.
>>>> 3. On errors during MADV_POPULATED, some memory might have been
>>>>      populated. Callers have to clean up if they care.
>>>
>>> How does caller find out? madvise reports 0 on success so how do you
>>> find out how much has been populated?
>>
>> If there is an error, something might have been populated. In my QEMU
>> implementation, I simply discard the range again, good enough. I don't think
>> we need to really indicate "error and populated" or "error and not
>> populated".
> 
> Agreed. The wording just suggests that the syscall actually provides any
> means for an effective way to handle those errors. Maybe you should just
> stick with the first sentence and drop the second.

Makes sense. "On errors during MADV_POPULATE, some memory might have 
been populated."

>   
>>>> 4. Concurrent changes to the virtual memory layour are tolerated - we
>>>>      process each and every PFN only once, though.
>>>
>>> I do not understand this. madvise is about virtual address space not a
>>> physical address space.
>>
>> What I wanted to express: if we detect a change in the mapping we don't
>> restart at the beginning, we always make forward progress. We process each
>> virtual address once (on a per-page basis, thus I accidentally used "PFN").
> 
> This is an implicit assumption. Your range can have the same page mapped
> several times in the given address range and all you care about is that
> you fault those which are not present during the virtual address space
> walk. Your syscall can return and large part of the address space might
> be unpopulated because memory reclaim just dropped those pages and that
> would be fine. This shouldn't really imply memory presence - mlock does
> that.

"Concurrent changes to the virtual memory layout are tolerated. The 
range is processed exactly once."

> 
>>>> 5. If MADV_POPULATE succeeds, all memory in the range can be accessed
>>>>      without SIGBUS. (of course, not if user space changed mappings in the
>>>>      meantime or KSM kicked in on anonymous memory).
>>>
>>> I do not see how KSM would change anything here and maybe it is not
>>> really important to mention it. KSM should be really transparent from
>>> the users space POV. Parallel and destructive virtual address space
>>> operations are also expected to change the outcome and there is nothing
>>> kernel do about at and provide any meaningful guarantees. I guess we
>>> want to assume a reasonable userspace behavior here.
>>
>> It's just a note that we cannot protect from someone interfering
>> (discard/ksm/whatever). I'm making that clearer in the cover letter.
> 
> Again that is implicit expectation. madvise will not work for anybody
> shooting an own foot.

Okay, I'll drop that part, thanks!

-- 
Thanks,

David / dhildenb

