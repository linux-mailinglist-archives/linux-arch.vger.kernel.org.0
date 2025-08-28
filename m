Return-Path: <linux-arch+bounces-13318-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B357EB390C5
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 03:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2572A982BC1
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 01:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0496254AF5;
	Thu, 28 Aug 2025 01:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ONsBxjcK"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627EB2459E1;
	Thu, 28 Aug 2025 01:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756343186; cv=none; b=HtJT8SKkWaD+suhjlnnewcqmptEVvWVx5QMkVeOZULwy6xVDxPQEMEFAi9RUoW3ZP3I9kteUnJVq4YTB0+dwhiIruNqDtWi6poSCYVml0/ttAxA7jZBjl6TM71mXAMvLWnUkDvPzS3typGuIk0gd3cMYVDbUfabDSJupyOObujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756343186; c=relaxed/simple;
	bh=dLBtBMRxPgTl5LlhBr9ohEdugqGfe8R5auGo67rDwCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1KS4AC2/z0x0xwVdLuQIL+SBNYnGeYLcTh4KXVZ7XjeLgxRiYNCXyNFwI4nsw5hN9LFNOYJPtIkW2sZpQeUZJguLGqOUAFzu15qm8P7eLvhksywxj8X+B92EAFFCeVH3tdB3gcHg2iCwidilA3XuzumRVHIEuzkt27c/CJ6OOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ONsBxjcK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.174.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id DB729201656A;
	Wed, 27 Aug 2025 18:06:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DB729201656A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756343185;
	bh=A/sW4Txq4BEAcrtbSZAL2Hl6CGu5CJrb8pFJartsG9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ONsBxjcKEXQyVoEG7U5jGuGktZAASYyXKzIkN2Xtsbc9uWpm+kNcPlkBYxViWuPaj
	 ZryvEaUS65dUufMSLJA/HyYkLmEASOBDpNmLVaHe+RsYYhAeIhIYzYNJ5T4C6nLx7U
	 OwYOs+ZBHHYWehnB0I1RrtfUAwxCpfy9DwkqWbyg=
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
Subject: [PATCH hyperv-next v5 15/16] Drivers: hv: Set the default VMBus version to 6.0
Date: Wed, 27 Aug 2025 18:05:56 -0700
Message-ID: <20250828010557.123869-16-romank@linux.microsoft.com>
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

The confidential VMBus is supported by the protocol version
6.0 onwards.

Attempt to establish the VMBus 6.0 connection thus enabling
the confidential VMBus features when available.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/connection.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 5ac9232396f7..5d9cb5bf2d62 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -51,6 +51,7 @@ EXPORT_SYMBOL_GPL(vmbus_proto_version);
  * Linux guests and are not listed.
  */
 static __u32 vmbus_versions[] = {
+	VERSION_WIN10_V6_0,
 	VERSION_WIN10_V5_3,
 	VERSION_WIN10_V5_2,
 	VERSION_WIN10_V5_1,
@@ -65,7 +66,7 @@ static __u32 vmbus_versions[] = {
  * Maximal VMBus protocol version guests can negotiate.  Useful to cap the
  * VMBus version for testing and debugging purpose.
  */
-static uint max_version = VERSION_WIN10_V5_3;
+static uint max_version = VERSION_WIN10_V6_0;
 
 module_param(max_version, uint, S_IRUGO);
 MODULE_PARM_DESC(max_version,
-- 
2.43.0


