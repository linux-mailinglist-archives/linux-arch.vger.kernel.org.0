Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAC7262DEF
	for <lists+linux-arch@lfdr.de>; Wed,  9 Sep 2020 13:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgIILf2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Sep 2020 07:35:28 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:47679 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgIILfU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Sep 2020 07:35:20 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MG9Xu-1kJCr04Bbw-00GaHP; Wed, 09 Sep 2020 13:27:15 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/23] Use asm-generic for mmu_context no-op functions
Date:   Wed,  9 Sep 2020 13:27:08 +0200
Message-Id: <159965079776.3591084.10754647036857628984.b4-ty@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7OMazxQ6DY8MEF6H/bZ/vvXzzHh3+g8R4o0uC3slmdaoHjeIgYq
 yYLMHXATL1HlHzETUxMec1heCWdAqn5Xbe34Z7iqBpu9Y+QREbqvwyqSFWcQXq6+OkYWUq4
 mlJxy2fwrK+/O2uwi47EP5zNbeaSwyCVP23+DW/IriB8kDIZHKFD40PKK96QjJV0N2KRzcV
 XgsmqvhStI+/vCfKlCM9A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OjSenc/nRNM=:sHJgLO55eTJMx1tettct0G
 U/ClkE6lo+ihElHXkhFWDzUhVTAAR5gjMe0sFNgxxcyMiFpjZB2rENTKO/6ddFDuqZ3A+9C1+
 CdcwFmxt6d5HuCEJuoEwNlDnb6D8kAXtKrZAxiIZ5iAe3/fjU33hmkLs15R/PMDUoDBGlhGL0
 St7NG+iSmQpf7w2nQ+PaEI/hCjlHJ00RVyDMkLk7FyQRimEdR+WZMHgDyvWWMNmxvPigQq+8m
 MaFMGfvho9GryNJm70o8JAFQAwtYy7jouv6RbZLi0GAh3me615Fdh+4iQPku1GcGkwBm9zW/a
 dZKwr/SQjnCYSP+ZZfEYfI9K0ro8xCanREpc4Ae9U0JK7fb1KdBY/3B7lJXugyF2rD27piobk
 rBVP7h5AdXxFVj+B9umczLfqT/krw4M5h1cvmkcbppjqptc4gnAFXd6BKZxvxETRsWC9wQqsz
 Fi/x/dHMTMKH1GC/ZABmMyDlDgmqKGTocCLl7oylXETp+rIKSnSMlVQcBAjlsmWnJijOTYUj+
 bPF4Kym/l21MJIaENgxENHu3CQ7Gb2Z68jcrrNvOasCrYAKxaCzV8OaZp48Y8vAgRXiHVH03g
 YcAmAU/cFBZ6/OMngwO10bkIqBbM45GP4dciPF+LKKtE/WS08AUs3hPykj7s+HpaEntswS3Eg
 ETWZP6yCowZLwzUSFCyeExLeMcmZf5NjdWXcO6Oex7Hgo/9kByuaZsluM43f0LRy+L3t5pUCr
 SWji5U0Cq1tm+X4skTmXimLd+AB4mgPkuhiwhZwbLiilbji2doD2oiDWx0ucLyp7QOi2Oi6mc
 DpOdgvH/qLWAD96HBRtP86lgs5MqXP4LZaiNCmm8ztc1rpqKK8GYRuepxRVP0AYezbXASPx
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2 Sep 2020 00:15:16 +1000, Nicholas Piggin wrote:
> It would be nice to be able to modify mmu_context functions or add a
> hook without updating all architectures, many of which will be no-ops.
> 
> The motivation for this series is a change to lazy mmu handling, but
> this series stands on its own as a good cleanup whether or not we end
> up making that change.
> 
> [...]

Applied to asm-generic, thanks!

[01/23] asm-generic: add generic MMU versions of mmu context functions
        (no commit info)
[02/23] alpha: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[03/23] arc: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[04/23] arm: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[05/23] arm64: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[06/23] csky: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[07/23] hexagon: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[08/23] ia64: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[09/23] m68k: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[10/23] microblaze: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[11/23] mips: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[12/23] nds32: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[13/23] nios2: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[14/23] openrisc: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[15/23] parisc: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[16/23] powerpc: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[17/23] riscv: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[18/23] s390: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[19/23] sh: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[20/23] sparc: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[21/23] um: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[22/23] x86: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)
[23/23] xtensa: use asm-generic/mmu_context.h for no-op implementations
        (no commit info)

       Arnd
