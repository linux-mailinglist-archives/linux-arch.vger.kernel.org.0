Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5661FC251
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jun 2020 01:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgFPXbd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jun 2020 19:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgFPXbX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jun 2020 19:31:23 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF15C06174E;
        Tue, 16 Jun 2020 16:31:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49mkwl731Mz9sSf;
        Wed, 17 Jun 2020 09:31:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1592350280;
        bh=Z8EPXB67S9g5w1bpWq7oF27matGVG6C165t6+mii+NE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dlVC2h+TCj+AUhv4hysuH9r8dl+3S7B5psm7YbEEjuOzxIU79XQeG4FUKSMUkcMye
         +BjDVV/BAxLG8xqjvAiAS84wdloJr0FuQrMARnRednHQ3+dGnvVJ/I2f0Rgi0GIzNA
         DQoRZqmoA5Y3GWcr3U0IqYGCkVSzTIGTIGwP13h1OR/IweZUMvwuCGiomWgo0GVulb
         s736QPIH7quGpvB+I7SLN8sG12tMgy5Ct+c/XRuS4aLavtqOEbbTYPXATGlMplNPg9
         Ttvim55p3wP3UQ5BC5opGp8q1lgFywFyXMrePFEPymZ2xKdwNwNnXNWgC5kDL7sey9
         ZWAHSnzeeH5Eg==
Date:   Wed, 17 Jun 2020 09:30:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <greg@kroah.com>
Subject: [PATCH 2/2] Remove the include of linux/major.h from files that do
 not need it
Message-ID: <20200617093044.71847e1a@canb.auug.org.au>
In-Reply-To: <20200617092614.7897ccb2@canb.auug.org.au>
References: <20200617092614.7897ccb2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SLH5jp.N73//Dr/64_U40xb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/SLH5jp.N73//Dr/64_U40xb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

This is fairly safe because major.h does not include any other files.
The only real risk is if a symbol defined in major.h is constructed by
concatenation in the preprocessor.

The actual change was done using the following command:

	sed -i -E '/[<"](uapi\/)?linux\/major\.h/d' \
		$(grep -L -w -f /tmp/xx \
			$(git grep -E -l '[<"](uapi/)?linux/major\.h'))

Where the file /tmp/xx contians all the symbols defined in major.h

(genhd.h was added by inspection.)

The win here is really just the number of lines to be parsed by the
preprocessor.  major.h is 180 lines long and was being included by these
101 files unnecessarily.  In particular, there are 3 global include
files here (tty.h, genhd.h and blkdev.h) that are also included by 354,
68 and 554 other files, repectively.

