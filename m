Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2394AFCA8
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 20:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbiBITBs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 14:01:48 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241954AbiBITAn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 14:00:43 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CA9C03C184;
        Wed,  9 Feb 2022 11:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644433217; x=1675969217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s84uSm9qyBNadCbATFCw5Cxj1InKAjGvq6LbxYnviTE=;
  b=n3tnxuw28owdJv6zCB1sHx9JFoCIWIhV/VVmqDKZgSk+Ls1TTB50fUGe
   E7qWFhbX5V/l9/9BDY5CzPWCA3Fmh7eSbLLX3hdisAoq+WZCXDb6P63s9
   +5LXxXHQvBBmHjwv0vvLMh+iLzTYOjEto3gxPsMAKO0ILbFPKvI/jj2IM
   fMtijjucJeSVA4lRb6QP33Su3TO0kTogTRDa2LwLmKtqwCWncPCQTXZuI
   KD1yyBaKZ5iEVC/1N0gPLnJMbzGCLN/2rxV7ANeLOULNrSi0HENTXGxXa
   NJHn/TAAEup3Ip0Qh6vM8YYztecaYRJpCPT+5LMudwcdmN6b6rg3oonXT
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="229953321"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="229953321"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 10:59:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="500088812"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga002.jf.intel.com with ESMTP; 09 Feb 2022 10:59:20 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 219IwjQc031082;
        Wed, 9 Feb 2022 18:59:17 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     linux-hardening@vger.kernel.org, x86@kernel.org
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Christoph Hellwig <hch@lst.de>,
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
Subject: [PATCH v10 15/15] maintainers: add MAINTAINERS entry for FG-KASLR
Date:   Wed,  9 Feb 2022 19:57:52 +0100
Message-Id: <20220209185752.1226407-16-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index f53d30463c21..49a0974d32a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7925,6 +7925,18 @@ L:	platform-driver-x86@vger.kernel.org
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
2.34.1

