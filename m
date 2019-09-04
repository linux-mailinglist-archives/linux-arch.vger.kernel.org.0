Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED642A80CF
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2019 13:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfIDLFU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Sep 2019 07:05:20 -0400
Received: from foss.arm.com ([217.140.110.172]:51984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729220AbfIDLFU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 4 Sep 2019 07:05:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5E84337;
        Wed,  4 Sep 2019 04:05:19 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F8973F246;
        Wed,  4 Sep 2019 04:05:18 -0700 (PDT)
Date:   Wed, 4 Sep 2019 12:05:16 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Kees Cook <keescook@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 2/2] ELF: Add ELF program property parsing support
Message-ID: <20190904110515.GP27757@arm.com>
References: <1566581020-9953-1-git-send-email-Dave.Martin@arm.com>
 <1566581020-9953-3-git-send-email-Dave.Martin@arm.com>
 <201908292224.007EB4D5@keescook>
 <20190830083415.GI27757@arm.com>
 <5ddd0306f42c2b53ffbd8ee8c9b948c1d529cf98.camel@intel.com>
 <20190902092816.GK27757@arm.com>
 <59052137a61bab9e8d312d51644aade3953ba339.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59052137a61bab9e8d312d51644aade3953ba339.camel@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[Kees, you have any thoughts on the error code issue?  See below.]

On Tue, Sep 03, 2019 at 11:29:10PM +0100, Yu-cheng Yu wrote:
> On Mon, 2019-09-02 at 10:28 +0100, Dave Martin wrote:
> > On Fri, Aug 30, 2019 at 06:03:27PM +0100, Yu-cheng Yu wrote:
> > > On Fri, 2019-08-30 at 09:34 +0100, Dave Martin wrote:
> > > > On Fri, Aug 30, 2019 at 06:37:45AM +0100, Kees Cook wrote:
> > > > > On Fri, Aug 23, 2019 at 06:23:40PM +0100, Dave Martin wrote:
> > > > > > ELF program properties will needed for detecting whether to enable
> > > > > > optional architecture or ABI features for a new ELF process.
> > > > > > 
> > > > > > For now, there are no generic properties that we care about, so do
> > > > > > nothing unless CONFIG_ARCH_USE_GNU_PROPERTY=y.
> > > > > > 
> > > > > > Otherwise, the presence of properties using the PT_PROGRAM_PROPERTY
> > > > > > phdrs entry (if any), and notify each property to the arch code.
> > > > > > 
> > > > > > For now, the added code is not used.
> > > > > > 
> > > > > > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > > > > 
> > > > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > > 
> > > > Thanks for the review.
> > > > 
> > > > Do you have any thoughts on Yu-Cheng Yu's comments?  It would be nice to
> > > > early-terminate the scan if we can, but my feeling so far was that the
> > > > scan is cheap, the number of properties is unlikely to be more than a
> > > > smallish integer, and the code separation benefits of just calling the
> > > > arch code for every property probably likely outweigh the costs of
> > > > having to iterate over every property.  We could always optimise it
> > > > later if necessary.
> > > > 
> > > > I need to double-check that there's no way we can get stuck in an
> > > > infinite loop with the current code, though I've not seen it in my
> > > > testing.  I should throw some malformed notes at it though.
> > > 
> > > Here is my arch_parse_elf_property() and objdump of the property.
> > > The parser works fine.
> > 
> > [...]
> > 
> > > int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
> > >           
> > >                    bool compat, struct arch_elf_state *state)
> > > {
> > >         if (type
> > > != GNU_PROPERTY_X86_FEATURE_1_AND)
> > >                 return -ENOENT;
> > 
> > For error returns, I was following this convention:
> > 
> > 	EIO: invalid ELF file
> > 
> > 	ENOEXEC: valid ELF file, but we can't (or won't) support it
> > 
> > 	0: OK, or don't care
> 
> From errno-base.h, EIO is for I/O error; ENOEXEC is for Exec format error.
> Is this closer to what is happening?

The common case of ENOEXEC is that the file is valid but can't be
executed (i.e., wrong architecture, unsupported binary format etc.).

There's precent for reporting a truncated file (seen as a kernel_read()
that reads less data than requested) being reported as -EIO.  There is
no actual I/O error here, this is just a file with a noncompliant format.
This happens on short read when trying to read the interpreter filename
from the main ELF file for example.

Based on this, I used EIO to report malformed files.

This doesn't always happen though even in the existing code: for
example, the same error occurring in load_elf_phdrs() yields ENOEXEC
from execve(), not EIO.  It's not clear which (if either) is the
correct error code.

The behaviour isn't totally consistent though, so maybe this is not
intentional.

The distinction seemed useful, but I agree this can be seen as an abuse
of EIO.

I'm happy to change this if people don't like it, but I'm not sure what
to change it to...

> > This function gets called for every property, including properties that
> > the arch code may not be interested in, so for properties you don't care
> > about here you should return 0.
> 
> Yes.
> 
> > 
> > > 
> > >         if (datasz < sizeof(unsigned int))
> > >                 return -ENOEXEC;
> > 
> > Should this be != ?
> > 
> > According to the draft x86-64 psABI spec [1],
> > X86_PROPERTY_FEATURE_1_AND (and all properties based on
> > GNU_PROPERTY_X86_UINT32_AND_LO) has data consisting of a single 4-byte
> > unsigned integer.
> > 
> > >         state->gnu_property = *(unsigned int *)data;
> > >         return 0;
> > > }
> 
> Yes, I will change it.

OK

Cheers
---Dave
