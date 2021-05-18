Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E94387861
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 14:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244728AbhERMFQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 08:05:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25771 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244323AbhERMFP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 08:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621339437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F7A0h/wa7e7/Tasvo9gaiD2QfuqTtOZnS8ypc2xwcz8=;
        b=DTS27fLufhJV3alG0gV1+kkaf0+lif+eSU1HS0RWFF3kBPa7WbC92J6OD8GD85YQATrrhZ
        dfy7CQI23BRIDaaD/pQbusGxihlZks4C3GxnomXfZE7xREibH1WYr/uQ8iAzBrH/+wlKvj
        wjwEzab9FZB4vNEMTd8XrSh+FQuKdYM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-nN6OZr0iOQeruqOigW-RNQ-1; Tue, 18 May 2021 08:03:56 -0400
X-MC-Unique: nN6OZr0iOQeruqOigW-RNQ-1
Received: by mail-wm1-f70.google.com with SMTP id u203-20020a1cddd40000b029016dbb86d796so483979wmg.0
        for <linux-arch@vger.kernel.org>; Tue, 18 May 2021 05:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=F7A0h/wa7e7/Tasvo9gaiD2QfuqTtOZnS8ypc2xwcz8=;
        b=ALp7wm7oc22Tmw5oqEh9yEnf+P4wCh890whVxHP+Cq1yLBeO3DUD/ARQ1ZlHbSQGEx
         rUniClvSjBdSj8b9RzD3Hvu0AQv8jDeP+hPp6lZIX/SiBspaY3jlP34E3cWktWuB8cHs
         rDY29iPApAzRGsfiNcLJvNaAZhaWv17pqN692cABg78Txi12BBbjNJuihFYzB8221TKq
         mi1v0YVgWWciG3jPOr/voPVOjjJMGJQHzACeC7Uy2nyHJMPZr0HcxVlfnGjUq0okbzxh
         RucLktJaRVD4hH2Wlnqgy6LMoM7Am/s399GJAjXuCYiSBg9nERfEbNQFWCFFxwJQXWyi
         bNUA==
X-Gm-Message-State: AOAM531jQ1ZWT2jpxitU3XiC2daFsxV//Ca/zpoWtFKLcZ+wMxgptGoa
        4S9cvgfs05LLv39KrVyl9RXMQcUPEd8/Wj5vt8teEBtlhjSMHOUnIIa0dHLnlYwTvvNmjgV4wRu
        ZHZAYWId/FnIff5mNfkjQsA==
X-Received: by 2002:a1c:4c03:: with SMTP id z3mr5151138wmf.58.1621339434769;
        Tue, 18 May 2021 05:03:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyr5Bgt53O6C5VMUFGO4r7zh5yLm4RnZeG8MK0yO3eR1vv5vvDmG2V0a/pykWs1t6HOhZ/1gg==
X-Received: by 2002:a1c:4c03:: with SMTP id z3mr5151081wmf.58.1621339434387;
        Tue, 18 May 2021 05:03:54 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64fd.dip0.t-ipconnect.de. [91.12.100.253])
        by smtp.gmail.com with ESMTPSA id q19sm2364810wmc.44.2021.05.18.05.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 05:03:54 -0700 (PDT)
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
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, Linux API <linux-api@vger.kernel.org>
References: <20210511081534.3507-1-david@redhat.com>
 <20210511081534.3507-3-david@redhat.com> <YKOR/8LzEaOgCvio@dhcp22.suse.cz>
 <bb0e2ebb-e66d-176c-b20a-fbadd95cde98@redhat.com>
 <YKOiV9VkEdYFM9nB@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH resend v2 2/5] mm/madvise: introduce
 MADV_POPULATE_(READ|WRITE) to prefault page tables
Message-ID: <b2fa988d-9625-7c0e-ce83-158af0058e38@redhat.com>
Date:   Tue, 18 May 2021 14:03:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKOiV9VkEdYFM9nB@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>>> This means that you want to have two different uses depending on the
>>> underlying mapping type. MADV_POPULATE_READ seems rather weak for
>>> anonymous/private mappings. Memory backed by zero pages seems rather
>>> unhelpful as the PF would need to do all the heavy lifting anyway.
>>> Or is there any actual usecase when this is desirable?
>>
>> Currently, userfaultfd-wp, which requires "some mapping" to be able to arm
>> successfully. In QEMU, we currently have to prefault the shared zeropage for
>> userfaultfd-wp to work as expected.
> 
> Just for clarification. The aim is to reduce the memory footprint at the
> same time, right? If that is really the case then this is worth adding.

