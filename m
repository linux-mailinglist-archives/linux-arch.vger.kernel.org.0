Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B34C4AFC91
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 20:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241976AbiBITAp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 14:00:45 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241909AbiBITAj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 14:00:39 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65597C0045B7;
        Wed,  9 Feb 2022 10:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644433158; x=1675969158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=++X99Su9CmcwEyMn/TkpPbeHGo1khXP+bvcbF0jf6Kk=;
  b=PESZ/2mi3/yq8NDCBQDN1XqWjcvcBEhQq0asKgTk2GBEx5D3SoXZ7uwA
   GA9DKfq56pE2pXCMTpV0ZVuVn1pKEn0eZ+r1R1OOIvf1movzCXnebOLJm
   S0TyCT0DoXo078ZCTQE+zFrq4mf0bXNj7KRCjcD8Buq/Kd1rSP/HXoye1
   TSrqcFa3NiTBVNf+qyERfy0yd6OTR/3L8vWJ0L0BL9gJnxjpEgKfRvc8u
   ObB+qcf0XjVZ8/ksYWNsSpu44tcwHCwkSHgIoB7p9QGWqt/lcKbT0m236
   PLMTW/qA+W/NvFjxvyYoG6isMV9dvSaGJH+f9R7JU2tz2uIXOqupHz7se
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="310047636"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="310047636"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 10:58:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="629389815"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga002.fm.intel.com with ESMTP; 09 Feb 2022 10:58:50 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 219IwjQO031082;
        Wed, 9 Feb 2022 18:58:47 GMT
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
Subject: [PATCH v10 01/15] modpost: fix removing numeric suffixes
Date:   Wed,  9 Feb 2022 19:57:38 +0100
Message-Id: <20220209185752.1226407-2-alexandr.lobakin@intel.com>
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

`-z unique-symbol` linker flag which is planned to use with FG-KASLR
to simplify livepatching (hopefully globally later on) triggers the
following:

ERROR: modpost: "param_set_uint.0" [vmlinux] is a static EXPORT_SYMBOL

The reason is that for now the condition from remove_dot():

if (m && (s[n + m] == '.' || s[n + m] == 0))

which was designed to test if it's a dot or a '\0' after the suffix
is never satisfied.
This is due to that `s[n + m]` always points to the last digit of a
numeric suffix, not on the symbol next to it (from a custom debug
print added to modpost):

param_set_uint.0, s[n + m] is '0', s[n + m + 1] is '\0'

So it's off-by-one and was like that since 2014.
Fix this for the sake of upcoming features, but don't bother
stable-backporting, as it's well hidden -- apart from that LD flag,
can be triggered only by GCC LTO which never landed upstream.

Fixes: fcd38ed0ff26 ("scripts: modpost: fix compilation warning")
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 scripts/mod/modpost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 6bfa33217914..4648b7afe5cc 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1986,7 +1986,7 @@ static char *remove_dot(char *s)
 
 	if (n && s[n]) {
 		size_t m = strspn(s + n + 1, "0123456789");
-		if (m && (s[n + m] == '.' || s[n + m] == 0))
+		if (m && (s[n + m + 1] == '.' || s[n + m + 1] == 0))
 			s[n] = 0;
 
 		/* strip trailing .lto */
-- 
2.34.1

