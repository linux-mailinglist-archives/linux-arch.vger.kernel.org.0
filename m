Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2309105327
	for <lists+linux-arch@lfdr.de>; Thu, 21 Nov 2019 14:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfKUNd5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Nov 2019 08:33:57 -0500
Received: from foss.arm.com ([217.140.110.172]:56336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfKUNd4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Nov 2019 08:33:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E35FBDA7;
        Thu, 21 Nov 2019 05:33:55 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 187683F703;
        Thu, 21 Nov 2019 05:33:53 -0800 (PST)
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI board
 installed, unless RAM size limited to 3500M
To:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org, darren@stevens-zone.net,
        mad skateman <madskateman@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        paulus@samba.org, rtd2@xtra.co.nz,
        "contact@a-eon.com" <contact@a-eon.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        nsaenzjulienne@suse.de
References: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de>
 <20191121072943.GA24024@lst.de>
 <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de>
 <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d0252d29-7a03-20e1-ccd7-e12d906e4bdf@arm.com>
Date:   Thu, 21 Nov 2019 13:33:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 21/11/2019 12:21 pm, Christian Zigotzky wrote:
> On 21 November 2019 at 01:16 pm, Christian Zigotzky wrote:
>> On 21 November 2019 at 08:29 am, Christoph Hellwig wrote:
>>> On Sat, Nov 16, 2019 at 08:06:05AM +0100, Christian Zigotzky wrote:
>>>> /*
>>>>   *  DMA addressing mode.
>>>>   *
>>>>   *  0 : 32 bit addressing for all chips.
>>>>   *  1 : 40 bit addressing when supported by chip.
>>>>   *  2 : 64 bit addressing when supported by chip,
>>>>   *      limited to 16 segments of 4 GB -> 64 GB max.
>>>>   */
>>>> #define   SYM_CONF_DMA_ADDRESSING_MODE 
>>>> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE
>>>>
>>>> Cyrus config:
>>>>
>>>> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
>>>>
>>>> I will configure “0 : 32 bit addressing for all chips” for the RC8. 
>>>> Maybe this is the solution.
>>> 0 means you are going to do bounce buffering a lot, which seems
>>> generally like a bad idea.
>>>
>>> But why are we talking about the sym53c8xx driver now?  The last issue
>>> you reported was about video4linux allocations.
>>>
>> Both drivers have the same problem. They don't work if we have more 
>> than 3.5GB RAM. I try to find a solution until you have a good 
>> solution. I have already a solution for V4L but I still need one for 
>> the sym53c8xx driver.
> OK, you mean that "0" is a bad idea but maybe it works until you have a 
> solution. ;-)

Is this on the same machine with the funny non-power-of-two bus_dma_mask 
as your other report? If so, does Nicolas' latest patch[1] help at all?

Robin.

[1] 
https://lore.kernel.org/linux-iommu/20191121092646.8449-1-nsaenzjulienne@suse.de/T/#u
