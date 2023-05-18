Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733657077B8
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 03:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjERB5d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 21:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjERB5c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 21:57:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F71CAA;
        Wed, 17 May 2023 18:57:31 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QMCfq0WpfzqTXk;
        Thu, 18 May 2023 09:53:07 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 09:57:28 +0800
Message-ID: <4aaec23f-066e-d8cb-b363-d7a999594d60@huawei.com>
Date:   Thu, 18 May 2023 09:57:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5 RESEND 06/17] mm/ioremap: add slab availability
 checking in ioremap_prot
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
        <arnd@arndb.de>, <christophe.leroy@csgroup.eu>,
        <hch@infradead.org>, <agordeev@linux.ibm.com>,
        <schnelle@linux.ibm.com>, <David.Laight@ACULAB.COM>,
        <shorne@gmail.com>, <willy@infradead.org>, <deller@gmx.de>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-7-bhe@redhat.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230515090848.833045-7-bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2023/5/15 17:08, Baoquan He wrote:
> Several architectures has done checking if slab if available in
> ioremap_prot(). In fact it should be done in generic ioremap_prot()
> since on any architecutre, slab allocator must be available before
> get_vm_area_caller() and vunmap() are used.
> 
> Add the checking into generic_ioremap_prot().
> 
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>   mm/ioremap.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
