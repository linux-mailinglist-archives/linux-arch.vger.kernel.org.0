Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC7C67E57F
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2019 00:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfHAWWb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Aug 2019 18:22:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389505AbfHAWVN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Aug 2019 18:21:13 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MHOFT057650;
        Thu, 1 Aug 2019 18:21:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u486f16j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:20:59 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71MHpcR059087;
        Thu, 1 Aug 2019 18:20:59 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u486f16hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:20:59 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71MJrom006661;
        Thu, 1 Aug 2019 22:20:58 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03wdc.us.ibm.com with ESMTP id 2u0e85w5pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 22:20:58 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MKwjm49545536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:20:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CFF8B206A;
        Thu,  1 Aug 2019 22:20:58 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDE83B2071;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0BEA516C9A4F; Thu,  1 Aug 2019 15:20:59 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 26/31] tools/memory-model: Add checktheselitmus.sh to run specified litmus tests
Date:   Thu,  1 Aug 2019 15:20:51 -0700
Message-Id: <20190801222056.12144-26-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801222026.GA11315@linux.ibm.com>
References: <20190801222026.GA11315@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010234
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

