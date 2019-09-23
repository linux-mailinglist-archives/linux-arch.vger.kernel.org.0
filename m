Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48772BBD52
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2019 22:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389848AbfIWUuZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Sep 2019 16:50:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59889 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387437AbfIWUuZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Sep 2019 16:50:25 -0400
Received: from pd9ef19d4.dip0.t-ipconnect.de ([217.239.25.212] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iCVHo-0006Gs-RE; Mon, 23 Sep 2019 22:50:20 +0200
Date:   Mon, 23 Sep 2019 22:50:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, James Morse <james.morse@arm.com>
Subject: Re: [RFC patch 00/15] entry: Provide generic implementation for host
 and guest entry/exit work
In-Reply-To: <20190920151240.GB55224@lakrids.cambridge.arm.com>
Message-ID: <alpine.DEB.2.21.1909232244560.1934@nanos.tec.linutronix.de>
References: <20190919150314.054351477@linutronix.de> <20190920151240.GB55224@lakrids.cambridge.arm.com>
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

On Fri, 20 Sep 2019, Mark Rutland wrote:
> I've been working on converting the arm64 entry code to C for a while
> now [1], gradually upstreaming the bits I can.
> 
> James has picked up some of that [2] as a prerequisite for some RAS
> error handling, and I think building the arm64 bits atop of that would
> be preferable. IIUC that should get posted as a series come -rc1.
> 
> Since there's immense scope for subtle breakage, I'd prefer that we do
> the arm64-specific asm->C conversion before migrating arm64 to generic
> code. That way us arm64 folk can ensure the asm->C conversion retains
> the existing behaviour, and it'll be easier for everyone to compare the
> arm64 and generic C implementations.

Right. It still would be nice to have some feedback on the general
approach.

That sais I'm happy to let you screw your entry code up yourself :)

Thanks

	tglx
