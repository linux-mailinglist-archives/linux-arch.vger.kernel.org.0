Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B06258A07
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 10:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgIAID7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 04:03:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:31502 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgIAIDz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 04:03:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bgfj35351z9v0Hp;
        Tue,  1 Sep 2020 10:03:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id o-eFXfCEiBu6; Tue,  1 Sep 2020 10:03:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bgfj348tSz9v0Hm;
        Tue,  1 Sep 2020 10:03:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7698C8B774;
        Tue,  1 Sep 2020 10:03:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UvDPBkwWDzC9; Tue,  1 Sep 2020 10:03:52 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 838268B75E;
        Tue,  1 Sep 2020 10:03:51 +0200 (CEST)
Subject: Re: [PATCH v2 00/13] mm/debug_vm_pgtable fixes
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        "x86@kernel.org" <x86@kernel.org>
References: <20200819130107.478414-1-aneesh.kumar@linux.ibm.com>
 <52e9743e-fa2f-3fd2-f50e-2c6c38464b96@arm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <c0de2c68-826b-bf0f-dc2c-a501fa7bef38@csgroup.eu>
Date:   Tue, 1 Sep 2020 10:03:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <52e9743e-fa2f-3fd2-f50e-2c6c38464b96@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 21/08/2020 à 10:51, Anshuman Khandual a écrit :
> 
> On 08/19/2020 06:30 PM, Aneesh Kumar K.V wrote:
>> This patch series includes fixes for debug_vm_pgtable test code so that
>> they follow page table updates rules correctly. The first two patches introduce
>> changes w.r.t ppc64. The patches are included in this series for completeness. We can
>> merge them via ppc64 tree if required.
>>
>> Hugetlb test is disabled on ppc64 because that needs larger change to satisfy
>> page table update rules.
>>

> 
> Changes proposed here will impact other enabled platforms as well.
> Adding the following folks and mailing lists, and hoping to get a
> broader review and test coverage. Please do include them in the
> next iteration as well.
> 
> + linux-arm-kernel@lists.infradead.org
> + linux-s390@vger.kernel.org
> + linux-snps-arc@lists.infradead.org
> + x86@kernel.org
> + linux-arch@vger.kernel.org
> 
> + Gerald Schaefer <gerald.schaefer@de.ibm.com>
> + Christophe Leroy <christophe.leroy@c-s.fr>

Please don't use anymore the above address. Only use the one below.

> + Christophe Leroy <christophe.leroy@csgroup.eu>
> + Vineet Gupta <vgupta@synopsys.com>
> + Mike Rapoport <rppt@linux.ibm.com>
> + Qian Cai <cai@lca.pw>
> 

Thanks
Christophe
