Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED942609EE
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 07:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgIHFWw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 01:22:52 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:65048 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbgIHFWu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Sep 2020 01:22:50 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bltny2bk8z9tyfS;
        Tue,  8 Sep 2020 07:22:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zhKYZbflWiU8; Tue,  8 Sep 2020 07:22:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bltny1W9Lz9tyfR;
        Tue,  8 Sep 2020 07:22:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 073A98B793;
        Tue,  8 Sep 2020 07:22:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5cxa6T4RQxxI; Tue,  8 Sep 2020 07:22:46 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BACC88B768;
        Tue,  8 Sep 2020 07:22:44 +0200 (CEST)
Subject: Re: [RFC PATCH v2 0/3] mm/gup: fix gup_fast with dynamic page table
 folding
To:     Mike Rapoport <rppt@kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Richard Weinberger <richard@nod.at>,
        linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907201256.GC1976319@kernel.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <9bde9857-fdfd-e384-ea27-a14e5a06f1e6@csgroup.eu>
Date:   Tue, 8 Sep 2020 07:22:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200907201256.GC1976319@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 07/09/2020 à 22:12, Mike Rapoport a écrit :
> On Mon, Sep 07, 2020 at 08:00:55PM +0200, Gerald Schaefer wrote:
>> This is v2 of an RFC previously discussed here:
>> https://lore.kernel.org/lkml/20200828140314.8556-1-gerald.schaefer@linux.ibm.com/
>>
>> Patch 1 is a fix for a regression in gup_fast on s390, after our conversion
>> to common gup_fast code. It will introduce special helper functions
>> pXd_addr_end_folded(), which have to be used in places where pagetable walk
>> is done w/o lock and with READ_ONCE, so currently only in gup_fast.
>>
>> Patch 2 is an attempt to make that more generic, i.e. change pXd_addr_end()
>> themselves by adding an extra pXd value parameter. That was suggested by
>> Jason during v1 discussion, because he is already thinking of some other
>> places where he might want to switch to the READ_ONCE logic for pagetable
>> walks. In general, that would be the cleanest / safest solution, but there
>> is some impact on other architectures and common code, hence the new and
>> greatly enlarged recipient list.
>>
>> Patch 3 is a "nice to have" add-on, which makes pXd_addr_end() inline
>> functions instead of #defines, so that we get some type checking for the
>> new pXd value parameter.
>>
>> Not sure about Fixes/stable tags for the generic solution. Only patch 1
>> fixes a real bug on s390, and has Fixes/stable tags. Patches 2 + 3 might
>> still be nice to have in stable, to ease future backports, but I guess
>> "nice to have" does not really qualify for stable backports.
> 
> I also think that adding pXd parameter to pXd_addr_end() is a cleaner
> way and with this patch 1 is not really required. I would even merge
> patches 2 and 3 into a single patch and use only it as the fix.

Why not merging patches 2 and 3, but I would keep patch 1 separate but 
after the generic changes, so that we first do the generic changes, then 
we do the specific S390 use of it.

Christophe
