Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E4D4BBD8B
	for <lists+linux-arch@lfdr.de>; Fri, 18 Feb 2022 17:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbiBRQcK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Feb 2022 11:32:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiBRQcJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Feb 2022 11:32:09 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2C716EA91;
        Fri, 18 Feb 2022 08:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645201912; x=1676737912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4W6IsG6XIGFsgxzcIzhA34FiQVuplRXxJf4Nr78Hxdk=;
  b=h3M5r/yP1p4/KqKNOu8HjkQwkgX7KmHaKwZQZPjXS1ix4rcz5EAkHUAT
   8DRgzyL6FEJ2m3GvzzjSzxhjsdr69TaIxYx2u7vIDgaZhHiugghAYVNOM
   kyB39oic3rd/O6keoyYTQQGLgJyH8pMbHM2vjNIfS1k1Gi7R6FlTApwdT
   bh638chiBxtAYTL3iz08zfz4WhRhbqJduZvaDYu2mSApIKWyJ3VtbPjlE
   sEt7KP3zpMg1fyDWTOshUcnsLO6Pai2WP3b5y5vNoynFq326QgcKPha+G
   f0XOvPgxSc815+Xw7GYbAQPakud2Hko4JJdD3gQI5xgJo5mHvJKb6JmW7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="275756735"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="275756735"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 08:31:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="635880026"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga002.fm.intel.com with ESMTP; 18 Feb 2022 08:31:43 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 21IGVegh000316;
        Fri, 18 Feb 2022 16:31:40 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        =?UTF-8?Q?F=C4=81ng-ru=C3=AC_S=C3=B2ng?= <maskray@google.com>,
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
Date:   Fri, 18 Feb 2022 17:31:11 +0100
Message-Id: <20220218163111.98564-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <alpine.LSU.2.21.2202161606430.1475@pobox.suse.cz>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com> <20220209185752.1226407-3-alexandr.lobakin@intel.com> <20220211174130.xxgjoqr2vidotvyw@treble> <CAFP8O3KvZOZJqOR8HYp9xZGgnYf3D8q5kNijZKORs06L-Vit1g@mail.gmail.com> <20220211183529.q7qi2qmlyuscxyto@treble> <alpine.LSU.2.21.2202161606430.1475@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Miroslav Benes <mbenes@suse.cz>
Date: Wed, 16 Feb 2022 16:15:20 +0100 (CET)

