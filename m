Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BFB7DFB7D
	for <lists+linux-arch@lfdr.de>; Thu,  2 Nov 2023 21:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjKBU00 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Nov 2023 16:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjKBU0Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Nov 2023 16:26:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1C3197
        for <linux-arch@vger.kernel.org>; Thu,  2 Nov 2023 13:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698956733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=VsDqPWH+t/yQGhBndaPGZQVRm/8Po6pc3sidIL9VAUU=;
        b=RMpNrmR/mUhiA1bMLjUTby6ps/oAC6X9r3ybLBftHHAKfq5ej+QpCmzQYXzvDtxpXAqZYR
        dq4T7UHyVEQm8+O3i+SIorgf7oGibLwvU8KvXrcAfUsw0WqIr04u+O0Zyy4JIVJ0LXs/m1
        LvAtHmG2vybmD83SQiNePTor7plI1To=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-p4wQ5cEUOMKfVNXXq-pR9w-1; Thu, 02 Nov 2023 16:25:32 -0400
X-MC-Unique: p4wQ5cEUOMKfVNXXq-pR9w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4094e5664a3so8851765e9.0
        for <linux-arch@vger.kernel.org>; Thu, 02 Nov 2023 13:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698956730; x=1699561530;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsDqPWH+t/yQGhBndaPGZQVRm/8Po6pc3sidIL9VAUU=;
        b=eBbqxpqpS4htXT+qsNusZ6/zJReqb1wIbyjcnhkT2rYpZsi81I0FnzWnIJNP5DOhKZ
         OVFIzWdgvPgvzKjv3AJSNoiAuhBnv/3hOCje4DkwJV7zS1ScmVfTFNTY/ojlYzFjzxaN
         sRoe8TtFSiu1a7ewPhv5nSlzMs45tM9OxWd1hUbb5u6QeXZWTA6kyjGqNA5yREx25LF4
         5h7v8s5xbc4cwYkEl5qg7c9Hk44FmQeMc/YoURn/mZV4s+6JswMC9VCg3sFuRjI8o5GE
         Bnb0n8cUtR8GhD49/7jkiUE5LJJCvCVLYI33Bl3VTQlcTsiLbee7HTA4/18dNhpFfd+s
         hLqg==
X-Gm-Message-State: AOJu0YyF+gOrWriCQNNEr0rN+V3RVSgQ+lNbyOSfBJ5iYvYgzqb8v2Pl
        tgr18ZIFnWfoWTD6wBvczjU62oxRz1iwhWHrv7w+bezc46i/xLGZmKVHMPmn5KUH+K+b+DXl/Gz
        u9DCujg5GuXCLvUlI6Q6dLg==
X-Received: by 2002:a05:600c:a03:b0:409:51c2:1192 with SMTP id z3-20020a05600c0a0300b0040951c21192mr7551463wmp.38.1698956730649;
        Thu, 02 Nov 2023 13:25:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFplHRiBTpNbYrLsxJwABSBvTJKRMM8iJySeuN20lNXUcrfP7RfixdOtEzAI8hMJzfQU66W7Q==
X-Received: by 2002:a05:600c:a03:b0:409:51c2:1192 with SMTP id z3-20020a05600c0a0300b0040951c21192mr7551431wmp.38.1698956729928;
        Thu, 02 Nov 2023 13:25:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c716:3000:f155:cef2:ff4d:c7? (p200300cbc7163000f155cef2ff4d00c7.dip0.t-ipconnect.de. [2003:cb:c716:3000:f155:cef2:ff4d:c7])
        by smtp.gmail.com with ESMTPSA id bh5-20020a05600c3d0500b004094e565e71sm227759wmb.23.2023.11.02.13.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 13:25:29 -0700 (PDT)
Message-ID: <927b6339-ac5f-480c-9cdc-49c838cbef20@redhat.com>
Date:   Thu, 2 Nov 2023 21:25:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Sharing page tables across processes (mshare)
Content-Language: en-US
To:     Khalid Aziz <khalid.aziz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>, rongwei.wang@linux.alibaba.com,
        Mark Hemment <markhemm@googlemail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <4082bc40-a99a-4b54-91e5-a1b55828d202@oracle.com>
 <1358598e-2c5b-4600-af54-64bf241dc760@redhat.com>
 <a1d6a3de-502e-4114-a603-01710e30428e@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a1d6a3de-502e-4114-a603-01710e30428e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 01.11.23 23:40, Khalid Aziz wrote:
