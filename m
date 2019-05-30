Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9BE2FE3F
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 16:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfE3Oni (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 10:43:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727048AbfE3Omf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:42:35 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEe1Tr091608
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:34 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stgm11rw1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:33 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:42:32 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 15:42:27 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UEgPv538011120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 14:42:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A02F0B2079;
        Thu, 30 May 2019 14:42:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E17DB205F;
        Thu, 30 May 2019 14:42:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 14:42:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3F37216C8EA8; Thu, 30 May 2019 07:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 32/33] tools/memory-model: Add checktheselitmus.sh to run specified litmus tests
Date:   Thu, 30 May 2019 07:42:24 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530144202.GA26201@linux.ibm.com>
References: <20190530144202.GA26201@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053014-0072-0000-0000-000004354C36
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210779; UDB=6.00636154; IPR=6.00991814;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 14:42:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053014-0073-0000-0000-00004C6B56B9
Message-Id: <20190530144225.27624-32-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300105
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commit adds a checktheselitmus.sh script that runs the litmus tests
specified on the command line.  This is useful for verifying fixes to
specific litmus tests.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/README             |  8 ++++
 .../memory-model/scripts/checktheselitmus.sh  | 43 +++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100755 tools/memory-model/scripts/checktheselitmus.sh

diff --git a/tools/memory-model/scripts/README b/tools/memory-model/scripts/README
index 0e29a52044c1..cc2c4e5be9ec 100644
--- a/tools/memory-model/scripts/README
+++ b/tools/memory-model/scripts/README
@@ -27,6 +27,14 @@ checklitmushist.sh
 checklitmus.sh
 
 	Check a single litmus test against its "Result:" expected result.
+	Not intended to for manual use.
+
+checktheselitmus.sh
+
+	Check the specified list of litmus tests against their "Result:"
+	expected results.  This takes optional parseargs.sh arguments,
+	followed by "--" followed by pathnames starting from the current
+	directory.
 
 cmplitmushist.sh
 
diff --git a/tools/memory-model/scripts/checktheselitmus.sh b/tools/memory-model/scripts/checktheselitmus.sh
new file mode 100755
index 000000000000..10eeb5ecea6d
--- /dev/null
+++ b/tools/memory-model/scripts/checktheselitmus.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Invokes checklitmus.sh on its arguments to run the specified litmus
+# test and pass judgment on the results.
+#
+# Usage:
+#	checktheselitmus.sh -- [ file1.litmus [ file2.litmus ... ] ]
+#
+# Run this in the directory containing the memory model, specifying the
+# pathname of the litmus test to check.  The usual parseargs.sh arguments
+# can be specified prior to the "--".
+#
+# This script is intended for use with pathnames that start from the
+# tools/memory-model directory.  If some of the pathnames instead start at
+# the root directory, they all must do so and the "--destdir /" parseargs.sh
+# argument must be specified prior to the "--".  Alternatively, some other
+# "--destdir" argument can be supplied as long as the needed subdirectories
+# are populated.
+#
+# Copyright IBM Corporation, 2018
+#
+# Author: Paul E. McKenney <paulmck@linux.ibm.com>
+
+. scripts/parseargs.sh
+
+ret=0
+for i in "$@"
+do
+	if scripts/checklitmus.sh $i
+	then
+		:
+	else
+		ret=1
+	fi
+done
+if test "$ret" -ne 0
+then
+	echo " ^^^ VERIFICATION MISMATCHES" 1>&2
+else
+	echo All litmus tests verified as was expected. 1>&2
+fi
+exit $ret
-- 
2.17.1

