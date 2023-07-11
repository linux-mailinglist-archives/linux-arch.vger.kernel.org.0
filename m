Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD17C74E9D7
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 11:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjGKJH3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jul 2023 05:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjGKJH2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2023 05:07:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62844A6;
        Tue, 11 Jul 2023 02:07:27 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B8pKAQ024554;
        Tue, 11 Jul 2023 09:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9V1PWe74FbnwsoWS30TGrc10DyiMCHmQKuXkgQTAjMA=;
 b=InCg+u1NpCIs+fl0EdUKCloBque7vy28mBE5OqkQTgW5mXvVcurUFlaw1qKhTv1H3Ad4
 eXI4OnCcqakSX467/U9VIKwCEExJBYCAPhYMn5goiKDK9RY/iLVgDID7igw9GH3KKM6f
 1mgkajidqXjziMCM43G5bkJXX7k8Ne0mKP0JPnwlnpVV7DfKpobc2r6gMd6uLFwY7eKC
 ZRM5c+2awZ8b/zJ2UIla0q44VK3pCr4e06HUE66NJFLppK2Gjc200taWKHZhO0A8MhcJ
 E32Khy8YlbfWnXXkuJ37i61RQmARzY5nPrDXfLpeLzb6vnuocqZrMokfoKRBk1vtCd4L 4w== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rs3xc8cdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 09:07:14 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36B7X1qa012025;
        Tue, 11 Jul 2023 09:07:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3rpy2e9978-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 09:07:12 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36B978s234603346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 09:07:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83D0920043;
        Tue, 11 Jul 2023 09:07:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 329672004D;
        Tue, 11 Jul 2023 09:07:08 +0000 (GMT)
Received: from [9.152.224.114] (unknown [9.152.224.114])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jul 2023 09:07:08 +0000 (GMT)
Message-ID: <8cfc3eef-e387-88e1-1006-2d7d97a09213@linux.ibm.com>
Date:   Tue, 11 Jul 2023 11:07:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 00/38] New page table range API
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
References: <20230710204339.3554919-1-willy@infradead.org>
Content-Language: en-US
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20230710204339.3554919-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yWhAr4gPvnS30Ln_V4ohQeR9uQatdToz
X-Proofpoint-ORIG-GUID: yWhAr4gPvnS30Ln_V4ohQeR9uQatdToz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 mlxlogscore=490 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Am 10.07.23 um 22:43 schrieb Matthew Wilcox (Oracle):
> This patchset changes the API used by the MM to set up page table entries.
> The four APIs are:
>      set_ptes(mm, addr, ptep, pte, nr)
>      update_mmu_cache_range(vma, addr, ptep, nr)
>      flush_dcache_folio(folio)
>      flush_icache_pages(vma, page, nr)
> 
> flush_dcache_folio() isn't technically new, but no architecture
> implemented it, so I've done that for them.  The old APIs remain around
> but are mostly implemented by calling the new interfaces.
> 
> The new APIs are based around setting up N page table entries at once.
> The N entries belong to the same PMD, the same folio and the same VMA,
> so ptep++ is a legitimate operation, and locking is taken care of for
> you.  Some architectures can do a better job of it than just a loop,
> but I have hesitated to make too deep a change to architectures I don't
> understand well.
> 
> One thing I have changed in every architecture is that PG_arch_1 is now a
> per-folio bit instead of a per-page bit.  This was something that would
> have to happen eventually, and it makes sense to do it now rather than
> iterate over every page involved in a cache flush and figure out if it
> needs to happen.

I think we do use PG_arch_1 on s390 for our secure page handling and
making this perf folio instead of physical page really seems wrong
and it probably breaks this code.

Claudio, can you have a look?


