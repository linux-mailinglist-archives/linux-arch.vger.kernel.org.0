Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57F6845B42
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jun 2019 13:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfFNLPa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jun 2019 07:15:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37537 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfFNLP3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jun 2019 07:15:29 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hbkB2-0000Rx-2w; Fri, 14 Jun 2019 13:15:24 +0200
Date:   Fri, 14 Jun 2019 13:15:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Michael Kelley <mikelley@microsoft.com>
cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
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
        Sasha Levin <sashal@kernel.org>
Subject: RE: [PATCH v6 18/19] x86: Add support for generic vDSO
In-Reply-To: <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1906141313150.1722@nanos.tec.linutronix.de>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com> <20190530141531.43462-19-vincenzo.frascino@arm.com> <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 30 May 2019, Michael Kelley wrote:
> Vincenzo -- these changes for Hyper-V are a subset of a larger patch set
> I have that moves all of the Hyper-V clock/timer code into a separate
> clocksource driver in drivers/clocksource, with an include file in
> includes/clocksource.  That new include file should be able to work
> instead of your new mshyperv-tsc.h.  It also has the benefit of being
> ISA neutral, so it will work with my in-progress patch set to support
> Linux on Hyper-V on ARM64.  See https://lkml.org/lkml/2019/5/27/231
> for the new clocksource driver patch set.

Grrr. That's queued in hyperv-next for whatever reasons.

Sasha, can you please provide me the branch to pull from so I can have a
common base for all the various changes floating around?

Thanks,

	tglx
