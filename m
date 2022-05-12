Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35ABC524C72
	for <lists+linux-arch@lfdr.de>; Thu, 12 May 2022 14:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353574AbiELMLk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 May 2022 08:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353577AbiELMLj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 May 2022 08:11:39 -0400
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [216.12.86.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C0D3D4AD
        for <linux-arch@vger.kernel.org>; Thu, 12 May 2022 05:11:33 -0700 (PDT)
Date:   Thu, 12 May 2022 08:11:31 -0400
From:   Rich Felker <dalias@libc.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     musl@lists.openwall.com, Christian Brauner <brauner@kernel.org>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Linux API <linux-api@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>
Subject: Re: [musl] Re: [PATCH V9 13/24] LoongArch: Add system call support
Message-ID: <20220512121131.GH7074@brightrain.aerifal.cx>
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-14-chenhuacai@loongson.cn>
 <CAK8P3a0A9dW4mwJ6JHDiJxizL7vWfr4r4c5KhbjtAY0sWbZJVA@mail.gmail.com>
 <CAAhV-H4te_+AS69viO4eBz=abBUm5oQ6AfoY1Cb+nOCZyyeMdA@mail.gmail.com>
 <CAK8P3a0DqQcApv8aa2dgBS5At=tEkN7cnaskoUeXDi2-Bu9Rnw@mail.gmail.com>
 <20220507121104.7soocpgoqkvwv3gc@wittgenstein>
 <20220509100058.vmrgn5fkk3ayt63v@wittgenstein>
 <CAK8P3a0zmPbMNsS11aUGiAADyjOEueNUXQ8QZtVxr48M3pwAkQ@mail.gmail.com>
 <20220511211231.GG7074@brightrain.aerifal.cx>
 <CAK8P3a05wSVu7M9kVMw5cSqx84YUCk1394Yfd_5tweEOc2P69g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a05wSVu7M9kVMw5cSqx84YUCk1394Yfd_5tweEOc2P69g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 12, 2022 at 09:21:13AM +0200, Arnd Bergmann wrote:
> On Wed, May 11, 2022 at 11:12 PM Rich Felker <dalias@libc.org> wrote:
> > On Wed, May 11, 2022 at 09:11:56AM +0200, Arnd Bergmann wrote:
> > > On Mon, May 9, 2022 at 12:00 PM Christian Brauner <brauner@kernel.org> wrote:
> > > .....
> > > > I can try and move a poc for this up the todo list.
> > > >
> > > > Without an approach like this certain sandboxes will fallback to
> > > > ENOSYSing system calls they can't filter. This is a generic problem
> > > > though with clone3() being one promiment example.
> > >
> > > Thank you for the detailed reply. It sounds to me like this will eventually have
> > > to get solved anyway, so we could move ahead without clone() on loongarch,
> > > and just not have support for Chrome until this is fully solved.
> > >
> > > As both the glibc and musl ports are being proposed for inclusion right
> > > now, we should try to come to a decision so the libc ports can adjust if
> > > necessary. Adding both mailing lists to Cc here, the discussion is archived
> > > at [1].
> > >
> > >          Arnd
> > >
> > > [1] https://lore.kernel.org/linux-arch/20220509100058.vmrgn5fkk3ayt63v@wittgenstein/
> >
> > Having read about the seccomp issue, I think it's a very strong
> > argument that __NR_clone should be kept permanently for all future
> > archs.
> 
> Ok, let's keep clone() around for all architectures then. We should probably
> just remove the __ARCH_WANT_SYS_CLONE macro and build the
> code into the kernel unconditionally, but at the moment there
> are still private versions for ia64 and sparc with the same name as
> the generic version. Both are also still lacking support for clone3() and
> don't have anyone actively working on them.
> 
> In this case, we probably don't need to change clone3() to allow the
> zero-length stack after all, and the wrapper that was added to the
> musl port should get removed again.

I still think disallowing a zero length (unknown length with caller
providing the start address only) stack is a gratuitous limitation on
the clone3 interface, and would welcome leaving the change to allow
zero-length in place. There does not seem to be any good justification
for forbidding it, and it does pose other real-world obstruction to
use. For example if your main thread had exited (or if you're forking
from a non-main thread) and you wanted to create a new process using
the old main thread stack as your stack, you would not know a
size/lowest-address, only a starting address from which it extends
some long (and possibly expanding) amount.

Rich
