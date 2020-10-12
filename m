Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551DC28B225
	for <lists+linux-arch@lfdr.de>; Mon, 12 Oct 2020 12:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgJLKW3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 06:22:29 -0400
Received: from foss.arm.com ([217.140.110.172]:35562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729529AbgJLKW3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Oct 2020 06:22:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E9E831B;
        Mon, 12 Oct 2020 03:22:28 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EC173F719;
        Mon, 12 Oct 2020 03:22:27 -0700 (PDT)
Date:   Mon, 12 Oct 2020 11:22:24 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] arm64: Add support for asymmetric AArch32 EL0
 configurations
Message-ID: <20201012102224.jwwwbejmgq7hj373@e107158-lin.cambridge.arm.com>
References: <20201008181641.32767-1-qais.yousef@arm.com>
 <20201008181641.32767-3-qais.yousef@arm.com>
 <5e1fe1a9-4ebc-bd20-701e-844d5c16dd42@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e1fe1a9-4ebc-bd20-701e-844d5c16dd42@infradead.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/08/20 11:22, Randy Dunlap wrote:
> On 10/8/20 11:16 AM, Qais Yousef wrote:
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 6d232837cbee..591853504dc4 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1868,6 +1868,20 @@ config DMI
> >  
> >  endmenu
> >  
> > +config ASYMMETRIC_AARCH32
> > +	bool "Allow support for asymmetric AArch32 support"
> 
> Please drop one "support" or reword the prompt string.

Thanks Randy. It now reads

	"Allow support for asymmetric AArch32 systems"

Cheers

--
Qais Yousef

> 
> > +	depends on COMPAT && EXPERT
> > +	help
> > +	  Enable this option to allow support for asymmetric AArch32 EL0
> > +	  CPU configurations. Once the AArch32 EL0 support is detected
> > +	  on a CPU, the feature is made available to user space to allow
> > +	  the execution of 32-bit (compat) applications. If the affinity
> > +	  of the 32-bit application contains a non-AArch32 capable CPU
> > +	  or the last AArch32 capable CPU is offlined, the application
> > +	  will be killed.
> > +
> > +	  If unsure say N.
> 
> 
> -- 
> ~Randy
> 
