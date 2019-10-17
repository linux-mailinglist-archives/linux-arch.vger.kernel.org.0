Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51ADFDA6A9
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 09:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388682AbfJQHr6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Oct 2019 03:47:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387930AbfJQHr6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 03:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CB9qLsgKsb2C8+4Pa5xdxWx+A9UkvlFXKVU3Kno+WKQ=; b=ROM9pgBtdot+ZohnyfyN8rdcZ
        OnZ56n50MaSVgCFWyn/mfioM0Z/iPxkd+ok0AGd9nDuhgSiNNa8MyhbNtGWojGKV8O1AZPltF1rJh
        CZ74niaLUFK+aGgq15s4Ghuto3JTCVqhumynY8qZl88AdgJds45NcyFxwCeAJX92mZkCO1jFju0wv
        DskF/8TNBHofVES1ofHgClvFvy+aCvWTgQ/dtXeGROi6+719bFGOLxlJdwsbuW6Vwo5p4EojIDtlR
        Nq7w3d0cuSzC0vSjbfIFXPzynwwk9ig1TpN8gDSovFeOESzxG8ucveivrVVnw3Inxvn3bvlTiYPn5
        JaT7idCPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL0VR-0008Vj-Jw; Thu, 17 Oct 2019 07:47:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFD2530018A;
        Thu, 17 Oct 2019 09:46:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1CA14203BFA9E; Thu, 17 Oct 2019 09:47:30 +0200 (CEST)
Date:   Thu, 17 Oct 2019 09:47:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Potapenko <glider@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>,
        Daniel Lustig <dlustig@nvidia.com>,
        dave.hansen@linux.intel.com, David Howells <dhowells@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH 1/8] kcsan: Add Kernel Concurrency Sanitizer
 infrastructure
Message-ID: <20191017074730.GW2328@hirez.programming.kicks-ass.net>
References: <20191016083959.186860-1-elver@google.com>
 <20191016083959.186860-2-elver@google.com>
 <20191016184346.GT2328@hirez.programming.kicks-ass.net>
 <CANpmjNP4b9Eo3ZKE6maBs4ANS7K7sLiVB2CbebQnCH09TB+hZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP4b9Eo3ZKE6maBs4ANS7K7sLiVB2CbebQnCH09TB+hZQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 16, 2019 at 09:34:05PM +0200, Marco Elver wrote:
> On Wed, 16 Oct 2019 at 20:44, Peter Zijlstra <peterz@infradead.org> wrote:
> > > +     /*
> > > +      * Disable interrupts & preemptions, to ignore races due to accesses in
> > > +      * threads running on the same CPU.
> > > +      */
> > > +     local_irq_save(irq_flags);
> > > +     preempt_disable();
> >
> > Is there a point to that preempt_disable() here?
> 
> We want to avoid being preempted while the watchpoint is set up;
> otherwise, we would report data-races for CPU-local data, which is
> incorrect.

Disabling IRQs already very much disables preemption. There is
absolutely no point in doing preempt_disable() when the whole section
already runs with IRQs disabled.
