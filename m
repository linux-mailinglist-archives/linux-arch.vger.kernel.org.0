Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04325F8AD4
	for <lists+linux-arch@lfdr.de>; Sun,  9 Oct 2022 13:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJILN7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Oct 2022 07:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJILN5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Oct 2022 07:13:57 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D9027141;
        Sun,  9 Oct 2022 04:13:55 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MlfSg0MX3z1P75B;
        Sun,  9 Oct 2022 19:09:23 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 19:13:53 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 19:13:52 +0800
Message-ID: <10ada8f0-0931-b6a6-e240-fc8b500e578d@huawei.com>
Date:   Sun, 9 Oct 2022 19:13:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 03/11] mm/ioremap: change the return value of
 io[re|un]map_allowed and rename
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
        <hch@infradead.org>, <agordeev@linux.ibm.com>,
        <christophe.leroy@csgroup.eu>, <schnelle@linux.ibm.com>,
        <David.Laight@ACULAB.COM>, <shorne@gmail.com>,
        "Arnd Bergmann" <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20221009103114.149036-1-bhe@redhat.com>
 <20221009103114.149036-4-bhe@redhat.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20221009103114.149036-4-bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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


On 2022/10/9 18:31, Baoquan He wrote:
> Currently, hooks ioremap_allowed() and iounmap_allowed() are used to
> check if it's qualified to do ioremap, and now this is done on ARM64.
> However, in oder to convert more architectures to take GENERIC_IOREMAP
> method, several more things need be done in those two hooks:
>   1) The io address mapping need be handled specifically on architectures,
>      e.g arc, ia64, s390;
>   2) The original physical address passed into ioremap_prot() need be
>      fixed up, e.g arc;
>   3) The 'prot' passed into ioremap_prot() need be adjusted, e.g on arc
>      and xtensa.
>
> To handle these three issues,
>
>   1) Rename ioremap_allowed() and iounmap_allowed() to arch_ioremap()
>      and arch_iounmap() since the old name can't reflect their
>      functionality after change;
>   2) Change the return value of arch_ioremap() so that arch can add
>      specifical io address mapping handling inside and return the maped
>      address. Now their returned value means:
>      ===
>      arch_ioremap() return a bool,
pointer?
>        - IS_ERR means return an error
>        - 0 means continue to remap
>        - a non-zero, non-IS_ERR pointer is returned directly
>      arch_iounmap() return a bool,
>        - true means continue to vunmap
>        - false means skip vunmap and return directly
...
>   /*
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index a68f8fbf423b..2ae16906f3be 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -1049,25 +1049,26 @@ static inline void iounmap(volatile void __iomem *addr)
>   
>   /*
>    * Arch code can implement the following two hooks when using GENERIC_IOREMAP
> - * ioremap_allowed() return a bool,
> - *   - true means continue to remap
> - *   - false means skip remap and return directly
> - * iounmap_allowed() return a bool,
> + * arch_ioremap() return a bool,
ditto...
>   	area = get_vm_area_caller(size, VM_IOREMAP,
>   			__builtin_return_address(0));
>   	if (!area)
> @@ -52,7 +57,7 @@ void iounmap(volatile void __iomem *addr)
>   {
>   	void *vaddr = (void *)((unsigned long)addr & PAGE_MASK);
>   
> -	if (!iounmap_allowed(vaddr))
> +	if (!arch_iounmap((void __iomem *)addr))
vaddr?
>   		return;
>   
>   	if (is_vmalloc_addr(vaddr))
