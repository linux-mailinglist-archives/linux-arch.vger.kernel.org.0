Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF482F9D1E
	for <lists+linux-arch@lfdr.de>; Mon, 18 Jan 2021 11:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389046AbhARKrl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Jan 2021 05:47:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2361 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389136AbhARJoV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Jan 2021 04:44:21 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DK6Cq72DRz67dBV;
        Mon, 18 Jan 2021 17:38:15 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 18 Jan 2021 10:43:39 +0100
Received: from [10.47.11.164] (10.47.11.164) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 18 Jan
 2021 09:43:37 +0000
Subject: Re: [PATCH RFC 0/4] Fix arm64 crash for accessing unmapped IO port
 regions (reboot)
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <arnd@arndb.de>, <akpm@linux-foundation.org>,
        <xuwei5@hisilicon.com>, <lorenzo.pieralisi@arm.com>,
        <helgaas@kernel.org>, <song.bao.hua@hisilicon.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
References: <1610729929-188490-1-git-send-email-john.garry@huawei.com>
 <982ed6eb-6975-aea8-1555-a557633966f5@flygoat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6c0a2484-2cd6-ea1f-1094-21a7e86d71a2@huawei.com>
Date:   Mon, 18 Jan 2021 09:42:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <982ed6eb-6975-aea8-1555-a557633966f5@flygoat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.11.164]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 18/01/2021 01:59, Jiaxun Yang wrote:
> 在 2021/1/16 上午12:58, John Garry 写道:
>> This is a reboot of my original series to address the problem of drivers
>> for legacy ISA devices accessing unmapped IO port regions on arm64 
>> systems
>> and causing the system to crash.
>>
>> There was another recent report of such an issue [0], and some old ones
>> [1] and [2] for reference.
>>
>> The background is that many systems do not include PCI host controllers,
>> or they do and controller probe may have failed. For these cases, no IO
>> ports are mapped. However, loading drivers for legacy ISA devices can
>> crash the system as there is nothing to stop them accessing those IO
>> ports (which have not been io remap'ed).
>>
>> My original solution tried to keep the kernel alive in these 
>> situations by
>> rejecting logical PIO access to PCI IO regions until PCI IO port regions
>> have been mapped.
>>
>> This series goes one step further, by just reserving the complete legacy
>> IO port range in 0x0--0xffff for arm64. The motivation for doing this is
>> to make the request_region() calls for those drivers fail, like this:
>>
>> root@ubuntu:/home/john# insmod mk712.ko
>>   [ 3415.575800] mk712: unable to get IO region
>> insmod: ERROR: could not insert module mk712.ko: No such device
>>
>> Otherwise, in theory, those drivers could initiate rogue accesses to
>> mapped IO port regions for other devices and cause corruptions or
>> side-effects. Indeed, those drivers should not be allowed to access
>> IO ports at all in such a system.
>>
>> As a secondary defence, for broken drivers who do not call
>> request_region(), IO port accesses in range 0--0xffff will be ignored,
>> again preserving the system.
>>
>> I am sending as an RFC as I am not sure of any problem with reserving
>> first 0x10000 of IO space like this. There is reserve= commandline
>> argument, which does allow this already.
> 

Hi Jiaxun,

> 
> Is it ok with ACPI? I'm not really familiar with ACPI on arm64 but my 
> impression
> is ACPI would use legacy I/O ports to communicate with kbd controller, 
> EC and
> power management facilities.

I tested for ACPI. As far as I'm concerned, fixed IO ports should not be 
used on arm64 systems.

Indeed, ACPI spec says IO port addresses should be CPU addressable, and 
it is the job of the kernel to io remap those correctly for systems 
which do not support IO ports natively, i.e. those that define PCI_IOBASE.

> 
> We'd better have a method to detect if ISA bus is not present on the system
> instead of reserve them unconditionally.
> 

For ISA bus or any IO ports region, they would/should be behind PCI host 
bridge or modeled as INDIRECT IO host and we should allocate logic PIO 
region for them, and there should be no assumption on the IO port 
address in drivers, i.e. not fixed.

Thanks,
John

> 
>>
>> For reference, here's how /proc/ioports looks on my arm64 system with
>> this change:
>>
>> root@ubuntu:/home/john# more /proc/ioports
>> 00010000-0001ffff : PCI Bus 0002:f8
>>    00010000-00010fff : PCI Bus 0002:f9
>>      00010000-00010007 : 0002:f9:00.0
>>        00010000-00010007 : serial
>>      00010008-0001000f : 0002:f9:00.1
>>        00010008-0001000f : serial
>>      00010010-00010017 : 0002:f9:00.2
>>      00010018-0001001f : 0002:f9:00.2
>> 00020000-0002ffff : PCI Bus 0004:88
>> 00030000-0003ffff : PCI Bus 0005:78
>> 00040000-0004ffff : PCI Bus 0006:c0
>> 00050000-0005ffff : PCI Bus 0007:90
>> 00060000-0006ffff : PCI Bus 000a:10
>> 00070000-0007ffff : PCI Bus 000c:20
>> 00080000-0008ffff : PCI Bus 000d:30
>>
>> [0] 
>> https://lore.kernel.org/linux-input/20210112055129.7840-1-song.bao.hua@hisilicon.com/T/#mf86445470160c44ac110e9d200b09245169dc5b6 
>>
>> [1] https://lore.kernel.org/linux-pci/56F209A9.4040304@huawei.com
>> [2] 
>> https://lore.kernel.org/linux-arm-kernel/e6995b4a-184a-d8d4-f4d4-9ce75d8f47c0@huawei.com/ 
>>
>>
>> Difference since v4:
>> https://lore.kernel.org/linux-pci/1560262374-67875-1-git-send-email-john.garry@huawei.com/ 
>>
>> - Reserve legacy ISA region
>>
>> John Garry (4):
>>    arm64: io: Introduce IO_SPACE_BASE
>>    asm-generic/io.h: Add IO_SPACE_BASE
>>    kernel/resource: Make ioport_resource.start configurable
>>    logic_pio: Warn on and discard accesses to addresses below
>>      IO_SPACE_BASE
>>
>>   arch/arm64/include/asm/io.h |  1 +
>>   include/asm-generic/io.h    |  4 ++++
>>   include/linux/logic_pio.h   |  5 +++++
>>   kernel/resource.c           |  2 +-
>>   lib/logic_pio.c             | 20 ++++++++++++++------
>>   5 files changed, 25 insertions(+), 7 deletions(-)
>>
> 
> .

