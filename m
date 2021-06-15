Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A899D3A794F
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 10:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhFOIte (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 04:49:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41400 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhFOIte (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 04:49:34 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 236491FD55;
        Tue, 15 Jun 2021 08:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623746849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qsvBIKoBBDJEgHaKCzoXt6uHkCjR8pMwpup6Tl3TIWY=;
        b=WwJmRcCYbA8r2cbd0yxaLSp4lsozxpCGL6nszt9InMByAVOLQ/Z5d+2k2XuFYFh9HPjXJD
        ZodOGPzRpVMMb+SBx07LnMHJGoFS8aBCCnfqwQQHjppmJdh5iubbNnO5S+9AxJSi+GvAWD
        WFdnDJP4wNe97E9c7jicUkbKP4kyxSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623746849;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qsvBIKoBBDJEgHaKCzoXt6uHkCjR8pMwpup6Tl3TIWY=;
        b=PYlBYDzM/Z9Ap6CCtY2GQf8IZ/Q159Cmyb0cRvl9Ay1zffhPvWJ8EV5idnd2VUgJOBjczc
        i1zl/1p02vC2Q5DQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 12232A3BA5;
        Tue, 15 Jun 2021 08:47:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C9A6F1F2C88; Tue, 15 Jun 2021 10:47:28 +0200 (CEST)
Date:   Tue, 15 Jun 2021 10:47:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] quota: finish disable quotactl_path syscall
Message-ID: <20210615084728.GG29751@quack2.suse.cz>
References: <20210614153712.313707-1-marcin@juszkiewicz.com.pl>
 <20210614164454.GC29751@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614164454.GC29751@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon 14-06-21 18:44:54, Jan Kara wrote:
> On Mon 14-06-21 17:37:12, Marcin Juszkiewicz wrote:
> > In commit 5b9fedb31e47 ("quota: Disable quotactl_path syscall") Jan Kara
> > disabled quotactl_path syscall on several architectures.
> > 
> > This commit disables it on all architectures using unified list of
> > system calls:
> > 
> > - arm64
> > - arc
> > - csky
> > - h8300
> > - hexagon
> > - nds32
> > - nios2
> > - openrisc
> > - riscv (32/64)
> > 
> > CC: Jan Kara <jack@suse.cz>
> > CC: Christian Brauner <christian.brauner@ubuntu.com>
> > CC: Sascha Hauer <s.hauer@pengutronix.de>
> > Link: https://lore.kernel.org/lkml/20210512153621.n5u43jsytbik4yze@wittgenstein
> > 
> > Signed-off-by: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
> 
> Aha, I've missed that one. Thanks for catching this. Arnd, will you take
> this patch or should I take it through my tree?

OK, I want this to make it for rc7 so I've pulled this patch to my tree and
will push it to Linus in a few days.

								Honza

> > diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> > index 6de5a7fc066b..d2a942086fcb 100644
> > --- a/include/uapi/asm-generic/unistd.h
> > +++ b/include/uapi/asm-generic/unistd.h
> > @@ -863,8 +863,7 @@ __SYSCALL(__NR_process_madvise, sys_process_madvise)
> >  __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
> >  #define __NR_mount_setattr 442
> >  __SYSCALL(__NR_mount_setattr, sys_mount_setattr)
> > -#define __NR_quotactl_path 443
> > -__SYSCALL(__NR_quotactl_path, sys_quotactl_path)
> > +/* 443 is reserved for quotactl_path */
> >  
> >  #define __NR_landlock_create_ruleset 444
> >  __SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
> > -- 
> > 2.31.1
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
