Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E128769F10
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 19:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjGaROl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 13:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbjGaROX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 13:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023624690
        for <linux-arch@vger.kernel.org>; Mon, 31 Jul 2023 10:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690823359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o7Je1Tw1wJWhPdYNICmrH5qTgNEkZ25/eHgF0fwCa/s=;
        b=J8AWeTjQNi8pOWsWpAHwvrfeaYtDu+ly6Fy6gt/T6QfNDbRmw1xB/clG2Pv9u6K37OtKPk
        9ECc4v7sROrYXXmB2oUZQ+DuFAqff7GhdLz8Owy4F0mRuQ3ZS8R6fwkRGRVu0nisoJ+Naz
        v+fI9FEuDM92iPAVZLtHd1rRkFa+/5Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-BqrOutMFM9uUQe33WehzyQ-1; Mon, 31 Jul 2023 13:06:08 -0400
X-MC-Unique: BqrOutMFM9uUQe33WehzyQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe13881511so13004915e9.3
        for <linux-arch@vger.kernel.org>; Mon, 31 Jul 2023 10:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823167; x=1691427967;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7Je1Tw1wJWhPdYNICmrH5qTgNEkZ25/eHgF0fwCa/s=;
        b=Tg+GOf5nFIxNwHe2WQgUTF3qO03OZnfsE/6kSb3hsKkzIYQ5OuAD6/TXqD6mtuCswP
         WlTcEw0Ik7e4T0nGa7y5W9fondvxE39HA57jQ9lyAuNLt71NsgKwA77pBe7aIDeRUkYJ
         xW6fgNWTSs+0/vQMKMJCPpsTsAWWVDBSXjNknAHx3WvOqOPj11ZblBSMw/0h6MwNwhn6
         Rjv0vLcYUNrprh3saCF3yeb8+ttu0fN/mqevbp5Qp9hkhIWCQKYWLg0r7eG08XRo/0Yu
         0+mNNpsX0S1PO8NJal+sphDJ1yQSWAuhDN2QueBbHcuArBR6wZT0yoSWjsVAOkEUVyMD
         C/IQ==
X-Gm-Message-State: ABy/qLbXvTPHf9davYDGxwpmfCHzgIDsD/RiPLq0vogMePVjrZlkg7pb
        IphDFoYWY2rQGPGPWlsbnrZmJoZbBADHXMj8oraHNj7dnOEg4DdTwnzvzyRznqPTgDjYbCLuY9n
        NHmAAXXMYdCfjqutRY3Y4YA==
X-Received: by 2002:a05:600c:260e:b0:3fe:1548:264f with SMTP id h14-20020a05600c260e00b003fe1548264fmr433539wma.22.1690823166978;
        Mon, 31 Jul 2023 10:06:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH2MTM3zZh6fdgvplx34o1m2GIuXvVYoFmP83+z8cxLJsJsTDtauV6QKq2/5/U7uWp78AAGYQ==
X-Received: by 2002:a05:600c:260e:b0:3fe:1548:264f with SMTP id h14-20020a05600c260e00b003fe1548264fmr433518wma.22.1690823166457;
        Mon, 31 Jul 2023 10:06:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c723:4c00:5c85:5575:c321:cea3? (p200300cbc7234c005c855575c321cea3.dip0.t-ipconnect.de. [2003:cb:c723:4c00:5c85:5575:c321:cea3])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c22c300b003fe13c3ece7sm7762180wmg.10.2023.07.31.10.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 10:06:06 -0700 (PDT)
