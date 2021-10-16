Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAFD430097
	for <lists+linux-arch@lfdr.de>; Sat, 16 Oct 2021 08:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhJPGnQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 16 Oct 2021 02:43:16 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:52041 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233802AbhJPGnN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 16 Oct 2021 02:43:13 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HWYSJ4Z1gz9sSL;
        Sat, 16 Oct 2021 08:41:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DgjsS_Egr1BK; Sat, 16 Oct 2021 08:41:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HWYSJ3TH7z9sSH;
        Sat, 16 Oct 2021 08:41:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5EEA88B765;
        Sat, 16 Oct 2021 08:41:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id asovUeRSJBBo; Sat, 16 Oct 2021 08:41:04 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.36])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 388CC8B763;
        Sat, 16 Oct 2021 08:41:03 +0200 (CEST)
Subject: Re: [PATCH v2 11/13] lkdtm: Fix lkdtm_EXEC_RODATA()
To:     Kees Cook <keescook@chromium.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <cover.1634190022.git.christophe.leroy@csgroup.eu>
 <44946ed0340013a52f8acdee7d6d0781f145cd6b.1634190022.git.christophe.leroy@csgroup.eu>
 <202110151432.D8203C19@keescook>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <61a3d2c4-4997-c221-3eef-d74aef5ba584@csgroup.eu>
Date:   Sat, 16 Oct 2021 08:41:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202110151432.D8203C19@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 15/10/2021 à 23:32, Kees Cook a écrit :
> On Thu, Oct 14, 2021 at 07:50:00AM +0200, Christophe Leroy wrote:
>> Behind its location, lkdtm_EXEC_RODATA() executes
>> lkdtm_rodata_do_nothing() which is a real function,
>> not a copy of do_nothing().
>>
>> So executes it directly instead of using execute_location().
>>
>> This is necessary because following patch will fix execute_location()
>> to use a copy of the function descriptor of do_nothing() and
>> function descriptor of lkdtm_rodata_do_nothing() might be different.
>>
>> And fix displayed addresses by dereferencing the function descriptors.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> I still don't understand this -- it doesn't look needed at all given the
> changes in patch 12. (i.e. everything is using
> dereference_function_descriptor() now)

dereference_function_descriptor() only deals with the function address, 
not the function TOC.

do_nothing() is a function. It has a function descriptor with a given 
address (address of .do_nothing) and a given TOC, say TOC1.

lkdtm_rodata_do_nothing() is another function. It has its own function 
descriptor with a given address (address of .lkdtm_rodata_do_nothing) 
and a given TOC, say TOC2.

If we use execute_location(), it will copy do_nothing() function 
descriptor and change the function address to the address of 
lkdtm_rodata_do_nothing(). So it will call lkdtm_rodata_do_nothing() 
with TOC1 instead of calling it with TOC2.

> 
> Can't this patch be dropped?

It is likely that the TOC will be the same for both functions, and 
anyway those functions are so simple that they don't use the TOC at all, 
so yes it would likely work without this patch but from my point of view 
it is incorrect to call one function with the TOC from the descriptor of 
another function.

If you thing we can take the risk, then I'm happy to drop the patch and 
replace it by

	execute_location(dereference_function_descriptor(lkdtm_rodata_do_nothing), CODE_AS_IS)

Christophe
