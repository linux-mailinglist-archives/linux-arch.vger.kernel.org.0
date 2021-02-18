Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9749E31E942
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 12:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhBRLrD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Feb 2021 06:47:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230471AbhBRK4c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Feb 2021 05:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613645705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gcqiQcLIQresUmqBjSfx8mrrnANdscT5bovWT1NTSz4=;
        b=RbMuaZstJ6CrGg4oZoL5YG7svl5DHKGEf1wjaUssrTflC9zkTDIx2aqkNx4R9yEHjj/GQo
        ivX8Rkt2Fl0Fvr6kT9YAdKWpQ7SnLbk9fTKa3Wrwos/6r4zfOGSVj53QVGRcydY6V8EXbF
        zZv44dg4pKP5TVkprrvN+0/8wO5f9uk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-9O4f9C2-NQaWM_0J6rqvXQ-1; Thu, 18 Feb 2021 05:55:01 -0500
X-MC-Unique: 9O4f9C2-NQaWM_0J6rqvXQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 032E7107ACC7;
        Thu, 18 Feb 2021 10:54:58 +0000 (UTC)
Received: from [10.36.114.59] (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29CF45D9C2;
        Thu, 18 Feb 2021 10:54:49 +0000 (UTC)
Subject: Re: [PATCH RFC] mm/madvise: introduce MADV_POPULATE to
 prefault/prealloc memory
From:   David Hildenbrand <david@redhat.com>
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
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
References: <20210217154844.12392-1-david@redhat.com>
 <YC5Am6a4KMSA8XoK@dhcp22.suse.cz>
 <3763a505-02d6-5efe-a9f5-40381acfbdfd@redhat.com>
Organization: Red Hat GmbH
Message-ID: <de28b8db-a103-5bc2-8ace-d2907026a95d@redhat.com>
Date:   Thu, 18 Feb 2021 11:54:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <3763a505-02d6-5efe-a9f5-40381acfbdfd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>>>      If we hit
>>>      hardware errors on pages, ignore them - nothing we really can or
>>>      should do.
>>> 3. On errors during MADV_POPULATED, some memory might have been
>>>      populated. Callers have to clean up if they care.
>>
>> How does caller find out? madvise reports 0 on success so how do you
>> find out how much has been populated?
> 
> If there is an error, something might have been populated. In my QEMU
> implementation, I simply discard the range again, good enough. I don't
> think we need to really indicate "error and populated" or "error and not
> populated".

Clarifying again: if madvise(MADV_POPULATED) succeeds, it returns 0. If 
there was a problem poopulating memory, it returns -ENOMEM (similar to 
MADV_WILLNEED). Callers can detect the error and discard.

-- 
Thanks,

David / dhildenb

