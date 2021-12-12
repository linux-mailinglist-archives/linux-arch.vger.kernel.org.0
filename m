Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6084717CE
	for <lists+linux-arch@lfdr.de>; Sun, 12 Dec 2021 03:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhLLCSF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Dec 2021 21:18:05 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:45112 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhLLCSF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Dec 2021 21:18:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EF08CCE0B01;
        Sun, 12 Dec 2021 02:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12138C004DD;
        Sun, 12 Dec 2021 02:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639275480;
        bh=iJL/6mEne38AzSXVcb8m6/VlwgWeUH9E66rradqeky8=;
        h=From:To:Cc:Subject:Date:From;
        b=ADivHlcaEKPtZ4Aawh/RUI1NxLo9PVFjqAMSeZ0FRZ8IMv5EZ9X9+bwuDKsTNGNUt
         lM5aPk86acgFXpnzFPdBd5FUelnLrqtkhm9gJMoqDF84/cuIcm1WqYBHvfKY3dGlKK
         2LIWxKNpnUT1t2Gv53p5X1fjG8e1LqCbVs86ek6v8ztqmbcu8ewPn7xMEjRBgQ6Q7p
         HFx/hb7qD6Z2+DfZzHpnkk+L+cettler6BU7ewrxd8JK2LFjMFouat0ITbAqCsPlM/
         z1urAwW3bJmEajrK6s4ljo4rjLR13mR9gYEt2/8Fa3jMWvv/+RYKIgCvAABBmdF12z
         9s2I3negR563Q==
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
        guoren@kernel.org
Subject: [GIT PULL] csky fixes for v5.16-rc5
Date:   Sun, 12 Dec 2021 10:17:53 +0800
Message-Id: <20211212021753.3541366-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.16-rc5

for you to fetch changes up to a0793fdad9a11a32bc6d21317c93c83f4aa82ebc:

  csky: fix typo of fpu config macro (2021-12-08 14:15:54 +0800)

----------------------------------------------------------------
csky updates for 5.16-rc5

Only 1 fixup for csky:
 - fpu config macro

----------------------------------------------------------------
Kelly Devilliv (1):
      csky: fix typo of fpu config macro

 arch/csky/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
