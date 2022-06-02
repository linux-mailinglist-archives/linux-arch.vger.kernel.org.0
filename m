Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD4F53C06C
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jun 2022 23:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbiFBViy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jun 2022 17:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiFBViy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jun 2022 17:38:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E0B13F4B;
        Thu,  2 Jun 2022 14:38:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A265618B9;
        Thu,  2 Jun 2022 21:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A15C385A5;
        Thu,  2 Jun 2022 21:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654205931;
        bh=amMY/A91YaEthDSlXJaPTNFGE4KBXfHPi7FX11QWa/A=;
        h=From:Date:Subject:To:Cc:From;
        b=Hgs+5nL8sDtkESwBJsrsyDqel+dO4V4lSdaXraX6Bb6VCfscPCY1SR6vGlWmKsIjU
         gqRm8/zrFzbhYqFTIPX7m2ZVLxsXJ05PaQCGsneWqRDA2tgeEtVJfU445Xf3ROkPAE
         7KQUjx4KC5vwWiJ3IP9D64h+gnMPViIhG4iWoA2wAucWuvFBFWD5I0iN+ch+bgG3Kd
         27P5HvsPeBEqn3G7k1Dy0a+z1aLtsD5waMqLGsmCqEV9ST/odO26FOe0Xj0WME+rZ0
         ngyvCcPP+pTUCRV443wXUP8GUFA47w9xDe2IMTtvytXMZCV3vL16b2W/JDvAR4zrnk
         0jIuZaIcgw4hw==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-30c2f288f13so64968517b3.7;
        Thu, 02 Jun 2022 14:38:51 -0700 (PDT)
X-Gm-Message-State: AOAM532uQ8rfE6nFmqiHdBUmxeX2nVnp8VruXz0lIyIt5S7Nj2wfm7zf
        V1+mLcCRbVvCSNEsHZnndlUYkgKv9XGOSaBPTII=
X-Google-Smtp-Source: ABdhPJyJ+baE/qLC48mWV+MXSK5c0wtuOPmTikbDw4WusgGptxYQ2d1f+Huq3hHPgw5DfMkFij4FafqIjHvrfmFC2z8=
X-Received: by 2002:a0d:efc2:0:b0:2fe:d2b7:da8 with SMTP id
 y185-20020a0defc2000000b002fed2b70da8mr7785647ywe.42.1654205930734; Thu, 02
 Jun 2022 14:38:50 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 2 Jun 2022 23:38:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1Pi6qjx=7=363DvCCqMb-b=b9BtD+FMByopAwymC+2fA@mail.gmail.com>
Message-ID: <CAK8P3a1Pi6qjx=7=363DvCCqMb-b=b9BtD+FMByopAwymC+2fA@mail.gmail.com>
Subject: [GIT PULL] asm-generic fixes for 5.19, part 1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit b2441b3bdce6c02cb96278d98c620d7ba1d41b7b:

  h8300: remove stale bindings and symlink (2022-05-20 22:40:56 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-fixes-5.19

for you to fetch changes up to 8cc5b032240ae5220b62c689c20459d3e1825b2d:

  binder: fix sender_euid type in uapi header (2022-06-02 17:47:25 +0200)

----------------------------------------------------------------
asm-generic fixes for 5.19, part 1

The header cleanup series from Masahiro Yamada ended up causing
some regressions in the ABI because of an ambiguous uid_t type.

This was only caught after the original patches got merged, but
at least the fixes are trivial and hopefully complete.

----------------------------------------------------------------
Carlos Llamas (1):
      binder: fix sender_euid type in uapi header

Masahiro Yamada (3):
      mips: use __kernel_{uid,gid}32_t in uapi/asm/stat.h
      powerpc: use __kernel_{uid,gid}32_t in uapi/asm/stat.h
      sparc: fix mis-use of __kernel_{uid,gid}_t in uapi/asm/stat.h

 arch/mips/include/uapi/asm/stat.h    | 12 ++++++------
 arch/powerpc/include/uapi/asm/stat.h |  4 ++--
 arch/sparc/include/uapi/asm/stat.h   |  4 ++--
 include/uapi/linux/android/binder.h  |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)
