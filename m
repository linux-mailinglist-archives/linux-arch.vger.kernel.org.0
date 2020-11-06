Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB6E2A97A3
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 15:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgKFOa0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 09:30:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgKFOa0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Nov 2020 09:30:26 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D984120719;
        Fri,  6 Nov 2020 14:30:23 +0000 (UTC)
Date:   Fri, 6 Nov 2020 14:30:21 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [PATCH 2/6] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <20201106143020.GG29329@gaia>
References: <20201028112206.GD13345@gaia>
 <20201028112343.GD27927@willie-the-truck>
 <20201028114945.GE13345@gaia>
 <20201028124049.GC28091@willie-the-truck>
 <20201028185620.GK13345@gaia>
 <20201029222048.GD31375@willie-the-truck>
 <20201030111846.GC23196@gaia>
 <20201030161353.GC32582@willie-the-truck>
 <20201102114444.GC21082@gaia>
 <20201105213846.GA8600@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105213846.GA8600@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 05, 2020 at 09:38:46PM +0000, Will Deacon wrote:
> Ok. Then we're in agreement about not preventing late-onlining. The problem
> then is that the existing 32-bit EL0 capability is a SYSTEM cap so even with
> your diff, we still have an issue if you boot on the CPUs that support
> 32-bit and then try to online a 64-bit-only core (it will fail).

Ah, I focussed too much on the 32-bit capable CPUs coming up late. In my
original hack, I made the capability weak based on the config option.
Here we want to make it weak based on cmdline but that structure is
const (we could remove the const though).

> So I think we do need my changes to the existing cap, but perhaps we
> could return false from system_supports_32bit_el0() until we've actually
> seen a 32-bit capable core. That way you would keep the existing behaviour
> on TX2, and we wouldn't get any unusual late-onlining failures.

If we see the first 32-bit capable core late, we may report it's
available but no proper hwcaps.

We could do a combination of a new weak feature together with your
always-on 32-bit feature when forced by the cmdline. So the system would
support 32-bit if both the system feature (with the detection override)
and the asym one are set.

However, I think it may be simpler if we made the current feature weak
(so no new one) together with a bool somewhere that tells us if we found
a CPU that doesn't have 32-bit (asym mode). system_supports_32bit_el0()
would check if the cap is set together with (!asym_found ||
asym_allowed).

-- 
Catalin
