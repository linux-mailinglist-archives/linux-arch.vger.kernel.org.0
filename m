Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247C675D1FE
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jul 2023 20:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjGUSzB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 14:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjGUSzA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 14:55:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2393930EA;
        Fri, 21 Jul 2023 11:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ML1sh8TENxoaFJqhR/+bKvkhp/DWbd2eeba6Xp6ZoLU=; b=FtKuy4lx7z5YbW7WPpf1Cujgu5
        eGcSoztbPnzwRQqJI2ZmyNi2yud6JAxPyYuzl1m7Mn4kBqR3GTkl5toBXpD6K9X/Yi2R4QepAedTL
        /FXcJSJ0tlEJ4ozi68mxpsZgcSdT93pewQPc6C0wW6yUuZhpExe8eyMCxrbq5QcChZADmDtHtMRtT
        ZBvVsj56+s816Shypra2AZ+zYJUTed8vzB4sGjGQ08b13EDMDhaBIzobCegh9hsSFuCdR+9dUlUaC
        xRBGa46ZX4/9GW7YRaMQP8SYDBoneaNPYNVfYz8iQmok5rSK5JXOOHNkmtxDpwEalyOHHPNuQ1wud
        gFkY8Pew==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qMvH3-001NJY-Dt; Fri, 21 Jul 2023 18:54:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67CA03001E7;
        Fri, 21 Jul 2023 20:54:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4DCB030C3FB86; Fri, 21 Jul 2023 20:54:45 +0200 (CEST)
Date:   Fri, 21 Jul 2023 20:54:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        Linux-Arch <linux-arch@vger.kernel.org>, malteskarupke@web.de
Subject: Re: [PATCH v1 05/14] futex: Add sys_futex_wake()
Message-ID: <20230721185445.GS4253@hirez.programming.kicks-ass.net>
References: <20230721102237.268073801@infradead.org>
 <20230721105744.022509272@infradead.org>
 <2a1f8ae6-ed2b-4fe8-85af-df64e9c84794@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a1f8ae6-ed2b-4fe8-85af-df64e9c84794@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 21, 2023 at 05:41:20PM +0200, Arnd Bergmann wrote:
> On Fri, Jul 21, 2023, at 12:22, Peter Zijlstra wrote:
> > --- a/arch/arm/tools/syscall.tbl
> > +++ b/arch/arm/tools/syscall.tbl
> > @@ -465,3 +465,4 @@
> >  449	common	futex_waitv			sys_futex_waitv
> >  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
> >  451	common	cachestat			sys_cachestat
> > +452	common	futex_wake			sys_futex_wake
> 
> This clashes with __NR_fchmodat2 in linux-next, which also wants number 452.

Yeah, I fully expected some collisions :/ Unavoidable.

> > --- a/arch/arm64/include/asm/unistd32.h
> > +++ b/arch/arm64/include/asm/unistd32.h
> > @@ -909,6 +909,8 @@ __SYSCALL(__NR_futex_waitv, sys_futex_wa
> >  __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
> >  #define __NR_cachestat 451
> >  __SYSCALL(__NR_cachestat, sys_cachestat)
> > +#define __NR_futex_wake 452
> > +__SYSCALL(__NR_futex_wake, sys_futex_wake)
> > 
> >  /*
> >   * Please add new compat syscalls above this comment and update
> 
> Unfortunately, changing this file still requires updating __NR_compat_syscalls
> in arch/arm64/include/asm/unistd.h as well.

Bah I missed that. I'll go fix it up. Thanks!

> > --- a/kernel/sys_ni.c
> > +++ b/kernel/sys_ni.c
> > @@ -87,6 +87,7 @@ COND_SYSCALL_COMPAT(set_robust_list);
> >  COND_SYSCALL(get_robust_list);
> >  COND_SYSCALL_COMPAT(get_robust_list);
> >  COND_SYSCALL(futex_waitv);
> > +COND_SYSCALL(futex_wake);
> >  COND_SYSCALL(kexec_load);
> >  COND_SYSCALL_COMPAT(kexec_load);
> >  COND_SYSCALL(init_module);
> 
> This is fine for the moment, but I wonder if we should start making
> futex mandatory at some point. Right now, sparc32 with CONFIG_SMP
> cannot support futex because of the lack of atomics in early
> sparc processors, but sparc32 glibc actually requires futexes
> and consequently only works on uniprocessor machines, on sparc64
> compat mode, or on Leon3 with out of tree patches.

PARISC is another 'fun' case. 
