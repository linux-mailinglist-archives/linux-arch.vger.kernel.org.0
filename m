Return-Path: <linux-arch+bounces-2173-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97DF850D24
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 05:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707DF28641A
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 04:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC7753A1;
	Mon, 12 Feb 2024 04:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VVAl/WKS"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A47C538D;
	Mon, 12 Feb 2024 04:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707712031; cv=none; b=Vravpx/74InXmAN2s+RSl7UmIixekB4DtIYVyaoLGDkufI2KUNqNurVXxGk9GjOrKJEsWA+ViuaI4Ni3w2/zJhx9Q3nhE1w9Ip8IHLUjPiQjEPMs7ZaiWXjgoRbrVwN9HV8KyNZdoNhovXoYJBziCEoNBpul0Uahih3EEENHNJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707712031; c=relaxed/simple;
	bh=PI7OsLMBcGqvxQAELryVmcH2/hBuWkPphtMfo+aLq18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f4bMwhxU88x2h/zZS4jphMJFmA3QFznbIaMOT1P4G98zzuQX8tV/AfWEuig4Nn7eT2/KFuSDOlipAizgcFc9n3mmOOkaK9mfLhtBI0yTOELHgsg6oRMMFxTOOvN0bPioOCGtqeOpvpX7A5EL6YMIovnL50btKppxTHmkEtd78Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VVAl/WKS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=3zU9qWCg0noGR4z5kjUevqgcV3l4ea81bsNQeNCgnKI=; b=VVAl/WKSlhOou0KvishC96wmu9
	w5jzd/YP2sYMX9CznDgnfww9H5rQqaEi7pymo197s3GlgZbVky0PO3NN0iJKmssZZRZL8kSHCx3h/
	f8dhN8ZBRCvro6M1v0FejJ9zzL933bXhQ+gH7ac7d1+1KxkAsD7SS3/LF8SZh+1VH0Hq/pDpa21le
	SyyS5o9elVYGoPBUh9993iWKAdaTwIOY/juFIEqYH8RraGKJAOFa0z0pR6v7terSSTLj4xF91UxKI
	gnTD81xt8KhSgbMAFCwYxcKJK83kBP0qh9eZQ+IJKrpMSywn/5oNt/tITQVmq1/zXgMJELrlbJo73
	CzZSYIoA==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZNuO-00000004IVh-3WIv;
	Mon, 12 Feb 2024 04:27:08 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: [PATCH RESEND] asm-generic/io.h: fix grammar typos
Date: Sun, 11 Feb 2024 20:27:07 -0800
Message-ID: <20240212042707.13006-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct grammar mistakes.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
---
 include/asm-generic/io.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/include/asm-generic/io.h b/include/asm-generic/io.h
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1019,12 +1019,12 @@ static inline void *phys_to_virt(unsigne
  *
  * Architectures with an MMU are expected to provide ioremap() and iounmap()
  * themselves or rely on GENERIC_IOREMAP.  For NOMMU architectures we provide
- * a default nop-op implementation that expect that the physical address used
+ * a default nop-op implementation that expects that the physical addresses used
  * for MMIO are already marked as uncached, and can be used as kernel virtual
  * addresses.
  *
  * ioremap_wc() and ioremap_wt() can provide more relaxed caching attributes
- * for specific drivers if the architecture choses to implement them.  If they
+ * for specific drivers if the architecture chooses to implement them.  If they
  * are not implemented we fall back to plain ioremap. Conversely, ioremap_np()
  * can provide stricter non-posted write semantics if the architecture
  * implements them.

