Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A897696CA
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 14:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjGaMwA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 08:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjGaMv4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 08:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EF610DF
        for <linux-arch@vger.kernel.org>; Mon, 31 Jul 2023 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690807864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=84KWZN3/Cp66pCpih1k+aMiQI8Xpxjc8sclddBLm/oE=;
        b=ZBz6e0uGK+ikpJSWFCHA3cofPrtiG5PddifYSsWJ+XbnfyFfbbTvR4rIXcmS5vxCy4x7AB
        5XfVcYvQP2q2EUOaFyT7wwsdqeciUd7kj11UcgNsBA/4gMTbk1XAEC+TdMX9v9Fer4j2M6
        18CiqEUIFWyfwxVQj0pR8y/Js9E5O4w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-rkHBlisWPIasVGzpnV8jwA-1; Mon, 31 Jul 2023 08:51:02 -0400
X-MC-Unique: rkHBlisWPIasVGzpnV8jwA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fe1bef4223so7123575e9.0
        for <linux-arch@vger.kernel.org>; Mon, 31 Jul 2023 05:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690807862; x=1691412662;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84KWZN3/Cp66pCpih1k+aMiQI8Xpxjc8sclddBLm/oE=;
        b=JHgZMC8MfUqPOzkCBJpE2tQXcVGfYlC+rk6qU68AJAmdy7YTK3xTIihs03vJJvzSZ3
         iIwfCBYGvVK1PN9RzNkl9gnW+g0ps5bgm+JOvpBzqMdyCvjD9AYWXC6vFSRlUFJIuKqO
         ekT9oZFskPnlH337wacvo4zYUxe8pjFZvYC5VNADsPp3WP4mvOOnhWV1g5u58YJPqpl6
         XWJtvqqAMqD/oakA8SvUJkNoBcIBHYzhTLKVdGVN1iOcMvVRqZBzcWFrQ7gyCkpxeUO8
         fLO643YP8gyVqVa1O01bZyJTeof+5lDwHa/it5t3igmJQu5khI0y8MBpAC3VTDxnuaoE
         IMwg==
X-Gm-Message-State: ABy/qLYZWkn25qbqlKwD8ZvZdG1L47BhkwN5/gu/RDdFx1vMcCe33tLZ
        9XT1zZ5aEmBCrIvsNywymsbid6XxiYwtEjweWw/8d0+ArLMeqmVwz0Gj3hF6nUYSNre23FEmlQK
        PcB5HrVzdO18UbJov+z2vWA==
X-Received: by 2002:adf:ea4b:0:b0:317:5849:c2e0 with SMTP id j11-20020adfea4b000000b003175849c2e0mr7238454wrn.9.1690807861763;
        Mon, 31 Jul 2023 05:51:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEJQrfVikayMf0IsKJjnYIPL3QRn3J9y6TzxNIyAXEm2FG75J8eow3X9SP4R2jpj0KHNj+FyQ==
X-Received: by 2002:adf:ea4b:0:b0:317:5849:c2e0 with SMTP id j11-20020adfea4b000000b003175849c2e0mr7238436wrn.9.1690807861313;
        Mon, 31 Jul 2023 05:51:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c723:4c00:5c85:5575:c321:cea3? (p200300cbc7234c005c855575c321cea3.dip0.t-ipconnect.de. [2003:cb:c723:4c00:5c85:5575:c321:cea3])
        by smtp.gmail.com with ESMTPSA id a10-20020a5d508a000000b0031773e3cf46sm13111204wrt.61.2023.07.31.05.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 05:51:00 -0700 (PDT)
Message-ID: <ae3bbfba-4207-ec5b-b4dd-ea63cb52883d@redhat.com>
Date:   Mon, 31 Jul 2023 14:50:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "xuyu@linux.alibaba.com" <xuyu@linux.alibaba.com>
References: <cover.1682453344.git.khalid.aziz@oracle.com>
 <74fe50d9-9be9-cc97-e550-3ca30aebfd13@linux.alibaba.com>
 <ZMeoHoM8j/ric0Bh@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC v2 0/4] Add support for sharing page tables across
 processes (Previously mshare)
In-Reply-To: <ZMeoHoM8j/ric0Bh@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 31.07.23 14:25, Matthew Wilcox wrote:
> On Mon, Jul 31, 2023 at 12:35:00PM +0800, Rongwei Wang wrote:
>> Hi Matthew
>>
>> May I ask you another question about mshare under this RFC? I remember you
>> said you will redesign the mshare to per-vma not per-mapping (apologize if
>> remember wrongly) in last time MM alignment session. And I also refer to you
>> to re-code this part in our internal version (based on this RFC). It seems
>> that per VMA will can simplify the structure of pgtable sharing, even
>> doesn't care the different permission of file mapping. these are advantages
>> (maybe) that I can imagine. But IMHO, It seems not a strongly reason to
>> switch per-mapping to per-vma.
>>
>> And I can't imagine other considerations of upstream. Can you share the
>> reason why redesigning in a per-vma way, due to integation with hugetlbfs
>> pgtable sharing or anonymous page sharing?
> 
> It was David who wants to make page table sharing be per-VMA.  I think
> he is advocating for the wrong approach.  In any case, I don't have time
> to work on mshare and Khalid is on leave until September, so I don't
> think anybody is actively working on mshare.

Not that I also don't have any time to look into this, but my comment 
essentially was that we should try decoupling page table sharing (reduce 
memory consumption, shorter rmap walk) from the mprotect(PROT_READ) use 
case.

For page table sharing I was wondering whether there could be ways to 
just have that done semi-automatically. Similar to how it's done for 
hugetlb. There are some clear limitations: mappings < PMD_SIZE won't be 
able to benefit.

It's still unclear whether that is a real limitation. Some use cases 
were raised (put all user space library mappings into a shared area), 
but I realized that these conflict with MAP_PRIVATE requirements of such 
areas. Maybe I'm wrong and this is easily resolved.

At least it's not the primary use case that was raised. For the primary 
use cases (VMs, databases) that map huge areas, it might not be a 
limitation.


Regarding mprotect(PROT_READ), my point was that mprotect() is most 
probably the wrong tool to use (especially, due to signal handling). 
Instead, I was suggesting having a way to essentially protect pages in a 
shmem file -- and get notified whenever wants to write to such a page 
either via the page tables or via write() and friends. We do have the 
write-notify infrastructure for filesystems in place that we might 
extend/reuse. That mechanism could benefit from shared page tables by 
having to do less rmap walks.

Again, I don't have time to look into that (just like everybody else as 
it appears) and might miss something important. Just sharing my thoughts 
that I raised in the call.

-- 
Cheers,

David / dhildenb

