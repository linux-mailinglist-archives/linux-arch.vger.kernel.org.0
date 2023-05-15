Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8595570279B
	for <lists+linux-arch@lfdr.de>; Mon, 15 May 2023 10:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238316AbjEOIxR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 May 2023 04:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238258AbjEOIxF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2023 04:53:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D571A4;
        Mon, 15 May 2023 01:53:04 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34F8dWhE030931;
        Mon, 15 May 2023 08:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=tL2Dh34WXBi3w0uOo/CEgFzRe9FVdf1V2DHXt3B1hzQ=;
 b=RgF2SLU/GSbIC43sewd93OJMJuQob/OvXp/h4GcpmDVvR3haOU9gtgWCmUKnHIJqaRGS
 zM/YtGmo0F8o8AehEEdxcNS5S0EutJWDp4JzJk07alCpgvPG+u+6OvcpgT1klbETGM7R
 B3vqZS3dTkEwbYIKYt4ZQsetvwQt11RWsnoYCa5Px4UUmeFelWObYB7JNRzhe/quKuJD
 vMFqFRrITU3nBkbW2ns34tBjo2HW/+MSDGQuEIVXyWuTB3BizyyzEZpEsC9781iymOJu
 Bb0Z15FQiZPDvAoBVmZu1rGvQpa8B5kCqVkHQuthmRbvDz+D5OTlICsTTU9UlTO916UP ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qkgnsskcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 08:52:52 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34F8g6jY012065;
        Mon, 15 May 2023 08:52:52 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qkgnsskbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 08:52:52 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34F4cDHw008930;
        Mon, 15 May 2023 08:52:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3qj264rt34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 08:52:49 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34F8qlos22151814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 08:52:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E464220043;
        Mon, 15 May 2023 08:52:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27F9620040;
        Mon, 15 May 2023 08:52:45 +0000 (GMT)
Received: from osiris (unknown [9.179.13.205])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 15 May 2023 08:52:45 +0000 (GMT)
Date:   Mon, 15 May 2023 10:52:43 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, joro@8bytes.org,
        suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3 10/11] arch: Remove cmpxchg_double
Message-ID: <ZGHy21ZEK4Q6umhV@osiris>
References: <20230515075659.118447996@infradead.org>
 <20230515080554.589824283@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515080554.589824283@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t1yqOEs5O0QDxVKZWXKnAMcNMUkxJyzX
X-Proofpoint-GUID: 01k30nTH3vJOdbRkPWfhMNqXAs4dbI1r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_06,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 spamscore=0 bulkscore=0 clxscore=1011 phishscore=0 adultscore=0
 mlxlogscore=660 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150073
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 09:57:09AM +0200, Peter Zijlstra wrote:
> No moar users, remove the monster.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
...
>  arch/s390/include/asm/cmpxchg.h            |   34 -----------------
>  arch/s390/include/asm/percpu.h             |   18 ---------

FWIW, for s390:
Acked-by: Heiko Carstens <hca@linux.ibm.com>
