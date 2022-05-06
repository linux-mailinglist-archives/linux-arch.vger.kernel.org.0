Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4D451CF2A
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 05:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388421AbiEFDFY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 May 2022 23:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiEFDFV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 23:05:21 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56F563BCD;
        Thu,  5 May 2022 20:01:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=30;SR=0;TI=SMTPD_---0VCQ-60L_1651806089;
Received: from 30.32.96.193(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCQ-60L_1651806089)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 May 2022 11:01:31 +0800
Message-ID: <6c8a5b23-e470-63ca-cc82-f8b5ff1bafaf@linux.alibaba.com>
Date:   Fri, 6 May 2022 11:02:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/3] mm: change huge_ptep_clear_flush() to return the
 original pte
To:     Mike Kravetz <mike.kravetz@oracle.com>, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org
Cc:     tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
References: <cover.1651216964.git.baolin.wang@linux.alibaba.com>
 <a9038435d408cd7b9defe143537de668dfdf03be.1651216964.git.baolin.wang@linux.alibaba.com>
 <495c4ebe-a5b4-afb6-4cb0-956c1b18d0cc@oracle.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <495c4ebe-a5b4-afb6-4cb0-956c1b18d0cc@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 5/6/2022 7:15 AM, Mike Kravetz wrote:
> On 4/29/22 01:14, Baolin Wang wrote:
>> It is incorrect to use ptep_clear_flush() to nuke a hugetlb page
>> table when unmapping or migrating a hugetlb page, and will change
>> to use huge_ptep_clear_flush() instead in the following patches.
>>
>> So this is a preparation patch, which changes the huge_ptep_clear_flush()
>> to return the original pte to help to nuke a hugetlb page table.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   arch/arm64/include/asm/hugetlb.h   |  4 ++--
>>   arch/arm64/mm/hugetlbpage.c        | 12 +++++-------
>>   arch/ia64/include/asm/hugetlb.h    |  4 ++--
>>   arch/mips/include/asm/hugetlb.h    |  9 ++++++---
>>   arch/parisc/include/asm/hugetlb.h  |  4 ++--
>>   arch/powerpc/include/asm/hugetlb.h |  9 ++++++---
>>   arch/s390/include/asm/hugetlb.h    |  6 +++---
>>   arch/sh/include/asm/hugetlb.h      |  4 ++--
>>   arch/sparc/include/asm/hugetlb.h   |  4 ++--
>>   include/asm-generic/hugetlb.h      |  4 ++--
>>   10 files changed, 32 insertions(+), 28 deletions(-)
> 
> The above changes look straight forward.
> Happy that you Cc'ed impacted arch maintainers so they can at least
> have a look.
> 
> The only user of huge_ptep_clear_flush() today is hugetlb_cow/wp() in
> mm/hugetlb.c.  Any reason why you did not change that code?  At least

Cause we did not use the return value of huge_ptep_clear_flush() in 
mm/hugetlb.c.

> cast the return of huge_ptep_clear_flush() to void with a comment?

Sure. Will add an explicit casting in next version.

> Not absolutely necessary.
> 
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks.
