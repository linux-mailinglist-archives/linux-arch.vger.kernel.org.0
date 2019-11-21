Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA810105221
	for <lists+linux-arch@lfdr.de>; Thu, 21 Nov 2019 13:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfKUMQu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Nov 2019 07:16:50 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:19573 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfKUMQt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Nov 2019 07:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574338605;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=AxkjqpX58AUIucsroDUl2nypkVTcNCP8/zSs6m4uJM0=;
        b=GRmr62AbML4wFGL9qv2oKx+S0EC8+NamrTlPgNWLUWQmjO6fpW31dQOSwENY3dYXtR
        KpDvc7tyTZzhlnzZ7cFQr1KiiGcU9RdyWWWrX6Mtipgqcbjm2ZCEu6U6dbXxc+Mkh1+h
        dFeZh8mre5zgXBv3W9dz05+Bl1ZfR13zhw3u94C5rX481F9BiQ8pP35flOTI/HZK1+dT
        XhPmm/tBzrDMWdDT4nXe6tdM/Xeqpbv/L9AWSeCQDvI9wy8S0T70O7hgARF4fenBGZQN
        HXbIK1W6rJ7fPUVSlE3LPevBJ3Cts0CatyixZhNaAJvdHMV6cEEG9EruEf7VG+o8/k0i
        nccA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPgBcsBrTF1qGB6TwVFx4Pq4s7A="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:bd57:573a:d50f:b5]
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id q007c8vALCGdiTu
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 21 Nov 2019 13:16:39 +0100 (CET)
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI board
 installed, unless RAM size limited to 3500M
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
References: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de>
 <20191121072943.GA24024@lst.de>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de>
Date:   Thu, 21 Nov 2019 13:16:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191121072943.GA24024@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 21 November 2019 at 08:29 am, Christoph Hellwig wrote:
> On Sat, Nov 16, 2019 at 08:06:05AM +0100, Christian Zigotzky wrote:
>> /*
>>   *  DMA addressing mode.
>>   *
>>   *  0 : 32 bit addressing for all chips.
>>   *  1 : 40 bit addressing when supported by chip.
>>   *  2 : 64 bit addressing when supported by chip,
>>   *      limited to 16 segments of 4 GB -> 64 GB max.
>>   */
>> #define   SYM_CONF_DMA_ADDRESSING_MODE CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE
>>
>> Cyrus config:
>>
>> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
>>
>> I will configure “0 : 32 bit addressing for all chips” for the RC8. Maybe this is the solution.
> 0 means you are going to do bounce buffering a lot, which seems
> generally like a bad idea.
>
> But why are we talking about the sym53c8xx driver now?  The last issue
> you reported was about video4linux allocations.
>
Both drivers have the same problem. They don't work if we have more than 
3.5GB RAM. I try to find a solution until your have a good solution. I 
have already a solution for V4L but I still need one for the sym53c8xx 
driver.