After this, major.h is only included by 4 global include files (which
are in turn included by 297 other files), so its indirect inclusion is
hopefully much reduced.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/alpha/kernel/osf_sys.c               | 1 -
 arch/alpha/kernel/process.c               | 1 -
 arch/arm/mach-iop32x/i2c.c                | 1 -
 arch/arm/mach-omap1/board-h3.c            | 1 -
 arch/arm/mach-pxa/corgi.c                 | 1 -
 arch/arm/mach-pxa/lubbock.c               | 1 -
 arch/arm/mach-pxa/tosa.c                  | 1 -
 arch/arm/mach-pxa/viper.c                 | 1 -
 arch/m68k/atari/atasound.c                | 1 -
 arch/m68k/atari/stram.c                   | 1 -
 arch/m68k/bvme6000/config.c               | 1 -
 arch/m68k/mvme147/config.c                | 1 -
 arch/m68k/mvme16x/config.c                | 1 -
 arch/m68k/q40/config.c                    | 1 -
 arch/mips/fw/arc/arc_con.c                | 1 -
 arch/powerpc/platforms/83xx/km83xx.c      | 1 -
 arch/powerpc/platforms/83xx/mpc832x_mds.c | 1 -
 arch/powerpc/platforms/83xx/mpc834x_itx.c | 1 -
 arch/powerpc/platforms/83xx/mpc834x_mds.c | 1 -
 arch/powerpc/platforms/83xx/mpc836x_mds.c | 1 -
 arch/powerpc/platforms/85xx/mpc85xx_cds.c | 1 -
 arch/powerpc/platforms/85xx/mpc85xx_mds.c | 1 -
 arch/powerpc/platforms/85xx/sbc8548.c     | 1 -
 arch/powerpc/platforms/chrp/setup.c       | 1 -
 arch/powerpc/platforms/maple/setup.c      | 1 -
 arch/powerpc/platforms/powermac/setup.c   | 1 -
 arch/powerpc/platforms/pseries/setup.c    | 1 -
 arch/powerpc/sysdev/fsl_soc.c             | 1 -
 arch/powerpc/sysdev/tsi108_dev.c          | 1 -
 arch/sparc/kernel/setup_32.c              | 1 -
 arch/sparc/kernel/setup_64.c              | 1 -
 arch/xtensa/platforms/xt2000/setup.c      | 1 -
 arch/xtensa/platforms/xtfpga/setup.c      | 1 -
 block/partitions/efi.h                    | 1 -
 drivers/android/binderfs.c                | 1 -
 drivers/block/drbd/drbd_int.h             | 1 -
 drivers/cdrom/cdrom.c                     | 1 -
 drivers/char/hpet.c                       | 1 -
 drivers/char/mwave/mwavedd.c              | 1 -
 drivers/char/pcmcia/synclink_cs.c         | 1 -
 drivers/char/random.c                     | 1 -
 drivers/hid/hidraw.c                      | 1 -
 drivers/ide/ide-cs.c                      | 1 -
 drivers/ide/ide-disk.c                    | 1 -
 drivers/ide/ide-floppy.c                  | 1 -
 drivers/ide/ide-io.c                      | 1 -
 drivers/ide/ide-iops.c                    | 1 -
 drivers/ide/ide.c                         | 1 -
 drivers/input/serio/serio_raw.c           | 1 -
 drivers/isdn/capi/capi.c                  | 1 -
 drivers/mmc/host/android-goldfish.c       | 1 -
 drivers/mtd/devices/pmc551.c              | 1 -
 drivers/mtd/devices/slram.c               | 1 -
 drivers/mtd/ftl.c                         | 1 -
 drivers/mtd/maps/uclinux.c                | 1 -
 drivers/net/hamradio/mkiss.c              | 1 -
 drivers/net/tun.c                         | 1 -
 drivers/parport/parport_cs.c              | 1 -
 drivers/pcmcia/cistpl.c                   | 1 -
 drivers/pcmcia/cs.c                       | 1 -
 drivers/pcmcia/socket_sysfs.c             | 1 -
 drivers/s390/block/dasd.c                 | 1 -
 drivers/s390/block/dasd_ioctl.c           | 1 -
 drivers/s390/char/raw3270.c               | 1 -
 drivers/s390/char/tape_class.h            | 1 -
 drivers/s390/scsi/zfcp_def.h              | 1 -
 drivers/sbus/char/display7seg.c           | 1 -
 drivers/scsi/nsp32.c                      | 1 -
 drivers/scsi/pcmcia/aha152x_stub.c        | 1 -
 drivers/scsi/pcmcia/nsp_cs.c              | 1 -
 drivers/scsi/pcmcia/qlogic_stub.c         | 1 -
 drivers/tty/hvc/hvc_console.c             | 1 -
 drivers/tty/hvc/hvcs.c                    | 1 -
 drivers/tty/hvc/hvsi.c                    | 1 -
 drivers/tty/moxa.c                        | 1 -
 drivers/tty/mxser.c                       | 1 -
 drivers/tty/n_gsm.c                       | 1 -
 drivers/tty/n_tty.c                       | 1 -
 drivers/tty/rocket.c                      | 1 -
 drivers/tty/serial/8250/serial_cs.c       | 1 -
 drivers/tty/serial/icom.c                 | 1 -
 drivers/tty/serial/sh-sci.c               | 1 -
 drivers/tty/synclink.c                    | 1 -
 drivers/tty/synclink_gt.c                 | 1 -
 drivers/tty/synclinkmp.c                  | 1 -
 drivers/tty/sysrq.c                       | 1 -
 drivers/tty/tty_ioctl.c                   | 1 -
 drivers/tty/vt/vt_ioctl.c                 | 1 -
 drivers/watchdog/cpwd.c                   | 1 -
 drivers/xen/evtchn.c                      | 1 -
 fs/block_dev.c                            | 1 -
 fs/char_dev.c                             | 1 -
 fs/coda/psdev.c                           | 1 -
 fs/xfs/xfs_linux.h                        | 1 -
 include/linux/blkdev.h                    | 1 -
 include/linux/genhd.h                     | 1 -
 include/linux/tty.h                       | 1 -
 init/do_mounts.h                          | 1 -
 kernel/bpf/inode.c                        | 1 -
 net/ipv4/ipconfig.c                       | 1 -
 tools/hv/hv_vss_daemon.c                  | 1 -
 101 files changed, 101 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index d5367a1c6300..ad0796b45118 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -27,7 +27,6 @@
 #include <linux/utsname.h>
 #include <linux/time.h>
 #include <linux/timex.h>
-#include <linux/major.h>
 #include <linux/stat.h>
 #include <linux/mman.h>
 #include <linux/shm.h>
diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index b45f0b0d6511..db828c6d8405 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -23,7 +23,6 @@
 #include <linux/ptrace.h>
 #include <linux/user.h>
 #include <linux/time.h>
-#include <linux/major.h>
 #include <linux/stat.h>
 #include <linux/vt.h>
 #include <linux/mman.h>
diff --git a/arch/arm/mach-iop32x/i2c.c b/arch/arm/mach-iop32x/i2c.c
index e422286af469..07f10ce0d83a 100644
--- a/arch/arm/mach-iop32x/i2c.c
+++ b/arch/arm/mach-iop32x/i2c.c
@@ -9,7 +9,6 @@
=20
 #include <linux/mm.h>
 #include <linux/init.h>
-#include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/platform_device.h>
 #include <linux/serial.h>
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 4249984f9c30..5d68745c9986 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -13,7 +13,6 @@
 #include <linux/gpio.h>
 #include <linux/types.h>
 #include <linux/init.h>
