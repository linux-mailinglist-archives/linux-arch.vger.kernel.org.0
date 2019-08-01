Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEBE7E550
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2019 00:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389435AbfHAWUd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Aug 2019 18:20:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729750AbfHAWUd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Aug 2019 18:20:33 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MHrPT055448
        for <linux-arch@vger.kernel.org>; Thu, 1 Aug 2019 18:20:31 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u45u86cvk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 01 Aug 2019 18:20:31 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 1 Aug 2019 23:20:31 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Aug 2019 23:20:26 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MKPG655509320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:20:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A87A7B2066;
        Thu,  1 Aug 2019 22:20:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AB73B205F;
        Thu,  1 Aug 2019 22:20:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:20:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D859716C9A4A; Thu,  1 Aug 2019 15:20:26 -0700 (PDT)
Date:   Thu, 1 Aug 2019 15:20:26 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: [PATCH RFC memory-model 0/31] LKMM updates for review
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19080122-0052-0000-0000-000003E7745E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011535; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01240728; UDB=6.00654291; IPR=6.01022152;
 MB=3.00028000; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-01 22:20:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080122-0053-0000-0000-000061EE6D1A
Message-Id: <20190801222026.GA11315@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=706 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010234
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

This series contains LKMM updates:

1.	Make scripts be executable.

2-3.	Make LKMM scripts note timeouts instead of just saying that
	the validation was bad.

4.	Make LKMM scripts identify litmus-test typos and use of
	unsupported primitives instead of just saying that the validation
	was bad.

5.	Make LKMM scripts detect unconditional deadlocks.

6.	Fix email address on LKMM scripts.

7-29.	Leverage Boqun Feng's C-to-assembly litmus-test-translation
	capability to allow verifying LKMM against hardware models for
	checkalllitmus.sh.  This is a work in progress.

30.	Use cumul-fence instead of fence in ->prop example, courtesy
	of Joel Fernandes.

31.	Update the informal documentation, courtesy of Andrea Parri.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/explanation.txt |   53 +++++++--------
 README                        |   18 ++---
 litmus-tests/.gitignore       |    4 -
 scripts/README                |   16 +++-
 scripts/checkalllitmus.sh     |   29 ++++----
 scripts/checkghlitmus.sh      |   11 +--
 scripts/checklitmus.sh        |  101 ++++++++++++-----------------
 scripts/checklitmushist.sh    |    2 
 scripts/checktheselitmus.sh   |   43 ++++++++++++
 scripts/cmplitmushist.sh      |   53 ++++++++++++++-
 scripts/hwfnseg.sh            |   20 +++++
 scripts/initlitmushist.sh     |    2 
 scripts/judgelitmus.sh        |  142 +++++++++++++++++++++++++++++++----------
 scripts/newlitmushist.sh      |    4 -
 scripts/parseargs.sh          |   21 ++++--
 scripts/runlitmus.sh          |  144 ++++++++++++++++++++++++++++++++----------
 scripts/runlitmushist.sh      |   30 +++++---
 scripts/simpletest.sh         |   35 ++++++++++
 18 files changed, 514 insertions(+), 214 deletions(-)

