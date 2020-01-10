Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98CA313700F
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2020 15:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgAJOy2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jan 2020 09:54:28 -0500
Received: from foss.arm.com ([217.140.110.172]:45768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbgAJOy2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jan 2020 09:54:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C647A30E;
        Fri, 10 Jan 2020 06:54:27 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AFA33F6C4;
        Fri, 10 Jan 2020 06:54:27 -0800 (PST)
From:   Mark Brown <broonie@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Richard Henderson <richard.henderson@linaro.org>,
        Borislav Petkov <bp@alien8.de>, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au, x86@kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 00/10] Impveovements for random.h/archrandom.h
Date:   Fri, 10 Jan 2020 14:54:12 +0000
Message-Id: <20200110145422.49141-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a resend of a series from Richard Henderson last posted back in
November:

   https://lore.kernel.org/linux-arm-kernel/20191106141308.30535-1-rth@twiddle.net/

Back then Borislav said they looked good and asked if he should take
them through the tip tree but things seem to have got lost since then.

Original cover letter:

During patch review for an addition of archrandom.h for arm64, it was
suggeted that the arch_random_get_* functions should be marked __must_check.
Which does sound like a good idea, since the by-reference integer output
may be uninitialized when the boolean result is false.

In addition, it turns out that arch_has_random() and arch_has_random_seed()
are not used, and not easy to support for arm64.  Rather than cobble
something together that would not be testable, remove the interfaces
against some future accidental use.

In addition, I noticed a few other minor inconsistencies between the
different architectures, e.g. powerpc isn't using bool.

Change since v1:
   * Remove arch_has_random, arch_has_random_seed.

Richard Henderson (10):
  x86: Remove arch_has_random, arch_has_random_seed
  powerpc: Remove arch_has_random, arch_has_random_seed
  s390: Remove arch_has_random, arch_has_random_seed
  linux/random.h: Remove arch_has_random, arch_has_random_seed
  linux/random.h: Use false with bool
  linux/random.h: Mark CONFIG_ARCH_RANDOM functions __must_check
  x86: Mark archrandom.h functions __must_check
  powerpc: Use bool in archrandom.h
  powerpc: Mark archrandom.h functions __must_check
  s390x: Mark archrandom.h functions __must_check

 arch/powerpc/include/asm/archrandom.h | 27 +++++++++-----------------
 arch/s390/include/asm/archrandom.h    | 20 ++++---------------
 arch/x86/include/asm/archrandom.h     | 28 ++++++++++++---------------
 include/linux/random.h                | 24 ++++++++---------------
 4 files changed, 33 insertions(+), 66 deletions(-)

-- 
2.20.1

