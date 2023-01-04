Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2682E65D21F
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jan 2023 13:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbjADMKI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Jan 2023 07:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjADMKB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jan 2023 07:10:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056CF3476D;
        Wed,  4 Jan 2023 04:09:59 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304BUDcm025186;
        Wed, 4 Jan 2023 12:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=RSYhdqTpMfykqc1ctl3BKtFuCm8inJnwJpeRspp9ONY=;
 b=WAY+yTiyqrC0H8nHA99N8GOhbtvysVlsp+R2PZkxQv/54AlHHBRZHekzaTqR5be2E1R3
 L7xZyLM/oqTgp/twEaYJRB4NOlfP99IN0XguZux5AXg3Ea5eHFhp7lbpy3qFJIBmejk9
 XbeLvtPSeoLzRFRn4bkFUSzubVFJgswEPxVtKtqP0Vxx26IVfRTY3iIYisHWrxQhndP5
 q16YnO97n04MLUE21A536mcKpY0iwXftD8Gy6h3KS5ZKPcpY0WCx/RfFglTBxkysQ5TQ
 iQPPjUcOuHnJhtyx4SFnoalJUzXWkIXwPfn3ZsDwv2P0Sjq6AKeVuS3FzR47u5HrlWUc /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw8mp8su2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 12:09:26 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 304Bn1l4000794;
        Wed, 4 Jan 2023 12:09:25 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw8mp8stf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 12:09:25 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303H2vOL028210;
        Wed, 4 Jan 2023 12:09:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6uu67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 12:09:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 304C9JKt44171612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Jan 2023 12:09:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 858F520049;
        Wed,  4 Jan 2023 12:09:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEC312004E;
        Wed,  4 Jan 2023 12:09:17 +0000 (GMT)
Received: from osiris (unknown [9.179.28.126])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Jan 2023 12:09:17 +0000 (GMT)
Date:   Wed, 4 Jan 2023 13:09:16 +0100
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
Subject: Re: [RFC][PATCH 07/12] percpu: Wire up cmpxchg128
Message-ID: <Y7VsbM4ada2KkAdx@osiris>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.286760562@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219154119.286760562@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v6Cdb3q06drLPDoMeGnxfYaUTPnm6fUF
X-Proofpoint-GUID: VZjraPk3cBZ_DLGZSw4eYM75PJm0BhwW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_06,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=683 mlxscore=0 impostorscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 19, 2022 at 04:35:32PM +0100, Peter Zijlstra wrote:
> In order to replace cmpxchg_double() with the newly minted
> cmpxchg128() family of functions, wire it up in this_cpu_cmpxchg().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
...
> --- a/arch/s390/include/asm/percpu.h
> +++ b/arch/s390/include/asm/percpu.h
> +#define this_cpu_cmpxchg_16(pcp, oval, nval)				\
> +({									\
> +	u128 old__ = __pcpu_cast_128((nval), (nval));			\
> +	u128 new__ = __pcpu_cast_128((oval), (oval));			\

spot the bug... please merge the below into this patch.

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 24a4d9d644c0..d1997d01892a 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -156,8 +156,8 @@
 
 #define this_cpu_cmpxchg_16(pcp, oval, nval)				\
 ({									\
-	u128 old__ = __pcpu_cast_128((nval), (nval));			\
-	u128 new__ = __pcpu_cast_128((oval), (oval));			\
+	u128 old__ = __pcpu_cast_128((oval), (oval));			\
+	u128 new__ = __pcpu_cast_128((nval), (nval));			\
 	typedef typeof(pcp) pcp_op_T__;					\
 	pcp_op_T__ *ptr__;						\
 	u128 ret__;							\
