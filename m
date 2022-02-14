Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A978E4B4F5F
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 12:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiBNLvo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 06:51:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351877AbiBNLul (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 06:50:41 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6028202;
        Mon, 14 Feb 2022 03:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644839433; x=1676375433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pwDESe15Vd1g0DPBCuoyVHda2xq39Jpz8AWqAWVhmO8=;
  b=btkqt3QcAz7ZqTLmoY3J0Jm2AE7ZkF66RoS0obUYwjTiMHwD1WrKgT0Z
   wZ3eZg9wJjqsUgq1kCqGgwi0By2yyz8J7SoJcQ+KcUr014eH4FWrjfpbh
   DxicnN4kGJD4PveSzCoUBdcdBQcoVbAa888nvpJUhsMn8pixY4byAg1d0
   HonppS8xEA908dwBT0JKYyR3l1JpXXbnQuND+k5TIxsUcsDheQzeDgZ4n
   QtBChrggcwIs2CKpVYzCdz5kDqy8UdPbpQ8k+oONszR9ngR0Dm+LRED+k
   Qnv/3lJxK7WYHnntYSZOGO+bB1Iy7H/tsiWKW4uyiD81GgbIDBDDExrpt
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="310811354"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="310811354"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 03:50:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="538559695"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga007.fm.intel.com with ESMTP; 14 Feb 2022 03:50:25 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 21EBoMxH001918;
        Mon, 14 Feb 2022 11:50:22 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-hardening@vger.kernel.org, x86@kernel.org,
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
Subject: Re: [PATCH v10 05/15] x86: support asm function sections
Date:   Mon, 14 Feb 2022 12:49:27 +0100
Message-Id: <20220214114927.6104-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211154524.GX23216@worktop.programming.kicks-ass.net>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com> <20220209185753.1226407-6-alexandr.lobakin@intel.com> <20220211154524.GX23216@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 11 Feb 2022 16:45:24 +0100

> On Wed, Feb 09, 2022 at 07:57:42PM +0100, Alexander Lobakin wrote:
> > Address places which need special care and enable
> > CONFIG_ARCH_SUPPORTS_ASM_FUNCTION_SECTIONS.
> > 
> > Notably:
> >  - propagate `--sectname-subst` to KBUILD_AFLAGS in
> >    x86/boot/Makefile and x86/boot/compressed/Makefile as both
> >    override them;
> >  - symbols starting with a dot (like ".Lrelocated") should be
> >    handled manually with SYM_*_START_SECT(.Lrelocated, relocated)
> >    as "two dots" is a special (and CPP doesn't want to concatenate
> >    two dots in general);
> >  - some symbols explicitly need to reside in one section (like
> >    kexec control code, hibernation page etc.);
> >  - macros creating aliases for functions (like __memcpy() for
> >    memcpy() etc.) should go after the main declaration (as
> >    aliases should be declared in the same section and they
> >    don't have SYM_PUSH_SECTION() inside);
> >  - things like ".org", ".align" should be manually pushed to
> >    the same section the next symbol goes to;
> >  - expand indirect_thunk wildcards in vmlinux.lds.S to catch
> >    symbols back into the "main" section;
> >  - inline ASM functions like __raw_callee*() should be pushed
> >    manually as well.
> > 
> > With these changes and `-ffunction-sections` enabled, "plain"
> > ".text" section is empty which means that everything works
> > right as expected.
> > 
> > Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> > ---
> >  arch/x86/Kconfig                              |  1 +
> >  arch/x86/boot/Makefile                        |  1 +
> >  arch/x86/boot/compressed/Makefile             |  1 +
> >  arch/x86/boot/compressed/head_32.S            |  2 +-
> >  arch/x86/boot/compressed/head_64.S            | 32 ++++++++++++-------
> >  arch/x86/boot/pmjump.S                        |  2 +-
> >  arch/x86/crypto/aesni-intel_asm.S             |  4 +--
> >  arch/x86/crypto/poly1305-x86_64-cryptogams.pl |  4 +++
> >  arch/x86/include/asm/paravirt.h               |  2 ++
> >  arch/x86/include/asm/qspinlock_paravirt.h     |  2 ++
> >  arch/x86/kernel/head_32.S                     |  4 +--
> >  arch/x86/kernel/head_64.S                     |  4 +--
> >  arch/x86/kernel/kprobes/core.c                |  2 ++
> >  arch/x86/kernel/kvm.c                         |  2 ++
> >  arch/x86/kernel/relocate_kernel_32.S          | 10 +++---
> >  arch/x86/kernel/relocate_kernel_64.S          | 12 ++++---
> >  arch/x86/kernel/vmlinux.lds.S                 |  2 +-
> >  arch/x86/kvm/emulate.c                        |  7 +++-
> >  arch/x86/lib/copy_user_64.S                   |  2 +-
> >  arch/x86/lib/error-inject.c                   |  2 ++
> >  arch/x86/lib/getuser.S                        |  5 ++-
> >  arch/x86/lib/memcpy_64.S                      |  4 +--
> >  arch/x86/lib/memmove_64.S                     |  5 ++-
> >  arch/x86/lib/memset_64.S                      |  5 +--
> >  arch/x86/lib/putuser.S                        |  2 +-
> >  arch/x86/power/hibernate_asm_32.S             | 10 +++---
> >  arch/x86/power/hibernate_asm_64.S             | 10 +++---
> >  27 files changed, 89 insertions(+), 50 deletions(-)
> 
> Urgh, how much of that can you avoid by (ab)using __DISABLE_EXPORTS
> like:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=x86/wip.ibt&id=ab74f54f2b1f6cfeaf2b3ba6999bde7cabada9ca

Oh, never thought on that, looks like at least 3 of 27 files and
35 of 139 lines, nice!
I'll redo this one in the meantime whilst waiting for more comments
here.

Thanks!
Al
