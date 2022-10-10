Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C265F9670
	for <lists+linux-arch@lfdr.de>; Mon, 10 Oct 2022 03:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiJJBF1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Oct 2022 21:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiJJBFH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Oct 2022 21:05:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9985721804;
        Sun,  9 Oct 2022 17:55:07 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mm0h90V2jzlXRl;
        Mon, 10 Oct 2022 08:50:33 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 08:55:04 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 08:55:03 +0800
Message-ID: <5dbf1591-fb8c-5b78-62fc-c1fc0dc6273d@huawei.com>
Date:   Mon, 10 Oct 2022 08:55:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 03/11] mm/ioremap: change the return value of
 io[re|un]map_allowed and rename
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <hch@infradead.org>,
        <agordeev@linux.ibm.com>, <christophe.leroy@csgroup.eu>,
        <schnelle@linux.ibm.com>, <David.Laight@aculab.com>,
        <shorne@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20221009103114.149036-1-bhe@redhat.com>
 <20221009103114.149036-4-bhe@redhat.com>
 <10ada8f0-0931-b6a6-e240-fc8b500e578d@huawei.com>
 <Y0NmcspddDQICfTi@MiWiFi-R3L-srv>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Y0NmcspddDQICfTi@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 2022/10/10 8:25, Baoquan He wrote:
> On 10/09/22 at 07:13pm, Kefeng Wang wrote:
>> On 2022/10/9 18:31, Baoquan He wrote:
>>> Currently, hooks ioremap_allowed() and iounmap_allowed() are used to
>>> check if it's qualified to do ioremap, and now this is done on ARM64.
>>> However, in oder to convert more architectures to take GENERIC_IOREMAP
>>> method, several more things need be done in those two hooks:
>>>    1) The io address mapping need be handled specifically on architectures,
>>>       e.g arc, ia64, s390;
>>>    2) The original physical address passed into ioremap_prot() need be
>>>       fixed up, e.g arc;
>>>    3) The 'prot' passed into ioremap_prot() need be adjusted, e.g on arc
>>>       and xtensa.
>>>
>>> To handle these three issues,
>>>
>>>    1) Rename ioremap_allowed() and iounmap_allowed() to arch_ioremap()
>>>       and arch_iounmap() since the old name can't reflect their
>>>       functionality after change;
>>>    2) Change the return value of arch_ioremap() so that arch can add
>>>       specifical io address mapping handling inside and return the maped
>>>       address. Now their returned value means:
>>>       ===
>>>       arch_ioremap() return a bool,
>> pointer?
> Right, I forgot fixing it again. Thanks.
>
>>>         - IS_ERR means return an error
>>>         - 0 means continue to remap
>>>         - a non-zero, non-IS_ERR pointer is returned directly
>>>       arch_iounmap() return a bool,
>>>         - true means continue to vunmap
>>>         - false means skip vunmap and return directly
>> ...
>>>    /*
>>> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
>>> index a68f8fbf423b..2ae16906f3be 100644
>>> --- a/include/asm-generic/io.h
>>> +++ b/include/asm-generic/io.h
>>> @@ -1049,25 +1049,26 @@ static inline void iounmap(volatile void __iomem *addr)
>>>    /*
>>>     * Arch code can implement the following two hooks when using GENERIC_IOREMAP
>>> - * ioremap_allowed() return a bool,
>>> - *   - true means continue to remap
>>> - *   - false means skip remap and return directly
>>> - * iounmap_allowed() return a bool,
>>> + * arch_ioremap() return a bool,
>> ditto...
> Will change.
>
>>>    	area = get_vm_area_caller(size, VM_IOREMAP,
>>>    			__builtin_return_address(0));
>>>    	if (!area)
>>> @@ -52,7 +57,7 @@ void iounmap(volatile void __iomem *addr)
>>>    {
>>>    	void *vaddr = (void *)((unsigned long)addr & PAGE_MASK);
>>> -	if (!iounmap_allowed(vaddr))
>>> +	if (!arch_iounmap((void __iomem *)addr))
>> vaddr?
> No, it's intentional. Alexander suggested this, both of you discussed
> this in v1, see below thread.
ok, please ignore it.
> https://lore.kernel.org/all/Yu4mYxpV0GWRTjQp@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com/T/#u
>
>>>    		return;
>>>    	if (is_vmalloc_addr(vaddr))
>
> .
