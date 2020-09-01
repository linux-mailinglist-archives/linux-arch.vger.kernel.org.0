Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F7325899A
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 09:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgIAHva (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 03:51:30 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:41099 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgIAHva (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 03:51:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BgfQj5ZqZz9v4j1;
        Tue,  1 Sep 2020 09:51:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id otG6xobMGX17; Tue,  1 Sep 2020 09:51:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BgfQj4hHYz9v1SD;
        Tue,  1 Sep 2020 09:51:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A99F68B774;
        Tue,  1 Sep 2020 09:51:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0bfitLpUFTsu; Tue,  1 Sep 2020 09:51:26 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C8C8D8B75E;
        Tue,  1 Sep 2020 09:51:25 +0200 (CEST)
Subject: Re: [PATCH v3 08/13] mm/debug_vm_pgtable/thp: Use page table
 depost/withdraw with THP
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
 <20200827080438.315345-9-aneesh.kumar@linux.ibm.com>
 <e7877a8d-b433-0cb4-50a7-631de0022c24@arm.com>
 <9beaaf93-b2dd-6d56-7737-9f022760f246@linux.ibm.com>
 <d80a91c3-0edf-7e2f-8101-2d37a371f4bd@csgroup.eu>
 <2fb4ac88-d417-2bdd-3c56-a816c356636a@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <5d25b02a-887a-432e-7ecd-cc5cbcea9b02@csgroup.eu>
Date:   Tue, 1 Sep 2020 09:51:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2fb4ac88-d417-2bdd-3c56-a816c356636a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 01/09/2020 à 09:40, Aneesh Kumar K.V a écrit :
> On 9/1/20 12:20 PM, Christophe Leroy wrote:
>>
>>
>> Le 01/09/2020 à 08:25, Aneesh Kumar K.V a écrit :
>>> On 9/1/20 8:52 AM, Anshuman Khandual wrote:
>>>>
>>>>
>>>>
>>>> There is a checkpatch.pl warning here.
>>>>
>>>> WARNING: Possible unwrapped commit description (prefer a maximum 75 
>>>> chars per line)
>>>> #7:
>>>> Architectures like ppc64 use deposited page table while updating the 
>>>> huge pte
>>>>
>>>> total: 0 errors, 1 warnings, 40 lines checked
>>>>
>>>
>>> I will ignore all these, because they are not really important IMHO.
>>>
>>
>> When doing a git log in a 80 chars terminal window, having wrapping 
>> lines is not really convenient. It should be easy to avoid it.
>>
> 
> We have been ignoring that for a long time  isn't it?
> 
> For example ppc64 checkpatch already had
> --max-line-length=90
> 
> 
> There was also recent discussion whether 80 character limit is valid any 
> more. But I do keep it restricted to 80 character where ever it is 
> easy/make sense.
> 

Here we are not talking about the code, but the commit log.

As far as I know, the discussions about 80 character lines, 90 lines in 
powerpc etc ... is for the code.

We still aim at keeping lines not longer than 75 chars in the commit log.

Christophe

Christophe
