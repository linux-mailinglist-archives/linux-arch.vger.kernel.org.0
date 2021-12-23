Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B050347DBF4
	for <lists+linux-arch@lfdr.de>; Thu, 23 Dec 2021 01:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbhLWAZF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Dec 2021 19:25:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:53166 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345845AbhLWAYk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Dec 2021 19:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640219080; x=1671755080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fdl2pqtwfSmHqco13iW37DLHxkjyBxAhNXlPzt3ZhyI=;
  b=cE7W8nuAgefwVtoAivMYMLt96NsHMrrAwna3IsRzh/kC5ZR2rkAU39zR
   l7WqCutTqVlqH4MVT8W9tQDqbFVrbW92l2QQOixhAWQNe2XGr+QqreiTB
   cWnUqX3M7JaXW/PQqmHsVLguEMHauKduUR+vQgWq+YJ7NPTtdOZtb4wE0
   1hW5lMuBYTyj6lNieVmtNZqA0VC8+cq4D2Xm8UPWCzcyAwOQxnznm/MaY
   rCJpn598xXC0+5wFcJm3y3c/i6QKoXSPIQ4jS3tWjWXg8Vh40Qq3/J+/v
   Th2BkF1xRAuvz43cMN9eV8kTnI6qWs1zVv5La3obLMf2U/r1RYxjqucvM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="240533513"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="240533513"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 16:23:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="521881999"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga008.jf.intel.com with ESMTP; 22 Dec 2021 16:23:39 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1BN0N79K032467;
        Thu, 23 Dec 2021 00:23:37 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     linux-hardening@vger.kernel.org, x86@kernel.org
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v9 15/15] maintainers: add MAINTAINERS entry for FG-KASLR
Date:   Thu, 23 Dec 2021 01:22:09 +0100
Message-Id: <20211223002209.1092165-16-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add an entry for FG-KASLR containing the maintainers, reviewers,
public mailing lists, files and so on.

Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8912b2c1260c..efdb313b6813 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7853,6 +7853,18 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/fujitsu-tablet.c
 
+FUNCTION-GRAINED KASLR (FG-KASLR)
+M:	Alexander Lobakin <alexandr.lobakin@intel.com>
+R:	Kristen Carlson Accardi <kristen@linux.intel.com>
+R:	Kees Cook <keescook@chromium.org>
+L:	linux-hardening@vger.kernel.org
+S:	Supported
+F:	Documentation/security/fgkaslr.rst
+F:	arch/x86/boot/compressed/fgkaslr.c
+F:	arch/x86/boot/compressed/gen-symbols.h
+F:	arch/x86/boot/compressed/utils.c
+F:	scripts/generate_text_sections.pl
+
 FUSE: FILESYSTEM IN USERSPACE
 M:	Miklos Szeredi <miklos@szeredi.hu>
 L:	linux-fsdevel@vger.kernel.org
-- 
2.33.1

