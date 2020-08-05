Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2908A23CEBF
	for <lists+linux-arch@lfdr.de>; Wed,  5 Aug 2020 21:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgHETDZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Aug 2020 15:03:25 -0400
Received: from gate.crashing.org ([63.228.1.57]:57203 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728019AbgHETB4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Aug 2020 15:01:56 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 075Ieuu6004765;
        Wed, 5 Aug 2020 13:40:56 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 075IesOr004764;
        Wed, 5 Aug 2020 13:40:54 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 5 Aug 2020 13:40:54 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com,
        anton@ozlabs.org, linux-arch@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        vincenzo.frascino@arm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v10 2/5] powerpc/vdso: Prepare for switching VDSO to generic C implementation.
Message-ID: <20200805184054.GQ6753@gate.crashing.org>
References: <cover.1596611196.git.christophe.leroy@csgroup.eu> <348528c33cd4007f3fee7fe643ef160843d09a6c.1596611196.git.christophe.leroy@csgroup.eu> <20200805140307.GO6753@gate.crashing.org> <3db2a590-b842-83db-ed2b-f3ee62595f18@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3db2a590-b842-83db-ed2b-f3ee62595f18@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

On Wed, Aug 05, 2020 at 04:40:16PM +0000, Christophe Leroy wrote:
> >It cannot optimise it because it does not know shift < 32.  The code
> >below is incorrect for shift equal to 32, fwiw.
> 
> Is there a way to tell it ?

Sure, for example the &31 should work (but it doesn't, with the GCC
version you used -- which version is that?)

> >What does the compiler do for just
> >
> >static __always_inline u64 vdso_shift_ns(u64 ns, unsigned long shift)
> >	return ns >> (shift & 31);
> >}
> >
> 
> Worse:

I cannot make heads or tails of all that branch spaghetti, sorry.

>  73c:	55 8c 06 fe 	clrlwi  r12,r12,27
>  740:	7f c8 f0 14 	addc    r30,r8,r30
>  744:	7c c6 4a 14 	add     r6,r6,r9
>  748:	7c c6 e1 14 	adde    r6,r6,r28
>  74c:	34 6c ff e0 	addic.  r3,r12,-32
>  750:	41 80 00 70 	blt     7c0 <__c_kernel_clock_gettime+0x114>

This branch is always true.  Hrm.


Segher
