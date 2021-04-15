Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9AF360993
	for <lists+linux-arch@lfdr.de>; Thu, 15 Apr 2021 14:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhDOMhd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 08:37:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230526AbhDOMhc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Apr 2021 08:37:32 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13FCXsVF099429;
        Thu, 15 Apr 2021 08:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=HMPYMkryMb2kTZkA18o3q6gtYsEChN9GPADDwYneUJ0=;
 b=WmrFK5cwrCV6VF0rndsxi4BBSO9Hjv3sMqQJ5LqrTUJhDt1CBrMM7P8kYTBwlsQW9Ng8
 ouxCQLh6ncf68dH30vp6oZhkD7sa/oxXr8aDS/52TvSzEJRoBOBHjHbsS/4WfFBqB1Jj
 JG6bpUGOd3vf0UmMYmGlPzN2Z+hrlVsgYlUmi0FA0/2SQYNbh/0YI1OKvUZMFZpZhv/a
 7gdWmKoRBtaRrXV2/C2XD9fX4BfNupIAKlNVSUUEfZUZ6iGTjgoGchk8Bm65xhF4/L87
 ZiW6IojzqBLix4JevcfKDWm4dQmlwmcxET5egi3JgFo7k6uCA0d5NlQ7CEKRUQtef208 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37x46xsk10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 08:37:05 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13FCZ0hB107550;
        Thu, 15 Apr 2021 08:37:05 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37x46xsk04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 08:37:05 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13FCYpUa030008;
        Thu, 15 Apr 2021 12:37:03 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 37u3n8a2wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 12:37:03 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13FCacgT34472320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 12:36:38 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F55EA405F;
        Thu, 15 Apr 2021 12:37:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B22B2A4062;
        Thu, 15 Apr 2021 12:37:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 15 Apr 2021 12:37:00 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 1/2] sparc: explicitly set PCI_IOBASE to 0
Date:   Thu, 15 Apr 2021 14:36:59 +0200
Message-Id: <20210415123700.3030728-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415123700.3030728-1-schnelle@linux.ibm.com>
References: <20210415123700.3030728-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UH8Oq1wFhxxs2JuaBJUiGztD2skqcCnW
X-Proofpoint-ORIG-GUID: 4WEs6BoKg6j-ubOXxz_x3y0rpGy1Wz8x
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_04:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 impostorscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxlogscore=899 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150084
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Instead of relying on the fallback in asm-generic/io.h which sets
PCI_IOBASE 0 if it is not defined set it explicitly.

Link: https://lore.kernel.org/lkml/CAK8P3a3PK9zyeP4ymELtc2ZYnymECoACiigw9Za+pvSJpCk5=g@mail.gmail.com/
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/sparc/include/asm/io.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sparc/include/asm/io.h b/arch/sparc/include/asm/io.h
index 2eefa526b38f..100992ba1317 100644
--- a/arch/sparc/include/asm/io.h
+++ b/arch/sparc/include/asm/io.h
@@ -1,6 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef ___ASM_SPARC_IO_H
 #define ___ASM_SPARC_IO_H
+
+/* On LEON I/O Space is accessed through low iomem */
+#define PCI_IOBASE ((void __iomem *)0)
+
 #if defined(__sparc__) && defined(__arch64__)
 #include <asm/io_64.h>
 #else
-- 
2.25.1

