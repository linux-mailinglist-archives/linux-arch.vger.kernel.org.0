Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D93C3A79CB
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 11:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhFOJHN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 05:07:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44896 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhFOJHN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 05:07:13 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 535311FD58;
        Tue, 15 Jun 2021 09:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623747908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BoLaFr9L6D8rCqvKm61qwafxG4D1Hm1B5OnYqiOpR0M=;
        b=jNaJPNL5OSfxR50ZoFgrnTyMSztqz79CTK8I12ZgNma3Gx83X3flMLW7JdNWZvNa1rrsP2
        tfFLFs7ipiOapFTZkCzcHxvweg5AjxtCMJDUiLjYXCeh9Y35dP5pxQ8p98iw0qKhJ1u4+X
        9k5VQpwLs+9l0Ob9PCdf+ANkg8kfp+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623747908;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BoLaFr9L6D8rCqvKm61qwafxG4D1Hm1B5OnYqiOpR0M=;
        b=fqAeHTy09GWGVexdXIY6yMqCOE0GrI/RWvSrnh4psCdDx1UtvZRxfS3Ww3JX/GhAvGJdpZ
        x1lmf5SW4RZmDUBA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 475AEA3B87;
        Tue, 15 Jun 2021 09:05:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2F5D71F2C88; Tue, 15 Jun 2021 11:05:08 +0200 (CEST)
Date:   Tue, 15 Jun 2021 11:05:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jan Kara <jack@suse.cz>,
        Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] quota: finish disable quotactl_path syscall
Message-ID: <20210615090508.GI29751@quack2.suse.cz>
References: <20210614153712.313707-1-marcin@juszkiewicz.com.pl>
 <20210614164454.GC29751@quack2.suse.cz>
 <CAK8P3a3XbbJ8WnzdsE5f4Uk-O5Z_mBsjc21E6AKuVavvF-_3Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3XbbJ8WnzdsE5f4Uk-O5Z_mBsjc21E6AKuVavvF-_3Cw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue 15-06-21 10:45:38, Arnd Bergmann wrote:
> On Mon, Jun 14, 2021 at 6:45 PM Jan Kara <jack@suse.cz> wrote:
> >
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
> I don't have any other fixes for 5.13 at the moment, so I would prefer it if
> you could pick it up.

OK, thanks for letting me know. I've picked it up.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
