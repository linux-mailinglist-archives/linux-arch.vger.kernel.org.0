Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD616564446
	for <lists+linux-arch@lfdr.de>; Sun,  3 Jul 2022 06:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiGCEFf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Jul 2022 00:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiGCEFX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Jul 2022 00:05:23 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1988113D6F;
        Sat,  2 Jul 2022 21:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LQzNJSrqoKMb8FMCvc/7lp2Km4cof1d6Hftc45fNj1g=; b=SlO+fKNyilPz+TVpOIzdYjMW8I
        Hsqq6l0JUqmKZnzFIfvzTAUxDFekbW1Xjbq8aFbgAuxIsNiVPE0oNLXIPm359WVbU9Seg97M9+O7r
        OojR6bi66spE6YIUgfO2Wu6DSNRFi+RBxtuotkAqiPYTj9usTSh8wTRcfL43lp3ajxi3TLHEA/12n
        Y/F8O4V669jsNhJbuRbb9bPkk4FAB58VW1SMi3Rp9ILhYuca0CNGJvhv3GHuBQzPvPNX4V4l0rn2N
        TJHAKEHb9PbmaIPNcrTdaKaLlrLK2KL2N2ui7v/i5dQvTkEUTppJSfvwBi0BvCcWXWFL7X/ISPBy0
        SdFr/OuA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o7qlz-007YYP-Mg;
        Sun, 03 Jul 2022 03:59:51 +0000
Date:   Sun, 3 Jul 2022 04:59:51 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Vitaly Buka <vitalybuka@google.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Subject: Re: [PATCH v4 43/45] namei: initialize parameters passed to
 step_into()
Message-ID: <YsEUNyKcIiSowfIR@ZenIV>
References: <20220701142310.2188015-1-glider@google.com>
 <20220701142310.2188015-44-glider@google.com>
 <CAHk-=wgbpot7nt966qvnSR25iea3ueO90RwC2DwHH=7ZyeZzvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgbpot7nt966qvnSR25iea3ueO90RwC2DwHH=7ZyeZzvQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 02, 2022 at 10:23:16AM -0700, Linus Torvalds wrote:
> On Fri, Jul 1, 2022 at 7:25 AM Alexander Potapenko <glider@google.com> wrote:
> >
> > Under certain circumstances initialization of `unsigned seq` and
> > `struct inode *inode` passed into step_into() may be skipped.
> > In particular, if the call to lookup_fast() in walk_component()
> > returns NULL, and lookup_slow() returns a valid dentry, then the
> > `seq` and `inode` will remain uninitialized until the call to
> > step_into() (see [1] for more info).

> So while I think this needs to be fixed, I think I'd really prefer to
> make the initialization and/or usage rules stricter or at least
> clearer.

Disclaimer: the bits below are nowhere near what I consider a decent
explanation; this might serve as the first approximation, but I really
need to get some sleep before I get it into coherent shape.  4 hours
of sleep today...

The rules are
	* no pathname resolution without successful path_init().
IOW, path_init() failure is an instant fuck off.
	* path_init() success sets nd->inode.  In all cases.
	* nd->inode must be set - LOOKUP_RCU or not, we simply cannot
proceed without it.

	* in non-RCU mode nd->inode must be equal to nd->path.dentry->d_inode.
	* in RCU mode nd->inode must be equal to a value observed in
nd->path.dentry->d_inode while nd->path.dentry->d_seq had been equal to
nd->seq.

	* step_into() gets a dentry/inode/seq triple.  In non-RCU
mode inode and seq are ignored; in RCU mode they must satisfy the
same relationship we have for nd->path.dentry/nd->inode/nd->seq.

> Of course, sometimes the "only get used for LOOKUP_RCU" is very very
> unclear, because even without being an RCU lookup, step_into() will
> save it into nd->inode/seq. So the values were "used", and
> initializing them makes them valid, but then *that* copy must not then
> be used unless RCU was set.

You are misreading that (and I admit that it badly needs documentation).
The whole point of step_into() is to move over to new place.  nd->inode
*MUST* be set on success, no matter what.

>  - I look at that follow_dotdot*() caller case, and think "that looks
> very similar to the lookup_fast() case, but then we have *very*
> different initialization rules".

follow_dotdot() might as well lose inodep and seqp arguments - everything
would've worked just as well without those.  We would've gotten the same
complaints about uninitialized values passed to step_into(), though.

This
                if (unlikely(!parent))
                        error = step_into(nd, WALK_NOFOLLOW,
                                         nd->path.dentry, nd->inode, nd->seq);
in handle_dots() probably contributes to confusion - it's the "we
have stepped on .. in the root, just jump into whatever's mounted on
it" case.  In non-RCU case it looks like a use of nd->seq in non-RCU
mode; however, in that case step_into() will end up ignoring the
last two arguments.

I'll post something more coherent after I get some sleep.  Sorry... ;-/
