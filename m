Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7097A359F08
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 14:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhDIMqj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Apr 2021 08:46:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232855AbhDIMqj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Apr 2021 08:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617972386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f+xd8ydLnyzhrcApE0s32pZuwoI7owl2AW9EUlJO53w=;
        b=GaJWPoMglnlAgQCXI7OcXeO5TQahdIFieDJk2+/BCUK6nFnriICROpneTD0z6VJnPIlkQn
        D2R0+7jAgaoNTXeT2i3wqUIFOEt5JEL/f3DAAkkSc2uORsyMp33pcfxl3bNimmnzG/Qnzb
        Ih4VO0xRresXwV8X0lsEZRz0zCVznIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-gNrwR-0SPUSqTDOnc5osug-1; Fri, 09 Apr 2021 08:46:22 -0400
X-MC-Unique: gNrwR-0SPUSqTDOnc5osug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92EB28030A0;
        Fri,  9 Apr 2021 12:46:20 +0000 (UTC)
Received: from [10.36.115.11] (ovpn-115-11.ams2.redhat.com [10.36.115.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 618F819C66;
        Fri,  9 Apr 2021 12:46:18 +0000 (UTC)
Subject: Re: [PATCH v7] RISC-V: enable XIP
To:     Mike Rapoport <rppt@linux.ibm.com>, Alex Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Vitaly Wool <vitaly.wool@konsulko.com>
References: <20210409065115.11054-1-alex@ghiti.fr>
 <3500f3cb-b660-5bbc-ae8d-0c9770e4a573@ghiti.fr>
 <be575094-badf-bac7-1629-36808ca530cc@redhat.com>
 <c4e78916-7e4c-76db-47f6-4dda3f09c871@ghiti.fr>
 <YHBEsDuEvPAnL8Vb@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <e7e87306-bb04-2d4f-7e7f-aabd40dccb3b@redhat.com>
Date:   Fri, 9 Apr 2021 14:46:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YHBEsDuEvPAnL8Vb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>>> Also, will that memory properly be exposed in the resource tree as
>>> System RAM (e.g., /proc/iomem) ? Otherwise some things (/proc/kcore)
>>> won't work as expected - the kernel won't be included in a dump.
>   
> Do we really need a XIP kernel to included in kdump?
> And does not it sound weird to expose flash as System RAM in /proc/iomem? ;-)

See my other mail, maybe we actually want something different.

> 
>> I have just checked and it does not appear in /proc/iomem.
>>
>> Ok your conclusion would be to have struct page, I'm going to implement this
>> version then using memblock as you described.
> 
> I'm not sure this is required. With XIP kernel text never gets into RAM, so
> it does not seem to require struct page.
> 
> XIP by definition has some limitations relatively to "normal" operation,
> so lack of kdump could be one of them.

I agree.

> 
> I might be wrong, but IMHO, artificially creating a memory map for part of
> flash would cause more problems in the long run.

Can you elaborate?

> 
> BTW, how does XIP account the kernel text on other architectures that
> implement it?

Interesting point, I thought XIP would be something new on RISC-V (well, 
at least to me :) ). If that concept exists already, we better mimic 
what existing implementations do.

-- 
Thanks,

David / dhildenb

