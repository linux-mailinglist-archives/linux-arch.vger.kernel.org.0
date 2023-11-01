Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A4E7DE1FC
	for <lists+linux-arch@lfdr.de>; Wed,  1 Nov 2023 15:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjKAOD6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Nov 2023 10:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344315AbjKAOD5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Nov 2023 10:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F1411F
        for <linux-arch@vger.kernel.org>; Wed,  1 Nov 2023 07:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698847386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=4qPavatvkwmUdF4Ofe6L1kWMfN08faPQqt3/qXkkW6s=;
        b=KhFu3BHDwD5AQe3DJrNglXRZZsERKgVp8e4impStTEV1h5ctUgo3kSA2NWkm/onuN3rvLZ
        +MdX62dmJ1fKarZ7Ok+Zz4Qa6ny/U5kNPKPZJYMUo+R+jqkBf1I/WJizNAQNDr+bU9W5AC
        YioxLN+ONnrl+GOUF2a7d/yBjY0kXHw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-dnWF_2HAOSCsvGVDG9CTHw-1; Wed, 01 Nov 2023 10:03:02 -0400
X-MC-Unique: dnWF_2HAOSCsvGVDG9CTHw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4083717431eso48356575e9.1
        for <linux-arch@vger.kernel.org>; Wed, 01 Nov 2023 07:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698847374; x=1699452174;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qPavatvkwmUdF4Ofe6L1kWMfN08faPQqt3/qXkkW6s=;
        b=NtxzDnzK/OxUFclgDgQ+XOS39Hjt5Jyg2ggICF55eW7zZwgLgJMrcVhFxBiSzEhj2A
         hIqorxkTjn2haEtuogaJEsdvOfJXjC7dXrQ0Ns8Bb9MkqyjuSxwf82o0dHUhZ/XPqNZ6
         nLe7m9GC+IvizpPmD/KdqdhDHTPZbB1yxWAe2kzkGDcx6sOepLQbjQNymrEKJX7XN0os
         RHI4n4XEiFNf+d0DHiYEu+Rv80KEdyPa4CLCybRSnj8WuUMmPObpsyL7OBtENRh0+ZI/
         8bxpi0YsFxn4xgjuYKkgqwQp7XY3iE5RAT1kbzpeXsA2B6ZlKauD3taHfUBuoUjsXM5P
         Equw==
X-Gm-Message-State: AOJu0YxG2IPQFz9CZYs/uz60R6lpSg3+TA0j10gfAslFf5kWDQzLGvZS
        oFELmbiItq/Seoj63Ae+2k9r8tHtLySSGjglRcxQlTyJcin+2AXUGgHC5PlttY5VxD+OiZYIz2P
        IySNOn+4/WyPbjzg3rN2AP0P6IG+++g==
X-Received: by 2002:a05:600c:3c9a:b0:404:2dbb:8943 with SMTP id bg26-20020a05600c3c9a00b004042dbb8943mr14116073wmb.2.1698847374222;
        Wed, 01 Nov 2023 07:02:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9dFjMGLwfAHQP7EZnPWyGt4Sp0tXs97KVt2riCI88+MfS0RMbmA4Xw0/EWF5XXPefwEaZOw==
X-Received: by 2002:a05:600c:3c9a:b0:404:2dbb:8943 with SMTP id bg26-20020a05600c3c9a00b004042dbb8943mr14116042wmb.2.1698847373782;
        Wed, 01 Nov 2023 07:02:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:f400:399f:9457:3eb8:da7f? (p200300cbc70bf400399f94573eb8da7f.dip0.t-ipconnect.de. [2003:cb:c70b:f400:399f:9457:3eb8:da7f])
        by smtp.gmail.com with ESMTPSA id dn11-20020a0560000c0b00b0032da319a27asm4253674wrb.9.2023.11.01.07.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 07:02:53 -0700 (PDT)
Message-ID: <1358598e-2c5b-4600-af54-64bf241dc760@redhat.com>
Date:   Wed, 1 Nov 2023 15:02:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Sharing page tables across processes (mshare)
To:     Khalid Aziz <khalid.aziz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>, rongwei.wang@linux.alibaba.com,
        Mark Hemment <markhemm@googlemail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <4082bc40-a99a-4b54-91e5-a1b55828d202@oracle.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4082bc40-a99a-4b54-91e5-a1b55828d202@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> ----------
> What next?
> ----------
> 
> There were some more discussions on this proposal while I was on
> leave for a few months. There is enough interest in this feature to
> continue to refine this. I will refine the code further but before
> that I want to make sure we have a common understanding of what this
> feature should do.

Did you follow-up on the alternatives discussed in a bi-weekly mm 
session on this topic or is there some other reason you are leaving that 
out?

To be precise, I raised that both problems should likely be decoupled 
(sharing of page tables as an optimization, NOT using mprotect to catch 
write access to pagecache pages). And that page table sharing better 
remains an implementation detail.

Sharing of page tables (as learned by hugetlb) can easily be beneficial 
to other use cases -- for example, multi-process VMs; no need to bring 
in mshare. There was the concern that it might not always be reasonable 
to share page tables, so one could just have some kind of hint (madvise? 
mmap flag?) that it might be reasonable to try sharing page tables. But 
it would be a pure internal optimization. Just like it is for hugetlb we 
would unshare as soon as someone does an mprotect() etc. Initially, you 
could simply ignore any such hint for filesystems that don't support it. 
Starting with shmem sounds reasonable.

Write access to pagecache pages (or also read-access?) would ideally be 
handled on the pagecache level, so you could catch any write (page 
tables, write(), ... and eventually later read access if required) and 
either notify someone (uffd-style, just on a fd) or send a signal to the 
faulting process. That would be a new feature, of course. But we do have 
writenotify infrastructure in place to catch write access to pagecache 
pages already, whereby we inform the FS that someone wants to write to a 
PTE-read-only pagecache page.

Once you combine both features, you can easily update only a single 
shared page table when updating the page protection as triggered by the 
FS/yet-to-be-named-feature and have all processes sharing these page 
tables see the change in one go.

> 
> As a result of many discussions, a new distinct version of
> original proposal has evolved. Which one do we agree to continue
> forward with - (1) current version which restricts sharing to PMD sized
> and aligned file mappings only, using just a new mmap flag
> (MAP_SHARED_PT), or (2) original version that creates an empty page
> table shared mshare region using msharefs and mmap for arbitrary
> objects to be mapped into later?

So far my opinion on this is unchanged: turning an implementation detail 
(sharing of page tables) into a feature to bypass per-process VMA 
permissions sounds absolutely bad to me.

The original concept of mshare certainly sounds interesting, but as 
discussed a couple of times (LSF/mm), it similarly sounds "dangerous" 
the way it was originally proposed.

Having some kind of container that multiple process can mmap (fd?), and 
*selected* mmap()/mprotect()/ get rerouted to the container could be 
interesting; but it might be reasonable to then have separate operations 
to work on such an fd (ioctl), and *not* using mmap()/mprotect() for 
that. And one might only want to allow to mmap that fd with a superset 
of all permissions used inside the container (and only MAP_SHARED), and 
strictly filter what we allow to map into such a container. page table 
sharing would likely be an implementation detail.

Just some random thoughts (some of which I previously raised). Probably 
makes sense to discuss that in a bi-weekly mm meeting (again, this time 
with you as well).

-- 
Cheers,

David / dhildenb

