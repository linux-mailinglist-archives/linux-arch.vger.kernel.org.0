Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EDA42D36E
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 09:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhJNHWl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 03:22:41 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:36477 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhJNHWl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Oct 2021 03:22:41 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HVLQp2MNRz9sSL;
        Thu, 14 Oct 2021 09:20:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jxIK-CDZ4PWD; Thu, 14 Oct 2021 09:20:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HVLQp1W5Tz9sSK;
        Thu, 14 Oct 2021 09:20:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1D58A8B788;
        Thu, 14 Oct 2021 09:20:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id SMTWv46bj1yk; Thu, 14 Oct 2021 09:20:34 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.231])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EDB608B763;
        Thu, 14 Oct 2021 09:20:32 +0200 (CEST)
Subject: Re: [PATCH v1 04/10] asm-generic: Use
 HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR to define associated stubs
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
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
 <8db2a3ca2b26a8325c671baa3e0492914597f079.1633964380.git.christophe.leroy@csgroup.eu>
 <202110122359.E59B90A@keescook>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <dbce3a00-2f1a-bb6d-98b5-5f73c14dad9d@csgroup.eu>
Date:   Thu, 14 Oct 2021 09:20:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202110122359.E59B90A@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 13/10/2021 à 09:00, Kees Cook a écrit :
> On Mon, Oct 11, 2021 at 05:25:31PM +0200, Christophe Leroy wrote:
>> Use HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR instead of 'dereference_function_descriptor'
>> to know whether arch has function descriptors.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> I'd mention the intentionally-empty #if/#else in the commit log, as I,
> like Helge, mentally tripped over it in the review. :)
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Ok, I did it in v2.

I also renamed it HAVE_FUNCTION_DESCRIPTORS because behind the fact that 
it has some functions to dereference function descriptor, the main fact 
is that they have and use function descriptors.

Christophe
