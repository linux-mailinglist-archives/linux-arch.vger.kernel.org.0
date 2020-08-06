Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BA023E0CC
	for <lists+linux-arch@lfdr.de>; Thu,  6 Aug 2020 20:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgHFSic (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Aug 2020 14:38:32 -0400
Received: from gate.crashing.org ([63.228.1.57]:59882 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbgHFSeW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Aug 2020 14:34:22 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 076IXI7v018034;
        Thu, 6 Aug 2020 13:33:18 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 076IXGtc018033;
        Thu, 6 Aug 2020 13:33:16 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 6 Aug 2020 13:33:16 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, nathanl@linux.ibm.com,
        linux-arch@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org,
        Tulio Magno Quites Machado Filho <tuliom@linux.ibm.com>,
        luto@kernel.org, tglx@linutronix.de, vincenzo.frascino@arm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 5/8] powerpc/vdso: Prepare for switching VDSO to generic C implementation.
Message-ID: <20200806183316.GV6753@gate.crashing.org>
References: <cover.1588079622.git.christophe.leroy@c-s.fr> <2a67c333893454868bbfda773ba4b01c20272a5d.1588079622.git.christophe.leroy@c-s.fr> <878sflvbad.fsf@mpe.ellerman.id.au> <65fd7823-cc9d-c05a-0816-c34882b5d55a@csgroup.eu> <87wo2dy5in.fsf@mpe.ellerman.id.au> <20200805133505.GN6753@gate.crashing.org> <87r1sky1hm.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1sky1hm.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

On Thu, Aug 06, 2020 at 12:03:33PM +1000, Michael Ellerman wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> > On Wed, Aug 05, 2020 at 04:24:16PM +1000, Michael Ellerman wrote:
> >> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> >> > Indeed, 32-bit doesn't have a redzone, so I believe it needs a stack 
> >> > frame whenever it has anything to same.

^^^

> >> >     fbb60:	94 21 ff e0 	stwu    r1,-32(r1)
> >
> > This is the *only* place where you can use a negative offset from r1:
> > in the stwu to extend the stack (set up a new stack frame, or make the
> > current one bigger).
> 
> (You're talking about 32-bit code here right?)

The "SYSV" ELF binding, yeah, which is used for 32-bit on Linux (give or
take, ho hum).

The ABIs that have a red zone are much nicer here (but less simple) :-)

> >> At the same time it's much safer for us to just save/restore r2, and
> >> probably in the noise performance wise.
> >
> > If you want a function to be able to work with ABI-compliant code safely
> > (in all cases), you'll have to make it itself ABI-compliant as well,
> > yes :-)
> 
> True. Except this is the VDSO which has previously been a bit wild west
> as far as ABI goes :)

It could get away with many things because it was guaranteed to be a
leaf function.  Some of those things even violate the ABIs, but you can
get away with it easily, much reduced scope.  Now if this is generated
code, violating the rules will catch up with you sooner rather than
later ;-)


Segher
