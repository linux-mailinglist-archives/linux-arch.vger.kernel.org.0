Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3876E390187
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 15:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhEYNDO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 09:03:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41529 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232991AbhEYNDN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 09:03:13 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PCheeH098926;
        Tue, 25 May 2021 09:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=heKL48jhTKHG+0Zf7GGx5pc2nTO7LUu6qGQW5p/pJiw=;
 b=m+/4Csr7PprAgzVd7tgMLPdGfwtdhI119P5i2v1HdcKKhFo64NrJyc+6Ei9Ab7omwQZ7
 B0bLzR/CDFgvT4MysPx8NzkYJ0ids4UnNh+vdyJgBmssuvpPbhk1Z9Drn6NRW1xUGO/U
 xDp2cRIr6fh1CSmh2c+wpOBYck7IYDF1o1yBXkdra6DVuGc37u9FqO+lLCqrDo1ssJv8
 sY6fEw4WQJumzHHRbVrSE2w8qQQWn86xQSAb4ZpwArFnBNb8th6CttmtXV8fN5QeuxU1
 jeTWrwFRJm4yhs1aQw9N3Dub0dtJRkbkfhztnKekRGOFe6BijRefbpndUsF0aEfoM30j Fg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38s1g68kum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 09:01:35 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14PD0KAf002901;
        Tue, 25 May 2021 13:01:33 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 38s1r48016-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 13:01:33 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14PD1VqW28705204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 13:01:31 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A19BAE055;
        Tue, 25 May 2021 13:01:31 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2DB9AE04D;
        Tue, 25 May 2021 13:01:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 May 2021 13:01:30 +0000 (GMT)
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [PATCH 0/1] mm/debug_vm_pgtable: fix alignment for pmd/pud_advanced_tests()
Date:   Tue, 25 May 2021 15:00:42 +0200
Message-Id: <20210525130043.186290-1-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UaPDqLmwIwnWKJEQumuWDv4XxDdjtyjp
X-Proofpoint-ORIG-GUID: UaPDqLmwIwnWKJEQumuWDv4XxDdjtyjp
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_06:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 clxscore=1011 phishscore=0 mlxlogscore=683
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250077
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We sometimes see a "BUG task_struct (Not tainted): Padding overwritten"
on s390, directly after running debug_vm_pgtable. This is because of
wrong vaddr alignment in pmd/pud_advanced_tests(), leading to memory
corruption at least on s390, see patch description.

At first glance, other architectures do not seem to care about vaddr in
their xxx_get_and_clear() implementations, so they should not be affected.
One exception is sparc, where the addr is passed over to some tlb_batch
code, but I'm not sure what implication the wrongly aligned vaddr would
have in this case.

Also adding linux-arch, just to make sure.

Gerald Schaefer (1):
  mm/debug_vm_pgtable: fix alignment for pmd/pud_advanced_tests()

 mm/debug_vm_pgtable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1

