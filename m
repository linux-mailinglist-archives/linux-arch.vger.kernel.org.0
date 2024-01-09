Return-Path: <linux-arch+bounces-1312-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2D882886C
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 15:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1847B1C24556
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 14:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F01439ACF;
	Tue,  9 Jan 2024 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="roCY5IWt"
X-Original-To: linux-arch@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC36039AC0;
	Tue,  9 Jan 2024 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704811582; bh=kW1dPczTH04Crl0tbFUCfcQMkxib/V9/fWFO15vd0ac=;
	h=From:To:Cc:Subject:Date;
	b=roCY5IWtGteTzczcJ6Rg5jYCIT2mgvePdtxbY/m+xxSpnwzFi+pnsyBqdLsBvAyCp
	 vpsfKa/TnPiX9K2O1LLNTDqCHGKbhkUdgIT7i/h2EG43+3eUKlfimWPQ5P/uSolojh
	 8GCX0wl1jLQ99XCyTmwkdPWatoLOSjUf+J45nRNk=
Received: from cyy-pc.lan ([2001:da8:c800:d084:c65a:644a:13d7:e72c])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id B8806A65; Tue, 09 Jan 2024 22:46:08 +0800
X-QQ-mid: xmsmtpt1704811568tjhw333a7
Message-ID: <tencent_13A0B6B4A3136E46CC448874232A9F956006@qq.com>
X-QQ-XMAILINFO: MJf32pulH481N5+721FHDLNIsCPMMppGeNjz2u6HG63swzGmnY8jwl7oe52Ui6
	 DZcnWAjXa93Z9dClvHOMcvdpYU5C73qTscOBPb3nCL/w9utGbUUuPUOZzN7MBkVXkpCd+qPRy7N+
	 irGWHzeIRxFpPzCzCCqN6rbJbQWqUt4zsAtXXTtH6sj+iWXDlCaIAvWx2qBogRRIkReNvy47Ytbq
	 7YE8wVeEMrTifNQx6S+aLlKdrdAyRu0lTDnt1tGsUzhXW31UtyDk6pydzCyL8ic+wvpmnrttyJ7o
	 XOnL3gRCVw6c2ZdxZdVrvQbgSeUhAY2dwhCAPbAuz3ft+BwYa+UJHiUtuNu1jKJNvMg+QNeCP9Qa
	 H0znsWzWa+9/WAQFFQYTxmCnaEPqQQB/XbUilTf9ZioykuQ/HrIctj/bOyJGQSgHcikt9D4SJS7N
	 whidKdbYGiFGMnHT32hV4yHMsLC2NBSG/P5rv4FtdSA4W2HJfultP74sQthjUFzAWULP2f1jYtXl
	 6FMToImFWmp7EValb6ILd5wxCgjv4nK3O6jYk11qDRpP5i6Y8Ns1SlIdH7APxo+uMSBeTRfzV6OL
	 7iU1KQ1nm9N75RU9mj1dax4MIAe8c3+3dQQkOdd6Usre6DmnwihTaLiFTh19ZsrebEYDf76PGNgx
	 8GtW3LzRINoW1QRZ5vCy0UUUNayOVFUGa2QsCG2/0PGZygcn7K+tQ4ZNnPQvlE5ySZrG027YkkeT
	 xnDvThWzmaEgBCmS5IGwU/bxkZv3BUH6OJ0X1kvR8xbsDGdzL29M0CdLYHUh7V3naGdTSJ4YZvXu
	 ThgkA8V0QZeVBCI+YqNDjf1a1S3RC28HiDGZ795GmtQBoQGcENZdg6Wk0Ybe9Q/Jd+I97sOOzX57
	 NykiS9ynUeeg6cNSHZnEc2g8o6cWALxP2/2+rHdZ6rgUxuxdyIQmBQeD98nFQNQ5dgtmZE0FPcSc
	 DCT1M/3VHEzZbo4g1ElO1o5YBlLJQ6uMp8ZjrhA9K048YtOv733gr1Jf4l6ebq
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Yangyu Chen <cyy@cyyself.name>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>,
	Alexander Potapenko <glider@google.com>,
	Mike Frysinger <vapier@gentoo.org>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH] asm-generic: flush icache only when vma->vm_flags has VM_EXEC set
Date: Tue,  9 Jan 2024 22:45:59 +0800
X-OQ-MSGID: <20240109144559.315476-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some ISAs like RISC-V, which may not support bus broadcast-based
icache flushing instructions, it's necessary to send IPIs to all of the
CPUs in the system to flush the icache. This process can be expensive for
these ISAs and introduce disturbances during performance profiling.
Limiting the icache flush to occur only when the vma->vm_flags has VM_EXEC
can help minimize the frequency of these operations.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 include/asm-generic/cacheflush.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index 84ec53ccc450..729d51536575 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -102,7 +102,8 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 	do { \
 		instrument_copy_to_user((void __user *)dst, src, len); \
 		memcpy(dst, src, len); \
-		flush_icache_user_page(vma, page, vaddr, len); \
+		if (vma->vm_flags & VM_EXEC) \
+			flush_icache_user_page(vma, page, vaddr, len); \
 	} while (0)
 #endif
 
-- 
2.43.0


