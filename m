Return-Path: <linux-arch+bounces-4117-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A208B91D6
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 01:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97CAEB21213
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 23:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A802168B0B;
	Wed,  1 May 2024 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYYe3iYV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B7B165FA1;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714604492; cv=none; b=qU321hEjwfEcGqji0EitW17s7e0jeomLOii0U6jZi7NstBQi7FvqrhOLlPUkXf6NiFm3SRuNmcXL1qTdWXrtLzY1HWuH5Pfrh6K4P2aNEF1YLoK4K2Da84q5ZNKUMi1zUbgEYHlF7mnSFOmZVRk0mGvS3Tm3KOJnAKQYIIxMl/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714604492; c=relaxed/simple;
	bh=JQmLzMtBpKC/TtfERldphRZSepAv95vPmjK1jOVEaZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cF+WwFog0DyOHgI+37QShHAc+jRU0f0hrEWt2W8kyGqDbAIp6wdutFyAH66dBP6lVNCEPE5Xz+2vdtWBXOCBYU2AYATyBpsQDmHxa7WGEFwclMrzboLgp+XTq9bcx10djb90fiKxIvndAg2+ZkPFvpsGwQK7YVFRVDUiWsmczN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYYe3iYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E8EC4AF52;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714604492;
	bh=JQmLzMtBpKC/TtfERldphRZSepAv95vPmjK1jOVEaZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VYYe3iYVikXiszNpOW5eYSVRF46eyKWebtQFsIdPs+aDuaYa3Tqel/IK7B/bnfftv
	 v1QLnxqFy86Rpq/Y16R+rMtmri6GptIEQrdQKTkEoN+qRnAx4Cz4iuGkL8hdGhOBiu
	 pXV0PFLT6tk9sTVd/+TiWSpe8hw5ih6YI3GyO7YYzmZg1hmw8MTM7jbdAoxdEW6hz3
	 1ScdcghDxJ53rOfUBJt+lIiyS0p88R0+qvsWqJNRLTDZJWCLojqJ6AC1RaNecXH/s9
	 y6YVSpQKzqMvjBR4JfZ0JRanZuqufemkYcQaFvgLPqOEbfpARsxdOmwHSEo/36VIJz
	 nzt1zgifH3t7A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CD788CE2277; Wed,  1 May 2024 16:01:31 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: elver@google.com,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	peterz@infradead.org,
	dianders@chromium.org,
	pmladek@suse.com,
	arnd@arndb.de,
	torvalds@linux-foundation.org,
	kernel-team@meta.com,
	Al Viro <viro@zeniv.linux.org.uk>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 cmpxchg 07/13] parisc: add missing export of __cmpxchg_u8()
Date: Wed,  1 May 2024 16:01:24 -0700
Message-Id: <20240501230130.1111603-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

__cmpxchg_u8() had been added (initially) for the sake of
drivers/phy/ti/phy-tusb1210.c; the thing is, that drivers is
modular, so we need an export

Fixes: b344d6a83d01 "parisc: add support for cmpxchg on u8 pointers"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/parisc/kernel/parisc_ksyms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/parisc/kernel/parisc_ksyms.c b/arch/parisc/kernel/parisc_ksyms.c
index 6f0c92e8149d8..dcf61cbd31470 100644
--- a/arch/parisc/kernel/parisc_ksyms.c
+++ b/arch/parisc/kernel/parisc_ksyms.c
@@ -22,6 +22,7 @@ EXPORT_SYMBOL(memset);
 #include <linux/atomic.h>
 EXPORT_SYMBOL(__xchg8);
 EXPORT_SYMBOL(__xchg32);
+EXPORT_SYMBOL(__cmpxchg_u8);
 EXPORT_SYMBOL(__cmpxchg_u32);
 EXPORT_SYMBOL(__cmpxchg_u64);
 #ifdef CONFIG_SMP
-- 
2.40.1


