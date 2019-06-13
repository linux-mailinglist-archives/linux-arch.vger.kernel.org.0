Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFE043C17
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2019 17:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfFMPdz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jun 2019 11:33:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728310AbfFMKfT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Jun 2019 06:35:19 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DAW7v9111438
        for <linux-arch@vger.kernel.org>; Thu, 13 Jun 2019 06:35:17 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t3je46jhu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 13 Jun 2019 06:35:17 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 13 Jun 2019 11:35:15 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Jun 2019 11:35:13 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5DAZB6v51052784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 10:35:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71782AE04D;
        Thu, 13 Jun 2019 10:35:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A382AE045;
        Thu, 13 Jun 2019 10:35:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jun 2019 10:35:10 +0000 (GMT)
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCHv2 1/3] processor: remove spin_cpu_yield
Date:   Thu, 13 Jun 2019 12:35:08 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190613103510.60529-1-heiko.carstens@de.ibm.com>
References: <20190613103510.60529-1-heiko.carstens@de.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19061310-0008-0000-0000-000002F36B1E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061310-0009-0000-0000-00002260707C
Message-Id: <20190613103510.60529-2-heiko.carstens@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=553 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130082
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

spin_cpu_yield is unused, therefore remove it.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/powerpc/include/asm/processor.h | 2 --
 include/linux/processor.h            | 9 ---------
 2 files changed, 11 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index ef573fe9873e..a9993e7a443b 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -346,8 +346,6 @@ static inline unsigned long __pack_fe01(unsigned int fpmode)
 
 #define spin_cpu_relax()	barrier()
 
-#define spin_cpu_yield()	spin_cpu_relax()
-
 #define spin_end()	HMT_medium()
 
 #define spin_until_cond(cond)					\
diff --git a/include/linux/processor.h b/include/linux/processor.h
index dbc952eec869..dc78bdc7079a 100644
--- a/include/linux/processor.h
+++ b/include/linux/processor.h
@@ -32,15 +32,6 @@
 #define spin_cpu_relax() cpu_relax()
 #endif
 
-/*
- * spin_cpu_yield may be called to yield (undirected) to the hypervisor if
- * necessary. This should be used if the wait is expected to take longer
- * than context switch overhead, but we can't sleep or do a directed yield.
- */
-#ifndef spin_cpu_yield
-#define spin_cpu_yield() cpu_relax_yield()
-#endif
-
 #ifndef spin_end
 #define spin_end()
 #endif
-- 
2.17.1

