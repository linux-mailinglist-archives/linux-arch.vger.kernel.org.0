Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61B6752BCF
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jul 2023 22:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjGMUn2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jul 2023 16:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjGMUn1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jul 2023 16:43:27 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7090D2710;
        Thu, 13 Jul 2023 13:43:26 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DKHBxx017705;
        Thu, 13 Jul 2023 20:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=772T/pNvtTeSekLPdcFDuGm+FrrGOncjPpcPiRxQAsA=;
 b=W7jUpo7X+Vp1Op9klgbXzcdrpPz8PRd1CqWFJWf18U0QXV7NDECZDBS1xrSRpE6FaIgT
 4DJw2C3hWfyPAbeIV8U7oQ46f6wv1kQ5ZBqntgt86s6MuAAszFYwgHTDhTx6wKQrgQNZ
 NO86pJgJVgZdAEHpldzvNJV3zPELmb7lcfr+JMmgn51VSZA9RohLaa9zZMKKODWEpUsP
 2RexgKtXRdsRVRrW+CUWXgNxZJJZEH2+FSdJPgFmNAGSHjQf5/J+A5Y3MY018ambKH2y
 szcaUGP1D4OJr77hBdhgETo+f6KRnGmu3cQKbjTotg63/YgheNat6Gy7yurgvfiu3DZk 7Q== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtr5r0ss2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 20:43:17 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36DInN4F001168;
        Thu, 13 Jul 2023 20:27:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rtpvur4tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 20:27:26 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36DKRNcm42336770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jul 2023 20:27:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4215720049;
        Thu, 13 Jul 2023 20:27:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B359220043;
        Thu, 13 Jul 2023 20:27:22 +0000 (GMT)
Received: from [9.171.17.117] (unknown [9.171.17.117])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jul 2023 20:27:22 +0000 (GMT)
Message-ID: <75932f85-67c7-8065-9fa0-77d76db19e7b@linux.ibm.com>
Date:   Thu, 13 Jul 2023 22:27:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 00/38] New page table range API
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
References: <20230710204339.3554919-1-willy@infradead.org>
 <8cfc3eef-e387-88e1-1006-2d7d97a09213@linux.ibm.com>
 <ZK1My5hQYC2Kb6G1@casper.infradead.org>
 <56ca93af-67dc-9d10-d27e-00c8d7c20f1b@linux.ibm.com>
 <ZK//Qnfhx+ihtvlO@casper.infradead.org>
Content-Language: en-US
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <ZK//Qnfhx+ihtvlO@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hBhU07KTJ-nQvi3vo9XvqfWV1hZipSMI
X-Proofpoint-ORIG-GUID: hBhU07KTJ-nQvi3vo9XvqfWV1hZipSMI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_08,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=705 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307130182
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Am 13.07.23 um 15:42 schrieb Matthew Wilcox:
> On Thu, Jul 13, 2023 at 12:42:44PM +0200, Christian Borntraeger wrote:
>>
>>
>> Am 11.07.23 um 14:36 schrieb Matthew Wilcox:
>>> On Tue, Jul 11, 2023 at 11:07:06AM +0200, Christian Borntraeger wrote:
>>>> Am 10.07.23 um 22:43 schrieb Matthew Wilcox (Oracle):
>>>>> This patchset changes the API used by the MM to set up page table entries.
>>>>> The four APIs are:
>>>>>        set_ptes(mm, addr, ptep, pte, nr)
>>>>>        update_mmu_cache_range(vma, addr, ptep, nr)
>>>>>        flush_dcache_folio(folio)
>>>>>        flush_icache_pages(vma, page, nr)
>>>>>
>>>>> flush_dcache_folio() isn't technically new, but no architecture
>>>>> implemented it, so I've done that for them.  The old APIs remain around
>>>>> but are mostly implemented by calling the new interfaces.
>>>>>
>>>>> The new APIs are based around setting up N page table entries at once.
>>>>> The N entries belong to the same PMD, the same folio and the same VMA,
>>>>> so ptep++ is a legitimate operation, and locking is taken care of for
>>>>> you.  Some architectures can do a better job of it than just a loop,
>>>>> but I have hesitated to make too deep a change to architectures I don't
>>>>> understand well.
>>>>>
>>>>> One thing I have changed in every architecture is that PG_arch_1 is now a
>>>>> per-folio bit instead of a per-page bit.  This was something that would
>>>>> have to happen eventually, and it makes sense to do it now rather than
>>>>> iterate over every page involved in a cache flush and figure out if it
>>>>> needs to happen.
>>>>
>>>> I think we do use PG_arch_1 on s390 for our secure page handling and
>>>> making this perf folio instead of physical page really seems wrong
>>>> and it probably breaks this code.
>>>
>>> Per-page flags are going away in the next few years, so you're going to
>>> need a new design.  s390 seems to do a lot of unusual things.  I wish
>>> you'd talk to the rest of us more.
>>
>> I understand you point from a logical point of view, but a 4k page frame
>> is also a hardware defined memory region. And I think not only for us.
>> How do you want to implement hardware poisoning for example?
>> Marking the whole folio with PG_hwpoison seems wrong.
> 
> For hardware poison, we can't use the page for any other purpose any more.
> So one of the 16 types of pointer is for hardware poison.  That doesn't
> seem like it's a solution that could work for secure/insecure pages?
> 
> But what I'm really wondering is why you need to transition pages
> between secure/insecure on a 4kB boundary.  What's the downside to doing
> it on a 16kB or 64kB boundary, or whatever size has been allocated?

The export and import for more pages will be more expensive, but I assume that
we would then also use the larger chunks (e.g. for paging). The more interesting
problem is that the guest can make a page shared/non-shared on a 4kb granularity.

Stupid question: can folios be split into folio,single page,folio when needed?