> On 11/1/23 08:02, David Hildenbrand wrote:
>>
>>> ----------
>>> What next?
>>> ----------
>>>
>>> There were some more discussions on this proposal while I was on
>>> leave for a few months. There is enough interest in this feature to
>>> continue to refine this. I will refine the code further but before
>>> that I want to make sure we have a common understanding of what this
>>> feature should do.
>>
>> Did you follow-up on the alternatives discussed in a bi-weekly mm session on this topic or is there some other reason
>> you are leaving that out?

Hi Khalid,

> 
> I did a poor job of addressing it :) What we are trying to implement here is to allow disjoint processes to share page
> tables AND page protection across all processes. It is not the intent to simply catch a process trying to write to a
> protected page. Mechanism already exists for that. The intent is when page protection is changed for one process, it
> applies instantly to all processes. Using mprotect to catch a change in page protection continues the same problem
> database is experiencing. Database wants to be able to change read/write permissions for terrabytes of data for all
> clients very quickly and simultaneously. Today it requires coordination across 1000s of processes to accomplish that. It

Right, because you have to issue an mprotect() in each and every process 
context ...

> is slow and impacts database performance significantly. For each process to have to handle a fault/signal whenever page
> protection is changed impacts every process. By sharing same PTE across all processes, any page protection changes apply

... and everyone has to get the fault and mprotect() again,

Which is one of the reasons why I said that mprotect() is simply the 
wrong tool to use here.

You want to protect a pagecache page from write access, catch write 
access and handle it, to then allow write-access again without 
successive fault->signal. Something similar is being done by filesystems 
already with the writenotify infrastructure I believe. You just don't 
get a signal on write access, because it's all handled internally in the FS.

Literally anything is better than using mprotect() here (uffd-wp would 
also be a faster alternative, but it similarly suffers from the 
multi-process setup; back when uffd-wp was introduced for shmem, I 
already raised that a an alternative for multi-process use would be to 
write-protect on the pagecache level instead of on individual VMAs. But 
Peter's position was that uffd-wp as is might also be helpful for some 
use cases that are single-process and we simply want to support shmem as 
well).

> instantly to all processes (there is the TLB shootdown issue but as discussed in the meeting, it can be handled). The
> mshare proposal implements the instant page protection change while bringing in benefits of shared page tables at the
> same time. So the two requirements of this feature are not separable.

Right, and I think we should talk about the problem we are trying to 
solve and not a solution to the problem. Because the current solution 
really requires sharing of page tables, which I absolutely don't like.

It absolutely makes no sense to bring in mprotect and VMAs when wanting 
to catch all write accesses to a pagecache page. And because we still 
decide to do so, we have to come up with ways of making page table 
sharing a user-visible feature with weird VMA semantics.

> It is a requirement of the feature to bypass
> per-process vma permissions. Processes that require per-process vma permissions would not use mshare and thus the
> requirement for a process to opt into mshare. Matthew, your thoughts?
> 
> Hopefully I understood your suggestion to separate the two requirements correctly. We can discuss it at another
> alignment meeting if that helps.

Yes, I believe there are cleaner alternatives that

(a) don't use mprotect()
(b) don't imply page table sharing (although it's a reasonable thing
     to use internally as an implementation detail to speed things up
     further)

If it's some API to write-protect on the pagecache level + page table 
sharing as optimization or some modified form of mshare (below), I can't 
tell.

