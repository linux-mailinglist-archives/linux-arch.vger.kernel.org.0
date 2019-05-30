Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E35F2FE41
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 16:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfE3OoF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 10:44:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727255AbfE3Ome (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:42:34 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEdCDX124770
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:33 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2stgm11usu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:32 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:42:32 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 15:42:27 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UEgQ4433816692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 14:42:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4022B2071;
        Thu, 30 May 2019 14:42:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B050EB2075;
        Thu, 30 May 2019 14:42:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 14:42:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4484316C8EA9; Thu, 30 May 2019 07:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 33/33] tools/memory-model: Add data-race capabilities to judgelitmus.sh
Date:   Thu, 30 May 2019 07:42:25 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530144202.GA26201@linux.ibm.com>
References: <20190530144202.GA26201@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053014-0052-0000-0000-000003C911B4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011184; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210780; UDB=6.00636154; IPR=6.00991814;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 14:42:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053014-0053-0000-0000-0000611A0B65
Message-Id: <20190530144225.27624-33-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=649 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300105
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commit adds functionality to judgelitmus.sh to allow it to handle
both the "DATARACE" markers in the "Result:" comments in litmus tests
and the "Flag data-race" markers in LKMM output.  For C-language tests,
if either marker is present, the other must also be as well, at least for
litmus tests having a "Result:" comment.  If the LKMM output indicates
a data race, then failures of the Always/Sometimes/Never portion of the
"Result:" prediction are forgiven.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/judgelitmus.sh | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index ca9a19829d79..eaa2cc7d3b36 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -47,9 +47,27 @@ else
 	echo ' --- ' error: \"$LKMM_DESTDIR/$litmusout is not a readable file
 	exit 255
 fi
+if grep -q '^Flag data-race$' "$LKMM_DESTDIR/$litmusout"
+then
+	datarace_modeled=1
+fi
 if grep -q '^ \* Result: ' $litmus
 then
 	outcome=`grep -m 1 '^ \* Result: ' $litmus | awk '{ print $3 }'`
+	if grep -m1 '^ \* Result: .* DATARACE' $litmus
+	then
+		datarace_predicted=1
+	fi
+	if test -n "$datarace_predicted" -a -z "$datarace_modeled" -a -z "$LKMM_HW_MAP_FILE"
+	then
+		echo '!!! Predicted data race not modeled' $litmus
+		exit 252
+	elif test -z "$datarace_predicted" -a -n "$datarace_modeled"
+	then
+		# Note that hardware models currently don't model data races
+		echo '!!! Unexpected data race modeled' $litmus
+		exit 253
+	fi
 elif test -n "$LKMM_HW_MAP_FILE" && grep -q '^Observation' $LKMM_DESTDIR/$lkmmout > /dev/null 2>&1
 then
 	outcome=`grep -m 1 '^Observation ' $LKMM_DESTDIR/$lkmmout | awk '{ print $3 }'`
@@ -114,7 +132,7 @@ elif grep '^Observation' $LKMM_DESTDIR/$litmusout | grep -q $outcome || test "$o
 then
 	ret=0
 else
-	if test -n "$LKMM_HW_MAP_FILE" -a "$outcome" = Sometimes
+	if test \( -n "$LKMM_HW_MAP_FILE" -a "$outcome" = Sometimes \) -o -n "$datarace_modeled"
 	then
 		flag="--- Forgiven"
 		ret=0
-- 
2.17.1

