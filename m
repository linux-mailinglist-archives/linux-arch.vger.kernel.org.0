Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128A425F387
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 09:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgIGHC7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 03:02:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37680 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbgIGHCp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 03:02:45 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200907070236euoutp0175063c44ad5a52dc99c38531d400a299~ybltW9U0l0716207162euoutp01S
        for <linux-arch@vger.kernel.org>; Mon,  7 Sep 2020 07:02:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200907070236euoutp0175063c44ad5a52dc99c38531d400a299~ybltW9U0l0716207162euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599462156;
        bh=ZxtWY66LgnHBrNYge2f9PDhTZ3Wz5P0yo+LHPKSot+Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=I+h/3I2VjIcxlVZDH/lNlOOjvMOZclTLJ/2t/GoftpsGxg9jk53gZdIy7AEvehtPh
         W8gtcUN9X/CZqLNWGwHS/yqyTr6bfdI2FE3fery7EjL+uqjNJOnrTpzDb0lu2EC3DE
         fd2OpcYiVOeJ0iCTvHb5u/KsiZBPrL0CBZMD8Avk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200907070236eucas1p29628d0052b264a54f3844c09e8df4730~ybltI412B0068800688eucas1p2Z;
        Mon,  7 Sep 2020 07:02:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9B.D3.06456.B0BD55F5; Mon,  7
        Sep 2020 08:02:35 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200907070235eucas1p22f87f67c713f5b6adcb494a54c5e75d4~yblst14op2412324123eucas1p2F;
        Mon,  7 Sep 2020 07:02:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200907070235eusmtrp1feae73e9984626b93ea2470d306c898e~yblstILju0412504125eusmtrp1u;
        Mon,  7 Sep 2020 07:02:35 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-c8-5f55db0b287d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 12.46.06017.B0BD55F5; Mon,  7
        Sep 2020 08:02:35 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200907070235eusmtip1a5111a2a4d5e325b24b610d4fe22cfd2~yblsNoKBC0360403604eusmtip1F;
        Mon,  7 Sep 2020 07:02:34 +0000 (GMT)
Subject: Re: [PATCH] dma-direct: zero out DMA_ATTR_NO_KERNEL_MAPPING buf
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Hillf Danton <hdanton@sina.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-arch@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <1eb4a2b0-2fd4-9f3c-e610-c8f856027181@samsung.com>
Date:   Mon, 7 Sep 2020 09:02:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1599321042.11726.6.camel@HansenPartnership.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7djPc7rct0PjDZ6sN7NYufook8WBn89Z
        LDb2c1ic6c616Nj1lcXi8q45bBbzlz1lt/j9Yw6bA4fH7IaLLB7TJp1i89i8Qstj85J6j903
        G9g8Jr1w9/i8SS6APYrLJiU1J7MstUjfLoErY98VzoKvEhWNsx4zNTC2iHQxcnJICJhIdM1u
        Y+ti5OIQEljBKHH8/3UmkISQwBdGiRVNghCJz4wSHxf+Ze5i5ADr+NnDDhFfzigx7+pOVgjn
        PaPEokUzWUC6hQU8JBbtWQBmiwjESVw9PxlsBbPASUaJi5v+MIMk2AQMJbredrGB2LwCdhKf
        ZrWxgtgsAioSp7tXMoLYokDNx049YoGoEZQ4OfMJmM0pYCux9e0EdhCbWUBeYvvbOcwQtrjE
        rSfzmUCWSQjsY5f4+eIpG8SjLhKX2m9B2cISr45vYYewZSROT+5hgWhoZpR4eG4tO4TTwyhx
        uWkGI0SVtcSdc7/YQAHALKApsX6XPkTYUeL+93tMkHDhk7jxVhDiCD6JSdumQ4OLV6KjTQii
        Wk1i1vF1cGsPXrjEPIFRaRaS12YheWcWkndmIexdwMiyilE8tbQ4Nz212DAvtVyvODG3uDQv
        XS85P3cTIzAtnf53/NMOxq+Xkg4xCnAwKvHwvhAPjRdiTSwrrsw9xCjBwawkwut09nScEG9K
        YmVValF+fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxSDYyMlYqff9rJd3Nu
        t0jJWzS5h8Hlg/SpkBdW9z7W/9fQX/zCTFGO60xjr3LawglmPz9paDNWXwjd/ZL9sv3M44s2
        TUucOe+MywKthxcOWCY/3uEbMm0x+/Pc2Ev/j2+15z13ojY86j33YmNunS9G5x5xHli/cSX7
        o6VdzpuDFvPzKS7/8+1vuE6vEktxRqKhFnNRcSIAF/iMU0cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xu7rct0PjDY68kLFYufook8WBn89Z
        LDb2c1ic6c616Nj1lcXi8q45bBbzlz1lt/j9Yw6bA4fH7IaLLB7TJp1i89i8Qstj85J6j903
        G9g8Jr1w9/i8SS6APUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1
        J7MstUjfLkEvY98VzoKvEhWNsx4zNTC2iHQxcnBICJhI/Oxh72Lk4hASWMooseTJdLYuRk6g
        uIzEyWkNrBC2sMSfa11sEEVvGSXezO0GKxIW8JBYtGcBC4gtIhAnceXYAyYQm1ngJKPEom1R
        EA3PGSWmLZzDDpJgEzCU6HrbBdbMK2An8WlWG9gGFgEVidPdKxlBbFGgQWd6XkDVCEqcnPkE
        bAGngK3E1rcT2CEWmEnM2/yQGcKWl9j+dg6ULS5x68l8pgmMQrOQtM9C0jILScssJC0LGFlW
        MYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbhtmM/t+xg7HoXfIhRgINRiYf3hXhovBBrYllx
        Ze4hRgkOZiURXqezp+OEeFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YIvJK4g1NDc0tLA3N
        jc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTDm2638/Zc7706cmv6d9swCgZMTTsja
        NT88E8174e73AGlns4Uyn59eebRipWfhnFtsDRNvh89Q3O1/7/uu3a/7ruiziKgYSRzKjn1y
        +7VtfvbNmm/FZ/wb8xud5nw+8saNq9HsmqqXwWSrK1tnnT5urCny/RKz700zqwuK16YGn1/S
        xsj5+qyTEktxRqKhFnNRcSIAItHzPtkCAAA=
