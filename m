Return-Path: <linux-arch+bounces-13979-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04565BC6EB5
	for <lists+linux-arch@lfdr.de>; Thu, 09 Oct 2025 01:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E95D74EDA6F
	for <lists+linux-arch@lfdr.de>; Wed,  8 Oct 2025 23:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539F32DF719;
	Wed,  8 Oct 2025 23:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fseko9up"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E855F2DEA90;
	Wed,  8 Oct 2025 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966480; cv=none; b=penGYGzmAOgIGDLh5/MTt9mXRIEDQtyAyUcIQsd2Cf+Csud7m0bBMakuXiKw2BQV1NzPVVEYhWiied+ZGclxL49P1qEfADkH4UHVZCHvwbX3HGNnb01fUd/agyz86M/i7g/t5Y0+LZRF/aFei2g1XqpyFklqPHjwFpZTOgonxwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966480; c=relaxed/simple;
	bh=dLBtBMRxPgTl5LlhBr9ohEdugqGfe8R5auGo67rDwCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FI3kuPe1YoPUIv/ADoEXF0hrZJJp03fsf93sTZkWE1jk0sCE4/ROi/lXBz8WkBfdRiOy6GqP8ychjfQ0FLzR8jWORC81R1Qrk3AGW/6D4okjdIJBy3Ny2HrS58AvjK/HfN14gUYnVL4e03LykdIkj+xXk0pvFBLx4yz49ZV+okg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fseko9up; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 509C82078630;
	Wed,  8 Oct 2025 16:34:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 509C82078630
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759966478;
	bh=A/sW4Txq4BEAcrtbSZAL2Hl6CGu5CJrb8pFJartsG9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fseko9up+AIVhBc4XDeRjmjeY/I1mW5ErUru3TlUTK1+Onfw+DM35goIcmBwxH20Y
	 e6mP3gTtMxkQneuFAKO+rIKgroD/sbr6fQl1fKZrR711ZKuqf24ixNQGXd6qqpvHa1
	 zVcVZq3MDdmqspQKR9mRxdKxAj4PJ/JhMzekirl0=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bp@alien8.de,
	bagasdotme@gmail.com,
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
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v7 16/17] Drivers: hv: Set the default VMBus version to 6.0
Date: Wed,  8 Oct 2025 16:34:18 -0700
Message-ID: <20251008233419.20372-17-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008233419.20372-1-romank@linux.microsoft.com>
References: <20251008233419.20372-1-romank@linux.microsoft.com>
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


