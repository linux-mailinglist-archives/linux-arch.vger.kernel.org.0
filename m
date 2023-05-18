Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16597077BC
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 03:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjERB6w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 21:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjERB6u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 21:58:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC235FD;
        Wed, 17 May 2023 18:58:49 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QMCgq17zWzTkqT;
        Thu, 18 May 2023 09:53:59 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 09:58:47 +0800
Message-ID: <0cb84102-083f-bb2a-1c07-98764c12b5ae@huawei.com>
Date:   Thu, 18 May 2023 09:58:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5 RESEND 17/17] mm: ioremap: remove unneeded
 ioremap_allowed and iounmap_allowed
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
        <arnd@arndb.de>, <christophe.leroy@csgroup.eu>,
        <hch@infradead.org>, <agordeev@linux.ibm.com>,
        <schnelle@linux.ibm.com>, <David.Laight@ACULAB.COM>,
        <shorne@gmail.com>, <willy@infradead.org>, <deller@gmx.de>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-18-bhe@redhat.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230515090848.833045-18-bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2023/5/15 17:08, Baoquan He wrote:
> Now there are no users of ioremap_allowed and iounmap_allowed, clean
> them up.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>   include/asm-generic/io.h | 26 --------------------------
>   mm/ioremap.c             |  6 ------
>   2 files changed, 32 deletions(-)
> 

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
