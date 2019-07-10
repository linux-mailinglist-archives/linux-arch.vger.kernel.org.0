Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFC2643E3
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2019 10:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfGJI6d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Jul 2019 04:58:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47130 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfGJI6d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jul 2019 04:58:33 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hl8Ql-0006xp-9o; Wed, 10 Jul 2019 10:58:27 +0200
Date:   Wed, 10 Jul 2019 10:58:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Will Deacon <will@kernel.org>
cc:     John Stultz <john.stultz@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Huw Davies <huw@codeweavers.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Burton <paul.burton@mips.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Shijith Thotton <sthotton@marvell.com>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH v7 10/25] arm64: compat: Add vDSO
In-Reply-To: <20190710082750.mvm3e6myzpqsurga@willie-the-truck>
Message-ID: <alpine.DEB.2.21.1907101057190.1758@nanos.tec.linutronix.de>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com> <20190621095252.32307-11-vincenzo.frascino@arm.com> <CALAqxLXxE5B+vVLj7NcW8S05nhDQ+XSKVn=_MNDci667JDFEhA@mail.gmail.com> <20190710082750.mvm3e6myzpqsurga@willie-the-truck>
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

On Wed, 10 Jul 2019, Will Deacon wrote:
> On Tue, Jul 09, 2019 at 09:02:54PM -0700, John Stultz wrote:
> > I tried to bisect things down a bit, but as some later fixes are
> > required (at one point, date was returning the start epoch and never
> > increasing), this hasn't worked too well. But I'm guessing since I
> > see: "CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will
> > not be built", and the system is half working, I'm guessing this is an
> > issue with just the 32bit code failing.  While I can try to sort out
> > the proper CROSS_COMPILE_COMPAT in my build environment, I assume
> > userland shouldn't be crashing if that value isn't set.
> > 
> > Any chance this issue has already been raised?
> 
> First I've seen of it, although Vincenzo is likely to know better than me.
> In the meantime, please can you share your .config?

I think the key is: CROSS_COMPILE_COMPAT not defined or empty. And then run
32bit userspace.

Thanks,

	tglx
