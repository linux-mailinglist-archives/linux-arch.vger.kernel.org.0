Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8011BEACA
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2019 04:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbfIZC7o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Sep 2019 22:59:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728722AbfIZC7o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 25 Sep 2019 22:59:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8182D307D985;
        Thu, 26 Sep 2019 02:59:44 +0000 (UTC)
Received: from treble (ovpn-120-76.rdu2.redhat.com [10.10.120.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E920B600C8;
        Thu, 26 Sep 2019 02:59:42 +0000 (UTC)
Date:   Wed, 25 Sep 2019 21:59:40 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC patch 10/15] x86/entry: Move irq tracing to C code
Message-ID: <20190926025940.hima423t2yfhh6h4@treble>
References: <20190919150314.054351477@linutronix.de>
 <20190919150809.446771597@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190919150809.446771597@linutronix.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 26 Sep 2019 02:59:44 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 19, 2019 at 05:03:24PM +0200, Thomas Gleixner wrote:
>  ENTRY(error_exit)
> -	UNWIND_HINT_REGS
>  	DISABLE_INTERRUPTS(CLBR_ANY)
>  	TRACE_IRQS_OFF
> +	UNWIND_HINT_REGS
>  	testb	$3, CS(%rsp)
>  	jz	retint_kernel
>  	jmp	retint_user

I don't think this UNWIND_HINT_REGS needs to be moved?

-- 
Josh
