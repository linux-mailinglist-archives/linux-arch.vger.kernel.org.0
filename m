Return-Path: <linux-arch+bounces-673-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA56C8044B4
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 03:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AACAB20B34
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 02:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F6A6AA0;
	Tue,  5 Dec 2023 02:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TG/QAcsi"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEA3CE;
	Mon,  4 Dec 2023 18:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yKvqmq+5jHD+XGPNm1nT/5MD5KNh5HIfxm0EQcxHIB4=; b=TG/QAcsiFAjEPFAhuK6dCGmPHP
	zrLw07/EQnEIW1+BZTHAIV2eDcgXxm7gUSr+lyX3abH3VfELwVV5+ftXhRjf7UrtltA2UExVj25tE
	IYAXVVSHUHa3/Oi9En5rcLaObFF7mIkttR4jw9JjsQVfPce4z11svXT0c/e8Wx7OW0ugdm8cxrrBK
	4zLz3d90+BAtwmR906FL8EML9YJKchG01EnEQFKs0Sbkme6nbxU/GSmHxyMTfSdCkZx2q8CIEUn4F
	CtzTxsGSeAESEIeKYEJKwD+dIrJFG5XrGzgPbvSQX9CGtBUMVogdGuuv1ILZIUXf6uimRnDqjG9F5
	IArjDOzg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAL6i-00792E-0C;
	Tue, 05 Dec 2023 02:24:20 +0000
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
Subject: [PATCH v2 05/18] bits missing from csum_and_copy_{from,to}_user() unexporting.
Date: Tue,  5 Dec 2023 02:24:00 +0000
Message-Id: <20231205022418.1703007-9-viro@zeniv.linux.org.uk>
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
 arch/arm/kernel/armksyms.c   | 1 -
 arch/mips/lib/csum_partial.S | 2 --
 arch/sparc/lib/csum_copy.S   | 2 +-
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index d076a5c8556f..5c2a5cf2e550 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -55,7 +55,6 @@ EXPORT_SYMBOL(arm_delay_ops);
 
 	/* networking */
 EXPORT_SYMBOL(csum_partial);
-EXPORT_SYMBOL(csum_partial_copy_from_user);
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
 EXPORT_SYMBOL(__csum_ipv6_magic);
 
diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index b0cda2950f4e..d27a25b653bf 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -743,9 +743,7 @@ FEXPORT(__csum_partial_copy_nocheck)
 EXPORT_SYMBOL(__csum_partial_copy_nocheck)
 #ifndef CONFIG_EVA
 FEXPORT(__csum_partial_copy_to_user)
-EXPORT_SYMBOL(__csum_partial_copy_to_user)
 FEXPORT(__csum_partial_copy_from_user)
-EXPORT_SYMBOL(__csum_partial_copy_from_user)
 #endif
 __BUILD_CSUM_PARTIAL_COPY_USER LEGACY_MODE USEROP USEROP
 
diff --git a/arch/sparc/lib/csum_copy.S b/arch/sparc/lib/csum_copy.S
index 9312d51367d3..13b7e01af133 100644
--- a/arch/sparc/lib/csum_copy.S
+++ b/arch/sparc/lib/csum_copy.S
@@ -34,6 +34,7 @@
 
 #ifndef FUNC_NAME
 #define FUNC_NAME	csum_partial_copy_nocheck
+EXPORT_SYMBOL(csum_partial_copy_nocheck)
 #endif
 
 	.register	%g2, #scratch
@@ -67,7 +68,6 @@
 
 	.globl		FUNC_NAME
 	.type		FUNC_NAME,#function
-	EXPORT_SYMBOL(FUNC_NAME)
 FUNC_NAME:		/* %o0=src, %o1=dst, %o2=len */
 	LOAD(prefetch, %o0 + 0x000, #n_reads)
 	xor		%o0, %o1, %g1
-- 
2.39.2


