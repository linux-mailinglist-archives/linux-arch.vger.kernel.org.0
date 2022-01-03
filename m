Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804464836ED
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 19:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbiACSf3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 13:35:29 -0500
Received: from drummond.us ([74.95.14.229]:40377 "EHLO
        talisker.home.drummond.us" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235705AbiACSfZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 13:35:25 -0500
X-Greylist: delayed 863 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jan 2022 13:35:25 EST
Received: from talisker.home.drummond.us (localhost [127.0.0.1])
        by talisker.home.drummond.us (8.15.2/8.15.2/Debian-20) with ESMTP id 203IKbNL983563;
        Mon, 3 Jan 2022 10:20:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=home.drummond.us;
        s=default; t=1641234037;
        bh=bSwluo0Aob4WYADzp3kAIHznX9//zY4MWY4AMAFc9h0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y1Rc4BiSyaGNvVy4ergvgD57C2KAPogSVraoGKWZQbOP66D7gqBoxQfslTqrLVDnp
         9Ykl0wJxzhE0WNWRSJNTZ8LmK+oEqdBCPvUHI+QSfHP9/FA32f+EAtOWAaq+RY0hwt
         8zBC1v1Uu/UlgBDWLHSpoecuXcAdrpPqrZz9QM+a8VPSEAt3zKIG6ZTXmnUMiH/jtL
         qf6iH2z/UwVXvBUKsxOeQstmhsILFQyiHWmn28c9QERlt9cKJGiqrJVczxpxeFA/TY
         1j6e77pATVRdiT1+CLO9C5qncNsFmudTkvxCaEbaZ9ZqEO06sVw4tUZPSGBUf9Dsft
         OY+j5YuRKkeAg==
Received: (from walt@localhost)
        by talisker.home.drummond.us (8.15.2/8.15.2/Submit) id 203IKaLT983562;
        Mon, 3 Jan 2022 10:20:36 -0800
From:   Walt Drummond <walt@drummond.us>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, Walt Drummond <walt@drummond.us>,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH 6/8] signals: Round up _NSIG_WORDS
Date:   Mon,  3 Jan 2022 10:19:54 -0800
Message-Id: <20220103181956.983342-7-walt@drummond.us>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220103181956.983342-1-walt@drummond.us>
References: <20220103181956.983342-1-walt@drummond.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When needed, round _NSIG_WORDS up for generic and x86 architectures.

Signed-off-by: Walt Drummond <walt@drummond.us>
---
 arch/x86/include/asm/signal.h     | 2 +-
 include/uapi/asm-generic/signal.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index 9bac7c6e524c..d8e2efe6cd46 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -16,7 +16,7 @@
 # define _NSIG_BPW	64
 #endif
 
-#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
+#define _NSIG_WORDS	((_NSIG + _NSIG_BPW - 1) / _NSIG_BPW)
 
 typedef unsigned long old_sigset_t;		/* at least 32 bits */
 
diff --git a/include/uapi/asm-generic/signal.h b/include/uapi/asm-generic/signal.h
index f634822906e4..3c4cc9b8378e 100644
--- a/include/uapi/asm-generic/signal.h
+++ b/include/uapi/asm-generic/signal.h
@@ -6,7 +6,7 @@
 
 #define _NSIG		64
 #define _NSIG_BPW	__BITS_PER_LONG
-#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
+#define _NSIG_WORDS	((_NSIG + _NSIG_BPW - 1) / _NSIG_BPW)
 
 #define SIGHUP		 1
 #define SIGINT		 2
-- 
2.30.2

