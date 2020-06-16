Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A631FC24D
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jun 2020 01:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgFPXbZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jun 2020 19:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgFPXbW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jun 2020 19:31:22 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2605C061573;
        Tue, 16 Jun 2020 16:31:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49mkwk1sT8z9sRR;
        Wed, 17 Jun 2020 09:31:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1592350278;
        bh=1CKBqFAc7WvGdyWyuVnLDnRC2fswSwrHDOjeLFGSXY4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RfTiy/BaU3y6Awz1cnE76HqwnfBvOB22RF6rmZmslUplIiTSJCICKn6w0+wXRoWJM
         ctMCUE7Ko9iZY4rdSh0/FYd2ROybBhmLf+LrP5uxn9lSvYOlFe0ECIwUKS9OyjRMds
         HtclXypoFqn7KC9D3gSZxWWkskzQM2GO1jfrgVQbW4ZV4UvzKeIHmTqoFA2u+2E2eV
         Ip7EubzeVWcppg/HAdS9eIdqprWS/T5dws6kDq0R0eUR3u7OzZQalxszDRg+oEv+wW
         TzNxmqMqMGYrPBfdEy92NUfWkcq1EW6bpOMFjR9+HPaQlZzM+XQ+40FIQkqZ7ewLFR
         lZYu0+8o9q0wg==
Date:   Wed, 17 Jun 2020 09:27:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <greg@kroah.com>
Subject: [RFC PATCH 1/2] Explicitly include linux/major.h where it is needed
Message-ID: <20200617092747.0cadb2de@canb.auug.org.au>
In-Reply-To: <20200617092614.7897ccb2@canb.auug.org.au>
References: <20200617092614.7897ccb2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sIq1QwnWVT.h+seLQbSpBld";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/sIq1QwnWVT.h+seLQbSpBld
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

This is in preparation for removing the include of major.h where it is
not needed.

These files were found using

	grep -E -L '[<"](uapi/)?linux/major\.h' $(git grep -l -w -f /tmp/xx)

where /tmp/xx contains all the symbols defined in major.h.  There were
a couple of files in that list that did not need the include since the
references are in comments.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/um/drivers/ubd_kern.c                       | 1 +
 block/genhd.c                                    | 1 +
 drivers/block/amiflop.c                          | 1 +
 drivers/block/ataflop.c                          | 1 +
 drivers/block/drbd/drbd_main.c                   | 1 +
 drivers/block/floppy.c                           | 1 +
 drivers/block/swim.c                             | 1 +
 drivers/block/swim3.c                            | 1 +
 drivers/block/xen-blkfront.c                     | 1 +
 drivers/char/mem.c                               | 1 +
 drivers/char/ttyprintk.c                         | 1 +
 drivers/md/md.c                                  | 1 +
 drivers/message/fusion/mptctl.c                  | 1 +
 drivers/misc/vmw_vmci/vmci_host.c                | 1 +
 drivers/mmc/core/block.c                         | 1 +
 drivers/s390/block/dasd_genhd.c                  | 1 +
 drivers/s390/block/xpram.c                       | 1 +
 drivers/s390/char/con3215.c                      | 1 +
 drivers/s390/char/fs3270.c                       | 1 +
 drivers/s390/char/sclp_tty.c                     | 1 +
 drivers/s390/char/tty3270.c                      | 1 +
 drivers/scsi/sd.c                                | 1 +
 drivers/scsi/sg.c                                | 1 +
 drivers/scsi/sr.c                                | 1 +
 drivers/scsi/st.c                                | 1 +
 drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c | 1 +
 drivers/staging/speakup/devsynth.c               | 1 +
 drivers/tty/serial/8250/8250_core.c              | 1 +
 drivers/tty/serial/apbuart.c                     | 1 +
 drivers/tty/serial/atmel_serial.c                | 1 +
 drivers/tty/serial/bcm63xx_uart.c                | 1 +
 drivers/tty/serial/mcf.c                         | 1 +
 drivers/tty/serial/mux.c                         | 1 +
 drivers/tty/serial/pxa.c                         | 1 +
 drivers/tty/serial/serial_txx9.c                 | 1 +
 drivers/watchdog/watchdog_dev.c                  | 1 +
 drivers/xen/gntalloc.c                           | 1 +
 fs/devpts/inode.c                                | 1 +
 fs/proc/proc_tty.c                               | 1 +
 include/uapi/linux/raid/md_u.h                   | 2 ++
 init/do_mounts.c                                 | 1 +
 init/do_mounts_md.c                              | 1 +
 init/do_mounts_rd.c                              | 1 +
 43 files changed, 44 insertions(+)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index eae8c83364f7..237babca7fac 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -35,6 +35,7 @@
 #include <linux/vmalloc.h>
 #include <linux/platform_device.h>
 #include <linux/scatterlist.h>
