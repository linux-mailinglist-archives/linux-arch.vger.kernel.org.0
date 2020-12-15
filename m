Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DB82DAB93
	for <lists+linux-arch@lfdr.de>; Tue, 15 Dec 2020 12:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgLOLCo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Dec 2020 06:02:44 -0500
Received: from ozlabs.org ([203.11.71.1]:59401 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbgLOLCf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Dec 2020 06:02:35 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CwFh153ckz9sRR; Tue, 15 Dec 2020 22:01:53 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Boqun Feng <boqun.feng@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20201111110723.3148665-1-npiggin@gmail.com>
References: <20201111110723.3148665-1-npiggin@gmail.com>
Subject: Re: [PATCH 0/3] powerpc: convert to use ARCH_ATOMIC
Message-Id: <160803006828.517022.11653746040201770780.b4-ty@ellerman.id.au>
Date:   Tue, 15 Dec 2020 22:01:53 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 11 Nov 2020 21:07:20 +1000, Nicholas Piggin wrote:
> This conversion seems to require generic atomic64 changes, looks
> like nothing else uses ARCH_ATOMIC and GENERIC_ATOMIC64 yet.
> 
> Thanks,
> Nick
> 
> Nicholas Piggin (3):
>   asm-generic/atomic64: Add support for ARCH_ATOMIC
>   powerpc/64s/iommu: don't use atomic_ function on atomic64_t type
>   powerpc: rewrite atomics to use ARCH_ATOMIC
> 
> [...]

Patch 2 applied to powerpc/next.

[2/3] powerpc/64s/iommu: Don't use atomic_ function on atomic64_t type
      https://git.kernel.org/powerpc/c/c33cd1ed60013ec2ae50f91fed260def5f1d9851

cheers
