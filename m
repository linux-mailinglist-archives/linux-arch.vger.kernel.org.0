Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48587553B7
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2019 17:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732476AbfFYPs1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jun 2019 11:48:27 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44752 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfFYPs1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jun 2019 11:48:27 -0400
Received: by mail-qt1-f194.google.com with SMTP id x47so18886795qtk.11;
        Tue, 25 Jun 2019 08:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UM0dIusS/gwdu4c8O9SbMLiBQ6AfaMuOD/f2wf1DSM0=;
        b=RfVP/YSHIeq6OEIFwBiAi3EiWtLzh9Q9AUz7CnT13RbOYKxIDrn5+A5hsG0/3bx2Z+
         u5lw0fc7jf4GnUGz5vRuuyiT4iqcKkc8MJMyZuzFLPEF5bTgEfYkmvpbibXMYYB/Ut5D
         2qfEHOAeH+kyx03C+vOwBM2J83NxNL2P1uRV/WtEtF5ILcEPYNTUxPGe5H/oubIaHA+G
         q2LSJEdxsd5XAdc1npGXjboFoVmsb+7nup3Gk9CTKWL0KBOR2dMVgUtj5PHdwp8QHfwM
         eSTvVz4xttnNx/d3Dasj7rP7vLgQ0ZtY1usPCd+k0xTJ6prXHYBZOQW0eDxFVKjcXXYq
         WkfA==
X-Gm-Message-State: APjAAAXnowdIA7qKtMgsJbv7q+AoVFoKX2PdZE9sd5OrOamRHYtndDT/
        qYm+DcnBYGOO9NxjsGuI0ny5hziib4v6Fuh+15A5p+Rs
X-Google-Smtp-Source: APXvYqyVchxTXULX5RiBGFf7pkDLgru/QLMdrSx0lNX8fcNNL8F7yHW1If4rQ0zSKCfUNzX8+NHSiNHEywkw8pWsVxw=
X-Received: by 2002:a0c:9595:: with SMTP id s21mr32470026qvs.63.1561477705897;
 Tue, 25 Jun 2019 08:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190625085616.GA32399@lst.de> <ccfa78f3-35c2-1d26-98b5-b21a76b90e1e@physik.fu-berlin.de>
 <20190625112146.GA9580@angband.pl> <401b12c0-d175-2720-d26c-b96ce3b28c71@physik.fu-berlin.de>
 <CAK8P3a3irwwwCQ_kPh5BTg-jGGbJOj=3fhVrTDBUZgH1V7bpFQ@mail.gmail.com> <20190625142832.GD1506@brightrain.aerifal.cx>
In-Reply-To: <20190625142832.GD1506@brightrain.aerifal.cx>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 25 Jun 2019 17:48:09 +0200
Message-ID: <CAK8P3a0j_9fzZxhxqCMHfoJ5DdZpHFvANEPqs1pbP23TCei6ng@mail.gmail.com>
Subject: Re: [RFC] remove arch/sh?
To:     Rich Felker <dalias@libc.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Adam Borowski <kilobyte@angband.pl>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 25, 2019 at 4:28 PM Rich Felker <dalias@libc.org> wrote:
> On Tue, Jun 25, 2019 at 02:50:01PM +0200, Arnd Bergmann wrote:
> > don't build, or are incomplete and not worked on for a long
> > time, compared to the bits that are known to work and that someone
> > is still using or at least playing with.
> > I guess a lot of the SoCs that have no board support other than
> > the Hitachi/Renesas reference platform can go away too, as any products
> > based on those boards have long stopped updating their kernels.
>
> My intent here was always, after getting device tree theoretically
> working for some reasonable subset of socs/boards, drop the rest and
> add them back as dts files (possibly plus some small drivers) only if
> there's demand/complaint about regression.

Do you still think that this is a likely scenario for the future though?

If nobody's actively working on the DT support for the old chips and
this is unlikely to change soon, removing the known-broken bits earlier
should at least make it easier to keep maintaining the working bits
afterwards.

FWIW, I went through the SH2, SH2A and SH3 based boards that
are supported in the kernel and found almost all of them to
be just reference platforms, with no actual product ever merged.
IIRC the idea back then was that users would supply their
own board files as an add-on patch, but I would consider all the
ones that did to be obsolete now.

HP Jornada 6xx is the main machine that was once supported, but
given that according to the defconfig file it only comes with 4MB
of RAM, it is unlikely to still boot any 5.x kernel, let alone user
space (wikipedia claims there were models with 16MB of RAM,
but that is still not a lot these days).

"Magicpanel" was another product that is supported in theory, but
the google search showed the 2007 patch for the required
flash storage driver that was never merged.

Maybe everything but J2 and SH4(a) can just get retired?

     Arnd
