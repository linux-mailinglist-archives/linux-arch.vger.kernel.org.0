Return-Path: <linux-arch+bounces-12482-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47142AEB564
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 12:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762271BC62E6
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 10:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FDC2951A0;
	Fri, 27 Jun 2025 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pksJWTHU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4BB29615D;
	Fri, 27 Jun 2025 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021460; cv=none; b=mcLJdd/J5iSe8OKNe2qu/4DAt3ERpD4Hukx1H+qZjY6JDqLYugw2g2OGMsTfzPIERMNlxtnBYq8qZCXa50Yp5HHZj+D7VVbkHHQYDyfrowM6oij+FbGb/HBu+4yXr5wr556dTaBIzX5nTrRDjU8entjouuJRpa1QSk6DKPJFtnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021460; c=relaxed/simple;
	bh=iyRgdZz62kfHtWgProqZ9GBCRWbW6BTlAC0PWj8nzus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JVMfqqYRygVy3RZ33xS/3fJNUuNMTPl2QoNC2WcfCS7mdDq4+kZ5QWZ+jTukg6/K4SaRdKFx6LTn4bTBeonqQRYK5tuzF2SCILRypEqAhA40byr0tTu0RDYYrehVqOSqK+DBOJ/JIm620dG7zjEmoUogt4TFpoDp5pDcf2fWG58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pksJWTHU; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RAbJZv012822;
	Fri, 27 Jun 2025 10:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Xo6dHGRpyyJ5stGO
	yGIAPRrHVhhNbeVBOkIc5fi1KhM=; b=pksJWTHUSjb1dR7FEIdM6KMxYRIOI+WW
	OWJshPa5FOP3b+zC6FyF5w76syHRip+H0+RZFl4lvo80+5g+mHz4bwPjyHq2haRC
	YEJhRlS9J6knjrrngizAyI8rn/wtCcMvpBBnbEQ4W9X1H59E3WnygtfYreB+5X91
	MGCHo95FGbdrdi9Lg6kUu4ISk7KTgrQ+UFP0C8p/S0wqF7Fe4/SLL2nCluK7UPUE
	RF99i5HZd6vAmcI2kDZpj6tV/4A1pCwgLduMjuflS6XKEu3xNpbm+D2Bpmw3axuu
	b5SflnJd6B/0zWZxcOMGbtbGzgn44pkvLMLAwV9D/frI+N8nRPghjg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt5tmqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 10:50:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55RAWS7B018085;
	Fri, 27 Jun 2025 10:50:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehw16w1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 10:50:39 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55RAocV9011478;
	Fri, 27 Jun 2025 10:50:38 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ehw16vyg-1;
	Fri, 27 Jun 2025 10:50:38 +0000
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
Subject: [PATCH v2 1/1] docs/memory-barriers.txt: Add wait_event_cmd() and wait_event_exclusive_cmd()
Date: Fri, 27 Jun 2025 12:50:33 +0200
Message-ID: <20250627105034.1612947-1-haakon.bugge@oracle.com>
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
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506270088
X-Proofpoint-GUID: 8FpXteLgEXlpSTDqPX7G2_fm-vPer4yz
X-Authority-Analysis: v=2.4 cv=PMYP+eqC c=1 sm=1 tr=0 ts=685e777f b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=M51BFTxLslgA:10 a=yPCof4ZbAAAA:8 a=lPgn3NRR9fYW2pfQ3SIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14723
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA4OCBTYWx0ZWRfX7ohwrFESJfrD aINzfDGzLbT2VX4HNPF8gP01tA+7rr/zKLEyGoQi08RLkZGhQW44I3CymIPuKuxiDrUYX8frqve PAxlV6Sso+UsiWg1xZX0CyeL+yixnYz8UWDscdHIGA6TyfTVDbod3dUFlQpqe45gyXTPTjTE2Vt
 wi16bsrfgVbyZ2MjzEshAXY4QkbQ7vAqr2FKOSU1ieKj2B83FCEPBMSwH8c2IARROMxan8HC959 JmfKFo4dSn7YHBtTPpCSEiFbgZszJlUhVzMa17JOEFtlt6ip/blReRtz8Q9WV/PM44cjVHDP0kY pkYMqCaP5j4Y4PUvBuH55WRKgGiLh+9/5+MvOzcWcHoOz7j03zsnxa0H7tQyLljRFqMtfn5KxNS
 ujvnYemC+DXFE8nmUgGWz7PQ/bS/Abf2PY6438eP+Ot31NXSkg5bmQyyV2jCViZ8TybLxWkL
X-Proofpoint-ORIG-GUID: 8FpXteLgEXlpSTDqPX7G2_fm-vPer4yz

Add said functions to Documentation/memory-barriers.txt.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

--

v1 -> v2:
      * Changed the prosaic part to kernel-doc style and moved it to
        include/linux/wait.h in another commit
---
 Documentation/memory-barriers.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 93d58d9a428b8..1d164e0057769 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -2192,6 +2192,8 @@ interpolate the memory barrier in the right place:
 	wait_event_timeout();
 	wait_on_bit();
 	wait_on_bit_lock();
+	wait_event_cmd();
+	wait_event_exclusive_cmd();
 
 
 Secondly, code that performs a wake up normally follows something like this:
-- 
2.43.5


