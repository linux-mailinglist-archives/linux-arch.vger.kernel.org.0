Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C04B379177
	for <lists+linux-arch@lfdr.de>; Mon, 10 May 2021 16:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbhEJOzW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 May 2021 10:55:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240278AbhEJOx4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 May 2021 10:53:56 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14AEoIdq184371;
        Mon, 10 May 2021 10:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=mp/51zQTwU0ypyrfGm7d48XnTdWhVBfdFjEkqW1sSTI=;
 b=oq69rh0YK6QO9Vj4ywqahWisbHFpUHdMJAoafl724vqZbwP/rLnDOW0KQizIskhiAgAA
 9osKksohAh+yD0sKHP4dquUDqzUq4xc32O17ZcbM3IyEP2Hyekr4W0A9CBKPVAFZ8WqP
 OJX0eBv/jKtaSjh/zPtcxELur0+xnYCd3KfYr+n6216jb/dt54a788enZxvbP+qEX3Tb
 1s0Uje/NJzFTufnc1uGENJcqKpW2QwN08bYLnu5bh14lAEpBJz09gD09T3aYfS7BumPq
 +2ieEynkW8nmQ6dCi4CX0cTn5mRjHwu5GMebgczRROXBHj7Hp11B35Flb5oS3m7s8tzs zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38f6xt01ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 10:52:39 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14AEpp51190897;
        Mon, 10 May 2021 10:52:39 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38f6xt01a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 10:52:39 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14AEmBHM025927;
        Mon, 10 May 2021 14:52:37 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 38dhwh91vr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 14:52:37 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14AEqZIE37814710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 14:52:35 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18BFB52050;
        Mon, 10 May 2021 14:52:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id AA76452051;
        Mon, 10 May 2021 14:52:34 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, sparclinux@vger.kernel.org
Subject: [PATCH v6 1/3] sparc: explicitly set PCI_IOBASE to 0
Date:   Mon, 10 May 2021 16:52:32 +0200
Message-Id: <20210510145234.594814-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210510145234.594814-1-schnelle@linux.ibm.com>
References: <20210510145234.594814-1-schnelle@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gY60jVdT9BfNYmq5tr-k84tUJE5i3gZe
X-Proofpoint-GUID: khRcgKtN16v846p8gRFfwt4YMf7XtDTg
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-10_07:2021-05-10,2021-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100105
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Instead of relying on the fallback in asm-generic/io.h which sets
PCI_IOBASE 0 if it is not defined set it explicitly.

Link: https://lore.kernel.org/lkml/CAK8P3a3PK9zyeP4ymELtc2ZYnymECoACiigw9Za+pvSJpCk5=g@mail.gmail.com/
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/sparc/include/asm/io.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/sparc/include/asm/io.h b/arch/sparc/include/asm/io.h
index 2eefa526b38f..c019e50702c1 100644
--- a/arch/sparc/include/asm/io.h
+++ b/arch/sparc/include/asm/io.h
@@ -1,6 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef ___ASM_SPARC_IO_H
 #define ___ASM_SPARC_IO_H
+
+/*
+ * On LEON PCI addresses below 64k are converted to IO accesses.
+ * io_remap_xxx() returns a kernel virtual address in the PCI window so
+ * inb() doesn't need to add an offset.
+ */
+#define PCI_IOBASE ((void __iomem *)0)
+
 #if defined(__sparc__) && defined(__arch64__)
 #include <asm/io_64.h>
 #else
-- 
2.25.1

