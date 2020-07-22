Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B533022929E
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 09:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgGVHzF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 03:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGVHzF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 03:55:05 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160EBC0619DC;
        Wed, 22 Jul 2020 00:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RM7GOf2CU2j7IEdxsQ76+7tPsuDp35umedz/Oe8IL6c=; b=wVfIXSUtGE9pDSPf46IprCtRvt
        rlP4DWLTU+26h7YnzffGvPwx+Q2V5KStDB4gowD8s7ZZPyjjQVbdcNRz7+j0R7IR4XOtvs2rUjWC1
        k6y/xZUeyIKYZGAM7I8yNwLrgkRoj1kgHzOVzvTP0ydEzmzgaYqYxd0TV0b9aCa4+k3NQb8+7IVqs
        ICcLMaAeUsXe1p6j3U2a9gtA5y2ra0GrRVvTm5UBCFozLFNoWobQZLIMxocwnw8BEZWEwm+L6+iPh
        Nc0Bf4pLM6xygsvwGTyEYclLbqc97zAnATlncIKI8vXTQwPnxeuPouY72d2tZkMrMcTJEnDtMCQW3
        ZETQILTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jy9aa-0005h7-Sf; Wed, 22 Jul 2020 07:54:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8529E301AC6;
        Wed, 22 Jul 2020 09:54:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B06D20140AD7; Wed, 22 Jul 2020 09:54:55 +0200 (CEST)
Date:   Wed, 22 Jul 2020 09:54:55 +0200
From:   peterz@infradead.org
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [patch V4 02/15] entry: Provide generic syscall entry
 functionality
Message-ID: <20200722075455.GQ119549@hirez.programming.kicks-ass.net>
References: <20200721105706.030914876@linutronix.de>
 <20200721110808.455350746@linutronix.de>
 <202007211426.B40A7A7BD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007211426.B40A7A7BD@keescook>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 02:38:16PM -0700, Kees Cook wrote:
> One thing I noticed while doing syscall entry timings for the kernel
> stack base offset randomization was that the stack protector was being
> needlessly enabled in certain paths (seccomp, audit) due to seeing a
> register array being declared on the stack. As part of that series I
> suggested down-grading the stack protector. Since then, Peter's changes
> entirely disabled the stack protector on the entry code, which I
> grudgingly accept (I'd rather have a way to mark a variable as "ignore
> this for stack protector detection", but ... there isn't, so fine.)

I don't think I'd like to have that per variable, but a function
attribute to disable stack protector would be awesome, except our
GCC-besties forgot to create that function attribute :-(

If/when we get such a function attribute, we can add it to noinstr.

Also see this here:

  https://lkml.kernel.org/r/20200314164451.346497-1-slyfox@gentoo.org
