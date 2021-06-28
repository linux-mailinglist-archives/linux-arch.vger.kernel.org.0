Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB693B58D2
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 07:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhF1F6x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 01:58:53 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:60420 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232172AbhF1F6w (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 Jun 2021 01:58:52 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4GCxgV1Yc3zBBlp;
        Mon, 28 Jun 2021 07:56:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XDK_m3pCk78b; Mon, 28 Jun 2021 07:56:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4GCxgV0d9PzBBgx;
        Mon, 28 Jun 2021 07:56:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ECF008B776;
        Mon, 28 Jun 2021 07:56:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QcdPGwq5KisL; Mon, 28 Jun 2021 07:56:21 +0200 (CEST)
Received: from [172.25.230.102] (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B1C728B763;
        Mon, 28 Jun 2021 07:56:21 +0200 (CEST)
Subject: Re: [PATCH v3] mm: pagewalk: Fix walk for hugepage tables
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Steven Price <steven.price@arm.com>, linux-mm@kvack.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <38d04410700c8d02f28ba37e020b62c55d6f3d2c.1624597695.git.christophe.leroy@csgroup.eu>
 <20210627181226.983d899cc30c02420e1a6af5@linux-foundation.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <ecf71f68-d25e-c0c6-4c2a-b181b836ac43@csgroup.eu>
Date:   Mon, 28 Jun 2021 07:56:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210627181226.983d899cc30c02420e1a6af5@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 28/06/2021 à 03:12, Andrew Morton a écrit :
> On Fri, 25 Jun 2021 05:10:12 +0000 (UTC) Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> 
>> Pagewalk ignores hugepd entries and walk down the tables
>> as if it was traditionnal entries, leading to crazy result.
>>
>> Add walk_hugepd_range() and use it to walk hugepage tables.
> 
> More details, please?  I assume "crazy result" is userspace visible?
> For how long has this bug existed?  Is a -stable backport needed?  Has
> a Fixes: commit been identified?  etcetera!
> 

I discovered the problem while porting powerpc to generic page table dump.
The generic page table dump uses walk_page_range_novma() .

Yes, "crazy result" is that when dumping /sys/kernel/debug/kernel_page_tables, you get random 
entries because at the time being the pagewalk code sees huge page directories as standard page tables.

The bug has always existed as far as I can see, but as no other architectures than powerpc use huge 
page directories, it only pops up now when powerpc is trying to use that generic page walking code.

So I don't think it is worth a backport to -stable, and about a Fixes: tag I don't know.

IIUC, hugepd was introduced for the first time in mm by commit cbd34da7dc9a ("mm: move the powerpc 
hugepd code to mm/gup.c")

Before that, hugepd was internal to powerpc.

I guess you are asking about Fixes: tag and backporting because of the patch subject.
Should I reword the page subject to something like "mm: enable the generic page walk code to walk 
huge page directories" ?
