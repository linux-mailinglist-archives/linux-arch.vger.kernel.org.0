Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4CA565DBB
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 21:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiGDTER (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 15:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiGDTD7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 15:03:59 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FEB11C29;
        Mon,  4 Jul 2022 12:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=StWcqGItZutY3CkZqZp4EajG2FBl6ewxUbX21EaiIa0=; b=gION5JVUSctjEA3iGVyhgDOwB8
        /cIoBlprCjdoAmu+i56RbxnuMuL4IKHr7XgAS37kiaaF4oZ1UP6Cw6APsQOce+xxaXzKDsY66devu
        sokw+Zjn7Va1VU574s0V9995iYgFWRSsgvDKJYYBEaZM+zFhtFOIEZqa2ed4WycftRArPMeF0UrEC
        NS3ZibrqrAgjlSoyiT84HEu0f9G07c6zeYA8TeenVF0dYmRU5sfuySzh3JQ3QfHGuHIaEzRGdYXqJ
        TxAAGr2j4E89bonfbrnO/p8QxTRGrgGkafzSkKhQwMVnXwFLLymD4z2DKEPHZl567ilxQiHg3gQiD
        yxdElB1Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o8RLQ-0086lx-NV;
        Mon, 04 Jul 2022 19:02:52 +0000
Date:   Mon, 4 Jul 2022 20:02:52 +0100
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
Message-ID: <YsM5XHy4RZUDF8cR@ZenIV>
References: <20220701142310.2188015-1-glider@google.com>
 <20220701142310.2188015-44-glider@google.com>
 <CAHk-=wgbpot7nt966qvnSR25iea3ueO90RwC2DwHH=7ZyeZzvQ@mail.gmail.com>
 <YsJWCREA5xMfmmqx@ZenIV>
 <CAHk-=wjxqKYHu2-m1Y1EKVpi5bvrD891710mMichfx_EjAjX4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjxqKYHu2-m1Y1EKVpi5bvrD891710mMichfx_EjAjX4A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 04, 2022 at 10:36:05AM -0700, Linus Torvalds wrote:

> For example, in __follow_mount_rcu(), when we jump to a new mount
> point, and that sequence has
> 
>                 *seqp = read_seqcount_begin(&dentry->d_seq);
> 
> to reset the sequence number to the new path we jumped into.
> 
> But I don't actually see what checks the previous sequence number in
> that path. We just reset it to the new one.

Theoretically it could be a problem.  We have /mnt/foo/bar and
/mnt/baz/bar.  Something's mounted on /mnt/foo, hiding /mnt/foo/bar.
We start a pathwalk for /mnt/baz/bar,
someone umounts /mnt/foo and swaps /mnt/foo to /mnt/baz before
we get there.  We are doomed to get -ECHILD from an attempt to
legitimize in the end, no matter what.  However, we might get
a hard error (-ENOENT, for example) before that, if we pick up
the old mount that used to be on top of /mnt/foo (now /mnt/baz)
and had been detached before the damn thing had become /mnt/baz
and notice that there's no "bar" in its root.

It used to be impossible (rename would've failed if the target had
been non-empty and had we managed to empty it first, well, there's
your point when -ENOENT would've been accurate).  With exchange...
Yes, it's a possible race.

Might need to add
                                if (read_seqretry(&mount_lock, nd->m_seq))
					return false;
in there.  And yes, it's a nice demonstration of how subtle and
brittle RCU pathwalk is - nobody noticed this bit of fun back when
RENAME_EXCHANGE had been added...  It got a lot more readable these
days, but...

> For __follow_mount_rcu it looks like validating the previous sequence
> number is left to the caller, which then does try_to_unlazy_next().

Not really - the caller goes there only if we have __follow_mount_rcu()
say "it's too tricky for me, get out of RCU mode and deal with it
there".

Anyway, I've thrown a mount_lock check in there, running xfstests to
see how it goes...
