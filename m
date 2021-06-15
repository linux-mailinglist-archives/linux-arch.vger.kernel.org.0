Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F913A843D
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 17:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhFOPoR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 11:44:17 -0400
Received: from foss.arm.com ([217.140.110.172]:38748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231274AbhFOPoQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Jun 2021 11:44:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E42E13A1;
        Tue, 15 Jun 2021 08:42:12 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D71B33F70D;
        Tue, 15 Jun 2021 08:42:10 -0700 (PDT)
Date:   Tue, 15 Jun 2021 16:41:08 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arch@vger.kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        libc-alpha@sourceware.org, Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <20210615154106.GS4187@arm.com>
References: <20210604112450.13344-1-broonie@kernel.org>
 <43e67d7b-aab9-db1f-f74b-a87ba7442d47@arm.com>
 <20210615152203.GR4187@arm.com>
 <20210615153341.GI5149@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615153341.GI5149@sirena.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 15, 2021 at 04:33:41PM +0100, Mark Brown via Libc-alpha wrote:
> On Tue, Jun 15, 2021 at 04:22:06PM +0100, Dave Martin wrote:
> > On Thu, Jun 10, 2021 at 11:28:12AM -0500, Jeremy Linton via Libc-alpha wrote:
> 
> > > Thus, I expect that with his patch applied to 5.13 the service will fail to
> > > start regardless of the state of MDWE, but it seems to continue starting
> > > when I set MDWE=yes. Same behavior with v1 FWTW.
> 
> > If the failure we're trying to detect is that BTI is undesirably left
> > off for the main executable, surely replacing BTIs with NOPs will make
> > no differenece?  The behaviour with PROT_BTI clear is strictly more
> > permissive than with PROT_BTI set, so I'm not sure we can test the
> > behaviour this way.
> 
> > Maybe I'm missing sometihng / confused myself somewhere.
> 
> The issue this patch series is intended to address is that BTI gets
> left off since the dynamic linker is unable to enable PROT_BTI on the
> main executable.  We're looking to see that we end up with the stricter
> permissions checking of BTI, with the issue present landing pads
> replaced by NOPs will not fault but once the issue is addressed they
> should start faulting.

Ah, right -- I got the test backwards in my head.  Yes, that sounds
reasonable.

> > Looking at /proc/<pid>/maps after the process starts up may be a more
> > reliable approach, so see what the actual prot value is on the main
> > executable's text pages.
> 
> smaps rather than maps but yes, executable pages show up as "ex" and BTI
> adds a "bt" tag in VmFlags.

Fumbled that -- yes, I meant smaps!

Ignore me...

Cheers
---Dave
