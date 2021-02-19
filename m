Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B124A31F619
	for <lists+linux-arch@lfdr.de>; Fri, 19 Feb 2021 09:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhBSIw7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Feb 2021 03:52:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12192 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhBSIw5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Feb 2021 03:52:57 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dhldj4s0gzlMgR;
        Fri, 19 Feb 2021 16:50:17 +0800 (CST)
Received: from [10.174.177.80] (10.174.177.80) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 19 Feb 2021 16:52:05 +0800
Subject: Re: [PATCH v12 13/14] mm/vmalloc: Hugepage vmalloc mappings
To:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20210202110515.3575274-1-npiggin@gmail.com>
 <20210202110515.3575274-14-npiggin@gmail.com>
 <e18ef38c-ecef-b15c-29b1-bd4acf0e7fe5@huawei.com>
 <1613720396.pnvmwaa8om.astroid@bobo.none>
From:   Ding Tianhong <dingtianhong@huawei.com>
Message-ID: <913cd34a-453c-ae66-ff87-4b0c74c98eb6@huawei.com>
Date:   Fri, 19 Feb 2021 16:52:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <1613720396.pnvmwaa8om.astroid@bobo.none>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.80]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2021/2/19 15:45, Nicholas Piggin wrote:
> Excerpts from Ding Tianhong's message of February 19, 2021 1:45 pm:
>> Hi Nicholas:
>>
>> I met some problem for this patch, like this:
>>
>> kva = vmalloc(3*1024k);
>>
>> remap_vmalloc_range(xxx, kva, xxx)
>>
>> It failed because that the check for page_count(page) is null so return, it break the some logic for current modules.
>> because the new huge page is not valid for composed page.
> 
> Hey Ding, that's a good catch. How are you testing this stuff, do you 
> have a particular driver that does this?
> 

yes, The driver would get a memory from the vmalloc in kernel space, and then the physical same memory will mmap to the user space. The drivers could not work when applying this patch.

>> I think some guys really don't get used to the changes for the vmalloc that the small pages was transparency to the hugepage
>> when the size is bigger than the PMD_SIZE.
> 
> I think in this case vmalloc could allocate the large page as a compound
> page which would solve this problem I think? (without having actually 
> tested it)
> 

yes, i think the __GFP_COMP flag could fix this.

>> can we think about give a new static huge page to fix it? just like use a a new vmalloc_huge_xxx function to disginguish the current function,
>> the user could choose to use the transparent hugepage or static hugepage for vmalloc.
> 
> Yeah that's a good question, there are a few things in the huge vmalloc 
> code that accounts things as small pages and you can't assume large or 
> small. If there is benefit from forcing large pages that could certainly
> be added.
> 

The vmalloc transparent is good, but not fit every user scenes, some guys like to use the deterministic function
for performance critical area.

Thanks
Ding

> Interestingly, remap_vmalloc_range in theory could map the pages as 
> large in userspace as well. That takes more work but if something
> really needs that for performance, it could be done.
> 
> Thanks,
> Nick
> .
> 

