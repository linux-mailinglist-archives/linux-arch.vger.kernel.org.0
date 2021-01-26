Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE14304E08
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 01:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388909AbhAZXjW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 18:39:22 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2430 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392072AbhAZR6z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jan 2021 12:58:55 -0500
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DQDqc26slz67gXH;
        Wed, 27 Jan 2021 01:53:32 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 26 Jan 2021 18:57:55 +0100
Received: from [10.47.2.35] (10.47.2.35) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 26 Jan
 2021 17:57:53 +0000
Subject: Re: [PATCH RFC 0/4] Fix arm64 crash for accessing unmapped IO port
 regions (reboot)
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "xuwei (O)" <xuwei5@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
References: <1610729929-188490-1-git-send-email-john.garry@huawei.com>
 <CAK8P3a38HsXrebiCdJXJdxdBvS7AUjs+rVEex-0JQ+ZsytTy8A@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <fe18fbe3-e7e6-039d-aaf8-67bfb4cf2375@huawei.com>
Date:   Tue, 26 Jan 2021 17:56:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a38HsXrebiCdJXJdxdBvS7AUjs+rVEex-0JQ+ZsytTy8A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.2.35]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>>
>> For reference, here's how /proc/ioports looks on my arm64 system with
>> this change:
>>
>> root@ubuntu:/home/john# more /proc/ioports
>> 00010000-0001ffff : PCI Bus 0002:f8
>>    00010000-00010fff : PCI Bus 0002:f9
>>      00010000-00010007 : 0002:f9:00.0
>>        00010000-00010007 : serial
>>      00010008-0001000f : 0002:f9:00.1
>>        00010008-0001000f : serial
>>      00010010-00010017 : 0002:f9:00.2
>>      00010018-0001001f : 0002:f9:00.2
>> 00020000-0002ffff : PCI Bus 0004:88
>> 00030000-0003ffff : PCI Bus 0005:78
>> 00040000-0004ffff : PCI Bus 0006:c0
>> 00050000-0005ffff : PCI Bus 0007:90
>> 00060000-0006ffff : PCI Bus 000a:10
>> 00070000-0007ffff : PCI Bus 000c:20
>> 00080000-0008ffff : PCI Bus 000d:30

Hi Arnd,

> Doesn't this mean we lose the ability to access PCI devices
> with legacy ISA compatibility? Most importantly, any GPU today
> should in theory still support VGA frame buffer mode or text
> console, but both of these stop working if the low I/O ports are
> not mapped to the corresponding PCI bus.

Hmmm.. so are you saying that there is an expectation that the kernel 
PIO region assigned for these devices must start at 0x0? If so, I assume 
it's because fixed IO ports are used.

> There is of course
> already a problem if you have multiple PCI host bridges, and
> each one gets its own PIO range, which means that only one
> of them can have an ISA bridge with working PIO behind it.

The answer to my question, above, seems to be 'yes' now.

> 
> Another such case would be a BMC that has legacy ISA devices
> behind a (real or emulated) LPC bus, e.g. a 8250 UART, ps2
> keyboard, RTC, or an ATA CDROM. Not sure if any of those are
> ever used on Arm machines.
> 
> Regarding the size of the reservation, does this actually need
> to cover the 0x0fff...0xffff range or just 0x0000...0x0fff? I don't
> think there are any drivers that hardcode I/O ports beyond 0x0fff
> because those would not work on ISA buses but require PCI
> assigned BARs.

I just chose the complete legacy IO port range, that being 0x0--0xffff. 
If there would be no hardcoded ports beyond 0x0fff, then reserving 
0x0--0xfff would work.

> 
> One more thought: There are two common ways in which PCI
> host bridges map their PIO ports: either each host bridge has
> its own 0x0...0xffff BAR range but gets remapped to an
> arbitrary range of port numbers in the kernel, or each host bridge
> uses a distinct range of port numbers, and the kernel can use
> a 1:1 mapping between hardware and software port numbers,
> i.e. the number in the BAR is the same as in the kernel.
> 
> If all numbers are shifted by 0x10000, that second case no
> longer works, and there is always an offset.

Yes, this change would definitely break the second. But does - or could 
- anyone use it on arm64? I didn't think that it was possible.

Thanks,
John
