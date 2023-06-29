Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6CA74259A
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jun 2023 14:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjF2MT6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jun 2023 08:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjF2MT5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2023 08:19:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA03E1FD8;
        Thu, 29 Jun 2023 05:19:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4573E1F8D6;
        Thu, 29 Jun 2023 12:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688041195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nwKCg0ASpMSj/N7nk6+LAWl9eqN5SgDZ9SSsI3CKIes=;
        b=ifsv+rsuemSFYPhJ/STIdTvx6x75qUEhLLGZ2g9AvONK3jL91ZNzeWNAtZraZVcGWThcHM
        EfQbM+qs5azyCMPqS9sZhBhwKPyBWCHJQhLVHCTMFRSDdi3SXNdEiGVeBJdlRqG6pE2rO7
        z3oGS2FeItnucroHvhtx1EF9mKdmXIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688041195;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nwKCg0ASpMSj/N7nk6+LAWl9eqN5SgDZ9SSsI3CKIes=;
        b=E6n/U6MQ4f+3rPbM2UsNu1qwtOXOlMais+WpB4FpCxfnJZvfgaxmYOknSshObU0+YcztfQ
        wODdqbuTw1DsqWBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCBF713905;
        Thu, 29 Jun 2023 12:19:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1lzwMOp2nWRlVAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 29 Jun 2023 12:19:54 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     arnd@arndb.de, deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-arch@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 00/12] arch,fbdev: Move screen_info into arch/
Date:   Thu, 29 Jun 2023 13:45:39 +0200
Message-ID: <20230629121952.10559-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The variables screen_info and edid_info provide information about
the system's screen, and possibly EDID data of the connected display.
Both are defined and set by architecture code. But both variables are
declared in non-arch header files. Dependencies are at bease loosely
tracked. To resolve this, move the global state screen_info and its
companion edid_info into arch/. Only declare them on architectures
that define them. List dependencies on the variables in the Kconfig
files. Also clean up the callers.

Patch 1 to 4 resolve a number of unnecessary include statements of
<linux/screen_info.h>. The header should only be included in source
files that access struct screen_info.

Patches 5 to 7 move the declaration of screen_info and edid_info to
<asm-generic/screen_info.h>. Architectures that provide either set
a Kconfig token to enable them.

Patches 8 to 9 make users of screen_info depend on the architecture's
feature.

Finally, patches 10 to 12 rework fbdev's handling of firmware EDID
data to make use of existing helpers and the refactored edid_info.

Tested on x86-64. Built for a variety of platforms.

Future directions: with the patchset in place, it will become possible
to provide screen_info and edid_info only if there are users. Some
architectures do this by testing for CONFIG_VT, CONFIG_DUMMY_CONSOLE,
etc. A more uniform approach would be nice. We should also attempt
to minimize access to the global screen_info as much as possible. To
do so, some drivers, such as efifb and vesafb, would require an update.
The firmware's EDID data could possibly made available outside of fbdev.
For example, the simpledrm and ofdrm drivers could provide such data
to userspace compositors.

Thomas Zimmermann (12):
  efi: Do not include <linux/screen_info.h> from EFI header
  fbdev/sm712fb: Do not include <linux/screen_info.h>
  sysfb: Do not include <linux/screen_info.h> from sysfb header
  staging/sm750fb: Do not include <linux/screen_info.h>
  arch: Remove trailing whitespaces
  arch: Declare screen_info in <asm/screen_info.h>
  arch/x86: Declare edid_info in <asm/screen_info.h>
  drivers/firmware: Remove trailing whitespaces
  drivers: Add dependencies on CONFIG_ARCH_HAS_SCREEN_INFO
  fbdev/core: Use fb_is_primary_device() in fb_firmware_edid()
  fbdev/core: Protect edid_info with CONFIG_ARCH_HAS_EDID_INFO
  fbdev/core: Define empty fb_firmware_edid() in <linux/fb.h>

 arch/Kconfig                                  | 12 +++++++
 arch/alpha/Kconfig                            |  1 +
 arch/arm/Kconfig                              |  1 +
 arch/arm/kernel/efi.c                         |  2 ++
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/kernel/efi.c                       |  1 +
 arch/csky/Kconfig                             |  1 +
 arch/hexagon/Kconfig                          |  1 +
 arch/ia64/Kconfig                             |  5 +--
 arch/loongarch/Kconfig                        |  1 +
 arch/mips/Kconfig                             |  1 +
 arch/nios2/Kconfig                            |  1 +
 arch/powerpc/Kconfig                          |  1 +
 arch/riscv/Kconfig                            |  1 +
 arch/sh/Kconfig                               |  7 ++--
 arch/sparc/Kconfig                            |  1 +
 arch/x86/Kconfig                              |  2 ++
 arch/xtensa/Kconfig                           |  1 +
 drivers/firmware/Kconfig                      |  3 +-
 drivers/firmware/efi/Kconfig                  |  1 +
 drivers/firmware/efi/libstub/efi-stub-entry.c |  2 ++
 drivers/firmware/efi/libstub/screen_info.c    |  2 ++
 drivers/gpu/drm/Kconfig                       |  1 +
 drivers/hv/Kconfig                            |  1 +
 drivers/staging/sm750fb/sm750.c               |  1 -
 drivers/staging/sm750fb/sm750_accel.c         |  1 -
 drivers/staging/sm750fb/sm750_cursor.c        |  1 -
 drivers/staging/sm750fb/sm750_hw.c            |  1 -
 drivers/video/console/Kconfig                 |  2 ++
 drivers/video/fbdev/Kconfig                   |  4 +++
 drivers/video/fbdev/core/fbmon.c              | 34 ++++++-------------
 drivers/video/fbdev/i810/i810-i2c.c           |  2 +-
 drivers/video/fbdev/intelfb/intelfbdrv.c      |  2 +-
 drivers/video/fbdev/nvidia/nv_i2c.c           |  2 +-
 drivers/video/fbdev/savage/savagefb-i2c.c     |  2 +-
 drivers/video/fbdev/sm712fb.c                 |  9 +++--
 include/asm-generic/Kbuild                    |  1 +
 include/asm-generic/screen_info.h             | 18 ++++++++++
 include/linux/efi.h                           |  3 +-
 include/linux/fb.h                            | 10 +++++-
 include/linux/screen_info.h                   |  2 +-
 include/linux/sysfb.h                         |  3 +-
 include/video/edid.h                          |  3 --
 43 files changed, 105 insertions(+), 47 deletions(-)
 create mode 100644 include/asm-generic/screen_info.h


base-commit: d2f0af8472494398a42153684b790b723a79f143
-- 
2.41.0

