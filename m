Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A961C3D77
	for <lists+linux-arch@lfdr.de>; Mon,  4 May 2020 16:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgEDOrx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 May 2020 10:47:53 -0400
Received: from foss.arm.com ([217.140.110.172]:46512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgEDOrx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 May 2020 10:47:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 881211FB;
        Mon,  4 May 2020 07:47:52 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 018C53F305;
        Mon,  4 May 2020 07:47:50 -0700 (PDT)
Date:   Mon, 4 May 2020 15:47:44 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 01/23] arm64: alternative: Allow alternative_insn to
 always issue the first instruction
Message-ID: <20200504144743.GB2884@gaia>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-2-catalin.marinas@arm.com>
 <20200427165737.GD15808@arm.com>
 <20200428114354.GE3868@gaia>
 <20200429102600.GA30377@arm.com>
 <20200429140425.GC10651@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429140425.GC10651@gaia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 29, 2020 at 03:04:25PM +0100, Catalin Marinas wrote:
> From 73f3869cb68fab1505d7b400ae8a39a19c5fc9e9 Mon Sep 17 00:00:00 2001
> From: Catalin Marinas <catalin.marinas@arm.com>
> Date: Wed, 27 Nov 2019 09:07:30 +0000
> Subject: [PATCH] arm64: alternative: Always emit the first instruction in
>  ALTERNATIVE blocks
> 
> Currently with the ALTERNATIVE macro or alternative_insn, the cfg (or
> enable) arguments disable the entire asm block. Change the macros to
> only omit the alternative block on !IS_ENABLED(cfg). In addition, remove
> the cfg arguments to to ALTERNATIVE in those few calls where it is still
> passed. There is no change to the resulting kernel image with defconfig.
> 
> alternative_insn's enable argument will be used in a subsequent patch
> and we are keeping the ALTERNATIVE C macro arguments in line with the
> asm version.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>

I no longer need this patch as I moved the page tag zeroing from
clear_page to the actual mte.S file (called via set_pte_at()). So don't
bother reviewing this.

-- 
Catalin
