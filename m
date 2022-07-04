Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FB3565EA0
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 22:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiGDUrX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 16:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiGDUrV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 16:47:21 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1C22630;
        Mon,  4 Jul 2022 13:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q731IdPTtbWT2I3vbiClRvKMIPfhcPeg7PDkz8ljupo=; b=JqCpfM5+ZnF4a2bPP1EP4QyFNP
        vBpzm4BVvaQCCnYWRX8171Gowyemw8skAK8mPjRXvlzaaGh7Qj2Id0ZiPBjOa1vpVzgMbcuIykFDo
        qlylUJo63UjcuLdTUuGnkvsrAQc0lbWj0xeYJn9CQoGCE8Oxi4z2sLBwYaAMdqkI/Ns6u2zYuXkks
        CPoGuTCYI+djgFZEkMKPcsXljk3yzHFHQH5p/Ki60sIk4qTLbL3JC1ynxCUPK4V9PodU/uOMjzQe7
        vv4YcJk2eePA/Dj3w3dh29o/KVeQvqvGjXgSWDmlOn9uJ4p1MKO665SwTXHUM0W09dauEtWsVjf1Z
        MESUVrYg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o8Sxv-0088VZ-0F;
        Mon, 04 Jul 2022 20:46:43 +0000
Date:   Mon, 4 Jul 2022 21:46:42 +0100
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
Message-ID: <YsNRsgOl04r/RCNe@ZenIV>
References: <20220701142310.2188015-1-glider@google.com>
 <20220701142310.2188015-44-glider@google.com>
 <CAHk-=wgbpot7nt966qvnSR25iea3ueO90RwC2DwHH=7ZyeZzvQ@mail.gmail.com>
 <YsJWCREA5xMfmmqx@ZenIV>
 <CAHk-=wjxqKYHu2-m1Y1EKVpi5bvrD891710mMichfx_EjAjX4A@mail.gmail.com>
 <YsM5XHy4RZUDF8cR@ZenIV>
 <CAHk-=wjeEre7eeWSwCRy2+ZFH8js4u22+3JTm6n+pY-QHdhbYw@mail.gmail.com>
 <YsNFoH0+N+KCt5kg@ZenIV>
 <CAHk-=whp8Npc+vMcgbpM9mrPEXkhV4YnhsPxbPXSu9gfEhKWmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whp8Npc+vMcgbpM9mrPEXkhV4YnhsPxbPXSu9gfEhKWmA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 04, 2022 at 01:24:48PM -0700, Linus Torvalds wrote:
> On Mon, Jul 4, 2022 at 12:55 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > You are checking the wrong thing here.  It's really about mount_lock -
> > ->d_seq is *not* bumped when we or attach in some namespace.
> 
> I think we're talking past each other.

We might be.
 
> Yes, we need to check the mount sequence lock too, because we're doing
> that mount traversal.
> 
> But I think we *also* need to check the dentry sequence count, because
> the dentry itself could have been moved to another parent.

Why is that a problem?  It could have been moved to another parent,
but so it could after we'd crossed to the mounted and we wouldn't have
noticed (or cared).

What the chain of seqcount checks gives us is that with some timings
it would be possible to traverse that path, not that it had remained
valid through the entire pathwalk.

What I'm suggesting is to treat transition from mountpoint to mount
as happening instantly, with transition from mount to root sealed by
mount_lock check.

If that succeeds, there had been possible history in which refwalk
would have passed through the same dentry/mount/dentry and arrived
to the root dentry when it had the sampled ->d_seq value.

Sure, mountpoint might be moved since we'd reached it.  And the mount
would move with it, so we can pretend that we'd won the race and got
into the mount before it had the mountpoint had been moved.

Am I missing something fundamental about the things the sequence of
sampling and verifications gives us?  I'd always thought it's about
verifying that resulting history would be possible for a non-RCU
pathwalk with the right timings.  What am I missing?
