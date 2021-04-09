Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B982C359E4F
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 14:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbhDIMHr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Apr 2021 08:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32353 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233560AbhDIMHr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Apr 2021 08:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617970053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cPZ0Ie5xguOPpDLkGIOIn4xg63tOXcjWUdAtpJa2pV4=;
        b=AYnrtV5ZdJVKk5m3RhdBd3yFvIlMXhIYBjBCH9bBpSmtOm9aTT3eFFZQNKwAh9au+2rOtq
        x0rj9wE6rlA/w4TUGUKUzhu++ZaydnTcgWvuBd8STsDH6ABnvn8S+qARP19o2xGUZr/kni
        tHRm3WbnJZ2ujdQDPAg0yTrHqXg4jq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-m71PPXm6OwGvDs3bRsxdqA-1; Fri, 09 Apr 2021 08:07:29 -0400
X-MC-Unique: m71PPXm6OwGvDs3bRsxdqA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E92AA801971;
        Fri,  9 Apr 2021 12:07:27 +0000 (UTC)
Received: from [10.36.115.11] (ovpn-115-11.ams2.redhat.com [10.36.115.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75E3460916;
        Fri,  9 Apr 2021 12:07:25 +0000 (UTC)
To:     Alex Ghiti <alex@ghiti.fr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20210409065115.11054-1-alex@ghiti.fr>
 <3500f3cb-b660-5bbc-ae8d-0c9770e4a573@ghiti.fr>
 <be575094-badf-bac7-1629-36808ca530cc@redhat.com>
 <c4e78916-7e4c-76db-47f6-4dda3f09c871@ghiti.fr>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v7] RISC-V: enable XIP
Message-ID: <d4d771a8-c731-acaf-b42d-44800c61f2e6@redhat.com>
Date:   Fri, 9 Apr 2021 14:07:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c4e78916-7e4c-76db-47f6-4dda3f09c871@ghiti.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 09.04.21 13:39, Alex Ghiti wrote:
> Hi David,
> 
> Le 4/9/21 à 4:23 AM, David Hildenbrand a écrit :
>> On 09.04.21 09:14, Alex Ghiti wrote:
>>> Le 4/9/21 à 2:51 AM, Alexandre Ghiti a écrit :
>>>> From: Vitaly Wool <vitaly.wool@konsulko.com>
>>>>
>>>> Introduce XIP (eXecute In Place) support for RISC-V platforms.
>>>> It allows code to be executed directly from non-volatile storage
>>>> directly addressable by the CPU, such as QSPI NOR flash which can
>>>> be found on many RISC-V platforms. This makes way for significant
>>>> optimization of RAM footprint. The XIP kernel is not compressed
>>>> since it has to run directly from flash, so it will occupy more
>>>> space on the non-volatile storage. The physical flash address used
>>>> to link the kernel object files and for storing it has to be known
>>>> at compile time and is represented by a Kconfig option.
>>>>
>>>> XIP on RISC-V will for the time being only work on MMU-enabled
>>>> kernels.
>>>>
>>> I added linux-mm and linux-arch to get feedbacks because I noticed that
>>> DEBUG_VM_PGTABLE fails for SPARSEMEM (it works for FLATMEM but I think
>>> it does not do what is expected): the fact that we don't have any struct
>>> page to back the text and rodata in flash is the problem but to which
>>> extent ?
>>
>> Just wondering, why can't we create a memmap for that memory -- or is it
>> even desireable to not do that explicity? There might be some nasty side
>> effects when not having a memmap for text and rodata.
> 
> 
> Do you have examples of such effects ? Any feature that will not work
> without that ?
> 

At least if it's not part of /proc/iomem in any way (maybe "System RAM" 
is not what we want without a memmap, TBD), kexec-tools won't be able to 
handle it properly e.g., for kdump. But not sure if that is really 
relevant in your setup.

Regarding other features, anything that does a pfn_valid(), 
pfn_to_page() or pfn_to_online_page() would behave differently now -- 
assuming the kernel doesn't fall into a section with other System RAM 
(whereby we would still allocate the memmap for the whole section).

I guess you might stumble over some surprises in some code paths, but 
nothing really comes to mind. Not sure if your zeropage is part of the 
kernel image on RISC-V (I remember that we sometimes need a memmap 
there, but I might be wrong)?

I assume you still somehow create the direct mapping for the kernel, 
right? So it's really some memory region with a direct mapping but 
without a memmap (and right now, without a resource), correct?

[...]

>>
>> Also, will that memory properly be exposed in the resource tree as
>> System RAM (e.g., /proc/iomem) ? Otherwise some things (/proc/kcore)
>> won't work as expected - the kernel won't be included in a dump.
> 
> 
> I have just checked and it does not appear in /proc/iomem.
> 
> Ok your conclusion would be to have struct page, I'm going to implement
> this version then using memblock as you described.

Let's first evaluate what the harm could be. You could (and should?) 
create the kernel resource manually - IIRC, that's independent of the 
memmap/memblock thing.

@Mike, what's your take on not having a memmap for kernel text and ro data?

-- 
Thanks,

David / dhildenb

