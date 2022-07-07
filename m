Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E3356A10C
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jul 2022 13:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbiGGLcv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jul 2022 07:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiGGLct (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jul 2022 07:32:49 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18CD2FFF2;
        Thu,  7 Jul 2022 04:32:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=33;SR=0;TI=SMTPD_---0VIdIQWG_1657193558;
Received: from 30.97.48.62(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VIdIQWG_1657193558)
          by smtp.aliyun-inc.com;
          Thu, 07 Jul 2022 19:32:40 +0800
Message-ID: <ef376131-bf5f-7e5b-ea1b-1e8f64a6d060@linux.alibaba.com>
Date:   Thu, 7 Jul 2022 19:32:44 +0800
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
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <d2d58cc2-7e6d-aa2d-3096-a500ce321494@intel.com>
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



On 7/6/2022 11:48 PM, Dave Hansen wrote:
> On 7/6/22 01:59, Baolin Wang wrote:
>> Now we will miss to account the PUD level pagetable and kernel PTE level
>> pagetable, as well as missing to set the PG_table flags for these pagetable
>> pages, which will get an inaccurate pagetable accounting, and miss
>> PageTable() validation in some cases. So this patch set introduces new
>> helpers to help to account PUD and kernel PTE pagetable pages.
> 
> Could you explain the motivation for this series a bit more?  Is there a
> real-world problem that this fixes?

Not fix real problem. The motivation is that making the pagetable 
accounting more accurate, which helps us to analyse the consumption of 
the pagetable pages in some cases, and maybe help to do some empty 
pagetable reclaiming in future.
