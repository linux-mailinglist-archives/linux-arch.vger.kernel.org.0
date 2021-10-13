Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1F242BED0
	for <lists+linux-arch@lfdr.de>; Wed, 13 Oct 2021 13:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhJMLWk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Oct 2021 07:22:40 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:33735 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhJMLWk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Oct 2021 07:22:40 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HTqpC28Spz9sSP;
        Wed, 13 Oct 2021 13:20:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kZcpVFyhFd8g; Wed, 13 Oct 2021 13:20:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HTqpC0fNwz9sSN;
        Wed, 13 Oct 2021 13:20:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EE53D8B77E;
        Wed, 13 Oct 2021 13:20:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3nizRho4O5jm; Wed, 13 Oct 2021 13:20:34 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B49778B763;
        Wed, 13 Oct 2021 13:20:34 +0200 (CEST)
Subject: Re: [PATCH v1 06/10] asm-generic: Refactor
 dereference_[kernel]_function_descriptor()
To:     Kees Cook <keescook@chromium.org>, Helge Deller <deller@gmx.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
 <c215b244a19a07327ec81bf99f3c5f89c68af7b4.1633964380.git.christophe.leroy@csgroup.eu>
 <202110130002.A7C0A86@keescook>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <c2904a2e-c112-f2bc-04a0-52b08b46c1ce@csgroup.eu>
Date:   Wed, 13 Oct 2021 13:20:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202110130002.A7C0A86@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 13/10/2021 à 09:02, Kees Cook a écrit :
> On Mon, Oct 11, 2021 at 05:25:33PM +0200, Christophe Leroy wrote:
>> dereference_function_descriptor() and
>> dereference_kernel_function_descriptor() are identical on the
>> three architectures implementing them.
>>
>> Make it common.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/ia64/include/asm/sections.h    | 19 -------------------
>>   arch/parisc/include/asm/sections.h  |  9 ---------
>>   arch/parisc/kernel/process.c        | 21 ---------------------
>>   arch/powerpc/include/asm/sections.h | 23 -----------------------
>>   include/asm-generic/sections.h      | 18 ++++++++++++++++++
>>   5 files changed, 18 insertions(+), 72 deletions(-)
> 
> A diffstat to love. :)
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Unless somebody minds, I will make them out of line as
suggested by Helge in he's comment to patch 4.

Allthough there is no spectacular size reduction, the functions
are not worth being inlined as they are not used in critical pathes.