X-CMS-MailID: 20200907070235eucas1p22f87f67c713f5b6adcb494a54c5e75d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200905155056eucas1p2d4a2249f73506a765fce2d2f7089748d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200905155056eucas1p2d4a2249f73506a765fce2d2f7089748d
References: <20200904152550.17964-1-hdanton@sina.com>
        <20200905073528.9464-1-hdanton@sina.com>
        <CGME20200905155056eucas1p2d4a2249f73506a765fce2d2f7089748d@eucas1p2.samsung.com>
        <1599321042.11726.6.camel@HansenPartnership.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi James,

On 05.09.2020 17:50, James Bottomley wrote:
> [resend with correct linux-arch address]
> On Sat, 2020-09-05 at 15:35 +0800, Hillf Danton wrote:
>> On Fri, 04 Sep 2020 08:34:39 -0700 James Bottomley wrote:
>>> On Fri, 2020-09-04 at 23:25 +0800, Hillf Danton wrote:
>>>> The DMA buffer allocated is always cleared in DMA core and this
>>>> is making DMA_ATTR_NO_KERNEL_MAPPING non-special.
>>>>
>>>> Fixes: d98849aff879 ("dma-direct: handle
>>>> DMA_ATTR_NO_KERNEL_MAPPING
>>>> in common code")
>>>> Cc: Kees Cook <keescook@chromium.org>
>>>> Cc: Matthew Wilcox <willy@infradead.org>
>>>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
>>>> Signed-off-by: Hillf Danton <hdanton@sina.com>
>>>> ---
>>>>
>>>> --- a/kernel/dma/direct.c
>>>> +++ b/kernel/dma/direct.c
>>>> @@ -178,9 +178,17 @@ void *dma_direct_alloc_pages(struct devi
>>>>   
>>>>   	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
>>>>   	    !force_dma_unencrypted(dev)) {
>>>> +		int i;
>>>> +
>>>>   		/* remove any dirty cache lines on the kernel
>>>> alias
>>>> */
>>>>   		if (!PageHighMem(page))
>>>>   			arch_dma_prep_coherent(page, size);
>>>> +
>>>> +		for (i = 0; i < size/PAGE_SIZE; i++) {
>>>> +			ret = kmap_atomic(page + i);
>>>> +			memset(ret, 0, PAGE_SIZE);
>>>> +			kunmap_atomic(ret);
>> Hi James
>>> This is massively expensive on PARISC and likely other VIPT/VIVT
>>> architectures.
>> Correct.
>>
>>> What's the reason for clearing it?  This could also be
>> 	/* we always manually zero the memory once we are done: */
>> 	gfp &= ~__GFP_ZERO;
>> 	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
>> 					   &phys_limit);
> That's not a reason ... that comment was put in for coherent mappings.
> What is the reason we should incur all this expense for clearing pages
> which aren't unmapped in the kernel, because we can update the comment?
>   The usual rationale for kernel mapped pages is security, because they
> may leak information but unmapped pages shouldn't have this problem.

Any dma_alloc_attrs() buffer might be mmaped to userspace, so the 
security reason is still valid. Possible lack if kernel mapping was only 
a hint that driver doesn't need it, so it might be skipped on some 
architectures, where creating it requires significant resources (i.e. 
vmalloc area).

>>> really inefficient even on PIPT architectures if the memory is
>>> device remote.
>>>
>>> If we really have to do this, it should likely be done in the arch
>>> or driver hooks because there are potentially more efficient ways
>>> we can do this knowing how the architecture behaves.
>> I'm open to any vintage ideas in your mind wrt clearing dma buf e.g
>> on platforms like PARISC. Or feel free to offload me the work if it
>> makes sense to you who are rich of PARISC knowledge.
> OK, I've cc'd linux-arch because this is a problem for more than just
> parisc.  However, not having to do it is the best solution ... sort of
> the doctor, doctor it hurts when I do this answer.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

