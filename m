Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B1C294E41
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 16:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443278AbgJUOJv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 10:09:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443240AbgJUOJu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 10:09:50 -0400
Received: from gaia (unknown [95.145.162.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A79DB22249;
        Wed, 21 Oct 2020 14:09:48 +0000 (UTC)
Date:   Wed, 21 Oct 2020 15:09:46 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 4/4] arm64: Export id_aar64fpr0 via sysfs
Message-ID: <20201021140945.GD3976@gaia>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
 <20201021121559.GB3976@gaia>
 <20201021133316.GF8004@e123083-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021133316.GF8004@e123083-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 03:33:29PM +0200, Morten Rasmussen wrote:
> On Wed, Oct 21, 2020 at 01:15:59PM +0100, Catalin Marinas wrote:
> > one, though not as easy as automatic task placement by the scheduler (my
> > first preference, followed by the id_* regs and the aarch32 mask, though
> > not a strong preference for any).
> 
> Automatic task placement by the scheduler would mean giving up the
> requirement that the user-space affinity mask must always be honoured.
> Is that on the table?

I think Peter rejected it but I still find it a nicer interface from a
dumb application perspective. It may interact badly with cpusets though
(at least on Android).

> Killing aarch32 tasks with an empty intersection between the
> user-space mask and aarch32_mask is not really "automatic" and would
> require the aarch32 capability to be exposed anyway.

I agree, especially if overriding the user mask is not desirable. But if
one doesn't play around with cpusets, 32-bit apps would run "fine" with
the scheduler transparently placing them on the correct CPU.

Anyway, if the task placement is entirely off the table, the next thing
is asking applications to set their own mask and kill them if they do
the wrong thing. Here I see two possibilities for killing an app:

1. When it ends up scheduled on a non-AArch32-capable CPU

2. If the user cpumask (bar the offline CPUs) is not a subset of the
   aarch32_mask

Option 1 is simpler but 2 would be slightly more consistent.

There's also the question on whether the kernel should allow an ELF32 to
be loaded (and potentially killed subsequently) if the user mask is not
correct on execve().

-- 
Catalin
