Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14136688513
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 18:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjBBRGe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 12:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjBBRGd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 12:06:33 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEB249035;
        Thu,  2 Feb 2023 09:06:30 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312Gg0Cp022372;
        Thu, 2 Feb 2023 17:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=1ou/BfjUx931yyEbqx6xu7ImWsoNYnwuj7rno8tiJPY=;
 b=nntwyMz7w4xMDk84fUg03zftlzoRUxmr2gATmZbex8X2DXig96pLjqb3MQFQ8XOTc2BF
 iwSfpBHOJt6YjRu3iHsrYqJrUml31GFUOvC1bQrlkmf3rQMH0AMztmpR7b+qbKqoOz2f
 bsNs0rP3C2ArKNwhCwLNk87VUUs5VO+wgYD9ZqwtgvwpR872O2jdlr67CEFPoxsPDgHh
 pxSrCLEM7v1lMCLWHKuBr7nWCMeD6ohyhsf1Od/C6NKfe800VGHwBsYtzm9BYd5dzBtV
 eBadoFqXw1zieiZAKEPJI3iIxsKW4Jmm+fiO0dN74MEnlw2Xkz2KDsQ0ZBhFz6AvHlL7 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngegwct6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 17:05:36 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 312GgkkN026520;
        Thu, 2 Feb 2023 17:05:35 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngegwct5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 17:05:35 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 312CQDEd014228;
        Thu, 2 Feb 2023 17:05:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3ncvugmm5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 17:05:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 312H5SGL22086172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Feb 2023 17:05:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB8482004E;
        Thu,  2 Feb 2023 17:05:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A969A2004B;
        Thu,  2 Feb 2023 17:05:26 +0000 (GMT)
Received: from osiris (unknown [9.171.31.155])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  2 Feb 2023 17:05:26 +0000 (GMT)
Date:   Thu, 2 Feb 2023 18:05:25 +0100
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
Subject: Re: [PATCH v2 05/10] percpu: Wire up cmpxchg128
Message-ID: <Y9vtVQeG00Fi8X3h@osiris>
References: <20230202145030.223740842@infradead.org>
 <20230202152655.494373332@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202152655.494373332@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q007MhlDi8JrYKwraOMmgRyUF-vFtQV0
X-Proofpoint-GUID: DA6NDcsG8tlhStEJm4IIuB7oK5XzJxbn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_10,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=467 phishscore=0 spamscore=0 lowpriorityscore=0
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

On Thu, Feb 02, 2023 at 03:50:35PM +0100, Peter Zijlstra wrote:
> In order to replace cmpxchg_double() with the newly minted
> cmpxchg128() family of functions, wire it up in this_cpu_cmpxchg().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arm64/include/asm/percpu.h |   21 +++++++++++++++
>  arch/s390/include/asm/percpu.h  |   17 ++++++++++++
>  arch/x86/include/asm/percpu.h   |   56 ++++++++++++++++++++++++++++++++++++++++
>  include/asm-generic/percpu.h    |    8 +++++
>  include/linux/percpu-defs.h     |   20 ++++++++++++--
>  5 files changed, 120 insertions(+), 2 deletions(-)

For s390:
Acked-by: Heiko Carstens <hca@linux.ibm.com>
