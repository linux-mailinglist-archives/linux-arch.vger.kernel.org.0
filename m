Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2DF406941
	for <lists+linux-arch@lfdr.de>; Fri, 10 Sep 2021 11:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhIJJq6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Sep 2021 05:46:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231916AbhIJJq6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Sep 2021 05:46:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3758610C7;
        Fri, 10 Sep 2021 09:45:45 +0000 (UTC)
Date:   Fri, 10 Sep 2021 10:45:42 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Marc Zyngier <maz@kernel.org>,
        Jade Alglave <jade.alglave@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH 0/4] Fix racing TLBI with ASID/VMID reallocation
Message-ID: <YTspRlASNfGWTdss@arm.com>
References: <20210806113109.2475-1-will@kernel.org>
 <753ff5ea79d54db0af83d195adcfa2b1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <753ff5ea79d54db0af83d195adcfa2b1@huawei.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 10, 2021 at 09:06:31AM +0000, Shameerali Kolothum Thodi wrote:
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/kernel-tla.git/commit/
> 
> I am going through the ASID TLA+ model and in the above commit, it appears that the
> different ASID check(=> ActiveAsid(c1) # ActiveAsid(c2)) for the Invariant
> UniqueASIDActiveTask is now removed.
> 
> Just wondering why that is not relevant anymore?

It's still relevant. I probably deleted it by mistake, I'll add it back
now. Thanks for carefully looking at this commit.

-- 
Catalin
