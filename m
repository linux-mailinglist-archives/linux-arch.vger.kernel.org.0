Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522361B77A4
	for <lists+linux-arch@lfdr.de>; Fri, 24 Apr 2020 15:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgDXN5o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Apr 2020 09:57:44 -0400
Received: from foss.arm.com ([217.140.110.172]:35116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgDXN5o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Apr 2020 09:57:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EA7931B;
        Fri, 24 Apr 2020 06:57:44 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67B803F68F;
        Fri, 24 Apr 2020 06:57:42 -0700 (PDT)
Date:   Fri, 24 Apr 2020 14:57:36 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Rob Herring <Rob.Herring@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>
Subject: Re: [PATCH v3 21/23] arm64: mte: Check the DT memory nodes for MTE
 support
Message-ID: <20200424135735.GB5551@gaia>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-22-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421142603.3894-22-catalin.marinas@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 21, 2020 at 03:26:01PM +0100, Catalin Marinas wrote:
> Even if the ID_AA64PFR1_EL1 register advertises the presence of MTE, it
> is not guaranteed that the memory system on the SoC supports the
> feature. In the absence of system-wide MTE support, the behaviour is
> undefined and the kernel should not enable the MTE memory type in
> MAIR_EL1.
> 
> For FDT, add an 'arm,armv8.5-memtag' property to the /memory nodes and
> check for its presence during MTE probing. For example:
> 
> 	memory@80000000 {
> 		device_type = "memory";
> 		arm,armv8.5-memtag;
> 		reg = <0x00000000 0x80000000 0 0x80000000>,
> 		      <0x00000008 0x80000000 0 0x80000000>;
> 	};
> 
> If the /memory nodes are not present in DT or if at least one node does
> not support MTE, the feature will be disabled. On EFI systems, it is
> assumed that the memory description matches the EFI memory map (if not,
> it is considered a firmware bug).
> 
> MTE is not currently supported on ACPI systems.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Rob Herring <Rob.Herring@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>

This patch turns out to be incomplete. While it does not expose the
HWCAP2_MTE to user when the above DT property is not present, it still
allows user access to the ID_AA64PFR1_EL1.MTE field (via MRS emulations)
since it is marked as visible.

-- 
Catalin