-#include <linux/major.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/errno.h>
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 593c7f793da5..7e7192553367 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -12,7 +12,6 @@
 #include <linux/module.h>	/* symbol_get ; symbol_put */
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/interrupt.h>
 #include <linux/leds.h>
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 742d18a1f7dc..2c6ab18e2870 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -18,7 +18,6 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/syscore_ops.h>
-#include <linux/major.h>
 #include <linux/fb.h>
 #include <linux/interrupt.h>
 #include <linux/mtd/mtd.h>
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 3d2c108e911e..a0976772f06d 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -12,7 +12,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 3aa34e9a15d3..3d4868bd0c4e 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -26,7 +26,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-#include <linux/major.h>
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/sched.h>
diff --git a/arch/m68k/atari/atasound.c b/arch/m68k/atari/atasound.c
index a8724d998c39..9c7696100aba 100644
--- a/arch/m68k/atari/atasound.c
+++ b/arch/m68k/atari/atasound.c
@@ -18,7 +18,6 @@
=20
 #include <linux/sched.h>
 #include <linux/timer.h>
-#include <linux/major.h>
 #include <linux/fcntl.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
diff --git a/arch/m68k/atari/stram.c b/arch/m68k/atari/stram.c
index ce79b322a99c..7bf922ae8a8a 100644
--- a/arch/m68k/atari/stram.c
+++ b/arch/m68k/atari/stram.c
@@ -12,7 +12,6 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/kdev_t.h>
-#include <linux/major.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
diff --git a/arch/m68k/bvme6000/config.c b/arch/m68k/bvme6000/config.c
index 50f4d01363df..5d34f4afe8b6 100644
--- a/arch/m68k/bvme6000/config.c
+++ b/arch/m68k/bvme6000/config.c
@@ -22,7 +22,6 @@
 #include <linux/console.h>
 #include <linux/linkage.h>
 #include <linux/init.h>
-#include <linux/major.h>
 #include <linux/genhd.h>
 #include <linux/rtc.h>
 #include <linux/interrupt.h>
diff --git a/arch/m68k/mvme147/config.c b/arch/m68k/mvme147/config.c
index 490700aa2212..89c3bf2972cd 100644
--- a/arch/m68k/mvme147/config.c
+++ b/arch/m68k/mvme147/config.c
@@ -21,7 +21,6 @@
 #include <linux/console.h>
 #include <linux/linkage.h>
 #include <linux/init.h>
-#include <linux/major.h>
 #include <linux/genhd.h>
 #include <linux/rtc.h>
 #include <linux/interrupt.h>
diff --git a/arch/m68k/mvme16x/config.c b/arch/m68k/mvme16x/config.c
index 5b86d10e0f84..9d3980cd4137 100644
--- a/arch/m68k/mvme16x/config.c
+++ b/arch/m68k/mvme16x/config.c
@@ -23,7 +23,6 @@
 #include <linux/console.h>
 #include <linux/linkage.h>
 #include <linux/init.h>
-#include <linux/major.h>
 #include <linux/genhd.h>
 #include <linux/rtc.h>
 #include <linux/interrupt.h>
diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
index 4627de3c0603..b337a896a9af 100644
--- a/arch/m68k/q40/config.c
+++ b/arch/m68k/q40/config.c
@@ -20,7 +20,6 @@
 #include <linux/console.h>
 #include <linux/linkage.h>
 #include <linux/init.h>
-#include <linux/major.h>
 #include <linux/serial_reg.h>
 #include <linux/rtc.h>
 #include <linux/vt_kern.h>
diff --git a/arch/mips/fw/arc/arc_con.c b/arch/mips/fw/arc/arc_con.c
index 365e3913231e..267831bb8dac 100644
--- a/arch/mips/fw/arc/arc_con.c
+++ b/arch/mips/fw/arc/arc_con.c
@@ -8,7 +8,6 @@
  * Copyright (c) 2002 Thiemo Seufer
  */
 #include <linux/tty.h>
-#include <linux/major.h>
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/fs.h>
diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/=
83xx/km83xx.c
index bcdc2c203ec9..a60d6f0df153 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -14,7 +14,6 @@
 #include <linux/reboot.h>
 #include <linux/pci.h>
 #include <linux/kdev_t.h>
-#include <linux/major.h>
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platf=
orms/83xx/mpc832x_mds.c
index 6fa5402ebf20..e64cd15d20c8 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -13,7 +13,6 @@
 #include <linux/reboot.h>
 #include <linux/pci.h>
 #include <linux/kdev_t.h>
-#include <linux/major.h>
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platf=
orms/83xx/mpc834x_itx.c
index ebfd139bca20..8db822458d33 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -14,7 +14,6 @@
 #include <linux/reboot.h>
 #include <linux/pci.h>
 #include <linux/kdev_t.h>
-#include <linux/major.h>
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platf=
orms/83xx/mpc834x_mds.c
index 356228e35279..24e719e29e15 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -14,7 +14,6 @@
 #include <linux/reboot.h>
 #include <linux/pci.h>
 #include <linux/kdev_t.h>
-#include <linux/major.h>
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platf=
orms/83xx/mpc836x_mds.c
index 90d9cbfae659..51e44ad28656 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -20,7 +20,6 @@
 #include <linux/reboot.h>
 #include <linux/pci.h>
 #include <linux/kdev_t.h>
