Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEE14D62BD
	for <lists+linux-arch@lfdr.de>; Fri, 11 Mar 2022 15:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349020AbiCKOCM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Mar 2022 09:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238102AbiCKOCL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Mar 2022 09:02:11 -0500
X-Greylist: delayed 1376 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 06:01:08 PST
Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk [78.40.148.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E12B1C57D0;
        Fri, 11 Mar 2022 06:01:08 -0800 (PST)
Received: from [167.98.27.226] (helo=[172.16.103.108])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1nSfSn-0000Di-Kl; Fri, 11 Mar 2022 13:37:49 +0000
Message-ID: <509d2b62-7d52-bf5c-7a6c-213a740a5c00@codethink.co.uk>
Date:   Fri, 11 Mar 2022 13:37:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V7 13/20] riscv: compat: process: Add UXL_32 support in
 start_thread
Content-Language: en-GB
To:     Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
References: <20220227162831.674483-1-guoren@kernel.org>
 <20220227162831.674483-14-guoren@kernel.org>
 <CAJF2gTSJFMg1YJ=dbaNyemNV4sc_3P=+_PrS=RD_Y2_xz3TzPA@mail.gmail.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <CAJF2gTSJFMg1YJ=dbaNyemNV4sc_3P=+_PrS=RD_Y2_xz3TzPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/03/2022 02:38, Guo Ren wrote:
> Hi Arnd,
> 
> On Mon, Feb 28, 2022 at 12:30 AM <guoren@kernel.org> wrote:
>>
>> From: Guo Ren <guoren@linux.alibaba.com>
>>
>> If the current task is in COMPAT mode, set SR_UXL_32 in status for
>> returning userspace. We need CONFIG _COMPAT to prevent compiling
>> errors with rv32 defconfig.
>>
>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> Signed-off-by: Guo Ren <guoren@kernel.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> ---
>>   arch/riscv/kernel/process.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
>> index 03ac3aa611f5..54787ca9806a 100644
>> --- a/arch/riscv/kernel/process.c
>> +++ b/arch/riscv/kernel/process.c
>> @@ -97,6 +97,11 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
>>          }
>>          regs->epc = pc;
>>          regs->sp = sp;
>> +
> FIxup:
> 
> + #ifdef CONFIG_COMPAT
>> +       if (is_compat_task())
>> +               regs->status = (regs->status & ~SR_UXL) | SR_UXL_32;
>> +       else
>> +               regs->status = (regs->status & ~SR_UXL) | SR_UXL_64;
> + #endif
> 
> We still need "#ifdef CONFIG_COMPAT" here, because for rv32 we can't
> set SR_UXL at all. SR_UXL is BIT[32, 33].

would an if (IS_ENABLED(CONFIG_COMPAT)) { } around the lot be better
than an #ifdef here?

>>   }
>>
>>   void flush_thread(void)
>> --
>> 2.25.1
>>
> 
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
