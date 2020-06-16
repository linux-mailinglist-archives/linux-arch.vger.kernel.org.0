Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BF71FC250
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jun 2020 01:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgFPXbZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jun 2020 19:31:25 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55417 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgFPXbW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Jun 2020 19:31:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49mkwl1Gpjz9sSd;
        Wed, 17 Jun 2020 09:31:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1592350279;
        bh=8Enzr05iqmdQEKnrvODMZ8/F/GGixYzwXWm/655F5TM=;
        h=Date:From:To:Cc:Subject:From;
        b=BwMj2eCa2lGurK4zw1uwzaS+m9kXADGwPYaLdJfx9o2TbS+m8Jcd1kZTrc/giZ4Dq
         zP8JOLQANzMwsfdozhG2QwgID9UbzPXVgX2+Qb7Bm/+8LphEzIxCsBifzm2nHajW+k
         rqSEQeV/TttREj2w/IgjcnWSM5o0D5wB7C/lAx/8niIw8sczf2XziiduuI5dAmmmaw
         X6YP4kUnS3KU/aVf5TrejwV5EDH5qGhd1gxctTSMkAikDjrgvqK6QIBaWjcZhXNOHL
         TwF/11Mee28jHD1lww5Q2jmPpyDK7KYDHY6PjJHCMDUXDkSeyebENA6BFraQBqfZ/o
         CICx3xEGli6YA==
Date:   Wed, 17 Jun 2020 09:26:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <greg@kroah.com>
Subject: [RFC Patch 0/2] fix up includes of linux/major.h
Message-ID: <20200617092614.7897ccb2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/c1RdnDg/CwSxuJmBjtRxByn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/c1RdnDg/CwSxuJmBjtRxByn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[This is not cc'd very widely, but get_maintainers produces a very long
list ...]

I have been looking at our include file mess off and on over time and
have finally decided to start with something easy.  linux/major.h
(actually uapi/linux/major.h) is included in quite a few places that
are unnecessary and not included in pleaces it should be.  It also does
not include (or depend on) any other file.  I was lead here while
looking at reducding the size of linux/tty.h (which this patch series
accomplishes).

