Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFE428CE14
	for <lists+linux-arch@lfdr.de>; Tue, 13 Oct 2020 14:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgJMMQX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Oct 2020 08:16:23 -0400
Received: from foss.arm.com ([217.140.110.172]:59036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbgJMMQS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Oct 2020 08:16:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F9391FB;
        Tue, 13 Oct 2020 05:16:17 -0700 (PDT)
Received: from e107158-lin (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F3B43F719;
        Tue, 13 Oct 2020 05:16:16 -0700 (PDT)
Date:   Tue, 13 Oct 2020 13:16:13 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 1/3] arm64: kvm: Handle Asymmetric AArch32 systems
Message-ID: <20201013121613.qd7l5djaguletjgv@e107158-lin>
References: <20201008181641.32767-2-qais.yousef@arm.com>
 <7c058d22dce84ec7636863c1486b11d1@kernel.org>
 <20201009095857.cq3bmmobxeq3tm5z@e107158-lin.cambridge.arm.com>
 <63e379d1399b5c898828f6802ce3dca5@kernel.org>
 <20201009124817.i7u53qrntvu7l5zq@e107158-lin.cambridge.arm.com>
 <54379ee1-97b1-699b-9500-655164f2e083@arm.com>
 <8cdbcf81bae94f4b030e2906191d80af@kernel.org>
 <13eb5d05-9eaf-7640-cd44-cfd7f8820257@arm.com>
 <20201013115953.gepxn5dbzrk6x6ec@e107158-lin>
 <20fba6976710e00dc32164bf8af26164@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20fba6976710e00dc32164bf8af26164@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/13/20 13:09, Marc Zyngier wrote:
> On 2020-10-13 12:59, Qais Yousef wrote:
> > Thanks both.
> > 
> > So using the vcpu->arch.target = -1 is the best way forward. In my
> > experiments
> > when I did that I considered calling kvm_reset_vcpu() too, does it make
> > sense
> > to force the reset here too? Or too heavy handed?
> 
> No, userspace should know about it and take action if it wants too.
> Trying to fix it behind the scenes is setting expectations, which
> I'd really like to avoid.

Cool I thought so but I wanted to hear it directly :-)

Thanks!

--
Qais Yousef
