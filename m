Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC6F6FEA27
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 05:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjEKDX1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 May 2023 23:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjEKDX0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 May 2023 23:23:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8CFF4;
        Wed, 10 May 2023 20:23:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QGy012TVHz4x4X;
        Thu, 11 May 2023 13:23:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1683775400;
        bh=segvorBuGekPc5jSCLXtWJe7pAKDaM/2mPQxUa2lvTw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mpN6WZbs8ze5YaIng5ERyTBY3chApO1uFrN1U1lTsRVA9HI18/rgyaG/eZmexoGi4
         xyNRjwovMhVVlZljbfexsALAQ/VC7SXFkLQXhGs4Bb0CKdQ9ZE7uWK8mAGQpR/wXnj
         Wj/Kq9bEbYeNfiJORTh/qbHavius2OrvxO8nKOQelnsk3QR4A3TJ4hsLhIW2fK+19D
         90D5YoD3X1p3CFTX+0ixP4wpazzRWLy7HTHBpgR9OBJW3WUEJ01CMuFyOW/rNQ/1o1
         jq40YmakA31zDnqwNmvC6KPPEIJRM2z/UjkLs2qgYubScN3CGu05cVDjwVg/DFcNT6
         LL1PDlPViTPUQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-api@vger.kernel.org,
        kernel-team@meta.com, linux-arch@vger.kernel.org,
        hannes@cmpxchg.org, richard.henderson@linaro.org,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux@armlinux.org.uk, geert@linux-m68k.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, davem@davemloft.net,
        chris@zankel.net, jcmvbkbc@gmail.com, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH] cachestat: wire up cachestat for other architectures
In-Reply-To: <20230510195806.2902878-1-nphamcs@gmail.com>
References: <20230510195806.2902878-1-nphamcs@gmail.com>
Date:   Thu, 11 May 2023 13:23:12 +1000
Message-ID: <874joja6vz.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Nhat Pham <nphamcs@gmail.com> writes:
> cachestat is previously only wired in for x86 (and architectures using
> the generic unistd.h table):
>
> https://lore.kernel.org/lkml/20230503013608.2431726-1-nphamcs@gmail.com/
>
> This patch wires cachestat in for all the other architectures.
>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  arch/alpha/kernel/syscalls/syscall.tbl      | 1 +
>  arch/arm/tools/syscall.tbl                  | 1 +
>  arch/ia64/kernel/syscalls/syscall.tbl       | 1 +
>  arch/m68k/kernel/syscalls/syscall.tbl       | 1 +
>  arch/microblaze/kernel/syscalls/syscall.tbl | 1 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl   | 1 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl   | 1 +
>  arch/mips/kernel/syscalls/syscall_o32.tbl   | 1 +
>  arch/parisc/kernel/syscalls/syscall.tbl     | 1 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    | 1 +

With the change to the selftest (see my other mail), I tested this on
powerpc and all tests pass.

Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)


cheers
