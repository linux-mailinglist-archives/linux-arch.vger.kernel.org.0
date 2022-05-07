Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D3751E309
	for <lists+linux-arch@lfdr.de>; Sat,  7 May 2022 03:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355291AbiEGBgB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 21:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbiEGBgA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 21:36:00 -0400
Received: from out199-4.us.a.mail.aliyun.com (out199-4.us.a.mail.aliyun.com [47.90.199.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F90058E7E;
        Fri,  6 May 2022 18:32:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=30;SR=0;TI=SMTPD_---0VCUCndB_1651887123;
Received: from 30.236.9.83(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCUCndB_1651887123)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 07 May 2022 09:32:05 +0800
Message-ID: <971cfb54-f5a6-921c-b0c5-195a5daed0fb@linux.alibaba.com>
Date:   Sat, 7 May 2022 09:32:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] mm: rmap: Fix CONT-PTE/PMD size hugetlb issue when
 unmapping
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
 <c91e04ebb792ef7b72966edea8bd6fa2dfa5bfa7.1651216964.git.baolin.wang@linux.alibaba.com>
 <f64f0d4f-f0fc-f07c-3c17-96f124da21e4@oracle.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <f64f0d4f-f0fc-f07c-3c17-96f124da21e4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 5/7/2022 2:55 AM, Mike Kravetz wrote:
> On 4/29/22 01:14, Baolin Wang wrote:
>> On some architectures (like ARM64), it can support CONT-PTE/PMD size
>> hugetlb, which means it can support not only PMD/PUD size hugetlb:
>> 2M and 1G, but also CONT-PTE/PMD size: 64K and 32M if a 4K page
>> size specified.
>>
>> When unmapping a hugetlb page, we will get the relevant page table
>> entry by huge_pte_offset() only once to nuke it. This is correct
>> for PMD or PUD size hugetlb, since they always contain only one
>> pmd entry or pud entry in the page table.
>>
>> However this is incorrect for CONT-PTE and CONT-PMD size hugetlb,
>> since they can contain several continuous pte or pmd entry with
>> same page table attributes, so we will nuke only one pte or pmd
>> entry for this CONT-PTE/PMD size hugetlb page.
>>
>> And now we only use try_to_unmap() to unmap a poisoned hugetlb page,
> 
> Since try_to_unmap can be called for non-hugetlb pages, perhaps the following
> is more accurate?
> 
> try_to_unmap is only passed a hugetlb page in the case where the
> hugetlb page is poisoned.

Yes, will update in next version.

> It does concern me that this assumption is built into the code as
> pointed out in your discussion with Gerald.  Should we perhaps add
> a VM_BUG_ON() to make sure the passed huge page is poisoned?  This
> would be in the same 'if block' where we call
> adjust_range_if_pmd_sharing_possible.
Good point. Will do in next version. Thanks.
