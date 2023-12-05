Return-Path: <linux-arch+bounces-676-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8738044B2
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 03:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B888FB20AFB
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 02:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E78D6AC0;
	Tue,  5 Dec 2023 02:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Yc6pmTWC"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92969107;
	Mon,  4 Dec 2023 18:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zPz4rykQwfacSAH0nWWTI708Z+TOJIpHH4duT4lMs50=; b=Yc6pmTWCRD6AXJXwlDC4RrIjDd
	OAFvLPG7P4UixmW2hIGf8ZKzKmRc33Tubhyau4vqxs78fLRW1r76fnXtPXd5EXKzwixXvTUv8LAS3
	P0Aw7l8dx4CPQHRlG+dKRPtGgOPAhZerdEkAbXdqynqaXAPStPkEyHF0H17BcEZ1msXdgHb8f0aY3
	33PuR6yUh7TNjRnpxYJXvGM7d2SqqjCjCL6Z8qpeYdlTkmI3/pkCkxuCOMVP7KpT5ECgJlBRL8xLq
	Y00NYi43jZY/Hm35zpoBgh7Q/Tg1XJoaMyW7a771W/ZSFBmjrsqQLkZzyWfn1YTBnZlkbIotHyHxB
	Qw9dIIZA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAL6l-007941-1k;
	Tue, 05 Dec 2023 02:24:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: gus Gusenleitner Klaus <gus@keba.com>,
	Al Viro <viro@ftp.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 16/18] x86: lift the extern for csum_partial() into checksum.h
Date: Tue,  5 Dec 2023 02:24:16 +0000
Message-Id: <20231205022418.1703007-25-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205022418.1703007-1-viro@zeniv.linux.org.uk>
References: <20231205022100.GB1674809@ZenIV>
 <20231205022418.1703007-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/checksum.h    | 12 ++++++++++++
 arch/x86/include/asm/checksum_32.h | 14 --------------
 arch/x86/include/asm/checksum_64.h | 12 ------------
 3 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/checksum.h b/arch/x86/include/asm/checksum.h
index 5c0a730c7316..05dd4c59880a 100644
--- a/arch/x86/include/asm/checksum.h
+++ b/arch/x86/include/asm/checksum.h
@@ -26,6 +26,18 @@ static inline __wsum csum_add(__wsum csum, __wsum addend)
 # define HAVE_CSUM_COPY_USER
 # define _HAVE_ARCH_CSUM_AND_COPY
 
+/**
+ * csum_partial - Compute an internet checksum.
+ * @buff: buffer to be checksummed
+ * @len: length of buffer.
+ * @sum: initial sum to be added in (32bit unfolded)
+ *
+ * Returns the 32bit unfolded internet checksum of the buffer.
+ * Before filling it in it needs to be csum_fold()'ed.
+ * buff should be aligned to a word boundary if possible.
+ */
+extern asmlinkage __wsum csum_partial(const void *buff, int len, __wsum sum);
+
 /**
  * csum_fold - Fold and invert a 32bit checksum.
  * sum: 32bit unfolded sum
diff --git a/arch/x86/include/asm/checksum_32.h b/arch/x86/include/asm/checksum_32.h
index 959f8c6f5247..164bf98fb23a 100644
--- a/arch/x86/include/asm/checksum_32.h
+++ b/arch/x86/include/asm/checksum_32.h
@@ -5,20 +5,6 @@
 #include <linux/in6.h>
 #include <linux/uaccess.h>
 
-/*
- * computes the checksum of a memory block at buff, length len,
- * and adds in "sum" (32-bit)
- *
- * returns a 32-bit number suitable for feeding into itself
- * or csum_tcpudp_magic
- *
- * this function must be called with even lengths, except
- * for the last fragment, which may be odd
- *
- * it's best to have buff aligned on a 32-bit boundary
- */
-asmlinkage __wsum csum_partial(const void *buff, int len, __wsum sum);
-
 /*
  * the same as csum_partial, but copies from src while it
  * checksums, and handles user-space pointer exceptions correctly, when needed.
diff --git a/arch/x86/include/asm/checksum_64.h b/arch/x86/include/asm/checksum_64.h
index c86db605c0fd..ce28f7c0bc29 100644
--- a/arch/x86/include/asm/checksum_64.h
+++ b/arch/x86/include/asm/checksum_64.h
@@ -11,18 +11,6 @@
 #include <linux/compiler.h>
 #include <asm/byteorder.h>
 
-/**
- * csum_partial - Compute an internet checksum.
- * @buff: buffer to be checksummed
- * @len: length of buffer.
- * @sum: initial sum to be added in (32bit unfolded)
- *
- * Returns the 32bit unfolded internet checksum of the buffer.
- * Before filling it in it needs to be csum_fold()'ed.
- * buff should be aligned to a 64bit boundary if possible.
- */
-extern __wsum csum_partial(const void *buff, int len, __wsum sum);
-
 /* Do not call this directly. Use the wrappers below */
 extern __visible __wsum_fault csum_partial_copy_generic(const void *src, void *dst, int len);
 
-- 
2.39.2


