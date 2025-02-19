Return-Path: <linux-arch+bounces-10211-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C2EA3B40F
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 09:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3881898A8D
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 08:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED341CD208;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5iNvIEi"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1501C82F4;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953972; cv=none; b=XKzuzH44PdV1cW2Qtul4619iflqk4Lw6FVL30vbCOiswlbjyvErodnn7PDS71MtlvnzdRwG46Hbw7vz92LaGOVE7Igfsc7Xc9TEmUdg44x6Th+y4Z13eMC0MJrAYrAJlyJFvxLkIrCwQqU/kJddEYvHm4yzZo1GScCfH1eqCVkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953972; c=relaxed/simple;
	bh=aeuqk5Ez6XBK1bcBiwdwu3D8K0LeqXVto+XLcOhJeWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pxb3khz+0ld4cNb7/f0/cUNbBzOx9+2RO+PExBTSCCnYDOMzjXrGyK+V6iXahixXHg88Ca9en+IBocOovYRfUcRrpi5Zx7nh8W7naMg39bJrgtccguB7xib0Ubx0ByeZESEp5fe5sSTYNv+f/ZEbtMu7kwUr8te2whQyIMzJ2lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5iNvIEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1077C4CEEB;
	Wed, 19 Feb 2025 08:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953971;
	bh=aeuqk5Ez6XBK1bcBiwdwu3D8K0LeqXVto+XLcOhJeWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J5iNvIEiipPo7GxZiDEnaXU1XLfO/KSoV40wNgDuzdBkGvyBgTXmcBvD1D9H4vhwn
	 eed7soqaUQvDVpTJHCn9zzFV3x9eozPWmr6Ce2c1tIgg1hGxS4b501DYJbCIhFszbg
	 +yZL0LT2qrquT/zsDmWZMD2Avv6noTkW8lv/TS5ALEXuNMr/4KiIYNqZdu/qjRIvS3
	 i/7AU4GfPTpynn3KfXkfcvkOKsCHKfdUCdb/COfmR691PghSIJu661FtiirymaYc4w
	 6sP3GdJLqoOsu4orpy2+rskNkvj5N75D5TEMCvxAu9aN9ky1foNW0Fj2B7M0nPCj7q
	 HZJQsmy2JyBXg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkfVh-0000000Gv4L-4122;
	Wed, 19 Feb 2025 09:32:49 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/27] include/asm-generic/io.h: fix kerneldoc markup
Date: Wed, 19 Feb 2025 09:32:17 +0100
Message-ID: <53fe92cda720035a5c72bc95a88a3d965bc9b1fc.1739952783.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739952783.git.mchehab+huawei@kernel.org>
References: <cover.1739952783.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Kerneldoc requires a "-" after the name of a function for it
to be recognized as a function.

Add it.

Fix those kernel-doc warnings:

include/asm-generic/io.h:1215: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * memset_io    Set a range of I/O memory to a constant value
include/asm-generic/io.h:1227: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * memcpy_fromio        Copy a block of data from I/O memory
include/asm-generic/io.h:1239: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * memcpy_toio          Copy a block of data into I/O memory

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/io.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index a5cbbf3e26ec..3c61c29ff6ab 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1212,7 +1212,7 @@ static inline void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
 
 #ifndef memset_io
 /**
- * memset_io	Set a range of I/O memory to a constant value
+ * memset_io -	Set a range of I/O memory to a constant value
  * @addr:	The beginning of the I/O-memory range to set
  * @val:	The value to set the memory to
  * @count:	The number of bytes to set
@@ -1224,7 +1224,7 @@ void memset_io(volatile void __iomem *addr, int val, size_t count);
 
 #ifndef memcpy_fromio
 /**
- * memcpy_fromio	Copy a block of data from I/O memory
+ * memcpy_fromio -	Copy a block of data from I/O memory
  * @dst:		The (RAM) destination for the copy
  * @src:		The (I/O memory) source for the data
  * @count:		The number of bytes to copy
@@ -1236,7 +1236,7 @@ void memcpy_fromio(void *dst, const volatile void __iomem *src, size_t count);
 
 #ifndef memcpy_toio
 /**
- * memcpy_toio		Copy a block of data into I/O memory
+ * memcpy_toio -	Copy a block of data into I/O memory
  * @dst:		The (I/O memory) destination for the copy
  * @src:		The (RAM) source for the data
  * @count:		The number of bytes to copy
-- 
2.48.1


