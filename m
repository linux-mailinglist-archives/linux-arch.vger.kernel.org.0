Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EE0771C97
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 10:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjHGIvc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 04:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjHGIvV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 04:51:21 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E8292;
        Mon,  7 Aug 2023 01:51:20 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3778eEEf016581;
        Mon, 7 Aug 2023 08:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=K3rm8C31M+8bo1MTJ18FryPmqLznOfinr8IhXGF1nUo=;
 b=elG7n4rPNYtHNYCuGUh7fQdG5pKovmN7+yh0fP1Pfmcssm+vefY8C/QkxgEsCjd677Qq
 rY6ZC4t5jYLex9vS12f7gd/XS6Zs22t8Wvc33ui4j5+5cJwFNabb8YAL2/FEa3tD+HI4
 lW60mrbRZhMusBLm+EaSn9v+WznujcX5xEy3QtyA5cWhGJbPFgL0u2Ix++VbWppeoXLl
 nOiJeHsfHbaKK1289vXsHwDHILUjX4jDTSI1LNzcrtsGqDZmWRWqMBRhwHOusz9xUDsO
 OjyiVhhJpoSSesDWLLd5JTvf/Z6RZFzPstvwcXL0zs54qYCQDrY1RTL62sUwSZJ3wn77 iA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3saw2qghqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 08:51:17 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3777HoMb001597;
        Mon, 7 Aug 2023 08:51:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa2yjk59n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 08:51:16 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3778p9ME63832330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Aug 2023 08:51:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F114C2004B;
        Mon,  7 Aug 2023 08:51:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66F1D20040;
        Mon,  7 Aug 2023 08:51:08 +0000 (GMT)
Received: from osiris (unknown [9.171.54.178])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon,  7 Aug 2023 08:51:08 +0000 (GMT)
Date:   Mon, 7 Aug 2023 10:51:06 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/3] s390: remove unneeded #include <asm/export.h>
Message-ID: <20230807085106.19540-B-hca@linux.ibm.com>
References: <20230806151641.394720-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230806151641.394720-1-masahiroy@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rlpfzrhkdUkT3gXiqvWQDhFSPnHQ64Xq
X-Proofpoint-ORIG-GUID: rlpfzrhkdUkT3gXiqvWQDhFSPnHQ64Xq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_07,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0 mlxlogscore=746
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 07, 2023 at 12:16:38AM +0900, Masahiro Yamada wrote:
> There is no EXPORT_SYMBOL line there, hence #include <asm/export.h>
> is unneeded.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/s390/kernel/mcount.S | 2 --
>  1 file changed, 2 deletions(-)

All three patches applied. Thanks!
