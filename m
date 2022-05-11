Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A987A523F4D
	for <lists+linux-arch@lfdr.de>; Wed, 11 May 2022 23:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240438AbiEKVMl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 May 2022 17:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348039AbiEKVMj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 May 2022 17:12:39 -0400
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [216.12.86.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276FE1F35F0
        for <linux-arch@vger.kernel.org>; Wed, 11 May 2022 14:12:35 -0700 (PDT)
Date:   Wed, 11 May 2022 17:12:32 -0400
From:   Rich Felker <dalias@libc.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christian Brauner <brauner@kernel.org>,
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
        GNU C Library <libc-alpha@sourceware.org>,
        musl@lists.openwall.com
Subject: Re: [musl] Re: [PATCH V9 13/24] LoongArch: Add system call support
Message-ID: <20220511211231.GG7074@brightrain.aerifal.cx>
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-14-chenhuacai@loongson.cn>
 <CAK8P3a0A9dW4mwJ6JHDiJxizL7vWfr4r4c5KhbjtAY0sWbZJVA@mail.gmail.com>
 <CAAhV-H4te_+AS69viO4eBz=abBUm5oQ6AfoY1Cb+nOCZyyeMdA@mail.gmail.com>
 <CAK8P3a0DqQcApv8aa2dgBS5At=tEkN7cnaskoUeXDi2-Bu9Rnw@mail.gmail.com>
 <20220507121104.7soocpgoqkvwv3gc@wittgenstein>
 <20220509100058.vmrgn5fkk3ayt63v@wittgenstein>
 <CAK8P3a0zmPbMNsS11aUGiAADyjOEueNUXQ8QZtVxr48M3pwAkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0zmPbMNsS11aUGiAADyjOEueNUXQ8QZtVxr48M3pwAkQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 11, 2022 at 09:11:56AM +0200, Arnd Bergmann wrote:
> On Mon, May 9, 2022 at 12:00 PM Christian Brauner <brauner@kernel.org> wrote:
> .....
> > I can try and move a poc for this up the todo list.
> >
> > Without an approach like this certain sandboxes will fallback to
> > ENOSYSing system calls they can't filter. This is a generic problem
> > though with clone3() being one promiment example.
> 
> Thank you for the detailed reply. It sounds to me like this will eventually have
> to get solved anyway, so we could move ahead without clone() on loongarch,
> and just not have support for Chrome until this is fully solved.
> 
> As both the glibc and musl ports are being proposed for inclusion right
> now, we should try to come to a decision so the libc ports can adjust if
> necessary. Adding both mailing lists to Cc here, the discussion is archived
> at [1].
> 
>          Arnd
> 
> [1] https://lore.kernel.org/linux-arch/20220509100058.vmrgn5fkk3ayt63v@wittgenstein/

Having read about the seccomp issue, I think it's a very strong
argument that __NR_clone should be kept permanently for all future
archs. Otherwise, at least AIUI, it's impossible to seccomp-sandbox
multithreaded programs (since you can't allow the creation of threads
without also allowing other unwanted use of clone3). It sounds like
there's some interest in extending seccomp to allow filtering of
argument blocks like clone3 uses, but some of what I read about was
checksum-based (thus a weak hardening measure at best, not a hard
privilege boundary) and even if something is eventually created that
works, it won't be available right away, and it won't be nearly as
easy to use as just allowing thread-creating clone syscalls on
existing archs.

Rich
