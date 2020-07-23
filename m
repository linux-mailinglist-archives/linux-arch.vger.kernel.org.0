Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64E522B7C7
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 22:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgGWUbE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 16:31:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:51798 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbgGWUbE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jul 2020 16:31:04 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 06NKUlRb019444;
        Thu, 23 Jul 2020 15:30:47 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 06NKUkhI019442;
        Thu, 23 Jul 2020 15:30:46 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 23 Jul 2020 15:30:46 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     peterz@infradead.org
Cc:     Waiman Long <longman@redhat.com>, linux-arch@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        virtualization@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        kvm-ppc@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks for SPLPAR
Message-ID: <20200723203046.GI32057@gate.crashing.org>
References: <20200706043540.1563616-1-npiggin@gmail.com> <20200706043540.1563616-6-npiggin@gmail.com> <874kqhvu1v.fsf@mpe.ellerman.id.au> <8265d782-4e50-a9b2-a908-0cb588ffa09c@redhat.com> <20200723140011.GR5523@worktop.programming.kicks-ass.net> <845de183-56f5-2958-3159-faa131d46401@redhat.com> <20200723184759.GS119549@hirez.programming.kicks-ass.net> <6d6279ad-7432-63c1-14c3-18c4cff30bf8@redhat.com> <20200723195855.GU119549@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723195855.GU119549@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.4.2.3i
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 23, 2020 at 09:58:55PM +0200, peterz@infradead.org wrote:
> 	asm ("addb	%[val], %b[var];"
> 	     "cmovc	%[sat], %[var];"
> 	     : [var] "+r" (tmp)
> 	     : [val] "ir" (val), [sat] "r" (sat)
> 	     );

"var" (operand 0) needs an earlyclobber ("sat" is read after "var" is
written for the first time).


Segher
