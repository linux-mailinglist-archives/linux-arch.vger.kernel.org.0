Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B161CC280
	for <lists+linux-arch@lfdr.de>; Sat,  9 May 2020 17:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgEIPyb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 May 2020 11:54:31 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:38197 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbgEIPyb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 9 May 2020 11:54:31 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49KBb73l86z9v0Zm;
        Sat,  9 May 2020 17:54:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hhT93JtYMSPR; Sat,  9 May 2020 17:54:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49KBb72sdxz9v2CW;
        Sat,  9 May 2020 17:54:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 91C698B775;
        Sat,  9 May 2020 17:54:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QdzKxSQXGUVx; Sat,  9 May 2020 17:54:29 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6232E8B75F;
        Sat,  9 May 2020 17:54:28 +0200 (CEST)
Subject: Re: [PATCH v8 8/8] powerpc/vdso: Provide __kernel_clock_gettime64()
 on vdso32
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
References: <cover.1588079622.git.christophe.leroy@c-s.fr>
 <e78344d3fcc1d33bfb1782e430b7f0529f6c612f.1588079622.git.christophe.leroy@c-s.fr>
 <CAK8P3a2aXJRWjxWO8oMRX2AJkfeVeeoYbOPbpd9-UTgjqM4B7g@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <d3f303f1-8b2c-0c54-5380-0b9a370a4eb3@csgroup.eu>
Date:   Sat, 9 May 2020 17:54:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2aXJRWjxWO8oMRX2AJkfeVeeoYbOPbpd9-UTgjqM4B7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 28/04/2020 à 18:05, Arnd Bergmann a écrit :
> On Tue, Apr 28, 2020 at 3:16 PM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>>
>> Provides __kernel_clock_gettime64() on vdso32. This is the
>> 64 bits version of __kernel_clock_gettime() which is
>> y2038 compliant.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> Looks good to me
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> There was a bug on ARM for the corresponding function, so far it is unclear
> if this was a problem related to particular hardware, the 32-bit kernel code,
> or the common implementation of clock_gettime64 in the vdso library,
> see https://github.com/richfelker/musl-cross-make/issues/96
> 
> Just to be sure that powerpc is not affected by the same issue, can you
> confirm that repeatedly calling clock_gettime64 on powerpc32, alternating
> between vdso and syscall, results in monotically increasing times?
> 

I think that's one of the things vdsotest checks, so yes that's ok I think.

Christophe
