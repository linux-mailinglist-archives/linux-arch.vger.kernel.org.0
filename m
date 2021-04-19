Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA3B3639E1
	for <lists+linux-arch@lfdr.de>; Mon, 19 Apr 2021 06:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbhDSEEs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Apr 2021 00:04:48 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53517 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233620AbhDSEEk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Apr 2021 00:04:40 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FNtVK6yHjz9vGS; Mon, 19 Apr 2021 14:04:09 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     luto@kernel.org, tglx@linutronix.de, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, avagin@gmail.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, vincenzo.frascino@arm.com,
        dima@arista.com
In-Reply-To: <cover.1617209141.git.christophe.leroy@csgroup.eu>
References: <cover.1617209141.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH RESEND v1 0/4] powerpc/vdso: Add support for time namespaces
Message-Id: <161880480562.1398509.1936824498391180839.b4-ty@ellerman.id.au>
Date:   Mon, 19 Apr 2021 14:00:05 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 31 Mar 2021 16:48:43 +0000 (UTC), Christophe Leroy wrote:
> [Sorry, resending with complete destination list, I used the wrong script on the first delivery]
> 
> This series adds support for time namespaces on powerpc.
> 
> All timens selftests are successfull.
> 
> Christophe Leroy (3):
>   lib/vdso: Mark do_hres_timens() and do_coarse_timens()
>     __always_inline()
>   lib/vdso: Add vdso_data pointer as input to
>     __arch_get_timens_vdso_data()
>   powerpc/vdso: Add support for time namespaces
> 
> [...]

Applied to powerpc/next.

[1/4] lib/vdso: Mark do_hres_timens() and do_coarse_timens() __always_inline()
      https://git.kernel.org/powerpc/c/58efe9f696cf908f40d6672aeca81cb2ad2bc762
[2/4] lib/vdso: Add vdso_data pointer as input to __arch_get_timens_vdso_data()
      https://git.kernel.org/powerpc/c/808094fcbf4196be0feb17afbbdc182ec95c8cec
[3/4] powerpc/vdso: Separate vvar vma from vdso
      https://git.kernel.org/powerpc/c/1c4bce6753857dc409a0197342d18764e7f4b741
[4/4] powerpc/vdso: Add support for time namespaces
      https://git.kernel.org/powerpc/c/74205b3fc2effde821b219d955c70e727dc43cc6

cheers
