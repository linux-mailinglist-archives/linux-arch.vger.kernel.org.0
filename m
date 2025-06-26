Return-Path: <linux-arch+bounces-12472-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0134EAEA10A
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 16:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1444E6A2445
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 14:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554622ECD32;
	Thu, 26 Jun 2025 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VPdNPhVb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22A22EAD18;
	Thu, 26 Jun 2025 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948654; cv=none; b=HeR0LG6qx48Gg+aCvTk4EfAE42JBcMrELiLPOSHjiPkG5QJvRnfryo2hr+cnvv0uR9p32gFRFXBMKUgDN7uCmSxuc4hS7K3PRegc4cox1T2VsmXyAnuR/5UPGTJoaR3/3lv39HnrnP5zZKG6rbsXa1MrHhVE4Iz19CpOmyc/r5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948654; c=relaxed/simple;
	bh=L8JBl46tQj2GAsdJIOnR0bzEZNqtdKwqi3HPNOgESs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J3n1jO1aWRpVXuEUaky6RzC0yK0BvabSm1x6wmNMr8dBVggL5WBJU7/tptmZ0uX3htkdlpqkZ5VD5mHXLy5zan/5fPmmfvkS9KvSduMRHEOyUQFvUVTnd9jnRo/I2t8aBu5gBb9FR4rY9Uyf9MPHTiRvsfpBzQm8W7XYB+AuYqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VPdNPhVb; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QCaX8Z021634;
	Thu, 26 Jun 2025 14:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=oM5QN1bTA2ARqyZQ
	7oZ4Jl0G6EnqLHk+PBXlHsrYz0Y=; b=VPdNPhVbizq0PbKPOE9IK6OwQvtCtMSN
	5TkHomMS2CrP5ZHzxc/O0NRwyvUx3K0ewAH8jwIiJ5qinnHgb1VkxWVoXKOcEBgd
	wgYhkENVI1nmOsnmHjx1XYwhNn38QS2gcCkRQIbeaa3lYUwTFrSRYuhcAg9Px/Fn
	kUjs2b8JF/Yza8ucjUH3aQauV8CpJArZpLfMzpxqIQ7DsBrlFUjxAAq8ufLUwXBk
	uifU1LumqVHWigJyGSA+rF9sHRVjMpeYOBebkTh/ypG31TrbYx35AuaXsuVX9ntW
	wlZpgUrkUi4+HFpE7Ck2o6N4QQXMNBekai277Jvde5ywL492DXvGZA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt5rvka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 14:37:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55QEKIcT019345;
	Thu, 26 Jun 2025 14:37:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehktk6wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 14:37:11 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55QEbABw013428;
	Thu, 26 Jun 2025 14:37:10 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ehktk6tv-1;
	Thu, 26 Jun 2025 14:37:10 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        lkmm@lists.linux.dev, linux-doc@vger.kernel.org
Subject: [PATCH 1/1] docs/memory-barriers.txt: Add wait_event_cmd() and wait_event_exclusive_cmd()
Date: Thu, 26 Jun 2025 16:37:05 +0200
Message-ID: <20250626143707.1533808-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506260123
X-Proofpoint-GUID: MkfSKuscW80Kz-Pb6bfVHXOzuccO-oZS
X-Authority-Analysis: v=2.4 cv=PMYP+eqC c=1 sm=1 tr=0 ts=685d5b18 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=M51BFTxLslgA:10 a=yPCof4ZbAAAA:8 a=eATuiTakoFPP2dfb7UwA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13216
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDEyNCBTYWx0ZWRfX2ix7oC6O+eik t0j65SIQuWXNKtWTth/IOos87DdxESTlbfNN3Qii/Rq98+NWhWePLiyjpwqcP0VfcNZl/4nH/dz BQelwjLvn0JoGMV1JZgCnqWL3i16pvbLwmhM6IFgqfRYDZBl6FL0fj7m8ZCVPCV9fqdVr5+uTQD
 6D3LgbG8988uJDU43NfgkZ2HBpCrnWksEaEGRkDmenVVlW3op7hpdne5y8ThVOn07qQaJ9nRGdM OzdasAiNnBOxX+g2eUtYABdLABV0hn55Aw7X4OpjoZIjIjeQqvqMGACjBAg3/k1fSHKtEh5QX5z 6qmC+CtmWEN24+P+Yhd7Oqp4Z97ClPGDxGUud1bCRR6nUcPhTYxDqQc71vlHfhbUFc1mhL7SDop
 zMHzaak8nViouAcEApHY/GHsG0D9jQ5/N2mxbhlpTgE+KWAf9qE2gD/NJBxU/F9EKp+Usa9m
X-Proofpoint-ORIG-GUID: MkfSKuscW80Kz-Pb6bfVHXOzuccO-oZS

Add said functions to the documentation and relate them to userspace's
pthread_cond_wait(). The latter because when searching for
functionality comparable to pthread_cond_wait(), it is very hard to
find wait_event_cmd().

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 Documentation/memory-barriers.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 93d58d9a428b8..d721e9be5a4f5 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -2192,6 +2192,8 @@ interpolate the memory barrier in the right place:
 	wait_event_timeout();
 	wait_on_bit();
 	wait_on_bit_lock();
+	wait_event_cmd();
+	wait_event_exclusive_cmd();
 
 
 Secondly, code that performs a wake up normally follows something like this:
@@ -2296,6 +2298,15 @@ and the waker should do:
 	event_indicated = 1;
 	wake_up(&event_wait_queue);
 
+Note that the wait_event_cmd() and wait_event_exclusive_cmd() are the
+kernel's polymorphic implementation of userspace's
+pthread_cond_wait().
+
+Using wait_event_cmd() or wait_event_exclusive_cmd(), cmd1 is
+typically a lock-release call and cmd2 a lock-acquire call. The
+locking primitive can be chosen, contrary to pthread_cond_wait(),
+where the locking type is cast in stone and is a pthread_mutex_t.
+
 
 MISCELLANEOUS FUNCTIONS
 -----------------------
-- 
2.43.5


