Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48363769C89
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 18:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjGaQbp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 12:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjGaQbo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 12:31:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED0D10E4
        for <linux-arch@vger.kernel.org>; Mon, 31 Jul 2023 09:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690821027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=px7yZE/hl3CkWpJKpt6G6+MH9UKWdf3vJIyU3rBolmc=;
        b=N9NYo8ToHrfk/V9WSvCkugNEbzedL/HuITD9WFJ8qVVDhAZuOxwpxIMUxjcRQYao8vIM6o
        AY6NKlh398B63q39E7aVNxg98tVzOh6gKZKperlXVNdL5IxOZHXv9UbQBTmGu2kZdGM3HS
        SkCF8W1+a6YQnD7p3DFSN+VKKSQ4m24=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-FwYzBs2-MXWUQSQuAkavKg-1; Mon, 31 Jul 2023 12:30:25 -0400
X-MC-Unique: FwYzBs2-MXWUQSQuAkavKg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe1dadb5d2so7388455e9.1
        for <linux-arch@vger.kernel.org>; Mon, 31 Jul 2023 09:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690821024; x=1691425824;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=px7yZE/hl3CkWpJKpt6G6+MH9UKWdf3vJIyU3rBolmc=;
        b=ERdL+aA3n1ePzRmnpo2E0i4WA7SQSFQ6GjlmhGPV6n9E4AzKGf/RX/uYUldWCA9WNG
         qVEQvdhATRbqTu1H4Hb6gcV9HntHD9lZKEwkQy50ROoH4oeAxXxVfJHoUVhMh7iIfjDV
         mbRM0yzllds31wsa9nUREbFOT8SZlrzJgOiukZxPkPCBWkEXYV4BbDEV3kH7FYgLYxDj
         I8lVST6UIGC6cg0rSZKtEejVemM494A1ufQD6aPF27h4R6Yc1tgATY6kaT0HTtOynH/8
         PlWHCjJEwkg6yVckpBOGrIeFrifXhhrZcGdB9SfgKaefhiuWr+YygQ9v14vb2RmQIrYd
         6elQ==
X-Gm-Message-State: ABy/qLZxDr4poCYruAg6r3veLexFxJs5ZM0GDXt+mo43sG6wat+Es+E6
        sYYMty/oXyQhbKJ6r1QDlJfdO+f+3EoCFF0XkoVN6y2G7Y7SwfoTUSzHxgDBN8dnA+0gLGXGUgT
        iwwiClen2rtWOQ7+lcHKhqA==
X-Received: by 2002:a7b:c859:0:b0:3fe:1b9e:e790 with SMTP id c25-20020a7bc859000000b003fe1b9ee790mr371391wml.2.1690821024148;
        Mon, 31 Jul 2023 09:30:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE4rPnoOFUauKsSsg9IXIbvMihh3+dXLQtyh593VbGQxpvSA34OH+mZ1+oH3S9DGahyG33ryw==
X-Received: by 2002:a7b:c859:0:b0:3fe:1b9e:e790 with SMTP id c25-20020a7bc859000000b003fe1b9ee790mr371366wml.2.1690821023756;
        Mon, 31 Jul 2023 09:30:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c723:4c00:5c85:5575:c321:cea3? (p200300cbc7234c005c855575c321cea3.dip0.t-ipconnect.de. [2003:cb:c723:4c00:5c85:5575:c321:cea3])
        by smtp.gmail.com with ESMTPSA id l22-20020a1c7916000000b003fe22da3bc5sm2293142wme.42.2023.07.31.09.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 09:30:23 -0700 (PDT)
Message-ID: <d3d03475-7977-fc55-188d-7df350ee0f29@redhat.com>
Date:   Mon, 31 Jul 2023 18:30:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "xuyu@linux.alibaba.com" <xuyu@linux.alibaba.com>
References: <cover.1682453344.git.khalid.aziz@oracle.com>
 <74fe50d9-9be9-cc97-e550-3ca30aebfd13@linux.alibaba.com>
 <ZMeoHoM8j/ric0Bh@casper.infradead.org>
 <ae3bbfba-4207-ec5b-b4dd-ea63cb52883d@redhat.com>
 <9faea1cf-d3da-47ff-eb41-adc5bd73e5ca@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC v2 0/4] Add support for sharing page tables across
 processes (Previously mshare)
In-Reply-To: <9faea1cf-d3da-47ff-eb41-adc5bd73e5ca@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 31.07.23 18:19, Rongwei Wang wrote:
> 
> On 2023/7/31 20:50, David Hildenbrand wrote:
>> On 31.07.23 14:25, Matthew Wilcox wrote:
>>> On Mon, Jul 31, 2023 at 12:35:00PM +0800, Rongwei Wang wrote:
>>>> Hi Matthew
>>>>
>>>> May I ask you another question about mshare under this RFC? I
>>>> remember you
>>>> said you will redesign the mshare to per-vma not per-mapping
>>>> (apologize if
>>>> remember wrongly) in last time MM alignment session. And I also
>>>> refer to you
>>>> to re-code this part in our internal version (based on this RFC). It
>>>> seems
>>>> that per VMA will can simplify the structure of pgtable sharing, even
>>>> doesn't care the different permission of file mapping. these are
>>>> advantages
>>>> (maybe) that I can imagine. But IMHO, It seems not a strongly reason to
>>>> switch per-mapping to per-vma.
>>>>
>>>> And I can't imagine other considerations of upstream. Can you share the
>>>> reason why redesigning in a per-vma way, due to integation with
>>>> hugetlbfs
>>>> pgtable sharing or anonymous page sharing?
>>>
>>> It was David who wants to make page table sharing be per-VMA.  I think
>>> he is advocating for the wrong approach.  In any case, I don't have time
>>> to work on mshare and Khalid is on leave until September, so I don't
>>> think anybody is actively working on mshare.
>>
>> Not that I also don't have any time to look into this, but my comment
>> essentially was that we should try decoupling page table sharing
>> (reduce memory consumption, shorter rmap walk) from the
>> mprotect(PROT_READ) use case.
> 
> Hi David, Matthew
> 
> Thanks for your reply.
> 
> Uh, sorry, I can't imagine the relative between decouping page table
> sharing with per-VMA design. And I think mprotect(PROT_READ) has to
> modify all sharing page tables of related tasks. It seems that I miss
> something about per-VMA from your words.

Assume we do do the page table sharing at mmap time, if the flags are 
right. Let's focus on the most common:

mmap(memfd, PROT_READ | PROT_WRITE, MAP_SHARED)

And doing the same in each and every process.


Having the original design of doing an mprotect(PROT_READ) in each and 
every process is just absolutely inefficient to protect a memfd page.

For that case, my thought was that you actually want to write-protect 
the pages on the memfd level.

So instead of doing mprotect(PROT_READ) in 999 processes, or doing 
mprotect(PROT_READ) on mshare(), you have memfd feature to protect pages 
from any write access -- not using virtual addresses but using an offset 
in the memfd.


Assume such a (badly imagined) memfd_protect(PROT_READ) would make sure 
that:
(1) Any page table mappings of the page are write-protected and
(2) Any write access using the page table mappings trigger write-notify and
(3) Any other access -- e.g., write() -- similarly informs memfd.

Without page table sharing, (1) would have to walk all mappings via the 
rmap. With page table sharing, it would only have to walk one page table.

But the features would be two separate things.

What memfd would do with that write notification (inject a signal, 
something like uffd) would be a different story.


Again, just an idea and maybe complete garbage.

-- 
Cheers,

David / dhildenb

