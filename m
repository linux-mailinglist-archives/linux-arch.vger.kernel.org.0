Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F63976D37D
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 18:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjHBQP6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 12:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjHBQP5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 12:15:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E161982;
        Wed,  2 Aug 2023 09:15:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67D74619CB;
        Wed,  2 Aug 2023 16:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6689FC433C9;
        Wed,  2 Aug 2023 16:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690992955;
        bh=aFB7V+3UZPnXI2t7HCSOEac0MGFqyimdDX0kPkq9PJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FcGDg/QoAgueCnjJ9htQ21ACnmhEnP0HCMC52BIWD717UyZgx8nRkDxGhxFbuZHHP
         Vt8nmloqhzQ+kreiqcdM9z98m0TUC5I9yHpVh5PWkbLEae7niNndRzm4U25INskyXG
         nzo/QO+8fgzpwBW95+RmRGtEJ3Qm8P9llSmcyrpA8p3KOd2xpU10b4Sus2IaauQN7R
         sm0wC3ji2L1BnZ4zwgIuy8XM7MMba58e+JO07lbDb/HKmEdXgaBK7iW8pA45ACUMhL
         Y50QJvBdQVgDP+eSoVsMvKTVcBd2W+A+PJd1m53TzNJPriX3GsPFin+4iPM90jal3t
         jP7BzbnsPCqvw==
Date:   Wed, 2 Aug 2023 09:15:53 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ndesaulniers@google.com, Arnd Bergmann <arnd@arndb.de>,
        Tom Rix <trix@redhat.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] word-at-a-time: use the same return type for has_zero
 regardless of endianness
Message-ID: <20230802161553.GA2108867@dev-arch.thelio-3990X>
References: <20230801-bitwise-v1-1-799bec468dc4@google.com>
 <CAHk-=wgkC80Ey0Wyi3zHYexUmteeDL3hvZrp=EpMrDccRGmMwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgkC80Ey0Wyi3zHYexUmteeDL3hvZrp=EpMrDccRGmMwA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 01, 2023 at 06:07:08PM -0700, Linus Torvalds wrote:
> I think the patch is fine, but I guess I'd like to know that people
> who are affected actually don't see any code generation changes (or
> possibly see improvements from not turning it into a bool until later)

We see this warning with ARCH=arm64 defconfig + CONFIG_CPU_BIG_ENDIAN=y.
With both clang 18.0.0 (tip of tree) and GCC 13.1.0, I don't see any
actual code generation changes in fs/namei.o with this configuration.
I'd be pretty surprised if any of the other uses of has_zero() show any
changes, I at least checked lib/string.o with that configuration and
s390 and did not see anything.

As far as I can tell, arm and arm64 with CONFIG_CPU_BIG_ENDIAN=y are the
only configurations that can hit the particular bit of code with the
generic big endian has_zero() implementation because the version of
hash_name() that uses has_zero() in this manner is only used when
CONFIG_DCACHE_WORD_ACCESS is set, which only arm, arm64, powerpc (little
endian), and x86 select.

arch/arm/Kconfig:49:         select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
arch/arm64/Kconfig:121:        select DCACHE_WORD_ACCESS
arch/powerpc/Kconfig:183:        select DCACHE_WORD_ACCESS                if PPC64 && CPU_LITTLE_ENDIAN
arch/x86/Kconfig:140:        select DCACHE_WORD_ACCESS                if !KMSAN
arch/x86/um/Kconfig:12:         select DCACHE_WORD_ACCESS

So seems like a pretty low risk patch to me but I could be missing
something.

Cheers,
Nathan
