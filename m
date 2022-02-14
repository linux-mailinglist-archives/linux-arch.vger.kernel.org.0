Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6966E4B4F17
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 12:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353176AbiBNLnd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 06:43:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352666AbiBNLnV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 06:43:21 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB03310FA;
        Mon, 14 Feb 2022 03:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644838513; x=1676374513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YGHaP2hnU1orIs+CLY7os5ijsM1R9T/d7HZLRE0xrlA=;
  b=dX6mTdeqdXBZBd/pj2j2TYNlmdNVZFw7mTNtAKYMSuBo115sinKvmJrT
   qCD3uZTLOdwmtV/3K6W7EUVdU/QLwq4EOnoE0T7gMPK4JVt7nJBL5habt
   Vxa/S3Kef5cYNP5X0mVo36cveEcKxGnhdq5QAydpYCFHHrC+Sh//eoyDH
   XGIeLW0dRtOGLNPgkUKwQKCcp1TJtzcbIrZu5l6xoK9+rPN9lRYflpg6o
   /7274SqBNOoblX7c9nu2Bv/xFA9zVD0qCv74FvCMVR8rGfYeaXgiuY+km
   SqxFULvcS3Me8QL4or5/DReeb5V77A5REPijD2OACxwZZRgzxrMN0PLYR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="250277559"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="250277559"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 03:35:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="775096766"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga005.fm.intel.com with ESMTP; 14 Feb 2022 03:34:59 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 21EBYuXA031487;
        Mon, 14 Feb 2022 11:34:57 GMT
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
Subject: Re: [PATCH v10 10/15] FG-KASLR: use a scripted approach to handle .text.* sections
Date:   Mon, 14 Feb 2022 12:34:34 +0100
Message-Id: <20220214113434.5256-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211153706.GW23216@worktop.programming.kicks-ass.net>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com> <20220209185752.1226407-11-alexandr.lobakin@intel.com> <20220211153706.GW23216@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 11 Feb 2022 16:37:06 +0100

> On Wed, Feb 09, 2022 at 07:57:47PM +0100, Alexander Lobakin wrote:
> > +sub read_sections {
> > +	open(my $fh, "\"$readelf\" -SW \"$file\" 2>/dev/null |")
> > +		or die "$0: ERROR: failed to execute \"$readelf\": $!";
> > +
> > +	while (<$fh>) {
> > +		my $name;
> > +		my $align;
> > +		chomp;
> > +
> > +		($name, $align) = $_ =~ /^\s*\[[\s0-9]*\]\s*(\.\S*)\s*[A-Z]*\s*[0-9a-f]{16}\s*[0-9a-f]*\s*[0-9a-f]*\s*[0-9a-f]*\s*[0-9a-f]{2}\s*[A-Z]{2}\s*[0-9]\s*[0-9]\s*([0-9]*)$/;
> 
> Is there really no readable way to write this?

I'm no regexp master, so I'd be glad if someone could help improve
this :D I only tried to optimize it using online tools, and they
eventually didn't help.
It could probably be replaced with a pipe to `cut` or `tr`, I'll
take a look a bit later if there won't be any other proposals.

> 
> > +
> > +		if (!defined($name)) {
> > +			next;
> > +		}
> > +
> > +		## Clang 13 onwards emits __cfi_check_fail only on final
> > +		## linking, so it won't appear in .o files and will be
> > +		## missing in @sections. Add it manually to prevent
> > +		## spawning orphans.
> > +		if ($name eq ".text.__cfi_check_fail") {
> > +			$has_ccf = 1;
> > +		}
> 
> How is that relevant, x86-64 doesn't and won't do clang-cfi.

1. One of my test cases was based on Sami's ClangCFI x86 series from
   LKML (the one that was getting patched by objtool :P).
2. ClangCFI is present on ARM64 and it can receive FG-KASLR in a
   future, why not make it work together from the start?

Re "won't do" -- sorry for trying to hijack this thread a bit, but
did I miss something? The last comments I've read were that LLVM
tools need to change their approach for CFI on x86, and Sami went
redo it, but I can't recall any "life-time" nacks.

Thanks,
Al
