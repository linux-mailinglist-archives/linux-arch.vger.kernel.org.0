Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBF348345C
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 16:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiACPlt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 10:41:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:20979 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbiACPls (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 3 Jan 2022 10:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641224508; x=1672760508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g5C1DLmzAjmvh8fBdfrCcd+FGlrkD8urpR90vXZoFjU=;
  b=QPK6Jse77vI5nv3kD20JUr8OHSP1W60/h8WoFBVcRIomUbFrS+SieCwW
   7IXjhdnqnyTj4RJkJsS1w63fqHOuE+rvMc42oTexVXQKzoUBLcbx1+O3S
   9F6/yzfTCegdD++Arh1AZOBQ4Wejj3q5ld0BB9XuKgXbjDmxJpLWwNQ+r
   lmW61Ew1g5rFhIRLGV90qhURoc+r5GgfVM0tUyQmPHNKPcMqEhFjBlT4g
   fndaCISAY97gT9dwLY6dsuNWX9vqxsOE6oy2fH2rXAW9BoQmg9dECnoy7
   2KtokdkR/uasbC6ST7G9OjjsBLwP5zctnX+xm4N6Ayh0dnaajGnGmILSL
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="242283703"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="242283703"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 07:41:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="688243455"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga005.jf.intel.com with ESMTP; 03 Jan 2022 07:41:39 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 203Ffa79022803;
        Mon, 3 Jan 2022 15:41:36 GMT
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
Subject: Re: [PATCH v9 03/15] kallsyms: Hide layout
Date:   Mon,  3 Jan 2022 16:40:23 +0100
Message-Id: <20220103154023.7326-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <Yc40UKmylVh38vl5@zn.tnic>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com> <20211223002209.1092165-4-alexandr.lobakin@intel.com> <Yc40UKmylVh38vl5@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Borislav Petkov <bp@alien8.de>
Date: Thu, 30 Dec 2021 23:36:00 +0100

> On Thu, Dec 23, 2021 at 01:21:57AM +0100, Alexander Lobakin wrote:
> > Subject: Re: [PATCH v9 03/15] kallsyms: Hide layout
> 
> That title is kinda laconic...

"kallsyms: randomize /proc/kallsyms output order"?

> 
> > From: Kristen Carlson Accardi <kristen@linux.intel.com>
> > 
> > This patch makes /proc/kallsyms display in a random order, rather
> 
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
> 
> Also, do
> 
> $ git grep 'This patch' Documentation/process
> 
> for more details.

Goes straight from the original series. Worth changing anyways.

> 
> > than sorted by address in order to hide the newly randomized address
> > layout.
> 
> Sorted by address?
> 
> My /proc/kallsyms says
> 
> $ awk '{ print $1 }' /proc/kallsyms | uniq -c
>  119086 0000000000000000
> 
> so all the addresses are 0. Aha, and when I list them as root, only then
> I see non-null addresses.
> 
> So why do we that patch at all?

It displays zeros for non-roots, but the symbols are still sorted by
their addresses. As a result, if you leak one address, you could
determine some others.
This is especially critical with FG-KASLR as its text layout is
random each time and sorted /proc/kallsyms would make the entire
feature useless.

> 
> > alobakin:
> > Don't depend FG-KASLR and always do that for unpriviledged accesses
> 
> Unknown word [unpriviledged] in commit message, suggestions:
>         ['unprivileged', 'underprivileged', 'privileged']

I either have some problems with checkpatch + codespell, or they
missed all that typos you're noticing. Thanks, and apologies =\

> 
> > as suggested by several folks.
> > Also, introduce and use a shuffle_array() macro which shuffles an
> > array using Fisher-Yates.
> 
> Fisher-Yates what?
> 
> /me goes and looks at the wikipedia article.
> 
> Aha, a Fisher-Yates shuffle algoithm.
> 
> Don't be afraid to explain more in your commit messages and make them
> more reader-friendly.

Sure.
This patch initially was at the tail of the set, after the commits
where this algo is mentioned several times in a more detailed
manner, but I moved it to the head then as the requests for doing
this unconditionally converted it to a pre-requisite.

> 
> > We'll make use of it several more times
> > later on.
> 
> Not important for this commit.
> 
> ...
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

Thanks!
Al
