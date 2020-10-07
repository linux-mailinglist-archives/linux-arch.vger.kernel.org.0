Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A317285CD6
	for <lists+linux-arch@lfdr.de>; Wed,  7 Oct 2020 12:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgJGKUi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 06:20:38 -0400
Received: from foss.arm.com ([217.140.110.172]:41422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbgJGKUW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Oct 2020 06:20:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B3FB11B3;
        Wed,  7 Oct 2020 03:20:21 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B80F3F71F;
        Wed,  7 Oct 2020 03:20:19 -0700 (PDT)
Date:   Wed, 7 Oct 2020 11:20:16 +0100
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
Message-ID: <20201007102015.GG6642@arm.com>
References: <20200929205746.6763-1-chang.seok.bae@intel.com>
 <20201005134534.GT6642@arm.com>
 <CAMe9rOpZm43aDG3UJeaioU32zSYdTxQ=ZyZuSS4u0zjbs9RoKw@mail.gmail.com>
 <20201006092532.GU6642@arm.com>
 <CAMe9rOq_nKa6xjHju3kVZephTiO+jEW3PqxgAhU9+RdLTo-jgg@mail.gmail.com>
 <20201006152553.GY6642@arm.com>
 <7663eff0-6c94-f6bf-f3e2-93ede50e75ed@intel.com>
 <20201006170020.GB6642@arm.com>
 <3545e3f3-a716-5e82-bd24-450eb74b4563@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3545e3f3-a716-5e82-bd24-450eb74b4563@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 06, 2020 at 11:30:42AM -0700, Dave Hansen wrote:
> On 10/6/20 10:00 AM, Dave Martin wrote:
> > On Tue, Oct 06, 2020 at 08:33:47AM -0700, Dave Hansen wrote:
> >> On 10/6/20 8:25 AM, Dave Martin wrote:
> >>> Or are people reporting real stack overruns on x86 today?
> >> We have real overruns.  We have ~2800 bytes of XSAVE (regisiter) state
> >> mostly from AVX-512, and a 2048 byte MINSIGSTKSZ.
> > Right.  Out of interest, do you believe that's a direct consequence of
> > the larger kernel-generated signal frame, or does the expansion of
> > userspace stack frames play a role too?
> 
> The kernel-generated signal frame is entirely responsible for the ~2800
> bytes that I'm talking about.
> 
> I'm sure there are some systems where userspace plays a role, but those
> are much less of a worry at the moment, since the kernel-induced
> overflows mean an instant crash that userspace has no recourse for.

Ack, that sounds pretty convincing.

Cheers
---Dave
