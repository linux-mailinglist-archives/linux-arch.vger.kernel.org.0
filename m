Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0205224D541
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 14:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgHUMoS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 08:44:18 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:31050 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgHUMoR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Aug 2020 08:44:17 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BY1Rd0Sbbz9v0RG;
        Fri, 21 Aug 2020 14:44:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Q_TLAb2lp2QD; Fri, 21 Aug 2020 14:44:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BY1Rc5GVgz9v0RF;
        Fri, 21 Aug 2020 14:44:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 260E78B8E1;
        Fri, 21 Aug 2020 14:44:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id isIM-AjxvK5w; Fri, 21 Aug 2020 14:44:14 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 238988B8C5;
        Fri, 21 Aug 2020 14:44:13 +0200 (CEST)
Subject: Re: [PATCH v5 5/8] mm: HUGE_VMAP arch support cleanup
To:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Zefan Li <lizefan@huawei.com>
References: <20200821044427.736424-1-npiggin@gmail.com>
 <20200821044427.736424-6-npiggin@gmail.com>
 <9b67b892-9482-15dc-0c1e-c5d5a93a3c91@csgroup.eu>
 <1598006254.vcbwyiiw9l.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <2bd2e0a4-37bc-680d-1e11-f6f44204c317@csgroup.eu>
Date:   Fri, 21 Aug 2020 14:43:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598006254.vcbwyiiw9l.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 21/08/2020 à 12:39, Nicholas Piggin a écrit :
> Excerpts from Christophe Leroy's message of August 21, 2020 3:40 pm:
>>
>>
>> Le 21/08/2020 à 06:44, Nicholas Piggin a écrit :
>>> This changes the awkward approach where architectures provide init
>>> functions to determine which levels they can provide large mappings for,
>>> to one where the arch is queried for each call.
>>>
>>> This removes code and indirection, and allows constant-folding of dead
>>> code for unsupported levels.
>>
>> I think that in order to allow constant-folding of dead code for
>> unsupported levels, you must define arch_vmap_xxx_supported() as static
>> inline in a .h
>>
>> If you have them in .c files, you'll get calls to tiny functions that
>> will always return false, but will still be called and dead code won't
>> be eliminated. And performance wise, that's probably not optimal either.
> 
> Yeah that's true actually, I think I didn't find a good place to add
> the prototypes in the arch code but I'll have another look and either
> rewrite the changelog or remove it. Although this does get a step closer
> at least.
> 

linux/vmalloc.h includes asm/vmalloc.h
Should it go there ?

Christophe
