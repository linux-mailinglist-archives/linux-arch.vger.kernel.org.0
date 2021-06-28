Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7E43B5CF4
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 13:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhF1LLr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 07:11:47 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5819 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbhF1LLq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jun 2021 07:11:46 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GD4VV3Ky7zXjFY;
        Mon, 28 Jun 2021 19:04:02 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 19:09:19 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 19:09:19 +0800
Subject: Re: [PATCH 7/9] s390: kprobes: Use is_kernel() helper
To:     Heiko Carstens <hca@linux.ibm.com>
CC:     Arnd Bergmann <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@de.ibm.com>,
        <linux-s390@vger.kernel.org>
References: <20210626073439.150586-1-wangkefeng.wang@huawei.com>
 <20210626073439.150586-8-wangkefeng.wang@huawei.com>
 <YNmeLhfWf3Rs6yRA@osiris>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <33b1d13e-a13c-44e0-bae6-3d8394892bbc@huawei.com>
Date:   Mon, 28 Jun 2021 19:09:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YNmeLhfWf3Rs6yRA@osiris>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 2021/6/28 18:02, Heiko Carstens wrote:
> On Sat, Jun 26, 2021 at 03:34:37PM +0800, Kefeng Wang wrote:
>> Use is_kernel() helper instead of is_kernel_addr().
>>
>> Cc: Heiko Carstens <hca@linux.ibm.com>
>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: linux-s390@vger.kernel.org
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   arch/s390/kernel/kprobes.c | 9 ++-------
>>   1 file changed, 2 insertions(+), 7 deletions(-)
> ...
>> -static inline int is_kernel_addr(void *addr)
>> -{
>> -	return addr < (void *)_end;
>> -}
>> -
>>   static int s390_get_insn_slot(struct kprobe *p)
>>   {
>>   	/*
>> @@ -105,7 +100,7 @@ static int s390_get_insn_slot(struct kprobe *p)
>>   	 * field can be patched and executed within the insn slot.
>>   	 */
>>   	p->ainsn.insn = NULL;
>> -	if (is_kernel_addr(p->addr))
>> +	if (is_kernel(p->addr))
>>   		p->ainsn.insn = get_s390_insn_slot();
>>   	else if (is_module_addr(p->addr))
>>   		p->ainsn.insn = get_insn_slot();
>> @@ -117,7 +112,7 @@ static void s390_free_insn_slot(struct kprobe *p)
>>   {
>>   	if (!p->ainsn.insn)
>>   		return;
>> -	if (is_kernel_addr(p->addr))
>> +	if (is_kernel(p->addr))
>>   		free_s390_insn_slot(p->ainsn.insn, 0);
>>   	else
>>   		free_insn_slot(p->ainsn.insn, 0);
> Given that this makes sense its own, and I can't follow the discussion
> of the patch series due to missing cc, I applied this to the s390 tree
> - and also fixed up the missing unsigned long casts.

Thanks Heiko, I got some tips(someone says, not send all patches to all 
the people who maybe not care

about the other patches), so I only send this one to you,  but the 
patches is cc to all the maillist,

and it could be check from 
https://lore.kernel.org/linux-arch/20210626073439.150586-1-wangkefeng.wang@huawei.com

>
> Thanks!
> .
>
