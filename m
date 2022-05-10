Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C1B520CD6
	for <lists+linux-arch@lfdr.de>; Tue, 10 May 2022 06:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbiEJEc6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 May 2022 00:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbiEJEbf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 May 2022 00:31:35 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FF43526D;
        Mon,  9 May 2022 21:26:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0VCp29EM_1652156751;
Received: from 30.15.214.13(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCp29EM_1652156751)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 10 May 2022 12:25:53 +0800
Message-ID: <0db300f4-8a91-b330-5c6f-bbc63cf2f151@linux.alibaba.com>
Date:   Tue, 10 May 2022 12:26:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 0/3] Fix CONT-PTE/PMD size hugetlb issue when unmapping
 or migrating
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mike.kravetz@oracle.com, catalin.marinas@arm.com, will@kernel.org,
        songmuchun@bytedance.com, tsbogend@alpha.franken.de,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ysato@users.osdn.me, dalias@libc.org, davem@davemloft.net,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <cover.1652147571.git.baolin.wang@linux.alibaba.com>
 <20220509210404.6a43aff15d0d6b3af0741001@linux-foundation.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220509210404.6a43aff15d0d6b3af0741001@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 5/10/2022 12:04 PM, Andrew Morton wrote:
> On Tue, 10 May 2022 11:45:57 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>> Hi,
>>
>> Now migrating a hugetlb page or unmapping a poisoned hugetlb page, we'll
>> use ptep_clear_flush() and set_pte_at() to nuke the page table entry
>> and remap it, and this is incorrect for CONT-PTE or CONT-PMD size hugetlb
>> page,
> 
> It would be helpful to describe why it's wrong.  Something like "should
> use huge_ptep_clear_flush() and huge_ptep_clear_flush() for this
> purpose"?

Sorry for the confusing description. I described the problem explicitly 
in each patch's commit message.

https://lore.kernel.org/all/ea5abf529f0997b5430961012bfda6166c1efc8c.1652147571.git.baolin.wang@linux.alibaba.com/
https://lore.kernel.org/all/730ea4b6d292f32fb10b7a4e87dad49b0eb30474.1652147571.git.baolin.wang@linux.alibaba.com/

> 
>> which will cause potential data consistent issue. This patch set
>> will change to use hugetlb related APIs to fix this issue, please find
>> details in each patch. Thanks.
> 
> Is a cc:stable needed here?  And are we able to identify a target for a
> Fixes: tag?

I think need a cc:stable tag, however I am not sure the target fixes 
tag, since we should trace back to the introduction of CONT-PTE/PMD 
hugetlb? 66b3923a1a0f ("arm64: hugetlb: add support for PTE contiguous bit")
