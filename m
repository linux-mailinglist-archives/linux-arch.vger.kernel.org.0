Return-Path: <linux-arch+bounces-13916-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7FABB84F1
	for <lists+linux-arch@lfdr.de>; Sat, 04 Oct 2025 00:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5B44C3063
	for <lists+linux-arch@lfdr.de>; Fri,  3 Oct 2025 22:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44B62DC34F;
	Fri,  3 Oct 2025 22:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QzlcFVsd"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB573287259;
	Fri,  3 Oct 2025 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759530446; cv=none; b=I5Ac1l05Rpa7G1nP1jUShGT3iR9fhIlWLVwr/nybRTXe+M9h9pllak1/M4uZVhK6ABHLBg8CjfF+7eHNynHh6xzLL90jKdipvt1W0hp6sRBj3CR4/yujdnb4ALr8niAHxjj16B4/LbWcJB3VOjd4Onn2BemN7NKPOzdXLW8nbe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759530446; c=relaxed/simple;
	bh=dLBtBMRxPgTl5LlhBr9ohEdugqGfe8R5auGo67rDwCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dg7Gjm8CL0mMeCVFG+4fG7Is2496R5ySu1ocSlbGDDfbhngF41XpeQ+2ZbsSXPqauw3TPlgoAJGY6HTMj7dHgfedwMyCWzvndy36hwbsfXFZPBB41D+9kzP1K/EFxkTJQI/Zx8/iyB2oCDQYC+tkCY1WSRZbxyk6vtmBfaLZmbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QzlcFVsd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3A744211C281;
	Fri,  3 Oct 2025 15:27:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A744211C281
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759530444;
	bh=A/sW4Txq4BEAcrtbSZAL2Hl6CGu5CJrb8pFJartsG9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QzlcFVsd5ibqXgsF2TgLT9V3IrsPSJr+Ts4gAdJfo/ERFUiPEnuzEAdaYvJ/xe8RU
	 x3uABocJqd4Q0Du+Ez2RWZ3e694x0c1UBDH8xtkNNGbITBE5ccb6sebXTIyUG1JGux
	 OK3/YXtGewMTZvwoiD1JXMu9zMKiEecIxmChuIUo=
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
Subject: [PATCH hyperv-next v6 16/17] Drivers: hv: Set the default VMBus version to 6.0
Date: Fri,  3 Oct 2025 15:27:09 -0700
Message-ID: <20251003222710.6257-17-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003222710.6257-1-romank@linux.microsoft.com>
References: <20251003222710.6257-1-romank@linux.microsoft.com>
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


