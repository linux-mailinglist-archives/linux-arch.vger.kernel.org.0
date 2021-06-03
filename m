Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFF339A9B6
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jun 2021 20:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhFCSHW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Jun 2021 14:07:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230436AbhFCSGz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Jun 2021 14:06:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD84D613E3;
        Thu,  3 Jun 2021 18:04:33 +0000 (UTC)
Date:   Thu, 3 Jun 2021 19:04:31 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Dave Martin <Dave.Martin@arm.com>, Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, libc-alpha@sourceware.org
Subject: Re: [PATCH v1 2/2] arm64: Enable BTI for main executable as well as
 the interpreter
Message-ID: <20210603180429.GI20338@arm.com>
References: <20210521144621.9306-1-broonie@kernel.org>
 <20210521144621.9306-3-broonie@kernel.org>
 <20210603154034.GH4187@arm.com>
 <20210603165134.GF4257@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603165134.GF4257@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 03, 2021 at 05:51:34PM +0100, Mark Brown wrote:
> On Thu, Jun 03, 2021 at 04:40:35PM +0100, Dave Martin wrote:
> > Do we know how libcs will detect that they don't need to do the
> > mprotect() calls?  Do we need a detection mechanism at all?
> > 
> > Ignoring certain errors from mprotect() when ld.so is trying to set
> > PROT_BTI on the main executable's code pages is probably a reasonable,
> > backwards-compatible compromise here, but it seems a bit wasteful.
> 
> I think the theory was that they would just do the mprotect() calls and
> ignore any errors as they currently do, or declare that they depend on a
> new enough kernel version I guess (not an option for glibc but might be
> for others which didn't do BTI yet).

I think we discussed the possibility of an AT_FLAGS bit. Until recently,
this field was 0 but it gained a new bit now. If we are to expose this
to arch-specific things, it may need some reservations. Anyway, that's
an optimisation that can be added subsequently.

-- 
Catalin
