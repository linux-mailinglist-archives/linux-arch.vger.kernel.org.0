Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9711776CB
	for <lists+linux-arch@lfdr.de>; Tue,  3 Mar 2020 14:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgCCNSY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Mar 2020 08:18:24 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2504 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727901AbgCCNSY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Mar 2020 08:18:24 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id A3C06456DF2344B7B802;
        Tue,  3 Mar 2020 13:18:22 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 3 Mar 2020 13:18:21 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 3 Mar 2020
 13:18:22 +0000
Subject: Re: About commit "io: change inX() to have their own IO barrier
 overrides"
To:     Sinan Kaya <okaya@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     "xuwei (O)" <xuwei5@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch <linux-arch@vger.kernel.org>
References: <2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com>
 <c1489f55-369d-2cff-ff36-b10fb5d3ee79@kernel.org>
 <8207cd51-5b94-2f15-de9f-d85c9c385bca@huawei.com>
 <6115fa56-a471-1e9f-edbb-e643fa4e7e11@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7c955142-1fcb-d99e-69e4-1e0d3d9eb8c3@huawei.com>
Date:   Tue, 3 Mar 2020 13:18:21 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <6115fa56-a471-1e9f-edbb-e643fa4e7e11@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+ linux-arch

For background, see 
https://lore.kernel.org/lkml/2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com/

>>
>> So today only ARM64 uses it for this relevant code, above. But maybe
>> others in future will want to use it - any arch without native IO port
>> access is a candidate.
> 
> I'm looking at Arnd here for help.
> 
>>
>>>
>>> As long as the expectations are set, I see no reason why it shouldn't
>>> but, I'll let Arnd comment on it too.
>>
>> ok, so it looks reasonable consider replicating your change for ***, above.

To be clear, I would make this change in lib/logic_pio.c since 
__io_pbr() can be overridden per-arch:

  #define BUILD_LOGIC_IO(bw, type)
  type logic_in##bw(unsigned long addr)
  {
       type ret = (type)~0;
       if (addr < MMIO_UPPER_LIMIT) {
-          ret = read##bw(PCI_IOBASE + addr);
+          __io_pbr();
+          ret = __raw_read##bw(PCI_IOBASE + addr);
+          __io_pbr();	
       } else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {
           struct logic_pio_hwaddr *entry = find_io_range(addr);

...

(forgetting leX_to_cpu for the moment)

> 
> Arnd is the maintainer here. We should consult first.

ok, fine.

> I believe there is also a linux-arch mailing list. Going there with this
> question makes sense IMO.

Cheers,
John

