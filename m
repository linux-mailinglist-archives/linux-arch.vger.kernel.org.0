Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA865352C48
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 18:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbhDBPdN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 11:33:13 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:42979 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235902AbhDBPdM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Apr 2021 11:33:12 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FBkb71LDWz9v2m9;
        Fri,  2 Apr 2021 17:33:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3l8bzcUaAS9w; Fri,  2 Apr 2021 17:33:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FBkb70P7lz9v2m7;
        Fri,  2 Apr 2021 17:33:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EB14E8BB77;
        Fri,  2 Apr 2021 17:33:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9sXjhQ8q7Sww; Fri,  2 Apr 2021 17:33:08 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B4BFB8BB6F;
        Fri,  2 Apr 2021 17:33:07 +0200 (CEST)
Subject: Re: [PATCH v3 01/17] cmdline: Add generic function to build command
 line.
To:     Daniel Walker <danielwa@cisco.com>
Cc:     will@kernel.org, robh@kernel.org,
        daniel@gimpelevich.san-francisco.ca.us, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        microblaze <monstr@monstr.eu>, linux-mips@vger.kernel.org,
        nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org,
        linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <878228ad88df38f8914c7aa25dede3ed05c50f48.1616765869.git.christophe.leroy@csgroup.eu>
 <20210330172714.GR109100@zorba>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <9c74d82f-f58f-1ccb-bf22-8eb02a4cd55d@csgroup.eu>
Date:   Fri, 2 Apr 2021 17:33:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210330172714.GR109100@zorba>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 30/03/2021 à 19:27, Daniel Walker a écrit :
> On Fri, Mar 26, 2021 at 01:44:48PM +0000, Christophe Leroy wrote:
>> This code provides architectures with a way to build command line
>> based on what is built in the kernel and what is handed over by the
>> bootloader, based on selected compile-time options.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>> v3:
>> - Addressed comments from Will
>> - Added capability to have src == dst
>> ---
>>   include/linux/cmdline.h | 57 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 57 insertions(+)
>>   create mode 100644 include/linux/cmdline.h
>>
>> diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
>> new file mode 100644
>> index 000000000000..dea87edd41be
>> --- /dev/null
>> +++ b/include/linux/cmdline.h
>> @@ -0,0 +1,57 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_CMDLINE_H
>> +#define _LINUX_CMDLINE_H
>> +
>> +#include <linux/string.h>
>> +
>> +/* Allow architectures to override strlcat, powerpc can't use strings so early */
>> +#ifndef cmdline_strlcat
>> +#define cmdline_strlcat strlcat
>> +#endif
>> +
>> +/*
>> + * This function will append or prepend a builtin command line to the command
>> + * line provided by the bootloader. Kconfig options can be used to alter
>> + * the behavior of this builtin command line.
>> + * @dst: The destination of the final appended/prepended string.
>> + * @src: The starting string or NULL if there isn't one.
>> + * @len: the length of dest buffer.
>> + */
> 
> Append or prepend ? Cisco requires both at the same time. This is why my
> implementation provides both. I can't use this with both at once.
> 

I think it can be added as a second step if dimmed necessary. The feeling I have from all the 
discussion is that it's not what people from the community are looking for at the moment.

Anyway, once all architectures are moved to generic handling, I believe it is then easier to split 
CONFIG_CMDLINE in two configuration items in order to provide both appending and prepending at the 
same time.

I see some concerns about risk of double changes, but I have focussed in changing as little as 
possible the existing configuration items, in order to minimise that.
