Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 556AD713BC
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2019 10:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbfGWIRh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Jul 2019 04:17:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39643 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbfGWIRh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jul 2019 04:17:37 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hppzH-0007kO-06; Tue, 23 Jul 2019 10:17:31 +0200
Date:   Tue, 23 Jul 2019 10:17:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
cc:     Mike Lothian <mike@fireburn.co.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, "H.J. Lu" <hjl.tools@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2] kbuild: Fail if gold linker is detected
In-Reply-To: <alpine.DEB.2.21.1907230837400.1659@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1907231013340.1659@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907161434260.1767@nanos.tec.linutronix.de> <20190716170606.GA38406@archlinux-threadripper> <alpine.DEB.2.21.1907162059200.1767@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907162135590.1767@nanos.tec.linutronix.de>
 <CAK7LNASBiaMX8ihnmhLGmYfHX=ZHZmVN91nxmFZe-OCaw6Px2w@mail.gmail.com> <alpine.DEB.2.21.1907170955250.1767@nanos.tec.linutronix.de> <CAHbf0-GyQzWcRg_BP2B5pVzEJoxSE_hX5xFypS--7Q5LSHxzWw@mail.gmail.com> <CAK7LNATJGbSYyuxV7npC_bQiXQShb=7J7dcQcOaupnL5-GhADg@mail.gmail.com>
 <alpine.DEB.2.21.1907230837400.1659@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 23 Jul 2019, Thomas Gleixner wrote:
> On Tue, 23 Jul 2019, Masahiro Yamada wrote:
> > Right.
> > I was able to build with ld.gold
> > 
> > So, we can use gold, depending on the kernel configuration.
> 
> That's exactly the problem. It breaks with random kernel configurations
> which is not acceptable except for people who know what they are doing.
> 
> I'm tired of dealing with half baken fixes and 'regression' reports. Either
> there is an effort to fix the issues with gold like the clang people fix
> their issues or it needs to be disabled. We have a clear statement that
> gold developers have other priorities.

That said, I'm perfectly happy to move this to x86 and leave it alone for
other architectures, but it does not make sense to me.

If the gold fans care enough, then we can add something like
CONFIG_I_WANT_TO_USE_GOLD_AND_DEAL_WITH_THE_FALLOUT_MYSELF.

Thanks,

	tglx
