Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59DB82BF2D
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2019 08:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfE1GT0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 May 2019 02:19:26 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57471 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfE1GT0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 May 2019 02:19:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45CkFj2vzbz9s00;
        Tue, 28 May 2019 16:19:21 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     vincenzo.frascino@arm.com,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 3/3] kselftest: Extend vDSO selftest to clock_getres
In-Reply-To: <20190523112116.19233-4-vincenzo.frascino@arm.com>
References: <20190523112116.19233-1-vincenzo.frascino@arm.com> <20190523112116.19233-4-vincenzo.frascino@arm.com>
Date:   Tue, 28 May 2019 16:19:21 +1000
Message-ID: <87lfyrp0d2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Vincenzo Frascino <vincenzo.frascino@arm.com> writes:

> The current version of the multiarch vDSO selftest verifies only
> gettimeofday.
>
> Extend the vDSO selftest to clock_getres, to verify that the
> syscall and the vDSO library function return the same information.
>
> The extension has been used to verify the hrtimer_resoltion fix.

This is passing for me even without patch 1 applied, shouldn't it fail
without the fix? What am I missing?

# uname -r
5.2.0-rc2-gcc-8.2.0

# ./vdso_clock_getres
clock_id: CLOCK_REALTIME [PASS]
clock_id: CLOCK_BOOTTIME [PASS]
clock_id: CLOCK_TAI [PASS]
clock_id: CLOCK_REALTIME_COARSE [PASS]
clock_id: CLOCK_MONOTONIC [PASS]
clock_id: CLOCK_MONOTONIC_RAW [PASS]
clock_id: CLOCK_MONOTONIC_COARSE [PASS]

cheers

> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>
> Note: This patch is independent from the others in this series, hence it
> can be merged singularly by the kselftest maintainers.
>
>  tools/testing/selftests/vDSO/Makefile         |   2 +
>  .../selftests/vDSO/vdso_clock_getres.c        | 124 ++++++++++++++++++
>  2 files changed, 126 insertions(+)
>  create mode 100644 tools/testing/selftests/vDSO/vdso_clock_getres.c
