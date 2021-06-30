Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD793B8291
	for <lists+linux-arch@lfdr.de>; Wed, 30 Jun 2021 14:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbhF3M6u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Jun 2021 08:58:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57004 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbhF3M6t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Jun 2021 08:58:49 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 274431FE79;
        Wed, 30 Jun 2021 12:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625057779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xdQwii54mAQjoPtlBzJZA6d/rnKA0OLflwRprIEP0MY=;
        b=GLULahH7VamboBss/Z2V3SMN2JRwOZ2rY2pDrAciiyGHEmc+ThftQraPIXuXgpPHGu7ubl
        hjWHvAhGeC5h/zvvdCfH/7jhvgqMSSzVSO1aoK7qtoYmWQy8AMYG4ENYWa0dbzG0er2EUH
        EcOdUboNbZ6IivkjAWM9O7yrisWIQ1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625057779;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xdQwii54mAQjoPtlBzJZA6d/rnKA0OLflwRprIEP0MY=;
        b=prVTd2KF0wkFSsuN3EFfXFBBttALuxdHLNTzxLOQENelHuRy+4eazXzbqinkjRc7sXCAFg
        T81d9SHcp5uEUCAA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 0F1B9118DD;
        Wed, 30 Jun 2021 12:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625057779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xdQwii54mAQjoPtlBzJZA6d/rnKA0OLflwRprIEP0MY=;
        b=GLULahH7VamboBss/Z2V3SMN2JRwOZ2rY2pDrAciiyGHEmc+ThftQraPIXuXgpPHGu7ubl
        hjWHvAhGeC5h/zvvdCfH/7jhvgqMSSzVSO1aoK7qtoYmWQy8AMYG4ENYWa0dbzG0er2EUH
        EcOdUboNbZ6IivkjAWM9O7yrisWIQ1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625057779;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xdQwii54mAQjoPtlBzJZA6d/rnKA0OLflwRprIEP0MY=;
        b=prVTd2KF0wkFSsuN3EFfXFBBttALuxdHLNTzxLOQENelHuRy+4eazXzbqinkjRc7sXCAFg
        T81d9SHcp5uEUCAA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id bdpOAvNp3GDUYAAALh3uQQ
        (envelope-from <chrubis@suse.cz>); Wed, 30 Jun 2021 12:56:19 +0000
Date:   Wed, 30 Jun 2021 14:30:45 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>, Tejun Heo <tj@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org
Subject: Re: [CFT][PATCH] exit/bdflush: Remove the deprecated bdflush system
 call
Message-ID: <YNxj9Ydotv39vwPW@yuki>
References: <YNULA+Ff+eB66bcP@zeniv-ca.linux.org.uk>
 <YNj4DItToR8FphxC@zeniv-ca.linux.org.uk>
 <6e283d24-7121-ae7c-d5ad-558f85858a09@gmail.com>
 <CAMuHMdXSU6_98NbC1UWTT_kmwxD=6Ha5LJxFAtbSuD=y78nASg@mail.gmail.com>
 <7ad6c3a9-b983-46a5-fc95-f961b636d3fe@gmail.com>
 <CAMuHMdUi5Ri=GmWzS8hb7dkfPyAE=HpQHg6OsKSLDse_364E=g@mail.gmail.com>
 <dbb4ca2d-a857-84f0-f167-5ad4e06aa52b@gmail.com>
 <CAMuHMdVKdZNBU-cTUY0zotA5DmtQ=dxH+iFY0_GX=4DzqpycZQ@mail.gmail.com>
 <36123b5d-daa0-6c2b-f2d4-a942f069fd54@gmail.com>
 <87sg10quue.fsf_-_@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sg10quue.fsf_-_@disp2133>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!
I've send a similar patch [1] a while ago when I removed bdflush tests from
LTP.

[1] https://lore.kernel.org/lkml/20190528101012.11402-1-chrubis@suse.cz/

Acked-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
