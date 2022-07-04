Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9CB565E78
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 22:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiGDUaq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 16:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGDUaq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 16:30:46 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09176306;
        Mon,  4 Jul 2022 13:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0ahdG6vwtrla/GfArjvdjqG8Ieo6jXxVEyUk4N9P1DU=; b=ne0Uf/6y0BOWxJovHIrHEvr2xA
        xwOaT8SpGI4pQyxrDEsz0MXWEP5fU5BfmjkOS9uiXA2/uYafTL8z3mZG61t3pF8Yp5qDYFUM7dg0S
        55ceSjFJBLdMCEPY8wiIS4wC5EWV4pUiB3jRlbbqEtE6dLqHsMTI3kvXXpvDrKj3EFnC7Jy9L9kyl
        iFqZTArbZn0Ub6BGDXrPH2SDexvyUvZH3gwVyWJGfZABlTfprEuLob7jWWY+L3v2nMp1bCnQ2+KGF
        G/mLSR88wuG9n29bHZMonvBJFlpsljyW7iZOnelikF61rHzsxzej0HSZFkj1WUecw35IcXl8USJUW
        /mXzlagg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o8Sho-0088HH-1A;
        Mon, 04 Jul 2022 20:30:04 +0000
Date:   Mon, 4 Jul 2022 21:30:03 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 44/45] mm: fs: initialize fsdata passed to
 write_begin/write_end interface
Message-ID: <YsNNy9o0+6Uyb9G4@ZenIV>
References: <20220701142310.2188015-1-glider@google.com>
 <20220701142310.2188015-45-glider@google.com>
 <YsNIjwTw41y0Ij0n@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsNIjwTw41y0Ij0n@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 04, 2022 at 09:07:43PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 01, 2022 at 04:23:09PM +0200, Alexander Potapenko wrote:
> > Functions implementing the a_ops->write_end() interface accept the
> > `void *fsdata` parameter that is supposed to be initialized by the
> > corresponding a_ops->write_begin() (which accepts `void **fsdata`).
> > 
> > However not all a_ops->write_begin() implementations initialize `fsdata`
> > unconditionally, so it may get passed uninitialized to a_ops->write_end(),
> > resulting in undefined behavior.
> 
> ... wait, passing an uninitialised variable to a function *which doesn't
> actually use it* is now UB?  What genius came up with that rule?  What
> purpose does it serve?

"The value we are passing might be utter bollocks, but that way it's
obfuscated enough to confuse anyone, compiler included".

Defensive progamming, don'cha know?

I would suggest a different way to obfuscate it, though - pass const void **
and leave it for the callee to decide whether they want to dereferences it.
It is still 100% dependent upon the ->write_end() being correctly matched
with ->write_begin(), with zero assistance from the compiler, but it does
look, er, safer.  Or something.

	Of course, a clean way to handle that would be to have
->write_begin() return a partial application of foo_write_end to
whatever it wants for fsdata, to be evaluated where we would currently
call ->write_end().  _That_ could be usefully typechecked, but... we
don't have usable partial application.
