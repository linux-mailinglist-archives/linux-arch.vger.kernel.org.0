Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC95751F2A
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jul 2023 12:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjGMKnE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jul 2023 06:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbjGMKnE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jul 2023 06:43:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22B81FDE;
        Thu, 13 Jul 2023 03:43:01 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DALboQ023181;
        Thu, 13 Jul 2023 10:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8BufaUFC4lq+i0mb7tum+tW3iSrvIdyYFfiCKGJV2Qk=;
 b=UWoYASnDlKVaItp/McDdVJ7xToFqq7bV2TMwidsakp9z61MBv99gGJNVx52W/4MRHqkj
 DbOGTFGGOve11J04Ncw6vAzYmJQnuBgQ4C05isIoQFvnqD0bJvSpmZvXIssFAakdiN51
 T/1qH7T7MwuIZWhXh/RdRUA7lEAoCJyQXVw34FY9kqbeMrFv4PvRajPk071PadjA1NDW
 nc7KCFIiMOrpOnYvu0g0bAmDvTOnl0xVnjsdTjiI8bSi7mRfiHcXNiRnVAJd8Dj8IFnx
 VbX2wlkBCUdOMKZOgquzh1xWJ5GO8o701DeAkU5+yR3t66R4feT8p3uhAzcW+fmT2HK9 FQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtfeugh64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 10:42:51 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36D1vZKw012770;
        Thu, 13 Jul 2023 10:42:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3rpye5aauq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 10:42:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36DAgjN027263496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jul 2023 10:42:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 631402004B;
        Thu, 13 Jul 2023 10:42:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEB552004F;
        Thu, 13 Jul 2023 10:42:44 +0000 (GMT)
Received: from [9.171.85.252] (unknown [9.171.85.252])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jul 2023 10:42:44 +0000 (GMT)
Message-ID: <56ca93af-67dc-9d10-d27e-00c8d7c20f1b@linux.ibm.com>
Date:   Thu, 13 Jul 2023 12:42:44 +0200
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
Content-Language: en-US
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <ZK1My5hQYC2Kb6G1@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iA3442D4Wv-j8LnOlc5uYmBlAGOt8UUj
X-Proofpoint-ORIG-GUID: iA3442D4Wv-j8LnOlc5uYmBlAGOt8UUj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=425 impostorscore=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130092
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Am 11.07.23 um 14:36 schrieb Matthew Wilcox:
> On Tue, Jul 11, 2023 at 11:07:06AM +0200, Christian Borntraeger wrote:
>> Am 10.07.23 um 22:43 schrieb Matthew Wilcox (Oracle):
>>> This patchset changes the API used by the MM to set up page table entries.
>>> The four APIs are:
>>>       set_ptes(mm, addr, ptep, pte, nr)
>>>       update_mmu_cache_range(vma, addr, ptep, nr)
>>>       flush_dcache_folio(folio)
>>>       flush_icache_pages(vma, page, nr)
>>>
>>> flush_dcache_folio() isn't technically new, but no architecture
>>> implemented it, so I've done that for them.  The old APIs remain around
>>> but are mostly implemented by calling the new interfaces.
>>>
>>> The new APIs are based around setting up N page table entries at once.
>>> The N entries belong to the same PMD, the same folio and the same VMA,
>>> so ptep++ is a legitimate operation, and locking is taken care of for
>>> you.  Some architectures can do a better job of it than just a loop,
>>> but I have hesitated to make too deep a change to architectures I don't
>>> understand well.
>>>
>>> One thing I have changed in every architecture is that PG_arch_1 is now a
>>> per-folio bit instead of a per-page bit.  This was something that would
>>> have to happen eventually, and it makes sense to do it now rather than
>>> iterate over every page involved in a cache flush and figure out if it
>>> needs to happen.
>>
>> I think we do use PG_arch_1 on s390 for our secure page handling and
>> making this perf folio instead of physical page really seems wrong
>> and it probably breaks this code.
> 
> Per-page flags are going away in the next few years, so you're going to
> need a new design.  s390 seems to do a lot of unusual things.  I wish
> you'd talk to the rest of us more.

I understand you point from a logical point of view, but a 4k page frame
is also a hardware defined memory region. And I think not only for us.
How do you want to implement hardware poisoning for example?
Marking the whole folio with PG_hwpoison seems wrong.
