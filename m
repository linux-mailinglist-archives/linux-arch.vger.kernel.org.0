Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABD8249878
	for <lists+linux-arch@lfdr.de>; Wed, 19 Aug 2020 10:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHSIqG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Aug 2020 04:46:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49453 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgHSIqF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Aug 2020 04:46:05 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k8JjK-00021u-5E; Wed, 19 Aug 2020 08:45:58 +0000
Date:   Wed, 19 Aug 2020 10:45:56 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     peterz@infradead.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hewllig <hch@infradead.org>,
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
Message-ID: <20200819084556.im5zfpm2iquzvzws@wittgenstein>
References: <20200818173411.404104-1-christian.brauner@ubuntu.com>
 <20200818174447.GV17456@casper.infradead.org>
 <20200819074340.GW2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200819074340.GW2674@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 19, 2020 at 09:43:40AM +0200, peterz@infradead.org wrote:
> On Tue, Aug 18, 2020 at 06:44:47PM +0100, Matthew Wilcox wrote:
> > On Tue, Aug 18, 2020 at 07:34:00PM +0200, Christian Brauner wrote:
> > > The only remaining function callable outside of kernel/fork.c is
> > > _do_fork(). It doesn't really follow the naming of kernel-internal
> > > syscall helpers as Christoph righly pointed out. Switch all callers and
> > > references to kernel_clone() and remove _do_fork() once and for all.
> > 
> > My only concern is around return type.  long, int, pid_t ... can we
> > choose one and stick to it?  pid_t is probably the right return type
> > within the kernel, despite the return type of clone3().  It'll save us
> > some work if we ever go through the hassle of growing pid_t beyond 31-bit.
> 
> We have at least the futex ABI restricting PID space to 30 bits.

Ok, looking into kernel/futex.c I see 

pid_t pid = uval & FUTEX_TID_MASK;

which is probably what this referes to and /proc/sys/kernel/threads-max
is restricted to FUTEX_TID_MASK.

Afaict, that doesn't block switching kernel_clone() to return pid_t. It
can't create anything > FUTEX_TID_MASK anyway without yelling EAGAIN at
userspace. But it means that _if_ we were to change the size of pid_t
we'd likely need a new futex API. 

Christian
