Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A1A738841
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jun 2023 17:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjFUPBA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 11:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjFUPAE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 11:00:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71AD5FF0;
        Wed, 21 Jun 2023 07:54:50 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LEmqhb023057;
        Wed, 21 Jun 2023 14:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=ufplYvlDcXmpwfmv6hySA3mz7btguYibmlfOu+EhMyQ=;
 b=RksFeJCqi8/XEsNsFNNOeDB6kOaDGSwtr/y3SMMlGsZiDdvUE0WTs/Sgq5XJRyXVSmHX
 +br3q8ohmX33mzOyLHHadNhxSQn5zaVrGCvgL/YeBzrHrY+GOut69jqxfe0E3z3I6g+V
 sxgB9PvEgYNW8nqPIgSEy/nLTRuCbIkMH02R5slzI7XTjRV8DIBwkc+o+3TTga/UeRGP
 DQW2O10/YgdwB8ZEf/CpMLQyaBTeFHE46P2ktveNTB3+Mgq3uHMmGqNSp9F5B4vSKty+
 pwUTVv95Ocmw+GHnz1zVWhDIkS2hnHlvLGH9GhSwBocuuVVzgIajx+sSLROTbfrxasxy 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc3a3g3rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 14:53:10 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35LEmtmJ023155;
        Wed, 21 Jun 2023 14:53:10 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc3a3g3q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 14:53:09 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35L5ZtLD020901;
        Wed, 21 Jun 2023 14:53:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3r94f524m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 14:53:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35LEr3vZ40960344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 14:53:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7D1A20043;
        Wed, 21 Jun 2023 14:53:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11FD520040;
        Wed, 21 Jun 2023 14:53:03 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Jun 2023 14:53:03 +0000 (GMT)
Date:   Wed, 21 Jun 2023 16:53:01 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@lst.de, rppt@kernel.org, willy@infradead.org,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, deller@gmx.de,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v6 10/19] s390: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZJMOzbQeVCLJfvXk@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20230609075528.9390-11-bhe@redhat.com>
 <202306100105.8GHnoMCP-lkp@intel.com>
 <ZIWrtFMUnRfVP5h0@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIWrtFMUnRfVP5h0@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NsNfLNerAb4XCeCbSoD6l5PpTopTDxHU
X-Proofpoint-ORIG-GUID: O67ntRKqq7CkkGkM2LAJDtH5Mvg4y18j
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210123
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 11, 2023 at 07:10:44PM +0800, Baoquan He wrote:

Hi Baoquan,

> From 26aedf424dac7e58dd1389e554cfe0693e2b371f Mon Sep 17 00:00:00 2001
> From: Baoquan He <bhe@redhat.com>
> Date: Sun, 11 Jun 2023 18:37:43 +0800
> Subject: [PATCH] s390: mm: fix building error when converting to
>  GENERIC_IOREMAP
> Content-type: text/plain
> 
> We should always include <asm/io.h> in ARCH, but not <asm-generic/io.h>
> directly. Otherwise, macro defined by ARCH won't be seen and could cause
> building error.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306100105.8GHnoMCP-lkp@intel.com/
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/s390/kernel/perf_cpum_sf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
> index 7ef72f5ff52e..b0269f3881aa 100644
> --- a/arch/s390/kernel/perf_cpum_sf.c
> +++ b/arch/s390/kernel/perf_cpum_sf.c
> @@ -22,7 +22,7 @@
>  #include <asm/irq.h>
>  #include <asm/debug.h>
>  #include <asm/timex.h>
> -#include <asm-generic/io.h>
> +#include <asm/io.h>
>  
>  /* Minimum number of sample-data-block-tables:
>   * At least one table is required for the sampling buffer structure.

Applied, thanks!
