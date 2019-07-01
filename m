Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6395C097
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jul 2019 17:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfGAPq1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Jul 2019 11:46:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46688 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfGAPq1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jul 2019 11:46:27 -0400
Received: by mail-qt1-f196.google.com with SMTP id h21so15098885qtn.13;
        Mon, 01 Jul 2019 08:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IE22YG1kj16IknP7QlS/hcyZEqytvttQhTXFYfXjkWQ=;
        b=JZv1F4YqJtPhAD7h1ykGuxlrCeOge9AiDu+iifDTSfkTBPL9kwDIlLEOaExrExZwrE
         JSJs7s8+5EgzIoiK7UyTazIW9rW6WTBdlDRZnm3PE1p9km7iuK73hiR15701RUATuIEB
         KLtiG7rtw/x5UzvWSDKdtIb0ewbmE9kLZnB5sECj6FK6WEwEvzChCIryBB4isI7npzOB
         Zs/wNt83u6acDh3kESPeEsrcTRpaopbJmYIL/9QI9HwzPfGjNXrFLgp4F3fwiuiwRwJr
         xqP+AcLYwRI+Gy7GYgUmqoBiiCtTmQQnBaTCoSATMY6XiXco0EzACgfIfgQb3aNIXOlE
         MtYQ==
X-Gm-Message-State: APjAAAXjPrtR7lylTVSlV0b2BJU3ezushxf5jFtDMigAO05eaWo9zkxp
        3jBo074Q6J/gkR+gyU7RM6+ZFBatK1hbvRSufY8=
X-Google-Smtp-Source: APXvYqzhz6wel8eAmEo0Rl5DHwP4U2CGItmP91pzq58M0NTwxUCzkZGOsPaq9nefB0EZ4xIpLiX+rlXeAW8kLRBehXg=
X-Received: by 2002:ac8:5311:: with SMTP id t17mr20545556qtn.304.1561995986128;
 Mon, 01 Jul 2019 08:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <1561786601-19512-1-git-send-email-guoren@kernel.org>
 <CAK8P3a0F5-wtJHbLvEwUXE8EnALMpQb5KeX4FK3S90Ce81oN-Q@mail.gmail.com> <CAJF2gTR7ooY=gxKW2zWK9MnuJ9YDm_1r6QTdJ=A=WqRDTuecRQ@mail.gmail.com>
In-Reply-To: <CAJF2gTR7ooY=gxKW2zWK9MnuJ9YDm_1r6QTdJ=A=WqRDTuecRQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 1 Jul 2019 17:46:09 +0200
Message-ID: <CAK8P3a1j+4u_xdP45rEX7H+m+ttd9AEjeL0ittRZjtKN5fApDw@mail.gmail.com>
Subject: Re: [PATCH] csky: Improve abiv1 mem ops performance with glibc codes
To:     Guo Ren <guoren@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 1, 2019 at 5:26 PM Guo Ren <guoren@kernel.org> wrote:
> On Mon, Jul 1, 2019 at 10:52 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Sat, Jun 29, 2019 at 7:36 AM <guoren@kernel.org> wrote:
> > >
> > > From: Guo Ren <ren_guo@c-sky.com>
> > >
> > > These codes are copied from glibc/string directory, they are the generic
> > > implementation for string operations. We may further optimize them with
> > > assembly code in the future.
> > >
> > > In fact these code isn't tested enough for kernel, but we've tested them
> > > on glibc and it seems good. We just trust them :)
> >
> > Are these files from the architecture independent portion of glibc or
> > are they csky specific? If they are architecture independent, we might
> > want to see if they make sense for other architectures as well, and
> > add them to lib/ rather than arch/csky/lib/
> They are just copied from glibc-2.28/string/*.c and they are generic.
> OK, I'll try to add them to lib/.

Ok. Note that lib/string.c contains very basic versions of these already,
so please see which of the functions you have actually make a
difference in practice over those (if you haven't done that already).

Otherwise you can probably follow the example of the libgcc functions
in lib/ashldi3.c etc: add a Kconfig symbol like CONFIG_GENERIC_LIB_ASHLDI3
for each function you had, put the glibc version into a new file, and allow
architectures to select them individually, which in turn should
replace the version from lib/string.c.

       Arnd
