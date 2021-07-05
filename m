Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701363BBD21
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jul 2021 14:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhGEMzM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Jul 2021 08:55:12 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:29575 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhGEMzL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Jul 2021 08:55:11 -0400
Date:   Mon, 05 Jul 2021 12:52:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1625489553; bh=dq32cO+ZKMc2KufqrF4+FnLvbFSGJWzWZn6wbfbMESE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=NsJzHSo68u3RONXSa1dsHMZ0kieV61sNhU2UxI7md1kCzE+xhhP+TgNVVpxDRdRQb
         Sn3LLQT//Pmu3Ib0/flMZLDnR1bLKSB+7xpaeoo4JVSm14ld2ueHbTXw/Xt77Pel75
         8i/oU66Blr2WCYv2KvXa31TJpaWuOv7TIpwxjmZqASWU1VVdbLLzZAAXD3edz9Evi/
         j8DcH69GHS2ETAUUOXgVEEiT0ikHTY1FdFGNuOaEWHBrjsr3DT4ki70+lfwMuOiPt3
         DVKHAEGwM9c9yY7xz9u1iKDGIagPe2Kb/ly9UAoWpctS+tNYsNKPEl1pLRosWbX28a
         nKzSr5FL3ojLw==
To:     John Wood <john.wood@gmx.com>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>, Andi Kleen <ak@linux.intel.com>,
        valdis.kletnieks@vt.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH v8 3/8] security/brute: Detect a brute force attack
Message-ID: <20210705124446.45320-1-alobakin@pm.me>
In-Reply-To: <20210704140108.GA2742@ubuntu>
References: <20210701234807.50453-1-alobakin@pm.me> <20210702145954.GA4513@ubuntu> <20210702170101.16116-1-alobakin@pm.me> <20210703105928.GA2830@ubuntu> <20210704140108.GA2742@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: John Wood <john.wood@gmx.com>
Date: Sun, 4 Jul 2021 16:01:08 +0200

> On Sat, Jul 03, 2021 at 12:59:28PM +0200, John Wood wrote:
> > Hi,
> >
> > On Fri, Jul 02, 2021 at 05:08:09PM +0000, Alexander Lobakin wrote:
> > >
> > > On the other hand, it leaves a potentional window for attackers to
> > > perform brute force from xattr-incapable filesystems. So at the end
> > > of the day I think that the current implementation (a strong
> > > rejection of such filesystems) is way more secure than having
> > > a fallback I proposed.
> >
> > I've been thinking more about this: that the Brute LSM depends on xattr
> > support and I don't like this part. I want that brute force attacks can
> > be detected and mitigated on every system (with minimal dependencies).
> > So, now I am working in a solution without this drawback. I have some
> > ideas but I need to work on it.
>
> I have been coding and testing a bit my ideas but:
>
> Trying to track the applications faults info using kernel memory ends up
> in an easy to abuse system (denied of service due to large amount of memo=
r=3D
> y
> in use) :(
>
> So, I continue with the v8 idea: xattr to track application crashes info.
>
> > > I'm planning to make a patch which will eliminate such weird rootfs
> > > type selection and just always use more feature-rich tmpfs if it's
> > > compiled in. So, as an alternative, you could add it to your series
> > > as a preparatory change and just add a Kconfig dependency on
> > > CONFIG_TMPFS && CONFIG_TMPFS_XATTR to CONFIG_SECURITY_FORK_BRUTE
> > > without messing with any fallbacks at all.
> > > What do you think?
> >
> > Great. But I hope this patch will not be necessary for Brute LSM :)
>
> My words are no longer valid ;)

Ok, so here's the patch that prefers tmpfs for rootfs over ramfs
if it's built-in (which is true for 99% of systems): [0]

For now it hasn't been reviewed by anyone yet, will see. I'm running
my system with this patch for several days already and there were no
issues with rootfs or Brute so far.

[0] https://lore.kernel.org/lkml/20210702233727.21301-1-alobakin@pm.me/

> Thanks,
> John Wood

Thanks,
Al

