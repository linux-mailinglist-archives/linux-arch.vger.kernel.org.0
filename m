Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601A5406B68
	for <lists+linux-arch@lfdr.de>; Fri, 10 Sep 2021 14:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhIJMbW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Sep 2021 08:31:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:57381 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232997AbhIJMbW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Sep 2021 08:31:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="219205329"
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="219205329"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 05:30:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="431539785"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga006.jf.intel.com with ESMTP; 10 Sep 2021 05:30:05 -0700
Received: from alobakin-mobl.ger.corp.intel.com (alobakin-mobl.ger.corp.intel.com [10.237.140.50])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 18ACU3af025901;
        Fri, 10 Sep 2021 13:30:03 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-hardening@vger.kernel.org,
        Kristen C Accardi <kristen.c.accardi@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Lukasz Czapnik <lukasz.czapnik@intel.com>,
        Marta A Plantykow <marta.a.plantykow@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@intel.com>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v6 kspp-next 16/22] livepatch: only match unique symbols when using fgkaslr
Date:   Fri, 10 Sep 2021 14:29:53 +0200
Message-Id: <20210910122953.400-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <alpine.LSU.2.21.2109091347400.20761@pobox.suse.cz>
References: <20210831144115.154-1-alexandr.lobakin@intel.com> <20210831144114.154-17-alexandr.lobakin@intel.com> <alpine.LSU.2.21.2109091347400.20761@pobox.suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Miroslav Benes <mbenes@suse.cz>
Date: Thu, 9 Sep 2021 13:53:35 +0200 (CEST)

> Hi,

Hi!

> On Tue, 31 Aug 2021, Alexander Lobakin wrote:
> 
> > From: Kristen Carlson Accardi <kristen@linux.intel.com>
> > 
> > If any type of function granular randomization is enabled, the sympos
> > algorithm will fail, as it will be impossible to resolve symbols when
> > there are duplicates using the previous symbol position.
> > 
> > Override the value of sympos to always be zero if fgkaslr is enabled for
> > either the core kernel or modules, forcing the algorithm
> > to require that only unique symbols are allowed to be patched.
> > 
> > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> > Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> > ---
> >  kernel/livepatch/core.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index 335d988bd811..852bbfa9da7b 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -169,6 +169,17 @@ static int klp_find_object_symbol(const char *objname, const char *name,
> >  	else
> >  		kallsyms_on_each_symbol(klp_find_callback, &args);
> >  
> > +	/*
> > +	 * If any type of function granular randomization is enabled, it
> > +	 * will be impossible to resolve symbols when there are duplicates
> > +	 * using the previous symbol position (i.e. sympos != 0). Override
> > +	 * the value of sympos to always be zero in this case. This will
> > +	 * force the algorithm to require that only unique symbols are
> > +	 * allowed to be patched.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_FG_KASLR))
> > +		sympos = 0;
> > +
> 
> I ran the live patching tests and no problem occurred, which is great. We 
> do not have a test for old_sympos, which makes the testing less telling, 
> but at least nothing blows up with the section randomization itself.

Great, thanks!

> However, I want to reiterate what I wrote for the same patch in v5 
> series.
> 
> The above hunk should work, but I wonder if we should make it more 
> explicit. With the change the user will get the error with "unresolvable 
> ambiguity for symbol..." if they specify sympos and the symbol is not 
> unique. It could confuse them.
> 
> So, how about it making it something like
> 
> if (IS_ENABLED(CONFIG_FG_KASLR) || IS_ENABLED(CONFIG_MODULE_FG_KASLR))
>         if (sympos) {
>                 pr_err("fgkaslr is enabled, specifying sympos for symbol '%s' in object '%s' does not work.\n",
>                         name, objname);
>                 *addr = 0;
>                 return -EINVAL;
>         }
> 
> ? (there could be goto to the error out at the end of the function to 
> save copy-pasting).
> 
> In that case, if sympos is not specified, the user will get the message 
> which matches the reality. If the user specifies it, they will get the 
> error in case of fgkaslr (no matter if the symbol is found or not).

Not familiar with livepatching unfortunately, hope Kristen and/or
Kees will comment on this. Looks fine for me anyways.

> What do you think?
> 
> Miroslav

Thanks,
Al
