Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA655442BF
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jun 2022 06:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiFIEpA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jun 2022 00:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiFIEpA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jun 2022 00:45:00 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7DE23687C;
        Wed,  8 Jun 2022 21:44:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VFqwi0e_1654749895;
Received: from 30.97.48.137(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VFqwi0e_1654749895)
          by smtp.aliyun-inc.com;
          Thu, 09 Jun 2022 12:44:55 +0800
Message-ID: <59676cdf-a719-efcd-d5c1-b43198dc4348@linux.alibaba.com>
Date:   Thu, 9 Jun 2022 12:45:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [mm] 9b12e49e9b: BUG:Bad_page_state_in_process
To:     Matthew Wilcox <willy@infradead.org>,
        kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, openrisc@lists.librecores.org,
        linux-arch@vger.kernel.org, lkp@lists.01.org,
        akpm@linux-foundation.org, linux-mm@kvack.org
References: <d35f42f7b598f629437940f941826e2cc49a97f6.1654271618.git.baolin.wang@linux.alibaba.com>
 <20220608143819.GA31193@xsang-OptiPlex-9020>
 <YqC7K0e2FFp7vT6i@casper.infradead.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YqC7K0e2FFp7vT6i@casper.infradead.org>
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



On 6/8/2022 11:07 PM, Matthew Wilcox wrote:
> On Wed, Jun 08, 2022 at 10:38:19PM +0800, kernel test robot wrote:
>>
>>
>> Greeting,
>>
>> FYI, we noticed the following commit (built with gcc-11):
>>
>> commit: 9b12e49e9b02bbaca8041f236a6b2fd4586d45c8 ("[RFC PATCH 3/3] mm: Add kernel PTE level pagetable pages account")
> 
>> [   75.338681][ T4873] BUG: Bad page state in process 444  pfn:20b066
>> [   75.338840][ T4873] page:0000000016cf0259 refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x20b066
> 
> mapcount:-512 is PG_table.  Somebody forgot to call
> pgtable_pte_page_dtor() (or similar)

Right. Thanks for reminding. :)
