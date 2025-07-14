Return-Path: <linux-arch+bounces-12760-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77988B04A34
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 00:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707DE4A41EB
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 22:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF85327C162;
	Mon, 14 Jul 2025 22:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Gc0UX85E"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9AF278143;
	Mon, 14 Jul 2025 22:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531352; cv=none; b=q7zd2VSNeHtzSIwEi1g+LC03zy0Rm1igfUFaipSMADg9ykcZozjMhcA5yjLReH/mmqC+37Lx/o0PqxSIZOhaADs+M2CP8FYZ4xnPAJlvV4KPZrrDZLQ4ppx1EzjAzVJaW0cfucuDMi2Jw96w/DfsfT/T74cP8niaN+34S8eKWSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531352; c=relaxed/simple;
	bh=hN0bzn33b7/bcvBUrIoUS+YL0Fauw5ocCHmmJJZGNOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKWlkt7GiZbrXwZ/BezwGZZzrmLHluwG3i2GSIl8DlQCRz+IHfX0AAjuqey3sz0QMcRFIrq+XI6Znw4XEbi1LpreJAY1k5bPAS+YlNL4BdbgMYgSzjAsooSdi6tszlAZktvZGCfBjuKxViRjMsI8CByaUERxrmaG0oQCCHUglIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Gc0UX85E; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 20B8A2016594;
	Mon, 14 Jul 2025 15:15:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 20B8A2016594
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752531349;
	bh=G1piMKMIQwdOuzoLPvU+WPXOuTN4hKPH7hsZm96BaHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gc0UX85ErGQszX3lQ+KML5u23xXLREkBCdgWmk1SpZilJVAdj7SDtcWFRes+ralIf
	 EZzDgm3fCETCop3FP5+QaE0xoi1AQGjjVWu3rGiwxDEGzlcBxLhP2/fKMAvHl6UnDb
	 AKlTnpIcvSkV75CW8pQdx3Rr8xXp/mitaivNOoM0=
From: Roman Kisel <romank@linux.microsoft.com>
To: alok.a.tiwari@oracle.com,
	arnd@arndb.de,
	bp@alien8.de,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mhklinux@outlook.com,
	mingo@redhat.com,
	rdunlap@infradead.org,
	tglx@linutronix.de,
	Tianyu.Lan@microsoft.com,
	wei.liu@kernel.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v4 08/16] Drivers: hv: remove stale comment
Date: Mon, 14 Jul 2025 15:15:37 -0700
Message-ID: <20250714221545.5615-9-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714221545.5615-1-romank@linux.microsoft.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
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
---
 drivers/hv/hv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 816f8a14ff63..820711e954d1 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -266,11 +266,7 @@ void hv_synic_free(void)
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


