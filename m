Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8E97640F6
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2019 08:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfGJGM3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Jul 2019 02:12:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46788 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfGJGM3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jul 2019 02:12:29 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hl5q2-0004k5-M0; Wed, 10 Jul 2019 08:12:22 +0200
Date:   Wed, 10 Jul 2019 08:12:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     John Stultz <john.stultz@linaro.org>
cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
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
In-Reply-To: <CALAqxLXxE5B+vVLj7NcW8S05nhDQ+XSKVn=_MNDci667JDFEhA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907100811170.1758@nanos.tec.linutronix.de>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com> <20190621095252.32307-11-vincenzo.frascino@arm.com> <CALAqxLXxE5B+vVLj7NcW8S05nhDQ+XSKVn=_MNDci667JDFEhA@mail.gmail.com>
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

On Tue, 9 Jul 2019, John Stultz wrote:
> Though unfortunately, it seems the arm64 vdso code that just landed is
> breaking AOSP for me.
> 
> I see a lot of the following errors:
> 01-01 01:22:14.097   755   755 F libc    : Fatal signal 11 (SIGSEGV),
> code 1 (SEGV_MAPERR), fault addr 0x3cf2c96c in tid 755 (cameraserver),
> pid 755 (cameraserver)
> 01-01 01:22:14.112   759   759 F libc    : Fatal signal 11 (SIGSEGV),
> code 1 (SEGV_MAPERR), fault addr 0x3cf2c96c in tid 759
> (android.hardwar), pid 759 (android.hardwar)
> 01-01 01:22:14.120   756   756 F libc    : Fatal signal 11 (SIGSEGV),
> code 1 (SEGV_MAPERR), fault addr 0x3cf2c96c in tid 756 (drmserver),
> pid 756 (drmserver)
> 
> Which go away if I revert the vdso merge that went in via tip/timers.
> 
> I tried to bisect things down a bit, but as some later fixes are
> required (at one point, date was returning the start epoch and never
> increasing), this hasn't worked too well. But I'm guessing since I
> see: "CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will
> not be built", and the system is half working, I'm guessing this is an
> issue with just the 32bit code failing.  While I can try to sort out
> the proper CROSS_COMPILE_COMPAT in my build environment, I assume
> userland shouldn't be crashing if that value isn't set.

The obvious question is whether the VDSO is mapped to the 32bit process in
that case. It shouldn't...

Thanks,

	tglx
