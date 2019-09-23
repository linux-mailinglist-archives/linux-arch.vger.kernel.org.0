Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7A48BBD3C
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2019 22:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388778AbfIWUnL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Sep 2019 16:43:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59856 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbfIWUnL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Sep 2019 16:43:11 -0400
Received: from pd9ef19d4.dip0.t-ipconnect.de ([217.239.25.212] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iCVAn-00066s-Nt; Mon, 23 Sep 2019 22:43:05 +0200
Date:   Mon, 23 Sep 2019 22:43:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC patch 02/15] x86/entry: Remove _TIF_NOHZ from
 _TIF_WORK_SYSCALL_ENTRY
In-Reply-To: <CALCETrWHkRiXx_r8x6k=ArxTZc5YS0DewMQDVHFrjVY3Xt+H7A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1909232242370.1934@nanos.tec.linutronix.de>
References: <20190919150314.054351477@linutronix.de> <20190919150808.617944343@linutronix.de> <CALCETrWHkRiXx_r8x6k=ArxTZc5YS0DewMQDVHFrjVY3Xt+H7A@mail.gmail.com>
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

On Fri, 20 Sep 2019, Andy Lutomirski wrote:

> On Thu, Sep 19, 2019 at 8:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Evaluating _TIF_NOHZ to decide whether to use the slow syscall entry path
> > is not only pointless, it's actually counterproductive:
> >
> >  1) Context tracking code is invoked unconditionally before that flag is
> >     evaluated.
> >
> >  2) If the flag is set the slow path is invoked for nothing due to #1
> 
> Can we also get rid of TIF_NOHZ on x86?

If we make the usage in context_tracking_cpu_set() conditional.

Thanks,

	tglx

