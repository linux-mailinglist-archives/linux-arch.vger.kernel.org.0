Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA8D645D7C
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jun 2019 15:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfFNNHa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jun 2019 09:07:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37904 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfFNNHa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jun 2019 09:07:30 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hblvS-0004Pz-5b; Fri, 14 Jun 2019 15:07:26 +0200
Date:   Fri, 14 Jun 2019 15:07:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
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
        Huw Davies <huw@codeweavers.com>
Subject: Re: [PATCH v6 03/19] kernel: Unify update_vsyscall implementation
In-Reply-To: <9371eabc-ed74-3db8-794c-44c37ada2163@arm.com>
Message-ID: <alpine.DEB.2.21.1906141506500.1722@nanos.tec.linutronix.de>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com> <20190530141531.43462-4-vincenzo.frascino@arm.com> <alpine.DEB.2.21.1906141307430.1722@nanos.tec.linutronix.de> <a69e48a2-575d-255c-2653-d3e99b7ba760@arm.com> <alpine.DEB.2.21.1906141416100.1722@nanos.tec.linutronix.de>
 <9371eabc-ed74-3db8-794c-44c37ada2163@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 14 Jun 2019, Vincenzo Frascino wrote:
> On 6/14/19 1:19 PM, Thomas Gleixner wrote:
> > On Fri, 14 Jun 2019, Vincenzo Frascino wrote:
> >> On 6/14/19 12:10 PM, Thomas Gleixner wrote:
> >>> On Thu, 30 May 2019, Vincenzo Frascino wrote:
> >>>> +
> >>>> +	if (__arch_use_vsyscall(vdata)) {
> >>>> +		vdata[CS_HRES_COARSE].cycle_last	=
> >>>> +						tk->tkr_mono.cycle_last;
> >>>> +		vdata[CS_HRES_COARSE].mask		=
> >>>> +						tk->tkr_mono.mask;
> >>>> +		vdata[CS_HRES_COARSE].mult		=
> >>>> +						tk->tkr_mono.mult;
> >>>
> >>> These line breaks make it really hard to read. Can you fold in the patch
> >>> below please?
> >>>
> >>
> >> Thanks for this. I will do it in v7.
> > 
> > Talking about v7. I'd like to get this into 5.3. That means you'd have to
> > rebase it on
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git hyperv-next
> > 
> > to avoid the hyperv conflict. I'll sort this out with the hyperv folks how
> > I can get these bits as a base for a tip branch which holds all the vdso
> > pieces.
> >
> 
> Ok, I will rebase and test the patches against the hyperv-next branch. Could you
> please let me know when all the bits are sorted?

Don't worry. Just post it against that branch and I'll sort out the
logistics independently.

Thanks,

	tglx
