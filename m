Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD6BF6F9B
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2019 09:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfKKIRF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Nov 2019 03:17:05 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:17460 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKIRE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Nov 2019 03:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573460218;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=I34eY/Xc9cf0a6K3KuyVWJGfAFrDKl9f+FC20iCE5jc=;
        b=exZtO/uSD8Lv5Wa3OSZfmepcTZuRHu59LuMSdOjRM6XrEnjgtixP8SjSi50EL5DsJV
        FPHdUiZz+rsf1ifyhBB/i0UsPNIPcfa6eG7NotAv+M1f6LibDSvigKpLNg/eMuhE2hfm
        7YcDD6Ofw54OfTgfqUt+jTRe7KS0LPKF0fOMjUzfoPzMLYCF/fyShxSIL6CMeh5kgZ2B
        EiglCfgxzxZ34wtw1bp3YztCYX8vhMZ78dIMQymhOYJ4yO+n0/IkisHEabsooW2eJwSE
        lUU+8cwkVW1PF6zt4H0skpStrK0F8nGff8d75e1+8Hm9bCUcjM8AkATzr5xzLsVt8G6N
        RtLg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySd+h5FvloCRpQViBsLQ=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.178.47]
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id q007c8vAB8GtS7D
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 11 Nov 2019 09:16:55 +0100 (CET)
Subject: Re: Bug 205201 - overflow of DMA mask and bus mask
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        paulus@samba.org, darren@stevens-zone.net,
        "contact@a-eon.com" <contact@a-eon.com>, rtd2@xtra.co.nz,
        mad skateman <madskateman@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20181213112511.GA4574@lst.de>
 <e109de27-f4af-147d-dc0e-067c8bafb29b@xenosoft.de>
 <ad5a5a8a-d232-d523-a6f7-e9377fc3857b@xenosoft.de>
 <e60d6ca3-860c-f01d-8860-c5e022ec7179@xenosoft.de>
 <008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de>
 <20190103073622.GA24323@lst.de>
 <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
 <1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de>
 <3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de>
 <46025f1b-db20-ac23-7dcd-10bc43bbb6ee@xenosoft.de>
 <20191105162856.GA15402@lst.de>
 <2f3c81bd-d498-066a-12c0-0a7715cda18f@xenosoft.de>
 <d2c614ec-c56e-3ec2-12d0-7561cd30c643@xenosoft.de>
 <af32bfcc-5559-578d-e1f4-75e454c965bf@xenosoft.de>
