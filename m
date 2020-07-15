Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC747220196
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jul 2020 03:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgGOBEc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jul 2020 21:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgGOBEc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 21:04:32 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE82C061755;
        Tue, 14 Jul 2020 18:04:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B5zgH5lGlz9sQt;
        Wed, 15 Jul 2020 11:04:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1594775068;
        bh=DRW9yi5rJrMkAE9FJwWBtPJ4PTfLdPhmlR2SiTJPUEA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WwupWKzZobPRuA0ewfQ/OibLdE136XZAxIa6okCeJFSZDbAOw/ndIILKb5eMGYCkY
         zHhUoRY/HBoO/u7mhE256GPlkDqO7dzJwO9S3/JM6Wlzm509/x6ZSNqD6yFyr0E3pr
         tMQlga8blXrq4k1TCuRJYTO5WNX8EnD85h6WLusGlw241MRKDzTGFt/AdxNJjkAXe+
         ixTMKNB6sGuB/35Yx/+fubQLUq+s1LANQJpO/VRS1wTcCGjSUyGxW/RJxc6dFtwFVl
         hsvo5DxpXVwVHbqXrNveC3J7JJMB5S/HkD5xRJeETKKxfGGKxPh4nXzlGzkkInSc5E
         /tRwbikclFpbw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, nathanl@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com,
        luto@kernel.org, linux-arch@vger.kernel.org,
        Tulio Magno Quites Machado Filho <tuliom@linux.ibm.com>
Subject: Re: [PATCH v8 5/8] powerpc/vdso: Prepare for switching VDSO to generic C implementation.
In-Reply-To: <2a67c333893454868bbfda773ba4b01c20272a5d.1588079622.git.christophe.leroy@c-s.fr>
References: <cover.1588079622.git.christophe.leroy@c-s.fr> <2a67c333893454868bbfda773ba4b01c20272a5d.1588079622.git.christophe.leroy@c-s.fr>
Date:   Wed, 15 Jul 2020 11:04:26 +1000
Message-ID: <878sflvbad.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Prepare for switching VDSO to generic C implementation in following
> patch. Here, we:
> - Modify __get_datapage() to take an offset
> - Prepare the helpers to call the C VDSO functions
> - Prepare the required callbacks for the C VDSO functions
> - Prepare the clocksource.h files to define VDSO_ARCH_CLOCKMODES
> - Add the C trampolines to the generic C VDSO functions
>
> powerpc is a bit special for VDSO as well as system calls in the
> way that it requires setting CR SO bit which cannot be done in C.
> Therefore, entry/exit needs to be performed in ASM.
>
> Implementing __arch_get_vdso_data() would clobber the link register,
> requiring the caller to save it. As the ASM calling function already
> has to set a stack frame and saves the link register before calling
> the C vdso function, retriving the vdso data pointer there is lighter.
...

> diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
> new file mode 100644
> index 000000000000..4452897f9bd8
> --- /dev/null
> +++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
> @@ -0,0 +1,175 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_VDSO_GETTIMEOFDAY_H
> +#define __ASM_VDSO_GETTIMEOFDAY_H
> +
> +#include <asm/ptrace.h>
> +
> +#ifdef __ASSEMBLY__
> +
> +.macro cvdso_call funct
> +  .cfi_startproc
> +	PPC_STLU	r1, -STACK_FRAME_OVERHEAD(r1)
> +	mflr		r0
> +  .cfi_register lr, r0
> +	PPC_STL		r0, STACK_FRAME_OVERHEAD + PPC_LR_STKOFF(r1)

This doesn't work for me on ppc64(le) with glibc.

glibc doesn't create a stack frame before making the VDSO call, so the
store of r0 (LR) goes into the caller's frame, corrupting the saved LR,
leading to an infinite loop.

This is an example from a statically built program that calls
clock_gettime():

0000000010030cb0 <__clock_gettime>:
    10030cb0:   0e 10 40 3c     lis     r2,4110
    10030cb4:   00 7a 42 38     addi    r2,r2,31232
    10030cb8:   a6 02 08 7c     mflr    r0
    10030cbc:   ff ff 22 3d     addis   r9,r2,-1
    10030cc0:   58 6d 29 39     addi    r9,r9,27992
    10030cc4:   f0 ff c1 fb     std     r30,-16(r1)			<-- redzone store
    10030cc8:   78 23 9e 7c     mr      r30,r4
    10030ccc:   f8 ff e1 fb     std     r31,-8(r1)			<-- redzone store
    10030cd0:   78 1b 7f 7c     mr      r31,r3
    10030cd4:   10 00 01 f8     std     r0,16(r1)			<-- save LR to caller's frame
    10030cd8:   00 00 09 e8     ld      r0,0(r9)
    10030cdc:   00 00 20 2c     cmpdi   r0,0
    10030ce0:   50 00 82 41     beq     10030d30 <__clock_gettime+0x80>
    10030ce4:   a6 03 09 7c     mtctr   r0
    10030ce8:   21 04 80 4e     bctrl					<-- vdso call
    10030cec:   26 00 00 7c     mfcr    r0
    10030cf0:   00 10 09 74     andis.  r9,r0,4096
    10030cf4:   78 1b 69 7c     mr      r9,r3
    10030cf8:   28 00 82 40     bne     10030d20 <__clock_gettime+0x70>
    10030cfc:   b4 07 23 7d     extsw   r3,r9
    10030d00:   10 00 01 e8     ld      r0,16(r1)			<-- load saved LR, since clobbered by the VDSO
    10030d04:   f0 ff c1 eb     ld      r30,-16(r1)
    10030d08:   f8 ff e1 eb     ld      r31,-8(r1)
    10030d0c:   a6 03 08 7c     mtlr    r0				<-- restore LR
    10030d10:   20 00 80 4e     blr					<-- jumps to 10030cec


I'm kind of confused how it worked for you on 32-bit.

There's also no code to load/restore the TOC pointer on BE, which I
think we'll need to handle.

cheers
