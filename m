Return-Path: <linux-arch+bounces-1804-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A32B8414D7
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 22:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AE4287A83
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 21:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32211586D0;
	Mon, 29 Jan 2024 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ZWoyjvOU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741DA157E72;
	Mon, 29 Jan 2024 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562413; cv=none; b=YirjOv4koDJYCbaNhyahLl5OyNVwpE0JxG59e/nGE7NYIspQdxR5pPCMbGhf7BLpeEXxNSWgQ2uJ2SF4GvkrX3sq7s9fkaLl3XxToDEAz0Jrbau0Aquyrc2ulSPspWo4MKLC9rcqY//skr9db9ccrjIrgXhaJ8xSRAJypwW0t9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562413; c=relaxed/simple;
	bh=huTRzi08F0C7MipcdwWe4Ussu/u99HDe6usjofLClk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pdH8ZxBjF459CKT+NL7owV6R+YPjRHYFgdT8WO2mtfqEfDccKE36H44qqCmfxDtCyCmZA+Y5UjJ2FL1hsm9yKYG+IVnnSPtZkv3Exlb0L/xEzIfxfHihj+xNUgc1YqDbNYc9hGvIJiG8GBezDnHSNIG3zkB5IdgvhOa0mmccfBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ZWoyjvOU; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706562410;
	bh=huTRzi08F0C7MipcdwWe4Ussu/u99HDe6usjofLClk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZWoyjvOUAKRorOkBf1VRCuUe3muZT9Jazkxz9NgPX6vA5tHzdv9fZAMvOwYQUQFS/
	 ykyGlVWSZVdQ0AmTeMSrDjJkEHWdN1z2Rkg+mdr/4zNt3mUu8G59Y1UA3dQ176ZmpR
	 XNnmvuPAdpd+gxgklREaTW4KM1V+5TYa9+K78amLQzWaxBqWfXKQpPUZi200cIw2Ld
	 Z3msxyPrO6jmtz8APzkLg3rQ9tiibW5MVa2+hL9owNVSrTbGjPvM2VkNg7OI3Jte1b
	 FXwljb10nWNnW/XdQvOwCcgvrIynWSjuNs5CGDe0uL9fagDqdafBZW/LVhSU2RA7Ha
	 tXwBGOdG23nsA==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TP17t2bfzzVJ6;
	Mon, 29 Jan 2024 16:06:50 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jan Kara <jack@suse.com>,
	linux-ext4@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: [RFC PATCH 4/7] ext2: Use dax_is_supported()
Date: Mon, 29 Jan 2024 16:06:28 -0500
Message-Id: <20240129210631.193493-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129210631.193493-1-mathieu.desnoyers@efficios.com>
References: <20240129210631.193493-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dax_is_supported() to validate whether the architecture has
virtually aliased caches at mount time.

This is relevant for architectures which require a dynamic check
to validate whether they have virtually aliased data caches
(ARCH_HAS_CACHE_ALIASING_DYNAMIC=y).

Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
---
 fs/ext2/super.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 01f9addc8b1f..0398e7a90eb6 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -585,13 +585,13 @@ static int parse_options(char *options, struct super_block *sb,
 			set_opt(opts->s_mount_opt, XIP);
 			fallthrough;
 		case Opt_dax:
-#ifdef CONFIG_FS_DAX
-			ext2_msg(sb, KERN_WARNING,
-		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
-			set_opt(opts->s_mount_opt, DAX);
-#else
-			ext2_msg(sb, KERN_INFO, "dax option not supported");
-#endif
+			if (dax_is_supported()) {
+				ext2_msg(sb, KERN_WARNING,
+					 "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
+				set_opt(opts->s_mount_opt, DAX);
+			} else {
+				ext2_msg(sb, KERN_INFO, "dax option not supported");
+			}
 			break;
 
 #if defined(CONFIG_QUOTA)
-- 
2.39.2


