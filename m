Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A01714D688
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jan 2020 07:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgA3Gho (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jan 2020 01:37:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57066 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725935AbgA3Gho (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Jan 2020 01:37:44 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00U6ai4r085309
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 01:37:42 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xtmmy1k3g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 01:37:42 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Thu, 30 Jan 2020 06:37:41 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Jan 2020 06:37:36 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00U6bZ4c26476672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 06:37:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AA7F4C046;
        Thu, 30 Jan 2020 06:37:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DC844C04A;
        Thu, 30 Jan 2020 06:37:32 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Jan 2020 06:37:32 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     shuah@kernel.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-mm@kvack.org, fweimer@redhat.com,
        dave.hansen@intel.com, linuxram@us.ibm.com, mhocko@kernel.org,
        mingo@redhat.com, aneesh.kumar@linux.ibm.com,
        bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au
Subject: [PATCH v18 09/24] selftests/vm/pkeys: Fix assertion in pkey_disable_set/clear()
Date:   Thu, 30 Jan 2020 12:06:51 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20013006-0016-0000-0000-000002E1F2E6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013006-0017-0000-0000-00003344BBBF
Message-Id: <90e6851e1c71696f03cfa2c71377f0542d8dbd8d.1580365432.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-30_01:2020-01-28,2020-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=558
 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1911200001 definitions=main-2001300042
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>

In some cases, a pkey's bits need not necessarily change
in a way that the value of the pkey register increases
when performing a pkey_disable_set() or decreases when
performing a pkey_disable_clear().

For example, on powerpc, if a pkey's current state is
PKEY_DISABLE_ACCESS and we perform a pkey_write_disable()
on it, the bits still remain the same. We will observe
something similar when the pkey's current state is 0 and
a pkey_access_enable() is performed on it.

Either case would cause some assertions to fail. This
fixes the problem.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 4b1ddb526228..7fd52d5c4bfd 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -400,7 +400,7 @@ void pkey_disable_set(int pkey, int flags)
 	dprintf1("%s(%d) pkey_reg: 0x%016llx\n",
 		__func__, pkey, read_pkey_reg());
 	if (flags)
-		pkey_assert(read_pkey_reg() > orig_pkey_reg);
+		pkey_assert(read_pkey_reg() >= orig_pkey_reg);
 	dprintf1("END<---%s(%d, 0x%x)\n", __func__,
 		pkey, flags);
 }
@@ -431,7 +431,7 @@ void pkey_disable_clear(int pkey, int flags)
 	dprintf1("%s(%d) pkey_reg: 0x%016llx\n", __func__,
 			pkey, read_pkey_reg());
 	if (flags)
-		assert(read_pkey_reg() < orig_pkey_reg);
+		assert(read_pkey_reg() <= orig_pkey_reg);
 }
 
 void pkey_write_allow(int pkey)
-- 
2.17.1

