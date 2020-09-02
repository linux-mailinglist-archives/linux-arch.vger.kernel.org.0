Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC8325A421
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 05:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgIBDqn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 23:46:43 -0400
Received: from foss.arm.com ([217.140.110.172]:56748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBDqn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 23:46:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71E69D6E;
        Tue,  1 Sep 2020 20:46:42 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E0F23F66F;
        Tue,  1 Sep 2020 20:46:38 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v3 08/13] mm/debug_vm_pgtable/thp: Use page table
 depost/withdraw with THP
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
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
 <5d25b02a-887a-432e-7ecd-cc5cbcea9b02@csgroup.eu>
Message-ID: <ffdc1dfb-4ed3-f1d6-5d90-9e2ed7637a97@arm.com>
Date:   Wed, 2 Sep 2020 09:15:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5d25b02a-887a-432e-7ecd-cc5cbcea9b02@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 09/01/2020 01:21 PM, Christophe Leroy wrote:
> 
> 
> Le 01/09/2020 à 09:40, Aneesh Kumar K.V a écrit :
>> On 9/1/20 12:20 PM, Christophe Leroy wrote:
>>>
>>>
>>> Le 01/09/2020 à 08:25, Aneesh Kumar K.V a écrit :
>>>> On 9/1/20 8:52 AM, Anshuman Khandual wrote:
>>>>>
>>>>>
>>>>>
>>>>> There is a checkpatch.pl warning here.
>>>>>
>>>>> WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
>>>>> #7:
>>>>> Architectures like ppc64 use deposited page table while updating the huge pte
>>>>>
>>>>> total: 0 errors, 1 warnings, 40 lines checked
>>>>>
>>>>
>>>> I will ignore all these, because they are not really important IMHO.
>>>>
>>>
>>> When doing a git log in a 80 chars terminal window, having wrapping lines is not really convenient. It should be easy to avoid it.
>>>
>>
>> We have been ignoring that for a long time  isn't it?
>>
>> For example ppc64 checkpatch already had
>> --max-line-length=90
>>
>>
>> There was also recent discussion whether 80 character limit is valid any more. But I do keep it restricted to 80 character where ever it is easy/make sense.
>>
> 
> Here we are not talking about the code, but the commit log.
> 
> As far as I know, the discussions about 80 character lines, 90 lines in powerpc etc ... is for the code.
> 
> We still aim at keeping lines not longer than 75 chars in the commit log.

Agreed.
