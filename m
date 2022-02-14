Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78CC4B4FD0
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 13:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbiBNMPY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 07:15:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbiBNMPX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 07:15:23 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3638148E5A;
        Mon, 14 Feb 2022 04:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644840916; x=1676376916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WUc1NN7vslvUvreUnv2/jHfCPbAb4tZm7oM8lOOA/80=;
  b=E/kUYZ8T74a59PqaAo6Z4gLVUC2vuruTCkLrLvXqtSAoyh+g4SZ/dn3E
   u6ElhBDHuRCcQ+v3f6u7GMPNF5Zs3i2G6HneB6PWcLPZIWFaytpofd4Xl
   aa2CFqEgkky755T4BKh+YB4WyXcD5VOmAVYhjsIp2dJl1N7B1v6imWL7A
   4yTK+uvtVfb+MJp8l+RrsQCD76JgpCyilsDYtt/83nMKz28zOd3u7iuxg
   l8/C8ZxEii+G4BVylC9kaF9EfaV2XgUBGrT3F6kUX2Br4gw90FlY/fJ2G
   oysPDPEgBRbk4uUeX5qY11/G5KT35VkERsSS087tdykrlLljHL1MpQIVL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="310814828"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="310814828"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 04:15:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="501769789"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga002.jf.intel.com with ESMTP; 14 Feb 2022 04:15:06 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 21ECF3B3005507;
        Mon, 14 Feb 2022 12:15:04 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
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
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v10 02/15] livepatch: avoid position-based search if `-z unique-symbol` is available
Date:   Mon, 14 Feb 2022 13:14:47 +0100
Message-Id: <20220214121447.288695-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211174130.xxgjoqr2vidotvyw@treble>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com> <20220209185752.1226407-3-alexandr.lobakin@intel.com> <20220211174130.xxgjoqr2vidotvyw@treble>
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

From: Josh Poimboeuf <jpoimboe@redhat.com>
Date: Fri, 11 Feb 2022 09:41:30 -0800

> On Wed, Feb 09, 2022 at 07:57:39PM +0100, Alexander Lobakin wrote:
> > Position-based search, which means that if there are several symbols
> > with the same name, the user needs to additionally provide the
> > "index" of a desired symbol, is fragile. For example, it breaks
> > when two symbols with the same name are located in different
> > sections.
> > 
> > Since a while, LD has a flag `-z unique-symbol` which appends
> > numeric suffixes to the functions with the same name (in symtab
> > and strtab). It can be used to effectively prevent from having
> > any ambiguity when referring to a symbol by its name.
> 
> In the patch description can you also give the version of binutils (and
> possibly other linkers) which have the flag?

Yeah, sure.

> 
> > Check for its availability and always prefer when the livepatching
> > is on. It can be used unconditionally later on after broader testing
> > on a wide variety of machines, but for now let's stick to the actual
> > CONFIG_LIVEPATCH=y case, which is true for most of distro configs
> > anyways.
> 
> Has anybody objected to just enabling it for *all* configs, not just for
> livepatch?

A few folks previously.

> 
> I'd much prefer that: the less "special" livepatch is (and the distros
> which enable it), the better.  And I think having unique symbols would
> benefit some other components.

Agree, I just want this series to be as least invasive for
non-FG-KASLR builds as possible. And currently this flag make depmod
emit a bunch of harmless false-positive warnings, so I'd wait until
at least the series is accepted / I post a patch for depmod and it
gets accepted.

> 
> > +++ b/kernel/livepatch/core.c
> > @@ -143,11 +143,13 @@ static int klp_find_callback(void *data, const char *name,
> >  	args->count++;
> >  
> >  	/*
> > -	 * Finish the search when the symbol is found for the desired position
> > -	 * or the position is not defined for a non-unique symbol.
> > +	 * Finish the search when unique symbol names are enabled
> > +	 * or the symbol is found for the desired position or the
> > +	 * position is not defined for a non-unique symbol.
> >  	 */
> > -	if ((args->pos && (args->count == args->pos)) ||
> > -	    (!args->pos && (args->count > 1)))
> > +	if (IS_ENABLED(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL) ||
> > +	    (args->pos && args->count == args->pos) ||
> > +	    (!args->pos && args->count > 1))
> >  		return 1;
> 
> There's no real need to do this.  The code already works as-is, even if
> there are no unique symbols.
> 
> Even if there are no duplicates, there's little harm in going through
> all the symbols anyway, to check for errors just in case something
> unexpected happened with the linking (unexpected duplicate) or the patch
> creation (unexpected sympos).  It's not a hot path, so performance isn't
> really a concern.
> 
> When the old linker versions eventually age out, we can then go strip
> out all the sympos stuff.
> 
> > @@ -169,6 +171,13 @@ static int klp_find_object_symbol(const char *objname, const char *name,
> >  	else
> >  		kallsyms_on_each_symbol(klp_find_callback, &args);
> >  
> > +	/*
> > +	 * If the LD's `-z unique-symbol` flag is available and enabled,
> > +	 * sympos checks are not relevant.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL))
> > +		sympos = 0;
> > +
> 
> Similarly, I don't see a need for this.  If the patch is legit then
> sympos should already be zero.  If not, an error gets reported and the
> patch fails to load.

Right, but for both those chunks the main idea is to let the
compiler optimize-out the code non-actual for unique-symbol builds:

add/remove: 0/0 grow/shrink: 1/2 up/down: 3/-80 (-77)
Function                                     old     new   delta
klp_find_callback                            139     142      +3
klp_find_object_symbol.cold                   85      48     -37
klp_find_object_symbol                       168     125     -43

> 
> -- 
> Josh

Thanks,
Al
