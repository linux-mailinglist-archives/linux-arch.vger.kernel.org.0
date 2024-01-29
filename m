Return-Path: <linux-arch+bounces-1810-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A9F8414E9
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 22:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C64A71C24069
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 21:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF4F15A4AE;
	Mon, 29 Jan 2024 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="CcOYTXBC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89212158D9E;
	Mon, 29 Jan 2024 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562416; cv=none; b=IcuF6SZE4MfJtURYRwlr8Oc4Vg4mkhRHAbqwbRK3Bo1dnhHN8Ifp2XVdSe9nfhuZdtvlj/PNT1Mu2f8Erw+3xy8GME2irfU33Q5+w1KuamGCnc7SFEnQ4He0woxl4o5lkifYqyUt5wfCobl/Xp+QXaCdwyLl6WtKLF2nvcloZD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562416; c=relaxed/simple;
	bh=+9KVNYBLuRYpTotbk2zGsoJXymuo5SYIdtEsNtMMAo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wia5Kdbl0lskrOHtEZ1N04JXKVz6hCh8gslubX2SPWxW54bZQ8QG2tR6TL1YE4JKbHdZUqaZjZ1pJKmMFZAnkAVnU7TYJfllDRDZ4faP7t9orggM0Qh0ZQ0QvzJRbbfSWv82G6pMBAGHowBMcrDcFF018Uue84lEUh5r+9gBDy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=CcOYTXBC; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706562411;
	bh=+9KVNYBLuRYpTotbk2zGsoJXymuo5SYIdtEsNtMMAo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CcOYTXBC+giecQFAnLXwCTdIA57noQj2OFLZSCDKOIqpDr07dTVy1a8yJ3JryQJFV
	 2W5WB4QDkxTlNWbKpDcCfDCV1Yk9/dIKfFXxGJuTQcgowNhMsO3Yukg02bjPIMQFRv
	 /baVDZYZtLVEz5A+3KUgQ0PgbI8sFNR5jmvB/7Vj1O8CCBTsO3bSZG9kBumQzDZiac
	 Bm8evVOKtcBoj9wUdK5Wg/PiFVXjpfyrc41vpv1g5ItzalsHpw3MmQJYQPi57b1jWs
	 DvIBjtghpS+h8EJifX32P3NqBz5VyeY9kNGlqU4+zvabpczDg6wWwsmvAwIDe9N3Eq
	 k/288u39p8m6w==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TP17v2W6RzVfr;
	Mon, 29 Jan 2024 16:06:51 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-xfs@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: [RFC PATCH 7/7] xfs: Use dax_is_supported()
Date: Mon, 29 Jan 2024 16:06:31 -0500
Message-Id: <20240129210631.193493-8-mathieu.desnoyers@efficios.com>
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
Cc: Chandan Babu R <chandan.babu@oracle.com>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org
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
 fs/xfs/xfs_super.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 764304595e8b..b27ecb11db66 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1376,14 +1376,22 @@ xfs_fs_parse_param(
 	case Opt_nodiscard:
 		parsing_mp->m_features &= ~XFS_FEAT_DISCARD;
 		return 0;
-#ifdef CONFIG_FS_DAX
 	case Opt_dax:
-		xfs_mount_set_dax_mode(parsing_mp, XFS_DAX_ALWAYS);
-		return 0;
+		if (dax_is_supported()) {
+			xfs_mount_set_dax_mode(parsing_mp, XFS_DAX_ALWAYS);
+			return 0;
+		} else {
+			xfs_warn(parsing_mp, "dax option not supported.");
+			return -EINVAL;
+		}
 	case Opt_dax_enum:
-		xfs_mount_set_dax_mode(parsing_mp, result.uint_32);
-		return 0;
-#endif
+		if (dax_is_supported()) {
+			xfs_mount_set_dax_mode(parsing_mp, result.uint_32);
+			return 0;
+		} else {
+			xfs_warn(parsing_mp, "dax option not supported.");
+			return -EINVAL;
+		}
 	/* Following mount options will be removed in September 2025 */
 	case Opt_ikeep:
 		xfs_fs_warn_deprecated(fc, param, XFS_FEAT_IKEEP, true);
-- 
2.39.2