-#include <linux/major.h>
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platf=
orms/85xx/mpc85xx_cds.c
index 172d2b7cfeb7..85a100dafd6e 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -14,7 +14,6 @@
 #include <linux/reboot.h>
 #include <linux/pci.h>
 #include <linux/kdev_t.h>
-#include <linux/major.h>
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platf=
orms/85xx/mpc85xx_mds.c
index 7759eca7d535..7a3a14d4492f 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -20,7 +20,6 @@
 #include <linux/reboot.h>
 #include <linux/pci.h>
 #include <linux/kdev_t.h>
-#include <linux/major.h>
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms=
/85xx/sbc8548.c
index e4acf5ce6b07..29ab427aa852 100644
--- a/arch/powerpc/platforms/85xx/sbc8548.c
+++ b/arch/powerpc/platforms/85xx/sbc8548.c
@@ -16,7 +16,6 @@
 #include <linux/reboot.h>
 #include <linux/pci.h>
 #include <linux/kdev_t.h>
-#include <linux/major.h>
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/c=
hrp/setup.c
index c45435aa5e36..4400adcdeff1 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -18,7 +18,6 @@
 #include <linux/ptrace.h>
 #include <linux/user.h>
 #include <linux/tty.h>
-#include <linux/major.h>
 #include <linux/interrupt.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/=
maple/setup.c
index f7e66a2005b4..e2627797f97a 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -22,7 +22,6 @@
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
-#include <linux/major.h>
 #include <linux/initrd.h>
 #include <linux/vt_kern.h>
 #include <linux/console.h>
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platfor=
ms/powermac/setup.c
index f002b0fa69b8..d22a9bedfc25 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -32,7 +32,6 @@
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
-#include <linux/major.h>
 #include <linux/initrd.h>
 #include <linux/vt_kern.h>
 #include <linux/console.h>
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platform=
s/pseries/setup.c
index 2db8469e475f..4beeebc6751b 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -21,7 +21,6 @@
 #include <linux/unistd.h>
 #include <linux/user.h>
 #include <linux/tty.h>
-#include <linux/major.h>
 #include <linux/interrupt.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 90ad16161604..9687c5d15200 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -12,7 +12,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/errno.h>
-#include <linux/major.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/export.h>
diff --git a/arch/powerpc/sysdev/tsi108_dev.c b/arch/powerpc/sysdev/tsi108_=
dev.c
index 0baec82510b9..ec4ec93190a2 100644
--- a/arch/powerpc/sysdev/tsi108_dev.c
+++ b/arch/powerpc/sysdev/tsi108_dev.c
@@ -9,7 +9,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/errno.h>
-#include <linux/major.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/export.h>
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 6d07b85b9e24..e00e0236830a 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -23,7 +23,6 @@
 #include <linux/seq_file.h>
 #include <linux/syscalls.h>
 #include <linux/kdev_t.h>
-#include <linux/major.h>
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index f765fda871eb..7d7091e1253a 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -21,7 +21,6 @@
 #include <linux/seq_file.h>
 #include <linux/syscalls.h>
 #include <linux/kdev_t.h>
-#include <linux/major.h>
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/inet.h>
diff --git a/arch/xtensa/platforms/xt2000/setup.c b/arch/xtensa/platforms/x=
t2000/setup.c
index 145d129be76f..278feee56092 100644
--- a/arch/xtensa/platforms/xt2000/setup.c
+++ b/arch/xtensa/platforms/xt2000/setup.c
@@ -16,7 +16,6 @@
 #include <linux/reboot.h>
 #include <linux/kdev_t.h>
 #include <linux/types.h>
-#include <linux/major.h>
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/stringify.h>
diff --git a/arch/xtensa/platforms/xtfpga/setup.c b/arch/xtensa/platforms/x=
tfpga/setup.c
index 4f7d6142d41f..ddaaaa6e25fd 100644
--- a/arch/xtensa/platforms/xtfpga/setup.c
+++ b/arch/xtensa/platforms/xtfpga/setup.c
@@ -18,7 +18,6 @@
 #include <linux/reboot.h>
 #include <linux/kdev_t.h>
 #include <linux/types.h>
-#include <linux/major.h>
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/of.h>
diff --git a/block/partitions/efi.h b/block/partitions/efi.h
index 8cc2b88d0aa8..1910f16faa37 100644
--- a/block/partitions/efi.h
+++ b/block/partitions/efi.h
@@ -15,7 +15,6 @@
 #include <linux/fs.h>
 #include <linux/genhd.h>
 #include <linux/kernel.h>
-#include <linux/major.h>
 #include <linux/string.h>
 #include <linux/efi.h>
 #include <linux/compiler.h>
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 7cf566aafe1f..2b91c91ec874 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -13,7 +13,6 @@
 #include <linux/list.h>
 #include <linux/namei.h>
 #include <linux/magic.h>
-#include <linux/major.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 14345a87c7cc..d634e475f1ee 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -24,7 +24,6 @@
 #include <linux/ratelimit.h>
 #include <linux/tcp.h>
 #include <linux/mutex.h>
