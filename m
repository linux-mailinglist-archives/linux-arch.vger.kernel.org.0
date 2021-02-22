Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06253217B6
	for <lists+linux-arch@lfdr.de>; Mon, 22 Feb 2021 13:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhBVMyx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Feb 2021 07:54:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47295 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231681AbhBVMx7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Feb 2021 07:53:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613998353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2iEQDmFtT3qebJig5f9jd7ifXq3OPYbzSwZS/a5ZYlE=;
        b=ipqaRcSaf49a8AlNSXTIuNwAxFXb42xzojkgCvhJ4G5Zo4QceGNK4q7OZmJvvhrgixejq+
        HnavqaUvmmQ60DysKS4F/RTwEiLhMGyMgh1Gw5RWGMUteEqFCNgv1wGGytBrBPXnM3C0VC
        TPQIif2rU06FNwoPzB5bNIuegpGlISQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-mZgLziWtMHSpoaneWBcJ5w-1; Mon, 22 Feb 2021 07:52:29 -0500
X-MC-Unique: mZgLziWtMHSpoaneWBcJ5w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4620A107ACC7;
        Mon, 22 Feb 2021 12:52:26 +0000 (UTC)
Received: from [10.36.115.16] (ovpn-115-16.ams2.redhat.com [10.36.115.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E65EE19CA8;
        Mon, 22 Feb 2021 12:52:16 +0000 (UTC)
Subject: Re: [PATCH RFC] mm/madvise: introduce MADV_POPULATE to
 prefault/prealloc memory
To:     Michal Hocko <mhocko@suse.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
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
 <20210218225904.GB6669@xz-x1>
 <b24996a6-7652-f88c-301e-28417637fd02@redhat.com>
 <YDOnq9Nliopj9kQL@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <296a1a02-f7ec-5085-f17e-eadc4bdb6a24@redhat.com>
Date:   Mon, 22 Feb 2021 13:52:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDOnq9Nliopj9kQL@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 22.02.21 13:46, Michal Hocko wrote:
> I am slowly catching up with this thread.
> 
> On Fri 19-02-21 09:20:16, David Hildenbrand wrote:
> [...]
>> So if we have zero, we write zero. We'll COW pages, triggering a write fault
>> - and that's the only good thing about it. For example, similar to
>> MADV_POPULATE, nothing stops KSM from merging anonymous pages again. So for
>> anonymous memory the actual write is not helpful at all. Similarly for
>> hugetlbfs, the actual write is not necessary - but there is no other way to
>> really achieve the goal.
> 
> I really do not see why you care about KSM so much. Isn't KSM an
> explicit opt-in with a fine grained interface to control which memory to
> KSM or not?

Yeah, I think it's opt-in via MADV_MERGEABLE. E.g., QEMU defaults to 
enable KSM unless explicitly disabled by the user.

But I agree, I got distracted by KSM details.

-- 
Thanks,

David / dhildenb

