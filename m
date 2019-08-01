Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 260757E582
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2019 00:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389498AbfHAWVL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Aug 2019 18:21:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45734 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389491AbfHAWVL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Aug 2019 18:21:11 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MGvO4016113;
        Thu, 1 Aug 2019 18:20:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u488k91uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:20:59 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71MHl1I018325;
        Thu, 1 Aug 2019 18:20:59 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u488k91u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 18:20:59 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x71MJlVc026752;
        Thu, 1 Aug 2019 22:20:58 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 2u0e87h3qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 22:20:58 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MKvT631785384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:20:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FD50B2065;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BD01B2066;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:20:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8245B16C9A4A; Thu,  1 Aug 2019 15:20:58 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 01/31] tools/memory-model: Make scripts be executable
Date:   Thu,  1 Aug 2019 15:20:26 -0700
Message-Id: <20190801222056.12144-1-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801222026.GA11315@linux.ibm.com>
References: <20190801222026.GA11315@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=831 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010234
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commit simplifies life a bit by making all of the scripts in
tools/memory-model/scripts be executable.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/checkghlitmus.sh   | 0
 tools/memory-model/scripts/checklitmushist.sh | 0
 tools/memory-model/scripts/cmplitmushist.sh   | 0
 tools/memory-model/scripts/initlitmushist.sh  | 0
 tools/memory-model/scripts/judgelitmus.sh     | 0
 tools/memory-model/scripts/newlitmushist.sh   | 0
 tools/memory-model/scripts/parseargs.sh       | 0
 tools/memory-model/scripts/runlitmushist.sh   | 0
 8 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tools/memory-model/scripts/checkghlitmus.sh
 mode change 100644 => 100755 tools/memory-model/scripts/checklitmushist.sh
 mode change 100644 => 100755 tools/memory-model/scripts/cmplitmushist.sh
 mode change 100644 => 100755 tools/memory-model/scripts/initlitmushist.sh
 mode change 100644 => 100755 tools/memory-model/scripts/judgelitmus.sh
 mode change 100644 => 100755 tools/memory-model/scripts/newlitmushist.sh
 mode change 100644 => 100755 tools/memory-model/scripts/parseargs.sh
 mode change 100644 => 100755 tools/memory-model/scripts/runlitmushist.sh

diff --git a/tools/memory-model/scripts/checkghlitmus.sh b/tools/memory-model/scripts/checkghlitmus.sh
old mode 100644
new mode 100755
diff --git a/tools/memory-model/scripts/checklitmushist.sh b/tools/memory-model/scripts/checklitmushist.sh
old mode 100644
new mode 100755
diff --git a/tools/memory-model/scripts/cmplitmushist.sh b/tools/memory-model/scripts/cmplitmushist.sh
old mode 100644
new mode 100755
diff --git a/tools/memory-model/scripts/initlitmushist.sh b/tools/memory-model/scripts/initlitmushist.sh
old mode 100644
new mode 100755
diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
old mode 100644
new mode 100755
diff --git a/tools/memory-model/scripts/newlitmushist.sh b/tools/memory-model/scripts/newlitmushist.sh
old mode 100644
new mode 100755
diff --git a/tools/memory-model/scripts/parseargs.sh b/tools/memory-model/scripts/parseargs.sh
old mode 100644
new mode 100755
diff --git a/tools/memory-model/scripts/runlitmushist.sh b/tools/memory-model/scripts/runlitmushist.sh
old mode 100644
new mode 100755
-- 
2.17.1

