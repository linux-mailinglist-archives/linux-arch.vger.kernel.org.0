Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CDB47E92B
	for <lists+linux-arch@lfdr.de>; Thu, 23 Dec 2021 22:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245106AbhLWVnT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Dec 2021 16:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240686AbhLWVnS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Dec 2021 16:43:18 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4206AC061401;
        Thu, 23 Dec 2021 13:43:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7AE5DCE2208;
        Thu, 23 Dec 2021 21:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85FEC36AEA;
        Thu, 23 Dec 2021 21:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640295794;
        bh=YZG2vX676ItJy3+kJRWOsS2iMCGgY1eqBlxO8esua7k=;
        h=From:Date:Subject:To:Cc:From;
        b=AFfyfJfylrPYTx9StY/CF6lMb4wD5XehUOUZH9qMPNQ/u4I33ZQIGVkN4fK1oTsEL
         S3J8hke9AyyiwFMd8LxSexuGbGtAhtR8UHNu2vmxwMF8a/PrbxzLy4GqXkS5pOt1LY
         2NMgZF50eiKyoVXlMQwtMpwHVJTP6S1LgkwLeImtAOCny0E/YI0IMVZKHaww3ZX7K7
         11QDAh+hCfe37h72ZpYNWboHz3TFIvVt17IY2KIuM6vox2EhyO/PxlfvVTv0UFYj2/
         Fc+zV1Ce/uD0AhadNpJOoBfQX6deMd6K1c0ZwVSwCRtXSCHVDLMf4LP4D0tN2AyoiP
         tneGAJlVQVZjA==
Received: by mail-wr1-f49.google.com with SMTP id s1so13889004wra.6;
        Thu, 23 Dec 2021 13:43:14 -0800 (PST)
X-Gm-Message-State: AOAM531UTSYgI11rmZGPgBJQxyrui03Qyr5Vza0bzllzcoOPcXAacpr1
        3eX3j+B0hImR9nSFSfY15XQ/hvajODlrShegk+k=
X-Google-Smtp-Source: ABdhPJxGnmkmwfJuofdStb9OMaZZAS7Asd+mhazJrq2O1sPYplNi8Szl6RNei35+vaGLMqTCAbvXATegCNAhfMORJlo=
X-Received: by 2002:a5d:6989:: with SMTP id g9mr2832508wru.12.1640295793148;
 Thu, 23 Dec 2021 13:43:13 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 23 Dec 2021 22:42:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2ajcXkh4OAfJseUSiCsfU7gOXbDwiWHNGKgByzDwcycg@mail.gmail.com>
Message-ID: <CAK8P3a2ajcXkh4OAfJseUSiCsfU7gOXbDwiWHNGKgByzDwcycg@mail.gmail.com>
Subject: [GIT PULL] asm-generic: cleanups for 5.17
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>, wasin@wasin.io
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-5.17

for you to fetch changes up to 733e417518a69b71061c3bafc2bf106109565eee:

  asm-generic/error-injection.h: fix a spelling mistake, and a coding
style issue (2021-12-17 14:12:14 +0100)

----------------------------------------------------------------
asm-generic: cleanups for 5.17

A few minor cleanups for cross-architecture code: Alexandre Ghiti
deals with removing some leftovers from drivers and features that
have been removed, and Wasin Thonkaew has a cosmetic change.

----------------------------------------------------------------
As with the soc pull requests, this is also early, as I won't be working
before the start of the merge window.

Alexandre Ghiti (4):
      Documentation, arch: Remove leftovers from raw device
      Documentation, arch: Remove leftovers from CIFS_WEAK_PW_HASH
      arch: Remove leftovers from mandatory file locking
      arch: Remove leftovers from prism54 wireless driver

Wasin Thonkaew (1):
      asm-generic/error-injection.h: fix a spelling mistake, and a
coding style issue

 Documentation/admin-guide/cifs/usage.rst    | 7 +++----
 Documentation/admin-guide/devices.txt       | 8 +-------
 arch/arm/configs/cm_x300_defconfig          | 1 -
 arch/arm/configs/ezx_defconfig              | 1 -
 arch/arm/configs/imote2_defconfig           | 1 -
 arch/arm/configs/nhk8815_defconfig          | 1 -
 arch/arm/configs/pxa_defconfig              | 1 -
 arch/arm/configs/spear13xx_defconfig        | 1 -
 arch/arm/configs/spear3xx_defconfig         | 1 -
 arch/arm/configs/spear6xx_defconfig         | 1 -
 arch/mips/configs/decstation_64_defconfig   | 1 -
 arch/mips/configs/decstation_defconfig      | 1 -
 arch/mips/configs/decstation_r4k_defconfig  | 1 -
 arch/mips/configs/fuloong2e_defconfig       | 1 -
 arch/mips/configs/ip27_defconfig            | 1 -
 arch/mips/configs/malta_defconfig           | 1 -
 arch/mips/configs/malta_kvm_defconfig       | 1 -
 arch/mips/configs/malta_qemu_32r6_defconfig | 1 -
 arch/mips/configs/maltaaprp_defconfig       | 1 -
 arch/mips/configs/maltasmvp_defconfig       | 1 -
 arch/mips/configs/maltasmvp_eva_defconfig   | 1 -
 arch/mips/configs/maltaup_defconfig         | 1 -
 arch/mips/configs/maltaup_xpa_defconfig     | 1 -
 arch/powerpc/configs/pmac32_defconfig       | 1 -
 arch/powerpc/configs/ppc6xx_defconfig       | 1 -
 arch/powerpc/configs/pseries_defconfig      | 1 -
 arch/sh/configs/titan_defconfig             | 1 -
 include/asm-generic/error-injection.h       | 4 ++--
 28 files changed, 6 insertions(+), 38 deletions(-)
