Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982DD35AE4A
	for <lists+linux-arch@lfdr.de>; Sat, 10 Apr 2021 16:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbhDJO3q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Apr 2021 10:29:46 -0400
Received: from ozlabs.org ([203.11.71.1]:42989 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234392AbhDJO3q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 10 Apr 2021 10:29:46 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FHcp23yX0z9sWP; Sun, 11 Apr 2021 00:29:30 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        cmr@codefail.de, Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org
In-Reply-To: <cover.1616151715.git.christophe.leroy@csgroup.eu>
References: <cover.1616151715.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 00/10] Convert signal32 to user read access by block
Message-Id: <161806493285.1467223.5574270316923753261.b4-ty@ellerman.id.au>
Date:   Sun, 11 Apr 2021 00:28:52 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 19 Mar 2021 11:06:49 +0000 (UTC), Christophe Leroy wrote:
> Similarly to the work done earlier with writes, this series
> converts signal32 to using user_read_access_begin/end and
> unsafe_get_user() and friends.
> 
> Applies on to of the signal64 series, ie on merge-test (ca6e327fefb2)
> 
> Christophe Leroy (10):
>   signal: Add unsafe_get_compat_sigset()
>   powerpc/uaccess: Also perform 64 bits copies in
>     unsafe_copy_from_user() on ppc32
>   powerpc/signal: Add unsafe_copy_ck{fpr/vsx}_from_user
>   powerpc/signal32: Rename save_user_regs_unsafe() and
>     save_general_regs_unsafe()
>   powerpc/signal32: Remove ifdefery in middle of if/else in sigreturn()
>   powerpc/signal32: Perform access_ok() inside restore_user_regs()
>   powerpc/signal32: Reorder user reads in restore_tm_user_regs()
>   powerpc/signal32: Convert restore_[tm]_user_regs() to user access
>     block
>   powerpc/signal32: Convert do_setcontext[_tm]() to user access block
>   powerpc/signal32: Simplify logging in sigreturn()
> 
> [...]

Applied to powerpc/next.

[01/10] signal: Add unsafe_get_compat_sigset()
        https://git.kernel.org/powerpc/c/fb05121fd6a20f0830ff2a4420c51af6ca4ac6e7
[02/10] powerpc/uaccess: Also perform 64 bits copies in unsafe_copy_from_user() on ppc32
        https://git.kernel.org/powerpc/c/c1cc1570bc8d94f288060f262f11be8f7672578c
[03/10] powerpc/signal: Add unsafe_copy_ck{fpr/vsx}_from_user
        https://git.kernel.org/powerpc/c/7c11f8893a76ac4e86c07f4b57371d5fa593627f
[04/10] powerpc/signal32: Rename save_user_regs_unsafe() and save_general_regs_unsafe()
        https://git.kernel.org/powerpc/c/f918a81e209f24acb45cd935bcfb78d2c024f6a1
[05/10] powerpc/signal32: Remove ifdefery in middle of if/else in sigreturn()
        https://git.kernel.org/powerpc/c/ca9e1605cdd9473a0eb4d6da238d2524be12591a
[06/10] powerpc/signal32: Perform access_ok() inside restore_user_regs()
        https://git.kernel.org/powerpc/c/362471b3192e4184fff5fedee1ea20bdf637a0c8
[07/10] powerpc/signal32: Reorder user reads in restore_tm_user_regs()
        https://git.kernel.org/powerpc/c/036fc2cb1dc2245c2ea7d2f03c7af80417b6310c
[08/10] powerpc/signal32: Convert restore_[tm]_user_regs() to user access block
        https://git.kernel.org/powerpc/c/627b72bee84d6652e0af26617e71ce2b3c18fcd5
[09/10] powerpc/signal32: Convert do_setcontext[_tm]() to user access block
        https://git.kernel.org/powerpc/c/887f3ceb51cd34109ac17bfc98695162e299e657
[10/10] powerpc/signal32: Simplify logging in sigreturn()
        https://git.kernel.org/powerpc/c/c7393a71eb1abdda7e3a3ef798bae60de11540ec

cheers
