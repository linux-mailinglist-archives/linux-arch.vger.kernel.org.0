Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A071D9C2C
	for <lists+linux-arch@lfdr.de>; Tue, 19 May 2020 18:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgESQOn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 May 2020 12:14:43 -0400
Received: from foss.arm.com ([217.140.110.172]:35734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbgESQOm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 May 2020 12:14:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60B3730E;
        Tue, 19 May 2020 09:14:42 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D46BB3F305;
        Tue, 19 May 2020 09:14:40 -0700 (PDT)
Date:   Tue, 19 May 2020 17:14:34 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v4 24/26] arm64: mte: Introduce early param to disable
 MTE support
Message-ID: <20200519161434.GF20313@gaia>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-25-catalin.marinas@arm.com>
 <a2ad6cbf-2632-3cda-eb49-74ddfbed2cec@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2ad6cbf-2632-3cda-eb49-74ddfbed2cec@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 18, 2020 at 12:26:30PM +0100, Vladimir Murzin wrote:
> On 5/15/20 6:16 PM, Catalin Marinas wrote:
> > For performance analysis it may be desirable to disable MTE altogether
> > via an early param. Introduce arm64.mte_disable and, if true, filter out
> > the sanitised ID_AA64PFR1_EL1.MTE field to avoid exposing the HWCAP to
> > user.
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> > 
> > Notes:
> >     New in v4.
> > 
> >  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
> >  arch/arm64/kernel/cpufeature.c                  | 11 +++++++++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index f2a93c8679e8..7436e7462b85 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -373,6 +373,10 @@
> >  	arcrimi=	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
> >  			Format: <io>,<irq>,<nodeID>
> >  
> > +	arm64.mte_disable=
> > +			[ARM64] Disable Linux support for the Memory
> > +			Tagging Extension (both user and in-kernel).
> > +
> 
> Should it really to take parameter (on/off/true/false)? It may lead to expectation
> that arm64.mte_disable=false should enable MT and, yes, double negatives make it
> look ugly, so if we do need parameter, can it be arm64.mte=on/off/true/false?

My reasoning about arm64.mte= was that 'on' may lead people to think it
does something even when MTE isn't available on the SoC. So I ended up
with an explicit 'disable' in the name. Happy to change it if we don't
drop this parameter altogether (in the absence of valid use-cases).

-- 
Catalin