+#include <linux/major.h>
 #include <asm/tlbflush.h>
 #include <kern_util.h>
 #include "mconsole_kern.h"
diff --git a/block/genhd.c b/block/genhd.c
index 1a7659327664..5231ece77fc0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -23,6 +23,7 @@
 #include <linux/log2.h>
 #include <linux/pm_runtime.h>
 #include <linux/badblocks.h>
+#include <linux/major.h>
=20
 #include "blk.h"
=20
diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 226219da3da6..1f7ccf05dc06 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -67,6 +67,7 @@
 #include <linux/elevator.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/major.h>
=20
 #include <asm/setup.h>
 #include <linux/uaccess.h>
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 1553d41f0b91..07247178d1f0 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -71,6 +71,7 @@
 #include <linux/mutex.h>
 #include <linux/completion.h>
 #include <linux/wait.h>
+#include <linux/major.h>
=20
 #include <asm/atariints.h>
 #include <asm/atari_stdma.h>
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 45fbd526c453..b6bf26e9cc12 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -41,6 +41,7 @@
 #include <linux/unistd.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/signal.h>
+#include <linux/major.h>
=20
 #include <linux/drbd_limits.h>
 #include "drbd_int.h"
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 3e9db22db2a8..1130ef91511d 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -193,6 +193,7 @@ static int print_unex =3D 1;
 #include <linux/uaccess.h>
 #include <linux/async.h>
 #include <linux/compat.h>
+#include <linux/major.h>
=20
 /*
  * PS/2 floppies have much slower step rates than regular floppies.
diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index dd34504382e5..2e2825db7887 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/major.h>
=20
 #include <asm/mac_via.h>
=20
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index aa77eb5fb7de..1a1f0c6ea7df 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
+#include <linux/major.h>
 #include <asm/io.h>
 #include <asm/dbdma.h>
 #include <asm/prom.h>
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 3b889ea950c2..8478bd553213 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -48,6 +48,7 @@
 #include <linux/list.h>
 #include <linux/workqueue.h>
 #include <linux/sched/mm.h>
+#include <linux/major.h>
=20
 #include <xen/xen.h>
 #include <xen/xenbus.h>
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 31cae88a730b..e20dc05d0cc0 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -34,6 +34,7 @@
 #include <linux/pseudo_fs.h>
 #include <uapi/linux/magic.h>
 #include <linux/mount.h>
+#include <linux/major.h>
=20
 #ifdef CONFIG_IA64
 # include <linux/efi.h>
diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
index 56db949a7b70..77fe7ef90c96 100644
--- a/drivers/char/ttyprintk.c
+++ b/drivers/char/ttyprintk.c
@@ -16,6 +16,7 @@
 #include <linux/tty.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
+#include <linux/major.h>
=20
 struct ttyprintk_port {
 	struct tty_port port;
diff --git a/drivers/md/md.c b/drivers/md/md.c
index f567f536b529..06741df80c72 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -62,6 +62,7 @@
 #include <linux/slab.h>
 #include <linux/percpu-refcount.h>
 #include <linux/part_stat.h>
+#include <linux/major.h>
=20
 #include <trace/events/block.h>
 #include "md.h"
diff --git a/drivers/message/fusion/mptctl.c b/drivers/message/fusion/mptct=
l.c
index 1074b882c57c..94c6f7f0799e 100644
--- a/drivers/message/fusion/mptctl.c
+++ b/drivers/message/fusion/mptctl.c
@@ -56,6 +56,7 @@
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
 #include <linux/compat.h>
+#include <linux/major.h>
=20
 #include <asm/io.h>
 #include <linux/uaccess.h>
diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci=
_host.c
index 2d8328d928d5..984d1b0437ec 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -24,6 +24,7 @@
 #include <linux/smp.h>
 #include <linux/fs.h>
 #include <linux/io.h>
+#include <linux/major.h>
=20
 #include "vmci_handle_array.h"
 #include "vmci_queue_pair.h"
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 7896952de1ac..c00ea508d890 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -38,6 +38,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/idr.h>
 #include <linux/debugfs.h>
+#include <linux/major.h>
=20
 #include <linux/mmc/ioctl.h>
 #include <linux/mmc/card.h>
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genh=
d.c
index af5b0ecb8f89..d0dab4e48be6 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/fs.h>
 #include <linux/blkpg.h>
+#include <linux/major.h>
=20
 #include <linux/uaccess.h>
=20
diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
index 45a04daec89e..06e8600699bc 100644
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -43,6 +43,7 @@
 #include <linux/platform_device.h>
 #include <linux/gfp.h>
 #include <linux/uaccess.h>
+#include <linux/major.h>
=20
 #define XPRAM_NAME	"xpram"
 #define XPRAM_DEVS	1	/* one partition */
diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 92757f9bd010..66b2c43328c0 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -22,6 +22,7 @@
 #include <linux/reboot.h>
 #include <linux/serial.h> /* ASYNC_* flags */
 #include <linux/slab.h>
+#include <linux/major.h>
 #include <asm/ccwdev.h>
 #include <asm/cio.h>
 #include <asm/io.h>
diff --git a/drivers/s390/char/fs3270.c b/drivers/s390/char/fs3270.c
index 4c4683d8784a..d124c4493a8f 100644
--- a/drivers/s390/char/fs3270.c
+++ b/drivers/s390/char/fs3270.c
@@ -18,6 +18,7 @@
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/major.h>
=20
 #include <asm/ccwdev.h>
 #include <asm/cio.h>
diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index 5aff8b684eb2..1f78e0135510 100644
--- a/drivers/s390/char/sclp_tty.c
+++ b/drivers/s390/char/sclp_tty.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/gfp.h>
 #include <linux/uaccess.h>
+#include <linux/major.h>
=20
 #include "ctrlchar.h"
 #include "sclp.h"
diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index 98d7fc152e32..1480aa5b2a65 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -17,6 +17,7 @@
 #include <linux/console.h>
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
+#include <linux/major.h>
=20
 #include <linux/slab.h>
 #include <linux/memblock.h>
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index d90fefffe31b..0e39639a9d63 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -57,6 +57,7 @@
 #include <linux/pr.h>
 #include <linux/t10-pi.h>
 #include <linux/uaccess.h>
+#include <linux/major.h>
 #include <asm/unaligned.h>
=20
 #include <scsi/scsi.h>
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 20472aaaf630..853c1d82cce6 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -47,6 +47,7 @@ static int sg_version_num =3D 30536;	/* 2 digits for each=
 component */
 #include <linux/ratelimit.h>
 #include <linux/uio.h>
 #include <linux/cred.h> /* for sg_check_file_access() */
+#include <linux/major.h>
=20
 #include "scsi.h"
 #include <scsi/scsi_dbg.h>
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 0c4aa4665a2f..8065f9145cc1 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -50,6 +50,7 @@
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
 #include <linux/uaccess.h>
+#include <linux/major.h>
=20
 #include <asm/unaligned.h>
=20
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 87fbc0ea350b..88a7e35cd9bd 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -42,6 +42,7 @@ static const char *verstr =3D "20160209";
 #include <linux/idr.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
+#include <linux/major.h>
=20
 #include <linux/uaccess.h>
 #include <asm/dma.h>
diff --git a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c b/drivers/sta=
ging/kpc2000/kpc_dma/kpc_dma_driver.c
index c3b30551e0ca..eacab9e2ba16 100644
--- a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
+++ b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
@@ -8,6 +8,7 @@
 #include <linux/platform_device.h>
 #include <linux/fs.h>
 #include <linux/rwsem.h>
+#include <linux/major.h>
 #include "kpc_dma_driver.h"
=20
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/speakup/devsynth.c b/drivers/staging/speakup/d=
evsynth.c
index d30571663585..2980180220a0 100644
--- a/drivers/staging/speakup/devsynth.c
+++ b/drivers/staging/speakup/devsynth.c
@@ -3,6 +3,7 @@
 #include <linux/miscdevice.h>	/* for misc_register, and MISC_DYNAMIC_MINOR=
 */
 #include <linux/types.h>
 #include <linux/uaccess.h>
+#include <linux/major.h>
=20
 #include "speakup.h"
 #include "spk_priv.h"
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/=
8250_core.c
index fc118f649887..6655ace9f872 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -37,6 +37,7 @@
 #ifdef CONFIG_SPARC
 #include <linux/sunserialcore.h>
 #endif
+#include <linux/major.h>
=20
 #include <asm/irq.h>
=20
diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index e8d56e899ec7..ad437d6be45e 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -28,6 +28,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/serial_core.h>
+#include <linux/major.h>
 #include <asm/irq.h>
=20
 #include "apbuart.h"
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_s=
erial.c
index e43471b33710..359a93aba62f 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -30,6 +30,7 @@
 #include <linux/irq.h>
 #include <linux/suspend.h>
 #include <linux/mm.h>
+#include <linux/major.h>
=20
 #include <asm/div64.h>
 #include <asm/io.h>
diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx=
_uart.c
index 5674da2b76f0..0f234aa8eafa 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -25,6 +25,7 @@
 #include <linux/serial_bcm63xx.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/major.h>
=20
 #define BCM63XX_NR_UARTS	2
=20
diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index 7dbfb4cde124..aaadb03cbedb 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/uaccess.h>
 #include <linux/platform_device.h>