-#include <linux/major.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/genhd.h>
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index d82b3b7658bd..67d0f529454a 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -268,7 +268,6 @@
 #include <linux/atomic.h>
 #include <linux/module.h>
 #include <linux/fs.h>
-#include <linux/major.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index ed3b7dab678d..28a46d1de2d9 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -12,7 +12,6 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/miscdevice.h>
-#include <linux/major.h>
 #include <linux/ioport.h>
 #include <linux/fcntl.h>
 #include <linux/init.h>
diff --git a/drivers/char/mwave/mwavedd.c b/drivers/char/mwave/mwavedd.c
index e43c876a9223..9d4d823865f5 100644
--- a/drivers/char/mwave/mwavedd.c
+++ b/drivers/char/mwave/mwavedd.c
@@ -50,7 +50,6 @@
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/init.h>
-#include <linux/major.h>
 #include <linux/miscdevice.h>
 #include <linux/device.h>
 #include <linux/serial.h>
diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/syncli=
nk_cs.c
index e342daa73d1b..7cdc84f5efe3 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -45,7 +45,6 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/serial.h>
-#include <linux/major.h>
 #include <linux/string.h>
 #include <linux/fcntl.h>
 #include <linux/ptrace.h>
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2a41b21623ae..2b540f396d3d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -312,7 +312,6 @@
 #include <linux/utsname.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/major.h>
 #include <linux/string.h>
 #include <linux/fcntl.h>
 #include <linux/slab.h>
diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 2eee5e31c2b7..e0094bcb11bd 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -21,7 +21,6 @@
 #include <linux/cdev.h>
 #include <linux/poll.h>
 #include <linux/device.h>
-#include <linux/major.h>
 #include <linux/slab.h>
 #include <linux/hid.h>
 #include <linux/mutex.h>
diff --git a/drivers/ide/ide-cs.c b/drivers/ide/ide-cs.c
index f1e922e2479a..cc2b0fa73743 100644
--- a/drivers/ide/ide-cs.c
+++ b/drivers/ide/ide-cs.c
@@ -38,7 +38,6 @@
 #include <linux/timer.h>
 #include <linux/ioport.h>
 #include <linux/ide.h>
-#include <linux/major.h>
 #include <linux/delay.h>
 #include <asm/io.h>
=20
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 1d3407d7e095..9339ebd97468 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -21,7 +21,6 @@
 #include <linux/timer.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
-#include <linux/major.h>
 #include <linux/errno.h>
 #include <linux/genhd.h>
 #include <linux/slab.h>
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 1fe1f9d37a51..2f815538a4f5 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -24,7 +24,6 @@
 #include <linux/timer.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
-#include <linux/major.h>
 #include <linux/errno.h>
 #include <linux/genhd.h>
 #include <linux/cdrom.h>
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index c31f1d2b3b07..2a1a79a83d77 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -31,7 +31,6 @@
 #include <linux/timer.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
-#include <linux/major.h>
 #include <linux/errno.h>
 #include <linux/genhd.h>
 #include <linux/blkpg.h>
diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
index f2be127ee96e..bdf5a0e2b969 100644
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -12,7 +12,6 @@
 #include <linux/timer.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
-#include <linux/major.h>
 #include <linux/errno.h>
 #include <linux/genhd.h>
 #include <linux/blkpg.h>
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index 9a9c64fd1032..89f75dd49a3f 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -50,7 +50,6 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
-#include <linux/major.h>
 #include <linux/errno.h>
 #include <linux/genhd.h>
 #include <linux/init.h>
diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_ra=
w.c
index e9647ebff187..c863fc913acb 100644
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -12,7 +12,6 @@
 #include <linux/poll.h>
 #include <linux/module.h>
 #include <linux/serio.h>
-#include <linux/major.h>
 #include <linux/device.h>
 #include <linux/miscdevice.h>
 #include <linux/wait.h>
diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index 85767f52fe3c..21b537efc992 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -13,7 +13,6 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
-#include <linux/major.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/fcntl.h>
diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android=
-goldfish.c
index ceb4924e02d0..d67eb2942d1c 100644
--- a/drivers/mmc/host/android-goldfish.c
+++ b/drivers/mmc/host/android-goldfish.c
@@ -12,7 +12,6 @@
=20
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/major.h>
=20
 #include <linux/types.h>
 #include <linux/pci.h>
diff --git a/drivers/mtd/devices/pmc551.c b/drivers/mtd/devices/pmc551.c
index 6597fc2aad34..12c4cb142e65 100644
--- a/drivers/mtd/devices/pmc551.c
+++ b/drivers/mtd/devices/pmc551.c
@@ -85,7 +85,6 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/timer.h>
-#include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/ioctl.h>
 #include <asm/io.h>
diff --git a/drivers/mtd/devices/slram.c b/drivers/mtd/devices/slram.c
index 28131a127d06..68dbf795071e 100644
--- a/drivers/mtd/devices/slram.c
+++ b/drivers/mtd/devices/slram.c
@@ -38,7 +38,6 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/timer.h>
-#include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/ioctl.h>
 #include <linux/init.h>
