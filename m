Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578964834CB
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 17:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiACQa7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 11:30:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:61989 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234503AbiACQa6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 3 Jan 2022 11:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641227458; x=1672763458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lDHyxnzBp52EBgn9DCV6gYjH1wlIV3ajsqPWDXcfpvI=;
  b=daquIahH8MXuFl9OrWG9Ihfk79Pv866hfOL5aX8XLylAGS8SJ6LPPKq/
   zeHFj9XkYKGCMS5NqSxHpUJzHl5gz9wpV9xBirbL9UFcqDyTF7asL6+85
   HLoSJs5Z5MTEY9WpSH6P+qDPVrR4AlNVBkYUlaMn/DRZZQR3HJKx57+wC
   iNWq+DJZgz2k9fz+GBelPN4pOIcoA1F+lE+vhJ3TOSDtUvheqx+nPNu6M
   2v44oM1yKAlOUeZHqpya7wnUn4kai2iF9s3F7/fIIqyEf6GfVptRP4kJa
   mB9lRoJNjacWNKgl/1RnH4v0nLVG/uL59eNsmCZNRnlhWYUb9/MiyasHZ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="240908622"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="240908622"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 08:30:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="762578003"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jan 2022 08:30:48 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 203GUjIa003559;
        Mon, 3 Jan 2022 16:30:45 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-hardening@vger.kernel.org, x86@kernel.org,
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
Subject: Re: [PATCH v9 02/15] livepatch: use `-z unique-symbol` if available to nuke pos-based search
Date:   Mon,  3 Jan 2022 17:29:31 +0100
Message-Id: <20220103162931.8132-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <Yc2Tqc69W9ukKDI1@zn.tnic>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com> <20211223002209.1092165-3-alexandr.lobakin@intel.com> <Yc2Tqc69W9ukKDI1@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Borislav Petkov <bp@alien8.de>
Date: Thu, 30 Dec 2021 12:10:33 +0100

> On Thu, Dec 23, 2021 at 01:21:56AM +0100, Alexander Lobakin wrote:
> > [PATCH v9 02/15] livepatch: use `-z unique-symbol` if available to nuke pos-based search
> 
> nuke?
> 
> I think you wanna say something about avoiding position-based search if
> toolchain supports -z ...

Correct. A "vocabulary fail" moment.

> 
> > Position-based search, which means that if we have several symbols
> > with the same name, we additionally need to provide an "index" of
> > the desired symbol, is fragile. Par exemple, it breaks when two
> 				  ^^^^^^^^^^^^
> 
> We already have hard time with the English in commit messages, let's
> avoid the French pls.
> 
> > symbols with the same name are located in different sections.
> > 
> > Since a while, LD has a flag `-z unique-symbol` which appends
> > numeric suffixes to the functions with the same name (in symtab
> > and strtab).
> > Check for its availability and always prefer when the livepatching
> > is on.
> 
> Why only then?
> 
> It looks to me like we want this unconditionally, no?

To be as least invasive as possible for now. We can turn it on
unconditionally after a while. LLD doesn't support it and this
and there are some different opinions about unique-symbol in
general.
Maybe FG-KASLR builds will reveal that some of the concerns are
true, who knows. It wouldn't need to get turned off back again
then.

> 
> > This needs a little adjustment to the modpost to make it
> > strip suffixes before adding exports.
> > 
> > depmod needs some treatment as well, tho its false-positibe warnings
> 
> Unknown word [false-positibe] in commit message, suggestions:
>         ['false-positive', 'false-positioned', 'prepositional']
> 
> Please introduce a spellchecker into your patch creation workflow.

It's here, but refused to work this time or so <O> I have definitely
run checkpatch with codespell against the series I can't recall any
reported typos.

> 
> > about unknown symbols are harmless and don't alter the return code.
> > And there is a bunch more livepatch code to optimize-out after
> > introducing this, but let's leave it for later.
> 
> ...
> 
> > @@ -171,17 +173,21 @@ static int klp_find_object_symbol(const char *objname, const char *name,
> >  
> >  	/*
> >  	 * Ensure an address was found. If sympos is 0, ensure symbol is unique;
> > -	 * otherwise ensure the symbol position count matches sympos.
> > +	 * otherwise ensure the symbol position count matches sympos. If the LD
> > +	 * `-z unique` flag is enabled, sympos checks are not relevant.
> 	   ^^^^^^^^^^^
> 
> -z unique-symbol
> 
> >  	 */
> > -	if (args.addr == 0)
> > +	if (args.addr == 0) {
> >  		pr_err("symbol '%s' not found in symbol table\n", name);
> > -	else if (args.count > 1 && sympos == 0) {
> > +	} else if (IS_ENABLED(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL)) {
> > +		goto out_ok;
> 
> This is silly - just do it all here.

Yeah, a "big brain" moment from me. Or even reset sympos to 0 when
unique-symbol is enabled, like Mirek suggests.

> 
> > +	} else if (args.count > 1 && sympos == 0) {
> >  		pr_err("unresolvable ambiguity for symbol '%s' in object '%s'\n",
> >  		       name, objname);
> >  	} else if (sympos != args.count && sympos > 0) {
> >  		pr_err("symbol position %lu for symbol '%s' in object '%s' not found\n",
> >  		       sympos, name, objname ? objname : "vmlinux");
> >  	} else {
> > +out_ok:
> >  		*addr = args.addr;
> >  		return 0;
> >  	}
> 
> Looks straight-forward otherwise but I'm no livepatcher so I'd prefer if
> they have a look too.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

Thanks,
Al
