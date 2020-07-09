Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21017219D0D
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 12:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgGIKJT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 06:09:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43361 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgGIKJS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Jul 2020 06:09:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B2X2f6tyhz9sSd;
        Thu,  9 Jul 2020 20:09:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1594289355;
        bh=B+pvOdRR00uR6MW/d9Tg/MIy1GpvfDv7HP5aB55eLMw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kxRBUjVzQLmCVjdHJKK+OcMHo6neU1RQex6N/x2BrSSEzz8iH/g7k4DoVMlUhjVk7
         qjlMzJqNzIPeCAL4m8bkMuCl1Dr7W0UwucYzh02G9a/78uSyNSp/rFzURUfJIof5xH
         rvrxbDJUq5MJV/BQwK0VcLmyEvCImjHGLb+/cWWbDQYBeOaA4oQ2CL3X3APXF6/y2J
         D2L/vyTlEu1jwKOp2V1ztZHSpC9pxYI9LfxuGcgX3zR3P6RAS/67QId4q+XfV3yQtt
         K7ocKhOlTOWEa7eB+mqmgAgCqXAnWX3PTuHX9vuE8pgXODpslKd4pTMDt2KQ2hnq7g
         Rlwx0t1IcWGFQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 2/6] powerpc/pseries: move some PAPR paravirt functions to their own file
In-Reply-To: <20200706043540.1563616-3-npiggin@gmail.com>
References: <20200706043540.1563616-1-npiggin@gmail.com> <20200706043540.1563616-3-npiggin@gmail.com>
Date:   Thu, 09 Jul 2020 20:11:29 +1000
Message-ID: <87d055vvzi.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:
>

Little bit of changelog would be nice :D

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/paravirt.h | 61 +++++++++++++++++++++++++++++
>  arch/powerpc/include/asm/spinlock.h | 24 +-----------
>  arch/powerpc/lib/locks.c            | 12 +++---
>  3 files changed, 68 insertions(+), 29 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/paravirt.h
>
> diff --git a/arch/powerpc/include/asm/paravirt.h b/arch/powerpc/include/asm/paravirt.h
> new file mode 100644
> index 000000000000..7a8546660a63
> --- /dev/null
> +++ b/arch/powerpc/include/asm/paravirt.h
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef __ASM_PARAVIRT_H
> +#define __ASM_PARAVIRT_H

Should be _ASM_POWERPC_PARAVIRT_H

> +#ifdef __KERNEL__

We shouldn't need __KERNEL__ in here, it's not a uapi header.

cheers