Yes. userfaultfd-wp is right now used in QEMU for background 
snapshotting of VMs. Just because you trigger a background snapshot 
doesn't mean that you want to COW all pages. (especially, if your VM 
previously inflated the balloon, was using free page reporting etc.)

> 
>> I expect that use case might vanish over
>> time (eventually with new kernels and updated user space), but it might
>> stick for a bit.
> 
> Could you elaborate some more please?

After I raised that the current behavior of userfaultfd-wp is 
suboptimal, Peter started working on a userfaultfd-wp mode that doesn't 
require to prefault all pages just to have it working reliably -- 
getting notified when any page changes, including ones that haven't been 
populated yet and would have been populated with the shared zeropage on 
first access. Not sure what the state of that is and when we might see it.

> 
>> Apart from that, populating the shared zeropage might be relevant in some
>> corner cases: I remember there are sparse matrix algorithms that operate
>> heavily on the shared zeropage.
> 
> I am not sure I see why this would be a useful interface for those? Zero
> page read fault is really low cost. Or are you worried about cummulative
> overhead by entering the kernel many times?

Yes, cumulative overhead when dealing with large, sparse matrices. Just 
an example where I think it could be applied in the future -- but not 
that I consider populating the shared zeropage a really important use 
case in general (besides for userfaultfd-wp right now).

> 
>>> So the split into these two modes seems more like gup interface
>>> shortcomings bubbling up to the interface. I do expect userspace only
>>> cares about pre-faulting the address range. No matter what the backing
>>> storage is.
>>>
>>> Or do I still misunderstand all the usecases?
>>
>> Let me give you an example where we really cannot tell what would be best
>> from a kernel perspective.
>>
>> a) Mapping a file into a VM to be used as RAM. We might expect the guest
>> writing all memory immediately (e.g., booting Windows). We would want
>> MADV_POPULATE_WRITE as we expect a write access immediately.
>>
>> b) Mapping a file into a VM to be used as fake-NVDIMM, for example, ROOTFS
>> or just data storage. We expect mostly reading from this memory, thus, we
>> would want MADV_POPULATE_READ.
> 
> I am afraid I do not follow. Could you be more explicit about advantages
> of using those two modes for those example usecases? Is that to share
> resources (e.g. by not breaking CoW)?

I'm only talking about shared mappings "ordinary files" for now, because 
that's where MADV_POPULATE_READ vs MADV_POPULATE_WRITE differ in regards 
of "mark something dirty and write it back"; CoW doesn't apply to shared 
mappings, it's really just a difference in dirtying and having to write 
back. For things like PMEM/hugetlbfs/... we usually want 
MADV_POPULATE_WRITE because then we'd avoid a context switch when our VM 
actually writes to a page the first time -- and we don't care about 
dirtying, because we don't have writeback.

But again, that's just one use case I have in mind coming from the VM 
area. I consider MADV_POPULATE_READ really only useful when we are 
expecting mostly read access on a mapping. (I assume there are other use 
cases for databases etc. not explored yet where MADV_POPULATE_WRITE 
would not be desired for performance reasons)

> 
>> Instead of trying to be smart in the kernel, I think for this case it makes
>> much more sense to provide user space the options. IMHO it doesn't really
>> hurt to let user space decide on what it thinks is best.
> 
> I am mostly worried that this will turn out to be more confusing than
> helpful. People will need to grasp non trivial concepts and kernel
> internal implementation details about how read/write faults are handled.

And that's the point: in the simplest case (without any additional 
considerations about the underlying mapping), if you end up mostly 
*reading* MADV_POPULATE_READ is the right thing. If you end up mostly 
*writing* MADV_POPULATE_WRITE is the right thing. Only care has to be 
taken when you really want a "prealloction" as in "allocate backend 
storage" or "don't ever use the shared zeropage". I agree that these 
details require more knowledge, but so does anything that messes with 
memory mappings on that level (VMs, databases, ...).

QEMU currently implements exactly these two cases manually in user space.

Anyhow, please suggest a way to handle it via a single flag in the 
kernel -- which would be some kind of heuristic as we know from 
MAP_POPULATE. Having an alternative at hand would make it easier to 
discuss this topic further. I certainly *don't* want MAP_POPULATE 
semantics when it comes to MADV_POPULATE, especially when it comes to 
shared mappings. Not useful in QEMU now and in the future.

We could make MADV_POPULATE act depending on the readability/writability 
of a mapping. Use MADV_POPULATE_WRITE on writable mappings, use 
MADV_POPULATE_READ on readable mappings. Certainly not perfect for use 
cases where you have writable mappings that are mostly read only (as in 
the example with fake-NVDIMMs I gave ...), but if it makes people happy, 
fine with me. I mostly care about MADV_POPULATE_WRITE.

-- 
Thanks,

David / dhildenb

