Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705E523E5FC
	for <lists+linux-arch@lfdr.de>; Fri,  7 Aug 2020 04:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgHGCoq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Aug 2020 22:44:46 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42129 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgHGCop (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Aug 2020 22:44:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BN8pM1JlRz9sSG;
        Fri,  7 Aug 2020 12:44:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1596768284;
        bh=FZuIxnPjJkYxCWMXw2mxcRhOKtZPN4eNLc1MN/Gupm4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MPMsNyeTn9a8d9v3fgyBEE07kO0XqO2/i5FfHbv9CyGV1GB8vH5IhwduGCenlTyPB
         ZYSTBZwtvBB0vFIwr9kUfvEI14D2YJ+gHaFR6FA0sPDvCvxxFpFSONBUyKuBg6bQrl
         U9VW0RJcVFHSTynki4Fz+vwmS8SG1pYoKBL8wXe5ZlwAHzfgPoLNq0GieUdNAoZ+BB
         aCj1+BSpCjXIY8vLjuh8Fnr9vMoJ/8a5RLgie/8bnzElqwrwFdXKgkTjYYEeC4F4J3
         Mq7Rofv/RlSpKFLB5N2LIsV4DPkQotvYf740maIf3gyM1ZynE1dEGGcRvdpomw+GSx
         P0t+HR6XtxnGA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Segher Boessenkool <segher@kernel.crashing.org>
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
In-Reply-To: <20200806183316.GV6753@gate.crashing.org>
References: <cover.1588079622.git.christophe.leroy@c-s.fr> <2a67c333893454868bbfda773ba4b01c20272a5d.1588079622.git.christophe.leroy@c-s.fr> <878sflvbad.fsf@mpe.ellerman.id.au> <65fd7823-cc9d-c05a-0816-c34882b5d55a@csgroup.eu> <87wo2dy5in.fsf@mpe.ellerman.id.au> <20200805133505.GN6753@gate.crashing.org> <87r1sky1hm.fsf@mpe.ellerman.id.au> <20200806183316.GV6753@gate.crashing.org>
Date:   Fri, 07 Aug 2020 12:44:42 +1000
Message-ID: <87mu37xjhh.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Thu, Aug 06, 2020 at 12:03:33PM +1000, Michael Ellerman wrote:
>> Segher Boessenkool <segher@kernel.crashing.org> writes:
>> > On Wed, Aug 05, 2020 at 04:24:16PM +1000, Michael Ellerman wrote:
>> >> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> >> > Indeed, 32-bit doesn't have a redzone, so I believe it needs a stack 
>> >> > frame whenever it has anything to same.
>
> ^^^
>
>> >> >     fbb60:	94 21 ff e0 	stwu    r1,-32(r1)
>> >
>> > This is the *only* place where you can use a negative offset from r1:
>> > in the stwu to extend the stack (set up a new stack frame, or make the
>> > current one bigger).
>> 
>> (You're talking about 32-bit code here right?)
>
> The "SYSV" ELF binding, yeah, which is used for 32-bit on Linux (give or
> take, ho hum).
>
> The ABIs that have a red zone are much nicer here (but less simple) :-)

Yep, just checking I wasn't misunderstanding your comment about negative
offsets.

>> >> At the same time it's much safer for us to just save/restore r2, and
>> >> probably in the noise performance wise.
>> >
>> > If you want a function to be able to work with ABI-compliant code safely
>> > (in all cases), you'll have to make it itself ABI-compliant as well,
>> > yes :-)
>> 
>> True. Except this is the VDSO which has previously been a bit wild west
>> as far as ABI goes :)
>
> It could get away with many things because it was guaranteed to be a
> leaf function.  Some of those things even violate the ABIs, but you can
> get away with it easily, much reduced scope.  Now if this is generated
> code, violating the rules will catch up with you sooner rather than
> later ;-)

Agreed.

cheers
