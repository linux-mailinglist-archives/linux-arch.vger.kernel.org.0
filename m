Return-Path: <linux-arch+bounces-1809-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5092A8414E7
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 22:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1F71F2591B
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 21:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C25615A4A6;
	Mon, 29 Jan 2024 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tKXBPkUC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B141159569;
	Mon, 29 Jan 2024 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562416; cv=none; b=ju9Gpt+93LT87othN2J1NZM3TImYDiJIuCxElmfkgugjoYN8J0xZDtZ0AbQYQo2ekSYXhKrHpbZIcU23aP/DwKuqT8dJapYPRbAah0mJX+gLrNEUKOgqmoLdaGZg9hrzBfMx4A6382MjlZjyNiw1rTkGqbjF1ytWdo7eLxz7Hrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562416; c=relaxed/simple;
	bh=PA2bNaQGUroOCG4PbvCJuxBIvden1XyXhOeNSYG6Pc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ujC9w3aHVUKhWAgw0KXlV6oaG7WHsk8EqWcvY4ktt678tNT2ggfndXvnBV17wR3gNCy7iGjkLDv9ZQebxCJJhydxapHhx3pIu+kWdT+celZAVW/2e2/wy1duCeXeUPyAGbmkWEPf54+VULNh2K0iaaJ3HW2JITa81dXfQeyMxQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=tKXBPkUC; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706562410;
	bh=PA2bNaQGUroOCG4PbvCJuxBIvden1XyXhOeNSYG6Pc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tKXBPkUCiGqFx3UJT68UfJtfsZvo9lzQSlEslbntl3bHG2N68r4Lg/D78jIgJDYa5
	 mKyvpwpcXLdU721AkT9t5A65cL9pS2PxkKh8Fqsl5nrw7+xrZmhxODO2+ZETuH9BbJ
	 fDx6jE3SERSeIc4yM77HcMOgHXxE+lcWi4Ya/iAB8zY2JS8yCgdYb0NWKbr3VG+rXO
	 5EXvs71nWGiOpNbObd5zHkTG22F3cC3Un8ScMy7nRmxFtw6ivamNeQeeFdbFBuwGQy
	 D9mHV02DMJsL15eKEnMFvo3u8CAMg9Tjc8pioep5x28rnNCaNJ/z68wTPZKQA2v0SR
	 mi8tFk2/icD4g==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TP17t4mGTzVXX;
	Mon, 29 Jan 2024 16:06:50 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: [RFC PATCH 5/7] ext4: Use dax_is_supported()
Date: Mon, 29 Jan 2024 16:06:29 -0500
Message-Id: <20240129210631.193493-6-mathieu.desnoyers@efficios.com>
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
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
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
 fs/ext4/super.c | 52 ++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c5fcf377ab1f..9e0606289239 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2359,34 +2359,32 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		return ext4_parse_test_dummy_encryption(param, ctx);
 	case Opt_dax:
 	case Opt_dax_type:
-#ifdef CONFIG_FS_DAX
-	{
-		int type = (token == Opt_dax) ?
-			   Opt_dax : result.uint_32;
-
-		switch (type) {
-		case Opt_dax:
-		case Opt_dax_always:
-			ctx_set_mount_opt(ctx, EXT4_MOUNT_DAX_ALWAYS);
-			ctx_clear_mount_opt2(ctx, EXT4_MOUNT2_DAX_NEVER);
-			break;
-		case Opt_dax_never:
-			ctx_set_mount_opt2(ctx, EXT4_MOUNT2_DAX_NEVER);
-			ctx_clear_mount_opt(ctx, EXT4_MOUNT_DAX_ALWAYS);
-			break;
-		case Opt_dax_inode:
-			ctx_clear_mount_opt(ctx, EXT4_MOUNT_DAX_ALWAYS);
-			ctx_clear_mount_opt2(ctx, EXT4_MOUNT2_DAX_NEVER);
-			/* Strictly for printing options */
-			ctx_set_mount_opt2(ctx, EXT4_MOUNT2_DAX_INODE);
-			break;
+		if (dax_is_supported()) {
+			int type = (token == Opt_dax) ?
+				   Opt_dax : result.uint_32;
+
+			switch (type) {
+			case Opt_dax:
+			case Opt_dax_always:
+				ctx_set_mount_opt(ctx, EXT4_MOUNT_DAX_ALWAYS);
+				ctx_clear_mount_opt2(ctx, EXT4_MOUNT2_DAX_NEVER);
+				break;
+			case Opt_dax_never:
+				ctx_set_mount_opt2(ctx, EXT4_MOUNT2_DAX_NEVER);
+				ctx_clear_mount_opt(ctx, EXT4_MOUNT_DAX_ALWAYS);
+				break;
+			case Opt_dax_inode:
+				ctx_clear_mount_opt(ctx, EXT4_MOUNT_DAX_ALWAYS);
+				ctx_clear_mount_opt2(ctx, EXT4_MOUNT2_DAX_NEVER);
+				/* Strictly for printing options */
+				ctx_set_mount_opt2(ctx, EXT4_MOUNT2_DAX_INODE);
+				break;
+			}
+			return 0;
+		} else {
+			ext4_msg(NULL, KERN_INFO, "dax option not supported");
+			return -EINVAL;
 		}
-		return 0;
-	}
-#else
-		ext4_msg(NULL, KERN_INFO, "dax option not supported");
-		return -EINVAL;
-#endif
 	case Opt_data_err:
 		if (result.uint_32 == Opt_data_err_abort)
 			ctx_set_mount_opt(ctx, m->mount_opt);
-- 
2.39.2


