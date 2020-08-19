Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7440A249B96
	for <lists+linux-arch@lfdr.de>; Wed, 19 Aug 2020 13:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgHSLTI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Aug 2020 07:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgHSLTB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Aug 2020 07:19:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13242C061757;
        Wed, 19 Aug 2020 04:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S3ViV7VOxKoiTfVgrvw4ZTEB3xmhm4rVfkGYugjh9Xc=; b=PqH95VsKVPNJwI5a/Er+qYg1YE
        2cP0Ceuh2EDSbznFUi6KCJU7M7Tnu1YxtinWU5IogRZ5X49Svh2ING9dG/X8+rguc0s8CNSZJSVjz
        sraZ7CGNbsDhWzRg8+UC6yH+tcPq9EXMZaDIgh2vnz9pMYTUAJGAn4dbA7FDtXtyG0dgROnOxjecF
        HOVDUZCBr76yq9h8gCFemMaMo2+mPHghmOxYz2YkVf+ANSqWMa0srF34jYala3pRYzPD19EoNJfdq
        Ood3xlpgoQ1+iBy6EacDpMR9Obz0ZXPuj8jDYzWyRwFWRGHSlTe43zBy51TCIlPCVr09ikGje2dIK
        +jtFq6ig==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8M7H-00015G-Od; Wed, 19 Aug 2020 11:18:51 +0000
Date:   Wed, 19 Aug 2020 12:18:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     peterz@infradead.org, Christoph Hewllig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stafford Horne <shorne@gmail.com>,
        Kars de Jong <jongk@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Greentime Hu <green.hu@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>, linux-doc@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/11] Introduce kernel_clone(), kill _do_fork()
Message-ID: <20200819111851.GY17456@casper.infradead.org>
References: <20200818173411.404104-1-christian.brauner@ubuntu.com>
 <20200818174447.GV17456@casper.infradead.org>
 <20200819074340.GW2674@hirez.programming.kicks-ass.net>
 <20200819084556.im5zfpm2iquzvzws@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819084556.im5zfpm2iquzvzws@wittgenstein>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 19, 2020 at 10:45:56AM +0200, Christian Brauner wrote:
> On Wed, Aug 19, 2020 at 09:43:40AM +0200, peterz@infradead.org wrote:
> > On Tue, Aug 18, 2020 at 06:44:47PM +0100, Matthew Wilcox wrote:
> > > On Tue, Aug 18, 2020 at 07:34:00PM +0200, Christian Brauner wrote:
> > > > The only remaining function callable outside of kernel/fork.c is
> > > > _do_fork(). It doesn't really follow the naming of kernel-internal
> > > > syscall helpers as Christoph righly pointed out. Switch all callers and
> > > > references to kernel_clone() and remove _do_fork() once and for all.
> > > 
> > > My only concern is around return type.  long, int, pid_t ... can we
> > > choose one and stick to it?  pid_t is probably the right return type
> > > within the kernel, despite the return type of clone3().  It'll save us
> > > some work if we ever go through the hassle of growing pid_t beyond 31-bit.
> > 
> > We have at least the futex ABI restricting PID space to 30 bits.
> 
> Ok, looking into kernel/futex.c I see 
> 
> pid_t pid = uval & FUTEX_TID_MASK;
> 
> which is probably what this referes to and /proc/sys/kernel/threads-max
> is restricted to FUTEX_TID_MASK.
> 
> Afaict, that doesn't block switching kernel_clone() to return pid_t. It
> can't create anything > FUTEX_TID_MASK anyway without yelling EAGAIN at
> userspace. But it means that _if_ we were to change the size of pid_t
> we'd likely need a new futex API. 

Yes, there would be a lot of work to do to increase the size of pid_t.
I'd just like to not do anything to make that harder _now_.  Stick to
using pid_t within the kernel.
