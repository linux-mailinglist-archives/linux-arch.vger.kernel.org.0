Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939E03A77F8
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 09:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhFOHbD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 03:31:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11663 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229908AbhFOHbC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Jun 2021 03:31:02 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G40LK5WyBzBBQy;
        Tue, 15 Jun 2021 09:28:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id utAMxQNL3e0X; Tue, 15 Jun 2021 09:28:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G40LK2Q82zBBDH;
        Tue, 15 Jun 2021 09:28:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 364218B7A3;
        Tue, 15 Jun 2021 09:28:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id HMyoXwMPJYV4; Tue, 15 Jun 2021 09:28:57 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BFA318B7A2;
        Tue, 15 Jun 2021 09:28:56 +0200 (CEST)
Subject: Re: [PATCH 5/7] signal: Add unsafe_copy_siginfo_to_user()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <b813c1f4d3dab2f51300eac44d99029aa8e57830.1623739212.git.christophe.leroy@csgroup.eu>
 <684939dcfef612fac573d1b983a977215b71f64d.1623739212.git.christophe.leroy@csgroup.eu>
 <YMhOMoKKvew0YYCt@infradead.org>
 <7061fbee-cc82-2699-cf12-e5a4ae46940f@csgroup.eu>
 <YMhU3Df7foVo9BaM@infradead.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <ce8f56c6-3312-8fb6-7389-1498d6bb9cb7@csgroup.eu>
Date:   Tue, 15 Jun 2021 09:28:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMhU3Df7foVo9BaM@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 15/06/2021 à 09:21, Christoph Hellwig a écrit :
> On Tue, Jun 15, 2021 at 09:03:42AM +0200, Christophe Leroy wrote:
>>
>>
>> Le 15/06/2021 ?? 08:52, Christoph Hellwig a ??crit??:
>>> On Tue, Jun 15, 2021 at 06:41:01AM +0000, Christophe Leroy wrote:
>>>> +	unsafe_copy_to_user(__ucs_to, __ucs_from,			\
>>>> +			    sizeof(struct kernel_siginfo), label);	\
>>>> +	unsafe_clear_user(__ucs_expansion, SI_EXPANSION_SIZE, label);	\
>>>> +} while (0)
>>>
>>> unsafe_clear_user does not exist at this point, and even your later
>>> patch only adds it for powerpc.
>>>
>>
>> You missed below chunck I guess:
>>
>>> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
>>> index c05e903cef02..37073caac474 100644
>>> --- a/include/linux/uaccess.h
>>> +++ b/include/linux/uaccess.h
>>> @@ -398,6 +398,7 @@ long strnlen_user_nofault(const void __user *unsafe_addr, long count);
>>>    #define unsafe_put_user(x,p,e) unsafe_op_wrap(__put_user(x,p),e)
>>>    #define unsafe_copy_to_user(d,s,l,e) unsafe_op_wrap(__copy_to_user(d,s,l),e)
>>>    #define unsafe_copy_from_user(d,s,l,e) unsafe_op_wrap(__copy_from_user(d,s,l),e)
>>> +#define unsafe_clear_user(d, l, e) unsafe_op_wrap(__clear_user(d, l), e)
> 
> That doesn't help with architectures that define user_access_begin but
> do not define unsafe_clear_user. (i.e. x86).
> 

Yes, the day they want to use unsafe_copy_siginfo_to_user() they'll have to implement 
unsafe_clear_user().

Until that day, they don't need unsafe_clear_user() and I'm sure the result would be disastrous if a 
poor powerpc guy like me was trying to implement some low level x86 code.

Similar to unsafe_get_compat_sigset(), an arch wanting to use it has to implement 
unsafe_copy_from_user().
