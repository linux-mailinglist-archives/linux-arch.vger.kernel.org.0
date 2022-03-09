Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA954D3C84
	for <lists+linux-arch@lfdr.de>; Wed,  9 Mar 2022 23:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiCIWDo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Mar 2022 17:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiCIWDn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Mar 2022 17:03:43 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7ED7893C
        for <linux-arch@vger.kernel.org>; Wed,  9 Mar 2022 14:02:43 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id t187so3115156pgb.1
        for <linux-arch@vger.kernel.org>; Wed, 09 Mar 2022 14:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kIXYEUsuLw4gUV3Ye5W7fihUmUGOrEx3hL1+RzhXlG8=;
        b=bs24caSe7zitzg4jbU/q8aXnhwx/uHyi8ILJqPPNQ5jn5FaIUoVSvL+NODGsYgtby2
         3b+Pd1L5hDPPmOxSd2qT/cGuCbpDZvcricQkN87pTMG509EosJVCmGhFq13Te0xA67h1
         2iNFVdRcMImXI2Z3rTAveuFvrhCUhZfqpRpFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kIXYEUsuLw4gUV3Ye5W7fihUmUGOrEx3hL1+RzhXlG8=;
        b=a2iL3EHAwhoLJkH02YlBVU2c75wb/FeQFmPwr2g27t60ikGQPyIt9vZJUZUZDrVz9g
         EuVxprNKttX90eeM52JOIavBT53gOaUw9jpv/LRfLoY5nfKGay63nzqKya+oDBY4OPE3
         aLAB05JPdXvR+ffEhtM2V2GR1HPlJEVoFBzgsIghYtDLa3hc1PWnadpQodURLlQUBILr
         J/NBOKNRPhYMvUxGRdD5Ivv0LuEQFPfnwcrFEJKy2fh3l8YHqKLrcyppZUXrKkdpsyWy
         wplJZAmfMoQc9fEN/Q7h9Fa7t37LqZ2UncBojHCZeEP5ya9he+FgKm2WoQhKXdiR7QqD
         UTAg==
X-Gm-Message-State: AOAM5314qwRbRgzUnvRPXCAFqdNPkK42900Xxa1MeQOMLTNcTPJOEbKd
        CBY3NG1yPOJSYaI/OpV91+ZmoQ==
X-Google-Smtp-Source: ABdhPJwhBIULkR9tfZfecnMcrauNNaqm7/Z9pC57rjh/s2FPJW7pv6NuJJ+zWVoTnDZkUx0Y2/U/ng==
X-Received: by 2002:a63:894a:0:b0:380:b14c:db14 with SMTP id v71-20020a63894a000000b00380b14cdb14mr1490573pgd.116.1646863363071;
        Wed, 09 Mar 2022 14:02:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s8-20020a056a0008c800b004f664655937sm4441024pfu.157.2022.03.09.14.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:02:42 -0800 (PST)
Date:   Wed, 9 Mar 2022 14:02:42 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Borislav Petkov <bp@alien8.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Theodore Ts'o <tytso@mit.edu>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
        Michael Cree <mcree@orcon.net.nz>,
        linux-arch <linux-arch@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH] a.out: Stop building a.out/osf1 support on alpha and m68k
Message-ID: <202203091358.775E158C@keescook>
References: <YeBzxuO0wLn/B2Ew@mit.edu>
 <YeCuNapJLK4M5sat@zn.tnic>
 <CAMuHMdUbTNNr16YY1TFe=-uRLjg6yGzgw_RqtAFpyhnOMM5Pvw@mail.gmail.com>
 <YeHLIDsjGB944GSP@zn.tnic>
 <CAMuHMdUBr+gpF6Z5nPadjHFYJwgGd+LGoNTV=Sxty+yaY5EWxg@mail.gmail.com>
 <YeHQmbMYyy92AbBp@zn.tnic>
 <YeKyBP5rac8sVvWw@zn.tnic>
 <b40d1377-51d5-4ba3-ab3f-b40626c229ad@physik.fu-berlin.de>
 <87ilsmdhb5.fsf_-_@email.froward.int.ebiederm.org>
 <CAHk-=wg+TYsns5JvNds6BVG7ezdg8uM_z9m8uJBcRDANdd7csw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg+TYsns5JvNds6BVG7ezdg8uM_z9m8uJBcRDANdd7csw@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 09, 2022 at 12:37:54PM -0800, Linus Torvalds wrote:
> On Wed, Mar 9, 2022 at 12:04 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> > Let's see if anyone cares about a.out support on the last two
> > architectures that build it, by disabling the build of the support in
> > Kconfig.
> [...]
> But sure, it would be interesting to know if any alpha people care - I
> just have this suspicion that we can't drop it that easily because of
> the non-Linux legacy.

It looks like the only distro supporting Alpha is Gentoo. I pulled
down the installation media, and everything is ELF except for firmware
COFF files:

$ find . -type f | xargs file | grep -Ei ':.*(out|coff)'
./lib/firmware/meson/vdec/g12a_hevc_mmu.bin: MIPSEB MIPS-III ECOFF executable not stripped - version 0.0
./lib/firmware/meson/vdec/g12a_vp9.bin: MIPSEB MIPS-III ECOFF executable not stripped - version 0.0
./lib/firmware/meson/vdec/gxl_hevc_mmu.bin: MIPSEB MIPS-III ECOFF executable not stripped - version 0.0
./lib/firmware/meson/vdec/gxl_vp9.bin: MIPSEB MIPS-III ECOFF executable not stripped - version 0.0
./lib/firmware/meson/vdec/sm1_hevc_mmu.bin: MIPSEB MIPS-III ECOFF executable not stripped - version 0.0
./lib/firmware/meson/vdec/sm1_vp9_mmu.bin: MIPSEB MIPS-III ECOFF executable not stripped - version 0.0
./lib/firmware/qca/crbtfw32.tlv: mc68k COFF object not stripped

So, since it's an easy revert, sure. Let's do it.

-- 
Kees Cook
