Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0677A416114
	for <lists+linux-arch@lfdr.de>; Thu, 23 Sep 2021 16:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241405AbhIWOez (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Sep 2021 10:34:55 -0400
Received: from out28-50.mail.aliyun.com ([115.124.28.50]:47058 "EHLO
        out28-50.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240652AbhIWOez (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Sep 2021 10:34:55 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.109725|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0194584-0.00528737-0.975254;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=zhouyu@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.LP.lKLZ_1632407598;
Received: from 192.168.88.131(mailfrom:zhouyu@wanyeetech.com fp:SMTPD_---.LP.lKLZ_1632407598)
          by smtp.aliyun-inc.com(10.147.40.200);
          Thu, 23 Sep 2021 22:33:19 +0800
Subject: Re: [PATCH v2 0/2] MIPS: convert to generic entry
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Feiyang Chen <chris.chenfeiyang@gmail.com>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, arnd@arndb.de,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        chenhuacai@kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
References: <cover.1631583258.git.chenfeiyang@loongson.cn>
 <3907ec0f-42a0-ff4c-d4ea-63ad2a1516c2@flygoat.com>
 <CACWXhK=YW6Kn9FO1JrU1mP_xxMnEF_ajkD6hou=4rpgR2hOM5w@mail.gmail.com>
 <20210921155708.GA12237@alpha.franken.de>
From:   Zhou Yanjie <zhouyu@wanyeetech.com>
Message-ID: <ef429f0f-7cc9-2625-3700-47dc459ee681@wanyeetech.com>
Date:   Thu, 23 Sep 2021 22:33:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210921155708.GA12237@alpha.franken.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Thomas,

On 2021/9/21 下午11:57, Thomas Bogendoerfer wrote:
> On Tue, Sep 14, 2021 at 05:30:14PM +0800, Feiyang Chen wrote:
>> On Tue, 14 Sept 2021 at 16:54, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>>>
>>>
>>> 在 2021/9/14 2:50, Feiyang Chen 写道:
>>>> Convert MIPS to use the generic entry infrastructure from
>>>> kernel/entry/*.
>>>>
>>>> v2: Use regs->regs[27] to mark whether to restore all registers in
>>>> handle_sys and enable IRQ stack.
>>> Hi Feiyang,
>>>
>>> Thanks for your patch, could you please expand how could this improve
>>> the performance?
>>>
>> Hi, Jiaxun,
>>
>> We always restore all registers in handle_sys in the v1 of the
>> patchset. Since regs->regs[27] is marked where we need to restore all
>> registers, now we simply use it as the return value of do_syscall to
>> determine whether we can only restore partial registers in handle_sys.
> can people, who provided performance numbers for v1 do the same for v2 ?


Sure, I will test the v2 in the next few days.


Thanks and best regards!


>
> Thomas,
>
