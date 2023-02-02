Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B6268851B
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 18:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjBBRGq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 12:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjBBRGo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 12:06:44 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52E645880;
        Thu,  2 Feb 2023 09:06:39 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312Gg6N5015686;
        Thu, 2 Feb 2023 17:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=yDxzHC0i4XY1TjBLDhAoGwe8Lrg89+u6eciHDt+wFdI=;
 b=XpL4qbrifRD2fUENbKAPApcJH7yCbeDYrlHXD49LZ3gyOvT4rQrVfJWVhlsJuS7mEc64
 d8I0tMxflpcTLBQ0gJLvYzbNtPiTpfqkyiYYYW9foAZmbBcKHo0xOe8+QJfIuUAT67gm
 8k3PNYChos3Jp55WEvn0TbGgDNhu2U5hyQ2SmOTX3IbrBBFaNASRzPvfjWpLmYzzdC8r
 hU5i8hLgQJOEMU3bBIO6LPHnnpjE0pBIc1LdJh47MBhh2mcaVVRHVW52KdzOGDhndR0F
 0cmlPNpQkF2SoV8fmVLiewp95YGFC9dGr00sgrI+cAlo9s2xXdlyzxCb/nI5jK7Df8S+ IA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngesvv96b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 17:06:06 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 312GggE0016414;
        Thu, 2 Feb 2023 17:06:05 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngesvv95c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 17:06:05 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 312BJnDH007789;
        Thu, 2 Feb 2023 17:06:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3ncvuqvmd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 17:06:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 312H5xep47317404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Feb 2023 17:05:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D65E20043;
        Thu,  2 Feb 2023 17:05:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7567020040;
        Thu,  2 Feb 2023 17:05:57 +0000 (GMT)
Received: from osiris (unknown [9.171.31.155])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  2 Feb 2023 17:05:57 +0000 (GMT)
Date:   Thu, 2 Feb 2023 18:05:56 +0100
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
Subject: Re: [PATCH v2 10/10] s390/cpum_sf: Convert to cmpxchg128()
Message-ID: <Y9vtdJhobsBgasDa@osiris>
References: <20230202145030.223740842@infradead.org>
 <20230202152655.805747571@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202152655.805747571@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z7UVjly_HchAKy3nXhefa_qrgUKnjUaS
X-Proofpoint-ORIG-GUID: 7ytywSjFg4weggctu8H9bLj6a3mmNq_m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_10,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=509 mlxscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020148
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 02, 2023 at 03:50:40PM +0100, Peter Zijlstra wrote:
> Now that there is a cross arch u128 and cmpxchg128(), use those
> instead of the custom CDSG helper.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/s390/include/asm/cpu_mf.h  |    2 +-
>  arch/s390/kernel/perf_cpum_sf.c |   22 ++++++----------------
>  2 files changed, 7 insertions(+), 17 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>
