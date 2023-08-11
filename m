Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8567791AE
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 16:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjHKOTr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 10:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjHKOTq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 10:19:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667E32D72;
        Fri, 11 Aug 2023 07:19:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0D28673A8;
        Fri, 11 Aug 2023 14:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8675C433C7;
        Fri, 11 Aug 2023 14:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691763585;
        bh=i7VU3I34lw3GcD4uAQQPNUafbDtJahwjek8NOngMtko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lDxsTCV3Yx7LfhjfdrPo/ISrE/LJSNhDKDFIJ+anH+dJLGjefDnC7zgNofIkUmGcv
         z9AhM1JpbMt0ICdxj67iEtzJoIrdaEMroxU8htuhV4E60nlN6fQ885lmWPc8uuBleP
         tley7EfmGe8OzOSbsCa0OQgiJXw8mz4ysW2SWyvV/FCobOBR3KIIc1eY0ZYfGiLPBI
         5M0LGJAl6Zw1+4NRwPSEEp1snaU0dlh0edy4GsBr/iIIzwdA6wz/R/KC0WWK96Fp45
         +GrhgdLU5uD79cR77/U0ePA2lBXRpnvZmDUiSnWBKO0uXSJGeljgXN9CmRkhMyB4Hs
         q0aNMdfhZwyiQ==
Date:   Fri, 11 Aug 2023 07:19:43 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/9] Kbuild: consolidate warning flags in
 scripts/Makefile.extrawarn
Message-ID: <20230811141943.GB3948268@dev-arch.thelio-3990X>
References: <20230811140327.3754597-1-arnd@kernel.org>
 <20230811140327.3754597-3-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811140327.3754597-3-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 11, 2023 at 04:03:20PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Warning options are enabled and disabled in inconsistent ways and
> inconsistent locations. Start rearranging those by moving all options
> into Makefile.extrawarn.
> 
> This should not change any behavior, but makes sure we can group them
> in a way that ensures that each warning that got temporarily disabled
> is turned back on at an appropriate W=1 level later on.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  Makefile                   | 88 -------------------------------------
>  scripts/Makefile.extrawarn | 90 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 90 insertions(+), 88 deletions(-)

This shuffle seems reasonable to me. Would it make sense to rename the
Makefile from Makefile.extrawarn to just Makefile.warn or
Makefile.warnings? They are still "extra" warnings but to me, the
meaning of the Makefile is changing so it seems reasonable to drop the
"extra" part.

Cheers,
Nathan
