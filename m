Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC2CE1091FA
	for <lists+linux-arch@lfdr.de>; Mon, 25 Nov 2019 17:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfKYQgb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Nov 2019 11:36:31 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:12407 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbfKYQga (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Nov 2019 11:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574699788;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=7k/spbSE4Wnjsqc+UF1NKqt47ly0JC/Mr6Ef3iOR2Sc=;
        b=V+zZ2g58uFy1XfbG736YCiQ6k+2ro5Vd+0R8Gaqjq5HiWNQNq9d2aT/srkOAr3uba/
        8DQfuSmrsEAEqAVLcAt7Lu6qEb88UC/b3M37NJF5t7hAUdvLi2GuUZL4OyWnGM8iNH+/
        NBv3yFTOnzFBNe98tykKKycr3oZnhZxizzkGIAUUSPQ3vthXLdIdJFUWRyjrhYBN58G7
        9Syyyll18biZwBsoP2u+p5oXdWYWNXkJuWau9JlSiCk/f2hOKsFtpAaciEyM1E1RtuqK
        z7xtxWeQO7qpFk1nGM+RMjBmrMEC91ZjGxjrVhMxnO0Pf5+waznjcy20IBPB312Oh4ar
        bsIg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhXJixqXRlXNgnQNtnHeat+VHo="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:40cb:202:5c2:453d]
        by smtp.strato.de (RZmta 45.0.2 AUTH)
        with ESMTPSA id x0678cvAPGaH2b4
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 25 Nov 2019 17:36:17 +0100 (CET)
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI board
 installed, unless RAM size limited to 3500M
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-arch@vger.kernel.org,
        darren@stevens-zone.net, mad skateman <madskateman@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        paulus@samba.org, rtd2@xtra.co.nz,
        "contact@a-eon.com" <contact@a-eon.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        nsaenzjulienne@suse.de, Mike Rapoport <rppt@linux.ibm.com>
References: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de>
 <20191121072943.GA24024@lst.de>
 <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de>
 <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de>
 <d0252d29-7a03-20e1-ccd7-e12d906e4bdf@arm.com>
 <b3217742-2c0b-8447-c9ac-608b93265363@xenosoft.de>
 <20191121180226.GA3852@lst.de>
 <2fde79cf-875f-94e6-4a1b-f73ebb2e2c32@xenosoft.de>
 <20191125073923.GA30168@lst.de>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <96537365-8dbf-7f7e-f37f-14bf5c144b45@xenosoft.de>
Date:   Mon, 25 Nov 2019 17:36:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191125073923.GA30168@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 25 November 2019 at 08:39 am, Christoph Hellwig wrote:
> On Sat, Nov 23, 2019 at 12:42:27PM +0100, Christian Zigotzky wrote:
>> Hello Christoph,
>>
>> Please find attached the dmesg of your Git kernel.
> Thanks.  It looks like on your platform the swiotlb buffer isn't
> actually addressable based on the bus dma mask limit, which is rather
> interesting.  swiotlb_init uses memblock_alloc_low to allocate the
> buffer, and I'll need some help from Mike and the powerpc maintainers
> to figure out how that select where to allocate the buffer from, and
> how we can move it to a lower address.  My gut feeling would be to try
> to do what arm64 does and define a new ARCH_LOW_ADDRESS_LIMIT, preferably
> without needing too much arch specific magic.
>
> As a quick hack can you try this patch on top of the tree from Friday?
>
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index f491690d54c6..e3f95c362922 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -344,7 +344,7 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
>   #define MEMBLOCK_LOW_LIMIT 0
>   
>   #ifndef ARCH_LOW_ADDRESS_LIMIT
> -#define ARCH_LOW_ADDRESS_LIMIT  0xffffffffUL
> +#define ARCH_LOW_ADDRESS_LIMIT  0x0fffffffUL
>   #endif
>   
>   phys_addr_t memblock_phys_alloc_range(phys_addr_t size, phys_addr_t align,
>
Hello Christoph,

Thanks a lot for your help! I will test your patch tomorrow.

Cheers,
Christian
