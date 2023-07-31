Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D228769C22
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 18:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjGaQT1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 12:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjGaQT0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 12:19:26 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B13197;
        Mon, 31 Jul 2023 09:19:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Voh64HD_1690820359;
Received: from 30.27.83.39(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0Voh64HD_1690820359)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 00:19:21 +0800
Message-ID: <9faea1cf-d3da-47ff-eb41-adc5bd73e5ca@linux.alibaba.com>
Date:   Tue, 1 Aug 2023 00:19:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH RFC v2 0/4] Add support for sharing page tables across
 processes (Previously mshare)
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "xuyu@linux.alibaba.com" <xuyu@linux.alibaba.com>
References: <cover.1682453344.git.khalid.aziz@oracle.com>
 <74fe50d9-9be9-cc97-e550-3ca30aebfd13@linux.alibaba.com>
 <ZMeoHoM8j/ric0Bh@casper.infradead.org>
 <ae3bbfba-4207-ec5b-b4dd-ea63cb52883d@redhat.com>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <ae3bbfba-4207-ec5b-b4dd-ea63cb52883d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 2023/7/31 20:50, David Hildenbrand wrote:
> On 31.07.23 14:25, Matthew Wilcox wrote:
>> On Mon, Jul 31, 2023 at 12:35:00PM +0800, Rongwei Wang wrote:
>>> Hi Matthew
>>>
>>> May I ask you another question about mshare under this RFC? I 
>>> remember you
>>> said you will redesign the mshare to per-vma not per-mapping 
>>> (apologize if
>>> remember wrongly) in last time MM alignment session. And I also 
>>> refer to you
>>> to re-code this part in our internal version (based on this RFC). It 
>>> seems
>>> that per VMA will can simplify the structure of pgtable sharing, even
>>> doesn't care the different permission of file mapping. these are 
>>> advantages
>>> (maybe) that I can imagine. But IMHO, It seems not a strongly reason to
>>> switch per-mapping to per-vma.
>>>
>>> And I can't imagine other considerations of upstream. Can you share the
>>> reason why redesigning in a per-vma way, due to integation with 
>>> hugetlbfs
>>> pgtable sharing or anonymous page sharing?
>>
>> It was David who wants to make page table sharing be per-VMA.  I think
>> he is advocating for the wrong approach.  In any case, I don't have time
>> to work on mshare and Khalid is on leave until September, so I don't
>> think anybody is actively working on mshare.
>
> Not that I also don't have any time to look into this, but my comment 
> essentially was that we should try decoupling page table sharing 
> (reduce memory consumption, shorter rmap walk) from the 
> mprotect(PROT_READ) use case.

Hi David, Matthew

Thanks for your reply.

Uh, sorry, I can't imagine the relative between decouping page table 
sharing with per-VMA design. And I think mprotect(PROT_READ) has to 
modify all sharing page tables of related tasks. It seems that I miss 
something about per-VMA from your words.

BTW, I can imagine a corner case to show the defect (maybe) of 
per-mapping. If we create a range of page table sharing by 
memfd_create(), and a child also own this range of page table sharing. 
But this child process can not create page table sharing base on the 
same fd after mumap() this range (same mapping but different vma area). 
Of course, per-VMA is better choice that can continue to create page 
table sharing base on original fd. That's because new mm struct created 
in this way. I guess that is a type of decoupling you said?

It's just corner case. I am not sure how important it is.

>
> For page table sharing I was wondering whether there could be ways to 
> just have that done semi-automatically. Similar to how it's done for 
> hugetlb. There are some clear limitations: mappings < PMD_SIZE won't 
> be able to benefit.
>
> It's still unclear whether that is a real limitation. Some use cases 
> were raised (put all user space library mappings into a shared area), 
> but I realized that these conflict with MAP_PRIVATE requirements of 
> such areas. Maybe I'm wrong and this is easily resolved.
>
> At least it's not the primary use case that was raised. For the 
> primary use cases (VMs, databases) that map huge areas, it might not 
> be a limitation.
>
>
> Regarding mprotect(PROT_READ), my point was that mprotect() is most 
> probably the wrong tool to use (especially, due to signal handling). 
> Instead, I was suggesting having a way to essentially protect pages in 
> a shmem file -- and get notified whenever wants to write to such a 
> page either via the page tables or via write() and friends. We do have 
> the write-notify infrastructure for filesystems in place that we might 
> extend/reuse.
I am poor in filesystem. The write-notify sounds a good idea. Maybe I 
need some times to digest this.
> That mechanism could benefit from shared page tables by having to do 
> less rmap walks.
>
> Again, I don't have time to look into that (just like everybody else 
> as it appears) and might miss something important. Just sharing my 
> thoughts that I raised in the call.

Your words are very helpful to me. I try to design our internal version 
about this feature in a right way.

Thanks again.