diff --git a/drivers/mtd/ftl.c b/drivers/mtd/ftl.c
index 2578f27914ef..4c14aa6ee676 100644
--- a/drivers/mtd/ftl.c
+++ b/drivers/mtd/ftl.c
@@ -64,7 +64,6 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/timer.h>
-#include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/hdreg.h>
diff --git a/drivers/mtd/maps/uclinux.c b/drivers/mtd/maps/uclinux.c
index de4c46318abb..0c536a785139 100644
--- a/drivers/mtd/maps/uclinux.c
+++ b/drivers/mtd/maps/uclinux.c
@@ -16,7 +16,6 @@
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
-#include <linux/major.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>
diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index deef14215110..50d9de805740 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -18,7 +18,6 @@
 #include <linux/tty.h>
 #include <linux/errno.h>
 #include <linux/netdevice.h>
-#include <linux/major.h>
 #include <linux/init.h>
 #include <linux/rtnetlink.h>
 #include <linux/etherdevice.h>
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 858b012074bd..14015eff5b99 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -36,7 +36,6 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/sched/signal.h>
-#include <linux/major.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
 #include <linux/fcntl.h>
diff --git a/drivers/parport/parport_cs.c b/drivers/parport/parport_cs.c
index 8e7e3ac4bb87..7fa5ddccb055 100644
--- a/drivers/parport/parport_cs.c
+++ b/drivers/parport/parport_cs.c
@@ -42,7 +42,6 @@
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/ioport.h>
-#include <linux/major.h>
 #include <linux/interrupt.h>
=20
 #include <linux/parport.h>
diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index cf109d9a1112..86f24ff10500 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -13,7 +13,6 @@
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
-#include <linux/major.h>
 #include <linux/errno.h>
 #include <linux/timer.h>
 #include <linux/slab.h>
diff --git a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
index e211e2619680..fd59a68102e7 100644
--- a/drivers/pcmcia/cs.c
+++ b/drivers/pcmcia/cs.c
@@ -14,7 +14,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
-#include <linux/major.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
diff --git a/drivers/pcmcia/socket_sysfs.c b/drivers/pcmcia/socket_sysfs.c
index d1b220a1e1ab..47eb78bddcdd 100644
--- a/drivers/pcmcia/socket_sysfs.c
+++ b/drivers/pcmcia/socket_sysfs.c
@@ -10,7 +10,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
-#include <linux/major.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index cf87eb27879f..024653f0de4c 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -15,7 +15,6 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/ctype.h>
-#include <linux/major.h>
 #include <linux/slab.h>
 #include <linux/hdreg.h>
 #include <linux/async.h>
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioct=
l.c
index 777734d1b4e5..f39a7f466da6 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -14,7 +14,6 @@
=20
 #include <linux/interrupt.h>
 #include <linux/compat.h>
-#include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/blkpg.h>
 #include <linux/slab.h>
diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index 63a41b168761..9aaa967dfde4 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -24,7 +24,6 @@
=20
 #include "raw3270.h"
=20
-#include <linux/major.h>
 #include <linux/kdev_t.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
diff --git a/drivers/s390/char/tape_class.h b/drivers/s390/char/tape_class.h
index d25ac075b1ad..564c3110a651 100644
--- a/drivers/s390/char/tape_class.h
+++ b/drivers/s390/char/tape_class.h
@@ -13,7 +13,6 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/fs.h>
-#include <linux/major.h>
 #include <linux/cdev.h>
=20
 #include <linux/device.h>
diff --git a/drivers/s390/scsi/zfcp_def.h b/drivers/s390/scsi/zfcp_def.h
index da8a5ceb615c..56cc641eade1 100644
--- a/drivers/s390/scsi/zfcp_def.h
+++ b/drivers/s390/scsi/zfcp_def.h
@@ -14,7 +14,6 @@
=20
 #include <linux/init.h>
 #include <linux/moduleparam.h>
-#include <linux/major.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/timer.h>
diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7se=
g.c
index fad936eb845f..8d08fff8194d 100644
--- a/drivers/sbus/char/display7seg.c
+++ b/drivers/sbus/char/display7seg.c
@@ -10,7 +10,6 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/errno.h>
-#include <linux/major.h>
 #include <linux/miscdevice.h>
 #include <linux/ioport.h>		/* request_region */
 #include <linux/slab.h>
diff --git a/drivers/scsi/nsp32.c b/drivers/scsi/nsp32.c
index b6e04d14292d..92428ba6875c 100644
--- a/drivers/scsi/nsp32.c
+++ b/drivers/scsi/nsp32.c
@@ -19,7 +19,6 @@
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/ioport.h>
-#include <linux/major.h>
 #include <linux/blkdev.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
diff --git a/drivers/scsi/pcmcia/aha152x_stub.c b/drivers/scsi/pcmcia/aha15=
2x_stub.c
index df82a349e969..b37c050a2057 100644
--- a/drivers/scsi/pcmcia/aha152x_stub.c
+++ b/drivers/scsi/pcmcia/aha152x_stub.c
@@ -41,7 +41,6 @@
 #include <linux/string.h>
 #include <linux/ioport.h>
 #include <scsi/scsi.h>
-#include <linux/major.h>
 #include <linux/blkdev.h>
 #include <scsi/scsi_ioctl.h>
