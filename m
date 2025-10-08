Return-Path: <linux-arch+bounces-13972-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC4CBC6E5E
	for <lists+linux-arch@lfdr.de>; Thu, 09 Oct 2025 01:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DD614EA9A5
	for <lists+linux-arch@lfdr.de>; Wed,  8 Oct 2025 23:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F247B2D3EE5;
	Wed,  8 Oct 2025 23:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mMsfyr30"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA4A2D1F61;
	Wed,  8 Oct 2025 23:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966470; cv=none; b=SLGYT3RLabaxBDKb/ExwJL8e5eqff9VTEQS4TAtZ4ORdCCaxJXBXKUJYGs3n2KRurRc8UINFeGvdi7U+xNJHPAT34sfEyEk66Nw9mXt9p+oI/AYrCQ99Fgi1FZ9wdN2N8KTPhnYUEaNvDAAGGFrpbXvHCkx16Cc8AW7puTTzWjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966470; c=relaxed/simple;
	bh=UCHaAztmaqPan3WN8y2waQiYdBywI5TdRQdR25q0yqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAjxm13z74oXh0eIdHnf+xIQ5QI081RBm30plWBoIKwLpVugPp1CioanUnaMGbEWzxsT7fBCV56AqKSIS1uBo2UTf2N/K80FukJChLhxIa+O9cj2Hp7qe6mZGfFRwcskDV7eOQk4WMqZIBL70WHkgaAYmRnxj3ymSzhFzVHadsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mMsfyr30; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id D548A211AF3E;
	Wed,  8 Oct 2025 16:34:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D548A211AF3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759966469;
	bh=9gEps6uGn9x2EAxbkmBhwMfVhSm/46tAIltv0VH9bmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mMsfyr30TlCqhe21ioNoiUaUCqzkdOXbHIj2PwK37poHXUpG7ts2EvmcL/zWqE6Jz
	 IQ3ofwXgawgERDjHSDqKZ7+dDEYbw23+xW8jaap8hXqfAZd9gvfom/KWrdKv/SpW83
	 lkY73QrLr74KG8gaKwO5Lctuo7x36og5wFgffuiI=
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
Subject: [PATCH hyperv-next v7 09/17] Drivers: hv: remove stale comment
Date: Wed,  8 Oct 2025 16:34:11 -0700
Message-ID: <20251008233419.20372-10-romank@linux.microsoft.com>
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


