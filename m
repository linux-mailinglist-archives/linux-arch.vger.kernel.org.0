Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AED92A0B05
	for <lists+linux-arch@lfdr.de>; Fri, 30 Oct 2020 17:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgJ3QYZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Oct 2020 12:24:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgJ3QYZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Oct 2020 12:24:25 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04EAD2083B;
        Fri, 30 Oct 2020 16:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604075064;
        bh=35pFo6MvmFEoU2yJ7e0M2UeTwxoblUxK1NKRVX+1ouI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ns4ZmJvVr2OIm0C4Si+V4GvXNidYwGlWsLoG7uQ74XbavuMfNGymwLoDBv8u32CtJ
         t3mDS1/tsI3a14TnKkKdjcOWQSUHAJU3tVm7ilxU9p2t1bQPHT0GUzvmsYhghnJXZG
         UsGf57DIVomY4w5IlnwCnPuZBQa4+aaTNIuu0BYQ=
Date:   Fri, 30 Oct 2020 16:24:19 +0000
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com,
        Qais Yousef <qais.yousef@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-arch@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 0/6] An alternative series for asymmetric AArch32 systems
Message-ID: <20201030162419.GB32700@willie-the-truck>
References: <20201027215118.27003-1-will@kernel.org>
 <160407459118.3016487.12247105988100320673.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160407459118.3016487.12247105988100320673.b4-ty@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 30, 2020 at 04:16:48PM +0000, Marc Zyngier wrote:
> On Tue, 27 Oct 2020 21:51:12 +0000, Will Deacon wrote:
> > I was playing around with the asymmetric AArch32 RFCv2 from Qais:
> > 
> > https://lore.kernel.org/r/20201021104611.2744565-1-qais.yousef@arm.com
> > 
> > and ended up writing my own implementation this afternoon. I think it's
> > smaller, simpler and easier to work with. In particular:
> > 
> > [...]
> 
> Applied to next, thanks!
> 
> [1/1] KVM: arm64: Handle Asymmetric AArch32 systems
>       commit: 22f553842b14a1289c088a79a67fb479d3fa2a4e

Got to be honest, this gave me a heart attack at first! First patch is
good though, just please don't apply the rest of this stuff :)

Will
