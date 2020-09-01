Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FFD2589F3
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 10:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgIAIAD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 04:00:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:59640 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgIAIAC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 04:00:02 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BgfcZ4pZKz9v4j6;
        Tue,  1 Sep 2020 09:59:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id jFpzCAZ8F1-s; Tue,  1 Sep 2020 09:59:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BgfcZ3qkxz9v4j8;
        Tue,  1 Sep 2020 09:59:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8B3A98B774;
        Tue,  1 Sep 2020 09:59:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id sXuYaJ7qSsE1; Tue,  1 Sep 2020 09:59:59 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A8AAA8B75E;
        Tue,  1 Sep 2020 09:59:58 +0200 (CEST)
Subject: Re: [PATCH v3 12/13] mm/debug_vm_pgtable/hugetlb: Disable hugetlb
 test on ppc64
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        "Erhard F." <erhard_f@mailbox.org>
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
 <20200827080438.315345-13-aneesh.kumar@linux.ibm.com>
 <6191e77f-c3b7-21ea-6dbd-eecc09735923@arm.com>
 <68f90b44-b830-58be-3c21-424fee05da37@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <2ca78670-eb76-0192-7a83-1c1fa4a0fff5@csgroup.eu>
Date:   Tue, 1 Sep 2020 09:59:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <68f90b44-b830-58be-3c21-424fee05da37@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 01/09/2020 à 08:30, Aneesh Kumar K.V a écrit :
>>
> 
> I actually wanted to add #ifdef BROKEN. That test is completely broken. 
> Infact I would suggest to remove that test completely.
> 
> 
> 
>> #ifdef will not be required here as there would be a stub definition
>> for hugetlb_advanced_tests() when CONFIG_PPC_BOOK3S_64 is enabled.
>>
>>>       spin_lock(&mm->page_table_lock);
>>>       p4d_clear_tests(mm, p4dp);
>>>
>>
>> But again, we should really try and avoid taking this path.
>>
> 
> To be frank i am kind of frustrated with how this patch series is being 
> looked at. We pushed a completely broken test to upstream and right now 
> we have a code in upstream that crash when booted on ppc64. My attempt 
> has been to make progress here and you definitely seems to be not in 
> agreement to that.
> 
> At this point I am tempted to suggest we remove the DEBUG_VM_PGTABLE 
> support on ppc64 because AFAIU it doesn't add any value.
> 

Note that a bug has been filed at 
https://bugzilla.kernel.org/show_bug.cgi?id=209029

Christophe
