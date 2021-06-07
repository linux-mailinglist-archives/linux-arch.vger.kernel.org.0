Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C50839E63F
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 20:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFGSOI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 14:14:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhFGSOI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 14:14:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2E2261003;
        Mon,  7 Jun 2021 18:12:15 +0000 (UTC)
Date:   Mon, 7 Jun 2021 19:12:13 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-arch@vger.kernel.org,
        libc-alpha@sourceware.org, Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 2/2] arm64: Enable BTI for main executable as well as
 the interpreter
Message-ID: <20210607181212.GD17957@arm.com>
References: <20210521144621.9306-1-broonie@kernel.org>
 <20210521144621.9306-3-broonie@kernel.org>
 <20210603154034.GH4187@arm.com>
 <20210603165134.GF4257@sirena.org.uk>
 <20210603180429.GI20338@arm.com>
 <20210607112536.GI4187@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607112536.GI4187@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 07, 2021 at 12:25:38PM +0100, Dave P Martin wrote:
> On Thu, Jun 03, 2021 at 07:04:31PM +0100, Catalin Marinas via Libc-alpha wrote:
> > On Thu, Jun 03, 2021 at 05:51:34PM +0100, Mark Brown wrote:
> > > On Thu, Jun 03, 2021 at 04:40:35PM +0100, Dave Martin wrote:
> > > > Do we know how libcs will detect that they don't need to do the
> > > > mprotect() calls?  Do we need a detection mechanism at all?
> > > > 
> > > > Ignoring certain errors from mprotect() when ld.so is trying to set
> > > > PROT_BTI on the main executable's code pages is probably a reasonable,
> > > > backwards-compatible compromise here, but it seems a bit wasteful.
> > > 
> > > I think the theory was that they would just do the mprotect() calls and
> > > ignore any errors as they currently do, or declare that they depend on a
> > > new enough kernel version I guess (not an option for glibc but might be
> > > for others which didn't do BTI yet).
> > 
> > I think we discussed the possibility of an AT_FLAGS bit. Until recently,
> > this field was 0 but it gained a new bit now. If we are to expose this
> > to arch-specific things, it may need some reservations. Anyway, that's
> > an optimisation that can be added subsequently.
> 
> I suppose so, but AT_FLAGS doesn't seem appropriate somehow.
> 
> I wonder why we suddenly start considering adding a flag to AT_FLAGS
> every few months, when it had sat empty for decades.  This may say
> something about the current health of the kernel ABI, but I'm not sure
> exactly what.
> 
> I think having mprotect() fail in a predictable way may be preferable
> for now: glibc still only needs to probe with a single call and could
> cache the knowledge after that.  Code outside libc / ld.so seems quite
> unlikely to care about this.

I think that's the expected approach for now. If anyone complains about
an extra syscall, we can look into options but I wouldn't rush on doing
something.

> Any ideas on how we would document this behaviour?  The kernel and libc
> behaviour are 100% clear: you _are_ allowed to twiddle PROT_BTI on
> executable mappings, and there is no legitimate (or even useful) reason
> to disallow this.  It's only systemd deliberately breaking the API that
> causes the behaviour seem by "userspace" to vary.

I don't think we can document all the filters that can be added on top
various syscalls, so I'd leave it undocumented (or part of the systemd
documentation). It was a user space program (systemd) breaking another
user space program (well, anything with a new enough glibc). The kernel
ABI was still valid when /sbin/init started ;).

-- 
Catalin
