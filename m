Return-Path: <linux-arch+bounces-1806-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C75B8414DD
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 22:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147361F25887
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 21:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B2D159570;
	Mon, 29 Jan 2024 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="owLk9BdI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7414E157E6B;
	Mon, 29 Jan 2024 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562414; cv=none; b=MS04Od4uN/RQDvvWyXSiiqfCY76L9IAy4Hvrag4buao6piROzQjDpR+4ZwihgwrbmZAm/K0KBGBk2z42jXCytSmLkgm0zmrMrmUlt1gUdNLVmf6z1mGHA0q8nT0fUxt52J1JOiSzrZG3XrL01yOYHWQbFv0AyzIwHJ8SjCgb8Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562414; c=relaxed/simple;
	bh=/LtPwfaY3uvi/uQueiJk5XQ5+25aOGLyhq5zZA6ahe8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j4LQ1rgd+V9cv+w2y4ZjJV2BGML+eS+PH4/5ihGAozRF7aYM0Wntlqe7lnNpIfBsTxpN4cZq973EvohnDGshOkYYNgUUfs7EpWnQXQ0c5r8wj8cu1oLoQjqNyxbxP5YvTrHuZJsyC3+gZAAbBu+HuoIBFiL9IjwP/TmmRP3sv60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=owLk9BdI; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706562410;
	bh=/LtPwfaY3uvi/uQueiJk5XQ5+25aOGLyhq5zZA6ahe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=owLk9BdIvYMqzPMeQbF2d7yNSH3zTkRUuREg1aXHoA5/oKPsRDPqPidgGmIGg+ZMe
	 uDiNO1/hYtcLl6AbcYMjONTAvJEsm6nwxQqyLcdJ/rEInjNK7h/7xuu18NXQG94k5M
	 nDpyHDrTa9Es9c9pzOQ+TFHsELADk92a4djW5vooUTinmDn2l9YfYZTRGedTlpDb1b
	 MI3xshUjIJfHBa1pLt/SmgLF6goBo2TIOsc/su8NScSwzwbLdoBVSgvIlqpOTOOubM
	 FokMDNIjPddKGnlVW51N6DyLGp3GD1P7ThIgTTI/7EBNQcDz6UZ9lqZkBEx0WblNU7
	 uTSeb4zKuNrPw==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TP17t029YzVXW;
	Mon, 29 Jan 2024 16:06:49 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: [RFC PATCH 3/7] erofs: Use dax_is_supported()
Date: Mon, 29 Jan 2024 16:06:27 -0500
Message-Id: <20240129210631.193493-4-mathieu.desnoyers@efficios.com>
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
virtually aliased data caches at mount time.

This is relevant for architectures which require a dynamic check
to validate whether they have virtually aliased data caches
(ARCH_HAS_CACHE_ALIASING_DYNAMIC=y).

Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Gao Xiang <xiang@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: Yue Hu <huyue2@coolpad.com>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org
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
 fs/erofs/super.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3789d6224513..bd88221f1ad7 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -419,9 +419,13 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 
 static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 {
-#ifdef CONFIG_FS_DAX
 	struct erofs_fs_context *ctx = fc->fs_private;
 
+	if (!dax_is_supported()) {
+		errorfc(fc, "dax options not supported");
+		return false;
+	}
+
 	switch (mode) {
 	case EROFS_MOUNT_DAX_ALWAYS:
 		warnfc(fc, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
@@ -436,10 +440,6 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 		DBG_BUGON(1);
 		return false;
 	}
-#else
-	errorfc(fc, "dax options not supported");
-	return false;
-#endif
 }
 
 static int erofs_fc_parse_param(struct fs_context *fc,
-- 
2.39.2


