Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641C1688510
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 18:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBBRGK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 12:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBBRGJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 12:06:09 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E1C3EFCA;
        Thu,  2 Feb 2023 09:06:08 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312G70iv014674;
        Thu, 2 Feb 2023 17:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=THmzzCVcKPPGZMPEbQflXm3IvB3LKRlax4gS3uPm2Cg=;
 b=TrxNGHtP3zuDTiRB+QF5ll3EWkcYVujoAKXghE8rtaJu26XV8VJ/t7M8gt4vHbGaYr6u
 wS0iwPRgWM3SvjC4k2ucaS6INccYjuM1SqIYAyfTLjka1cjjbprLkNXGU9yn9qD87yZd
 mO+v2TqIqrACv71/CvbH1BuWsZYlNhkw3s4sCX4/TuV04c0BWj2sWALiK6jyXghQAG/0
 fMXfZQRBe/fL4TwbDwbdDhB1om9qeKNpkpiGyKVaBD3Cy9+QkrRtBW2jt7DjwVbJCSG2
 1CKRQyOhVuQ/THAusffCDfNOC8uLwuMCLDjNr9nxNpYrebHbJGQ+eCQiDa5/Yo5lhYPc GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nge3bwf46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 17:04:55 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 312G79gm016181;
        Thu, 2 Feb 2023 17:04:54 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nge3bwf2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 17:04:54 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 312C25cu026867;
        Thu, 2 Feb 2023 17:04:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3ncvs7pf5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 17:04:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 312H4kMv22217088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Feb 2023 17:04:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D43692004B;
        Thu,  2 Feb 2023 17:04:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05CC320043;
        Thu,  2 Feb 2023 17:04:45 +0000 (GMT)
Received: from osiris (unknown [9.171.31.155])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  2 Feb 2023 17:04:44 +0000 (GMT)
Date:   Thu, 2 Feb 2023 18:04:43 +0100
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
Subject: Re: [PATCH v2 03/10] arch: Introduce
 arch_{,try_}_cmpxchg128{,_local}()
Message-ID: <Y9vtK1voirb1wUfW@osiris>
References: <20230202145030.223740842@infradead.org>
 <20230202152655.373335780@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202152655.373335780@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FHdsPEaqsFg45qSGo90As5Aep1zo1_oE
X-Proofpoint-GUID: hpauW67JMPa2pJxw-_S6KStoX2TLt-s_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_10,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=383
 mlxscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020148
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 02, 2023 at 03:50:33PM +0100, Peter Zijlstra wrote:
> For all architectures that currently support cmpxchg_double()
> implement the cmpxchg128() family of functions that is basically the
> same but with a saner interface.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arm64/include/asm/atomic_ll_sc.h |   41 +++++++++++++++++++++++++
>  arch/arm64/include/asm/atomic_lse.h   |   31 +++++++++++++++++++
>  arch/arm64/include/asm/cmpxchg.h      |   26 ++++++++++++++++
>  arch/s390/include/asm/cmpxchg.h       |   14 ++++++++
>  arch/x86/include/asm/cmpxchg_32.h     |    3 +
>  arch/x86/include/asm/cmpxchg_64.h     |   55 +++++++++++++++++++++++++++++++++-
>  6 files changed, 168 insertions(+), 2 deletions(-)

For s390:
Acked-by: Heiko Carstens <hca@linux.ibm.com>
