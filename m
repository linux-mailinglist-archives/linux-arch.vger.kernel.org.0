Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B220B2497A1
	for <lists+linux-arch@lfdr.de>; Wed, 19 Aug 2020 09:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHSHoW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Aug 2020 03:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHSHoU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Aug 2020 03:44:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97393C061389;
        Wed, 19 Aug 2020 00:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J4VLIDE+jMck3vXa9rHkkbq93VX4dA7h042aAl3zgek=; b=GSbjxZPVDWY9S2GcrIk8B4gIZK
        j92/xIYVxtuoQcdVQihAza5CL3O+d/4dVnYCOtqcw95X6MI1MCZZSH6hwnnNv59Rv6M/0DxxfI85Z
        UetDLZWdWsUi0gxQgyvX8fGCj5GmxgkNMNSwgrePOzzo081IyNCOy8gMqm/f6tWnpCOgk7R6crldh
        OlQrG9icVQmb7q55F07IEfNtZO5gIevhdDF5gCkOdzt7019673F7x8Bn8IOD8fbZrRBUSRYhjoZpr
        mvZYw/yBuHHrZ3B/X+3SaSMawrw2fW9khhY7o7saT7DmXZNOoFnK3Bqb3KZy6UsHyVp/CwyDsiZsC
        KS6aDo8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8Il4-0004Sk-Ty; Wed, 19 Aug 2020 07:43:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 033743003E1;
        Wed, 19 Aug 2020 09:43:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D771C21A87267; Wed, 19 Aug 2020 09:43:40 +0200 (CEST)
Date:   Wed, 19 Aug 2020 09:43:40 +0200
From:   peterz@infradead.org
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
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
Message-ID: <20200819074340.GW2674@hirez.programming.kicks-ass.net>
References: <20200818173411.404104-1-christian.brauner@ubuntu.com>
 <20200818174447.GV17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818174447.GV17456@casper.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 18, 2020 at 06:44:47PM +0100, Matthew Wilcox wrote:
> On Tue, Aug 18, 2020 at 07:34:00PM +0200, Christian Brauner wrote:
> > The only remaining function callable outside of kernel/fork.c is
> > _do_fork(). It doesn't really follow the naming of kernel-internal
> > syscall helpers as Christoph righly pointed out. Switch all callers and
> > references to kernel_clone() and remove _do_fork() once and for all.
> 
> My only concern is around return type.  long, int, pid_t ... can we
> choose one and stick to it?  pid_t is probably the right return type
> within the kernel, despite the return type of clone3().  It'll save us
> some work if we ever go through the hassle of growing pid_t beyond 31-bit.

We have at least the futex ABI restricting PID space to 30 bits.
