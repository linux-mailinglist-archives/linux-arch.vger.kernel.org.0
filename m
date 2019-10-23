Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED56E1E4A
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 16:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389876AbfJWOhs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 10:37:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49102 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732328AbfJWOhs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Oct 2019 10:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/PR2FEiCX+iu4eBmOZGHncjejUZSgrUpVLIkHmDbJhU=; b=FnXFrZo50dOrSKOXpol2prson
        gTlqkVnD6hYYGZ5vX+QKIYp1tlmacAw4DtTMwHmAxJIz8Q9OKuTAMPacabb4rZ5rqtjYLz9yvhYdF
        GcNTyDoOD67WxiR5GjT4fakBYjhOFKVV7t4OyCJKIdZrr8zB3dLn1H15qt0Affa7xuR1t4uqwHI52
        1VA2EW8gfOT6fDr7m5ZgZcUL/iwEb/vckqEB9sgi56WyUtQVMOHWUKC2FTrpdYouJNrEtbdrj+dyl
        TFTBGjr4n+MfeKN9HhzNCTcncRmr7a+/NTp57Gq4y45KRR9sGJc0CbqkXcufhl1DW+g88P30GgKhm
        4hCq4S+kg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNHlY-0007VJ-Ql; Wed, 23 Oct 2019 14:37:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 770C4300EBF;
        Wed, 23 Oct 2019 16:36:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8643A2B1D776D; Wed, 23 Oct 2019 16:37:34 +0200 (CEST)
Date:   Wed, 23 Oct 2019 16:37:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [patch V2 00/17] entry: Provide generic implementation for host
 and guest entry/exit work
Message-ID: <20191023143734.GJ1800@hirez.programming.kicks-ass.net>
References: <20191023122705.198339581@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023122705.198339581@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 23, 2019 at 02:27:05PM +0200, Thomas Gleixner wrote:
>  /Makefile                             |    3 
>  arch/Kconfig                          |    3 
>  arch/x86/Kconfig                      |    1 
>  arch/x86/entry/calling.h              |   12 +
>  arch/x86/entry/common.c               |  264 ++------------------------------
>  arch/x86/entry/entry_32.S             |   41 ----
>  arch/x86/entry/entry_64.S             |   32 ---
>  arch/x86/entry/entry_64_compat.S      |   30 ---
>  arch/x86/include/asm/irqflags.h       |    8 
>  arch/x86/include/asm/paravirt.h       |    9 -
>  arch/x86/include/asm/signal.h         |    1 
>  arch/x86/include/asm/thread_info.h    |    9 -
>  arch/x86/kernel/signal.c              |    2 
>  arch/x86/kernel/traps.c               |   33 ++--
>  arch/x86/kvm/x86.c                    |   17 --
>  arch/x86/mm/fault.c                   |    7 
>  b/arch/x86/include/asm/entry-common.h |  104 ++++++++++++
>  b/arch/x86/kvm/Kconfig                |    1 
>  b/include/linux/entry-common.h        |  280 ++++++++++++++++++++++++++++++++++
>  b/kernel/entry/common.c               |  184 ++++++++++++++++++++++
>  include/linux/kvm_host.h              |   64 +++++++
>  kernel/Makefile                       |    1 
>  virt/kvm/Kconfig                      |    3 
>  23 files changed, 735 insertions(+), 374 deletions(-)

This looks really nice; esp. the cleaned up interrupt state.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