> 
>>
>> To be precise, I raised that both problems should likely be decoupled (sharing of page tables as an optimization, NOT
>> using mprotect to catch write access to pagecache pages). And that page table sharing better remains an implementation
>> detail.
>>
>> Sharing of page tables (as learned by hugetlb) can easily be beneficial to other use cases -- for example, multi-process
>> VMs; no need to bring in mshare. There was the concern that it might not always be reasonable to share page tables, so
>> one could just have some kind of hint (madvise? mmap flag?) that it might be reasonable to try sharing page tables. But
>> it would be a pure internal optimization. Just like it is for hugetlb we would unshare as soon as someone does an
>> mprotect() etc. Initially, you could simply ignore any such hint for filesystems that don't support it. Starting with
>> shmem sounds reasonable.
>>
>> Write access to pagecache pages (or also read-access?) would ideally be handled on the pagecache level, so you could
>> catch any write (page tables, write(), ... and eventually later read access if required) and either notify someone
>> (uffd-style, just on a fd) or send a signal to the faulting process. That would be a new feature, of course. But we do
>> have writenotify infrastructure in place to catch write access to pagecache pages already, whereby we inform the FS that
>> someone wants to write to a PTE-read-only pagecache page.
>>
>> Once you combine both features, you can easily update only a single shared page table when updating the page protection
>> as triggered by the FS/yet-to-be-named-feature and have all processes sharing these page tables see the change in one go.
>>
>>>
>>> As a result of many discussions, a new distinct version of
>>> original proposal has evolved. Which one do we agree to continue
>>> forward with - (1) current version which restricts sharing to PMD sized
>>> and aligned file mappings only, using just a new mmap flag
>>> (MAP_SHARED_PT), or (2) original version that creates an empty page
>>> table shared mshare region using msharefs and mmap for arbitrary
>>> objects to be mapped into later?
> 
> At the meeting Matthew expressed desire to support mapping in any objects in the mshare'd region which makes this
> feature much more versatile. That was the intent of the original proposal which was not fd and MMAP_SHARED_PT based.
> That is (2) above. The current version was largely based upon your suggestion at LSF/MM to restrict this feature to file
> mappings only.

It's been a while, but I remember that the feedback in the room was 
primarily that:
(a) the original mshare approach/implementation had a very dangerous
     smell to it. Rerouting mmap/mprotect/... is just absolutely nasty.
(b) that pure page table sharing itself might be itself a reasonable
     optimization worth having.

I still think generic page table sharing (as a pure optimization) can be 
something reasonable to have, and can help existing use cases without 
the need to modify any software (well, except maybe give a hint that it 
might be reasonable).

As said, I see value in some fd-thingy that can be mmaped, but is 
internally assembled from other fds (using protect ioctls, not mmap) 
with sub-protection (using protect ioctls, not mprotect). The ioctls 
would be minimal and clearly specified. Most madvise()/uffd/... would 
simply fail when seeing a VMA that mmaps such a fd thingy. No rerouting 
of mmap, munmap, mprotect, ...

Under the hood, one can use a MM to manage all that and share page 
tables. But it would be an implementation detail.

> 
>>
>> So far my opinion on this is unchanged: turning an implementation detail (sharing of page tables) into a feature to
>> bypass per-process VMA permissions sounds absolutely bad to me.
> 
> I agree if a feature silently bypasses per-process VMA permissions, that is a terrible idea. This is why we have
> explicit opt-in requirement and intent is to bypass per-vma permissions by sharing PTE, as opposed to shared PTE
> bringing in the feature of bypassing per-vma permissions.

Let's talk about cleaner alternatives, at least we should try :)

> 
>>
>> The original concept of mshare certainly sounds interesting, but as discussed a couple of times (LSF/mm), it similarly
>> sounds "dangerous" the way it was originally proposed.
>>
>> Having some kind of container that multiple process can mmap (fd?), and *selected* mmap()/mprotect()/ get rerouted to
>> the container could be interesting; but it might be reasonable to then have separate operations to work on such an fd
>> (ioctl), and *not* using mmap()/mprotect() for that. And one might only want to allow to mmap that fd with a superset of
>> all permissions used inside the container (and only MAP_SHARED), and strictly filter what we allow to map into such a
>> container. page table sharing would likely be an implementation detail.
>>
>> Just some random thoughts (some of which I previously raised). Probably makes sense to discuss that in a bi-weekly mm
>> meeting (again, this time with you as well).
>>
> 
> I appreciate your thoughts and your helping move this discussion forward.

Yes, I'm happy to discuss further. In a bi-weekly MM meeting, off-list 
or here.

-- 
Cheers,

David / dhildenb

