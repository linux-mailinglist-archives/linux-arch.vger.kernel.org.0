Return-Path: <linux-arch+bounces-421-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 782327F5D3F
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 12:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89CC1C20E06
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 11:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1164D22EE7;
	Thu, 23 Nov 2023 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXSKUa80"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9C2200CD;
	Thu, 23 Nov 2023 11:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32336C433C8;
	Thu, 23 Nov 2023 11:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700737528;
	bh=PTPvyroKGj+bJmSOqebpW9CjBUzzYiO7xPn/MeixGLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXSKUa807rZ29ZDLQfJmvRhSi4N8WHovmHbAfyMVEficfSwAV9byFeM2EehuHMPvf
	 2plHjQPIGprL9a+CvVI91LktsH4dCLOTw85PLAzRHbTDWS8PBJ+HD6a6zbcFYzYA7S
	 /LF4mUwnNE/22hs/ycyxoIHFHiNWy/JLf4Gu9DuVWVIbobN3N9tuy8iVJrVYE3ouLt
	 kJi1liD6r+5hhz0cNDST79u04zevwc68Rku5RvjzatdqYLmQop3cbiP1tDQ8ikihWg
	 Ed5QrWidUanGzm2kwC1ytck42YRJYbIN/BD477srlxzuaH3tVo4HVndRuycbh+BrmA
	 FTpBsaIVkDHAA==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matt Turner <mattst88@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Peter Zijlstra <peterz@infradead.org>,
	Rich Felker <dalias@libc.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Richard Weinberger <richard@nod.at>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-sh@vger.kernel.org,
	linux-usb@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v3 1/6] ida: make 'ida_dump' static
Date: Thu, 23 Nov 2023 12:05:01 +0100
Message-Id: <20231123110506.707903-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123110506.707903-1-arnd@kernel.org>
References: <20231123110506.707903-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

There is no global declaration for ida_dump() and no other
callers, so make it static to avoid this warning:

lib/test_ida.c:16:6: error: no previous prototype for 'ida_dump'

Fixes: 8ab8ba38d488 ("ida: Start new test_ida module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/test_ida.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_ida.c b/lib/test_ida.c
index b06880625961..f946c80ced8b 100644
--- a/lib/test_ida.c
+++ b/lib/test_ida.c
@@ -13,7 +13,7 @@ static unsigned int tests_run;
 static unsigned int tests_passed;
 
 #ifdef __KERNEL__
-void ida_dump(struct ida *ida) { }
+static void ida_dump(struct ida *ida) { }
 #endif
 #define IDA_BUG_ON(ida, x) do {						\
 	tests_run++;							\
-- 
2.39.2


