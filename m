Return-Path: <linux-arch+bounces-1800-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46572841364
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 20:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DECBCB2412D
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1C376036;
	Mon, 29 Jan 2024 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gVyAxVbI"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FF676020;
	Mon, 29 Jan 2024 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556411; cv=none; b=uhLaagN+k5KoMu8uFjLNusKVQMV/wz3tYAThfJyfADoLx3bs2CILEsmDPSoH+fkfnTrIowzG+4GDyC+lFeiQG9sjiwwXsllUctGUiPHlVohWEYUNh35p0UTdWuey4uM7oYU0wvYrmqhU3KM33lX2IY7YTh9LjTWGzLz8BLAsnBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556411; c=relaxed/simple;
	bh=fWacdajCuKruy4IRIC3PfeCsbekc4brMNN4YQdaTalo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQRhUiZ1JKMMA29tYtPFQLf2NMso5Xtn2SeDXg1xZSuGoS/iSQGqZRxlNScSzti7Vkw84LUMv7rwURZ9S/kd27Nigp8RxUC7/WVjm6fyq5v1R+IZcnz9nOMSn7kXqDu6gx0osijjjjUcak0WEHZAofqnZtOe9TbnCjxsLs2EbL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gVyAxVbI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=StcUcdeBhMll4u6Z4i+H51owxL/+smnyRSjHl622094=; b=gVyAxVbI/Cx6Kpl28JvKZOP4tk
	57nEOoe6Sw4I2IkN5W6psqo4tGP5Gq3ZdR+GkxDCGugiLgnvDXU2pMiFvb80xUU6eXm28Ak5CXA2y
	G8Lk6q/0KXugythCeLCBYAX00gkMTnjDDGWrZ6sPBA6xaQs7Pr4Ek5NPJRkWIAJ55OwzUwBi22ckc
	/tVg8mBsT6PWGFCc04CitPe4u1ACSPzDWFFFewYOeE2vv2W7pytKtvYvjy8HTVrDb7WsRC2EwOddt
	uef/XXchE3++mqs/Oqpx8pexEnLD4kd5VYcxkCKAVhHrJDAfRB+mxjasCSn1z2S1qDpsyYW3Fw++/
	KLmSJaUw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUXHN-0000000E67v-2wh9;
	Mon, 29 Jan 2024 19:26:49 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: masahiroy@kernel.org,
	deller@gmx.de
Cc: mcgrof@kernel.org,
	arnd@arndb.de,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] vmlinux.lds.h: add missing alignment for symbol CRCs
Date: Mon, 29 Jan 2024 11:26:42 -0800
Message-ID: <20240129192644.3359978-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129192644.3359978-1-mcgrof@kernel.org>
References: <20240129192644.3359978-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Commit f3304ecd7f06 (linux/export: use inline assembler to populate
symbol CRCs") fixed an issue with unexpected padding  by adding
asm inline assembly to directly specify the desired data layout.
It however forgot to add the alignment, fix that.

Reported-by: Helge Deller <deller@gmx.de>
Fixes: f3304ecd7f06 ("linux/export: use inline assembler to populate symbol CRCs")
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/export-internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
index 69501e0ec239..51b8cf3f60ef 100644
--- a/include/linux/export-internal.h
+++ b/include/linux/export-internal.h
@@ -61,6 +61,7 @@
 
 #define SYMBOL_CRC(sym, crc, sec)   \
 	asm(".section \"___kcrctab" sec "+" #sym "\",\"a\""	"\n" \
+	    ".balign 4"						"\n" \
 	    "__crc_" #sym ":"					"\n" \
 	    ".long " #crc					"\n" \
 	    ".previous"						"\n")
-- 
2.42.0


