Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2456243C14
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2019 17:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfFMPdz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jun 2019 11:33:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728304AbfFMKfT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Jun 2019 06:35:19 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DATYIL138645
        for <linux-arch@vger.kernel.org>; Thu, 13 Jun 2019 06:35:17 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t3jchejhn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 13 Jun 2019 06:35:17 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 13 Jun 2019 11:35:15 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Jun 2019 11:35:12 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5DAZB2M51052778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 10:35:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEC1CAE057;
        Thu, 13 Jun 2019 10:35:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90CEBAE045;
        Thu, 13 Jun 2019 10:35:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jun 2019 10:35:10 +0000 (GMT)
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCHv2 0/3] improve wait logic of stop_machine
Date:   Thu, 13 Jun 2019 12:35:07 +0200
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19061310-0008-0000-0000-000002F36B1D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061310-0009-0000-0000-00002260707B
Message-Id: <20190613103510.60529-1-heiko.carstens@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=753 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130082
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

FWIW, it would be nice to get some Acks.

Given that this patch set touches common code only in a way that
shouldn't have any effect on any architecture except s390, I'll add
this to the s390 tree, unless somebody objects.

RFC->v2:
  Use cpumask_next_wrap as suggested by Peter Zijlstra.

RFC:

The stop_machine loop to advance the state machine and to wait for all
affected CPUs to check-in calls cpu_relax_yield in a tight loop until
the last missing CPUs acknowledged the state transition.

On a virtual system where not all logical CPUs are backed by real CPUs
all the time it can take a while for all CPUs to check-in. With the
current definition of cpu_relax_yield on s390 a diagnose 0x44 is done
which tells the hypervisor to schedule *some* other CPU. That can be
any CPU and not necessarily one of the CPUs that need to run in order
to advance the state machine. This can lead to a pretty bad diagnose
0x44 storm until the last missing CPU finally checked-in.

Replace the undirected cpu_relax_yield based on diagnose 0x44 with an
architecture specific directed yield. Each CPU in the wait loop will
pick up the next CPU in the cpumask of stop_machine. The diagnose 0x9c
is used to tell the hypervisor to run this next CPU instead of the
current one. If there is only a limited number of real CPUs backing
the virtual CPUs we end up with the real CPUs passed around in a
round-robin fashion.

Patches 1 and 3 are just possible cleanups; the interesting part is
patch 2.

Heiko Carstens (2):
  processor: remove spin_cpu_yield
  processor: get rid of cpu_relax_yield

Martin Schwidefsky (1):
  s390: improve wait logic of stop_machine

 arch/powerpc/include/asm/processor.h |  2 --
 arch/s390/include/asm/processor.h    |  7 +------
 arch/s390/kernel/processor.c         | 19 +++++++++++++------
 arch/s390/kernel/smp.c               |  2 +-
 include/linux/processor.h            |  9 ---------
 include/linux/sched.h                |  4 ----
 include/linux/stop_machine.h         |  1 +
 kernel/stop_machine.c                | 19 ++++++++++++++-----
 8 files changed, 30 insertions(+), 33 deletions(-)

-- 
2.17.1

