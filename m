Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B646B285065
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 19:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgJFRA1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 13:00:27 -0400
Received: from foss.arm.com ([217.140.110.172]:52364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgJFRA1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Oct 2020 13:00:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A31C1D6E;
        Tue,  6 Oct 2020 10:00:26 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A660A3F66B;
        Tue,  6 Oct 2020 10:00:24 -0700 (PDT)
Date:   Tue, 6 Oct 2020 18:00:21 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] x86: Improve Minimum Alternate Stack Size
Message-ID: <20201006170020.GB6642@arm.com>
References: <20200929205746.6763-1-chang.seok.bae@intel.com>
 <20201005134534.GT6642@arm.com>
 <CAMe9rOpZm43aDG3UJeaioU32zSYdTxQ=ZyZuSS4u0zjbs9RoKw@mail.gmail.com>
 <20201006092532.GU6642@arm.com>
 <CAMe9rOq_nKa6xjHju3kVZephTiO+jEW3PqxgAhU9+RdLTo-jgg@mail.gmail.com>
 <20201006152553.GY6642@arm.com>
 <7663eff0-6c94-f6bf-f3e2-93ede50e75ed@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7663eff0-6c94-f6bf-f3e2-93ede50e75ed@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 06, 2020 at 08:33:47AM -0700, Dave Hansen wrote:
> On 10/6/20 8:25 AM, Dave Martin wrote:
> > Or are people reporting real stack overruns on x86 today?
> 
> We have real overruns.  We have ~2800 bytes of XSAVE (regisiter) state
> mostly from AVX-512, and a 2048 byte MINSIGSTKSZ.

Right.  Out of interest, do you believe that's a direct consequence of
the larger kernel-generated signal frame, or does the expansion of
userspace stack frames play a role too?

In practice software just assumes SIGSTKSZ and then ignores the problem
until / unless an actual stack overflow is seen.

There's probably a lot of software out there whose stack is
theoretically too small even without AVX-512 etc. in the mix, especially
when considering the possibility of nested signals...

Cheers
---Dave
