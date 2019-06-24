Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D32B8500C5
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2019 06:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfFXEbg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jun 2019 00:31:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34711 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfFXEbg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2019 00:31:36 -0400
X-Greylist: delayed 5399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Jun 2019 00:31:34 EDT
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfCnK-0000Kk-5Z; Mon, 24 Jun 2019 02:25:14 +0200
Date:   Mon, 24 Jun 2019 02:25:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Michael Kelley <mikelley@microsoft.com>
cc:     Sasha Levin <sashal@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
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
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: RE: [PATCH v6 18/19] x86: Add support for generic vDSO
In-Reply-To: <BYAPR21MB135202F46C4B023B51EBBFD0D7E00@BYAPR21MB1352.namprd21.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1906240221550.32342@nanos.tec.linutronix.de>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com> <20190530141531.43462-19-vincenzo.frascino@arm.com> <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com> <alpine.DEB.2.21.1906141313150.1722@nanos.tec.linutronix.de>
 <20190614211710.GQ1513@sasha-vm> <alpine.DEB.2.21.1906221542270.5503@nanos.tec.linutronix.de> <20190623190929.GL2226@sasha-vm> <alpine.DEB.2.21.1906240006090.32342@nanos.tec.linutronix.de>
 <BYAPR21MB135202F46C4B023B51EBBFD0D7E00@BYAPR21MB1352.namprd21.prod.outlook.com>
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

On Mon, 24 Jun 2019, Michael Kelley wrote:
> From: Thomas Gleixner <tglx@linutronix.de> Sent: Sunday, June 23, 2019 3:13 PM
> > 
> > I have no objections if you collect hyper-v stuff, quite the contrary, but
> > changes which touch other subsystems need to be coordinated upfront. That's
> > all I'm asking for.
> > 
> > Btw, that clocksource stuff looks good code wise, just the change logs need
> > some care and after the VDSO stuff hits next we need to sort out the
> > logistics. I hope these changes are completely self contained. If not we'll
> > find a solution.
> >
> 
> In my view, the only thing that potentially needs a solution is where the
> Hyper-V clock code used by VDSO ends up in the code tree.  I think the
> right long term place is include/clocksource/hyperv_timer.h.   That location
> is architecture neutral, and the same Hyper-V clock code will be shared by
> the Hyper-V on ARM64 support that's in process.
> 
> Vincenzo's patch set creates a new file arch/x86/include/asm/mshyperv-tsc.h,
> which I will want to move when creating the separate Hyper-V clocksource
> driver.   If you're OK with that file existing for a release and then going away,
> that's fine.  Alternatively, put the code in include/clocksource/hyperv_timer.h
> now as part of the VDSO patch set so it's in the right place from the start.  My
> subsequent patch set will add a few additional tweaks to remove x86-isms
> and fully integrate with the separate Hyper-V clocksource driver.

I don't care whether this goes into 5.3 or later. If you can provide me
rebased self contained patches on top of

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso

I'm happy to pull them in on top.

Thanks,

	tglx
