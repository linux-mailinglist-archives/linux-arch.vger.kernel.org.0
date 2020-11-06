Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03562A9904
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 17:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgKFQDx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 11:03:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbgKFQDx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Nov 2020 11:03:53 -0500
Received: from linux-8ccs.fritz.box (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B04C2208C7;
        Fri,  6 Nov 2020 16:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604678632;
        bh=EYK+J+nFdAu5CEbJrfqWZq4PGL/t0JmQeodkAruc60E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UHM7wJvE07Wa3hVRkhdkb/75xQO+HuXaQzce6E9FNDwyZx8Ir43LvS03WIcGblB9g
         d3AIuBzRmSgG0IzSUhJ6wzw1/3RUJqRw7XbEIr42GbzU0BdgAZlH/J+UP3/sqC5wtf
         dZeLHsfiaIqhYWLbBMKlhFwnF+4FqwH7VDiXUOso=
Date:   Fri, 6 Nov 2020 17:03:45 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 0/8] linker-section array fix and clean ups
Message-ID: <20201106160344.GA12184@linux-8ccs.fritz.box>
References: <20201103175711.10731-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201103175711.10731-1-johan@kernel.org>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+++ Johan Hovold [03/11/20 18:57 +0100]:
>We rely on the linker to create arrays for a number of things including
>kernel parameters and device-tree-match entries.
>
>The stride of these linker-section arrays obviously needs to match the
>expectations of the code accessing them or bad things will happen.
>
>One thing to watch out for is that gcc is known to increase the
>alignment of larger objects with static extent as an optimisation (on
>x86), but this can be suppressed by using the aligned attribute when
>declaring entries.
>
>We've been relying on this behaviour for 16 years for kernel parameters
>(and other structures) and it indeed hasn't changed since the
>introduction of the aligned attribute in gcc 3.1 (see align_variable()
>in [1]).
>
>Occasionally this gcc optimisation do cause problems which have instead
>been worked around in various creative ways including using indirection
>through an array of pointers. This was originally done for tracepoints
>[2] after a number of failed attempts to create properly aligned arrays,
>and the approach was later reused for module-version attributes [3] and
>earlycon entries.

>[2] https://lore.kernel.org/lkml/20110126222622.GA10794@Krystal/

Hi Johan,

So unfortunately, I am not familiar enough with the semantics of gcc's
aligned attribute. AFAICT from the patch you linked in [2], the
original purpose of the pointer indirection workaround was to avoid
relying on (potentially inconsistent) compiler-specific behavior with
respect to the aligned attribute. The main concern was potential
up-alignment being done by gcc (or the linker) despite the desired
alignment being specified. Indeed, the gcc documentation also states
that the aligned attribute only specifies the *minimum* alignment,
although there's no guarantee that up-alignment wouldn't occur.

So I guess my question is, is there some implicit guarantee that
specifying alignment by type via __alignof__ that's supposed to
prevent gcc from up-aligning? Or are we just assuming that gcc won't
increase the alignment? The gcc docs don't seem to clarify this
unfortunately.

Thanks,

Jessica




