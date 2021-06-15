Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A8A3A79ED
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 11:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhFOJSp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 05:18:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231174AbhFOJSp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Jun 2021 05:18:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E704761245;
        Tue, 15 Jun 2021 09:16:38 +0000 (UTC)
Date:   Tue, 15 Jun 2021 11:16:35 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] quota: finish disable quotactl_path syscall
Message-ID: <20210615091635.moujr4zgfy3gqc6j@wittgenstein>
References: <20210614153712.313707-1-marcin@juszkiewicz.com.pl>
 <20210614164454.GC29751@quack2.suse.cz>
 <20210615084728.GG29751@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210615084728.GG29751@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 15, 2021 at 10:47:28AM +0200, Jan Kara wrote:
> On Mon 14-06-21 18:44:54, Jan Kara wrote:
> > On Mon 14-06-21 17:37:12, Marcin Juszkiewicz wrote:
> > > In commit 5b9fedb31e47 ("quota: Disable quotactl_path syscall") Jan Kara
> > > disabled quotactl_path syscall on several architectures.
> > > 
> > > This commit disables it on all architectures using unified list of
> > > system calls:
> > > 
> > > - arm64
> > > - arc
> > > - csky
> > > - h8300
> > > - hexagon
> > > - nds32
> > > - nios2
> > > - openrisc
> > > - riscv (32/64)
> > > 
> > > CC: Jan Kara <jack@suse.cz>
> > > CC: Christian Brauner <christian.brauner@ubuntu.com>
> > > CC: Sascha Hauer <s.hauer@pengutronix.de>
> > > Link: https://lore.kernel.org/lkml/20210512153621.n5u43jsytbik4yze@wittgenstein
> > > 
> > > Signed-off-by: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
> > 
> > Aha, I've missed that one. Thanks for catching this. Arnd, will you take
> > this patch or should I take it through my tree?
> 
> OK, I want this to make it for rc7 so I've pulled this patch to my tree and
> will push it to Linus in a few days.

Looks good, thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

> 
> 								Honza
> 
> > > diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> > > index 6de5a7fc066b..d2a942086fcb 100644
> > > --- a/include/uapi/asm-generic/unistd.h
> > > +++ b/include/uapi/asm-generic/unistd.h
> > > @@ -863,8 +863,7 @@ __SYSCALL(__NR_process_madvise, sys_process_madvise)
> > >  __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
> > >  #define __NR_mount_setattr 442
> > >  __SYSCALL(__NR_mount_setattr, sys_mount_setattr)
> > > -#define __NR_quotactl_path 443
> > > -__SYSCALL(__NR_quotactl_path, sys_quotactl_path)
> > > +/* 443 is reserved for quotactl_path */
> > >  
> > >  #define __NR_landlock_create_ruleset 444
> > >  __SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
> > > -- 
> > > 2.31.1
> > > 
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
