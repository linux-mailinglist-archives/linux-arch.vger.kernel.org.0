Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A62D15ADF7
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 18:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgBLRDz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 12:03:55 -0500
Received: from foss.arm.com ([217.140.110.172]:35314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgBLRDz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Feb 2020 12:03:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CF6630E;
        Wed, 12 Feb 2020 09:03:54 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80FD73F68F;
        Wed, 12 Feb 2020 09:03:52 -0800 (PST)
Date:   Wed, 12 Feb 2020 17:03:50 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm64: mte: Clear SCTLR_EL1.TCF0 on exec
Message-ID: <20200212170350.GB587247@arrakis.emea.arm.com>
References: <CAMn1gO4iv1FsxV+aR3CgU=jgmVjHL0YQF-xJJG0UMv3nJZnOBw@mail.gmail.com>
 <20191220014853.223389-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191220014853.223389-1-pcc@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 19, 2019 at 05:48:53PM -0800, Peter Collingbourne wrote:
> On Thu, Dec 19, 2019 at 12:32 PM Peter Collingbourne <pcc@google.com> wrote:
> > On Wed, Dec 11, 2019 at 10:45 AM Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > > +       if (current->thread.sctlr_tcf0 != next->thread.sctlr_tcf0)
> > > +               update_sctlr_el1_tcf0(next->thread.sctlr_tcf0);
> >
> > I don't entirely understand why yet, but I've found that this check is
> > insufficient for ensuring consistency between SCTLR_EL1.TCF0 and
> > sctlr_tcf0. In my Android test environment with some processes having
> > sctlr_tcf0=SCTLR_EL1_TCF0_SYNC and others having sctlr_tcf0=0, I am
> > seeing intermittent tag failures coming from the sctlr_tcf0=0
> > processes. With this patch:
[...]
> > Since sysreg_clear_set only sets the sysreg if it ended up changing, I
> > wouldn't expect this to cause a significant performance hit unless
> > just reading SCTLR_EL1 is expensive. That being said, if the
> > inconsistency is indicative of a deeper problem, we should probably
> > address that.
> 
> I tracked it down to the flush_mte_state() function setting sctlr_tcf0 but
> failing to update SCTLR_EL1.TCF0. With this patch I am not seeing any more
> inconsistencies.

Thanks Peter. I folded in your fix.

-- 
Catalin
