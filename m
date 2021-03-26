Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D39C34A985
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 15:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhCZOUv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 10:20:51 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:43073 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230100AbhCZOU1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Mar 2021 10:20:27 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F6PJQ0zLJz9v03Q;
        Fri, 26 Mar 2021 15:20:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id s0KOf5I51hUM; Fri, 26 Mar 2021 15:20:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F6PJP6Vfbz9v0P3;
        Fri, 26 Mar 2021 15:20:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9B5C58B8CF;
        Fri, 26 Mar 2021 15:20:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id apm4h56oZ3Cq; Fri, 26 Mar 2021 15:20:23 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 95C5C8B8C7;
        Fri, 26 Mar 2021 15:20:22 +0100 (CET)
Subject: Re: [PATCH v3 11/17] riscv: Convert to GENERIC_CMDLINE
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     will@kernel.org, danielwa@cisco.com, robh@kernel.org,
        daniel@gimpelevich.san-francisco.ca.us, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        microblaze <monstr@monstr.eu>, linux-mips@vger.kernel.org,
        nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org,
        linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <46745e07b04139a22b5bd01dc37df97e6981e643.1616765870.git.christophe.leroy@csgroup.eu>
 <87zgyqdn3d.fsf@igel.home>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <81a7e63f-57d4-5c81-acc5-35278fe5bb04@csgroup.eu>
Date:   Fri, 26 Mar 2021 15:20:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <87zgyqdn3d.fsf@igel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 26/03/2021 à 15:08, Andreas Schwab a écrit :
> On Mär 26 2021, Christophe Leroy wrote:
> 
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index f8f15332caa2..e7c91ee478d1 100644
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/swiotlb.h>
>>   #include <linux/smp.h>
>>   #include <linux/efi.h>
>> +#include <linux/cmdline.h>
>>   
>>   #include <asm/cpu_ops.h>
>>   #include <asm/early_ioremap.h>
>> @@ -228,10 +229,8 @@ static void __init parse_dtb(void)
>>   	}
>>   
>>   	pr_err("No DTB passed to the kernel\n");
>> -#ifdef CONFIG_CMDLINE_FORCE
>> -	strlcpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
>> +	cmdline_build(boot_command_line, NULL, COMMAND_LINE_SIZE);
>>   	pr_info("Forcing kernel command line to: %s\n", boot_command_line);
> 
> Shouldn't that message become conditional in some way?
> 

You are right, I did something similar on ARM but looks like I missed it on RISCV.

Christophe
