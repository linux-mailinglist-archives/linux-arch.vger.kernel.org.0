Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D27870A879
	for <lists+linux-arch@lfdr.de>; Sat, 20 May 2023 16:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjETOMv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 May 2023 10:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjETOMu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 May 2023 10:12:50 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4605E103;
        Sat, 20 May 2023 07:12:49 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A2FED6E3;
        Sat, 20 May 2023 14:12:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A2FED6E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684591968; bh=ssW6Hz/R5GSYGIKYc6bggawEYxKcwfdt7FMg15yh+SQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Wqc7837+yYQXWUWpNZUbvPfAYsEU94Nsz63U2qrzVyv7mG9M0sVdGPh8u7zVEB38U
         sl6657pnw40uwSVT1M0djeLOW9uewXdf3OyWstEEpXxJ6I7nPy4oXj/iuB3RZkpCwi
         vxB63WPEpBIlq2H6TNUGxZM7mF0vUJPIxCT6JbKWtX8U2p21dBr0uaI34QOdMUUaXo
         TDDws2G9+yEWz1JZec2SLrtHGWn4d9CUQXGzyaHta5aj7U/RKlYlUlV8tiJysSna0J
         TqXVQXXa8kjv8LocVTL3rWVHJWzTQWPb3p4jd497m0LjvWI1wI9MWzhvObS9pq5K09
         nmCd0mP7uhhsw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     kernel test robot <lkp@intel.com>, linux-doc@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6ni?= =?utf-8?Q?g?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-input@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 6/7] docs: update some straggling Documentation/arm
 references
In-Reply-To: <202305201023.2DYXmdv3-lkp@intel.com>
References: <20230519164607.38845-7-corbet@lwn.net>
 <202305201023.2DYXmdv3-lkp@intel.com>
Date:   Sat, 20 May 2023 08:12:47 -0600
Message-ID: <87r0rbjdls.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> Hi Jonathan,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v6.4-rc2 next-20230519]
> [cannot apply to sunxi/sunxi/for-next arm64/for-next/core thierry-reding-pwm/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Corbet/arm-docs-Move-Arm-documentation-to-Documentation-arch/20230520-005124
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20230519164607.38845-7-corbet%40lwn.net
> patch subject: [PATCH 6/7] docs: update some straggling Documentation/arm references
> reproduce:
>         # https://github.com/intel-lab-lkp/linux/commit/3c9885f2702a3319156cfbacedfca658e726213b
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Jonathan-Corbet/arm-docs-Move-Arm-documentation-to-Documentation-arch/20230520-005124
>         git checkout 3c9885f2702a3319156cfbacedfca658e726213b
>         make menuconfig
>         # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
>         make htmldocs
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202305201023.2DYXmdv3-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/arch/arm64/

Sigh...obviously this hunk:

 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
-F:	Documentation/arm64/
+F:	Documentation/arch/arm64/
 F:	arch/arm64/
 F:	tools/testing/selftests/arm64/

...got a bit ahead of the game.  I'll take that one out, sorry for the
noise.

jon
