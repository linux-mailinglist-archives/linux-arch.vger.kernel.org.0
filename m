Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F63FAE45
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2019 11:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKMKOY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Nov 2019 05:14:24 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:25731 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfKMKOY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Nov 2019 05:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573640062;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=J7/OnwrZ9IrNVa3LANzeKLBHmUi2jZG0D6gUnLn+clU=;
        b=D0WCd2/oRBXag3La3z0m7u8Y07sXsNsYBKhiwwgIqt4dQDLIJ3SS/pdRBeGixdlp6c
        7+v4NnRBmdrWeHSeOSX6jHJU5QiJHhR0Dl24q8UCRsf7u4Md7QlpkXH3rE2PQISxzwx3
        R0xmaGxFrM8rYGT8wzLqve7esV8WrrqrzXpZyILUogc9SSbWxpiHI81OGnyQyBNGrogV
        ZpNhnP76B5q0PPd/mkNvEwglYkqTUHaVJOt+IX/IWWzoAeM6SQTjHlzeJz/nl0XYI3ZF
        B4lJPuIIX4oJy8xGp6CMtbXV0WlDq72VQPjtP3SUyKoCxM1U14sn9kIfwlVselFD6qd9
        fY+g==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPgFIzdVjkULP4r2k+hZ6iFmBbj9vw=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:f53b:829e:4025:ce2b]
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id q007c8vADAEHlLm
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 13 Nov 2019 11:14:17 +0100 (CET)
Subject: Re: Bug 205201 - overflow of DMA mask and bus mask
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        paulus@samba.org, darren@stevens-zone.net,
        "contact@a-eon.com" <contact@a-eon.com>, rtd2@xtra.co.nz,
        mad skateman <madskateman@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        nsaenzjulienne@suse.de
References: <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
 <1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de>
 <3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de>
 <46025f1b-db20-ac23-7dcd-10bc43bbb6ee@xenosoft.de>
 <20191105162856.GA15402@lst.de>
 <2f3c81bd-d498-066a-12c0-0a7715cda18f@xenosoft.de>
 <d2c614ec-c56e-3ec2-12d0-7561cd30c643@xenosoft.de>
 <af32bfcc-5559-578d-e1f4-75e454c965bf@xenosoft.de>
 <0c5a8009-d28b-601f-3d1a-9de0e869911c@xenosoft.de>
 <a794864f-04ae-9b90-50e7-01b416c861fe@xenosoft.de>
 <20191112144109.GA11805@lst.de>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <9b14ca1b-2d5d-52b5-c7b4-0e637dbb1157@xenosoft.de>
Date:   Wed, 13 Nov 2019 11:14:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191112144109.GA11805@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Christoph,

I have found the issue. :-)

GFP_DMA32 was renamed to GFP_DMA in the PowerPC updates 4.21-1 in 
December last year.

Some PCI devices still use GFP_DMA32 (grep -r GFP_DMA32 *). I renamed 
GFP_DMA32 to GFP_DMA in the file 
"drivers/media/v4l2-core/videobuf-dma-sg.c". After compiling the RC7 of 
kernel 5.4 my TV card works again.

Cheers,
Christian


On 12 November 2019 at 3:41 pm, Christoph Hellwig wrote:
> On Mon, Nov 11, 2019 at 01:22:55PM +0100, Christian Zigotzky wrote:
>> Now, I can definitely say that this patch does not solve the issue.
>>
>> Do you have another patch for testing or shall I bisect?
> I'm still interested in the .config and dmesg.  Especially if the
> board is using arch/powerpc/sysdev/fsl_pci.c, which is the only
> place inside the powerpc arch code doing funny things with the
> bus_dma_mask, which Robin pointed out looks fishy.
>
>> Thanks,
>> Christian
> ---end quoted text---
>

