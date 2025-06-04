Return-Path: <linux-arch+bounces-12202-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDA0ACD0EC
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 02:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BE13A7495
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 00:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B490E17332C;
	Wed,  4 Jun 2025 00:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fT62NYCK"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5E372625;
	Wed,  4 Jun 2025 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997830; cv=none; b=uSkfoD+nQwv23ClFtap9pZxnsL9KHFa78u/G4R+B2rIwTcwvUrj6O712ImyQQfN8rQu40xFENOBXQBDlcw+FZWR5Ad0zr9Fv1slDDuqNk6YuT/Xkdh0n51vCbqaY2rWSJFOQ99SGcx0maXNrO+iYfDumFCzXn7WEIx/O8bxMyXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997830; c=relaxed/simple;
	bh=qu5wrCRGckFddgOVao5M+PQvlTFUez7DHz4TBUqUopY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0Y02VfBfbkcJsTl+qodOGNVqRkShXQxh3P0BAFhItp8CVGUbiQkMpEKOghPYsxDtEA8OmSH5Ymyxia90HOJklg2pfLn4HZRD7vNcpXEnuymnv6tG0t3bsQPdM9UU/QW87OaRyuFuq/hSa+wBxzwGvr/+6R8qCHyAUzIv6cZNBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fT62NYCK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 23742211744D;
	Tue,  3 Jun 2025 17:43:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 23742211744D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748997828;
	bh=5NILQvH5aX9tvrOJMwj2GLYW/SEBrWgpZjSjwN/upug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fT62NYCKaOi1r3nQQ2phA+78GAYqZzdidu63lQ0n8P896grkB7UwaF/o7dzybHx3z
	 eZq+bZOBaCVvc5CZR3QS1I+GDau9/vsQmZOrVhpq1HeuNn/dIyEWkp+MvrgMCWVIw0
	 X+2tz1uJ/Funk9IeIp3ArJ1XvPh2fYXJsX+6UPFk=
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
Subject: [PATCH hyperv-next v3 15/15] Drivers: hv: Set the default VMBus version to 6.0
Date: Tue,  3 Jun 2025 17:43:41 -0700
Message-ID: <20250604004341.7194-16-romank@linux.microsoft.com>
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

The confidential VMBus is supported by the protocol version
6.0 onwards.

Attempt to establish the VMBus 6.0 connection thus enabling
the confidential VMBus features when available.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/connection.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index eeb472019d69..7cd43463f969 100644
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


