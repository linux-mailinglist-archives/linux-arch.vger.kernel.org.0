Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C47D3D9B8B
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jul 2021 04:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbhG2CDK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 22:03:10 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:12419 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhG2CDK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2021 22:03:10 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GZty16sw9zcjKF;
        Thu, 29 Jul 2021 09:59:37 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 10:02:56 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 10:02:56 +0800
Subject: Re: [PATCH v2 6/7] sections: Add new is_kernel() and is_kernel_text()
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <mingo@redhat.com>, <davem@davemloft.net>, <ast@kernel.org>,
        <ryabinin.a.a@gmail.com>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.org>, <paulus@samba.org>
References: <20210728081320.20394-1-wangkefeng.wang@huawei.com>
 <20210728081320.20394-7-wangkefeng.wang@huawei.com>
 <20210728113204.67fa6dfc@oasis.local.home>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <503b712c-ae62-ae05-907d-7bca67a2b00a@huawei.com>
Date:   Thu, 29 Jul 2021 10:02:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210728113204.67fa6dfc@oasis.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 2021/7/28 23:32, Steven Rostedt wrote:
> On Wed, 28 Jul 2021 16:13:19 +0800
> Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>> @@ -64,8 +64,7 @@ const struct exception_table_entry *search_exception_tables(unsigned long addr)
>>   
>>   int notrace core_kernel_text(unsigned long addr)
>>   {
>> -	if (addr >= (unsigned long)_stext &&
>> -	    addr < (unsigned long)_etext)
>> +	if (is_kernel_text(addr))
> Perhaps this was a bug, and these functions should be checking the gate
> area as well, as that is part of kernel text.
Ok, I would fix this if patch5 is reviewed well.
>
> -- Steve
>
>
>>   		return 1;
>>   
>>   	if (system_state < SYSTEM_RUNNING &&
>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
>> index 884a950c7026..88f5b0c058b7 100644
>> --- a/mm/kasan/report.c
>> +++ b/mm/kasan/report.c
>> @@ -235,7 +235,7 @@ static void describe_object(struct kmem_cache *cache, void *object,
>>   
>>   static inline bool kernel_or_module_addr(const void *addr)
>>   {
>> -	if (addr >= (void *)_stext && addr < (void *)_end)
>> +	if (is_kernel((unsigned long)addr))
>>   		return true;
>>   	if (is_module_address((unsigned long)addr))
>>   		return true;
>> -- 
> .
>
