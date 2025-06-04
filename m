Return-Path: <linux-arch+bounces-12192-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A79EACD0D6
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 02:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00AE4188A2F5
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 00:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1C57261F;
	Wed,  4 Jun 2025 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JQ0hHu5l"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DB41E52D;
	Wed,  4 Jun 2025 00:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997828; cv=none; b=DERX+w8V6ViKkKUzAJsdrKISz3qDqnJwi7uRWfQZQzQG09tGPTJ3AgEBu2gD35E+YJ7GsWhvBs5h9MnKHwSzE0zvgNNpznphbh/8I49/znw2IYLKdK8xgWAT1tf1v5iPeugC8LzHCM+YKy8euGs82xlTyMtZbnq7xS3J6jlHzOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997828; c=relaxed/simple;
	bh=I99ATGrgD7XawikCaVwkKDyfblPK065Jd+ZqTiEtwDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjZTEPoaZ0LckWc+SjdT7ffqvrvshjaO1mveQaWp+lBBtAMRGVdNSLhu8n+k5d5NN9W7kDWpYKbtAzu0vU9UxEPiXMnl6b7fs0tm/fgwzOnnxinNeOLAV5cN+NgQLRP4SWsqq1HYqH5As2z9hCkWW3NTANJ9brPqe+fAiJMTuv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JQ0hHu5l; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6BA9B2117446;
	Tue,  3 Jun 2025 17:43:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6BA9B2117446
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748997826;
	bh=ZShplV4bAYCDbYEU2Ei1HtNkAps8t8DA995FmRQAChw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JQ0hHu5lana2ZWgWM5ePpoMdQotzLuBlV7k6nfsaH2IHCgFIUIFLZdocLG077GfPu
	 oV1l6OWXIIU4sdjx76AQWlnZvysfC6IxBXtcbJOBJtLsJQbCqKR9inuIZXUvL5/aLf
	 jM2lxkusnxehzasnAaw0A3LIS6bt+2V1MLP9ijF8=
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
	mingo@redhat.com,
	mhklinux@outlook.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v3 08/15] Drivers: hv: remove stale comment
Date: Tue,  3 Jun 2025 17:43:34 -0700
Message-ID: <20250604004341.7194-9-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604004341.7194-1-romank@linux.microsoft.com>
References: <20250604004341.7194-1-romank@linux.microsoft.com>
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
index 1f7cf1244509..6a4857def82d 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -257,11 +257,7 @@ void hv_synic_free(void)
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


