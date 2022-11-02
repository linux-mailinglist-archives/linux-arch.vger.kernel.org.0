Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E61615F66
	for <lists+linux-arch@lfdr.de>; Wed,  2 Nov 2022 10:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiKBJRs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 05:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiKBJRb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 05:17:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2A22873C;
        Wed,  2 Nov 2022 02:15:33 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A27Qs4X030407;
        Wed, 2 Nov 2022 09:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=jdQmEeOgiNwFLWeVWTgZR2yrp3zoMERFpz3XBL1Qh2Q=;
 b=kvng6NqwcOm32s3C8WnR2rCvgyxMbP0BVBLoaLLr6pOhfD61/fB4JjqORTiY2Pi0cJS1
 m60ZcidPWydDQe0LqqlsZtIV1Icvf1KIyk+j2lHIPJv6A6uwBvjN2ddYeXx/QYdZIq8d
 2mxqkbSu42LHzPRX6+3wkOtRtr/u0cNBLUD2P/FTDkb3L935l9dRj40kHh8qUzwx9xxa
 LdSKmDag2l9r8NkUHdDuUVDrvKVYN9klnmKDiIZgHrkK+81BfOXE/GqTIwO12WuKd4cP
 G6YjSGo3paPy0DUiuC9UDlktICuILWZp/a1FwzM2dHPRkN/gtUXdBSeTthOMr/OLut65 Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjruhgf0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 09:14:50 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A29AnwJ001370;
        Wed, 2 Nov 2022 09:14:50 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjruhgeyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 09:14:49 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A29CcIa030019;
        Wed, 2 Nov 2022 09:14:47 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3kgut96ca1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 09:14:47 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A29EiaQ2097862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 09:14:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 773F4A405F;
        Wed,  2 Nov 2022 09:14:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6673EA405B;
        Wed,  2 Nov 2022 09:14:43 +0000 (GMT)
Received: from [9.179.6.48] (unknown [9.179.6.48])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Nov 2022 09:14:43 +0000 (GMT)
Message-ID: <50458458-9b57-aa5a-0d67-692cc4dbf2ad@linux.ibm.com>
Date:   Wed, 2 Nov 2022 10:14:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: mm: delay rmap removal until after TLB flush
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>, Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Uros Bizjak <ubizjak@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        linux-arch <linux-arch@vger.kernel.org>
References: <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com>
 <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
 <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com>
 <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
 <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
 <Y1+XCALog8bW7Hgl@hirez.programming.kicks-ass.net>
 <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
 <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HD-L18mDYpAabN4ya7S1LgpqD4jDlWsh
X-Proofpoint-ORIG-GUID: pThod4uwjyNzWhf_DluG1jRsTwt2kGSi
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_06,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Am 31.10.22 um 19:43 schrieb Linus Torvalds:
> Updated subject line, and here's the link to the original discussion
> for new people:
> 
>      https://lore.kernel.org/all/B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com/
> 
> On Mon, Oct 31, 2022 at 10:28 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Ok. At that point we no longer have the pte or the virtual address, so
>> it's not going to be exactly the same debug output.
>>
>> But I think it ends up being fairly natural to do
>>
>>          VM_WARN_ON_ONCE_PAGE(page_mapcount(page) < 0, page);
>>
>> instead, and I've fixed that last patch up to do that.
> 
> Ok, so I've got a fixed set of patches based on the feedback from
> PeterZ, and also tried to do the s390 updates for this blindly, and
> pushed them out into a git branch:
> 
>      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?h=mmu_gather-race-fix
> 
> If people really want to see the patches in email again, I can do
> that, but most of you already have, and the changes are either trivial
> fixes or the s390 updates.
> 
> For the s390 people that I've now added to the participant list maybe
> the git tree is fine - and the fundamental explanation of the problem
> is in that top-most commit (with the three preceding commits being
> prep-work). Or that link to the thread about this all.

Adding Gerald.

> 
> That top-most commit is also where I tried to fix things up for s390
> that uses its own non-gathering TLB flush due to
> CONFIG_MMU_GATHER_NO_GATHER.
> 
> NOTE NOTE NOTE! Unlike my regular git branch, this one may end up
> rebased etc for further comments and fixes. So don't consider that
> stable, it's still more of an RFC branch.
> 
> At a minimum I'll update it with Ack's etc, assuming I get those, and
> my s390 changes are entirely untested and probably won't work.
> 
> As far as I can tell, s390 doesn't actually *have* the problem that
> causes this change, because of its synchronous TLB flush, but it
> obviously needs to deal with the change of rmap zapping logic.
> 
> Also added a few people who are explicitly listed as being mmu_gather
> maintainers. Maybe people saw the discussion on the linux-mm list, but
> let's make it explicit.
> 
> Do people have any objections to this approach, or other suggestions?
> 
> I do *not* consider this critical, so it's a "queue for 6.2" issue for me.
> 
> It probably makes most sense to queue in the -MM tree (after the thing
> is acked and people agree), but I can keep that branch alive too and
> just deal with it all myself as well.
> 
> Anybody?
> 
>                       Linus

It certainly needs a build fix for s390:


In file included from kernel/sched/core.c:78:
./arch/s390/include/asm/tlb.h: In function '__tlb_remove_page_size':
./arch/s390/include/asm/tlb.h:50:17: error: implicit declaration of function 'page_zap_pte_rmap' [-Werror=implicit-function-declaration]
    50 |                 page_zap_pte_rmap(page);
       |                 ^~~~~~~~~~~~~~~~~
