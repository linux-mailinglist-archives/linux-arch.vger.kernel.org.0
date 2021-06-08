Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D1A39FA3C
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 17:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhFHPWN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 11:22:13 -0400
Received: from foss.arm.com ([217.140.110.172]:33356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230462AbhFHPWM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 11:22:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72F346D;
        Tue,  8 Jun 2021 08:20:19 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 565963F73D;
        Tue,  8 Jun 2021 08:20:18 -0700 (PDT)
Date:   Tue, 8 Jun 2021 16:19:18 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 2/2] arm64: Enable BTI for main executable as well as
 the interpreter
Message-ID: <20210608151914.GJ4187@arm.com>
References: <20210521144621.9306-1-broonie@kernel.org>
 <20210521144621.9306-3-broonie@kernel.org>
 <20210603154034.GH4187@arm.com>
 <20210603165134.GF4257@sirena.org.uk>
 <20210603180429.GI20338@arm.com>
 <20210607112536.GI4187@arm.com>
 <20210607181212.GD17957@arm.com>
 <20210608113318.GA4200@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608113318.GA4200@sirena.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 08, 2021 at 12:33:18PM +0100, Mark Brown via Libc-alpha wrote:
> On Mon, Jun 07, 2021 at 07:12:13PM +0100, Catalin Marinas wrote:
> 
> > I don't think we can document all the filters that can be added on top
> > various syscalls, so I'd leave it undocumented (or part of the systemd
> > documentation). It was a user space program (systemd) breaking another
> > user space program (well, anything with a new enough glibc). The kernel
> > ABI was still valid when /sbin/init started ;).
> 
> Indeed.  I think from a kernel point of view the main thing is to look
> at why userspace feels the need to do things like this and see if
> there's anything we can improve or do better with in future APIs, part
> of the original discussion here was figuring out that there's not really
> any other reasonable options for userspace to implement this check at
> the minute.

Ack, that would be my policy -- just wanted to make it explicit.
It would be good if there were better dialogue between the systemd
and kernel folks on this kind of thing.

SECCOMP makes it rather easy to (attempt to) paper over kernel/user API
design problems, which probably reduces the chance of the API ever being
fixed properly, if we're not careful...

Cheers
---Dave
