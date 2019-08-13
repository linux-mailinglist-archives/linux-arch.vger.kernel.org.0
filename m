Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17EC78B663
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 13:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfHMLKJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 07:10:09 -0400
Received: from foss.arm.com ([217.140.110.172]:34252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbfHMLKJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 07:10:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62C26344;
        Tue, 13 Aug 2019 04:10:08 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A12C3F694;
        Tue, 13 Aug 2019 04:10:06 -0700 (PDT)
Date:   Tue, 13 Aug 2019 12:10:04 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Message-ID: <20190813111004.GV10425@arm.com>
References: <20190807155321.9648-1-catalin.marinas@arm.com>
 <20190807155321.9648-2-catalin.marinas@arm.com>
 <826a9ace-feac-c019-843e-07e23c9fd46c@intel.com>
 <20190808172730.GC37129@arrakis.emea.arm.com>
 <68354acd-e205-71cb-11c6-74a150178ae0@intel.com>
 <20190812173611.GD62772@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812173611.GD62772@arrakis.emea.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 12, 2019 at 06:36:12PM +0100, Catalin Marinas wrote:
> On Fri, Aug 09, 2019 at 07:10:18AM -0700, Dave Hansen wrote:
> > On 8/8/19 10:27 AM, Catalin Marinas wrote:
> > > On Wed, Aug 07, 2019 at 01:38:16PM -0700, Dave Hansen wrote:
> > >> Also, shouldn't this be converted over to an arch_prctl()?
> > > 
> > > What do you mean by arch_prctl()? We don't have such thing, apart from
> > > maybe arch_prctl_spec_ctrl_*(). We achieve the same thing with the
> > > {SET,GET}_TAGGED_ADDR_CTRL macros. They could be renamed to
> > > arch_prctl_tagged_addr_{set,get} or something but I don't see much
> > > point.
> > 
> > Silly me.  We have an x86-specific:
> > 
> > 	SYSCALL_DEFINE2(arch_prctl, int , option, unsigned long , arg2)
> > 
> > I guess there's no ARM equivalent so you're stuck with the generic one.
> > 
> > > What would be better (for a separate patch series) is to clean up
> > > sys_prctl() and move the arch-specific options into separate
> > > arch_prctl() under arch/*/kernel/. But it's not really for this series.
> > 
> > I think it does make sense for truly arch-specific features to stay out
> > of the arch-generic prctl().  Yes, I know I've personally violated this
> > in the past. :)
> 
> Maybe Dave M could revive his prctl() clean-up patches which moves the
> arch specific cases to the corresponding arch/*/ code

I'll try to take a look at it.

> > >> What is the scope of these prctl()'s?  Are they thread-scoped or
> > >> process-scoped?  Can two threads in the same process run with different
> > >> tagging ABI modes?
> > > 
> > > Good point. They are thread-scoped and this should be made clear in the
> > > doc. Two threads can have different modes.
> > > 
> > > The expectation is that this is invoked early during process start (by
> > > the dynamic loader or libc init) while in single-thread mode and
> > > subsequent threads will inherit the same mode. However, other uses are
> > > possible.
> > 
> > If that's the expectation, it would be really nice to codify it.
> > Basically, you can't enable the feature if another thread is already
> > been forked off.
> 
> Well, that's my expectation but I'm not a userspace developer. I don't
> think there is any good reason to prevent it. It doesn't cost us
> anything to support in the kernel, other than making the documentation
> clearer.

This came up for SVE and eventually we didn't bother, partly because the
kernel doesn't fully know what userspace is trying to do, in general.

If userspace has some kind of worker threads that run specific code,
they could legitimately interface differently with the kernel compared
with, say, the main thread.  This model already exists for e.g.,
seccomp.

In any case, I think it's not up to the kernel to dictate how user
runtimes initialise themselves.

[...]

Cheers
---Dave
