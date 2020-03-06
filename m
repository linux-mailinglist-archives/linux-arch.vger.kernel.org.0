Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64BC717BA93
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 11:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCFKkE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 05:40:04 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2513 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726079AbgCFKkC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Mar 2020 05:40:02 -0500
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id CD22D7FCF6C196E470F8;
        Fri,  6 Mar 2020 10:40:00 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 6 Mar 2020 10:40:00 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 6 Mar 2020
 10:40:00 +0000
Subject: Re: About commit "io: change inX() to have their own IO barrier
 overrides"
To:     Arnd Bergmann <arnd@arndb.de>, Sinan Kaya <okaya@kernel.org>
CC:     "xuwei (O)" <xuwei5@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com>
 <c1489f55-369d-2cff-ff36-b10fb5d3ee79@kernel.org>
 <8207cd51-5b94-2f15-de9f-d85c9c385bca@huawei.com>
 <6115fa56-a471-1e9f-edbb-e643fa4e7e11@kernel.org>
 <7c955142-1fcb-d99e-69e4-1e0d3d9eb8c3@huawei.com>
 <CAK8P3a0f9hnKGd6GJ8qFZSu+J-n4fY23TCGxQkmgJaxbpre50Q@mail.gmail.com>
 <90af535f-00ef-c1e3-ec20-aae2bd2a0d88@kernel.org>
 <CAK8P3a2Grd0JsBNsB19oAxrAFtOdpvjrpGcfeArKe7zD_jrUZw@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ae0a1bf1-948f-7df0-9efb-cd1e94e27d2d@huawei.com>
Date:   Fri, 6 Mar 2020 10:39:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2Grd0JsBNsB19oAxrAFtOdpvjrpGcfeArKe7zD_jrUZw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 06/03/2020 07:54, Arnd Bergmann wrote:
> On Fri, Mar 6, 2020 at 4:44 AM Sinan Kaya <okaya@kernel.org> wrote:
>>
>> On 3/3/2020 11:40 AM, Arnd Bergmann wrote:
>>>> -          ret = read##bw(PCI_IOBASE + addr);
>>>> +          __io_pbr();
>>>> +          ret = __raw_read##bw(PCI_IOBASE + addr);
>>>> +          __io_pbr();
>>> __io_par();
>>>
>>
>> Why do we need to change read##bw above?
>>
>> read##bw already provides strong ordering guarantees across multiple
>> architectures.
> 
> The exact semantics of inl() and readl() are slightly different, so they
> have distinct sets of barriers in the asm-generic/io.h implementation.
> 
> For instance, the arm64 architectures defines in_par() as '__iormb(v)',
> but defines __io_ar() as a  '__rmb()'. Similarly, riscv defines them
> as "fence i,ior" and "fence i,r".
> 
> You could argue that the definitions are wrong (I have not checked the
> history of the definitions), but as long as the inb() in asm-generic/io.h
> uses those, the implementation in lib/logic_pio.c uses the same ones
> to make the two behave the same way.
> 

So the change would look like:

-- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -229,13 +229,21 @@ unsigned long 
logic_pio_trans_cpuaddr(resource_size_t addr)
  }

  #if defined(CONFIG_INDIRECT_PIO) && defined(PCI_IOBASE)
+
+#define logic_in_to_cpu_b(x) (x)
+#define logic_in_to_cpu_w(x) __le16_to_cpu(x)
+#define logic_in_to_cpu_l(x) __le32_to_cpu(x)
+
  #define BUILD_LOGIC_IO(bw, type)                                      \
  type logic_in##bw(unsigned long addr)                                 \
  {                                                                     \
         type ret = (type)~0;                                           \
                                                                        \
         if (addr < MMIO_UPPER_LIMIT) {                                 \
-               ret = read##bw(PCI_IOBASE + addr);                     \
+               void __iomem *_addr = PCI_IOBASE + addr;               \
+               __io_pbr();                                            \
+               ret = logic_in_to_cpu_##bw(__raw_read##bw(_addr));     \
+               __io_par(ret);                                         \
         } else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {\
                 struct logic_pio_hwaddr *entry = find_io_rang

We could prob combine the le_to_cpu and __raw_read into a single macro.

John
