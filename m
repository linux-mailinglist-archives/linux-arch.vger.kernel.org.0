Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348963DFC52
	for <lists+linux-arch@lfdr.de>; Wed,  4 Aug 2021 09:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbhHDH4W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Aug 2021 03:56:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3574 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbhHDH4V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Aug 2021 03:56:21 -0400
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GfkZK1dqrz6GFWC;
        Wed,  4 Aug 2021 15:55:53 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 4 Aug 2021 09:56:07 +0200
Received: from [10.47.90.65] (10.47.90.65) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 4 Aug 2021
 08:56:06 +0100
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
 <CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com>
 <CAK8P3a1D5DzmNGsEPQomkyMCmMrtD6pQ11JRMh78vbY53edp-Q@mail.gmail.com>
 <CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com>
 <db043b76-880d-5fad-69cf-96abcd9cd34f@huawei.com>
 <CAK8P3a3HHeP+Gw_k2P7Qtig0OmErf0HN30G22+qHic_uZTh11Q@mail.gmail.com>
 <a74dfb1f-befd-92ce-4c30-233cb08e04d3@huawei.com>
 <CAK8P3a3B4FCaPPHhzBdpkv0fsjE0jREwGFCdPeHEDHxxRBEjng@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5e8dfbd2-a6c0-6d02-53e9-1f29aebcc44e@huawei.com>
Date:   Wed, 4 Aug 2021 08:55:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3B4FCaPPHhzBdpkv0fsjE0jREwGFCdPeHEDHxxRBEjng@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.90.65]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 03/08/2021 13:15, Arnd Bergmann wrote:
>> That seems reasonable. And asm-generic io.h should be ifdef'ed by
>> HAS_IOPORT. In your patch you had it under CONFIG_IOPORT - was that
>> intentional?
> No, that was a typo. Thanks for pointing this out.
> 
>> On another point, I noticed SCSI driver AHA152x depends on ISA, but is
>> not an isa driver - however it does use port IO. Would such dependencies
>> need to be changed to depend on HAS_IOPORT?
> I'm not sure what you mean here. As far as I can tell, AHA152x is an ISA
> driver in the sense that it is a driver for ISA add-on cards. However, it
> is not a 'struct isa_driver' in the sense that AHA1542 is, AHA152x  is even
> older and uses the linux-2.4 style initialization using a module_init()
> function that does the probing.

ok, fine. So I just wonder what the ISA kconfig dependency gets us for 
aha152x. I experimented by removing the kconfig dependency and enabling 
for the arm64 (which does not have CONFIG_ISA) std defconfig and it 
built fine.

> 
>> I did notice that arm32 support CONFIG_ISA - not sure why.
> This is for some of the earlier machines we support:
> mach-footbridge has some on-board ISA components, while
> SA1100, PXA25x and S3C2410 each have at least one machine
> with a PC/104 connector using ISA signaling for add-on cards.
> 
> There are also a couple of platforms with PCMCIA or CF slots
> using the same ISA style I/O signals, but those have separate
> drivers.
> 
>>> HARDCODED_IOPORT: (or another name you might think of,) Used by
>>>      drivers that unconditionally do inb()/outb() without checking the
>>>      validity of the address using firmware or other methods first.
>>>      depends on HAS_IOPORT and possibly architecture specific
>>>      settings.
>> Yeah, that sounds the same as what I was thinking. Maybe IOPORT_NATIVE
>> could work as a name. I would think that only x86/ia64 would define it.
>> A concern though is that someone could argue that is a functional
>> dependency, rather than just a build dependency.
> You can have those on a number of platforms, such as early
> PowerPC CHRP or pSeries systems, a number of MIPS workstations
> including recent Loongson machines, and many Alpha platforms.
> 

hmmm... if some machines under an arch support "native" port IO and some 
don't, then if we use a common multi-platform defconfig which defines 
HARDCODED_IOPORT, then we still build for platforms without "native" 
port IO, which is not ideal.

> Maybe the name should reflect that these all use PC-style ISA/LPC
> port numbers without the ISA connectors.

Thanks,
john

