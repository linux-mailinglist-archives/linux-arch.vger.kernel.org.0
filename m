Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE5B38164D
	for <lists+linux-arch@lfdr.de>; Sat, 15 May 2021 08:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhEOG3p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 May 2021 02:29:45 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:39263 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229980AbhEOG3o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 15 May 2021 02:29:44 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FhwSs2YMvz9sbb;
        Sat, 15 May 2021 08:28:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zEapEaUkxjZf; Sat, 15 May 2021 08:28:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FhwSs1YWcz9sbT;
        Sat, 15 May 2021 08:28:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1A8538B76E;
        Sat, 15 May 2021 08:28:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TQ3BUIWyNMAO; Sat, 15 May 2021 08:28:29 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5554B8B765;
        Sat, 15 May 2021 08:28:28 +0200 (CEST)
Subject: Re: [PATCH] arm64: Define only {pud/pmd}_{set/clear}_huge when
 usefull
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, naresh.kamboju@linaro.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
References: <73ec95f40cafbbb69bdfb43a7f53876fd845b0ce.1620990479.git.christophe.leroy@csgroup.eu>
 <20210514144200.b49ee77c9b2a7f9998ffbf22@linux-foundation.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <ae1be8a1-8412-1288-31d4-23dc2cf4e5e7@csgroup.eu>
Date:   Sat, 15 May 2021 08:28:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514144200.b49ee77c9b2a7f9998ffbf22@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 14/05/2021 à 23:42, Andrew Morton a écrit :
> On Fri, 14 May 2021 11:08:53 +0000 (UTC) Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> 
>> When PUD and/or PMD are folded, those functions are useless
>> and we now have a stub in linux/pgtable.h
> 
> OK, help me out here please.  What patch does this fix?
> 

Both this one and the x86 one from the day before fix 1cff41494b15cd82c1ec418bb5c ("mm/pgtable: add 
stubs for {pmd/pub}_{set/clear}_huge")

I think both the x86 fix and the arm64 fix should be squashed into that patch at the end.

I checked, the only other architecture involving pud_set_huge() and friends is powerpc, and powerpc 
doesn't have this problem as it only defined those for book3s/64 platforms which have 4 level page 
tables by definition.

Thanks
Christophe
