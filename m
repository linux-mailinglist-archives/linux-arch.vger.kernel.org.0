Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029D332C86C
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 02:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240250AbhCDAtV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 19:49:21 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:61453 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234278AbhCCSVZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Mar 2021 13:21:25 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DrLpz2xdqz9tylR;
        Wed,  3 Mar 2021 18:39:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id YBZwzXhxA9In; Wed,  3 Mar 2021 18:39:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DrLpz09Xkz9tylQ;
        Wed,  3 Mar 2021 18:39:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 264978B7E8;
        Wed,  3 Mar 2021 18:39:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id oNwRvWSyIn_a; Wed,  3 Mar 2021 18:39:39 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 609DB8B7E6;
        Wed,  3 Mar 2021 18:39:38 +0100 (CET)
Subject: Re: [PATCH v2 1/7] cmdline: Add generic function to build command
 line.
To:     Will Deacon <will@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com,
        robh@kernel.org, daniel@gimpelevich.san-francisco.ca.us,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1614705851.git.christophe.leroy@csgroup.eu>
 <d8cf7979ad986de45301b39a757c268d9df19f35.1614705851.git.christophe.leroy@csgroup.eu>
 <20210303172810.GA19713@willie-the-truck>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <a0cfef11-efba-2e5c-6f58-ed63a2c3bfa0@csgroup.eu>
Date:   Wed, 3 Mar 2021 18:38:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210303172810.GA19713@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 03/03/2021 à 18:28, Will Deacon a écrit :
> On Tue, Mar 02, 2021 at 05:25:17PM +0000, Christophe Leroy wrote:
>> This code provides architectures with a way to build command line
>> based on what is built in the kernel and what is handed over by the
>> bootloader, based on selected compile-time options.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   include/linux/cmdline.h | 62 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 62 insertions(+)
>>   create mode 100644 include/linux/cmdline.h
>>
>> diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
>> new file mode 100644
>> index 000000000000..ae3610bb0ee2
>> --- /dev/null
>> +++ b/include/linux/cmdline.h
>> @@ -0,0 +1,62 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_CMDLINE_H
>> +#define _LINUX_CMDLINE_H
>> +
>> +static __always_inline size_t cmdline_strlen(const char *s)
>> +{
>> +	const char *sc;
>> +
>> +	for (sc = s; *sc != '\0'; ++sc)
>> +		; /* nothing */
>> +	return sc - s;
>> +}
>> +
>> +static __always_inline size_t cmdline_strlcat(char *dest, const char *src, size_t count)
>> +{
>> +	size_t dsize = cmdline_strlen(dest);
>> +	size_t len = cmdline_strlen(src);
>> +	size_t res = dsize + len;
>> +
>> +	/* This would be a bug */
>> +	if (dsize >= count)
>> +		return count;
>> +
>> +	dest += dsize;
>> +	count -= dsize;
>> +	if (len >= count)
>> +		len = count - 1;
>> +	memcpy(dest, src, len);
>> +	dest[len] = 0;
>> +	return res;
>> +}
> 
> Why are these needed instead of using strlen and strlcat directly?

Because on powerpc (at least), it will be used in prom_init, it is very early in the boot and KASAN 
shadow memory is not set up yet so calling generic string functions would crash the board.

> 
>> +/*
>> + * This function will append a builtin command line to the command
>> + * line provided by the bootloader. Kconfig options can be used to alter
>> + * the behavior of this builtin command line.
>> + * @dest: The destination of the final appended/prepended string.
>> + * @src: The starting string or NULL if there isn't one. Must not equal dest.
>> + * @length: the length of dest buffer.
>> + */
>> +static __always_inline void cmdline_build(char *dest, const char *src, size_t length)
>> +{
>> +	if (length <= 0)
>> +		return;
>> +
>> +	dest[0] = 0;
>> +
>> +#ifdef CONFIG_CMDLINE
>> +	if (IS_ENABLED(CONFIG_CMDLINE_FORCE) || !src || !src[0]) {
>> +		cmdline_strlcat(dest, CONFIG_CMDLINE, length);
>> +		return;
>> +	}
>> +#endif
> 
> CONFIG_CMDLINE_FORCE implies CONFIG_CMDLINE, and even if it didn't,
> CONFIG_CMDLINE is at worst an empty string. Can you drop the #ifdef?

Ah yes, since cbe46bd4f510 ("powerpc: remove CONFIG_CMDLINE #ifdef mess") it is feasible. I can 
change that now.

> 
>> +	if (dest != src)
>> +		cmdline_strlcat(dest, src, length);
>> +#ifdef CONFIG_CMDLINE
>> +	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) && sizeof(CONFIG_CMDLINE) > 1)
>> +		cmdline_strlcat(dest, " " CONFIG_CMDLINE, length);
>> +#endif
> 
> Likewise, but also I'm not sure why the sizeof() is required.

It is to avoid adding a white space at the end of the command line when CONFIG_CMDLINE is empty. But 
maybe it doesn't matter ?

Christophe
