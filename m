Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3300C7700BE
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 15:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjHDNEw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Aug 2023 09:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjHDNEv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2023 09:04:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A701146B1;
        Fri,  4 Aug 2023 06:04:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31B1561FE2;
        Fri,  4 Aug 2023 13:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C97C433C8;
        Fri,  4 Aug 2023 13:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691154288;
        bh=89r/cdPXUA3crJLOF3jvKSSR2U3OJaNBikJcnHTJn8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gUYMlOrfhs6V2ihRFqHUGhHMMYmMbicrmDYusJpbidqVz7/W3N9yODCXo+KSy/7IE
         Q7WKyfeiHvaKdEwjZ0XfcHRzwBp8IEKN8SMFMsyKgq2TBTZ/tkpJhxSOsjaAV8tO7+
         cdoSzqVVANT7dDsGKYnheeTz2lnX4eTOoHAkYAX39McHpg8KzdqvxvSiUrHMkNB8F7
         z1yWxTheru1Xu87cnT4nOT33rnMmmgqhfhFz7tE8KgvwkzyBvrvMIWjwF6z+8M6hIV
         eEflx7YZSm5zsv4tLE77TXac5S1gfpNvHdxi9ZKWEOw74M2ZGGTKFl8NuBTSqopvAk
         kMU68qIP13ohg==
Date:   Fri, 4 Aug 2023 14:04:43 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] word-at-a-time: use the same return type for has_zero
 regardless of endianness
Message-ID: <20230804130431.GA29929@willie-the-truck>
References: <20230801-bitwise-v1-1-799bec468dc4@google.com>
 <CAHk-=wgkC80Ey0Wyi3zHYexUmteeDL3hvZrp=EpMrDccRGmMwA@mail.gmail.com>
 <20230802161553.GA2108867@dev-arch.thelio-3990X>
 <CAHk-=wjmWjd+xe88cf14hFGkSK7fYJBSixK8Ym0DLYCa+dTxtg@mail.gmail.com>
 <dd48b4ff-1009-41fe-baf5-be89432c5d28@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd48b4ff-1009-41fe-baf5-be89432c5d28@app.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 02, 2023 at 08:17:32PM +0200, Arnd Bergmann wrote:
> On Wed, Aug 2, 2023, at 19:37, Linus Torvalds wrote:
> > On Wed, 2 Aug 2023 at 09:16, Nathan Chancellor <nathan@kernel.org> wrote:
> >>
> >> We see this warning with ARCH=arm64 defconfig + CONFIG_CPU_BIG_ENDIAN=y.
> >
> > Oh Christ. I didn't even realize that arm64 allowed a BE config.
> >
> > The config option goes back to 2013 - are there actually BE user space
> > implementations around?
> 
> At least NXP's Layerscape and Huawei's SoCs ended up in big-endian
> appliances, running legacy software ported from mips or powerpc.
> I agree this was a mistake, but that wasn't nearly as obvious ten
> years ago when there were still new BE-only sparc, mips and powerpc
> put on the market -- that really only ended in 2017.
> 
> > People, why do we do that? That's positively crazy. BE is dead and
> > should be relegated to legacy platforms. There are no advantages to
> > being different just for the sake of being different - any "security
> > by obscurity" argument would be far outweighed by the inconvenience to
> > actual users.
> >
> > Yes, yes, I know the aarch64 architecture technically allows BE
> > implementations - and apparently you can even do it by exception
> > level, which I had to look up. But do any actually exist?
> >
> > Does the kernel even work right in BE mode? It's really easy to miss
> > some endianness check when all the actual hardware and use is LE, and
> > when (for example) instruction encoding and IO is then always LE
> > anyway.
> 
> This was always only done for compatibility with non-portable
> software when companies with large custom network stacks argued
> that it was cheaper to build the entire open source software to
> big-endian than port their own product to little-endian. ;-)
> 
> We (Linaro) used to test all toolchain and kernel releases in
> big-endian mode as member companies had customers that asked
> for it, but that stopped a while ago as those legacy software
> stacks either got more portable or got replaced over time.
> 
> Many Arm systems won't boot BE kernels any more because UEFI
> firmware only supports LE, or because of driver bugs.
> Virtual machines are still likely to work fine though.
> I'm fairly sure that all Arm Cortex and Neoverse cores still\
> support BE mode in all exception levels, OTOH at least Apple's
> custom CPUs do not implement it at all.

Yes, that's right. The CPUs we have *do* tend to support BE, but
practically there isn't any software to run on them. I asked about
removing it a few years ago:

https://lore.kernel.org/linux-arm-kernel/20191011102747.lpbaur2e4nqyf7sw@willie-the-truck/

but Hanjun said that Huawei are using it, so it stayed.

Will
