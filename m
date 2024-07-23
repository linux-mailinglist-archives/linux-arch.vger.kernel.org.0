Return-Path: <linux-arch+bounces-5583-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4EC939B0F
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 08:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C064F2847D1
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 06:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4514114E2CF;
	Tue, 23 Jul 2024 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNLg86Jy"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13E714C581;
	Tue, 23 Jul 2024 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717229; cv=none; b=fn5fAohQp9rbdMs0L4Ip4aFArr6HIoDYMrxhUwbEagtUnLNlZNvkS5YmreCgOEj34F2IN+9+0/sxobHvxogUZYdrqdkKT9KnrBHPuwLD8zRc7xuEQs4zEqyPOnQWCHvk19W/eWRqoPhzs6z7XTHBZ63LHkmVr9EkCzyQyY5AdNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717229; c=relaxed/simple;
	bh=XhBFop5H8bMuMnCv+pTVRkvsNA1D1d9rM83bQqfOsbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qw8UwVVAYW0kNbHWuHwLfbt0Cm8dmJXGnePh8QGEqfllpHrRxyyGjWAigpIbhkBfWloSx1fk0xT//esojPCjbqqs6Kfer8mPypCmF1qdnuBOx2IXPpjP1Jp34JVJaTWdul6tcB5nONkkTU1yNmUrY5avFf4sm91BVrcC+vKKGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNLg86Jy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E7AC4AF10;
	Tue, 23 Jul 2024 06:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721717228;
	bh=XhBFop5H8bMuMnCv+pTVRkvsNA1D1d9rM83bQqfOsbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QNLg86Jyt1YyzxPEeX6D3F4KpgxoIA7kTTXU/4Vh40COSg2P7gWaFbk2wTlGFfl4o
	 8VEFN0QnIMlGVDL9MQTFK1P9wKPcdxA6llZjn9naPajN8ELpS3/Hl6z/d8bIhTz8Bo
	 crTLjwLalT1F0qF/XNoilpQdEa5ncV0aAZ/SpaB+6WLDO664rMOj6P6DtDnIvhdGiU
	 c2Pr42NhZgqI9ZRisEeKX6Fejq+BKDo4BMOie7hVHOHzopjON0xM1GAA3kppApeLKE
	 /0wmyOuJJNxXMREyX7/3OLD4TIDGDkn7CPLTl9q6nZ36lvACr6Abe1/mdtFq4g6M3X
	 VaFW/sr1c5HuQ==
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
	x86@kernel.org
Subject: [PATCH v2 25/25] docs: move numa=fake description to kernel-parameters.txt
Date: Tue, 23 Jul 2024 09:41:56 +0300
Message-ID: <20240723064156.4009477-26-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723064156.4009477-1-rppt@kernel.org>
References: <20240723064156.4009477-1-rppt@kernel.org>
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
---
 Documentation/admin-guide/kernel-parameters.txt | 15 +++++++++++++++
 Documentation/arch/x86/x86_64/boot-options.rst  | 12 ------------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 27ec49af1bf2..d64e27768429 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4158,6 +4158,21 @@
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


