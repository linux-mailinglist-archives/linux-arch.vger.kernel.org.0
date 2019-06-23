Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D425500CC
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2019 06:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfFXEbn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jun 2019 00:31:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34713 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfFXEbn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2019 00:31:43 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfAj1-0007Ex-1q; Mon, 24 Jun 2019 00:12:40 +0200
Date:   Mon, 24 Jun 2019 00:12:37 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sasha Levin <sashal@kernel.org>
cc:     Michael Kelley <mikelley@microsoft.com>,
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
        Huw Davies <huw@codeweavers.com>, linux-hyperv@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v6 18/19] x86: Add support for generic vDSO
In-Reply-To: <20190623190929.GL2226@sasha-vm>
Message-ID: <alpine.DEB.2.21.1906240006090.32342@nanos.tec.linutronix.de>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com> <20190530141531.43462-19-vincenzo.frascino@arm.com> <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com> <alpine.DEB.2.21.1906141313150.1722@nanos.tec.linutronix.de>
 <20190614211710.GQ1513@sasha-vm> <alpine.DEB.2.21.1906221542270.5503@nanos.tec.linutronix.de> <20190623190929.GL2226@sasha-vm>
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

Sasha,

On Sun, 23 Jun 2019, Sasha Levin wrote:
> On Sat, Jun 22, 2019 at 04:46:28PM +0200, Thomas Gleixner wrote:
> > Folks, please stop chosing Cc lists as you like. We have well established
> > rules for that. And please stop queueing random unreviewed patches in
> > next. Next is not a playground for not ready and unreviewed stuff. No, the
> > hyper-v inbreed Reviewed-by is not sufficient for anything x86 and
> > clocksource related.
> 
> I'm sorry for this, you were supposed to be Cc'ed on these patches and I
> see that you were not.

All good. I've vented steam and am back to normal pressure :)

> > After chasing and looking at those patches, which have horrible subject
> > lines and changelogs btw, I was not able to judge quickly whether that
> > stuff is self contained or not. So no, I fixed up the fallout and rebased
> > Vincenzos VDSO stuff on mainline w/o those hyperv changes simply because if
> > they are not self contained they will break bisection badly.
> > 
> > I'm going to push out the VDSO series later today. That will nicely break

Not yet, but soon :)

> > in combination with the hyper-next branch. Stephen, please drop that and do
> > not try to handle the fallout. That stuff needs to go through the proper
> > channels or at least be acked/reviewed by the relevant maintainers. So the
> > hyper-v folks can rebase themself and post it proper.
> 
> Okay, thank you. We'll rebase and resend.

I have no objections if you collect hyper-v stuff, quite the contrary, but
changes which touch other subsystems need to be coordinated upfront. That's
all I'm asking for.

Btw, that clocksource stuff looks good code wise, just the change logs need
some care and after the VDSO stuff hits next we need to sort out the
logistics. I hope these changes are completely self contained. If not we'll
find a solution.

Thanks,

	tglx
