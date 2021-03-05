Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F422832EB96
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 13:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhCEMtp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 07:49:45 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:16416 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229737AbhCEMtO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 07:49:14 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DsSGm00BQz9tyKH;
        Fri,  5 Mar 2021 13:49:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id X6AkLw5kGVzF; Fri,  5 Mar 2021 13:49:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DsSGl5zSdz9tyKG;
        Fri,  5 Mar 2021 13:49:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3D85B8B827;
        Fri,  5 Mar 2021 13:49:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FCMvPv1BqI8E; Fri,  5 Mar 2021 13:49:05 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 84AB68B826;
        Fri,  5 Mar 2021 13:49:04 +0100 (CET)
Subject: Re: [PATCH v2 1/7] cmdline: Add generic function to build command
 line.
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, danielwa@cisco.com,
        robh@kernel.org, daniel@gimpelevich.san-francisco.ca.us,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1614705851.git.christophe.leroy@csgroup.eu>
 <d8cf7979ad986de45301b39a757c268d9df19f35.1614705851.git.christophe.leroy@csgroup.eu>
 <20210303172810.GA19713@willie-the-truck>
 <a0cfef11-efba-2e5c-6f58-ed63a2c3bfa0@csgroup.eu>
 <20210303174627.GC19713@willie-the-truck>
 <dc6576ac-44ff-7db4-d718-7565b83f50b8@csgroup.eu>
 <20210303181651.GE19713@willie-the-truck> <87sg59rewl.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <11d7af27-28cb-0eed-0f33-6669cbf7f1bb@csgroup.eu>
Date:   Fri, 5 Mar 2021 13:49:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87sg59rewl.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 05/03/2021 à 12:58, Michael Ellerman a écrit :
> Will Deacon <will@kernel.org> writes:
>> On Wed, Mar 03, 2021 at 06:57:09PM +0100, Christophe Leroy wrote:
>>> Le 03/03/2021 à 18:46, Will Deacon a écrit :
>>>> On Wed, Mar 03, 2021 at 06:38:16PM +0100, Christophe Leroy wrote:
>>>>> Le 03/03/2021 à 18:28, Will Deacon a écrit :
>>>>>> On Tue, Mar 02, 2021 at 05:25:17PM +0000, Christophe Leroy wrote:
>>>>>>> This code provides architectures with a way to build command line
>>>>>>> based on what is built in the kernel and what is handed over by the
>>>>>>> bootloader, based on selected compile-time options.
>>>>>>>
>>>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>>> ---
>>>>>>>     include/linux/cmdline.h | 62 +++++++++++++++++++++++++++++++++++++++++
>>>>>>>     1 file changed, 62 insertions(+)
>>>>>>>     create mode 100644 include/linux/cmdline.h
>>>>>>>
>>>>>>> diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..ae3610bb0ee2
>>>>>>> --- /dev/null
>>>>>>> +++ b/include/linux/cmdline.h
>>>>>>> @@ -0,0 +1,62 @@
>>>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>>>> +#ifndef _LINUX_CMDLINE_H
>>>>>>> +#define _LINUX_CMDLINE_H
>>>>>>> +
>>>>>>> +static __always_inline size_t cmdline_strlen(const char *s)
>>>>>>> +{
>>>>>>> +	const char *sc;
>>>>>>> +
>>>>>>> +	for (sc = s; *sc != '\0'; ++sc)
>>>>>>> +		; /* nothing */
>>>>>>> +	return sc - s;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static __always_inline size_t cmdline_strlcat(char *dest, const char *src, size_t count)
>>>>>>> +{
>>>>>>> +	size_t dsize = cmdline_strlen(dest);
>>>>>>> +	size_t len = cmdline_strlen(src);
>>>>>>> +	size_t res = dsize + len;
>>>>>>> +
>>>>>>> +	/* This would be a bug */
>>>>>>> +	if (dsize >= count)
>>>>>>> +		return count;
>>>>>>> +
>>>>>>> +	dest += dsize;
>>>>>>> +	count -= dsize;
>>>>>>> +	if (len >= count)
>>>>>>> +		len = count - 1;
>>>>>>> +	memcpy(dest, src, len);
>>>>>>> +	dest[len] = 0;
>>>>>>> +	return res;
>>>>>>> +}
>>>>>>
>>>>>> Why are these needed instead of using strlen and strlcat directly?
>>>>>
>>>>> Because on powerpc (at least), it will be used in prom_init, it is very
>>>>> early in the boot and KASAN shadow memory is not set up yet so calling
>>>>> generic string functions would crash the board.
>>>>
>>>> Hmm. We deliberately setup a _really_ early shadow on arm64 for this, can
>>>> you not do something similar? Failing that, I think it would be better to
>>>> offer the option for an arch to implement cmdline_*, but have then point to
>>>> the normal library routines by default.
>>>
>>> I don't think it is possible to setup an earlier early shadow.
>>>
>>> At the point we are in prom_init, the code is not yet relocated at the
>>> address it was linked for, and it is running with the MMU set by the
>>> bootloader, I can't imagine being able to setup MMU entries for the early
>>> shadow KASAN yet without breaking everything.
>>
>> That's very similar to us; we're not relocated, although we are at least
>> in control of the MMU (which is using a temporary set of page-tables).
> 
> prom_init runs as an OF client, with the MMU off (except on some Apple
> machines), and we don't own the MMU. So there's really nothing we can do :)
> 
> Though now that I look at it, I don't think we should be doing this
> level of commandline handling in prom_init. It should just grab the
> value from firmware and pass it to the kernel proper, and then all the
> prepend/append/force etc. logic should happen there.

But then, how do you handle the command line parameters that are needed by prom_init ?

For instance, prom_init_mem() use 'prom_memory_limit', which comes from the "mem=" option in the 
command line.

Christophe
