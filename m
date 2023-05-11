Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274B46FED41
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 09:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbjEKH6Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 May 2023 03:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjEKH6W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 03:58:22 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F75DD;
        Thu, 11 May 2023 00:58:21 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34B7dgUa004840;
        Thu, 11 May 2023 07:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=yfYCleIUn+xWJ9AcJe62X2wnauCgiMhHoQILlx/ttD4=;
 b=LFq957axn1UNzTUzhvNVYlDHbCfcqhQ2pRD8ZLsFp/RSpjT1uBMJ/d7ENLNjdQvs8b/O
 ETkXd8kuOadcVr2pCLjNWw4G6MBgssGxGpZMpJIuASv1SpR0PUK34wuL0h5qEW2QJh35
 I82bYrl1LLcaa8T78oJT6a6wtEhLMGPImsQm6ZZ7OMLR004RU4Y4gi9OSAsfKRz/2fjX
 JzkG3CzcsaF9fSk6t5lnZ7W3md1J2Vb7gFuVV3BeMsGsW3QU1zaunkYp8Yy88gnQ5l6D
 XVrXeBgHCOF+7Jj5+rSLVfvXlTFdfCzT/ZEvy3XYrdn6a7Y8+/7BRN1ptdRgFVOcV3xn Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qgcdvax5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 07:57:23 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34B7vMqo010805;
        Thu, 11 May 2023 07:57:22 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qgcdvax4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 07:57:22 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34B4RaPD016221;
        Thu, 11 May 2023 07:57:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qf7nh1hc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 07:57:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34B7vF6226739210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 07:57:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8227920043;
        Thu, 11 May 2023 07:57:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7766720040;
        Thu, 11 May 2023 07:57:13 +0000 (GMT)
Received: from osiris (unknown [9.179.19.134])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 11 May 2023 07:57:13 +0000 (GMT)
Date:   Thu, 11 May 2023 09:57:11 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, kernel-team@meta.com,
        linux-arch@vger.kernel.org, hannes@cmpxchg.org,
        richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux@armlinux.org.uk, geert@linux-m68k.org,
        monstr@monstr.eu, tsbogend@alpha.franken.de,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, davem@davemloft.net,
        chris@zankel.net, jcmvbkbc@gmail.com, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH] cachestat: wire up cachestat for other architectures
Message-ID: <ZFyf195PuoBmaV2N@osiris>
References: <20230510195806.2902878-1-nphamcs@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510195806.2902878-1-nphamcs@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4wqLDbk2I-cFtsb56SrteodOnFigMIFv
X-Proofpoint-GUID: fOUzFmhABUHi7ZZwffU3nGIoi4bBWM03
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1011 malwarescore=0 suspectscore=0 mlxlogscore=301
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 10, 2023 at 12:58:06PM -0700, Nhat Pham wrote:
> cachestat is previously only wired in for x86 (and architectures using
> the generic unistd.h table):
> 
> https://lore.kernel.org/lkml/20230503013608.2431726-1-nphamcs@gmail.com/
> 
> This patch wires cachestat in for all the other architectures.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
...
>  arch/s390/kernel/syscalls/syscall.tbl       | 1 +

Acked-by: Heiko Carstens <hca@linux.ibm.com> (s390)
