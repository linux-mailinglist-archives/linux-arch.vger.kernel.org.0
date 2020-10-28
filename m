Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A98429DE83
	for <lists+linux-arch@lfdr.de>; Thu, 29 Oct 2020 01:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbgJ1WSE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Oct 2020 18:18:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731780AbgJ1WRp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:45 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA94F246BA;
        Wed, 28 Oct 2020 11:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603884124;
        bh=gCC0Dn6wIGkv86PvFj+5e1eW46q6tyKiN4oY61BT7os=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UMbj+PfZ1WE8lf5L27GZgSlvtoY46oq0ZS5AOpDKIQzT2yn6yeVar0fO4Hq2UjPCH
         exHXpIrznCGfSYJWHivfkolSB9wAv8uGESDTeOx8S1FsUzCrrYliLwcAD7QhedRH3C
         GqZk18VqCoTXNMcdCdwh1IJvheh5OsOpmXsi6vvM=
Date:   Wed, 28 Oct 2020 11:21:59 +0000
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>, kernel-team@android.com
Subject: Re: [PATCH 2/6] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <20201028112159.GC27927@willie-the-truck>
References: <20201027215118.27003-1-will@kernel.org>
 <20201027215118.27003-3-will@kernel.org>
 <20201028111810.GC13345@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028111810.GC13345@gaia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 28, 2020 at 11:18:10AM +0000, Catalin Marinas wrote:
> On Tue, Oct 27, 2020 at 09:51:14PM +0000, Will Deacon wrote:
> > +bool system_has_mismatched_32bit_el0(void)
> > +{
> > +	u64 reg;
> > +	unsigned int fld;
> > +
> > +	if (!__allow_mismatched_32bit_el0)
> > +		return false;
> > +
> > +	reg = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
> > +	fld = cpuid_feature_extract_unsigned_field(reg, ID_AA64PFR0_EL0_SHIFT);
> > +	return fld == ID_AA64PFR0_EL0_64BIT_ONLY;
> > +}
> 
> Same here, this reports true even if no 32-bit is available (I have yet
> to go through the other patches to see how this function is used).

Same deal, really. We need to report true to deal with late-onlining.

Will
