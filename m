Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62564B4FFF
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 13:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbiBNMZM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 07:25:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiBNMZL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 07:25:11 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFCF496A9;
        Mon, 14 Feb 2022 04:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644841504; x=1676377504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vtQ4PnDQPH5UNj0aFuF+/GWWafdq/9R3N2a/97wYrWE=;
  b=kFv81OAeehTHhyv2LeZ6RDGufcmDQBMGZEiCCjgYJe6Aq5zyeJW3nUHA
   9i01BqV+ACE3GR5uPJrqdcjizJvpqO2BWuS8fLqaxxrNqWlav7qyijmCj
   7Dsw5R3+VQG9cbZ8wjwAQkvJZsPc0WL49bIqsXaLXkD18tpwyc+nkPUHD
   jdNyT4t51U4pOw/9KIRcI0cQfx6H0vUK0ZQ7gJP5rQ/CG4WN2O+a30Ppg
   e4Bt5I4gndCy4vIY650uueTetNtAcMGTpYxiDsXkvnw8kOypHG9bi0Bj0
   H6dclUx/+oGBzr5HmLVsX45vgmoaFoFgZ5dBvJPNcXdygSfQpiSPjkANO
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="230716168"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="230716168"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 04:25:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="485429689"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga003.jf.intel.com with ESMTP; 14 Feb 2022 04:24:54 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 21ECOpqZ007552;
        Mon, 14 Feb 2022 12:24:52 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
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
Date:   Mon, 14 Feb 2022 13:24:33 +0100
Message-Id: <20220214122433.288910-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211183529.q7qi2qmlyuscxyto@treble>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com> <20220209185752.1226407-3-alexandr.lobakin@intel.com> <20220211174130.xxgjoqr2vidotvyw@treble> <CAFP8O3KvZOZJqOR8HYp9xZGgnYf3D8q5kNijZKORs06L-Vit1g@mail.gmail.com> <20220211183529.q7qi2qmlyuscxyto@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Date: Fri, 11 Feb 2022 10:35:29 -0800

> On Fri, Feb 11, 2022 at 10:05:02AM -0800, Fāng-ruì Sòng wrote:
> > On Fri, Feb 11, 2022 at 9:41 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Wed, Feb 09, 2022 at 07:57:39PM +0100, Alexander Lobakin wrote:
> > > > Position-based search, which means that if there are several symbols
> > > > with the same name, the user needs to additionally provide the
> > > > "index" of a desired symbol, is fragile. For example, it breaks
> > > > when two symbols with the same name are located in different
> > > > sections.
> > > >
> > > > Since a while, LD has a flag `-z unique-symbol` which appends
> > > > numeric suffixes to the functions with the same name (in symtab
> > > > and strtab). It can be used to effectively prevent from having
> > > > any ambiguity when referring to a symbol by its name.
> > >
> > > In the patch description can you also give the version of binutils (and
> > > possibly other linkers) which have the flag?
> > 
> > GNU ld>=2.36 supports -z unique-symbol. ld.lld doesn't support -z unique-symbol.
> > 
> > I subscribe to llvm@lists.linux.dev and happen to notice this message
> > (can't keep up with the changes...)
> > I am a bit concerned with this option and replied last time on
> > https://lore.kernel.org/r/20220105032456.hs3od326sdl4zjv4@google.com
> > 
> > My full reasoning is on
> > https://maskray.me/blog/2020-11-15-explain-gnu-linker-options#z-unique-symbol
> 
> Ah, right.  Also discussed here:
> 
>   https://lore.kernel.org/all/20210123225928.z5hkmaw6qjs2gu5g@google.com/T/#u
>   https://lore.kernel.org/all/20210125172124.awabevkpvq4poqxf@treble/
> 
> I'm not qualified to comment on LTO/PGO stability issues, but it doesn't
> sound good.  And we want to support livepatch for LTO kernels.
> 
> Also I realized that this flag would have a negative effect on
> kpatch-build, as it currently does its analysis on .o files.  So it
> would have to figure out how to properly detect function renames, to
> avoid patching the wrong function for example.
> 
> And if LLD doesn't plan to support the flag then it will be a headache
> for livepatch (and the kernel in general) to deal with the divergent
> configs.

I'm always down with replacing any of the parts, I'm just not
familiar with any other ways of approaching this without huge diffs.
I've read Fāng-ruì's blogpost previously and there's a possible
replacement described there, but I dunno how to approach it.
And them Miroslav just told me that unique-symbol should work just
fine and I can go with it.
So I asked here prevously and ask once again for any hints regarding
some other ways :p

> 
> One idea I mentioned before, it may be worth exploring changing the "F"
> in FGKASLR to "File" instead of "Function".  In other words, only
> shuffle at an object-file granularity.  Then, even with duplicates, the
> <file+function> symbol pair doesn't change in the symbol table.  And as
> a bonus, it should help FGKASLR i-cache performance, significantly.

Yeah, I keep that in mind. However, this wouldn't solve the
duplicate static function names problem, right?
Let's say you have a static function f() in file1 and f() in file2,
then the layout each boot can be

.text.file1  or  .text.file2
f()              f()
.text.file2      .text.file1
f()              f()

and position-based search won't work anyway, right?

> 
> -- 
> Josh

Thanks,
Al
