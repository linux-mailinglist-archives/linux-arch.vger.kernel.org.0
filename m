Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1FF65C4F2
	for <lists+linux-arch@lfdr.de>; Tue,  3 Jan 2023 18:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbjACRR4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Jan 2023 12:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238165AbjACRRy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jan 2023 12:17:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9EDD8;
        Tue,  3 Jan 2023 09:17:53 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303FBZbW024241;
        Tue, 3 Jan 2023 17:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=vYy7M1t90PXp8Ww5l79hBYIeVV3imFzvlAp6ShHvT+A=;
 b=Kuc1aXe4Le2pJh78LzwravdcrsyCccOE2BEmjTicEZwqlCSjHjZ3nDDLwXlcjLpPFDS/
 TKMgGhc7mSifKtxMTqVtl+pLRYNfbrS4pCYmS+QWJOp/cTXCN0qPCOqs+VMLSKQEC8+Z
 frju4tXZGjGrOMq/LYw6nHmELHDEPekPOdaoz62nvCJAJc//CbjTXKTEU5LLbGG2N6p8
 GT0DsUdazyvytqOzMe9gpytlJWXmFJSuSX2Hg5Qf2oqxhjY/QfmqeVy88GpkIl9mupM1
 6M+rFKMvK9Ls2i6k3OSTw8GoN35oaa3dewxD9CNtc94omRrKe4Y9dmIfY2I00JqcmAhK iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvhh4jhv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 17:16:53 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 303HF0cs024698;
        Tue, 3 Jan 2023 17:16:52 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvhh4jhu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 17:16:52 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303FN4hK005328;
        Tue, 3 Jan 2023 17:16:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6k0pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 17:16:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 303HGjnh20644460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jan 2023 17:16:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75F8F2004B;
        Tue,  3 Jan 2023 17:16:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E35F20040;
        Tue,  3 Jan 2023 17:16:43 +0000 (GMT)
Received: from osiris (unknown [9.171.65.115])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  3 Jan 2023 17:16:43 +0000 (GMT)
Date:   Tue, 3 Jan 2023 18:16:41 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 11/12] slub: Replace cmpxchg_double()
Message-ID: <Y7Ri+Uij1GFkI/LB@osiris>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.550996611@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219154119.550996611@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aYt5JesJFhS0mKJx405t1-xW5NqppuLb
X-Proofpoint-GUID: Z03ZnZI1MCXR4CrburtVGAvLqmHB93ng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_05,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=618 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030145
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 19, 2022 at 04:35:36PM +0100, Peter Zijlstra wrote:
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/slub_def.h |   12 ++-
>  mm/slab.h                |   41 +++++++++++--
>  mm/slub.c                |  146 ++++++++++++++++++++++++++++-------------------
>  3 files changed, 135 insertions(+), 64 deletions(-)

Does this actually work? Just wondering since I end up with an instant
list corruption on s390. Might be endianness related, but I can't see
anything obvious at a first glance.
