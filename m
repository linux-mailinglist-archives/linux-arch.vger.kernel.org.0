Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 982EC9D913
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2019 00:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbfHZW0O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Aug 2019 18:26:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41378 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfHZW0O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Aug 2019 18:26:14 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i2NR8-0006Vh-6T; Tue, 27 Aug 2019 00:26:07 +0200
Date:   Tue, 27 Aug 2019 00:26:05 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Cristian Marussi <cristian.marussi@arm.com>
cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mark.rutland@arm.com, peterz@infradead.org,
        catalin.marinas@arm.com, takahiro.akashi@linaro.org,
        james.morse@arm.com, hidehiro.kawai.ez@hitachi.com,
        will@kernel.org, dave.martin@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 5/7] arm64: smp: use generic SMP stop common code
In-Reply-To: <c6a86709-6faf-bf84-08aa-c41dab61c58f@arm.com>
Message-ID: <alpine.DEB.2.21.1908270025340.1939@nanos.tec.linutronix.de>
References: <20190823115720.605-1-cristian.marussi@arm.com> <20190823115720.605-6-cristian.marussi@arm.com> <20190826153236.GA9591@infradead.org> <c6a86709-6faf-bf84-08aa-c41dab61c58f@arm.com>
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

On Mon, 26 Aug 2019, Cristian Marussi wrote:
> On 8/26/19 4:32 PM, Christoph Hellwig wrote:
> > > +config ARCH_USE_COMMON_SMP_STOP
> > > +	def_bool y if SMP
> > 
> > The option belongs into common code and the arch code shoud only
> > select it.
> > 
> 
> In fact that was my first approach, but then I noticed that in kernel/ topdir
> there was no generic Kconfig but only subsystem specific ones:
> 
> Kconfig.freezer  Kconfig.hz       Kconfig.locks    Kconfig.preempt

arch/Kconfig

Thanks,

	tglx
