Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB0C466CED
	for <lists+linux-arch@lfdr.de>; Thu,  2 Dec 2021 23:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377548AbhLBWhS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Dec 2021 17:37:18 -0500
Received: from mga17.intel.com ([192.55.52.151]:46501 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349757AbhLBWgr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Dec 2021 17:36:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="217546806"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="217546806"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 14:33:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="748394126"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga005.fm.intel.com with ESMTP; 02 Dec 2021 14:33:17 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1B2MWmYf028552;
        Thu, 2 Dec 2021 22:33:14 GMT
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
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v8 14/14] maintainers: add MAINTAINERS entry for FG-KASLR
Date:   Thu,  2 Dec 2021 23:32:14 +0100
Message-Id: <20211202223214.72888-15-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211202223214.72888-1-alexandr.lobakin@intel.com>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com>
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
index 360e9aa0205d..336cae4c08b4 100644
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
+F:	arch/x86/boot/compressed/utils.c
+F:	arch/x86/boot/compressed/vmlinux.symbols
+F:	scripts/generate_text_sections.pl
+
 FUSE: FILESYSTEM IN USERSPACE
 M:	Miklos Szeredi <miklos@szeredi.hu>
 L:	linux-fsdevel@vger.kernel.org
-- 
2.33.1

