Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F15E483491
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 17:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiACQHe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 11:07:34 -0500
Received: from mga02.intel.com ([134.134.136.20]:29872 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231648AbiACQHe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 3 Jan 2022 11:07:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641226054; x=1672762054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rVVwDAkcOxhvyeGTJ9bFMrtt0ZWlk8cQj8m6qKDK0tg=;
  b=Bqjjn6mwGSRgG9KY0aWfbooRTW2ZyS7SPHPhIA/OHX8sjyJZKx5SH3Di
   srJ9m0KDbjNfkyP5pKpK7bIEScg5a/+HtqIAvxVIfrtCrkxSYhsVm98oc
   FxI6hWF1sVYF/H1Zf524xtpZs4PmEivyqp2lmAJAbxihTAu4D6Phu0OX3
   WC2f17pPCDsMRCDr+O68L6NIDfzRE5b2vTLBvtQ0/57gMPwKsToqto6gS
   zOlJdmx5b2lXiGdsZp83mz8p3SJIMQPEBQCNSwxVHaV7Tgj+5H66dR+hI
   EzT1ZPXCLa9TybRZDVF+RzT63n/IAUqeg2vy6TSZ7/xeYPvavonI5fC6D
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="229392993"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="229392993"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 08:07:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="760128765"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jan 2022 08:07:25 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 203G7Mbb027955;
        Mon, 3 Jan 2022 16:07:22 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        =?UTF-8?Q?F=C4=81ng-ru=C3=AC_S=C3=B2ng?= <maskray@google.com>,
        Borislav Petkov <bp@alien8.de>,
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
Date:   Mon,  3 Jan 2022 17:06:15 +0100
Message-Id: <20220103160615.7904-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <alpine.LSU.2.21.2201031447140.15051@pobox.suse.cz>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com> <20211223002209.1092165-3-alexandr.lobakin@intel.com> <Yc2Tqc69W9ukKDI1@zn.tnic> <CAFP8O3K1mkiCGMTEeuSifZtr2piHsKTjP5TOA25nqpv2SrbzYQ@mail.gmail.com> <alpine.LSU.2.21.2201031447140.15051@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Miroslav Benes <mbenes@suse.cz>
Date: Mon, 3 Jan 2022 14:55:42 +0100 (CET)

> On Thu, 30 Dec 2021, Fāng-ruì Sòng wrote:
> 
> > On Thu, Dec 30, 2021 at 3:11 AM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Thu, Dec 23, 2021 at 01:21:56AM +0100, Alexander Lobakin wrote:
> > > > [PATCH v9 02/15] livepatch: use `-z unique-symbol` if available to nuke pos-based search
> 
> ...
> 
> > Apologies since I haven't read the patch series.
> > 
> > The option does not exist in ld.lld and I am a bit concerning about
> > its semantics: https://maskray.me/blog/2020-11-15-explain-gnu-linker-options#z-unique-symbol
> > 
> > I thought that someone forwarded my comments (originally posted months
> > on a feature request ago) here but seems not.
> > (I am a ld.lld maintainer.)
> 
> Do you mean 
> https://lore.kernel.org/all/20210123225928.z5hkmaw6qjs2gu5g@google.com/T/#u 
> ?
> 
> Unfortunately, it did not lead anywhere. I think that '-z unique-symbol' 
> option should work fine as long as the live patching is concerned. Maybe I 
> misunderstood but your concerns mentioned at the blog do not apply. The 
> stability is not an issue for us since we (KLP) always work with already 
> built and fixed kernel. And(at least) GCC already uses number suffices for 
> IPA clones and it has not been a problem anywhere.

LLD doesn't have such an option, so FG-KASLR + livepatching builds
wouldn't be available for LLVM with the current approach (or we'd
still need a stub that prints "FG-KASLR is not compatible with
sympos != 0").
Unfortunately, I discovered this a bit late, just after sending this
revision.

OTOH, there's no easy alternative. <file + function> pair looks
appealing, but is it even possible for now to implement in the
kernel without much refactoring?

>
> Am I wrong?
> 
> Thanks
> 
> Miroslav 

Thanks,
Al
