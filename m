Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58EB426CD2
	for <lists+linux-arch@lfdr.de>; Fri,  8 Oct 2021 16:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhJHOis (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 10:38:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229756AbhJHOir (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Oct 2021 10:38:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95F0260F5C;
        Fri,  8 Oct 2021 14:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633703812;
        bh=t+hlBOA9013wCFF+qw9fA68XVfWsxLdC41rXTznDq+c=;
        h=From:Date:Subject:To:Cc:From;
        b=fG4ogRK3ZZNFAQ00Si3IYqNyGXsJ1xilUV4wmIP1aRxeQcnaZYnwXSGMhDTSIO/uL
         GsOC1oiCKNMekPlx+04AiIYTUFepKQS0sorYAGxnTRtoPjVfzpX3Auc3fBNN9xNvd7
         2lB6wAmehOQz89Jm3T86aTTTZktyx+7lWTknVOWthmcfU1v8vETapIXdF6XQQIsMtk
         DIpeRQoFiM7CHkbqAXC7APbYJeJFWO5JEioM41GtEDAwkElBfwqizUR9RzLF3wOMah
         CZqg45SIueuLqn/izsRbWikGRYqWZulZ9dTlCxZ3+3gMmSjAGREQpfnMEkN/KgEEtN
         GYSFH/9auAYlg==
Received: by mail-wr1-f43.google.com with SMTP id e12so30518500wra.4;
        Fri, 08 Oct 2021 07:36:52 -0700 (PDT)
X-Gm-Message-State: AOAM530sxmLAZbnDKb4LJA9Gxj+dAnTNOcmQmL2K1shsNCTh69cKFltY
        oEEaIh03FguLQ9vDZpz0EdcQuvRldRjuhp2bRd4=
X-Google-Smtp-Source: ABdhPJz7rvULoEBwZGj3NKEJYoTa6eWldb9JNPxhe0dUKjgtZhb+oFcS2iARUryNLXjWtpdUumTdWOhep47L+av9IaA=
X-Received: by 2002:adf:b1c4:: with SMTP id r4mr4627783wra.428.1633703811146;
 Fri, 08 Oct 2021 07:36:51 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 8 Oct 2021 16:36:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0WCfiZ=WeezCCATSoxGmaDtL=pAWKzRu3wuLaT9qs6gA@mail.gmail.com>
Message-ID: <CAK8P3a0WCfiZ=WeezCCATSoxGmaDtL=pAWKzRu3wuLaT9qs6gA@mail.gmail.com>
Subject: [GIT PULL] asm-generic: build fixes for v5.15
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-fixes-5.15

for you to fetch changes up to 2fbc349911e45d4ea5187b608c8d58db66496260:

  asm-generic/io.h: give stub iounmap() on !MMU same prototype as
elsewhere (2021-10-08 15:39:33 +0200)

----------------------------------------------------------------
asm-generic: build fixes for v5.15

There is one build fix for Arm platforms that ended up impacting most
architectures because of the way the drivers/firmware Kconfig file is
wired up:

The CONFIG_QCOM_SCM dependency have caused a number of randconfig
regressions over time, and some still remain in v5.15-rc4. The
fix we agreed on in the end is to make this symbol selected by any
driver using it, and then building it even for non-Arm platforms with
CONFIG_COMPILE_TEST.

To make this work on all architectures, the drivers/firmware/Kconfig
file needs to be included for all architectures to make the symbol
itself visible.

In a separate discussion, we found that a sound driver patch that is
pending for v5.16 needs the same change to include this Kconfig file,
so the easiest solution seems to have my Kconfig rework included in v5.15.

There is a small merge conflict against an earlier partial fix for the
QCOM_SCM dependency problems.

Finally, the branch also includes a small unrelated build fix for NOMMU
architectures.

Link: https://lore.kernel.org/all/20210928153508.101208f8@canb.auug.org.au/
Link: https://lore.kernel.org/all/20210928075216.4193128-1-arnd@kernel.org/
Link: https://lore.kernel.org/all/20211007151010.333516-1-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Adam Borowski (1):
      asm-generic/io.h: give stub iounmap() on !MMU same prototype as elsewhere

Arnd Bergmann (2):
      firmware: include drivers/firmware/Kconfig unconditionally
      qcom_scm: hide Kconfig symbol

 arch/arm/Kconfig                           |  2 -
 arch/arm64/Kconfig                         |  2 -
 arch/ia64/Kconfig                          |  2 -
 arch/mips/Kconfig                          |  2 -
 arch/parisc/Kconfig                        |  2 -
 arch/riscv/Kconfig                         |  2 -
 arch/x86/Kconfig                           |  2 -
 drivers/Kconfig                            |  2 +
 drivers/firmware/Kconfig                   |  5 +--
 drivers/gpu/drm/msm/Kconfig                |  4 +-
 drivers/iommu/Kconfig                      |  3 +-
 drivers/iommu/arm/arm-smmu/Makefile        |  3 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c |  3 +-
 drivers/media/platform/Kconfig             |  2 +-
 drivers/mmc/host/Kconfig                   |  2 +-
 drivers/net/ipa/Kconfig                    |  1 +
 drivers/net/wireless/ath/ath10k/Kconfig    |  2 +-
 drivers/pinctrl/qcom/Kconfig               |  3 +-
 include/asm-generic/io.h                   |  2 +-
 include/linux/arm-smccc.h                  | 10 +++++
 include/linux/qcom_scm.h                   | 71 ------------------------------
 21 files changed, 27 insertions(+), 100 deletions(-)
