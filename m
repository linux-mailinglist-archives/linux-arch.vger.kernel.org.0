Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75BBD182757
	for <lists+linux-arch@lfdr.de>; Thu, 12 Mar 2020 04:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbgCLDPD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Mar 2020 23:15:03 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:59838 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387453AbgCLDPD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Mar 2020 23:15:03 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07444842|-1;CH=green;DM=||false|;DS=CONTINUE|ham_regular_dialog|0.00684787-0.000191967-0.99296;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03267;MF=zhiwei_liu@c-sky.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.H-3cCKL_1583982869;
Received: from 172.16.31.150(mailfrom:zhiwei_liu@c-sky.com fp:SMTPD_---.H-3cCKL_1583982869)
          by smtp.aliyun-inc.com(10.147.42.197);
          Thu, 12 Mar 2020 11:14:30 +0800
Subject: Re: [RFC PATCH V3 00/11] riscv: Add vector ISA support
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Anup.Patel@wdc.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, arnd@arndb.de,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Dave Martin <Dave.Martin@arm.com>, Alistair.Francis@wdc.com,
        wenmeng_zhang <wenmeng_zhang@c-sky.com>
References: <20200308094954.13258-1-guoren@kernel.org>
 <CAHCEeh+XYD3uVmaQRGpY=VGxpO9hzMeKasNmAojhkZe9PJ9Lug@mail.gmail.com>
 <95e3bba4-65c0-8991-9523-c16977f6350f@c-sky.com>
 <CAHCEehK0rgBpEzrWar1UTWJoOz=OQi18iw4Y+v3z5Hi=7JCEWw@mail.gmail.com>
 <CAHCEehLq5f+DGusL0T4ZUuJ2hTRhSyLSGRpKHhq5b4J3nXfBHg@mail.gmail.com>
From:   LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <1da6bf25-431b-7b69-0b09-66dae4ad18ca@c-sky.com>
Date:   Thu, 12 Mar 2020 11:14:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAHCEehLq5f+DGusL0T4ZUuJ2hTRhSyLSGRpKHhq5b4J3nXfBHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2020/3/10 17:19, Greentime Hu wrote:
> On Tue, Mar 10, 2020 at 4:54 PM Greentime Hu <greentime.hu@sifive.com> wrote:
>> On Mon, Mar 9, 2020 at 6:27 PM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>>> On 2020/3/9 11:41, Greentime Hu wrote:
>>>> On Sun, Mar 8, 2020 at 5:50 PM <guoren@kernel.org> wrote:
>>>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>>>
>>>>> The implementation follow the RISC-V "V" Vector Extension draft v0.8 with
>>>>> 128bit-vlen and it's based on linux-5.6-rc3 and tested with qemu [1].
>>>>>
>>>>> The patch implement basic context switch, sigcontext save/restore and
>>>>> ptrace interface with a new regset NT_RISCV_VECTOR. Only fixed 128bit-vlen
>>>>> is implemented. We need to discuss about vlen-size for libc sigcontext and
>>>>> ptrace (the maximum size of vlen is unlimited in spec).
>>>>>
>>>>> Puzzle:
>>>>> Dave Martin has talked "Growing CPU register state without breaking ABI" [2]
>>>>> before, and riscv also met vlen size problem. Let's discuss the common issue
>>>>> for all architectures and we need a better solution for unlimited vlen.
>>>>>
>>>>> Any help are welcomed :)
>>>>>
>>>>>    1: https://github.com/romanheros/qemu.git branch:vector-upstream-v3
>>>> Hi Guo,
>>>>
>>>> Thanks for your patch.
>>>> It seems the qemu repo doesn't have this branch?
>>> Hi Greentime,
>>>
>>> It's a promise from me. Now it's ready.  You can turn on vector by
>>> "qemu-system-riscv64 -cpu rv64,v=true,vext_spec=v0.7.1".
>>>
>>> Zhiwei
>>>
>>>
>> Hi Zhiwei,
>>
>> Thank you, I see the branch in the repo now. I will give it a try and
>> let you know if I have any problem. :)
> Hi Zhiwei & Guo,
>
> It seems current version only support v0.7.1 in qemu but this patchset
> is verified in qemu too and it is based on 0.8.
> Would you please provide the qemu with 0.8 vector spec supported?
Hi Greentime,
vector-upstream-v3 only supports v0.7.1. It  is under reviewed in QEMU 
community.
Maybe I will also support v0.8 after it is merged.

As Guo Ren said, the kernel patch set works both  for v0.7.1 and v0.8,
which only uses the common instructions and CSRs.
> or
> Did I miss something?
>
> 489             if (cpu->cfg.vext_spec) {
> 490                 if (!g_strcmp0(cpu->cfg.vext_spec, "v0.7.1")) {
> 491                     vext_version = VEXT_VERSION_0_07_1;
> 492                 } else {
> 493                     error_setg(errp,
> 494                            "Unsupported vector spec version '%s'",
> 495                            cpu->cfg.vext_spec);
> 496                     return;
> 497                 }
> 498             }
>
> By the way, can I specify vlen in Qemu?
Yes, you can specify vlen through QEMU command line like
“-cpu rv64,v=true,vext_spec=v0.7.1,vlen=256”

Currently , vlen supports up to 512 bits, with a default value 128 bits.

> Thank you. :)

