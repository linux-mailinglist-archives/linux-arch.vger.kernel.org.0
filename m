Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A618147DBE5
	for <lists+linux-arch@lfdr.de>; Thu, 23 Dec 2021 01:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345675AbhLWAYF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Dec 2021 19:24:05 -0500
Received: from mga12.intel.com ([192.55.52.136]:60585 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345656AbhLWAXm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Dec 2021 19:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640219022; x=1671755022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZqsacVCaCaa0RH/T+KzpxaVhq/CCs3gWJ74Mp2TbBss=;
  b=nPai+hED8/pvT4GWlD8Kb+lwrRxCjYXP86LoWcbX3ReBPl02Yj3oIcHt
   mHG/B/4mcnJL+xu+dFjxyv/PA8tp128FtW+tlympWplMK3P5T64HGY+Wo
   2QLawitlSVxFNQRcIWp5L681jmW6p8A2SB0LChmaSdWx0LJ9HDEPViEEC
   Gmb9/LOyOaa2BK3xjXun6NaniuekQRXSNM2BZzTmuCPFWNFSz+QPMXpfi
   FLLL4HOMm2FXrNV8BkSYO/zbI6qLm+SIrLufSUvH+toZFLc0PbRBgp/s1
   98xG5sALpoZF/jtLlNV5YbcYlruNP7zVVycVwFvaDEilc0pyTmTgeFtH7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="220739058"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="220739058"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 16:23:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="614013918"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga002.fm.intel.com with ESMTP; 22 Dec 2021 16:23:31 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1BN0N79G032467;
        Thu, 23 Dec 2021 00:23:29 GMT
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
Subject: [PATCH v9 11/15] x86/boot: allow FG-KASLR to be selected
Date:   Thu, 23 Dec 2021 01:22:05 +0100
Message-Id: <20211223002209.1092165-12-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now that we have full support of FG-KASLR from both kernel core
and x86 code, allow FG-KASLR to be enabled for x86_64 if the
"regular" KASLR is also turned on.

Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3e4ea355147b..f7472528f3dd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -105,6 +105,7 @@ config X86
 	select ARCH_SUPPORTS_ASM_FUNCTION_SECTIONS
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
+	select ARCH_SUPPORTS_FG_KASLR		if X86_64 && RANDOMIZE_BASE
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
 	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
 	select ARCH_SUPPORTS_LTO_CLANG
-- 
2.33.1

