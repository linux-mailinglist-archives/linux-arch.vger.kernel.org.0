Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFA2565E30
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 21:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiGDT4C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 15:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGDT4B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 15:56:01 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6DF5F8D;
        Mon,  4 Jul 2022 12:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1MlVvLG41NeVJL2nvZkPrUdGWixdJlckw5dTfoQTefk=; b=Lcb8/mafbItE20U9aUkaQKp+3D
        4wOzZ+NdnUj4WKsXvYsO53MozliGkbS+4GEcVCbqB9GlKxhJORR2Fx87qXmQRdFbVLjV4PR6JhtcN
        a/DxIoLzPHXhTgs2UWol5vsO5HWZ+3obtKZSYP6I1OknNsGj7tuyPtN0SNFhGlyWoQPZdS25IM3ze
        gb6OdYCLOARbZHQlnpqTKOD9cUhs+ugo/UxqgHOxVE5miCRoMel/jTs6k8bqKBUVBai0SzVwCKrhX
        Wx+YeYUooo723+P4l1ZTs4NczTWV/92sLTs8oZS6lwlVjIAbzCSd0VaQSdG44K9s+iLuMUX7MHEoH
        R+6thDBA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o8SA4-0087lj-68;
        Mon, 04 Jul 2022 19:55:12 +0000
Date:   Mon, 4 Jul 2022 20:55:12 +0100
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
Message-ID: <YsNFoH0+N+KCt5kg@ZenIV>
References: <20220701142310.2188015-1-glider@google.com>
 <20220701142310.2188015-44-glider@google.com>
 <CAHk-=wgbpot7nt966qvnSR25iea3ueO90RwC2DwHH=7ZyeZzvQ@mail.gmail.com>
 <YsJWCREA5xMfmmqx@ZenIV>
 <CAHk-=wjxqKYHu2-m1Y1EKVpi5bvrD891710mMichfx_EjAjX4A@mail.gmail.com>
 <YsM5XHy4RZUDF8cR@ZenIV>
 <CAHk-=wjeEre7eeWSwCRy2+ZFH8js4u22+3JTm6n+pY-QHdhbYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjeEre7eeWSwCRy2+ZFH8js4u22+3JTm6n+pY-QHdhbYw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 04, 2022 at 12:16:24PM -0700, Linus Torvalds wrote:
> On Mon, Jul 4, 2022 at 12:03 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Anyway, I've thrown a mount_lock check in there, running xfstests to
> > see how it goes...
> 
> So my reaction had been that it would be good to just do something like this:
> 
>   diff --git a/fs/namei.c b/fs/namei.c
>   index 1f28d3f463c3..25c4bcc91142 100644
>   --- a/fs/namei.c
>   +++ b/fs/namei.c
>   @@ -1493,11 +1493,18 @@ static bool __follow_mount_rcu(struct n...
>       if (flags & DCACHE_MOUNTED) {
>           struct mount *mounted = __lookup_mnt(path->mnt, dentry);
>           if (mounted) {
>   +           struct dentry *old_dentry = dentry;
>   +           unsigned old_seq = *seqp;
>   +
>               path->mnt = &mounted->mnt;
>               dentry = path->dentry = mounted->mnt.mnt_root;
>               nd->state |= ND_JUMPED;
>               *seqp = read_seqcount_begin(&dentry->d_seq);
>               *inode = dentry->d_inode;
>   +
>   +           if (read_seqcount_retry(&old_dentry->d_seq, old_seq))
>   +               return false;
>   +
>               /*
>                * We don't need to re-check ->d_seq after this
>                * ->d_inode read - there will be an RCU delay
> 
> but the above is just whitespace-damaged random monkey-scribbling by
> yours truly.
> 
> More like a "shouldn't we do something like this" than a serious
> patch, in other words.
> 
> IOW, it has *NOT* had a lot of real thought behind it. Purely a
> "shouldn't we always clearly check the old sequence number after we've
> picked up the new one?"

You are checking the wrong thing here.  It's really about mount_lock -
->d_seq is *not* bumped when we or attach in some namespace.  If there's
a mismatch, RCU pathwalk is doomed anyway (it'll fail any form of unlazy)
and we might as well bugger off.  If it *does* match, we know that both
mountpoint and root had been pinned since before the pathwalk, remain
pinned as of that check and had a mount connecting them all along.
IOW, if we could have arrived to this dentry at any point, we would have
gotten that dentry as the next step.

We sample into nd->m_seq in path_init() and we want it to stay unchanged
all along.  If it does, all mountpoints and roots we observe are pinned
and their association with each other is stable.

It's not dentry -> dentry, it's dentry -> mount -> dentry.  The following
would've been safe:

	find mountpoint
	sample ->d_seq
	verify whatever had lead us to mountpoint

	sample mount_lock
	find mount
	verify mountpoint's ->d_seq

	find root of mounted
	sample its ->d_seq
	verify mount_lock

Correct?  Now, note that the last step done against the value we'd sampled
in path_init() guarantees that mount hash had not changed through all of
that.  Which is to say, we can pretend that we'd found mount before ->d_seq
of mountpoint might've changed, leaving us with

	find mountpoint
	sample ->d_seq
	verify whatever had lead us to mountpoint
	find mount
	find root of mounted
	sample its ->d_seq
	verify mount_lock
