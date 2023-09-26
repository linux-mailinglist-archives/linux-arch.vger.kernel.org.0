Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB60D7AF6CE
	for <lists+linux-arch@lfdr.de>; Wed, 27 Sep 2023 01:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjIZXnC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Sep 2023 19:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjIZXlA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Sep 2023 19:41:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0F11BEF;
        Tue, 26 Sep 2023 15:53:54 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QLnYC9021734;
        Tue, 26 Sep 2023 22:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=zZB0dYUR3FFVNmHrxi9HQc22uG3RrL+fhXjXqsYEZiw=;
 b=hrnDU6sYSrDJR9uVrEze/U4yIj2DuSNzTAEZe4PC3SBiEZxVYmrBdvwG3hpFbZebh0Iu
 BbFDF4AzmZvn+2XQEzD/2iIhVlhc+hPsh6kQInrNoKPkUqrg966jupfLb5DIIlr1wzLj
 y9lTID71M2kLSwUfd9XQISyyQAtXibueOXIsjXVP0/+z/fq3speynzlJXhIcthqG1ZoN
 wnIdUfexsGKubD9xH+lnt8atVb1j9NOYFqQwWVErHTtTqnKvYgwC8CjRkeO7RY1tRpus
 CVKF5XMGFjlyRK/wHIhgX0iqQrO//lhkVT+SESJR0g3JVZFCaiCRiJSn49qUefi2GRB3 Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tc7hw07sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 22:02:30 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QLx22g014239;
        Tue, 26 Sep 2023 22:02:30 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tc7hw07qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 22:02:29 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38QK3o16030753;
        Tue, 26 Sep 2023 22:02:27 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tacjjxa79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 22:02:27 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38QM2QDj54133134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 22:02:26 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 996525805B;
        Tue, 26 Sep 2023 22:02:26 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C502C58059;
        Tue, 26 Sep 2023 22:02:25 +0000 (GMT)
Received: from [9.61.104.45] (unknown [9.61.104.45])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 26 Sep 2023 22:02:25 +0000 (GMT)
Message-ID: <fd879f60-3f0b-48d1-bfa1-6d337768207e@linux.ibm.com>
Date:   Tue, 26 Sep 2023 17:02:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        GNU C Library <libc-alpha@sourceware.org>
From:   Peter Bergner <bergner@linux.ibm.com>
Subject: [PATCH] uapi/auxvec: Define AT_HWCAP3 and AT_HWCAP4 aux vector,
 entries
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gO_5ccXBsh6B5i09S1LfJSWkSowyQdRR
X-Proofpoint-ORIG-GUID: h-kAgeXMqo_4QcCKYyxNVFZtgAGCP97Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_15,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1011
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309260189
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The powerpc toolchain keeps a copy of the HWCAP bit masks in our TCB for fast
access by our __builtin_cpu_supports built-in function.  The TCB space for
the HWCAP entries - which are created in pairs - is an ABI extension, so
waiting to create the space for HWCAP3 and HWCAP4 until we need them is
problematical, given distro unwillingness to apply ABI modifying patches
to distro point releases.  Define AT_HWCAP3 and AT_HWCAP4 in the generic
uapi header so they can be used in GLIBC to reserve space in the powerpc
TCB for their future use.

I scanned both the Linux and GLIBC source codes looking for unused AT_*
values and 29 and 30 did not seem to be used, so they are what I went
with.  If anyone sees a problem with using those specific values, I'm
amenable to using other values, just let me know what would be better.

Peter


Signed-off-by: Peter Bergner <bergner@linux.ibm.com>
---
 include/uapi/linux/auxvec.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/auxvec.h b/include/uapi/linux/auxvec.h
index 6991c4b8ab18..cc61cb9b3e9a 100644
--- a/include/uapi/linux/auxvec.h
+++ b/include/uapi/linux/auxvec.h
@@ -32,6 +32,8 @@
 #define AT_HWCAP2 26	/* extension of AT_HWCAP */
 #define AT_RSEQ_FEATURE_SIZE	27	/* rseq supported feature size */
 #define AT_RSEQ_ALIGN		28	/* rseq allocation alignment */
+#define AT_HWCAP3 29	/* extension of AT_HWCAP */
+#define AT_HWCAP4 30	/* extension of AT_HWCAP */
 
 #define AT_EXECFN  31	/* filename of program */
 
-- 
2.39.3

