Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C11A2FE0F
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 16:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfE3OmJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 10:42:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55328 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725961AbfE3OmJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:42:09 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEdCDJ124770
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:08 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2stgm11u6h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:07 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:42:07 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 15:42:01 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UEg0Zq30278116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 14:42:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E02B0B2066;
        Thu, 30 May 2019 14:42:00 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2366B2064;
        Thu, 30 May 2019 14:42:00 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 14:42:00 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 83ADB16C09D5; Thu, 30 May 2019 07:42:02 -0700 (PDT)
Date:   Thu, 30 May 2019 07:42:02 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: [PATCH RFC memory-model 0/33] LKMM updates for review
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19053014-2213-0000-0000-00000397F31A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210779; UDB=6.00636154; IPR=6.00991814;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 14:42:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053014-2214-0000-0000-00005EA2F2BB
Message-Id: <20190530144202.GA26201@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=847 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300105
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

This series contains LKMM updates:

1-3.	Add plain C-language accesses to the model, including data-race
	detection, courtesy of Alan Stern.

4.	Make scripts be executable.

5.	Explain ordering provided by smp_mb__{before,after}_atomic(),
	courtesy of Alan Stern.

6.	Fix comment in MP+poonceonces.litmus, courtesy of Andrea Parri.

7.	Make documentation referencing "herd" instead reference the
	actual name of the command, "herd7", courtesy of Andrea Parri.

8-9.	Make LKMM scripts note timeouts instead of just saying that
	the validation was bad.

10.	Make LKMM scripts identify litmus-test typos and use of
	unsupported primitives instead of just saying that the validation
	was bad.

11.	Make LKMM scripts detect unconditional deadlocks.

12.	Fix email address on LKMM scripts.

13-33.	Leverage Boqun Feng's C-to-assembly litmus-test-translation
	capability to allow verifying LKMM against hardware models for
	checkalllitmus.sh.  This is a work in progress.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/atomic_t.txt                            |   17 +-
 tools/memory-model/linux-kernel.bell                  |    6 
 tools/memory-model/linux-kernel.cat                   |   82 ++++++++--
 tools/memory-model/linux-kernel.def                   |    1 
 tools/memory-model/litmus-tests/.gitignore            |    4 
 tools/memory-model/litmus-tests/MP+poonceonces.litmus |    2 
 tools/memory-model/litmus-tests/README                |    2 
 tools/memory-model/lock.cat                           |    2 
 tools/memory-model/scripts/README                     |   20 +-
 tools/memory-model/scripts/checkalllitmus.sh          |   31 +--
 tools/memory-model/scripts/checkghlitmus.sh           |   11 -
 tools/memory-model/scripts/checklitmus.sh             |  103 +++++--------
 tools/memory-model/scripts/checklitmushist.sh         |    2 
 tools/memory-model/scripts/checktheselitmus.sh        |   43 +++++
 tools/memory-model/scripts/cmplitmushist.sh           |   53 ++++++
 tools/memory-model/scripts/hwfnseg.sh                 |   20 ++
 tools/memory-model/scripts/initlitmushist.sh          |    2 
 tools/memory-model/scripts/judgelitmus.sh             |  136 +++++++++++++----
 tools/memory-model/scripts/newlitmushist.sh           |    4 
 tools/memory-model/scripts/parseargs.sh               |   23 ++
 tools/memory-model/scripts/runlitmus.sh               |  142 ++++++++++++++----
 tools/memory-model/scripts/runlitmushist.sh           |   32 ++--
 tools/memory-model/scripts/simpletest.sh              |   35 ++++
 23 files changed, 573 insertions(+), 200 deletions(-)

