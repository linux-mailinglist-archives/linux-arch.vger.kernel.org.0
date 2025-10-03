Return-Path: <linux-arch+bounces-13909-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E50DFBB84B5
	for <lists+linux-arch@lfdr.de>; Sat, 04 Oct 2025 00:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F4D4C2C16
	for <lists+linux-arch@lfdr.de>; Fri,  3 Oct 2025 22:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23503288537;
	Fri,  3 Oct 2025 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Gm0tCL5f"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF36279DB5;
	Fri,  3 Oct 2025 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759530445; cv=none; b=oulYF1OWAqsRyk2UUUNrCbSC44dLwNxOswiOQjUWEA+AiuV43KVYlgLg0H44MUSbDdyloIv9nvdQVFWpqvxTya/yFvDwf+Vomryu6ItHy1QbGlyahdkSicXzm+zx3GZe3U4B+ejgUWtJsA3eL/eFB/zPNsgLlxiEUHncuhvuFiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759530445; c=relaxed/simple;
	bh=UCHaAztmaqPan3WN8y2waQiYdBywI5TdRQdR25q0yqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0PR0EpJeVoi0pDt+ff0t4aHUCJEwQmF1HSuagCWN6ByKYMkwIuIdbTFZj36MARPLKgZdZrrxGDTJcIVSNPEIiuqSbB0xzBe4vfSg0isGQmYMSLOH55FZU7rikraFRjRaetPrXzhspEAvjUYd8pvQWPsyf17GOudE7jpO3sN5EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Gm0tCL5f; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 821FE211C27A;
	Fri,  3 Oct 2025 15:27:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 821FE211C27A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759530439;
	bh=9gEps6uGn9x2EAxbkmBhwMfVhSm/46tAIltv0VH9bmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gm0tCL5fUFubphWC7/R8yr83pEmnBosFdd7e599hq1KOfmkDDTwTnT+AL61tYrQsT
	 3kenkuqA5urUTCtZqpwyk9IDAXxcCpqPz6zugYSYnSsmNiKc8oxpmLMzos7I6pq5a3
	 QEtTyz1AZIvQvc7hFSYKb92vXjgXqOYr/2nkZKPE=
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
Subject: [PATCH hyperv-next v6 09/17] Drivers: hv: remove stale comment
Date: Fri,  3 Oct 2025 15:27:02 -0700
Message-ID: <20251003222710.6257-10-romank@linux.microsoft.com>
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

The comment about the x2v shim is ancient and long since incorrect.

Remove the incorrect comment.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/hv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index b1085473778c..95631c08a71f 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -268,11 +268,7 @@ void hv_synic_free(void)
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


