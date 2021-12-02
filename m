Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4891D466CD3
	for <lists+linux-arch@lfdr.de>; Thu,  2 Dec 2021 23:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbhLBWgs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Dec 2021 17:36:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:32132 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349448AbhLBWgg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Dec 2021 17:36:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="216877428"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="216877428"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 14:33:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="655540569"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga001.fm.intel.com with ESMTP; 02 Dec 2021 14:33:05 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1B2MWmYZ028552;
        Thu, 2 Dec 2021 22:33:03 GMT
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
Subject: [PATCH v8 08/14] livepatch: only match unique symbols when using FG-KASLR
Date:   Thu,  2 Dec 2021 23:32:08 +0100
Message-Id: <20211202223214.72888-9-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211202223214.72888-1-alexandr.lobakin@intel.com>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If any type of function granular randomization is enabled, the sympos
algorithm will fail, as it will be impossible to resolve symbols when
there are duplicates using the previous symbol position.

We could override sympos to 0, but make it more clear to the user
and bail out if the symbol is not unique.

Suggested-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 kernel/livepatch/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 335d988bd811..10ea75111057 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -169,6 +169,17 @@ static int klp_find_object_symbol(const char *objname, const char *name,
 	else
 		kallsyms_on_each_symbol(klp_find_callback, &args);
 
+	/*
+	 * If function granular randomization is enabled, it is impossible
+	 * to resolve symbols when there are duplicates using the previous
+	 * symbol position (i.e. sympos != 0).
+	 */
+	if (IS_ENABLED(CONFIG_FG_KASLR) && sympos) {
+		pr_err("FG-KASLR is enabled, specifying symbol position %lu for symbol '%s' in object '%s' does not work\n",
+		       sympos, name, objname ? objname : "vmlinux");
+		goto out_err;
+	}
+
 	/*
 	 * Ensure an address was found. If sympos is 0, ensure symbol is unique;
 	 * otherwise ensure the symbol position count matches sympos.
@@ -186,6 +197,7 @@ static int klp_find_object_symbol(const char *objname, const char *name,
 		return 0;
 	}
 
+out_err:
 	*addr = 0;
 	return -EINVAL;
 }
-- 
2.33.1

