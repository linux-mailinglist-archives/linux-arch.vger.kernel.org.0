Return-Path: <linux-arch+bounces-10332-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 204ACA4183A
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2025 10:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6156216F3B4
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2025 09:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB9A245025;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BH7uhf5h"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E979245019;
	Mon, 24 Feb 2025 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388143; cv=none; b=AeGqyWfBaFzC5RKKRC+P46FkuBqZYoxp44dkEFh2o0B1XqveOpddZhiAfOZIjQY52TSvBFMoIzobyPqlucsZGqRo9UUWREGiNoG/WJGg3SfHzyAHD9bJGEpJMybeXp0WBsJAN9yiFTHOyQFJ60mXAHIt/zjg7GalrqLNcvK8bps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388143; c=relaxed/simple;
	bh=aeuqk5Ez6XBK1bcBiwdwu3D8K0LeqXVto+XLcOhJeWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/c5dfBdbfA8o3iFlEcNujEkZHd3OgZZTNt8zEaKA2Hv742hvp5bwoxr4hO3PsjdcEkHrFptjQ7hxS/TPa4MBdn+5gJ/I9gYnoNCUu9RT6B7cAWesiEX7YZbYlI+prlgpO2Hhl3GWbrNFAIIalTguHRxpB2wK0cReECz1B4YwW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BH7uhf5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0513C4CED6;
	Mon, 24 Feb 2025 09:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388142;
	bh=aeuqk5Ez6XBK1bcBiwdwu3D8K0LeqXVto+XLcOhJeWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BH7uhf5hdCSjBbtEmHZxu97pqEwi708sPDnqlCChf7VeABCdQb5l8WqNHLCVAWVH2
	 nGOrmEVc4cwu5nEKQrr1c+sXSt9amTOFhqm3ZeWFCCAlS2TUoMRtwjHL79qe8/Jx53
	 qhdcWnJbrggcogk7KZTXZf/NGNisKGXs6Rm96hVdalJYKMyZ2lTYhvuFG5udczm/Ai
	 mWLfesW+eiZsp2pymw/Vj8T2ZdSLDVyeUyZSaPeAPpYOGt50dGuzLXpYbzfTsTgcGY
	 /YR4Rje51xJ75BY2FOEvjv4OhtJ26kMniBYXd35917ByAOWsgkkFFGvgaHiOWh4zlT
	 CTiBei3J5b99A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUSS-00000003p3U-3Nqo;
	Mon, 24 Feb 2025 10:09:00 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/39] include/asm-generic/io.h: fix kerneldoc markup
Date: Mon, 24 Feb 2025 10:08:07 +0100
Message-ID: <066968c00196ed88f6dc97e3d317926fc4ab7d52.1740387599.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740387599.git.mchehab+huawei@kernel.org>
References: <cover.1740387599.git.mchehab+huawei@kernel.org>
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


