Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 863FBB8F39
	for <lists+linux-arch@lfdr.de>; Fri, 20 Sep 2019 13:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438266AbfITLsT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Sep 2019 07:48:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52081 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438265AbfITLsT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Sep 2019 07:48:19 -0400
Received: from [5.158.153.55] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iBHOX-0007Zj-Cs; Fri, 20 Sep 2019 13:48:13 +0200
Date:   Fri, 20 Sep 2019 13:48:05 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC patch 14/15] workpending: Provide infrastructure for work
 before entering a guest
In-Reply-To: <0cc964dc-4d00-05ec-1ed1-f6cee7370d7b@redhat.com>
Message-ID: <alpine.DEB.2.21.1909201345380.1858@nanos.tec.linutronix.de>
References: <20190919150314.054351477@linutronix.de> <20190919150809.860645841@linutronix.de> <0cc964dc-4d00-05ec-1ed1-f6cee7370d7b@redhat.com>
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

On Thu, 19 Sep 2019, Paolo Bonzini wrote:
> > +	/* Any extra architecture specific work */
> > +	return arch_exit_to_guestmode_work(kvm, vcpu, ti_work);
> > +}
> 
> Perhaps, in virt/kvm/kvm_main.c:
> 
> int kvm_exit_to_guestmode_work(struct kvm *kvm, struct kvm_vcpu *vcpu,
> 				unsigned long ti_work)
> {
...
> }
> 
> and in kernel/entry/common.c:
> 
> int core_exit_to_guestmode_work(unsigned long ti_work)
> {
...
> }

Makes sense.
 
> so that kernel/entry/ is not polluted with KVM structs and APIs.
> 
> Perhaps even extract the body of core_exit_to_usermode_work's while loop
> to a separate function, and call it as
> 
> 	core_exit_to_usermode_work_once(NULL,
> 				ti_work & EXIT_TO_GUESTMODE_WORK);

Doh, its too obvious now that you mention it :)

> from core_exit_to_guestmode_work.
> 
> In general I don't mind having these exit_to_guestmode functions in
> kvm_host.h, and only having entry-common.h export EXIT_TO_GUESTMODE_WORK
> and ARCH_EXIT_TO_GUESTMODE_WORK.  Unless you had good reasons to do the
> opposite...

That was an arbitrary choice and it does not matter much where it lives.

Thanks,

	tglx
