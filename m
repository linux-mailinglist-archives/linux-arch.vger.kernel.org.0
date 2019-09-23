Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F225ABAF9C
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2019 10:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406380AbfIWIbV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Sep 2019 04:31:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40568 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406140AbfIWIbV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Sep 2019 04:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7o6n0gDyL8oWsv7euVvM1MN4aW1spZsrFDqIaqO7ubU=; b=OWUHLnis63TPY5Zn5rv4UnzaP
        oBxAH4Qa7rfAOOln4qe+XeIhBt3DVZwDWIIHAV5KI+Lsqx3qYBJsZ7NjWhKhDcjM0ER+i0Fh5zNY3
        JYxAU4qaLEvPgqCCCot7RpAXStjrQkoiaUvzZvBsupuRXVZ60ti5EEMGVYJr7Sq/3En+jso9sSRCE
        9Mj9yfyi+TkRrBsOzS/2XkuDx5Zc5uUff5X/96t0E5VFuW9DzvsbtrxdP6fNOrgUUFEiHE1tAyent
        UztA8BnGK/I4nT1PBylr/6BVUgO5eW6E2MzmlwGWwfY/kB8fIHipfCQNG7RkbEmXc+ZWzxt7rlnka
        ONrjfsFMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCJka-0001Oo-4C; Mon, 23 Sep 2019 08:31:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BD07F303DFD;
        Mon, 23 Sep 2019 10:30:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D6C642B1204C9; Mon, 23 Sep 2019 10:31:14 +0200 (CEST)
Date:   Mon, 23 Sep 2019 10:31:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC patch 03/15] x86/entry: Use generic syscall entry function
Message-ID: <20190923083114.GF2349@hirez.programming.kicks-ass.net>
References: <20190919150314.054351477@linutronix.de>
 <20190919150808.724554170@linutronix.de>
 <CALCETrUhH9_ZGn=-FMKYvTswQ7g0deVJif2xUihsu5tpJg0xSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUhH9_ZGn=-FMKYvTswQ7g0deVJif2xUihsu5tpJg0xSA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 20, 2019 at 04:41:03PM -0700, Andy Lutomirski wrote:
> On Thu, Sep 19, 2019 at 8:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Replace the syscall entry work handling with the generic version, Provide
> > the necessary helper inlines to handle the real architecture specific
> > parts, e.g. audit and seccomp invocations.
> 
> > -       if (work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
> > -               ret = tracehook_report_syscall_entry(regs);
> > -               if (ret || (work & _TIF_SYSCALL_EMU))
> > -                       return -1L;
> > -       }
> 
> Unless I missed something, you lost the _TIF_SYSCALL_EMU abomination.

IIUC that's actually in patch #1.