> On Fri, 11 Feb 2022, Josh Poimboeuf wrote:
> 
> > On Fri, Feb 11, 2022 at 10:05:02AM -0800, Fāng-ruì Sòng wrote:
> > > On Fri, Feb 11, 2022 at 9:41 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > >
> > > > On Wed, Feb 09, 2022 at 07:57:39PM +0100, Alexander Lobakin wrote:
> > > > > Position-based search, which means that if there are several symbols
> > > > > with the same name, the user needs to additionally provide the
> > > > > "index" of a desired symbol, is fragile. For example, it breaks
> > > > > when two symbols with the same name are located in different
> > > > > sections.
> > > > >
> > > > > Since a while, LD has a flag `-z unique-symbol` which appends
> > > > > numeric suffixes to the functions with the same name (in symtab
> > > > > and strtab). It can be used to effectively prevent from having
> > > > > any ambiguity when referring to a symbol by its name.
> > > >
> > > > In the patch description can you also give the version of binutils (and
> > > > possibly other linkers) which have the flag?
> > > 
> > > GNU ld>=2.36 supports -z unique-symbol. ld.lld doesn't support -z unique-symbol.
> > > 
> > > I subscribe to llvm@lists.linux.dev and happen to notice this message
> > > (can't keep up with the changes...)
> > > I am a bit concerned with this option and replied last time on
> > > https://lore.kernel.org/r/20220105032456.hs3od326sdl4zjv4@google.com
> > > 
> > > My full reasoning is on
> > > https://maskray.me/blog/2020-11-15-explain-gnu-linker-options#z-unique-symbol
> > 
> > Ah, right.  Also discussed here:
> > 
> >   https://lore.kernel.org/all/20210123225928.z5hkmaw6qjs2gu5g@google.com/T/#u
> >   https://lore.kernel.org/all/20210125172124.awabevkpvq4poqxf@treble/
> > 
> > I'm not qualified to comment on LTO/PGO stability issues, but it doesn't
> > sound good.  And we want to support livepatch for LTO kernels.
> 
> Hm, bear with me, because I am very likely missing something which is 
> clear to everyone else...
> 
> Is the stability really a problem for the live patching (and I am talking 
> about the live patching only here. It may be a problem elsewhere, but I am 
> just trying to understand.)? I understand that two different kernel builds 
> could have a different name mapping between the original symbols and their 
> unique renames. Not nice. But we can prepare two different live patches 
> for these two different kernels. Something one would like to avoid if 
> possible, but it is not impossible. Am I missing something?
>  
> > Also I realized that this flag would have a negative effect on
> > kpatch-build, as it currently does its analysis on .o files.  So it
> > would have to figure out how to properly detect function renames, to
> > avoid patching the wrong function for example.
> 
> Yes, that is unfortunate. And not only for kpatch-build.
> 
> > And if LLD doesn't plan to support the flag then it will be a headache
> > for livepatch (and the kernel in general) to deal with the divergent
> > configs.
> 
> True.
> 
> The position-based approach clearly shows its limits. I like <file+func> 
> approach based on kallsyms tracking, that you proposed elsewhere in the 
> thread, more.

Hmm, same.

For FG-KASLR part, `-ffunction-sections` has no options, it only
appends the function name to the name of a function, i.e. it can
be only ".text.dup".
However, LD scripts allow to specify a particular input file for
the section being described, i.e.:

.text.dup {         .text.file1_dup {
    (.text.dup) ->      file1.o(.text.dup)
}                   }
                    .text.file2_dup {
                        file2.o(.text.dup)
                    }

But the problem is that currently vmlinux is being linked from
vmlinux.o solely, so there are no input files apart from vmlinux.o.
I could probably (not 100% sure, I'm not deep into the details of
thin archives) create a temporary linker script for vmlinux.o
itself to process duplicates. Then vmlinux.o will always have only
unique section names right from the start.
It may not worth it: I don't mind that random functions with the
same name go into one section, it's not a big deal and/or security
risk, and it doesn't help livepatch which operates with symbol
names, not sections.

Re livepatch, the best option would probably be storing relative
paths to the object files in kallsyms. By relative I mean starting
from $srctree -- this would keep their versatility (no abspaths),
but provide needed uniquity:

dup()    main.o:dup()    init/main.o:dup()       /mnt/init/main.o:dup()
dup()    main.o:dup()    foo/bar/main.o:dup()    /mnt/foo/bar/main.o:dup()

                         ^^^^^^ here ^^^^^^

The problem is that kallsyms are being generated at the moment of
(re)linking vmlinux already and no earlier.
If I could catch STT_FILE (can't say for sure now), it would provide
only filenames, so wouldn't be enough.
...oh wait, kallsyms rely on `nm` output. I checked nm's `-l` which
tries to find a file corresponding to each symbol and got a nice
output:

ffffffff8109ad00 T switch_mm_irqs_off	/home/alobakin/Documents/work/xdp_hints/linux/arch/x86/mm/tlb.c:488

So this could be parsed with no issues nto:

name: switch_mm_irqs_off
addr: 0x9ad00 (rel)
file: arch/x86/mm/tlb.c

This solves a lot. One problem is that

> time nm -ln vmlinux > ~/Documents/tmp/nml
nm -ln vmlinux > ~/Documents/tmp/nml  120.80s user 1.77s system 99% cpu 2:02.94 total

it took 2 minutes to generate the whole map (instead of a split
second) (on 64-core CPU, but I guess nm runs in one thread).
I guess it can be optimized? I'm no a binutils master (will take a
look after sending this), is there a way to do it manually skipping
this nm lag or maybe make nm emit filenames without such delays?

> 
> Miroslav

Thanks,
Al