Message-ID: <b046ce32-2f47-d415-ad40-8be2cc0d5991@redhat.com>
Date:   Mon, 31 Jul 2023 19:06:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "xuyu@linux.alibaba.com" <xuyu@linux.alibaba.com>
References: <cover.1682453344.git.khalid.aziz@oracle.com>
 <74fe50d9-9be9-cc97-e550-3ca30aebfd13@linux.alibaba.com>
 <ZMeoHoM8j/ric0Bh@casper.infradead.org>
 <ae3bbfba-4207-ec5b-b4dd-ea63cb52883d@redhat.com>
 <9faea1cf-d3da-47ff-eb41-adc5bd73e5ca@linux.alibaba.com>
 <d3d03475-7977-fc55-188d-7df350ee0f29@redhat.com>
 <ZMfjmhaqVZyZNNMW@casper.infradead.org>
 <c1f3c78d-b1eb-5c1c-83aa-35901800498f@redhat.com>
 <ZMfnNpQIkXXs1W02@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC v2 0/4] Add support for sharing page tables across
 processes (Previously mshare)
In-Reply-To: <ZMfnNpQIkXXs1W02@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 31.07.23 18:54, Matthew Wilcox wrote:
> On Mon, Jul 31, 2023 at 06:48:47PM +0200, David Hildenbrand wrote:
>> On 31.07.23 18:38, Matthew Wilcox wrote:
>>> On Mon, Jul 31, 2023 at 06:30:22PM +0200, David Hildenbrand wrote:
>>>> Assume we do do the page table sharing at mmap time, if the flags are right.
>>>> Let's focus on the most common:
>>>>
>>>> mmap(memfd, PROT_READ | PROT_WRITE, MAP_SHARED)
>>>>
>>>> And doing the same in each and every process.
>>>
>>> That may be the most common in your usage, but for a database, you're
>>> looking at two usage scenarios.  Postgres calls mmap() on the database
>>> file itself so that all processes share the kernel page cache.
>>> Some Commercial Databases call mmap() on a hugetlbfs file so that all
>>> processes share the same userspace buffer cache.  Other Commecial
>>> Databases call shmget() / shmat() with SHM_HUGETLB for the exact
>>> same reason.
>>
>> I remember you said that postgres might be looking into using shmem as well,
>> maybe I am wrong.
> 
> No, I said that postgres was also interested in sharing page tables.
> I don't think they have any use for shmem.
> 
>> memfd/hugetlb/shmem could all be handled alike, just "arbitrary filesystems"
>> would require more work.
> 
> But arbitrary filesystems was one of the origin use cases; where the
> database is stored on a persistent memory filesystem, and neither the
> kernel nor userspace has a cache.  The Postgres & Commercial Database
> use-cases collapse into the same case, and we want to mmap the files
> directly and share the page tables.

Yes, and transparent page table sharing can be achieved otherwise.

I guess what you imply is that they want to share page tables and have a 
single mprotect(PROT_READ) to modify the shared page tables.

> 
>>> This is why I proposed mshare().  Anyone can use it for anything.
>>> We have such a diverse set of users who want to do stuff with shared
>>> page tables that we should not be tying it to memfd or any other
>>> filesystem.  Not to mention that it's more flexible; you can map
>>> individual 4kB files into it and still get page table sharing.
>>
>> That's not what the current proposal does, or am I wrong?
> 
> I think you're wrong, but I haven't had time to read the latest patches.
> 

Maybe I misunderstood what the MAP_SHARED_PT actually does.

"
This patch series adds a new flag to mmap() call - MAP_SHARED_PT.
This flag can be specified along with MAP_SHARED by a process to
hint to kernel that it wishes to share page table entries for this
file mapping mmap region with other processes. Any other process
that mmaps the same file with MAP_SHARED_PT flag can then share the
same page table entries. Besides specifying MAP_SHARED_PT flag, the
processes must map the files at a PMD aligned address with a size
that is a multiple of PMD size and at the same virtual addresses.
This last requirement of same virtual addresses can possibly be
relaxed if that is the consensus.
"

Reading this, I'm confused how 4k files would interact with the PMD size 
requirement.

Probably I got it all wrong.

>> Also, I'm curious, is that a real requirement in the database world?
> 
> I don't know.  It's definitely an advantage that falls out of the design
> of mshare.

Okay, just checking if there is an important use case I'm missing, I'm 
also not aware of any.


Anyhow, I have other work to do. Happy to continue the discussion 
someone is actually working on this (again).

-- 
Cheers,

David / dhildenb

