Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7E8467D29
	for <lists+linux-arch@lfdr.de>; Fri,  3 Dec 2021 19:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhLCSYO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Dec 2021 13:24:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38924 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239716AbhLCSYN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Dec 2021 13:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638555649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qgsO3oHAmFJzKq+dVmJv06T3M/ORmohx5le6ux9ty9c=;
        b=bhHBJvxiCWUR7VbhYghOxUAsBMzqMUHmBzvarYUAVK4RFNESORb5UiThllxjfUWSJFOYsP
        xrfHMd963etXqtitrFa+4VSDhMgOUh8rDxwzcoC/HRM4lLzhWjAs3QXenA3Z1vKTIbPKM7
        yM0qYmKX0uscRwoQMCbW4ecRNNleJYQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-zZSeZhYZNieRrHfivlMRwg-1; Fri, 03 Dec 2021 13:20:48 -0500
X-MC-Unique: zZSeZhYZNieRrHfivlMRwg-1
Received: by mail-wm1-f69.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so3815256wma.3
        for <linux-arch@vger.kernel.org>; Fri, 03 Dec 2021 10:20:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=qgsO3oHAmFJzKq+dVmJv06T3M/ORmohx5le6ux9ty9c=;
        b=r4DD96Ap9NwQgv1TanCNSVZ+meCrGAuXs/pFKmzhXag0itl3ZrO3qtBBNw937lIs49
         5QJiauH7lmuKDAZKYteWPofTk8QI0LQfklJeO7UyumGvMjsTiN0gTytR5E3nZohMu2mn
         QCIJTslQxuBtMxqFBlXu1xDAWO/kajmBW1xkLJoR2/4+wo0Rvx0qIEL5NXKExFFzCLdU
         vCWk8cD48vKlFfhDLO2PoGutww0wJbgf881qKc+mZtk/khJS0PU362Y2PO5YLHKiO1ME
         eXINGTwB27EGhbcL/b6jDIVKazpNhVqmqi4LPyuhctyYJ28e59QYbqxCxLtm/zcJQdRd
         BDFg==
X-Gm-Message-State: AOAM530mTBGJYkm3v+LMUDWR2e9sfW74RSWC3gXW0qAHksfkXPBe8Sa4
        mXlpqBYqo2MlDoU6k5IKqAWFxHWhaGuCFRtqxLK5mZF66xqXqZzS3wr82DcRcPbvDVRhVMH0zZC
        sFgOdH9lGuzbYGEuJmp8Z5g==
X-Received: by 2002:a05:6000:2c7:: with SMTP id o7mr24017452wry.62.1638555647053;
        Fri, 03 Dec 2021 10:20:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8CavJ4evptW+LbrLlZf/myYwiY1F8lIjOYR0WgVLxsVzfjSUUsdpB9qGAHvDNHYUc5Gd9IQ==
X-Received: by 2002:a05:6000:2c7:: with SMTP id o7mr24017435wry.62.1638555646881;
        Fri, 03 Dec 2021 10:20:46 -0800 (PST)
Received: from ?IPV6:2003:d8:2f44:9200:3344:447e:353c:bf0b? (p200300d82f4492003344447e353cbf0b.dip0.t-ipconnect.de. [2003:d8:2f44:9200:3344:447e:353c:bf0b])
        by smtp.gmail.com with ESMTPSA id l22sm3203749wmp.34.2021.12.03.10.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 10:20:46 -0800 (PST)
Message-ID: <1e0ce8f6-332b-399f-5ac7-5a56639172b3@redhat.com>
Date:   Fri, 3 Dec 2021 19:20:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFD] clear virtual machine memory when virtual machine is turned
 off
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        fei luo <morphyluo@gmail.com>, akpm@linux-foundation.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
Cc:     Joao Martins <joao.m.martins@oracle.com>
References: <CAMgLiBskDz7XW9-0=azOgVJ00t8zFOXjdGaH7NLpKDfNH9wsGQ@mail.gmail.com>
 <673c5628-da97-83d3-028f-46219f203caf@redhat.com>
 <e13bd5e9-981f-e2f1-fdd9-049a1926d70f@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <e13bd5e9-981f-e2f1-fdd9-049a1926d70f@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 02.12.21 18:27, Mike Kravetz wrote:
> On 12/2/21 04:47, David Hildenbrand wrote:
>> On 02.12.21 11:19, fei luo wrote:
>>>
>>> When reusing the page that has been cleared, there is no need to clear it
>>>
>>> again, which also speeds up the memory allocation of user-mode programs.
>>>
>>>
>>> Is this feature feasible?
>>
>> "init_on_free=1" for the system as a whole, which might sounds like what
>> might tackle part of your use case.
>>
> 
> Certainly init_on_free will not make much difference if VMs are backed by
> hugetlb pages.  We (Joao and myself) have thought about clearing hugetlb
> pages from user space in an attempt speed up launching of VMs backed by
> hugetlb pages.
> 

I remember that discussion. And I also recall a discussion regarding
extending init_on_free semantics to hugetlbfs.

-- 
Thanks,

David / dhildenb

