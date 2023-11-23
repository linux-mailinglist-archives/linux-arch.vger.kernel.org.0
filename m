Return-Path: <linux-arch+bounces-424-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 140287F5D55
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 12:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A80281A7B
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 11:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B83C22EF8;
	Thu, 23 Nov 2023 11:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PspJpNl8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DADE22EE6;
	Thu, 23 Nov 2023 11:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDFCC433CD;
	Thu, 23 Nov 2023 11:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700737548;
	bh=e+QnAKFOR6wNf8AU7caaDk1G44zPUvTIPn9eqgvKtVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PspJpNl8eiPdZ9teU9sgGRq0899Z4qRquTRTMB3ArIInHB3Up/Nd1jNAK52qGJfw6
	 VwcSqNBj6wKq0fD5yXgSW27a59XD7QLOvPbuIspPpPRBkcfND/tpUKYcFGCF7v8Zsa
	 dgDyTwQGndIV8yWAWF26tuIPGfQKRXj1NO3DcnqV310BwDabCzlQwn1lCiuBVbFjHA
	 Z86z4PLYiZf9MHHOZgmqB8KbDB4rO/oWM3+PqBPki4n8eLgoRQ6LCVS7VPSNlti2tC
	 3KF5z4FbFLm2GWjTZYrI/5XmCiH2J5bKlvwiwgrOPc4LVeIRCaHUi1/MBiIDKhPy5d
	 Oiwg9eBSopTGQ==
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
Subject: [PATCH v3 4/6] x86: sta2x11: include header for sta2x11_get_instance() prototype
Date: Thu, 23 Nov 2023 12:05:04 +0100
Message-Id: <20231123110506.707903-5-arnd@kernel.org>
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

sta2x11_get_instance() is a global function declared in asm/sta2x11.h,
but this header is not included before the definition, causing a warning:

arch/x86/pci/sta2x11-fixup.c:95:26: error: no previous prototype for 'sta2x11_get_instance' [-Werror=missing-prototypes]

Add the missing #include.

Fixes: 83125a3a189e ("x86, platform: Initial support for sta2x11 I/O hub")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/pci/sta2x11-fixup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
index 7368afc03998..8c8ddc4dcc08 100644
--- a/arch/x86/pci/sta2x11-fixup.c
+++ b/arch/x86/pci/sta2x11-fixup.c
@@ -14,6 +14,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/swiotlb.h>
 #include <asm/iommu.h>
+#include <asm/sta2x11.h>
 
 #define STA2X11_SWIOTLB_SIZE (4*1024*1024)
 
-- 
2.39.2


