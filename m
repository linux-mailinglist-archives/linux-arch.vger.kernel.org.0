Return-Path: <linux-arch+bounces-407-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C599C7F5335
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 23:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE0928144C
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 22:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234111F95D;
	Wed, 22 Nov 2023 22:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDxAjeN0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018541F60A;
	Wed, 22 Nov 2023 22:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC02C433CC;
	Wed, 22 Nov 2023 22:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700691502;
	bh=naPsrd6dgZmrcqFRnBTJLF85zK+mznbfmwCxwvHg1bc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DDxAjeN0PF56HLuHq+owxFyRf1SXkUc0Z3SIxrGBECInqJ9bI5WTebiKUjB+kdXgc
	 4GAAJFWkwGKOeLi4wqgSc5qKmWrSDg2dC/VcMaTpnvQB/ctWee/LrWjppfZMvUUEZT
	 +Xt4fRitwdPMjB5F1t2+G/fVNeDMtj/EVVXtakgp2AUggs4s5bljxWU2MTDNSB4ElI
	 e5d9Yb4xkQhock5YbwJnwZ+TbIKMpPf7s/cT+0vH51VrCbGGPqjMw2BFSh1//YguKf
	 ZXpMGYJ71+KG4ilzh78AGFUUbGJIONjGDFGHncsmOLm0RinIWC8kHlcjJce+uJ0aNU
	 YM+gqd4jArNIg==
From: deller@kernel.org
To: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-modules@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/4] modules: Ensure 64-bit alignment on __ksymtab_* sections
Date: Wed, 22 Nov 2023 23:18:12 +0100
Message-ID: <20231122221814.139916-3-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231122221814.139916-1-deller@kernel.org>
References: <20231122221814.139916-1-deller@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Helge Deller <deller@gmx.de>

On 64-bit architectures without CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
(e.g. ppc64, ppc64le, parisc, s390x,...) the __KSYM_REF() macro stores
64-bit pointers into the __ksymtab* sections.
Make sure that those sections will be correctly aligned at module link time,
otherwise unaligned memory accesses may happen at runtime.

The __kcrctab* sections store 32-bit entities, so use ALIGN(4) for those.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org> # v6.0+
---
 scripts/module.lds.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index bf5bcf2836d8..b00415a9ff27 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -15,10 +15,10 @@ SECTIONS {
 		*(.discard.*)
 	}
 
-	__ksymtab		0 : { *(SORT(___ksymtab+*)) }
-	__ksymtab_gpl		0 : { *(SORT(___ksymtab_gpl+*)) }
-	__kcrctab		0 : { *(SORT(___kcrctab+*)) }
-	__kcrctab_gpl		0 : { *(SORT(___kcrctab_gpl+*)) }
+	__ksymtab		0 : ALIGN(8) { *(SORT(___ksymtab+*)) }
+	__ksymtab_gpl		0 : ALIGN(8) { *(SORT(___ksymtab_gpl+*)) }
+	__kcrctab		0 : ALIGN(4) { *(SORT(___kcrctab+*)) }
+	__kcrctab_gpl		0 : ALIGN(4) { *(SORT(___kcrctab_gpl+*)) }
 
 	.ctors			0 : ALIGN(8) { *(SORT(.ctors.*)) *(.ctors) }
 	.init_array		0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }
-- 
2.41.0


