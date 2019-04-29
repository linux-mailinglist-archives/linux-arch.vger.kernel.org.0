Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8EEDC8F
	for <lists+linux-arch@lfdr.de>; Mon, 29 Apr 2019 09:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfD2HEF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Apr 2019 03:04:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfD2HEE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Apr 2019 03:04:04 -0400
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDDEB2147A;
        Mon, 29 Apr 2019 07:04:01 +0000 (UTC)
Subject: Re: endianness swapped
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Angelo Dureghello <angelo@sysam.it>,
        Logan Gunthorpe <logang@deltatee.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190427153222.GA9613@jerusalem>
 <20190427202150.GB9613@jerusalem>
 <CAMuHMdXNCxHP=BWPOy70LjNJoMH+zy7yYOHj29gYt79_5=4ffg@mail.gmail.com>
 <CAK8P3a2F6KW3M7ZaK=WL8429j_z=y_wXrx6rthxni8vBmsMPyg@mail.gmail.com>
 <c75092d5-0bbf-cd8e-d0a2-ff1384ac5a48@linux-m68k.org>
 <CAK8P3a16O57dvUYUPVZJpvZ7Hm6WA-jc_svQHTAEdDpbyLRv7w@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <50f49e95-95f3-4fdb-bcf6-6165382a5168@linux-m68k.org>
Date:   Mon, 29 Apr 2019 17:03:59 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a16O57dvUYUPVZJpvZ7Hm6WA-jc_svQHTAEdDpbyLRv7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On 29/4/19 4:44 am, Arnd Bergmann wrote:
> On Sun, Apr 28, 2019 at 3:59 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
>> On 28/4/19 7:21 pm, Arnd Bergmann wrote:
>>> On Sun, Apr 28, 2019 at 10:46 AM Geert Uytterhoeven
>>> <geert@linux-m68k.org> wrote:
>>>> On Sat, Apr 27, 2019 at 10:22 PM Angelo Dureghello <angelo@sysam.it> wrote:
>>>>> On Sat, Apr 27, 2019 at 05:32:22PM +0200, Angelo Dureghello wrote:
>>>
>>> Coldfire makes the behavior of readw()/readl() depend on the
>>> MMIO address, presumably since that was the easiest way to
>>> get drivers working originally, but it breaks the assumption
>>> in the asm-generic code.
>>
>> Yes, that is right.
>>
>> There is a number of common hardware modules that Freescale have
>> used in the ColdFire SoC parts and in their ARM based parts (iMX
>> families). The ARM parts are pretty much always little endian, and
>> the ColdFire is always big endian. The hardware registers in those
>> hardware blocks are always accessed in native endian of the processor.
> 
> In later Freescale/NXP ARM SoCs (i.MX and Layerscape), we
> also get a lot of devices pulled over from PowerPC, with random
> endianess. In some cases, the same device that had big-endian
> registers originally ends up in two different ARM products and one of
> them uses big-endian while the other one uses little-endian registers.
> 
>> So the address range checks are to deal with those internal
>> hardware blocks (i2c, spi, dma, etc), since we know those are
>> at fixed addresses. That leaves the usual endian swapping in place for
>> other general (ie external) devices (PCI devices, network chips, etc).
> 
> Is there a complete list of coldfire on-chip device drivers?
> 
> Looking at some of the drivers:
> 
> - drivers/i2c/busses/i2c-imx.c uses only 8-bit accesses and works either way,
>    same for drivers/tty/serial/mcf.c
> - drivers/spi/spi-coldfire-qspi.c is apparently coldfire-only and could use
>    ioread32be for a portable to do big-endian register access.
> - edma-common has a wrapper to support both big-endian and little-endian
>    configurations in the same kernel image, but the mcf interrupt handler
>    is hardcoded to the (normally) little-endian ioread32 function.
> - drivers/net/ethernet/freescale/fec_main.c is shared between coldfire
>    and i.MX (but not mpc52xx), and is hardcoded to readl/writel, and
>    would need the same trick as edma to make it portable.

That matches up with what we list out in arch/m68k/coldfire/devices.c.
I can't think of any other drivers.

There is a lot of use readl/writel and friends in the architecture
specific code too, in arch/m68k/coldfire. At first I used __raw_readl/
__raw_writel to always get native endianess. But quote a few uses of
readl/writel have crept in over the years.

Regards
Greg


