Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5A37793EA
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 18:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjHKQJn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 12:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHKQJm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 12:09:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5D02712;
        Fri, 11 Aug 2023 09:09:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 253FB67197;
        Fri, 11 Aug 2023 16:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0647BC433C7;
        Fri, 11 Aug 2023 16:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691770181;
        bh=anhq8W4bQNFdrAjwUq2MBpnU1vhYuOCchZyRQGtrqbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e1Vhbjm6u/5Mygf9TZgGmxJOcBAbymm8LGuvpLhSG+20Pzanh7kuyP3qd7ZMqjyTN
         N8X5O3kx+0NBCDFEK4ApafqhpIrrNpYYmvbM+5ct6ZhkoUEpG6vnTubDmvbBfpRIy0
         7FidDhdNFq5Objpf03QLGHQ0QTxsLbyDkxxM2+9x8FT2VbN0EGnD5L6Ia9YXWXuxA0
         qTCphGCz2p3E7tMdNhaiLJMvz/M1cia/ox5R2MEZ0W4OUp7euo62XaERnpWMEYjYpH
         0kzOvav60ZO635X/rAkHWZqVxDXcgG6WTFcUV9b/8G15cy2cuDOAr4nawgU28mw0BI
         f59vFDPvSMjhA==
Date:   Fri, 11 Aug 2023 09:09:39 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 9/9] [RFC] extrawarn: enable more W=1 warnings by default
Message-ID: <20230811160939.GA426470@dev-arch.thelio-3990X>
References: <20230811140327.3754597-1-arnd@kernel.org>
 <20230811140327.3754597-10-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811140327.3754597-10-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 11, 2023 at 04:03:27PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A number of warning options from the W=1 set are completely clean in current
> kernels, so we should just enable them by default, including a lot of warnings
> that are part of -Wextra, so just turn on -Wextra by default.
> 
> The -Woverride-init, -Wvoid-pointer-to-enum-cast and
> -Wmissing-format-attribute warnings are part of -Wextra but still produce
> some legitimate warnings that need to be fixed, so leave them at the
> W=1 level but turn them off otherwise.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
...
> -KBUILD_CFLAGS += -Wno-tautological-constant-out-of-range-compare
> -KBUILD_CFLAGS += $(call cc-disable-warning, unaligned-access)
> -KBUILD_CFLAGS += $(call cc-disable-warning, cast-function-type-strict)

I am still running through my builds but I don't think that dropping
these three is acceptable at the moment. I see a good number of all of
these warnings in -next still. I see some patches that I have picked up
to address a couple of the really noisy ones but some others that I
looked at are not fixed. I'll have a list eventually.

Cheers,
Nathan
