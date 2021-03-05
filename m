Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AF932E722
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 12:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhCELVA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 06:21:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:44684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhCELUy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 06:20:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5E8B65015;
        Fri,  5 Mar 2021 11:20:52 +0000 (UTC)
Date:   Fri, 5 Mar 2021 11:20:49 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Alexander Lobakin <alobakin@pm.me>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2] ARM64: enable GENERIC_FIND_FIRST_BIT
Message-ID: <20210305112049.GB23855@arm.com>
References: <20210225135700.1381396-1-yury.norov@gmail.com>
 <20210225135700.1381396-2-yury.norov@gmail.com>
 <20210225140205.GA13297@willie-the-truck>
 <20210303221741.GA2013084@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303221741.GA2013084@yury-ThinkPad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 03, 2021 at 02:17:41PM -0800, Yury Norov wrote:
> On Thu, Feb 25, 2021 at 02:02:06PM +0000, Will Deacon wrote:
> > On Thu, Feb 25, 2021 at 05:56:59AM -0800, Yury Norov wrote:
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index 31bd885b79eb..5596eab04092 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -108,6 +108,7 @@ config ARM64
> > >  	select GENERIC_CPU_AUTOPROBE
> > >  	select GENERIC_CPU_VULNERABILITIES
> > >  	select GENERIC_EARLY_IOREMAP
> > > +	select GENERIC_FIND_FIRST_BIT
> > >  	select GENERIC_IDLE_POLL_SETUP
> > >  	select GENERIC_IRQ_IPI
> > >  	select GENERIC_IRQ_MULTI_HANDLER
> > 
> > Acked-by: Will Deacon <will@kernel.org>
> > 
> > Catalin can pick this up later in the cycle.
> > 
> > Will
> 
> Ping?

It's on my list for 5.13 but I'll only start queuing patches after -rc3.

-- 
Catalin
