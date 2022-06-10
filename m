Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7631545AE1
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jun 2022 05:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240953AbiFJD7V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jun 2022 23:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346587AbiFJD6s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jun 2022 23:58:48 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD0245792;
        Thu,  9 Jun 2022 20:58:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VFxazjx_1654833523;
Received: from 30.0.143.52(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VFxazjx_1654833523)
          by smtp.aliyun-inc.com;
          Fri, 10 Jun 2022 11:58:44 +0800
Message-ID: <6351ead6-b4b8-dc43-2c1d-c099094cadc9@linux.alibaba.com>
Date:   Fri, 10 Jun 2022 11:58:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [mm] 9b12e49e9b: BUG:Bad_page_state_in_process
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org,
        openrisc@lists.librecores.org, linux-arch@vger.kernel.org,
        lkp@lists.01.org, akpm@linux-foundation.org, linux-mm@kvack.org
References: <20220608143819.GA31193@xsang-OptiPlex-9020>
 <d64da0da-9f71-3ae9-4d72-00b0c42fce5e@linux.alibaba.com>
 <YqHlKj5LbmtYGWUy@casper.infradead.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YqHlKj5LbmtYGWUy@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 6/9/2022 8:18 PM, Matthew Wilcox wrote:
> On Thu, Jun 09, 2022 at 12:42:16PM +0800, Baolin Wang wrote:
>> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
>> index 6cccf52e156a..cae74e972426 100644
>> --- a/arch/x86/mm/pgtable.c
>> +++ b/arch/x86/mm/pgtable.c
>> @@ -858,6 +858,7 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>>          /* INVLPG to clear all paging-structure caches */
>>          flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
>>
>> +       pgtable_clear_and_dec(virt_to_page(pte));
>>          free_page((unsigned long)pte);
>>
>>          return 1;
> 
> If you're going to call virt_to_page() here, you may as well cache the
> result and call __free_page(page) to avoid calling virt_to_page() twice.

Right, will do in next version. Thanks.
