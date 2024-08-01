Return-Path: <linux-arch+bounces-5822-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 358CF944434
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 08:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C25284224
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 06:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7E9170A28;
	Thu,  1 Aug 2024 06:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Krg1nriO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EB3157A61;
	Thu,  1 Aug 2024 06:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492831; cv=none; b=lhP7zkFDDrjWakGcX/AhiRwpMFOf/TJPEEzyu+oWJKYJdDnSxpuCb2E3miV5SZUUfp4ikjSXSKuihwRKAYyN0uWbdPTpd+oxm9OAMF7H4qzvyRBRMz1kxV9N4R/0MIilawgbG+kvSq6jXkFXdXn7OzMs5E018D66v3e9FjRLPoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492831; c=relaxed/simple;
	bh=2z4bHnWIWcvxAiFTLgSYfPcGY4CSFltdU+BtR9hEENA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsHMjGs1DPreEDY+ebC1gSMGjxZotK3FF9xWXvYGcfT/Sn8dk7Gg9GD6X3e7W2vcUMfQodFT5gQLYi/u+t3NYKUJQgOjxZYqDXmL9rc43BC85nramEy7QmDZNnqGh6XwSGT39196WjnajkNIjS7QndicpEUz99UHO91Wujl0n/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Krg1nriO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97316C4AF0E;
	Thu,  1 Aug 2024 06:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722492830;
	bh=2z4bHnWIWcvxAiFTLgSYfPcGY4CSFltdU+BtR9hEENA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Krg1nriO+eqnJw/SwdbuG3fCazMoLJlQMveWlRkHWmGKjUeBAV7SPEb3qpYrtisDR
	 zcMTZ9ucUhsZWHm5P0W+e7OwiQbmCzYDNW0O0KB9bpGyPbYgbomgp6evmqSqJK760o
	 G3tlRtfaCIlHRTSAxX+B6jfurNE/P42/ILnPuKFYuvjt2jr3XDTpBGpJgTe69srkyE
	 T7HP4P7RrEbKkHv+Z2WcA38kANShZuYnsFLoO9R+x/ze0wRTfzDScZQnHsTT0bkqEp
	 r3/pInPgL1sn+CE/kAYEoSxGqH/IFD6WOJQ4wImNEhfM2qe3oPpI8DAV+mZ7uJVllq
	 swnBD4lW/yIiw==
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
Subject: [PATCH v3 26/26] docs: move numa=fake description to kernel-parameters.txt
Date: Thu,  1 Aug 2024 09:08:26 +0300
Message-ID: <20240801060826.559858-27-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801060826.559858-1-rppt@kernel.org>
References: <20240801060826.559858-1-rppt@kernel.org>
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


