Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8632035A0DA
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 16:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbhDIORL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Apr 2021 10:17:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53553 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232642AbhDIORK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Apr 2021 10:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617977817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7lJbgd2hYY827G0NWvg1oy4yBkmSJegYFDEkQ7hgRxA=;
        b=BYqB95MhceHs4AJrUa8zlRHyTswcZ3H4qKTPhdoCsFBLGuy3c9IgksPYJQyT31zGxOmQww
        Ufy76vJXnvRvJy1up6koXtM7ozgLlysc/SOO5DKKFKP63CDYJ5gfrcyP/aFeyz//tLTxox
        U70cLgQRoffXjJSGSpCZCRtGFnGW4fA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-CbpfF08qOAm3ydVeGePGJg-1; Fri, 09 Apr 2021 10:16:55 -0400
X-MC-Unique: CbpfF08qOAm3ydVeGePGJg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39E0B807344;
        Fri,  9 Apr 2021 14:16:54 +0000 (UTC)
Received: from [10.36.115.11] (ovpn-115-11.ams2.redhat.com [10.36.115.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FF2A648A1;
        Fri,  9 Apr 2021 14:16:51 +0000 (UTC)
Subject: Re: [PATCH v7] RISC-V: enable XIP
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Alex Ghiti <alex@ghiti.fr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Vitaly Wool <vitaly.wool@konsulko.com>
References: <20210409065115.11054-1-alex@ghiti.fr>
 <3500f3cb-b660-5bbc-ae8d-0c9770e4a573@ghiti.fr>
 <be575094-badf-bac7-1629-36808ca530cc@redhat.com>
 <c4e78916-7e4c-76db-47f6-4dda3f09c871@ghiti.fr>
 <d4d771a8-c731-acaf-b42d-44800c61f2e6@redhat.com>
 <YHBgUs1JKvHWkG9F@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <2d442bca-c367-598c-b4ee-746925517118@redhat.com>
Date:   Fri, 9 Apr 2021 16:16:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YHBgUs1JKvHWkG9F@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 09.04.21 16:10, Mike Rapoport wrote:
> On Fri, Apr 09, 2021 at 02:07:24PM +0200, David Hildenbrand wrote:
>> On 09.04.21 13:39, Alex Ghiti wrote:
>>> Hi David,
>>
>> I assume you still somehow create the direct mapping for the kernel, right?
>> So it's really some memory region with a direct mapping but without a memmap
>> (and right now, without a resource), correct?
> 
> XIP kernel text is not a region in memory to begin with ;-)

I think that's the part that confused me. I thought it would be mapped 
somehow into physical address space and would be addressed like other 
memory -- just that reads would be rewired to go to flash.

> 
> It resides in a flash and it is executed directly from there without being
> relocated to RAM.
> 
> That's why it does not need neither direct mapping, nor struct pages.

Thanks for clarifying! :)

-- 
Thanks,

David / dhildenb

