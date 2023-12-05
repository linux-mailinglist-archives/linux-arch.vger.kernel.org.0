Return-Path: <linux-arch+bounces-680-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0DE8044B7
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 03:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10951C20A5A
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 02:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE0C4C69;
	Tue,  5 Dec 2023 02:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rdXV8YLe"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF228191;
	Mon,  4 Dec 2023 18:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BOlDhXErEGL5vq9/qi5YxTCcpTGQOTXCdpaBafqvR+8=; b=rdXV8YLeqaYLb41yEuhx8J99j9
	Ot+YALUdjpRHPsNgo9UV53/kLiaA3i1xnEfb6bNdzOKEoCMH3cJ6CAvVnxzYxnMg7YNhBPy4FrUmR
	A1k1HkN9QXcPEXeF7wkacoDVqZzPm8hCPHPevxGuj/39ENbuOheMrG5ZTHxjOeyqZPOnebmwTZclP
	06FvfH7OccZtLTZNqfYuKEVOpQirWvBSEFZS56OvIYiu+QTbEUjCK/zp8s/7ma+ctLHxF4rBo2+Pa
	FXJx76gLoNuZKPL2RS5ivNgUjXhZOh9xn1+FwatyvQMsCvn6xlB8iIfJkdi5SmbeOt2GaqYEl4XIU
	F56F8KVw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAL6l-00793l-0G;
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
Subject: [PATCH v2 14/18] amd64: saner handling of odd address in csum_partial()
Date: Tue,  5 Dec 2023 02:24:14 +0000
Message-Id: <20231205022418.1703007-23-viro@zeniv.linux.org.uk>
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

all we want there is to have return value congruent to
result * 256 modulo 0xffff; no need to convert from
32bit to 16bit (i.e. take it modulo 0xffff) first -
cyclic shift of 32bit value by 8 bits (in either direction)
will work.

Kills the from32to16() helper and yields better code...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/lib/csum-partial_64.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index 5e877592a7b3..192d4772c2a3 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -11,25 +11,13 @@
 #include <net/checksum.h>
 #include <asm/word-at-a-time.h>
 
-static inline unsigned short from32to16(unsigned a)
-{
-	unsigned short b = a >> 16;
-	asm("addw %w2,%w0\n\t"
-	    "adcw $0,%w0\n"
-	    : "=r" (b)
-	    : "0" (b), "r" (a));
-	return b;
-}
-
 static inline __wsum csum_tail(u64 temp64, int odd)
 {
 	unsigned int result;
 
 	result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
-	if (unlikely(odd)) {
-		result = from32to16(result);
-		result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
-	}
+	if (unlikely(odd))
+		result = rol32(result, 8);
 	return (__force __wsum)result;
 }
 
-- 
2.39.2


