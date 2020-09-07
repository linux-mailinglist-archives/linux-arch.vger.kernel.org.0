Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAB4260427
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 20:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgIGSEl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 14:04:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19414 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728548AbgIGSEk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 14:04:40 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 087I2Kaj149186;
        Mon, 7 Sep 2020 14:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=llOokXYaeFuIqVieDq95v0tbRJZyTidIz682PTCYDAE=;
 b=DKUC1cxIdAyXGdb1LJMQxZCmyRckMOY3yH+BL2PIngvCYp9BUjlEt9kNIZfUGGbwFQPD
 bantvKYv38QTxd4IL4TDUhdMYgKl7HtCjI4wLqN0xpm18+BVow6mrg+vGE8uN95Pqb7K
 r3A/hRvxcHV07fQVv4bHCljFgqnzeJAwpg4w4cxTYbt9ypJOOXXa/60NC6bwYZ2xTJyI
 /wWSwGk1krs3AmfcV9p3i0tMaQ8847pcow1g3GsKVixL9i1Bvuu/CzewQKiyoiqtOg7x
 wMTvQsX3CLxuhJDnZskAgiskS7ZyMC1EO8GXmdBTdbeZjjPLW3zmvsr58bQCVaBm2qrv pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33dsgfrbxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 14:03:16 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 087I2StQ149524;
        Mon, 7 Sep 2020 14:03:15 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33dsgfrbwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 14:03:15 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 087I39Cf010781;
        Mon, 7 Sep 2020 18:03:13 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 33c2a89kvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 18:03:13 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 087I3A7O64356840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Sep 2020 18:03:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDA974203F;
        Mon,  7 Sep 2020 18:03:10 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B683442045;
        Mon,  7 Sep 2020 18:03:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Sep 2020 18:03:09 +0000 (GMT)
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-x86 <x86@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [RFC PATCH v2 3/3] mm: make generic pXd_addr_end() macros inline functions
Date:   Mon,  7 Sep 2020 20:00:58 +0200
Message-Id: <20200907180058.64880-4-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_11:2020-09-07,2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxlogscore=950 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070168
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Alexander Gordeev <agordeev@linux.ibm.com>

Since pXd_addr_end() macros take pXd page-table entry as a
parameter it makes sense to check the entry type on compile.
Even though most archs do not make use of page-table entries
in pXd_addr_end() calls, checking the type in traversal code
paths could help to avoid subtle bugs.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
---
 include/linux/pgtable.h | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 67ebc22cf83d..d9e7d16c2263 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -656,31 +656,35 @@ static inline int arch_unmap_one(struct mm_struct *mm,
  */
 
 #ifndef pgd_addr_end
-#define pgd_addr_end(pgd, addr, end)					\
-({	unsigned long __boundary = ((addr) + PGDIR_SIZE) & PGDIR_MASK;	\
-	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
-})
+#define pgd_addr_end pgd_addr_end
+static inline unsigned long pgd_addr_end(pgd_t pgd, unsigned long addr, unsigned long end)
+{	unsigned long __boundary = (addr + PGDIR_SIZE) & PGDIR_MASK;
+	return (__boundary - 1 < end - 1) ? __boundary : end;
+}
 #endif
 
 #ifndef p4d_addr_end
-#define p4d_addr_end(p4d, addr, end)					\
-({	unsigned long __boundary = ((addr) + P4D_SIZE) & P4D_MASK;	\
-	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
-})
+#define p4d_addr_end p4d_addr_end
+static inline unsigned long p4d_addr_end(p4d_t p4d, unsigned long addr, unsigned long end)
+{	unsigned long __boundary = (addr + P4D_SIZE) & P4D_MASK;
+	return (__boundary - 1 < end - 1) ? __boundary : end;
+}
 #endif
 
 #ifndef pud_addr_end
-#define pud_addr_end(pud, addr, end)					\
-({	unsigned long __boundary = ((addr) + PUD_SIZE) & PUD_MASK;	\
-	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
-})
+#define pud_addr_end pud_addr_end
+static inline unsigned long pud_addr_end(pud_t pud, unsigned long addr, unsigned long end)
+{	unsigned long __boundary = (addr + PUD_SIZE) & PUD_MASK;
+	return (__boundary - 1 < end - 1) ? __boundary : end;
+}
 #endif
 
 #ifndef pmd_addr_end
-#define pmd_addr_end(pmd, addr, end)					\
-({	unsigned long __boundary = ((addr) + PMD_SIZE) & PMD_MASK;	\
-	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
-})
+#define pmd_addr_end pmd_addr_end
+static inline unsigned long pmd_addr_end(pmd_t pmd, unsigned long addr, unsigned long end)
+{	unsigned long __boundary = (addr + PMD_SIZE) & PMD_MASK;
+	return (__boundary - 1 < end - 1) ? __boundary : end;
+}
 #endif
 
 /*
-- 
2.17.1

