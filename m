Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38F95661FE
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 05:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiGEDt4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 23:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbiGEDtz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 23:49:55 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7C012AB7;
        Mon,  4 Jul 2022 20:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WiklvS9k0el8XhEQTp2AsFsJfZTmp2j5g87JdjG5LuY=; b=A6t/lG34n3OcVFs5zHW4rDAgZU
        dB25v6MxiCdWY7bmdH/wWMwaUIjPEoO1NWhXrC7y6CSmgLDL6bimS/XngJ2GfM7RDrgo98UN/Hj5w
        phxCr6dVDxHMO5OyImVJNe+pBY/kpdH+uHILtmM5FEJN5dminDlfCj7TB7tUgjynMeYgPLR9ZJLg6
        5iq4kIYJ9iFtlCfW/XX9hM6JjSG8RfvMehgbWUy1/mO7jhrbxMHwv6wuVdX66t8kIJebaxLKtFSpY
        JUWGP8LidNDDQzx7AI81vdD7vBuNViIZtGOuVxRemJ+Jh/b9pHi+7NtjZp1cROsoB+T5lnwoKjDFA
        yiZQuu/A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o8ZYY-008EUH-Gz;
        Tue, 05 Jul 2022 03:48:58 +0000
Date:   Tue, 5 Jul 2022 04:48:58 +0100
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
Subject: Re: [PATCH 1/7] __follow_mount_rcu(): verify that mount_lock remains
 unchanged
Message-ID: <YsO0qu97PYZos2G1@ZenIV>
References: <YsM5XHy4RZUDF8cR@ZenIV>
 <CAHk-=wjeEre7eeWSwCRy2+ZFH8js4u22+3JTm6n+pY-QHdhbYw@mail.gmail.com>
 <YsNFoH0+N+KCt5kg@ZenIV>
 <CAHk-=whp8Npc+vMcgbpM9mrPEXkhV4YnhsPxbPXSu9gfEhKWmA@mail.gmail.com>
 <YsNRsgOl04r/RCNe@ZenIV>
 <CAHk-=wih_JHVPvp1qyW4KNK0ctTc6e+bDj4wdTgNkyND6tuFoQ@mail.gmail.com>
 <YsNVyLxrNRFpufn8@ZenIV>
 <YsN0GURKuaAqXB/e@ZenIV>
 <YsN1kfBsfMdH+eiU@ZenIV>
 <CAHk-=wjmD7BgykuZYDOH-fmvfE3VMXm3qSoRjGShjKKdiiPDtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjmD7BgykuZYDOH-fmvfE3VMXm3qSoRjGShjKKdiiPDtA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 04, 2022 at 05:06:17PM -0700, Linus Torvalds wrote:

> I wonder if the solution might not be to create a new structure like
> 
>         struct rcu_dentry {
>                 struct dentry *dentry;
>                 unsigned seq;
>         };
> 
> and in fact then we could make __d_lookup_rcu() return one of these
> things (we already rely on that "returning a two-word structure is
> efficient" elsewhere).
>
> That would then make that "this dentry goes with this sequence number"
> be a very clear thing, and I actually thjink that it would make
> __d_lookup_rcu() have a cleaner calling convention too, ie we'd go
> from
> 
>         dentry = __d_lookup_rcu(parent, &nd->last, &nd->next_seq);
> 
> rto
> 
>        dseq = __d_lookup_rcu(parent, &nd->last);
> 
> and it would even improve code generation because it now returns the
> dentry and the sequence number in registers, instead of returning one
> in a register and one in memory.
> 
> I did *not* look at how it would change some of the other places, but
> I do like the notion of "keep the dentry and the sequence number that
> goes with it together".
> 
> That "keep dentry as a local, keep the sequence number that goes with
> it as a field in the 'nd'" really does seem an odd thing. So I'm
> throwing the above out as a "maybe we could do this instead..".

I looked into that; turns out to be quite messy, unfortunately.  For one
thing, the distance between the places where we get the seq count and
the place where we consume it is large; worse, there's a bunch of paths
where we are in non-RCU mode converging to the same consumer and those
need a 0/1/-1/whatever paired with dentry.  Gets very clumsy...

There might be a clever way to deal with pairs cleanly, but I don't see it
at the moment.  I'll look into that some more, but...

BTW, how good gcc and clang are at figuring out that e.g.

static int foo(int n)
{
	if (likely(n >= 0))
		return 0;
	....
}

....
	if (foo(n))
		whatever();

should be treated as
	if (unlikely(foo(n)))
		whatever();

They certainly do it just fine if the damn thing is inlined (e.g.
all those unlikely(read_seqcount_retry(....)) can and should lose
unlikely), but do they manage that for non-inlined functions in
the same compilation unit?  Relatively recent gcc seems to...
