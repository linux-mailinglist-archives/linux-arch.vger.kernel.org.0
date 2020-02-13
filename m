Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5D4D15BD9E
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 12:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgBMLXu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 06:23:50 -0500
Received: from foss.arm.com ([217.140.110.172]:45242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbgBMLXu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Feb 2020 06:23:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FE651FB;
        Thu, 13 Feb 2020 03:23:50 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6ACBA3F6CF;
        Thu, 13 Feb 2020 03:23:48 -0800 (PST)
Date:   Thu, 13 Feb 2020 11:23:46 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Kortchinsky <kostyak@google.com>,
        Kostya Serebryany <kcc@google.com>
Subject: Re: [PATCH 00/22] arm64: Memory Tagging Extension user-space support
Message-ID: <20200213112346.GA639258@arrakis.emea.arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
 <CAMn1gO6f4UUdhBe1sfiAPBW=zr-C3ypUv-Pwgx=wvmJjp4xfyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMn1gO6f4UUdhBe1sfiAPBW=zr-C3ypUv-Pwgx=wvmJjp4xfyA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 13, 2019 at 10:05:10AM -0800, Peter Collingbourne wrote:
> On Wed, Dec 11, 2019 at 10:40 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > This series proposes the initial user-space support for the ARMv8.5
> > Memory Tagging Extension [1].
> 
> Thanks for sending out this series. I have been testing it on Android
> with the FVP model and my in-development scudo changes that add memory
> tagging support [1], and have not noticed any problems so far.

Thanks for the comments so far and the testing. I'll post a v2 next
week.

> > - Clarify whether mmap(tagged_addr, PROT_MTE) pre-tags the memory with
> >   the tag given in the tagged_addr hint. Strong justification is
> >   required for this as it would force arm64 to disable the zero page.
> 
> We would like to use this feature in scudo to tag large (>128KB on
> Android) allocations, which are currently allocated via mmap rather
> than from an allocation pool. Otherwise we would need to pay the cost
> (perf and RSS) of faulting all of their pages at allocation time
> instead of on demand, if we want to tag them.

Would the default tag of 0 be sufficient here? We disable match-all for
user-space already, so 0 is not a wildcard.

-- 
Catalin
