Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14283B3BDA
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jun 2021 06:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhFYE7Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Jun 2021 00:59:24 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63897 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhFYE7T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 25 Jun 2021 00:59:19 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4GB4VK1WGnzBC7l;
        Fri, 25 Jun 2021 06:56:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2g-zeAQYg2tJ; Fri, 25 Jun 2021 06:56:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4GB4VK0Z0yzBC7h;
        Fri, 25 Jun 2021 06:56:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EB1638B7F4;
        Fri, 25 Jun 2021 06:56:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id WESD5kl9hnOU; Fri, 25 Jun 2021 06:56:55 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0E8C58B7F0;
        Fri, 25 Jun 2021 06:56:51 +0200 (CEST)
Subject: Re: [PATCH v2 1/4] mm: pagewalk: Fix walk for hugepage tables
To:     Michael Ellerman <mpe@ellerman.id.au>, akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Paul Mackerras <paulus@samba.org>, dja@axtens.net,
        Steven Price <steven.price@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <cover.1618828806.git.christophe.leroy@csgroup.eu>
 <db6981c69f96a8c9c6dcf688b7f485e15993ddef.1618828806.git.christophe.leroy@csgroup.eu>
 <d22d196a-45ea-0960-b748-caab0e996c7c@csgroup.eu>
 <874kdm1rim.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <217a6b38-a6ac-84d5-e3dc-257331431bb2@csgroup.eu>
Date:   Fri, 25 Jun 2021 06:56:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <874kdm1rim.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 25/06/2021 à 06:45, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> Hi Michael,
>>
>> Le 19/04/2021 à 12:47, Christophe Leroy a écrit :
>>> Pagewalk ignores hugepd entries and walk down the tables
>>> as if it was traditionnal entries, leading to crazy result.
>>>
>>> Add walk_hugepd_range() and use it to walk hugepage tables.
>>
>> I see you took patch 2 and 3 of the series.
> 
> Yeah I decided those were bug fixes so could be taken separately.
> 
>> Do you expect Andrew to take patch 1 via mm tree, and then you'll take
>> patch 4 once mm tree is merged ?
> 
> I didn't feel I could take patch 1 via the powerpc tree without risking
> conflicts.
> 
> Andrew could take patch 1 and 4 via mm, though he might not want to pick
> them up this late.

Patch 4 needs patches 2 and 3 and doesn't apply without them so it is not that easy.

Maybe Andrew you can take patch 1 now and then Michael you can take patch 4 at anytime during 5.15 
preparation without any conflict risk ?

> 
> I guess step one would be to repost 1 and 4 as a new series. Either they
> can go via mm, or for 5.15 I could probably take them both as long as I
> pick them up early enough.
> 

I'll first repost patch 1 as standalone and see what happens.

Christophe
