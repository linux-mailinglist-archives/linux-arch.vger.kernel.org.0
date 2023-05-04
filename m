Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA76A6F6608
	for <lists+linux-arch@lfdr.de>; Thu,  4 May 2023 09:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjEDHpq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 03:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjEDHpp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 03:45:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EB219B7;
        Thu,  4 May 2023 00:45:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D02F620955;
        Thu,  4 May 2023 07:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683186341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fAtkXnSLgcjg8Wiwr7C3q+RqNoepW6FpquCKIhVr0Gk=;
        b=rKCnIQNeTc5rRFs+HYGq7Kh4+pVl7eStJUFXOT5DocQzKtpM8WC31swLPiJPkoi6zbIkD/
        0gBJDg35KdFY0fRdG36T0VBWGE64YGGH3BxK+m/yOpMzSac7pSpXywz+k02coBOFZGDfMr
        IKvcjN/QkvhRfoBSIdqnql/ChUK2/2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683186341;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fAtkXnSLgcjg8Wiwr7C3q+RqNoepW6FpquCKIhVr0Gk=;
        b=Vv3xoxs1nqazVAyOW0YxVUG8zcfYMlfCiDJLrmBCjgt8Qy0QlVsf6JGOJ1DcgHoKT54Yw7
        brFIEdnzJZa58kDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66A25133F7;
        Thu,  4 May 2023 07:45:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QRIdGKViU2S6HAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 04 May 2023 07:45:41 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, geert@linux-m68k.org, javierm@redhat.com,
        daniel@ffwll.ch, vgupta@kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, davem@davemloft.net,
        James.Bottomley@HansenPartnership.com, arnd@arndb.de,
        sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 0/6] fbdev: Move framebuffer I/O helpers to <asm/fb.h>
Date:   Thu,  4 May 2023 09:45:33 +0200
Message-Id: <20230504074539.8181-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Fbdev provides helpers for framebuffer I/O, such as fb_readl(),
fb_writel() or fb_memcpy_to_fb(). The implementation of each helper
depends on the architecture, but they are all equivalent to regular
I/O functions of similar names. So use regular functions instead and
move all helpers into <asm-generic/fb.h>

The first patch a simple whitespace cleanup.

Until now, <linux/fb.h> contained an include of <asm/io.h>. As this
will go away, patches 2 to 4 prepare include statements in the various
drivers. Source files that use regular I/O helpers, such as readl(),
now include <linux/io.h>. Source files that use framebuffer I/O
helpers, such as fb_readl(), now include <linux/fb.h>.

Patch 5 replaces the architecture-based if-else branching in 
<linux/fb.h> by helpers in <asm-generic/fb.h>. All helpers use Linux'
existing I/O functions.

Patch 6 harmonizes naming among fbdev and existing I/O functions.

The patchset has been built for a variety of platforms, such as x86-64,
arm, aarch64, ppc64, parisc, m64k, mips and sparc.

v4:
	* keep fb_mem*() as-is on ia64, loongarch, sparc64 (Arnd)
	* don't include <asm/fb.h> (Sam)
v3:
	* add the new helpers in <asm-generic/fb.h>
	* support reordering and native byte order (Geert, Arnd)
v2:
	* use Linux I/O helpers (Sam, Arnd)

Thomas Zimmermann (6):
  fbdev/matrox: Remove trailing whitespaces
  ipu-v3: Include <linux/io.h>
  fbdev: Include <linux/io.h> in various drivers
  fbdev: Include <linux/fb.h> instead of <asm/fb.h>
  fbdev: Move framebuffer I/O helpers into <asm/fb.h>
  fbdev: Rename fb_mem*() helpers

 arch/ia64/include/asm/fb.h                  |  20 ++++
 arch/loongarch/include/asm/fb.h             |  21 ++++
 arch/parisc/video/fbdev.c                   |   3 +-
 arch/sparc/include/asm/fb.h                 |  20 ++++
 arch/sparc/video/fbdev.c                    |   1 -
 arch/x86/video/fbdev.c                      |   2 -
 drivers/gpu/ipu-v3/ipu-prv.h                |   1 +
 drivers/staging/sm750fb/sm750.c             |   2 +-
 drivers/video/fbdev/arcfb.c                 |   1 +
 drivers/video/fbdev/aty/atyfb.h             |   2 +
 drivers/video/fbdev/aty/mach64_cursor.c     |   2 +-
 drivers/video/fbdev/chipsfb.c               |   2 +-
 drivers/video/fbdev/core/fbcon.c            |   1 -
 drivers/video/fbdev/core/fbmem.c            |   6 +-
 drivers/video/fbdev/kyro/fbdev.c            |   2 +-
 drivers/video/fbdev/matrox/matroxfb_accel.c |   6 +-
 drivers/video/fbdev/matrox/matroxfb_base.h  |   4 +-
 drivers/video/fbdev/pvr2fb.c                |   2 +-
 drivers/video/fbdev/sstfb.c                 |   2 +-
 drivers/video/fbdev/stifb.c                 |   4 +-
 drivers/video/fbdev/tdfxfb.c                |   2 +-
 drivers/video/fbdev/wmt_ge_rops.c           |   2 +
 include/asm-generic/fb.h                    | 101 ++++++++++++++++++++
 include/linux/fb.h                          |  55 +----------
 24 files changed, 187 insertions(+), 77 deletions(-)

-- 
2.40.1

