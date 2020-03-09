Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0226D17DD81
	for <lists+linux-arch@lfdr.de>; Mon,  9 Mar 2020 11:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgCIK1N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Mar 2020 06:27:13 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:42580 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725956AbgCIK1N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2020 06:27:13 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1169725|-1;CH=blue;DM=||false|;DS=CONTINUE|ham_system_inform|0.0111236-0.0031218-0.985755;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03300;MF=zhiwei_liu@c-sky.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.GyXya.O_1583749628;
Received: from 172.16.31.150(mailfrom:zhiwei_liu@c-sky.com fp:SMTPD_---.GyXya.O_1583749628)
          by smtp.aliyun-inc.com(10.147.41.143);
          Mon, 09 Mar 2020 18:27:09 +0800
Subject: Re: [RFC PATCH V3 00/11] riscv: Add vector ISA support
To:     Greentime Hu <greentime.hu@sifive.com>, guoren@kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Anup.Patel@wdc.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, arnd@arndb.de,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Dave Martin <Dave.Martin@arm.com>
References: <20200308094954.13258-1-guoren@kernel.org>
 <CAHCEeh+XYD3uVmaQRGpY=VGxpO9hzMeKasNmAojhkZe9PJ9Lug@mail.gmail.com>
From:   LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <95e3bba4-65c0-8991-9523-c16977f6350f@c-sky.com>
Date:   Mon, 9 Mar 2020 18:27:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAHCEeh+XYD3uVmaQRGpY=VGxpO9hzMeKasNmAojhkZe9PJ9Lug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2020/3/9 11:41, Greentime Hu wrote:
> On Sun, Mar 8, 2020 at 5:50 PM <guoren@kernel.org> wrote:
>> From: Guo Ren <guoren@linux.alibaba.com>
>>
>> The implementation follow the RISC-V "V" Vector Extension draft v0.8 with
>> 128bit-vlen and it's based on linux-5.6-rc3 and tested with qemu [1].
>>
>> The patch implement basic context switch, sigcontext save/restore and
>> ptrace interface with a new regset NT_RISCV_VECTOR. Only fixed 128bit-vlen
>> is implemented. We need to discuss about vlen-size for libc sigcontext and
>> ptrace (the maximum size of vlen is unlimited in spec).
>>
>> Puzzle:
>> Dave Martin has talked "Growing CPU register state without breaking ABI" [2]
>> before, and riscv also met vlen size problem. Let's discuss the common issue
>> for all architectures and we need a better solution for unlimited vlen.
>>
>> Any help are welcomed :)
>>
>>   1: https://github.com/romanheros/qemu.git branch:vector-upstream-v3
> Hi Guo,
>
> Thanks for your patch.
> It seems the qemu repo doesn't have this branch?
Hi Greentime,

It's a promise from me. Now it's ready.  You can turn on vector by 
"qemu-system-riscv64 -cpu rv64,v=true,vext_spec=v0.7.1".

Zhiwei


