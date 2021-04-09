Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A9D359BDE
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 12:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbhDIKVP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Apr 2021 06:21:15 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:29555 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232990AbhDIKVN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Apr 2021 06:21:13 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FGvKd22R6z9vBmN;
        Fri,  9 Apr 2021 12:20:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id U6kaT8vyPDk2; Fri,  9 Apr 2021 12:20:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FGvKd0qpkz9vBmM;
        Fri,  9 Apr 2021 12:20:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 449288B7E3;
        Fri,  9 Apr 2021 12:20:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 20mYPqZcSrF8; Fri,  9 Apr 2021 12:20:54 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0866D8B7E1;
        Fri,  9 Apr 2021 12:20:52 +0200 (CEST)
Subject: Re: [PATCH v4 18/20] x86: Convert to GENERIC_CMDLINE
To:     Rob Herring <robh@kernel.org>
Cc:     will@kernel.org, danielwa@cisco.com,
        daniel@gimpelevich.san-francisco.ca.us, arnd@kernel.org,
        akpm@linux-foundation.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        microblaze <monstr@monstr.eu>, linux-mips@vger.kernel.org,
        nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org,
        linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
 <ab0fd4477964cdbf99e3dd2965a455aa3e738e4b.1617375802.git.christophe.leroy@csgroup.eu>
 <20210408194148.GB1724284@robh.at.kernel.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <834c4850-5541-b5c2-0b7b-d7d960ab2629@csgroup.eu>
Date:   Fri, 9 Apr 2021 12:20:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210408194148.GB1724284@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 08/04/2021 à 21:41, Rob Herring a écrit :
> On Fri, Apr 02, 2021 at 03:18:20PM +0000, Christophe Leroy wrote:
>> This converts the architecture to GENERIC_CMDLINE.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/x86/Kconfig        | 45 ++---------------------------------------
>>   arch/x86/kernel/setup.c | 17 ++--------------
>>   2 files changed, 4 insertions(+), 58 deletions(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index a20684d56b4b..66b384228ca3 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -104,6 +104,7 @@ config X86
>>   	select ARCH_USE_QUEUED_SPINLOCKS
>>   	select ARCH_USE_SYM_ANNOTATIONS
>>   	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>> +	select ARCH_WANT_CMDLINE_PREPEND_BY_DEFAULT
> 
> Seems to be non-existent kconfig option.

Oops. Added in v5.

>> @@ -883,18 +881,7 @@ void __init setup_arch(char **cmdline_p)
>>   	bss_resource.start = __pa_symbol(__bss_start);
>>   	bss_resource.end = __pa_symbol(__bss_stop)-1;
>>   
>> -#ifdef CONFIG_CMDLINE_BOOL
>> -#ifdef CONFIG_CMDLINE_FORCE
>> -	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
>> -#else
>> -	if (builtin_cmdline[0]) {
>> -		/* append boot loader cmdline to builtin */
>> -		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
>> -		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
>> -		strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
>> -	}
>> -#endif
>> -#endif
>> +	cmdline_build(boot_command_line, boot_command_line);
>>   
>>   	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
>>   	*cmdline_p = command_line;
> 
> Once this is all done, I wonder if we can get rid of the strlcpy and
> perhaps also cmdline_p.
> 

It seems rather complicated, in init/main.c you have heavy manipulations of command lines which 
seems to be done in setup_command_line() which seems to add stuff in front of command lines, at the 
end we end up with several command lines:

/* Untouched saved command line (eg. for /proc) */
char *saved_command_line;
/* Command line for parameter parsing */
static char *static_command_line;
/* Untouched extra command line */
static char *extra_command_line;

Some of them come from the cmdline_p which others are from boot_command_line.

I think a cleanup on all that stuff would be worth it as a further step.
