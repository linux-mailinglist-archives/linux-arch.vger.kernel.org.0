Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5108E387696
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 12:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348515AbhERKdp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 06:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24540 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348528AbhERKdf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 06:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621333937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I3GoBhYUm/DKIxdTnLjldHt3dau0GNiE51gCpNBcSM0=;
        b=eZwJ2NSd4PKIV/GqNXVaAA9B6D37QU/rOKWCYfsfils4iqUdXQoe3uG+4LGR9gbmYSLZ9o
        SVxyd2Si86fMcQGqLi7qVRSIK2ytmldw6QwtbHXgeo5aRR5nSI0qPH0GwHFCbCb9GMPttP
        2t2cFjMMpjG3zB34iLW3p1CWs+yKJDc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-efZoc69-PKiYNw6uXnwr0w-1; Tue, 18 May 2021 06:32:15 -0400
X-MC-Unique: efZoc69-PKiYNw6uXnwr0w-1
Received: by mail-wr1-f69.google.com with SMTP id r12-20020adfc10c0000b029010d83323601so5352386wre.22
        for <linux-arch@vger.kernel.org>; Tue, 18 May 2021 03:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=I3GoBhYUm/DKIxdTnLjldHt3dau0GNiE51gCpNBcSM0=;
        b=ZyJKhjiS6wZN07/ehqqYZtxxUMiIJ/1EGZM23abxg/1sq9/9cdkZoLM+7cuTgnqEHp
         AmlUV99dFng7Suhi+0Ubq42XekFJHSeXyw/7w8LlWSIhzzyV7jVL8SgpCm/eRdQvk9eR
         ZpHMP89KDNG8w7QVGDcJhOAoNdLDb5euPI7DBMgmVSkDVDmsQEepxVZrzs5Q4Y+lmFll
         VShLTPmYgNy12ywD2CzOMS7wtv7+lbobw2vU2Mhl+H+LUNpK4tz1O/mUCvWTGHTXhRmE
         fed81qtMzmMHZIdsHrhkbdY9CODixhIX8fwRmJZY6h6mUqubR/bHPOa5G1CBMsUy9jTF
         RIUg==
X-Gm-Message-State: AOAM5339AHlQIy508dHqS5rwPf/dDBdjpcPmWNn4vpd49OnLU8652KMY
        KktrRJnFEAger3GUzeXrlhdNMjLRV1UB6kfH8Rx72muHUWG7g893b2fXuc6mItrWZZpPDJkOyNc
        SIALaVzSB18YmGdXP4Ti3aQ==
X-Received: by 2002:a1c:730b:: with SMTP id d11mr4111577wmb.20.1621333934509;
        Tue, 18 May 2021 03:32:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNi/tkWCoG0NuBlaiGe8ooTg64rxLuGj3IhddCSk72nVE1RVc10kp/QPhwhI1TNBxYXIrVfw==
X-Received: by 2002:a1c:730b:: with SMTP id d11mr4111530wmb.20.1621333934226;
        Tue, 18 May 2021 03:32:14 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64fd.dip0.t-ipconnect.de. [91.12.100.253])
        by smtp.gmail.com with ESMTPSA id f26sm2241521wmj.30.2021.05.18.03.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 03:32:13 -0700 (PDT)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH resend v2 2/5] mm/madvise: introduce
 MADV_POPULATE_(READ|WRITE) to prefault page tables
Message-ID: <bb0e2ebb-e66d-176c-b20a-fbadd95cde98@redhat.com>
Date:   Tue, 18 May 2021 12:32:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKOR/8LzEaOgCvio@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 18.05.21 12:07, Michal Hocko wrote:
> [sorry for a long silence on this]
> 
> On Tue 11-05-21 10:15:31, David Hildenbrand wrote:
> [...]
> 
> Thanks for the extensive usecase description. That is certainly useful
> background. I am sorry to bring this up again but I am still not
> convinced that READ/WRITE variant are the best interface.

Thanks for having time to look into this.

>   
>> While the use case for MADV_POPULATE_WRITE is fairly obvious (i.e.,
>> preallocate memory and prefault page tables for VMs), one issue is that
>> whenever we prefault pages writable, the pages have to be marked dirty,
>> because the CPU could dirty them any time. while not a real problem for
>> hugetlbfs or dax/pmem, it can be a problem for shared file mappings: each
>> page will be marked dirty and has to be written back later when evicting.
>>
>> MADV_POPULATE_READ allows for optimizing this scenario: Pre-read a whole
>> mapping from backend storage without marking it dirty, such that eviction
>> won't have to write it back. As discussed above, shared file mappings
>> might require an explciit fallocate() upfront to achieve
>> preallcoation+prepopulation.
> 
> This means that you want to have two different uses depending on the
> underlying mapping type. MADV_POPULATE_READ seems rather weak for
> anonymous/private mappings. Memory backed by zero pages seems rather
> unhelpful as the PF would need to do all the heavy lifting anyway.
> Or is there any actual usecase when this is desirable?

Currently, userfaultfd-wp, which requires "some mapping" to be able to 
arm successfully. In QEMU, we currently have to prefault the shared 
zeropage for userfaultfd-wp to work as expected. I expect that use case 
might vanish over time (eventually with new kernels and updated user 
space), but it might stick for a bit.

Apart from that, populating the shared zeropage might be relevant in 
some corner cases: I remember there are sparse matrix algorithms that 
operate heavily on the shared zeropage.

> 
> So the split into these two modes seems more like gup interface
> shortcomings bubbling up to the interface. I do expect userspace only
> cares about pre-faulting the address range. No matter what the backing
> storage is.
> 
> Or do I still misunderstand all the usecases?

Let me give you an example where we really cannot tell what would be 
best from a kernel perspective.

a) Mapping a file into a VM to be used as RAM. We might expect the guest 
writing all memory immediately (e.g., booting Windows). We would want 
MADV_POPULATE_WRITE as we expect a write access immediately.

b) Mapping a file into a VM to be used as fake-NVDIMM, for example, 
ROOTFS or just data storage. We expect mostly reading from this memory, 
thus, we would want MADV_POPULATE_READ.

Instead of trying to be smart in the kernel, I think for this case it 
makes much more sense to provide user space the options. IMHO it doesn't 
really hurt to let user space decide on what it thinks is best.

-- 
Thanks,

David / dhildenb

