Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F1056CEBA
	for <lists+linux-arch@lfdr.de>; Sun, 10 Jul 2022 13:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiGJLUE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Jul 2022 07:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJLUD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Jul 2022 07:20:03 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DB010557;
        Sun, 10 Jul 2022 04:20:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=33;SR=0;TI=SMTPD_---0VIrBUyv_1657451992;
Received: from 30.39.247.23(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VIrBUyv_1657451992)
          by smtp.aliyun-inc.com;
          Sun, 10 Jul 2022 19:19:54 +0800
Message-ID: <7628e9a7-8e2d-dcfb-09e5-27de36da5af7@linux.alibaba.com>
Date:   Sun, 10 Jul 2022 19:19:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] Add PUD and kernel PTE level pagetable account
To:     Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org
Cc:     rppt@linux.ibm.com, willy@infradead.org, will@kernel.org,
        aneesh.kumar@linux.ibm.com, npiggin@gmail.com,
        peterz@infradead.org, catalin.marinas@arm.com,
        chenhuacai@kernel.org, kernel@xen0n.name,
        tsbogend@alpha.franken.de, dave.hansen@linux.intel.com,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, arnd@arndb.de, guoren@kernel.org,
        monstr@monstr.eu, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linux-csky@vger.kernel.org,
        openrisc@lists.librecores.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1657096412.git.baolin.wang@linux.alibaba.com>
 <d2d58cc2-7e6d-aa2d-3096-a500ce321494@intel.com>
 <ef376131-bf5f-7e5b-ea1b-1e8f64a6d060@linux.alibaba.com>
 <8821beda-4d60-4d01-b5c8-1629a19c7f0d@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <8821beda-4d60-4d01-b5c8-1629a19c7f0d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 7/7/2022 10:44 PM, Dave Hansen wrote:
> On 7/7/22 04:32, Baolin Wang wrote:
>> On 7/6/2022 11:48 PM, Dave Hansen wrote:
>>> On 7/6/22 01:59, Baolin Wang wrote:
>>>> Now we will miss to account the PUD level pagetable and kernel PTE level
>>>> pagetable, as well as missing to set the PG_table flags for these
>>>> pagetable
>>>> pages, which will get an inaccurate pagetable accounting, and miss
>>>> PageTable() validation in some cases. So this patch set introduces new
>>>> helpers to help to account PUD and kernel PTE pagetable pages.
>>>
>>> Could you explain the motivation for this series a bit more?  Is there a
>>> real-world problem that this fixes?
>>
>> Not fix real problem. The motivation is that making the pagetable
>> accounting more accurate, which helps us to analyse the consumption of
>> the pagetable pages in some cases, and maybe help to do some empty
>> pagetable reclaiming in future.
> 
> This accounting isn't free.  It costs storage (and also parts of
> cachelines) in each mm and CPU time to maintain it, plus maintainer
> eyeballs to maintain.  PUD pages are also fundamentally (on x86 at
> least) 0.0004% of the overhead of PTE and 0.2% of the overhead of PMD
> pages unless someone is using gigantic hugetlbfs mappings.

Yes, agree. However I think the performence influence of this patch is 
small from some testing I did (like mysql, no obvious performance 
influence). Moreover the pagetable accounting gap is about 1% from below 
testing data.

Without this patchset, the pagetable consumption is about 110M with 
mysql testing.
              flags      page-count       MB  symbolic-flags 
          long-symbolic-flags
0x0000000004000000           28232      110 
__________________________g__________________      pgtable

With this patchset, and the consumption is about 111M.
              flags      page-count       MB  symbolic-flags 
          long-symbolic-flags
0x0000000004000000           28459      111 
__________________________g__________________      pgtable


> Even with 1G gigantic pages, you would need a quarter of a million
> (well, 262144 or 512*512) mappings of one 1G page to consume 1G of
> memory on PUD pages.
> 
> That just doesn't seem like something anyone is likely to actually do in
> practice.  That makes the benefits of the PUD portion of this series
> rather unclear in the real world.
> 
> As for the kernel page tables, I'm not really aware of them causing any
> problems.  We have a pretty good idea how much space they consume from
> the DirectMap* entries in meminfo:
> 
> 	DirectMap4k:     2262720 kB
> 	DirectMap2M:    40507392 kB
> 	DirectMap1G:    24117248 kB

However these statistics are arch-specific information, which only 
available on x86, s390 and powerpc.

> as well as our page table debugging infrastructure.  I haven't found
> myself dying for more specific info on them.
> 
> So, nothing in this series seems like a *BAD* idea, but I'm not sure in
> the end it solves more problems than it creates.

Thanks for your input.