=20
diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
index d79ce97a04bd..cf9de1d0f6bf 100644
--- a/drivers/scsi/pcmcia/nsp_cs.c
+++ b/drivers/scsi/pcmcia/nsp_cs.c
@@ -34,7 +34,6 @@
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <linux/major.h>
 #include <linux/blkdev.h>
 #include <linux/stat.h>
=20
diff --git a/drivers/scsi/pcmcia/qlogic_stub.c b/drivers/scsi/pcmcia/qlogic=
_stub.c
index 828d53faf09a..9c064ddf1644 100644
--- a/drivers/scsi/pcmcia/qlogic_stub.c
+++ b/drivers/scsi/pcmcia/qlogic_stub.c
@@ -39,7 +39,6 @@
 #include <linux/ioport.h>
 #include <asm/io.h>
 #include <scsi/scsi.h>
-#include <linux/major.h>
 #include <linux/blkdev.h>
 #include <scsi/scsi_ioctl.h>
 #include <linux/interrupt.h>
diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index cdcc64ea2554..2438c9ad3821 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -16,7 +16,6 @@
 #include <linux/kernel.h>
 #include <linux/kthread.h>
 #include <linux/list.h>
-#include <linux/major.h>
 #include <linux/atomic.h>
 #include <linux/sysrq.h>
 #include <linux/tty.h>
diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 55105ac38f89..533d0abff068 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -57,7 +57,6 @@
 #include <linux/kref.h>
 #include <linux/kthread.h>
 #include <linux/list.h>
-#include <linux/major.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/sched.h>
diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
index 66f95f758be0..c7465cda0d33 100644
--- a/drivers/tty/hvc/hvsi.c
+++ b/drivers/tty/hvc/hvsi.c
@@ -24,7 +24,6 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/major.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/sysrq.h>
diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 9f13f7d49dd7..75f0cb5ddd18 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -29,7 +29,6 @@
 #include <linux/interrupt.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
-#include <linux/major.h>
 #include <linux/string.h>
 #include <linux/fcntl.h>
 #include <linux/ptrace.h>
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 3703987c4666..a78ee27a5b60 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -25,7 +25,6 @@
 #include <linux/tty_flip.h>
 #include <linux/serial.h>
 #include <linux/serial_reg.h>
-#include <linux/major.h>
 #include <linux/string.h>
 #include <linux/fcntl.h>
 #include <linux/ptrace.h>
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 0a29a94ec438..9a3a96372efd 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -23,7 +23,6 @@
  */
=20
 #include <linux/types.h>
-#include <linux/major.h>
 #include <linux/errno.h>
 #include <linux/signal.h>
 #include <linux/fcntl.h>
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 1794d84e7bf6..50605ce1c85d 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -29,7 +29,6 @@
  */
=20
 #include <linux/types.h>
-#include <linux/major.h>
 #include <linux/errno.h>
 #include <linux/signal.h>
 #include <linux/fcntl.h>
diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index 2540b2e4c8e8..5797e59a5adb 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -48,7 +48,6 @@
=20
 #include <linux/module.h>
 #include <linux/errno.h>
-#include <linux/major.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/=
serial_cs.c
index e3d10794dbba..4cd8ddd73d70 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -41,7 +41,6 @@
 #include <linux/timer.h>
 #include <linux/serial_core.h>
 #include <linux/delay.h>
-#include <linux/major.h>
 #include <asm/io.h>
=20
 #include <pcmcia/cistpl.h>
diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 624f3d541c68..cdb92f2ca114 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -20,7 +20,6 @@
 #include <linux/tty_flip.h>
 #include <linux/serial.h>
 #include <linux/serial_reg.h>
-#include <linux/major.h>
 #include <linux/string.h>
 #include <linux/fcntl.h>
 #include <linux/ptrace.h>
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e1179e74a2b8..87e241c37f65 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -30,7 +30,6 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/ktime.h>
-#include <linux/major.h>
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/of.h>
diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index 08d2976593d5..f1f30147cb8c 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -70,7 +70,6 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/serial.h>
-#include <linux/major.h>
 #include <linux/string.h>
 #include <linux/fcntl.h>
 #include <linux/ptrace.h>
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index b794177ccfb9..a2c8f613f2c8 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -53,7 +53,6 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/serial.h>
-#include <linux/major.h>
 #include <linux/string.h>
 #include <linux/fcntl.h>
 #include <linux/ptrace.h>
diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index 33ff2dbb6650..06c476e950fb 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -44,7 +44,6 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/serial.h>
-#include <linux/major.h>
 #include <linux/string.h>
 #include <linux/fcntl.h>
 #include <linux/ptrace.h>
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 7c95afa905a0..19bb2d84de79 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -24,7 +24,6 @@
 #include <linux/fs.h>
 #include <linux/mount.h>
 #include <linux/kdev_t.h>
-#include <linux/major.h>
 #include <linux/reboot.h>
 #include <linux/sysrq.h>
 #include <linux/kbd_kern.h>
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 9245fffdbceb..d94353dd6ed7 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -12,7 +12,6 @@
 #include <linux/errno.h>
 #include <linux/sched/signal.h>
 #include <linux/kernel.h>
