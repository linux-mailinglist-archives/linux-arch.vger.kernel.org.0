Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF291503D3
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2019 09:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfFXHm1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jun 2019 03:42:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35147 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfFXHm1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2019 03:42:27 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfJcL-0001F8-3S; Mon, 24 Jun 2019 09:42:21 +0200
Date:   Mon, 24 Jun 2019 09:42:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@openvz.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v7 00/25] Unify vDSOs across more architectures
In-Reply-To: <CALCETrV-suRS5=JqDjbouXciN_OPsguERjux7fQVFOKGmdrspA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1906240935430.32342@nanos.tec.linutronix.de>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com> <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de> <CALCETrV-suRS5=JqDjbouXciN_OPsguERjux7fQVFOKGmdrspA@mail.gmail.com>
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

On Sun, 23 Jun 2019, Andy Lutomirski wrote:

> On Sun, Jun 23, 2019 at 5:34 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > +GENERIC VDSO LIBRARY:
> > +M:     Andy Lutomirksy <luto@kernel.org>
> 
> Lutomirski, perhaps?

Ooops. Where did I copy that from?

> Although I do appreciate the opportunity to say "not me!" :)

You just gave me the perfect exit plan. I'll change my surname to Gleyxner
and head off to the goat farm :)

Thanks,

	tglx
