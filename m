Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7187B13D48B
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jan 2020 07:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgAPGqO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jan 2020 01:46:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10710 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729774AbgAPGqO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Jan 2020 01:46:14 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00G6io87110984;
        Thu, 16 Jan 2020 01:45:58 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xhgs7h3cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jan 2020 01:45:58 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00G6fvw5030770;
        Thu, 16 Jan 2020 06:45:57 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03dal.us.ibm.com with ESMTP id 2xf74yxukv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jan 2020 06:45:57 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00G6juBN59375918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 06:45:56 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0C6F6E052;
        Thu, 16 Jan 2020 06:45:55 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B33E6E050;
        Thu, 16 Jan 2020 06:45:52 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.45.56])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 16 Jan 2020 06:45:52 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, will@kernel.org,
        mpe@ellerman.id.au
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v4 3/9] asm-generic/tlb: Avoid potential double flush
Date:   Thu, 16 Jan 2020 12:15:25 +0530
Message-Id: <20200116064531.483522-4-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200116064531.483522-1-aneesh.kumar@linux.ibm.com>
References: <20200116064531.483522-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_02:2020-01-16,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=2 mlxlogscore=914 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001160055
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Aneesh reported that:

	tlb_flush_mmu()
	  tlb_flush_mmu_tlbonly()
	    tlb_flush()			<-- #1
	  tlb_flush_mmu_free()
	    tlb_table_flush()
	      tlb_table_invalidate()
		tlb_flush_mmu_tlbonly()
		  tlb_flush()		<-- #2

does two TLBIs when tlb->fullmm, because __tlb_reset_range() will not
clear tlb->end in that case.

Observe that any caller to __tlb_adjust_range() also sets at least one
of the tlb->freed_tables || tlb->cleared_p* bits, and those are
unconditionally cleared by __tlb_reset_range().

Change the condition for actually issuing TLBI to having one of those
bits set, as opposed to having tlb->end != 0.

Reported-by: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/asm-generic/tlb.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 9e22ac369d1d..b36b3bef5661 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -402,7 +402,12 @@ tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
 
 static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 {
-	if (!tlb->end)
+	/*
+	 * Anything calling __tlb_adjust_range() also sets at least one of
+	 * these bits.
+	 */
+	if (!(tlb->freed_tables || tlb->cleared_ptes || tlb->cleared_pmds ||
+	      tlb->cleared_puds || tlb->cleared_p4ds))
 		return;
 
 	tlb_flush(tlb);
-- 
2.24.1

