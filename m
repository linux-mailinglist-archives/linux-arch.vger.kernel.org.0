Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24345B371E
	for <lists+linux-arch@lfdr.de>; Fri,  9 Sep 2022 14:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiIIMLR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Sep 2022 08:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiIIMKg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Sep 2022 08:10:36 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD15100435;
        Fri,  9 Sep 2022 05:10:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MPFDX2zd5z4xXy;
        Fri,  9 Sep 2022 22:10:04 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-arch@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
In-Reply-To: <8403854a4c187459b2f4da3537f51227b70b9223.1662134272.git.christophe.leroy@csgroup.eu>
References: <8403854a4c187459b2f4da3537f51227b70b9223.1662134272.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/2] powerpc/math_emu/efp: Include module.h
Message-Id: <166272521909.2076816.16685747643958755021.b4-ty@ellerman.id.au>
Date:   Fri, 09 Sep 2022 22:06:59 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2 Sep 2022 18:00:08 +0200, Christophe Leroy wrote:
> From: Nathan Chancellor <nathan@kernel.org>
> 
> When building with a recent version of clang, there are a couple of
> errors around the call to module_init():
> 
>   arch/powerpc/math-emu/math_efp.c:927:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
>   module_init(spe_mathemu_init);
>   ^
>   int
>   arch/powerpc/math-emu/math_efp.c:927:13: error: a parameter list without types is only allowed in a function definition
>   module_init(spe_mathemu_init);
>               ^
>   2 errors generated.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/math_emu/efp: Include module.h
      https://git.kernel.org/powerpc/c/cfe0d370e0788625ce0df3239aad07a2506c1796
[2/2] powerpc/math-emu: Remove -w build flag and fix warnings
      https://git.kernel.org/powerpc/c/7245fc5bb7a966852d5bd7779d1f5855530b461a

cheers
