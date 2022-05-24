Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396D653291A
	for <lists+linux-arch@lfdr.de>; Tue, 24 May 2022 13:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbiEXLep (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 May 2022 07:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236604AbiEXLeo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 May 2022 07:34:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D448BD36;
        Tue, 24 May 2022 04:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653392084; x=1684928084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dqryofZxF2pFV6kkTP1H9GJ1NQVHZ92x9MysfmWCcAg=;
  b=DX5QLJUoPEx7bCULQnV0/9GVDT09IhzQeBVBcXeEe96kpLzNxYachsxH
   S74UiPiooFqdm71f+Fr3TMgZkeWADg83vBu6POg5sslap6Z/BENze8X0Z
   GUGTiGwYNEeHPPoitHLvB/tPNQ/U9y8EPScROq9LRsXsqTiUktTyz8T9p
   N/A5gz8cfc3BanNt+I1DGJlr8RZVG0d+tPphKKK+XZdax5jldxsFmSfKH
   lizNufrUKNl4gedhmf2Iq4mTTPCdcaXiXm4MuvVXM62Sq9Xrepdog2M4k
   Jrha3YVwG3bH76WJZZHwAWmRs9CTRrz4U2gPcP99TudZk9xZzoIMm+QP1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="253378256"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="253378256"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 04:34:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="559086967"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga002.jf.intel.com with ESMTP; 24 May 2022 04:34:34 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 24OBYVcZ004315;
        Tue, 24 May 2022 12:34:31 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-hardening@vger.kernel.org, X86 ML <x86@kernel.org>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        live-patching@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>
Subject: Re: [PATCH v10 01/15] modpost: fix removing numeric suffixes
Date:   Tue, 24 May 2022 13:33:37 +0200
Message-Id: <20220524113337.4128239-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <CAK7LNAT3QTfkYLFTBKLxghY_gBQZmud3-4UJMK3tA9eOV4UeTg@mail.gmail.com>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com> <20220209185752.1226407-2-alexandr.lobakin@intel.com> <CAK7LNAT3QTfkYLFTBKLxghY_gBQZmud3-4UJMK3tA9eOV4UeTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 24 May 2022 03:04:00 +0900

> On Thu, Feb 10, 2022 at 3:59 AM Alexander Lobakin
> <alexandr.lobakin@intel.com> wrote:
> >
> > `-z unique-symbol` linker flag which is planned to use with FG-KASLR
> > to simplify livepatching (hopefully globally later on) triggers the
> > following:
> >
> > ERROR: modpost: "param_set_uint.0" [vmlinux] is a static EXPORT_SYMBOL
> >
> > The reason is that for now the condition from remove_dot():
> >
> > if (m && (s[n + m] == '.' || s[n + m] == 0))
> >
> > which was designed to test if it's a dot or a '\0' after the suffix
> > is never satisfied.
> > This is due to that `s[n + m]` always points to the last digit of a
> > numeric suffix, not on the symbol next to it (from a custom debug
> > print added to modpost):
> >
> > param_set_uint.0, s[n + m] is '0', s[n + m + 1] is '\0'
> >
> > So it's off-by-one and was like that since 2014.
> > Fix this for the sake of upcoming features, but don't bother
> > stable-backporting, as it's well hidden -- apart from that LD flag,
> > can be triggered only by GCC LTO which never landed upstream.
> >
> > Fixes: fcd38ed0ff26 ("scripts: modpost: fix compilation warning")
> > Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> > ---
> >  scripts/mod/modpost.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 6bfa33217914..4648b7afe5cc 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -1986,7 +1986,7 @@ static char *remove_dot(char *s)
> >
> >         if (n && s[n]) {
> >                 size_t m = strspn(s + n + 1, "0123456789");
> > -               if (m && (s[n + m] == '.' || s[n + m] == 0))
> > +               if (m && (s[n + m + 1] == '.' || s[n + m + 1] == 0))
> >                         s[n] = 0;
> >
> >                 /* strip trailing .lto */
> > --
> > 2.34.1
> >
> 
> This trivial patch has not been picked up yet.
> 
> I can apply this to my tree, if you want.

It's a good idea, I'd like to!
I don't use `-z unique-symbol` for FG-KALSR anymore*, but this fix
is not directly related to it and can be taken independently.
Should I change the commit message or it's ok to take it as it is?

> 
> Please let me know your thoughts.
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

* I'm planning to submit a new rev of FG-KASLR series soon, but
since I'm too busy with XDP for now, it will happen no sooner than
in a couple months =\

Thanks!
Al
