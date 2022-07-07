Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E31E56A13F
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jul 2022 13:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbiGGLpe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jul 2022 07:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbiGGLpd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jul 2022 07:45:33 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07194F65D;
        Thu,  7 Jul 2022 04:45:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=32;SR=0;TI=SMTPD_---0VIcuH0b_1657194323;
Received: from 30.97.48.62(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VIcuH0b_1657194323)
          by smtp.aliyun-inc.com;
          Thu, 07 Jul 2022 19:45:25 +0800
Message-ID: <12227412-1d79-4ff6-b4e6-0d438dac7359@linux.alibaba.com>
Date:   Thu, 7 Jul 2022 19:45:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] mm: Add kernel PTE level pagetable pages account
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, rppt@linux.ibm.com, will@kernel.org,
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
 <398ead25695e530f766849be5edafaf62c1c864d.1657096412.git.baolin.wang@linux.alibaba.com>
 <YsWuC9+b3JaEAr0Q@casper.infradead.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YsWuC9+b3JaEAr0Q@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 7/6/2022 11:45 PM, Matthew Wilcox wrote:
> On Wed, Jul 06, 2022 at 04:59:17PM +0800, Baolin Wang wrote:
>> Now the kernel PTE level ptes are always protected by mm->page_table_lock
>> instead of split pagetable lock, so the kernel PTE level pagetable pages
>> are not accounted. Especially the vmalloc()/vmap() can consume lots of
>> kernel pagetable, so to get an accurate pagetable accounting, calling new
>> helpers page_{set,clear}_pgtable() when allocating or freeing a kernel
>> PTE level pagetable page.
>>
>> Meanwhile converting architectures to use corresponding generic PTE pagetable
>> allocation and freeing functions.
>>
>> Note this patch only adds accounting to the page tables allocated after boot.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> What does this Reported-by: even mean?  the kernel test robot told you
> that the page tables weren't being accounted?

I fixed an issue reported by this robot. OK, I can remove the tag.

> I don't understand why we want to start accounting kernel page tables.
> an we have a *discussion* about that with a sensible thread name instead
> of just trying to sneak it in as patch 3/3?

I think I have replied to you in below link [1]. The reason is we should 
keep consistent with PMD or PUD pagetable allocation.

[1] 
https://lore.kernel.org/all/68a5286b-7ff3-2c4e-1ab2-305e7860a2f3@linux.alibaba.com/
