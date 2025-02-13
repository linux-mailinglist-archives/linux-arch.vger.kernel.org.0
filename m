Return-Path: <linux-arch+bounces-10139-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0A3A33EC2
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2025 13:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0A23A16A9
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2025 12:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8915421D3FE;
	Thu, 13 Feb 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAZcqoOc"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEFB227EBD;
	Thu, 13 Feb 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448388; cv=none; b=rAsAOc6yw68C/47YgYSwuBCA8pcTzVilTsguq+R3jdRLlKi2IEAAal6h1ITcYZqXfH7Jemc9lm7vo/eqkZzIXsXUCiqJaJRUUI9q2ZTswzWN6qiygkHXNcj9B2G49+mjdDLUgpvXf2G/nqoCA4Dp89Vg29A2097ymSeZelJjbTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448388; c=relaxed/simple;
	bh=heN5uzw9akfWGw1tZbJvgZxzr34v25wO2kkfWNOwXhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIaE/6LfkrUtv0HNO0QZa+dK9o8elWrgJwg0ou5U5YR07HZ3jDBCBxMN6mbtn0yQQQB/RgZHI/t7EYBRGl+6nPk+a1jJYr+jtCzWp0vvebeBaLMvuyFIIOYkir8cVnlORc2i/gp7DgFiXSw9rm95GvCllIce9jiRP70fp1VCA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAZcqoOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64DCC4CED1;
	Thu, 13 Feb 2025 12:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739448387;
	bh=heN5uzw9akfWGw1tZbJvgZxzr34v25wO2kkfWNOwXhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NAZcqoOc8qkNBk/QG3pFaUHHwH5J3tbsED7ru4bOKulXrw1JpJoaD0dCZ3kuw2g4w
	 80FlRmvxafhzTCGgg1EsBDXcn3A84MEZQ9IVu+/ebbk3K+u50HPxFKI7A4VQnCBK0Z
	 xEM9uJMd3d4LkvZwetBnQUgSHajHK5YD8Ywbn+o9Hi/iz+/TNcj287lWMowJl6zrmu
	 iyYharUCVHxQ9hh4DN4sgb0lay5b7a28BUgrluK8XyYQAWTU7FJtpPC5o3W2c7vNm3
	 aJqhwgJDE1ar0A9eq55bbNb1Y6kfv/lhVD8nXmr3lw/MEWcLLDLYMI5zh9JGCsXhdV
	 n9VQ6aqKwR09A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tiXz7-0000000BIV3-1OV4;
	Thu, 13 Feb 2025 13:06:25 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFCv2 1/5] include/asm-generic/io.h: fix kerneldoc markup
Date: Thu, 13 Feb 2025 13:06:14 +0100
Message-ID: <6d69b25e9c720e0e7fc037928695ece7c8a35034.1739447912.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739447912.git.mchehab+huawei@kernel.org>
References: <cover.1739447912.git.mchehab+huawei@kernel.org>
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


