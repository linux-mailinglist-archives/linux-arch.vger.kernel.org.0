Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B94DF177D32
	for <lists+linux-arch@lfdr.de>; Tue,  3 Mar 2020 18:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgCCRQW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Mar 2020 12:16:22 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2506 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729100AbgCCRQW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Mar 2020 12:16:22 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 20BACB3F076F71A9F686;
        Tue,  3 Mar 2020 17:16:20 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 3 Mar 2020 17:16:19 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 3 Mar 2020
 17:16:19 +0000
Subject: Re: About commit "io: change inX() to have their own IO barrier
 overrides"
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Sinan Kaya <okaya@kernel.org>, "xuwei (O)" <xuwei5@hisilicon.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com>
 <c1489f55-369d-2cff-ff36-b10fb5d3ee79@kernel.org>
 <8207cd51-5b94-2f15-de9f-d85c9c385bca@huawei.com>
 <6115fa56-a471-1e9f-edbb-e643fa4e7e11@kernel.org>
 <7c955142-1fcb-d99e-69e4-1e0d3d9eb8c3@huawei.com>
 <CAK8P3a0f9hnKGd6GJ8qFZSu+J-n4fY23TCGxQkmgJaxbpre50Q@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <773c5d63-5626-ca3d-634b-73d3a7776ddb@huawei.com>
Date:   Tue, 3 Mar 2020 17:16:18 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0f9hnKGd6GJ8qFZSu+J-n4fY23TCGxQkmgJaxbpre50Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 03/03/2020 16:40, Arnd Bergmann wrote:
> On Tue, Mar 3, 2020 at 2:18 PM John Garry <john.garry@huawei.com> wrote:
>>
>> + linux-arch
>>
>> For background, see
>> https://lore.kernel.org/lkml/2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com/
>>
>>>>
>>>> So today only ARM64 uses it for this relevant code, above. But maybe
>>>> others in future will want to use it - any arch without native IO port
>>>> access is a candidate.
>>>
>>> I'm looking at Arnd here for help.
>>>
>>>>
>>>>>
>>>>> As long as the expectations are set, I see no reason why it shouldn't
>>>>> but, I'll let Arnd comment on it too.
>>>>
>>>> ok, so it looks reasonable consider replicating your change for ***, above.
>>
>> To be clear, I would make this change in lib/logic_pio.c since
>> __io_pbr() can be overridden per-arch:
>>
>>    #define BUILD_LOGIC_IO(bw, type)
>>    type logic_in##bw(unsigned long addr)
>>    {
>>         type ret = (type)~0;
>>         if (addr < MMIO_UPPER_LIMIT) {
>> -          ret = read##bw(PCI_IOBASE + addr);
>> +          __io_pbr();
>> +          ret = __raw_read##bw(PCI_IOBASE + addr);
>> +          __io_pbr();
> 
> __io_par();
> 
>>         } else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {
>>             struct logic_pio_hwaddr *entry = find_io_range(addr);
>>
>> ...
>>
>> (forgetting leX_to_cpu for the moment)
> 
> Yes, I suppose this is required to get consistent behavior on arm64,
> which overrides __io_par() but not __io_ar(), with the current code
> the barrier after read is weaker when LOGIC_PIO is enabled than it
> is otherwise.

Ok.

Apart from that, this code is somewhat hidden. I mean, most people would 
consider generic IO port accessors come from asm-generic/io.h only, 
which is not the case here. Maybe this can be better integrated into 
asm-generic/io.h, the only hint today being the logic_pio.h include half 
way through the file.

> 
> For other architectures, I suppose we would need another indirection
> level, as those can also override the default inb() itself to do something
> other than readb(PCI_IOBASE + addr), and that is not handled
> here either. We can do that if we need LOGIC_PIO on a second
> architecture.

Jiaxun Yang did mention that MIPS may want to move away from its own IO 
space management.

Thanks,
John