-#include <linux/major.h>
 #include <linux/tty.h>
 #include <linux/fcntl.h>
 #include <linux/string.h>
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index daf61c28ba76..6ce35b4cc1e7 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -21,7 +21,6 @@
 #include <linux/vt.h>
 #include <linux/string.h>
 #include <linux/slab.h>
-#include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/console.h>
 #include <linux/consolemap.h>
diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 808eeb4779e4..b7a7a53dc7f1 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -21,7 +21,6 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/errno.h>
-#include <linux/major.h>
 #include <linux/miscdevice.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
index 6e0b1dd5573c..054f13c8abf4 100644
--- a/drivers/xen/evtchn.c
+++ b/drivers/xen/evtchn.c
@@ -41,7 +41,6 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
-#include <linux/major.h>
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
 #include <linux/poll.h>
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 47860e589388..edb053cae078 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -11,7 +11,6 @@
 #include <linux/fcntl.h>
 #include <linux/slab.h>
 #include <linux/kmod.h>
-#include <linux/major.h>
 #include <linux/device_cgroup.h>
 #include <linux/highmem.h>
 #include <linux/blkdev.h>
diff --git a/fs/char_dev.c b/fs/char_dev.c
index ba0ded7842a7..cc645798a0ac 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -11,7 +11,6 @@
 #include <linux/slab.h>
 #include <linux/string.h>
=20
-#include <linux/major.h>
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index 240669f51eac..1125bcbf53f3 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -16,7 +16,6 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
-#include <linux/major.h>
 #include <linux/time.h>
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index 9f70d2f68e05..7bb9fb4f2f59 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -38,7 +38,6 @@ typedef __u32			xfs_nlink_t;
 #include <linux/errno.h>
 #include <linux/sched/signal.h>
 #include <linux/bitops.h>
-#include <linux/major.h>
 #include <linux/pagemap.h>
 #include <linux/vfs.h>
 #include <linux/seq_file.h>
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8fd900998b4e..0edac52a9e36 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -7,7 +7,6 @@
=20
 #ifdef CONFIG_BLOCK
=20
-#include <linux/major.h>
 #include <linux/genhd.h>
 #include <linux/list.h>
 #include <linux/llist.h>
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 392aad5e29a2..cf2fe7f67c5b 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -32,7 +32,6 @@ extern struct class block_class;
 #define DISK_MAX_PARTS			256
 #define DISK_NAME_LEN			32
=20
-#include <linux/major.h>
 #include <linux/device.h>
 #include <linux/smp.h>
 #include <linux/string.h>
diff --git a/include/linux/tty.h b/include/linux/tty.h
index a99e9b8e4e31..f2de77662885 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -3,7 +3,6 @@
 #define _LINUX_TTY_H
=20
 #include <linux/fs.h>
-#include <linux/major.h>
 #include <linux/termios.h>
 #include <linux/workqueue.h>
 #include <linux/tty_driver.h>
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 0bb0806de4ce..10f7d73fdb1d 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -6,7 +6,6 @@
 #include <linux/unistd.h>
 #include <linux/slab.h>
 #include <linux/mount.h>
-#include <linux/major.h>
 #include <linux/root_dev.h>
=20
 void  change_floppy(char *fmt, ...);
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index fb878ba3f22f..863af1993433 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -10,7 +10,6 @@
=20
 #include <linux/init.h>
 #include <linux/magic.h>
-#include <linux/major.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/fs.h>
diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 561f15b5a944..0a932d26e5ce 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -53,7 +53,6 @@
 #include <linux/udp.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
-#include <linux/major.h>
 #include <linux/root_dev.h>
 #include <linux/delay.h>
 #include <linux/nfs_fs.h>
diff --git a/tools/hv/hv_vss_daemon.c b/tools/hv/hv_vss_daemon.c
index dd111870beee..6795b078ea03 100644
--- a/tools/hv/hv_vss_daemon.c
+++ b/tools/hv/hv_vss_daemon.c
@@ -21,7 +21,6 @@
 #include <ctype.h>
 #include <errno.h>
 #include <linux/fs.h>
-#include <linux/major.h>
 #include <linux/hyperv.h>
 #include <syslog.h>
 #include <getopt.h>
--=20
2.27.0


--Sig_/SLH5jp.N73//Dr/64_U40xb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7pViQACgkQAVBC80lX
0GxhWAf/VDVWxSLal3vDoa9yA7BgX24/UjMVQtP8GuE5BMRLuXIujYczEm9K+VdQ
DJcrjWA6UAM7azR2M5oCB5VSLhrPbKp6b+/LsEtlHUTCRuPc5wNNS+rDDlXX40V9
ftapCiyoY/ils7zyXHI1izW8WAhZgIVu6peZf/N6lweGD0ZqPW0+OGkZ9RZ0mmmk
Va9CAsKUsnh2px0bHz+UlOc21glC5iqDT0bmGRmX8qOAf+FRcTz8S7nHDwLdIemB
aZX2x0n28vFnVuj09CM9KknGs6JvzmdBoi1nVJyOKLhUt6sLqveV9KdM/3jZRgqr
LL5u/vVeg5f6XcsdvB5vfmmf9aYCEQ==
=YdrU
-----END PGP SIGNATURE-----

--Sig_/SLH5jp.N73//Dr/64_U40xb--
