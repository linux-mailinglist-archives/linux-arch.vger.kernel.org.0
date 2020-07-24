Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE43822C652
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 15:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgGXNZO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 09:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbgGXNZO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 09:25:14 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032F8C0619D3
        for <linux-arch@vger.kernel.org>; Fri, 24 Jul 2020 06:25:14 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BCqgr20z3z9sTR; Fri, 24 Jul 2020 23:25:12 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-arch@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andreas Schwab <schwab@linux-m68k.org>
In-Reply-To: <20200716013522.338318-1-npiggin@gmail.com>
References: <20200716013522.338318-1-npiggin@gmail.com>
Subject: Re: [PATCH v3] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
Message-Id: <159559697191.1657499.15398729679167946534.b4-ty@ellerman.id.au>
Date:   Fri, 24 Jul 2020 23:25:12 +1000 (AEST)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 16 Jul 2020 11:35:22 +1000, Nicholas Piggin wrote:
> powerpc return from interrupt and return from system call sequences are
> context synchronising.

Applied to powerpc/next.

[1/1] powerpc: Select ARCH_HAS_MEMBARRIER_SYNC_CORE
      https://git.kernel.org/powerpc/c/2384b36f9156c3b815a5ce5f694edc5054ab7625

cheers
