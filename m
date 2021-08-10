Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D3A3E56A9
	for <lists+linux-arch@lfdr.de>; Tue, 10 Aug 2021 11:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbhHJJUX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Aug 2021 05:20:23 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3620 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbhHJJUO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Aug 2021 05:20:14 -0400
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GkS7l1GDLz6C9Kv;
        Tue, 10 Aug 2021 17:19:15 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 10 Aug 2021 11:19:47 +0200
Received: from [10.47.80.4] (10.47.80.4) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 10 Aug
 2021 10:19:47 +0100
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
 <5e8dfbd2-a6c0-6d02-53e9-1f29aebcc44e@huawei.com>
 <CAK8P3a08Zcyx0J4_LGAfU_AtUyEK+XtQJxYBQ52VXfWu8-o8_w@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <dd2d49ef-3154-3c87-67b9-c134567ba947@huawei.com>
Date:   Tue, 10 Aug 2021 10:19:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a08Zcyx0J4_LGAfU_AtUyEK+XtQJxYBQ52VXfWu8-o8_w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.4]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 04/08/2021 09:52, Arnd Bergmann wrote:
>>>> On another point, I noticed SCSI driver AHA152x depends on ISA, but is
>>>> not an isa driver - however it does use port IO. Would such dependencies
>>>> need to be changed to depend on HAS_IOPORT?
>>> I'm not sure what you mean here. As far as I can tell, AHA152x is an ISA
>>> driver in the sense that it is a driver for ISA add-on cards. However, it
>>> is not a 'struct isa_driver' in the sense that AHA1542 is, AHA152x  is even
>>> older and uses the linux-2.4 style initialization using a module_init()
>>> function that does the probing.
>> ok, fine. So I just wonder what the ISA kconfig dependency gets us for
>> aha152x. I experimented by removing the kconfig dependency and enabling
>> for the arm64 (which does not have CONFIG_ISA) std defconfig and it
>> built fine.
> The point of CONFIG_ISA is to only build drivers for ISA add-on cards
> on architectures that can have such slots. For ISA drivers in particular,
> we don't want them to be loaded on machines that don't have them
> because of the various ways this can cause trouble with hardwired
> port and irq numbers.
> 
>>>> Yeah, that sounds the same as what I was thinking. Maybe IOPORT_NATIVE
>>>> could work as a name. I would think that only x86/ia64 would define it.
>>>> A concern though is that someone could argue that is a functional
>>>> dependency, rather than just a build dependency.
>>> You can have those on a number of platforms, such as early
>>> PowerPC CHRP or pSeries systems, a number of MIPS workstations
>>> including recent Loongson machines, and many Alpha platforms.
>>>
>> hmmm... if some machines under an arch support "native" port IO and some
>> don't, then if we use a common multi-platform defconfig which defines
>> HARDCODED_IOPORT, then we still build for platforms without "native"
>> port IO, which is not ideal.
> Correct, but that's not a problem I'm trying to solve at this point. The
> machines that have those are extremely rare, so almost all configurations
> that one would encounter in practice do not suffer from it, and solving it
> reliably would be really hard.

Hi Arnd,

This seems a reasonable approach. Do you have a plan for this work? Or 
still waiting for the green light?

I have noticed the kernel test robot reporting the following to me, 
which seems to be the same issue which was addressed in this series 
originally:

config: s390-randconfig-r032-20210802 (attached as .config)
compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 
4f71f59bf3d9914188a11d0c41bedbb339d36ff5)
...
All errors (new ones prefixed by >>):

    In file included from drivers/block/null_blk/main.c:12:
    In file included from drivers/block/null_blk/null_blk.h:8:
    In file included from include/linux/blkdev.h:25:
    In file included from include/linux/scatterlist.h:9:
    In file included from arch/s390/include/asm/io.h:75:
    include/asm-generic/io.h:464:31: warning: performing pointer 
arithmetic on a null pointer has undefined behavior 
[-Wnull-pointer-arithmetic]
            val = __raw_readb(PCI_IOBASE + addr);

So I imagine lots of people are seeing these.

Thanks,
john
