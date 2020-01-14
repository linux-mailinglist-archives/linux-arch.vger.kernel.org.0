Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16CAB13A4C6
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2020 11:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgANKCY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 05:02:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbgANKCY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jan 2020 05:02:24 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EA2CpJ040439;
        Tue, 14 Jan 2020 05:02:12 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xh8d3evj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 05:02:12 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00EA06UR019477;
        Tue, 14 Jan 2020 10:02:07 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02wdc.us.ibm.com with ESMTP id 2xf750ahs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 10:02:07 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00EA26xA43254174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 10:02:06 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4ADB8C6059;
        Tue, 14 Jan 2020 10:02:06 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB083C6055;
        Tue, 14 Jan 2020 10:02:03 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.124.35.105])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 14 Jan 2020 10:02:03 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, will@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v3 4/9] asm-gemeric/tlb: Remove stray function declarations
Date:   Tue, 14 Jan 2020 15:31:40 +0530
Message-Id: <20200114100145.365527-5-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114100145.365527-1-aneesh.kumar@linux.ibm.com>
References: <20200114100145.365527-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_02:2020-01-13,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=597 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001140090
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

We removed the actual functions a while ago.

Fixes: 1808d65b55e4 ("asm-generic/tlb: Remove arch_tlb*_mmu()")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/asm-generic/tlb.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index b36b3bef5661..1a4cea5f95df 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -285,11 +285,7 @@ struct mmu_gather {
 #endif
 };
 
-void arch_tlb_gather_mmu(struct mmu_gather *tlb,
-	struct mm_struct *mm, unsigned long start, unsigned long end);
 void tlb_flush_mmu(struct mmu_gather *tlb);
-void arch_tlb_finish_mmu(struct mmu_gather *tlb,
-			 unsigned long start, unsigned long end, bool force);
 
 static inline void __tlb_adjust_range(struct mmu_gather *tlb,
 				      unsigned long address,
-- 
2.24.1

