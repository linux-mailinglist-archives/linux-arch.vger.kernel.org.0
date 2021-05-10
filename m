Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D628E377E8A
	for <lists+linux-arch@lfdr.de>; Mon, 10 May 2021 10:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhEJItH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 May 2021 04:49:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230186AbhEJItG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 May 2021 04:49:06 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14A8Y5Jw092729;
        Mon, 10 May 2021 04:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=evXVASPNHYxBuNpGpwUb76ljx34WoISjJiXB/0dEjGk=;
 b=ORnm0lLUxN1YpQA8HlyRcBFkf6KoxCic7Ncm8AuCh7Ot/rwnQeNSElhA+xQUd+KwPlOU
 tNJnPyTQhDuLvR9morTthwfn25Et6eAeYxvNhj0ePcJ1JlIkRbSFYTXsGFn8+Yf96Xn+
 Dp3yhj3Qb7MJ3SUbvPx/FfvxB/fp/sg12uTzyIi6CbAaZskbXfRhp1SrklpAUHl3kJ8b
 ovtSXGMaaABo0/lBCxZEFK7x4b+SF731rTtHCuHokrEBBud2VkU2Xw4ouIWXZSv4i0st
 EPVWd8cFv6MAczXHErRCCnyJnox644XcdG19p0FqQXj4kGEWbSSB4P5vxdxe7tmOiu4J mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38f156ru71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 04:47:49 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14A8h31t128637;
        Mon, 10 May 2021 04:47:49 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38f156ru6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 04:47:49 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14A8g7hA014602;
        Mon, 10 May 2021 08:47:47 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 38dhwh8skc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 08:47:47 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14A8ljAw29884800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 08:47:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39B934C044;
        Mon, 10 May 2021 08:47:45 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAA344C04A;
        Mon, 10 May 2021 08:47:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 May 2021 08:47:44 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, sparclinux@vger.kernel.org
Subject: [PATCH v5--cover-letter 2/3] risc-v: Use generic io.h helpers for nommu
Date:   Mon, 10 May 2021 10:47:42 +0200
Message-Id: <20210510084743.1850777-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210510084743.1850777-1-schnelle@linux.ibm.com>
References: <20210510084743.1850777-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mv9os6CnoMAOgvLf5XHalhXFL_P_nZND
X-Proofpoint-ORIG-GUID: I0yuNbIY3BzKJLWW9ZbQ3sjB9fNQbOwV
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-10_04:2021-05-10,2021-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxlogscore=967 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100061
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Niklas Schnelle <niklas@komani.de>

Without MMU support PCI_IOBASE is left undefined because PCI_IO_END is
VMEMMAP_START. Nevertheless the in*()/out*() helper macros are left
defined with uses of PCI_IOBASE.

At the moment this only compiles because asm-generic/io.h defines
PCI_IOBASE as 0 if it is undefined and so at macro expansion PCI_IOBASE
is defined. This leads to compilation errors when asm-generic/io.h is
changed to leave PCI_IOBASE undefined.  More importantly it is currently
broken at runtime, as accessing a fixed I/O port number of an ISA device
on NOMMU RISC-V would turn into a NULL pointer dereference.

Instead only define the in*()/out*() helper macros with MMU support and
fall back to the asm-generic/io.h helper stubs otherwise.

Signed-off-by: Niklas Schnelle <niklas@komani.de>
---
 arch/riscv/include/asm/io.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index c025a746a148..31a8b98c0f13 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -23,12 +23,12 @@
 #include <asm/mmio.h>
 
 /*
- *  I/O port access constants.
+ *  I/O port access constants. Without MMU support leave PCI_IOBASE undefined
+ *  and fall back to generic stubs for I/O access routines.
  */
 #ifdef CONFIG_MMU
 #define IO_SPACE_LIMIT		(PCI_IO_SIZE - 1)
 #define PCI_IOBASE		((void __iomem *)PCI_IO_START)
-#endif /* CONFIG_MMU */
 
 /*
  * Emulation routines for the port-mapped IO space used by some PCI drivers.
@@ -145,6 +145,7 @@ __io_writes_outs(writes, u64, q, __io_bw(), __io_aw())
 __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
 #define outsq(addr, buffer, count) __outsq((void __iomem *)addr, buffer, count)
 #endif
+#endif /* CONFIG_MMU */
 
 #include <asm-generic/io.h>
 
-- 
2.25.1

