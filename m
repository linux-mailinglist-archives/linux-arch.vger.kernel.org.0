Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9554B9A00
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 08:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbiBQHqD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 02:46:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiBQHqC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 02:46:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A00E23A1A8;
        Wed, 16 Feb 2022 23:45:47 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C4B591F37D;
        Thu, 17 Feb 2022 07:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645083945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N1Bwkgc0b1NsSzA+goLBbyLYnuFpjvP2ZA623nZPeoU=;
        b=LMzvITKL+HRLw4P7XofOjk1T99l49Svs+bIG968ShkCNoMHbk4iFHhRC/+aSeIWvQXhVj4
        IUWURCieN1XSygVBt+Oo0ERi/4JQeNKE8hwXaYdSwW7+QWRjqLQ8wyIPo1sQSujPmsKUfA
        xvUKJPohu4obUX4yyl8TAjblL2pnEms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645083945;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N1Bwkgc0b1NsSzA+goLBbyLYnuFpjvP2ZA623nZPeoU=;
        b=sA66tyj6hGa43RzOunBJ54EjO34EwRWPSAqD7VXSJ/ifWqAqw8zyPNB71MS1Z0JeTybQOl
        6qqR0AaRmeM7F0Dw==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3F741A3B91;
        Thu, 17 Feb 2022 07:45:44 +0000 (UTC)
Date:   Thu, 17 Feb 2022 08:45:44 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
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
Subject: Re: [PATCH v10 02/15] livepatch: avoid position-based search if `-z
 unique-symbol` is available
In-Reply-To: <20220216195738.vhlot4udoqga4ndm@treble>
Message-ID: <alpine.LSU.2.21.2202170841240.29121@pobox.suse.cz>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com> <20220209185752.1226407-3-alexandr.lobakin@intel.com> <20220211174130.xxgjoqr2vidotvyw@treble> <alpine.LSU.2.21.2202161601010.1475@pobox.suse.cz> <20220216195738.vhlot4udoqga4ndm@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 16 Feb 2022, Josh Poimboeuf wrote:

> On Wed, Feb 16, 2022 at 04:06:24PM +0100, Miroslav Benes wrote:
> > > > +	/*
> > > > +	 * If the LD's `-z unique-symbol` flag is available and enabled,
> > > > +	 * sympos checks are not relevant.
> > > > +	 */
> > > > +	if (IS_ENABLED(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL))
> > > > +		sympos = 0;
> > > > +
> > > 
> > > Similarly, I don't see a need for this.  If the patch is legit then
> > > sympos should already be zero.  If not, an error gets reported and the
> > > patch fails to load.
> > 
> > My concern was that if the patch is not legit (that is, sympos is > 0 for 
> > some reason), the error would be really cryptic and would not help the 
> > user at all. So zeroing sympos seems to be a good idea to me. There is no 
> > harm and the change is very small and compact.
> 
> But wouldn't a cryptic error be better than no error at all?  A bad
> sympos might be indicative of some larger issue, like the wrong symbol
> getting patched.

Maybe you are right. I do not feel confident enough to decide it. So 
either way would be fine, I guess.

Miroslav
