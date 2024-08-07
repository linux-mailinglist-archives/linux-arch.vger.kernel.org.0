Return-Path: <linux-arch+bounces-6098-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF1694A10A
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 08:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F6FDB21A6C
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 06:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589C61BB6BF;
	Wed,  7 Aug 2024 06:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IN10SVfP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112B21B86DF;
	Wed,  7 Aug 2024 06:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013203; cv=none; b=UcIsDznz6i0kBNu1Dp/D7a+cXUz6WENGjNNLliwAaXMz4qAm0bOAQ3ZmmifpHjeldL1onSagulYs7ab1gRQwtxwZIW5g8yPYRUJNifHI9/6HCJy9KOn8sS/KxGiSMp7QZs/HJpScOPzf0ZnIMkJ3Em5d9ndHgfR9tZX3/2PLMhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013203; c=relaxed/simple;
	bh=mSVpkyrRlmc8gB/6cofdu7bK0SP2SFlikATxtCiu+1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FguULqNOJQ1Ks64ypQyp+IN38kGIEzk5bG0JNINVJhafzfMoYO3nDbngkk+JZUWxnSSHfjVv1lsR9JzbqtFzJdngoT3PWXBdfmYJOlth3FvT8PlMGYPhMCRKjkghmqTRHRYigj982VSSVUNTAyJVS+TBb1hlAlOoBnAHpt1LNik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IN10SVfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF8AC32782;
	Wed,  7 Aug 2024 06:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723013202;
	bh=mSVpkyrRlmc8gB/6cofdu7bK0SP2SFlikATxtCiu+1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IN10SVfP1ekyZrWQRi9UxJMep+tmuEWFmv5b8/EQkN2D/blJP8VDf2x14svnDTZPL
	 o8kAnGxStd/1zLKk4F1PH0VzY4pDSS/4dQY7Vxur783cRbUwO618mIeFJMNOi+4j/v
	 rZHa9+AOwuemUocpGbUEIASRGMQ4U2lEyMK8w9MoPuWsM9VMktGWNMVkWyanO8yAF7
	 lqxMob7NGVsEgyNaaDriMRMZIoJJHtaeYqcFkeOqMGnvq7l+Vxj8UOH/qXBNJhl7iT
	 f/DtdjeDNGa5SC0m1U2ZtlRAbaUYx14tdgmGqQRe+Lwqm6aOgi1JKpbYbsIb2zB2Gb
	 IYC7joAJCNuyA==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	nvdimm@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 26/26] docs: move numa=fake description to kernel-parameters.txt
Date: Wed,  7 Aug 2024 09:41:10 +0300
Message-ID: <20240807064110.1003856-27-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807064110.1003856-1-rppt@kernel.org>
References: <20240807064110.1003856-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

NUMA emulation can be now enabled on arm64 and riscv in addition to x86.

Move description of numa=fake parameters from x86 documentation of
admin-guide/kernel-parameters.txt

Suggested-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> [arm64 + CXL via QEMU]
Acked-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 15 +++++++++++++++
 Documentation/arch/x86/x86_64/boot-options.rst  | 12 ------------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1384c7b59c9..bcdee8984e1f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4123,6 +4123,21 @@
 			Disable NUMA, Only set up a single NUMA node
 			spanning all memory.
 
+	numa=fake=<size>[MG]
+			[KNL, ARM64, RISCV, X86, EARLY]
+			If given as a memory unit, fills all system RAM with
+			nodes of size interleaved over physical nodes.
+
+	numa=fake=<N>
+			[KNL, ARM64, RISCV, X86, EARLY]
+			If given as an integer, fills all system RAM with N
+			fake nodes interleaved over physical nodes.
+
+	numa=fake=<N>U
+			[KNL, ARM64, RISCV, X86, EARLY]
+			If given as an integer followed by 'U', it will
+			divide each physical node into N emulated nodes.
+
 	numa_balancing=	[KNL,ARM64,PPC,RISCV,S390,X86] Enable or disable automatic
 			NUMA balancing.
 			Allowed values are enable and disable
diff --git a/Documentation/arch/x86/x86_64/boot-options.rst b/Documentation/arch/x86/x86_64/boot-options.rst
index 137432d34109..98d4805f0823 100644
--- a/Documentation/arch/x86/x86_64/boot-options.rst
+++ b/Documentation/arch/x86/x86_64/boot-options.rst
@@ -170,18 +170,6 @@ NUMA
     Don't parse the HMAT table for NUMA setup, or soft-reserved memory
     partitioning.
 
-  numa=fake=<size>[MG]
-    If given as a memory unit, fills all system RAM with nodes of
-    size interleaved over physical nodes.
-
-  numa=fake=<N>
-    If given as an integer, fills all system RAM with N fake nodes
-    interleaved over physical nodes.
-
-  numa=fake=<N>U
-    If given as an integer followed by 'U', it will divide each
-    physical node into N emulated nodes.
-
 ACPI
 ====
 
-- 
2.43.0