Message-ID: <0c5a8009-d28b-601f-3d1a-9de0e869911c@xenosoft.de>
Date:   Mon, 11 Nov 2019 09:16:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <af32bfcc-5559-578d-e1f4-75e454c965bf@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11 November 2019 at 09:12 am, Christian Zigotzky wrote:
> On 10 November 2019 at 08:27 am, Christian Zigotzky wrote:
>> On 07 November 2019 at 10:53 am, Christian Zigotzky wrote:
>>> On 05 November 2019 at 05:28 pm, Christoph Hellwig wrote:
>>>> On Tue, Nov 05, 2019 at 08:56:27AM +0100, Christian Zigotzky wrote:
>>>>> Hi All,
>>>>>
>>>>> We still have DMA problems with some PCI devices. Since the 
>>>>> PowerPC updates
>>>>> 4.21-1 [1] we need to decrease the RAM to 3500MB (mem=3500M) if we 
>>>>> want to
>>>>> work with our PCI devices. The FSL P5020 and P5040 have these 
>>>>> problems
>>>>> currently.
>>>>>
>>>>> Error message:
>>>>>
>>>>> [   25.654852] bttv 1000:04:05.0: overflow 0x00000000fe077000+4096 
>>>>> of DMA
>>>>> mask ffffffff bus mask df000000
>>>>>
>>>>> All 5.x Linux kernels can't initialize a SCSI PCI card anymore so 
>>>>> booting
>>>>> of a Linux userland isn't possible.
>>>>>
>>>>> PLEASE check the DMA changes in the PowerPC updates 4.21-1 [1]. 
>>>>> The kernel
>>>>> 4.20 works with all PCI devices without limitation of RAM.
>>>> Can you send me the .config and a dmesg?  And in the meantime try the
>>>> patch below?
>>>>
>>>> ---
>>>> >From 4d659b7311bd4141fdd3eeeb80fa2d7602ea01d4 Mon Sep 17 00:00:00 
>>>> 2001
>>>> From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>>> Date: Fri, 18 Oct 2019 13:00:43 +0200
>>>> Subject: dma-direct: check for overflows on 32 bit DMA addresses
>>>>
>>>> As seen on the new Raspberry Pi 4 and sta2x11's DMA implementation 
>>>> it is
>>>> possible for a device configured with 32 bit DMA addresses and a 
>>>> partial
>>>> DMA mapping located at the end of the address space to overflow. It
>>>> happens when a higher physical address, not DMAable, is translated to
>>>> it's DMA counterpart.
>>>>
>>>> For example the Raspberry Pi 4, configurable up to 4 GB of memory, has
>>>> an interconnect capable of addressing the lower 1 GB of physical 
>>>> memory
>>>> with a DMA offset of 0xc0000000. It transpires that, any attempt to
>>>> translate physical addresses higher than the first GB will result 
>>>> in an
>>>> overflow which dma_capable() can't detect as it only checks for
>>>> addresses bigger then the maximum allowed DMA address.
>>>>
>>>> Fix this by verifying in dma_capable() if the DMA address range 
>>>> provided
>>>> is at any point lower than the minimum possible DMA address on the 
>>>> bus.
>>>>
>>>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>>> ---
>>>>   include/linux/dma-direct.h | 8 ++++++++
>>>>   1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
>>>> index adf993a3bd58..6ad9e9ea7564 100644
>>>> --- a/include/linux/dma-direct.h
>>>> +++ b/include/linux/dma-direct.h
>>>> @@ -3,6 +3,7 @@
>>>>   #define _LINUX_DMA_DIRECT_H 1
>>>>     #include <linux/dma-mapping.h>
>>>> +#include <linux/memblock.h> /* for min_low_pfn */
>>>>   #include <linux/mem_encrypt.h>
>>>>     #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
>>>> @@ -27,6 +28,13 @@ static inline bool dma_capable(struct device 
>>>> *dev, dma_addr_t addr, size_t size)
>>>>       if (!dev->dma_mask)
>>>>           return false;
>>>>   +#ifndef CONFIG_ARCH_DMA_ADDR_T_64BIT
>>>> +    /* Check if DMA address overflowed */
>>>> +    if (min(addr, addr + size - 1) <
>>>> +        __phys_to_dma(dev, (phys_addr_t)(min_low_pfn << PAGE_SHIFT)))
>>>> +        return false;
>>>> +#endif
>>>> +
>>>>       return addr + size - 1 <=
>>>>           min_not_zero(*dev->dma_mask, dev->bus_dma_mask);
>>>>   }
>>> Hello Christoph,
>>>
>>> Thanks a lot for your patch! Unfortunately this patch doesn't solve 
>>> the issue.
>>>
>>> Error messages:
>>>
>>> [    6.041163] bttv: driver version 0.9.19 loaded
>>> [    6.041167] bttv: using 8 buffers with 2080k (520 pages) each for 
>>> capture
>>> [    6.041559] bttv: Bt8xx card found (0)
>>> [    6.041609] bttv: 0: Bt878 (rev 17) at 1000:04:05.0, irq: 19, 
>>> latency: 128, mmio: 0xc20001000
>>> [    6.041622] bttv: 0: using: Typhoon TView RDS + FM Stereo / KNC1 
>>> TV Station RDS [card=53,insmod option]
>>> [    6.042216] bttv: 0: tuner type=5
>>> [    6.111994] bttv: 0: audio absent, no audio device found!
>>> [    6.176425] bttv: 0: Setting PLL: 28636363 => 35468950 (needs up 
>>> to 100ms)
>>> [    6.200005] bttv: PLL set ok
>>> [    6.209351] bttv: 0: registered device video0
>>> [    6.211576] bttv: 0: registered device vbi0
>>> [    6.214897] bttv: 0: registered device radio0
>>> [  114.218806] bttv 1000:04:05.0: overflow 0x00000000ff507000+4096 
>>> of DMA mask ffffffff bus mask df000000
>>> [  114.218848] Modules linked in: rfcomm bnep tuner_simple 
>>> tuner_types tea5767 tuner tda7432 tvaudio msp3400 bttv tea575x 
>>> tveeprom videobuf_dma_sg videobuf_core rc_core videodev mc btusb 
>>> btrtl btbcm btintel bluetooth uio_pdrv_genirq uio ecdh_generic ecc
>>> [  114.219012] [c0000001ecddf720] [80000000008ff6e8] 
>>> .buffer_prepare+0x150/0x268 [bttv]
>>> [  114.219029] [c0000001ecddf860] [80000000008fff6c] 
>>> .bttv_qbuf+0x50/0x64 [bttv]
>>>
>>> -----
>>>
>>> Trace:
>>>
>>> [  462.783184] Call Trace:
>>> [  462.783187] [c0000001c6c67420] [c0000000000b3358] 
>>> .report_addr+0xb8/0xc0 (unreliable)
>>> [  462.783192] [c0000001c6c67490] [c0000000000b351c] 
>>> .dma_direct_map_page+0xf0/0x128
>>> [  462.783195] [c0000001c6c67530] [c0000000000b35b0] 
>>> .dma_direct_map_sg+0x5c/0xac
>>> [  462.783205] [c0000001c6c675e0] [8000000000862e88] 
>>> .__videobuf_iolock+0x660/0x6d8 [videobuf_dma_sg]
>>> [  462.783220] [c0000001c6c676b0] [8000000000854274] 
>>> .videobuf_iolock+0x98/0xb4 [videobuf_core]
>>> [  462.783271] [c0000001c6c67720] [80000000008686e8] 
>>> .buffer_prepare+0x150/0x268 [bttv]
>>> [  462.783276] [c0000001c6c677c0] [8000000000854afc] 
>>> .videobuf_qbuf+0x2b8/0x428 [videobuf_core]
>>> [  462.783288] [c0000001c6c67860] [8000000000868f6c] 
>>> .bttv_qbuf+0x50/0x64 [bttv]
>>> [  462.783383] [c0000001c6c678e0] [80000000007bf208] 
>>> .v4l_qbuf+0x54/0x60 [videodev]
>>> [  462.783402] [c0000001c6c67970] [80000000007c1eac] 
>>> .__video_do_ioctl+0x30c/0x3f8 [videodev]
>>> [  462.783421] [c0000001c6c67a80] [80000000007c3c08] 
>>> .video_usercopy+0x18c/0x3dc [videodev]
>>> [  462.783440] [c0000001c6c67c00] [80000000007bb14c] 
>>> .v4l2_ioctl+0x60/0x78 [videodev]
>>> [  462.783460] [c0000001c6c67c90] [80000000007d3c48] 
>>> .v4l2_compat_ioctl32+0x9b4/0x1850 [videodev]
>>> [  462.783468] [c0000001c6c67d70] [c0000000001ad9cc] 
>>> .__se_compat_sys_ioctl+0x284/0x127c
>>> [  462.783473] [c0000001c6c67e20] [c00000000000067c] 
>>> system_call+0x60/0x6c
>>> [  462.783475] Instruction dump:
>>> [  462.783477] 40fe0044 60000000 892255d0 2f890000 40fe0020 3c82ffc5 
>>> 39200001 60000000
>>> [  462.783483] 38842029 992255d0 485ad0d9 60000000 <0fe00000> 
>>> 38210070 e8010010 7c0803a6
>>> [  462.783490] ---[ end trace b677d4a00458e277 ]---
>>>
>>> -----
>>>
>>> dmesg fsl p5040: https://bugzilla.kernel.org/attachment.cgi?id=285813
>>>
>>> Kernel 5.4-rc6 config for the Cyrus+ board and for the QEMU ppce500 
>>> board (CPU: P5040 and P5020): 
>>> https://bugzilla.kernel.org/attachment.cgi?id=285815
>>>
>>> Bug report: https://bugzilla.kernel.org/show_bug.cgi?id=205201
>>>
>>> Thanks for your help,
>>>
>>> Christian
>>
>> Christoph,
>>
>> Do you have another patch for testing or shall I bisect?
>>
>> Thanks,
>> Christian
>
> Hi Christoph,
>
> I have seen that I have activated the kernel config option 
> CONFIG_ARCH_DMA_ADDR_T_64BIT. That means your code in your patch won't 
> work if this kernel option is enabled.
>
> +#ifndef CONFIG_ARCH_DMA_ADDR_T_64BIT
> +    /* Check if DMA address overflowed */
> +    if (min(addr, addr + size - 1) <
> +        __phys_to_dma(dev, (phys_addr_t)(min_low_pfn << PAGE_SHIFT)))
> +        return false;
> +#endif
>
> I will delete the lines with ifndef and endif and will try it again.
>
> Cheers,
> Christian

Christoph,

I have seen that the patch above isn't from you. It's from Nicolas Saenz 
Julienne.

Cheers,
Christian
