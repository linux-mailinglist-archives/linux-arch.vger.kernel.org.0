Return-Path: <linux-arch+bounces-3543-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C489989FB74
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 17:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF2AB31400
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 15:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946D816EC13;
	Wed, 10 Apr 2024 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RBNh+tqa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB50816EBF3;
	Wed, 10 Apr 2024 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761849; cv=none; b=YHRsLiURS34CaQDbMvNNKRRhie53JdPiBwulGC97N0wrKdzg58ujAKyyLuD3YogM1RZWfWB1yiP7loSdqIpN7dDGnsJNxWkhWm1M9HgxmAUCWjeSVOp9RhdtXdsb5/z5ufC5gFUUOZ04N9DmNc5yTXiWRvjC8tomU/Vm9CezDUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761849; c=relaxed/simple;
	bh=m8eE0AcwzEs5wRNkzi5ro5vJAfqsbE5UexQ/HfZKWAY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jns02tMeOqB73+l9lpNUjwm2ky9HJ2PG76VLJxDFTwahKN1pNM/rhGdoFz7OekiUYo+lyR4LviWzQvafv1SMFnyvNz5i9kcVWMB5jgPZU91GsOF4kG2VhTFvhMVcuZWCrIdqHO45dLCQZN3PD0V6w1Yss5cLPX8askGy5PptN74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RBNh+tqa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43AF76LJ019812;
	Wed, 10 Apr 2024 15:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=S7Sh61Dwbw08Hj8QqXjKFpfPZZqM0K8Q6t/Sk/b6f4Y=;
 b=RBNh+tqaPKTIhKRa+KG5KVN8s36DSZb74fobi7BHt6HaQooIAqn/PnkXtM8BFDHjTW+T
 9Oe7e3W0pDJfG2AND0nSgmRwdo8D2aLCqQefluGkBM4m60b/Xvjk9mbd9+jKsgyYV2+w
 5FkVXCrQYAWjxIPBhKwF0Q+sSUwCop+qt7zi3kJBvvqlHJQa3qBjPZXmiolZNWRbKcdN
 T4+N/BMWsK/adOJnp3scBxfQIr7K/XywKizk6fCJK6s6IB0XFLJFRl51fxKxttjZ+OaV
 WT5jo+MQ6BycbKjoYZrj6u2Q5HzOZNrsemRJBGbHnfW8VAeGmLgM/M1pFcVm00xc6GuC GA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdw4n806d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 15:09:56 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43AF9uAj023241;
	Wed, 10 Apr 2024 15:09:56 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdw4n806a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 15:09:56 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43ACSJid016982;
	Wed, 10 Apr 2024 15:09:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbke2n0jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 15:09:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43AF9nam48562646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 15:09:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 265842004F;
	Wed, 10 Apr 2024 15:09:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 125DF2004B;
	Wed, 10 Apr 2024 15:09:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Apr 2024 15:09:49 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id CA30CE0301; Wed, 10 Apr 2024 17:09:48 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Weisbecker <frederic@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH v2 RESEND 0/5] sched/vtime: vtime.h headers cleanup
Date: Wed, 10 Apr 2024 17:09:43 +0200
Message-Id: <cover.1712760275.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 43tJPVhQ1qfmHz2XICzEeDqIzqiN8NXK
X-Proofpoint-ORIG-GUID: iPRydWYHzjU6SLaIr79RnupfQ4DzWgiA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 mlxlogscore=787 bulkscore=0 impostorscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404100109

Hi All,

There are no changes since the last post, just a re-send.

v2:
- patch 4: commit message reworded (Heiko)
- patch 5: vtime.h is removed from Kbuild scripts (PowerPC only) (Heiko)

v1:
Please find a small cleanup to vtime_task_switch() wiring.
I split it into smaller patches to allow separate PowerPC
vs s390 reviews. Otherwise patches 2+3 and 4+5 could have
been merged.

I tested it on s390 and compile-tested it on 32- and 64-bit
PowerPC and few other major architectures only, but it is
only of concern for CONFIG_VIRT_CPU_ACCOUNTING_NATIVE-capable
ones (AFAICT).

Thanks!


Alexander Gordeev (5):
  sched/vtime: remove confusing arch_vtime_task_switch() declaration
  sched/vtime: get rid of generic vtime_task_switch() implementation
  s390/vtime: remove unused __ARCH_HAS_VTIME_TASK_SWITCH leftover
  s390/irq,nmi: include <asm/vtime.h> header directly
  sched/vtime: do not include <asm/vtime.h> header

 arch/powerpc/include/asm/Kbuild    |  1 -
 arch/powerpc/include/asm/cputime.h | 13 -------------
 arch/powerpc/kernel/time.c         | 22 ++++++++++++++++++++++
 arch/s390/include/asm/vtime.h      |  2 --
 arch/s390/kernel/irq.c             |  1 +
 arch/s390/kernel/nmi.c             |  1 +
 include/asm-generic/vtime.h        |  1 -
 include/linux/vtime.h              |  5 -----
 kernel/sched/cputime.c             | 13 -------------
 9 files changed, 24 insertions(+), 35 deletions(-)
 delete mode 100644 include/asm-generic/vtime.h

-- 
2.40.1