Just 2 patches currently:

  1/2 Explicitly include linux/major.h where it is needed
  2/2 Remove the include of linux/major.h from files that do not need it

 arch/alpha/kernel/osf_sys.c                      | 1 -
 arch/alpha/kernel/process.c                      | 1 -
 arch/arm/mach-iop32x/i2c.c                       | 1 -
 arch/arm/mach-omap1/board-h3.c                   | 1 -
 arch/arm/mach-pxa/corgi.c                        | 1 -
 arch/arm/mach-pxa/lubbock.c                      | 1 -
 arch/arm/mach-pxa/tosa.c                         | 1 -
 arch/arm/mach-pxa/viper.c                        | 1 -
 arch/m68k/atari/atasound.c                       | 1 -
 arch/m68k/atari/stram.c                          | 1 -
 arch/m68k/bvme6000/config.c                      | 1 -
 arch/m68k/mvme147/config.c                       | 1 -
 arch/m68k/mvme16x/config.c                       | 1 -
 arch/m68k/q40/config.c                           | 1 -
 arch/mips/fw/arc/arc_con.c                       | 1 -
 arch/powerpc/platforms/83xx/km83xx.c             | 1 -
 arch/powerpc/platforms/83xx/mpc832x_mds.c        | 1 -
 arch/powerpc/platforms/83xx/mpc834x_itx.c        | 1 -
 arch/powerpc/platforms/83xx/mpc834x_mds.c        | 1 -
 arch/powerpc/platforms/83xx/mpc836x_mds.c        | 1 -
 arch/powerpc/platforms/85xx/mpc85xx_cds.c        | 1 -
 arch/powerpc/platforms/85xx/mpc85xx_mds.c        | 1 -
 arch/powerpc/platforms/85xx/sbc8548.c            | 1 -
 arch/powerpc/platforms/chrp/setup.c              | 1 -
 arch/powerpc/platforms/maple/setup.c             | 1 -
 arch/powerpc/platforms/powermac/setup.c          | 1 -
 arch/powerpc/platforms/pseries/setup.c           | 1 -
 arch/powerpc/sysdev/fsl_soc.c                    | 1 -
 arch/powerpc/sysdev/tsi108_dev.c                 | 1 -
 arch/sparc/kernel/setup_32.c                     | 1 -
 arch/sparc/kernel/setup_64.c                     | 1 -
 arch/um/drivers/ubd_kern.c                       | 1 +
 arch/xtensa/platforms/xt2000/setup.c             | 1 -
 arch/xtensa/platforms/xtfpga/setup.c             | 1 -
 block/genhd.c                                    | 1 +
 block/partitions/efi.h                           | 1 -
 drivers/android/binderfs.c                       | 1 -
 drivers/block/amiflop.c                          | 1 +
 drivers/block/ataflop.c                          | 1 +
 drivers/block/drbd/drbd_int.h                    | 1 -
 drivers/block/drbd/drbd_main.c                   | 1 +
 drivers/block/floppy.c                           | 1 +
 drivers/block/swim.c                             | 1 +
 drivers/block/swim3.c                            | 1 +
 drivers/block/xen-blkfront.c                     | 1 +
 drivers/cdrom/cdrom.c                            | 1 -
 drivers/char/hpet.c                              | 1 -
 drivers/char/mem.c                               | 1 +
 drivers/char/mwave/mwavedd.c                     | 1 -
 drivers/char/pcmcia/synclink_cs.c                | 1 -
 drivers/char/random.c                            | 1 -
 drivers/char/ttyprintk.c                         | 1 +
 drivers/hid/hidraw.c                             | 1 -
 drivers/ide/ide-cs.c                             | 1 -
 drivers/ide/ide-disk.c                           | 1 -
 drivers/ide/ide-floppy.c                         | 1 -
 drivers/ide/ide-io.c                             | 1 -
 drivers/ide/ide-iops.c                           | 1 -
 drivers/ide/ide.c                                | 1 -
 drivers/input/serio/serio_raw.c                  | 1 -
 drivers/isdn/capi/capi.c                         | 1 -
 drivers/md/md.c                                  | 1 +
 drivers/message/fusion/mptctl.c                  | 1 +
 drivers/misc/vmw_vmci/vmci_host.c                | 1 +
 drivers/mmc/core/block.c                         | 1 +
 drivers/mmc/host/android-goldfish.c              | 1 -
 drivers/mtd/devices/pmc551.c                     | 1 -
 drivers/mtd/devices/slram.c                      | 1 -
 drivers/mtd/ftl.c                                | 1 -
 drivers/mtd/maps/uclinux.c                       | 1 -
 drivers/net/hamradio/mkiss.c                     | 1 -
 drivers/net/tun.c                                | 1 -
 drivers/parport/parport_cs.c                     | 1 -
 drivers/pcmcia/cistpl.c                          | 1 -
 drivers/pcmcia/cs.c                              | 1 -
 drivers/pcmcia/socket_sysfs.c                    | 1 -
 drivers/s390/block/dasd.c                        | 1 -
 drivers/s390/block/dasd_genhd.c                  | 1 +
 drivers/s390/block/dasd_ioctl.c                  | 1 -
 drivers/s390/block/xpram.c                       | 1 +
 drivers/s390/char/con3215.c                      | 1 +
 drivers/s390/char/fs3270.c                       | 1 +
 drivers/s390/char/raw3270.c                      | 1 -
 drivers/s390/char/sclp_tty.c                     | 1 +
 drivers/s390/char/tape_class.h                   | 1 -
 drivers/s390/char/tty3270.c                      | 1 +
 drivers/s390/scsi/zfcp_def.h                     | 1 -
 drivers/sbus/char/display7seg.c                  | 1 -
 drivers/scsi/nsp32.c                             | 1 -
 drivers/scsi/pcmcia/aha152x_stub.c               | 1 -
 drivers/scsi/pcmcia/nsp_cs.c                     | 1 -
 drivers/scsi/pcmcia/qlogic_stub.c                | 1 -
 drivers/scsi/sd.c                                | 1 +
 drivers/scsi/sg.c                                | 1 +
 drivers/scsi/sr.c                                | 1 +
 drivers/scsi/st.c                                | 1 +
 drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c | 1 +
 drivers/staging/speakup/devsynth.c               | 1 +
 drivers/tty/hvc/hvc_console.c                    | 1 -
 drivers/tty/hvc/hvcs.c                           | 1 -
 drivers/tty/hvc/hvsi.c                           | 1 -
 drivers/tty/moxa.c                               | 1 -
 drivers/tty/mxser.c                              | 1 -
 drivers/tty/n_gsm.c                              | 1 -
 drivers/tty/n_tty.c                              | 1 -
 drivers/tty/rocket.c                             | 1 -
 drivers/tty/serial/8250/8250_core.c              | 1 +
 drivers/tty/serial/8250/serial_cs.c              | 1 -
 drivers/tty/serial/apbuart.c                     | 1 +
 drivers/tty/serial/atmel_serial.c                | 1 +
 drivers/tty/serial/bcm63xx_uart.c                | 1 +
 drivers/tty/serial/icom.c                        | 1 -
 drivers/tty/serial/mcf.c                         | 1 +
 drivers/tty/serial/mux.c                         | 1 +
 drivers/tty/serial/pxa.c                         | 1 +
 drivers/tty/serial/serial_txx9.c                 | 1 +
 drivers/tty/serial/sh-sci.c                      | 1 -
 drivers/tty/synclink.c                           | 1 -
 drivers/tty/synclink_gt.c                        | 1 -
 drivers/tty/synclinkmp.c                         | 1 -
 drivers/tty/sysrq.c                              | 1 -
 drivers/tty/tty_ioctl.c                          | 1 -
 drivers/tty/vt/vt_ioctl.c                        | 1 -
 drivers/watchdog/cpwd.c                          | 1 -
 drivers/watchdog/watchdog_dev.c                  | 1 +
 drivers/xen/evtchn.c                             | 1 -
 drivers/xen/gntalloc.c                           | 1 +
 fs/block_dev.c                                   | 1 -
 fs/char_dev.c                                    | 1 -
 fs/coda/psdev.c                                  | 1 -
 fs/devpts/inode.c                                | 1 +
 fs/proc/proc_tty.c                               | 1 +
 fs/xfs/xfs_linux.h                               | 1 -
 include/linux/blkdev.h                           | 1 -
 include/linux/genhd.h                            | 1 -
 include/linux/tty.h                              | 1 -
 include/uapi/linux/raid/md_u.h                   | 2 ++
 init/do_mounts.c                                 | 1 +
 init/do_mounts.h                                 | 1 -
 init/do_mounts_md.c                              | 1 +
 init/do_mounts_rd.c                              | 1 +
 kernel/bpf/inode.c                               | 1 -
 net/ipv4/ipconfig.c                              | 1 -
 tools/hv/hv_vss_daemon.c                         | 1 -
 144 files changed, 44 insertions(+), 101 deletions(-)

--=20
Cheers,
Stephen Rothwell

--Sig_/c1RdnDg/CwSxuJmBjtRxByn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7pVRYACgkQAVBC80lX
0Gzlcwf/b25QCg0ykDaOMiVG+okZvg5BqDreuD+is6k4L9JLgZ+YkTTUj8lg5opd
EDjrV49J+q5TR/H7aPFIbfqoqmuVKblGKJ595+Xmnr68XggwMexS+QFKQUZaGLkX
ekK/iEyHjl2ry7DFRLCa12tHBkmUML8W893Bqk4yjDugP+kyZ1wBwlAsDSSIO7fU
jLWGJO+PKpAsiHbsaINoSfMZa6WUJ19ClJeeO4s0v4SXXqeOmhIwcUQI3XrzQm5x
kntG/FskFUS5Sh/CeAAJmeR+9k03cgttIIHDjr5bGZYuY5q0q68Q/P91R5t6eaIu
k79hxhqy2VZjw76J/G/xf0wNBwmT/w==
=0vtK
-----END PGP SIGNATURE-----

--Sig_/c1RdnDg/CwSxuJmBjtRxByn--
