Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3D14365DA
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 17:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhJUPVz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 11:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhJUPVz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 11:21:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A80BC061764;
        Thu, 21 Oct 2021 08:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NLJ71Cg5LEnHqcIFkkZXwV1AtdUcW7tx8BbmnW6dm2g=; b=LlXZjS8mpvPBPAcm9fAJMVVIEX
        GW9IxpiIaNNbRWFpiiSrlTQAisFo2nBmhFeRJTVLmPD3snhgYjgXfnh5+Tppkpkldh2CtnayBpvZU
        5VHsyKd64d1lhCkh2nspl7xw3HumC1xR2FmEPtMaRFc0FuBNTaijLVDqndEt1Xt7RasRb+gxhJSve
        tOKrfkwzfTuEfudSGXk/vzEgRdjLGuVswaaowf9Dd2xcJypZr51wI2BcTsmx0BUa1WiVCmok0aP4i
        u+v+vQl85dvR1aFijH7mbSgbGRIpGymJSZJWNLdMavXimToVlBQVcebHmtAT3g/7GQQmVBnMZ6U42
        798BlBkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdZmI-00DLc1-I2; Thu, 21 Oct 2021 15:15:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 30C283002BC;
        Thu, 21 Oct 2021 17:14:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0920B2C103FF6; Thu, 21 Oct 2021 17:14:45 +0200 (CEST)
Date:   Thu, 21 Oct 2021 17:14:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Christoph =?iso-8859-1?Q?M=FCllner?= <christophm30@gmail.com>,
        Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH] locking: Generic ticket lock
Message-ID: <YXGD5OFbI7TEDFTr@hirez.programming.kicks-ass.net>
References: <YXFli3mzMishRpEq@hirez.programming.kicks-ass.net>
 <CAK8P3a2+=9jjyqN5dMOb4+bYJy=q5G3CxFaCW+=4xryz-S=zYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2+=9jjyqN5dMOb4+bYJy=q5G3CxFaCW+=4xryz-S=zYA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 21, 2021 at 03:49:51PM +0200, Arnd Bergmann wrote:
> On Thu, Oct 21, 2021 at 3:05 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Therefore provide ticket locks, which depend on a single atomic
> > operation (fetch_add) while still providing fairness.
> 
> Nice!
> 
> Aside from the qspinlock vs ticket-lock question, can you describe the
> tradeoffs between this generic ticket lock and a custom implementation
> in architecture code? Should we convert most architectures over
> to the generic code in the long run, or is there something they
> can usually do better with an inline asm based ticket lock

I think for a load-store arch this thing should generate pretty close to
optimal code. x86 can do ticket_unlock() slightly better using a single
INCW (or ADDW 1) on the owner subword, where this implementation will to
separate load-add-store instructions.

If that is actually measurable is something else entirely.

> or a trivial test-and-set?

If your SMP arch is halfway sane (no fwd progress issues etc..) then
ticket should behave well and avoid the starvation/variablilty of TaS
lock.

The big exception there is virtualized architectures, ticket is
absolutely horrendous for 'guests' (any fair lock is for that matter).

