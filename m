Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5F7715A82F
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 12:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgBLLpV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 06:45:21 -0500
Received: from foss.arm.com ([217.140.110.172]:59952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbgBLLpV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Feb 2020 06:45:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59E9A30E;
        Wed, 12 Feb 2020 03:45:21 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09B723F68F;
        Wed, 12 Feb 2020 03:45:19 -0800 (PST)
Date:   Wed, 12 Feb 2020 11:45:17 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kevin Brodsky <kevin.brodsky@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 19/22] arm64: mte: Allow user control of the tag check
 mode via prctl()
Message-ID: <20200212114517.GF488264@arrakis.emea.arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
 <20191211184027.20130-20-catalin.marinas@arm.com>
 <cdd9d203-00c8-0a63-69b5-66234c0e9d9a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdd9d203-00c8-0a63-69b5-66234c0e9d9a@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 27, 2019 at 02:34:32PM +0000, Kevin Brodsky wrote:
> Not just related to this patch, but here goes. While trying to debug an
> MTE-enabled process, I realised that there's no way to tell the tagged addr
> / MTE thread configuration from outside of the thread. At this point I
> thought it'd be really nice if this were to be exposed in /proc/pid, maybe
> in /proc/pid/status. Unfortunately there seems to be no precedent for an
> arch-specific feature to be exposed there. I guess a ptrace call would work
> as well, although it wouldn't be as practical without using a debugger.

There is proc_pid_arch_status(), currently only used by x86 to report
the avx512 status. We could do the same on arm64 and provide information
information on the MTE status, SVE configuration, ptrauth. I think this
can be a separate patch covering all these.

-- 
Catalin
