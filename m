Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9359B32048E
	for <lists+linux-arch@lfdr.de>; Sat, 20 Feb 2021 10:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBTJDG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Feb 2021 04:03:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57472 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229819AbhBTJCu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 20 Feb 2021 04:02:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613811684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JgoL6yAU+V/ArfjxO3XDCSurXdtNKbGCFrJc0uCVVRc=;
        b=Eqny4QLbWroe99WbRgPEczS3QxqJ6zCAmUpNo1NVkWpylk1yb1153M2AwyqGLFwHRNsTQf
        eA1KfWdtP8TwzdO2suo6ileRW0Q8tMarqtNJW8zV94w32FRI0IJbW4GQbiHXRScqNwojOx
        LYdJVkdm9OrluYJgh+ww3fR+M+6jL7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-EtcmsycmMP6Ck3kTppQAqg-1; Sat, 20 Feb 2021 04:01:20 -0500
X-MC-Unique: EtcmsycmMP6Ck3kTppQAqg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91037107ACE3;
        Sat, 20 Feb 2021 09:01:16 +0000 (UTC)
Received: from [10.36.112.45] (ovpn-112-45.ams2.redhat.com [10.36.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60B415D9C2;
        Sat, 20 Feb 2021 09:01:01 +0000 (UTC)
Subject: Re: [PATCH RFC] mm/madvise: introduce MADV_POPULATE to
 prefault/prealloc memory
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>
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
 <4d8e6f55-66a6-d701-6a94-79f5e2b23e46@redhat.com>
 <15da147c-e440-ee87-c505-a4684a5b29dc@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <2073702b-9e09-2033-2915-628c7b7ccb3d@redhat.com>
Date:   Sat, 20 Feb 2021 10:01:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <15da147c-e440-ee87-c505-a4684a5b29dc@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> Sorry, for jumping in late ... hugetlb keyword just hit my mail filters :)
> 

Sorry for not realizing to cc you before I sent out the man page update :)

> Yes, it is true that hugetlb reservations are not numa aware.  So, even if
> pages are reserved at mmap time one could still SIGBUS if a fault is
> restricted to a node with insufficient pages.
> 
> I looked into this some years ago, and there really is not a good way to
> make hugetlb reservations numa aware.  preallocation, or on demand
> populating as proposed here is a way around the issue.


Thanks for confirming, this makes a lot of sense to me now.


-- 
Thanks,

David / dhildenb

