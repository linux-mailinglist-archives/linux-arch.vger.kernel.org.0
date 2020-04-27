Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7CB1BA2FF
	for <lists+linux-arch@lfdr.de>; Mon, 27 Apr 2020 13:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgD0Lyt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Apr 2020 07:54:49 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726260AbgD0Lyt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Apr 2020 07:54:49 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 7AEC82A367116205EBC7;
        Mon, 27 Apr 2020 12:54:47 +0100 (IST)
Received: from [127.0.0.1] (10.210.170.137) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 27 Apr
 2020 12:54:44 +0100
Subject: Re: [PATCH 3/4] lib: logic_pio: Introduce MMIO_LOWER_RESERVED
To:     <jiaxun.yang@flygoat.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-mips@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Kitt <steve@sk2.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Wei Xu <xuwei5@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, Rob Herring <robh@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
References: <20200426114806.1176629-1-jiaxun.yang@flygoat.com>
 <20200426114806.1176629-4-jiaxun.yang@flygoat.com>
 <e84f4146-b44f-b009-0dc4-876aa551f44f@huawei.com>
 <42432F7C-D859-48B4-9547-A61BD22EFEEF@flygoat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e6e3331f-283d-03e8-b23e-41870b547e34@huawei.com>
Date:   Mon, 27 Apr 2020 12:54:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <42432F7C-D859-48B4-9547-A61BD22EFEEF@flygoat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.170.137]
X-ClientProxiedBy: lhreml722-chm.china.huawei.com (10.201.108.73) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 27/04/2020 12:03, Jiaxun Yang wrote:
> 
> 
> 于 2020年4月27日 GMT+08:00 下午6:43:09, John Garry <john.garry@huawei.com> 写到:
>> On 26/04/2020 12:47, Jiaxun Yang wrote:
>>> That would allow platforms reserve some lower address in PIO MMIO range
>>> to deal with legacy drivers with hardcoded I/O ports that can't be
>>> managed by logic_pio.
>>
>> Hi,
>>
>> Is there some reason why the logic_pio code cannot be improved to handle
>> these devices at these "fixed" addresses? Or do you have a plan to
>> improve it? We already support fixed bus address devices in the INDIRECT
>> IO region.
> 
> Hi,
> 
> The issue about "Fixed Address" is we can't control the ioport
> That driver used to operate devices.
> So any attempt to resolve it in logic_pio seems impossible.
> 
> Currently we have i8259, i8042, piix4_smbus, mc146818 rely on this assumption.

Right, and from glancing at a couple of drivers you mentioned, if we 
were to register a logic pio region for that legacy region, there does 
not seem to be an easy place to fixup to use logic pio addresses (for 
those devices). They use hardcoded values. However if all those drivers 
were mips specific, you could fixup those drivers to use logic_pio 
addresses today through some macro. But not sure on that.

So, going back to your change, I have a dilemma wondering whether you 
should still register a logic pio region for the legacy region instead 
of the carveout reservation, but ensure it is the first region 
registered, such that logic pio address base is 0 and no translation is 
required. At least then you have a region registered and it shows in 
/proc/ioports, but then this whole thing becomes a bit fragile.

Maybe Arnd or Bjorn have an opinion on this.

Thanks,
John


> 
> My plan is after getting this part merged, I'm going to work on a ISA Host bridge driver,
> then convert device drivers into logic_pio and Devicetree based driver step by step.
> 
> Finally when we nologner have any legacy driver, we can safely remove this reserved
> range.
> 
> Thanks.
> 
> 
>>
>> Carving out a region of IO space is less than ideal.
>>
>> Thanks,
>> John
>>
>>>
>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> ---
>>>    lib/logic_pio.c | 6 +++++-
>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/lib/logic_pio.c b/lib/logic_pio.c
>>> index f511a99bb389..57fff1cb7063 100644
>>> --- a/lib/logic_pio.c
>>> +++ b/lib/logic_pio.c
>>> @@ -20,6 +20,10 @@
>>>    static LIST_HEAD(io_range_list);
>>>    static DEFINE_MUTEX(io_range_mutex);
>>>    
>>> +#ifndef MMIO_LOWER_RESERVED
>>> +#define MMIO_LOWER_RESERVED	0
>>> +#endif
>>> +
>>>    /* Consider a kernel general helper for this */
>>>    #define in_range(b, first, len)        ((b) >= (first) && (b) < (first) + (len))
>>>    
>>> @@ -36,7 +40,7 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
>>>    	struct logic_pio_hwaddr *range;
>>>    	resource_size_t start;
>>>    	resource_size_t end;
>>> -	resource_size_t mmio_end = 0;
>>> +	resource_size_t mmio_end = MMIO_LOWER_RESERVED;
>>>    	resource_size_t iio_sz = MMIO_UPPER_LIMIT;
>>>    	int ret = 0;
>>>    
>>>
>>
> 

