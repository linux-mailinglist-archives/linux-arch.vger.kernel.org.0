Return-Path: <linux-arch+bounces-13311-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 079D6B390A6
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 03:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1B11C246F3
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 01:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BDD226D1E;
	Thu, 28 Aug 2025 01:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BnmU/SRS"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870001DF26E;
	Thu, 28 Aug 2025 01:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756343179; cv=none; b=YGvBtSrdscMOKM13xvpqiq9grF8MxO3Xkp6eUumWcqzGDSZy2ashgtxEGVnFhY73bk9uD+DC5hEbetrVGd2xJg+YqwSRdK24heBs2tDtkyZd0TDynkT/ipK+OJR7buUn762wEjaJy37gGCQwnVA/SFPmA2X1iYRsXI0xxwJA+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756343179; c=relaxed/simple;
	bh=X1MH60oLqF+7VATMGi3fq+AwPANECHoJNjmCr1BSZbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9Mf6Nrxls67woNnhjPps8LUNbHvS8o4IM+rhXdp+OvgOp55GwV9o3hE00lPSwJgyVmwblFjTkaNH/e0eDLIwXPPfr5ePQ7MA1ljnZLL5btT8jX5oEPBRIs3cR0qdZtsLhoB4ka7YFoyfn/DfcBQxrd4VjNXysKX0gK1dNFFUek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BnmU/SRS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.174.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8EDEA201656A;
	Wed, 27 Aug 2025 18:06:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8EDEA201656A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756343175;
	bh=Cxm868aqOG2WQoIQ4YnyrRLfsVlAHVhuDEZdf1jnYX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BnmU/SRStCjvI+Ro7Ki2kQUa0Xo8FzRmESzSlkLVuJBHscXT+Vv/Z5hM2tHsvV48w
	 R5WELUZew/3apMpu0u1Hh8jQ9h/q46BtpU2qpFSZWGzqEGxKsylIHThWAeJ4WY/xgX
	 QygiVe/9n7UpZhoaF0sE7/8Y/TAwwaXY7vzFFuKw=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bp@alien8.de,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mikelley@microsoft.com,
	mingo@redhat.com,
	tglx@linutronix.de,
	Tianyu.Lan@microsoft.com,
	wei.liu@kernel.org,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com,
	romank@linux.microsoft.com
Subject: [PATCH hyperv-next v5 08/16] Drivers: hv: remove stale comment
Date: Wed, 27 Aug 2025 18:05:49 -0700
Message-ID: <20250828010557.123869-9-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828010557.123869-1-romank@linux.microsoft.com>
References: <20250828010557.123869-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment about the x2v shim is ancient and long since incorrect.

Remove the incorrect comment.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/hv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 951330ca4ba9..1e7fd7c19c58 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -271,11 +271,7 @@ void hv_synic_free(void)
 }
 
 /*
- * hv_synic_init - Initialize the Synthetic Interrupt Controller.
- *
- * If it is already initialized by another entity (ie x2v shim), we need to
- * retrieve the initialized message and event pages.  Otherwise, we create and
- * initialize the message and event pages.
+ * hv_synic_enable_regs - Initialize the Synthetic Interrupt Controller.
  */
 void hv_synic_enable_regs(unsigned int cpu)
 {
-- 
2.43.0


