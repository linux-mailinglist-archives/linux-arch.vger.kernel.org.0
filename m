Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC07258B20
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 11:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgIAJMe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 05:12:34 -0400
Received: from foss.arm.com ([217.140.110.172]:38950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgIAJMd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 05:12:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D4D330E;
        Tue,  1 Sep 2020 02:12:33 -0700 (PDT)
Received: from [10.163.69.134] (unknown [10.163.69.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13CEF3F71F;
        Tue,  1 Sep 2020 02:12:27 -0700 (PDT)
Subject: Re: [PATCH v2 00/13] mm/debug_vm_pgtable fixes
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
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
 <c0de2c68-826b-bf0f-dc2c-a501fa7bef38@csgroup.eu>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <74db4583-36a3-629b-9423-4e4961a91ea6@arm.com>
Date:   Tue, 1 Sep 2020 14:41:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c0de2c68-826b-bf0f-dc2c-a501fa7bef38@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 09/01/2020 01:33 PM, Christophe Leroy wrote:
> 
> 
> Le 21/08/2020 à 10:51, Anshuman Khandual a écrit :
>>
>> On 08/19/2020 06:30 PM, Aneesh Kumar K.V wrote:
>>> This patch series includes fixes for debug_vm_pgtable test code so that
>>> they follow page table updates rules correctly. The first two patches introduce
>>> changes w.r.t ppc64. The patches are included in this series for completeness. We can
>>> merge them via ppc64 tree if required.
>>>
>>> Hugetlb test is disabled on ppc64 because that needs larger change to satisfy
>>> page table update rules.
>>>
> 
>>
>> Changes proposed here will impact other enabled platforms as well.
>> Adding the following folks and mailing lists, and hoping to get a
>> broader review and test coverage. Please do include them in the
>> next iteration as well.
>>
>> + linux-arm-kernel@lists.infradead.org
>> + linux-s390@vger.kernel.org
>> + linux-snps-arc@lists.infradead.org
>> + x86@kernel.org
>> + linux-arch@vger.kernel.org
>>
>> + Gerald Schaefer <gerald.schaefer@de.ibm.com>
>> + Christophe Leroy <christophe.leroy@c-s.fr>
> 
> Please don't use anymore the above address. Only use the one below.
> 
>> + Christophe Leroy <christophe.leroy@csgroup.eu>

Sure, noted.

>> + Vineet Gupta <vgupta@synopsys.com>
>> + Mike Rapoport <rppt@linux.ibm.com>
>> + Qian Cai <cai@lca.pw>
>>
> 
> Thanks
> Christophe
> 
>
