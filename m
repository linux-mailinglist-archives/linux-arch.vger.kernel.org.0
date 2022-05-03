Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96142517EF1
	for <lists+linux-arch@lfdr.de>; Tue,  3 May 2022 09:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiECHep (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 May 2022 03:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiECHeo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 May 2022 03:34:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8B817074;
        Tue,  3 May 2022 00:31:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1FF1E1F749;
        Tue,  3 May 2022 07:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651563072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w+PouQmnZ9GsbOBxPEA2aGYdP7XgCY+B9Qhwz2UQ8+Y=;
        b=ox1CyHAMnWjmEqLQwK8dSc53AwYIueIddr3rIyNhdAh2r9ypOQwtjkrpz55leMI4agVEFu
        ifQJhpDj2meSrhcdmc3gQKoNNsVuYOX/JYRryRrYxdQrC4tq6KadDhHNSdJoAa4NxZmGNc
        jChZK/w6hEpO3GjgQW3mNeQDcjqP/fQ=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 148A12C141;
        Tue,  3 May 2022 07:31:08 +0000 (UTC)
Date:   Tue, 3 May 2022 09:31:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     linux-hardening@vger.kernel.org, x86@kernel.org,
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
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v10 01/15] modpost: fix removing numeric suffixes
Message-ID: <YnDaO5ThkiYkRXbO@alley>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
 <20220209185752.1226407-2-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209185752.1226407-2-alexandr.lobakin@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed 2022-02-09 19:57:38, Alexander Lobakin wrote:
> `-z unique-symbol` linker flag which is planned to use with FG-KASLR
> to simplify livepatching (hopefully globally later on) triggers the
> following:
> 
> ERROR: modpost: "param_set_uint.0" [vmlinux] is a static EXPORT_SYMBOL
> 
> The reason is that for now the condition from remove_dot():
> 
> if (m && (s[n + m] == '.' || s[n + m] == 0))
> 
> which was designed to test if it's a dot or a '\0' after the suffix
> is never satisfied.
> This is due to that `s[n + m]` always points to the last digit of a
> numeric suffix, not on the symbol next to it (from a custom debug
> print added to modpost):
> 
> param_set_uint.0, s[n + m] is '0', s[n + m + 1] is '\0'

Yup, the + 1  is for the '.' between the symbol name and the number.
In the order of apperance it would be: n + 1 + m

> So it's off-by-one and was like that since 2014.
> Fix this for the sake of upcoming features, but don't bother
> stable-backporting, as it's well hidden -- apart from that LD flag,
> can be triggered only by GCC LTO which never landed upstream.
> 
> Fixes: fcd38ed0ff26 ("scripts: modpost: fix compilation warning")
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
