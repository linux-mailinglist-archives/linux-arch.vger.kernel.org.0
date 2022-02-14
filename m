Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811B04B4F89
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 13:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352111AbiBNMAh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 07:00:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiBNMAg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 07:00:36 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B8DCFA;
        Mon, 14 Feb 2022 04:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vrno95ckgyNZyTDaz0cxWeVMJf3/5VGWMZm2iflspMA=; b=DbFyDh73sddokDaXx0Lfi0R3f9
        3LM/8QuYShYk70AL/7BQOgCR6JoVl6UlqVGlhOvQNd+AVIW/BMBTryCH+Cu5IDioUss955Yt7ynk9
        /7BjDllCHbIHhQeeXrOb2egSffpeatjS9x0whRRwCjx6Z2+7h0PbeCD80iYuzpb2B1K+pTsmYQHpy
        x2k6fZXbtf2V9mTxncO0kDw0Xga/JMR2o9iROVt5EZJlXBB3EULFOArIPe0iJVULIvI2oScz6vEsC
        eid+p2o5HJ2qaE7tyGpH+W6kr92OaoLnuYUo5OCKUCCCkSjMgwMlxdJQXdmdkgPoGpFI0AcYVKFow
        XkHiBb+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJa17-009tm8-Bi; Mon, 14 Feb 2022 11:59:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A43F53002C5;
        Mon, 14 Feb 2022 12:59:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E9D12D1EC148; Mon, 14 Feb 2022 12:59:35 +0100 (CET)
Date:   Mon, 14 Feb 2022 12:59:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
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
Subject: Re: [PATCH v10 10/15] FG-KASLR: use a scripted approach to handle
 .text.* sections
Message-ID: <YgpEJ7BmuYtHkayT@hirez.programming.kicks-ass.net>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
 <20220209185752.1226407-11-alexandr.lobakin@intel.com>
 <20220211153706.GW23216@worktop.programming.kicks-ass.net>
 <20220214113434.5256-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214113434.5256-1-alexandr.lobakin@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 14, 2022 at 12:34:34PM +0100, Alexander Lobakin wrote:

> Re "won't do" -- sorry for trying to hijack this thread a bit, but
> did I miss something? The last comments I've read were that LLVM
> tools need to change their approach for CFI on x86, and Sami went
> redo it, but I can't recall any "life-time" nacks.

Won't as in the lclang-cfi as it exists today. And I've understood that
this CFI model is a keeper. It is true that Sami has been working on an
alternative KCFI, but the little I can make of this proposal, it
still needs serious work. Also see here:

  https://lkml.kernel.org/r/20220211133803.GV23216@worktop.programming.kicks-ass.net

Specifically, I object to the existence of any __*cfi_check_fail symbol
on the grounds that it will bloat the code (and makes thinking about the
whole speculation angle more painful than it needs to be).
