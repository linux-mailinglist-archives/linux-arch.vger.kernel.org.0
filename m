Return-Path: <linux-arch+bounces-432-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AD27F66E5
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 20:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52420281C04
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 19:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467424B5D7;
	Thu, 23 Nov 2023 19:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTZ3btdf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A25A4B5CA;
	Thu, 23 Nov 2023 19:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB6BC433CB;
	Thu, 23 Nov 2023 19:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700766287;
	bh=3ljL0Da911z3hmk5/gL8FYWs2N0kZXcYl6ny1yDDcSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LTZ3btdfPmyeES5lb/Fx+83WSn0LF7ztn8weW++kVE7xLL78yTNhb/ZjDM9GQudaH
	 VlF1lGFLLpcUu181spW7Jzu1P7KDFqT+dnfzn1QO5J/bEg6+nJaPRZ7txBXoIH4Ro8
	 hsDOVeNetBITsmNdcOpgtaBljWqGdTCLcdUGec9N/8sDZUE89yV0+MjZLa8B8HDRy3
	 2kMHgcEpUF9WNClvA4va2s3hdwW1Yu+ulnXwn2Z4Os1jf1xyFwntrl1kuHORk1ttXU
	 6XJ2/4/6x97FHIN7RO2MmcDSleInk6Pw1cy9pkhGfnewfc/nt6I0sYKIYlXd1S4ykx
	 6NOzaThMxbryA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org,
	llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Date: Thu, 23 Nov 2023 21:04:31 +0200
Message-ID: <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1700766072.git.leon@kernel.org>
References: <cover.1700766072.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

The kernel supports write combining IO memory which is commonly used to
generate 64 byte TLPs in a PCIe environment. On many CPUs this mechanism
is pretty tolerant and a simple C loop will suffice to generate a 64 byte
TLP.

However modern ARM64 CPUs are quite sensitive and a compiler generated
loop is not enough to reliably generate a 64 byte TLP. Especially given
the ARM64 issue that writel() does not codegen anything other than "[xN]"
as the address calculation.

These newer CPUs require an orderly consecutive block of stores to work
reliably. This is best done with four STP integer instructions (perhaps
ST64B in future), or a single ST4 vector instruction.

Provide a new generic function memcpy_toio_64() which should reliably
generate the needed instructions for the architecture, assuming address
alignment. As the usual need for this operation is performance sensitive a
fast inline implementation is preferred.

Implement an optimized version on ARM that is a block of 4 STP
instructions.

The generic implementation is just a simple loop. x86-64 (clang 16)
compiles this into an unrolled loop of 16 movq pairs.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 arch/arm64/include/asm/io.h | 20 ++++++++++++++++++++
 include/asm-generic/io.h    | 30 ++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 3b694511b98f..73ab91913790 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -135,6 +135,26 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
 #define memcpy_fromio(a,c,l)	__memcpy_fromio((a),(c),(l))
 #define memcpy_toio(c,a,l)	__memcpy_toio((c),(a),(l))
 
+static inline void __memcpy_toio_64(volatile void __iomem *to, const void *from)
+{
+	const u64 *from64 = from;
+
+	/*
+	 * Newer ARM core have sensitive write combining buffers, it is
+	 * important that the stores be contiguous blocks of store instructions.
+	 * Normal memcpy does not work reliably.
+	 */
+	asm volatile("stp %x0, %x1, [%8, #16 * 0]\n"
+		     "stp %x2, %x3, [%8, #16 * 1]\n"
+		     "stp %x4, %x5, [%8, #16 * 2]\n"
+		     "stp %x6, %x7, [%8, #16 * 3]\n"
+		     :
+		     : "rZ"(from64[0]), "rZ"(from64[1]), "rZ"(from64[2]),
+		       "rZ"(from64[3]), "rZ"(from64[4]), "rZ"(from64[5]),
+		       "rZ"(from64[6]), "rZ"(from64[7]), "r"(to));
+}
+#define memcpy_toio_64(to, from) __memcpy_toio_64(to, from)
+
 /*
  * I/O memory mapping functions.
  */
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index bac63e874c7b..2d6d60ed2128 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1202,6 +1202,36 @@ static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
 }
 #endif
 
+#ifndef memcpy_toio_64
+#define memcpy_toio_64 memcpy_toio_64
+/**
+ * memcpy_toio_64	Copy 64 bytes of data into I/O memory
+ * @dst:		The (I/O memory) destination for the copy
+ * @src:		The (RAM) source for the data
+ * @count:		The number of bytes to copy
+ *
+ * dst and src must be aligned to 8 bytes. This operation copies exactly 64
+ * bytes. It is intended to be used for write combining IO memory. The
+ * architecture should provide an implementation that has a high chance of
+ * generating a single combined transaction.
+ */
+static inline void memcpy_toio_64(volatile void __iomem *addr,
+				  const void *buffer)
+{
+	unsigned int i = 0;
+
+#if BITS_PER_LONG == 64
+	for (; i != 8; i++)
+		__raw_writeq(((const u64 *)buffer)[i],
+			     ((u64 __iomem *)addr) + i);
+#else
+	for (; i != 16; i++)
+		__raw_writel(((const u32 *)buffer)[i],
+			     ((u32 __iomem *)addr) + i);
+#endif
+}
+#endif
+
 extern int devmem_is_allowed(unsigned long pfn);
 
 #endif /* __KERNEL__ */
-- 
2.42.0


