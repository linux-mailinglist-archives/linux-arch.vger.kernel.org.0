Return-Path: <linux-arch+bounces-662-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F235C8044A7
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 03:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28ED3B20B47
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 02:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0E56122;
	Tue,  5 Dec 2023 02:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KaDecUGV"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72725CE;
	Mon,  4 Dec 2023 18:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=v4vafIp0lx9db/09meQhTdWX3KXD/90cqv4KIh7IvXU=; b=KaDecUGVJTBarWzcIdGONopl76
	81cGwcUbG9/pwyWFQgh8/vDOz2vsgw3usdmXo4MrunVxpOr4O20rFb8lmhRvPSg7HY5eVNADhYO/5
	tqt5FRY7HROjCgKesVoWICVmsWQjGxUlPDibUMP2QccKA5ZF1BFEU7RSvCs7EJMA3VS+Yzi5AgKdt
	9MgN/MtQITSeHHwxlDKeDHlxlF4rBztbzx9PoHnFKE9ZvG88kuSTZl3J+mKR/c8NyrOqrC7owExaG
	HClrfzbar1oV1rtQwVhUmrY/wVUy3UTZSZONtSGACzeawHxQGEvUyI9Od/tfjtHbym6fCECGYOw+R
	IswYVnHQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAL6g-00791y-1Q;
	Tue, 05 Dec 2023 02:24:18 +0000
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
Subject: [PATCH v2 01/18] make net/checksum.h self-contained
Date: Tue,  5 Dec 2023 02:23:52 +0000
Message-Id: <20231205022418.1703007-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205022100.GB1674809@ZenIV>
References: <20231205022100.GB1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

It uses ror32(), so have it pull linux/bitops.h
(and linux/bitops.h pulls asm/types.h)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/net/checksum.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/checksum.h b/include/net/checksum.h
index 1338cb92c8e7..5bf7dcebb5c2 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -16,7 +16,7 @@
 #define _CHECKSUM_H
 
 #include <linux/errno.h>
-#include <asm/types.h>
+#include <linux/bitops.h>
 #include <asm/byteorder.h>
 #include <asm/checksum.h>
 #if !defined(_HAVE_ARCH_COPY_AND_CSUM_FROM_USER) || !defined(HAVE_CSUM_COPY_USER)
-- 
2.39.2


