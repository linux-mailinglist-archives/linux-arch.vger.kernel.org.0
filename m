Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177E334AC11
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 16:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhCZPzy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 11:55:54 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:24186 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230372AbhCZPzf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Mar 2021 11:55:35 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F6RQB6DtPz9v0Mx;
        Fri, 26 Mar 2021 16:55:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id fRfLPhr5ARx4; Fri, 26 Mar 2021 16:55:30 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F6RQB5JGZz9v0Mw;
        Fri, 26 Mar 2021 16:55:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 354458B8CF;
        Fri, 26 Mar 2021 16:55:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id o-ftwDSIO1we; Fri, 26 Mar 2021 16:55:32 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 249F98B8C7;
        Fri, 26 Mar 2021 16:55:31 +0100 (CET)
Subject: Re: [PATCH v3 01/17] cmdline: Add generic function to build command
 line.
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Daniel Walker <danielwa@cisco.com>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>, devicetree@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        microblaze <monstr@monstr.eu>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        nios2 <ley.foon.tan@intel.com>,
        Openrisc <openrisc@lists.librecores.org>,
        linux-hexagon@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org,
        SH-Linux <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <878228ad88df38f8914c7aa25dede3ed05c50f48.1616765869.git.christophe.leroy@csgroup.eu>
 <CAL_JsqKr3xekKSo3DtQvOOw_VoGC=FUTagZGY5g=CGGGdUZSMQ@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <58834b01-aad5-fa1e-554e-6417b2357202@csgroup.eu>
Date:   Fri, 26 Mar 2021 16:55:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKr3xekKSo3DtQvOOw_VoGC=FUTagZGY5g=CGGGdUZSMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 26/03/2021 à 16:42, Rob Herring a écrit :
> On Fri, Mar 26, 2021 at 7:44 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>>
>> This code provides architectures with a way to build command line
>> based on what is built in the kernel and what is handed over by the
>> bootloader, based on selected compile-time options.
> 
> Note that I have this patch pending:
> 
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210316193820.3137-1-alex@ghiti.fr/
> 
> It's going to need to be adapted for this. I've held off applying to
> see if this gets settled.

good point.

Hope we can't have things like

	option="beautiful weather"

> 
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
>> +static __always_inline void __cmdline_build(char *dst, const char *src, size_t len)
>> +{
>> +       if (!len || src == dst)
>> +               return;
>> +
>> +       if (IS_ENABLED(CONFIG_CMDLINE_FORCE) || !src) {
>> +               dst[0] = 0;
>> +               cmdline_strlcat(dst, CONFIG_CMDLINE, len);
>> +               return;
>> +       }
>> +
>> +       if (dst != src)
>> +               dst[0] = 0;
>> +
>> +       if (IS_ENABLED(CONFIG_CMDLINE_PREPEND))
>> +               cmdline_strlcat(dst, CONFIG_CMDLINE " ", len);
>> +
>> +       cmdline_strlcat(dst, src, len);
>> +
>> +       if (IS_ENABLED(CONFIG_CMDLINE_EXTEND))
> 
> Should be APPEND.

Not yet. For the time being all architectures use EXTEND only.

In patch 3 it is changed to:

-	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND))
+	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) || IS_ENABLED(CONFIG_CMDLINE_APPEND))

Then in last patch, I forgot but I should have done:

-	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) || IS_ENABLED(CONFIG_CMDLINE_APPEND))
+	if (IS_ENABLED(CONFIG_CMDLINE_APPEND))


> 
>> +               cmdline_strlcat(dst, " " CONFIG_CMDLINE, len);
>> +}
>> +
>> +#define cmdline_build(dst, src, len) do {                              \
> 
> Perhaps a comment why we need this to be a define.

Probably we don't need anymore as I finally decided to use COMMAND_LINE_SIZE instead of 'len' as the 
size of the temporary buffer.

> 
>> +       char *__c_dst = (dst);                                          \
>> +       const char *__c_src = (src);                                    \
>> +                                                                       \
>> +       if (__c_src == __c_dst) {                                       \
>> +               static char __c_tmp[COMMAND_LINE_SIZE] __initdata = ""; \
>> +                                                                       \
>> +               cmdline_strlcat(__c_tmp, __c_src, COMMAND_LINE_SIZE);   \
>> +               __cmdline_build(__c_dst, __c_tmp, (len));               \
>> +       } else {                                                        \
>> +               __cmdline_build(__c_dst, __c_src, (len));               \
>> +       }                                                               \
>> +} while (0)
>> +
>> +#endif /* _LINUX_CMDLINE_H */
>> --
>> 2.25.0
>>

Christophe
