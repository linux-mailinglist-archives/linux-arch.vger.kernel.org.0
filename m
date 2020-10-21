Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27C9294DA5
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 15:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438856AbgJUNde (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 09:33:34 -0400
Received: from foss.arm.com ([217.140.110.172]:35472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410081AbgJUNdd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 09:33:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55C5431B;
        Wed, 21 Oct 2020 06:33:33 -0700 (PDT)
Received: from e123083-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8BD93F66B;
        Wed, 21 Oct 2020 06:33:31 -0700 (PDT)
Date:   Wed, 21 Oct 2020 15:33:29 +0200
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 4/4] arm64: Export id_aar64fpr0 via sysfs
Message-ID: <20201021133316.GF8004@e123083-lin>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
 <20201021121559.GB3976@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021121559.GB3976@gaia>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 01:15:59PM +0100, Catalin Marinas wrote:
> one, though not as easy as automatic task placement by the scheduler (my
> first preference, followed by the id_* regs and the aarch32 mask, though
> not a strong preference for any).

Automatic task placement by the scheduler would mean giving up the
requirement that the user-space affinity mask must always be honoured.
Is that on the table?

Killing aarch32 tasks with an empty intersection between the user-space
mask and aarch32_mask is not really "automatic" and would require the
aarch32 capability to be exposed anyway.

Morten