+#include <linux/major.h>
 #include <asm/coldfire.h>
 #include <asm/mcfsim.h>
 #include <asm/mcfuart.h>
diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 47ab280f553b..dc62fb72e4c7 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -21,6 +21,7 @@
 #include <linux/console.h>
 #include <linux/delay.h> /* for udelay */
 #include <linux/device.h>
+#include <linux/major.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/parisc-device.h>
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 41319ef96fa6..9b8ae12d7cf0 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -35,6 +35,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/major.h>
=20
 #define PXA_NAME_LEN		8
=20
diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_t=
xx9.c
index b4d89e31730e..df4cd7d08b5b 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -23,6 +23,7 @@
 #include <linux/serial.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include <linux/major.h>
=20
 #include <asm/io.h>
=20
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_de=
v.c
index 7e4cd34a8c20..7147dc472578 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -42,6 +42,7 @@
 #include <linux/types.h>	/* For standard types (like size_t) */
 #include <linux/watchdog.h>	/* For watchdog specific items */
 #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
+#include <linux/major.h>
=20
 #include <uapi/linux/sched/types.h>	/* For struct sched_param */
=20
diff --git a/drivers/xen/gntalloc.c b/drivers/xen/gntalloc.c
index 3fa40c723e8e..26992992cd5f 100644
--- a/drivers/xen/gntalloc.c
+++ b/drivers/xen/gntalloc.c
@@ -63,6 +63,7 @@
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/highmem.h>
+#include <linux/major.h>
=20
 #include <xen/xen.h>
 #include <xen/page.h>
diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 42e5a766d33c..1edda7d190de 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -24,6 +24,7 @@
 #include <linux/parser.h>
 #include <linux/fsnotify.h>
 #include <linux/seq_file.h>
+#include <linux/major.h>
=20
 #define DEVPTS_DEFAULT_MODE 0600
 /*
diff --git a/fs/proc/proc_tty.c b/fs/proc/proc_tty.c
index c69ff191e5d8..1490f26ecc5f 100644
--- a/fs/proc/proc_tty.c
+++ b/fs/proc/proc_tty.c
@@ -15,6 +15,7 @@
 #include <linux/tty.h>
 #include <linux/seq_file.h>
 #include <linux/bitops.h>
+#include <linux/major.h>
 #include "internal.h"
=20
 /*
diff --git a/include/uapi/linux/raid/md_u.h b/include/uapi/linux/raid/md_u.h
index 105307244961..ddc48efc32ee 100644
--- a/include/uapi/linux/raid/md_u.h
+++ b/include/uapi/linux/raid/md_u.h
@@ -16,6 +16,8 @@
 #ifndef _UAPI_MD_U_H
 #define _UAPI_MD_U_H
=20
+#include <linux/major.h>
+
 /*
  * Different major versions are not compatible.
  * Different minor versions are only downward compatible.
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 29d326b6c29d..1aa866d59bde 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/ramfs.h>
 #include <linux/shmem_fs.h>
+#include <linux/major.h>
=20
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
diff --git a/init/do_mounts_md.c b/init/do_mounts_md.c
index b84031528dd4..e20fc6eb4b69 100644
--- a/init/do_mounts_md.c
+++ b/init/do_mounts_md.c
@@ -2,6 +2,7 @@
 #include <linux/delay.h>
 #include <linux/raid/md_u.h>
 #include <linux/raid/md_p.h>
+#include <linux/major.h>
=20
 #include "do_mounts.h"
=20
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 32fb049d18f9..22df2b2c3650 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -8,6 +8,7 @@
 #include <linux/initrd.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/major.h>
=20
 #include "do_mounts.h"
 #include "../fs/squashfs/squashfs_fs.h"
--=20
2.27.0


--Sig_/sIq1QwnWVT.h+seLQbSpBld
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7pVXMACgkQAVBC80lX
0GxQnQf/WRj0UjEMbNWW77ukMspAJ8lsXHv/GE81u+OdZ5p5SUocbkR/u/pasewe
mKHUfeFOrCovdcIi8gqfero07xIXW+ieiuR18NM1KHZyemvcHbB1b+Ge2gXAYkUx
wBVmD6v82Tu+8mP0OTqml22f74AoyIcYc0Ao6BgN4oGbvgh4Ivava1C/APUjWUrI
pjTCjIknfeZMCZZztzWfD+RZZPPmpgXgrVV0i8f5kstznPy+z3MUI5yE86wT9bbr
upmrx45cqlY1MMw2s5h78HwF4Az1svtcdwXQPDky+VrGvjRZ3T4M2eq5QGssq4Kp
7G8bu98eAvrH1isn/8P+jq9E7A4zAQ==
=bPE3
-----END PGP SIGNATURE-----

--Sig_/sIq1QwnWVT.h+seLQbSpBld--
