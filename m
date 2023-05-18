Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFFC7077B6
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 03:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjERB46 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 21:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjERB46 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 21:56:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2523AA0;
        Wed, 17 May 2023 18:56:56 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QMCgs0M0VzLq1N;
        Thu, 18 May 2023 09:54:01 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 09:56:53 +0800
Message-ID: <b09292dc-22b7-fc9d-79c4-586cf7e36d18@huawei.com>
Date:   Thu, 18 May 2023 09:56:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5 RESEND 05/17] mm: ioremap: allow ARCH to have its own
 ioremap method definition
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
        <arnd@arndb.de>, <christophe.leroy@csgroup.eu>,
        <hch@infradead.org>, <agordeev@linux.ibm.com>,
        <schnelle@linux.ibm.com>, <David.Laight@ACULAB.COM>,
        <shorne@gmail.com>, <willy@infradead.org>, <deller@gmx.de>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-6-bhe@redhat.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230515090848.833045-6-bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
> Architectures can be converted to GENERIC_IOREMAP, to take standard
> ioremap_xxx() and iounmap() way. But some ARCH-es could have specific
> handling for ioremap_prot(), ioremap() and iounmap(), than standard
> methods.
> 
> In oder to convert these ARCH-es to take GENERIC_IOREMAP method, allow
> these architecutres to have their own ioremap_prot(), ioremap() and
> iounmap() definitions.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   include/asm-generic/io.h | 3 +++
>   mm/ioremap.c             | 4 ++++
>   2 files changed, 7 insertions(+)
> 

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

