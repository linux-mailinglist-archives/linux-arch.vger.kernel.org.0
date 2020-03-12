Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DADD8182CB5
	for <lists+linux-arch@lfdr.de>; Thu, 12 Mar 2020 10:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgCLJu1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Mar 2020 05:50:27 -0400
Received: from foss.arm.com ([217.140.110.172]:59726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgCLJu0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Mar 2020 05:50:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 675A31FB;
        Thu, 12 Mar 2020 02:50:26 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D92E83F67D;
        Thu, 12 Mar 2020 02:50:24 -0700 (PDT)
Date:   Thu, 12 Mar 2020 09:50:22 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Richard Henderson <richard.henderson@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 19/19] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200312095022.GA5801@mbp>
References: <20200226180526.3272848-1-catalin.marinas@arm.com>
 <20200226180526.3272848-20-catalin.marinas@arm.com>
 <0857cca0-9f75-398d-e755-f645d2d8a594@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0857cca0-9f75-398d-e755-f645d2d8a594@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 11, 2020 at 03:17:54PM -0700, Richard Henderson wrote:
> On 2/26/20 10:05 AM, Catalin Marinas wrote:
> > +    /*
> > +     * From include/uapi/linux/prctl.h
> > +     */
> > +    #define PR_SET_TAGGED_ADDR_CTRL 55
> > +    #define PR_GET_TAGGED_ADDR_CTRL 56
> > +    # define PR_TAGGED_ADDR_ENABLE  (1UL << 0)
> > +    # define PR_MTE_TCF_SHIFT       1
> > +    # define PR_MTE_TCF_NONE        (0UL << PR_MTE_TCF_SHIFT)
> > +    # define PR_MTE_TCF_SYNC        (1UL << PR_MTE_TCF_SHIFT)
> > +    # define PR_MTE_TCF_ASYNC       (2UL << PR_MTE_TCF_SHIFT)
> > +    # define PR_MTE_TCF_MASK        (3UL << PR_MTE_TCF_SHIFT)
> > +    # define PR_MTE_TAG_SHIFT       3
> > +    # define PR_MTE_TAG_MASK        (0xffffUL << PR_MTE_TAG_SHIFT)
> 
> Is there a reason not to include TCMA into the set of bits that userland can
> control with this prcrl?
> 
> I know that ordinarily TCR_ELx requires expensive syncing, but for this
> particular field there is a note about "software may change this control bit on
> a context switch".  Which I take to mean that the usual TLB-related syncing may
> be omitted.

TCMA (unlike TCF) is allowed to be cached in the TLB. If we are to allow
the user to configure this field, there are two approaches, each with
its own problems:

1. per-thread TCMA (as we do with TCF). Since the field is cached in the
   TLB (ASID-tagged), we'd have to invalidate the TLB for that ASID
   every time we switch between threads of the same process on a CPU.

2. per-process TCMA. This solves the problem of TLB invalidation,
   however you'd have to synchronise all the threads that may run on
   other CPUs. A simple IPI (as in sys_membarrier() for example) is not
   sufficient since with CnP (CPU threads sharing the TLB) we'd need a
   synchronous update. This leaves us with a stop_machine() call and I'm
   not keen on exposing this to user via a syscall.

If you have a strong need for TCMA in user space, please raise it and we
can discuss about always allowing match-all tags for user tasks. Note
that the kernel will have match-all enabled for kernel addresses.

-- 
Catalin
