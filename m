Return-Path: <linux-arch+bounces-665-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D77038044A2
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 03:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872F01F212B9
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 02:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DCE4C69;
	Tue,  5 Dec 2023 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ftqyCDwP"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A014F11F;
	Mon,  4 Dec 2023 18:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+ftBbukfbbgB/3/4QoTvmiqqpacNNyeFRNlaZmcdRVg=; b=ftqyCDwPPLwgkHLsUwmdm5vWdw
	3X8jVP2KGrZwzU8ISQlnPaZR+3nV/h0rwQIbnwWAHv1JjQIguquG0DAAe0sUN9N8xt5/zXi4eki8X
	5Kh6Y7Pfu7JuId3EUU+4h99/T757qoM7cEDBC4akHwXD2q9dUa9HQU87f2XAv0PFWsb2K/IZChimn
	CJYFuYkIe0OAGcQ6GhZBSkfItbtxgyBjxz+xF18eDfYyGKlSkQsp/iC8N8JSQdwZ39MnvdxcbYuF2
	h9ksaoDjqeqHqVYtW9jA9j4+Mij2xp6Nlz0H0vCfOtI4g/S4pijHmS6oZ2IxnLqQJw2z5eC2Yfod4
	++f++LEQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAL6j-007937-2f;
	Tue, 05 Dec 2023 02:24:21 +0000
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
Subject: [PATCH v2 09/18] mips: pull include of asm-generic/checksum.h out of #if
Date: Tue,  5 Dec 2023 02:24:08 +0000
Message-Id: <20231205022418.1703007-17-viro@zeniv.linux.org.uk>
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
 arch/mips/include/asm/checksum.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index 1e49fd107da1..061b56163668 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -12,9 +12,7 @@
 #ifndef _ASM_CHECKSUM_H
 #define _ASM_CHECKSUM_H
 
-#ifdef CONFIG_GENERIC_CSUM
-#include <asm-generic/checksum.h>
-#else
+#ifndef CONFIG_GENERIC_CSUM
 
 #include <linux/in6.h>
 
@@ -237,7 +235,8 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	return csum_fold(sum);
 }
 
-#include <asm-generic/checksum.h>
 #endif /* CONFIG_GENERIC_CSUM */
 
+#include <asm-generic/checksum.h>
+
 #endif /* _ASM_CHECKSUM_H */
-- 
2.39.2


