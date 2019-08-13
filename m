Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1CF18B865
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 14:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfHMMUE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 08:20:04 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:37454 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbfHMMUC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Aug 2019 08:20:02 -0400
Received: by mail-ua1-f73.google.com with SMTP id o46so9657889uad.4
        for <linux-arch@vger.kernel.org>; Tue, 13 Aug 2019 05:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=BVCscCghGr3RW4i2SIfebP2PoMpA3Kh9pJgULCxqlPQ=;
        b=u2/pqsshhQnlXCPysffXEOpXSHiOYRisuXsp5awurzduyutvZibG6iupvJfZ36dW4O
         B8ZCY65b0BwRxdtrl0BtmL0X6jGeHNRKdtQPO3cA8cU/5qLkMeqbp9XtNxx4BCtf9xid
         7T5XjArfMsnwQJUkBxxPMFLQuSr4ixSuQdco24WpGOt4HnPHhQnblxUvW5Z+FyYqbvHf
         2gdxaH+FSMoOtGHuoi+z8HwRrKyIosqYPuRWqYIhUWyG7yzlVDb9WCTJoxJXbbSEzMyP
         IyMsNUoceVGVHF/6P+NiU7TV79UdRsIy5g8qnt6NBe3KgZZg/7TSjqTXBZ3N0xTvEVp8
         icvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=BVCscCghGr3RW4i2SIfebP2PoMpA3Kh9pJgULCxqlPQ=;
        b=M/eJNxTmP5hFyrlHqOH9yH9ymXPvFXBmtqMm/owpjbkflmZWHkfPbysMIBi2nDFIM7
         KY21R6fIIM4NoHKPQyd9QTNeKK6zuzbNdleYkrgIBhQ7j1iGATdUbmQVLSDKxrNpEE2Y
         /2sIrZkLpvPVGNgerD4hLtO1ChlH4+byLfgfNO9r/7TY1+bedZulVWuQQq4jF8uajYaU
         OqrD7YBTr4eAbp+lOTOQhv9ycTBHNgAOMPvpnVrp8bJCYcPwirZIPWGW2qnCbdEEIaBB
         cXy5+wcKhde2vbo5PqzdSZukPRIi0TOtWc0d8ib072mXcfsp3ZNtXKyWvzogRe45/PfQ
         l/qw==
X-Gm-Message-State: APjAAAXJxezBLcic4mh8mTXp5Hy3YQMkzQ89yL1UpLl+qT/etVKFaX1t
        wukj5lOPcTsMSQsXl+BnoojPmgEikZ6Tfg==
X-Google-Smtp-Source: APXvYqxu9ZboBauUgURGvwMlFpuvzXKtKNrSni4vknrSu8vLMAf7HLrp+1GWRNFhg6GB2Pf15cf4tJRLGP5l/w==
X-Received: by 2002:a1f:5405:: with SMTP id i5mr4863634vkb.75.1565698800581;
 Tue, 13 Aug 2019 05:20:00 -0700 (PDT)
Date:   Tue, 13 Aug 2019 13:17:07 +0100
In-Reply-To: <20190813121733.52480-1-maennich@google.com>
Message-Id: <20190813121733.52480-11-maennich@google.com>
Mime-Version: 1.0
References: <20180716122125.175792-1-maco@android.com> <20190813121733.52480-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v2 10/10] RFC: usb-storage: export symbols in USB_STORAGE namespace
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org, maco@android.com
Cc:     kernel-team@android.com, maennich@google.com, arnd@arndb.de,
        geert@linux-m68k.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        jeyu@kernel.org, joel@joelfernandes.org,
        kstewart@linuxfoundation.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com,
        maco@google.com, michal.lkml@markovi.net, mingo@redhat.com,
        oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org,
        sboyd@codeaurora.org, sspatil@google.com,
        stern@rowland.harvard.edu, tglx@linutronix.de,
        usb-storage@lists.one-eyed-alien.net, x86@kernel.org,
        yamada.masahiro@socionext.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Modules using these symbols are required to explicitly import the
namespace. This patch was generated with the following steps and serves
as a reference to use the symbol namespace feature:

 1) Define DDEFAULT_SYMBOL_NAMESPACE in the corresponding Makefile
 2) make  (see warnings during modpost about missing imports)
 3) make nsdeps

Instead of a DEFAULT_SYMBOL_NAMESPACE definition, the EXPORT_SYMBOL_NS
variants can be used to explicitly specify the namespace. The advantage
of the method used here is that newly added symbols are automatically
exported and existing ones are exported without touching their
respective EXPORT_SYMBOL macro expansion.

Signed-off-by: Matthias Maennich <maennich@google.com>
---
 drivers/usb/storage/Makefile        | 2 ++
 drivers/usb/storage/alauda.c        | 1 +
 drivers/usb/storage/cypress_atacb.c | 1 +
 drivers/usb/storage/datafab.c       | 1 +
 drivers/usb/storage/ene_ub6250.c    | 1 +
 drivers/usb/storage/freecom.c       | 1 +
 drivers/usb/storage/isd200.c        | 1 +
 drivers/usb/storage/jumpshot.c      | 1 +
 drivers/usb/storage/karma.c         | 1 +
 drivers/usb/storage/onetouch.c      | 1 +
 drivers/usb/storage/realtek_cr.c    | 1 +
 drivers/usb/storage/sddr09.c        | 1 +
 drivers/usb/storage/sddr55.c        | 1 +
 drivers/usb/storage/shuttle_usbat.c | 1 +
 drivers/usb/storage/uas.c           | 1 +
 15 files changed, 16 insertions(+)

diff --git a/drivers/usb/storage/Makefile b/drivers/usb/storage/Makefile
index a67ddcbb4e24..46635fa4a340 100644
--- a/drivers/usb/storage/Makefile
+++ b/drivers/usb/storage/Makefile
@@ -8,6 +8,8 @@
=20
 ccflags-y :=3D -I $(srctree)/drivers/scsi
=20
+ccflags-y +=3D -DDEFAULT_SYMBOL_NAMESPACE=3DUSB_STORAGE
+
 obj-$(CONFIG_USB_UAS)		+=3D uas.o
 obj-$(CONFIG_USB_STORAGE)	+=3D usb-storage.o
=20
diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
index 6b8edf6178df..ddab2cd3d2e7 100644
--- a/drivers/usb/storage/alauda.c
+++ b/drivers/usb/storage/alauda.c
@@ -36,6 +36,7 @@
 MODULE_DESCRIPTION("Driver for Alauda-based card readers");
 MODULE_AUTHOR("Daniel Drake <dsd@gentoo.org>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(USB_STORAGE);
=20
 /*
  * Status bytes
diff --git a/drivers/usb/storage/cypress_atacb.c b/drivers/usb/storage/cypr=
ess_atacb.c
index 4825902377eb..a6f3267bbef6 100644
--- a/drivers/usb/storage/cypress_atacb.c
+++ b/drivers/usb/storage/cypress_atacb.c
@@ -22,6 +22,7 @@
 MODULE_DESCRIPTION("SAT support for Cypress USB/ATA bridges with ATACB");
 MODULE_AUTHOR("Matthieu Castet <castet.matthieu@free.fr>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(USB_STORAGE);
=20
 /*
  * The table of devices
diff --git a/drivers/usb/storage/datafab.c b/drivers/usb/storage/datafab.c
index 09353be199be..588818483f4b 100644
--- a/drivers/usb/storage/datafab.c
+++ b/drivers/usb/storage/datafab.c
@@ -54,6 +54,7 @@
 MODULE_DESCRIPTION("Driver for Datafab USB Compact Flash reader");
 MODULE_AUTHOR("Jimmie Mayfield <mayfield+datafab@sackheads.org>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(USB_STORAGE);
=20
 struct datafab_info {
 	unsigned long   sectors;	/* total sector count */
diff --git a/drivers/usb/storage/ene_ub6250.c b/drivers/usb/storage/ene_ub6=
250.c
index c26129d5b943..8b1b73065421 100644
--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -26,6 +26,7 @@
=20
 MODULE_DESCRIPTION("Driver for ENE UB6250 reader");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(USB_STORAGE);
 MODULE_FIRMWARE(SD_INIT1_FIRMWARE);
 MODULE_FIRMWARE(SD_INIT2_FIRMWARE);
 MODULE_FIRMWARE(SD_RW_FIRMWARE);
diff --git a/drivers/usb/storage/freecom.c b/drivers/usb/storage/freecom.c
index 4f542df37a44..34e7eaff1174 100644
--- a/drivers/usb/storage/freecom.c
+++ b/drivers/usb/storage/freecom.c
@@ -29,6 +29,7 @@
 MODULE_DESCRIPTION("Driver for Freecom USB/IDE adaptor");
 MODULE_AUTHOR("David Brown <usb-storage@davidb.org>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(USB_STORAGE);
=20
 #ifdef CONFIG_USB_STORAGE_DEBUG
 static void pdump(struct us_data *us, void *ibuffer, int length);
diff --git a/drivers/usb/storage/isd200.c b/drivers/usb/storage/isd200.c
index 2b474d60b4db..c4da3fd6eff9 100644
--- a/drivers/usb/storage/isd200.c
+++ b/drivers/usb/storage/isd200.c
@@ -53,6 +53,7 @@
 MODULE_DESCRIPTION("Driver for In-System Design, Inc. ISD200 ASIC");
 MODULE_AUTHOR("Bj=C3=B6rn Stenberg <bjorn@haxx.se>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(USB_STORAGE);
=20
 static int isd200_Initialization(struct us_data *us);
=20
diff --git a/drivers/usb/storage/jumpshot.c b/drivers/usb/storage/jumpshot.=
c
index 917f170c4124..229bf0c1afc9 100644
--- a/drivers/usb/storage/jumpshot.c
+++ b/drivers/usb/storage/jumpshot.c
@@ -51,6 +51,7 @@
 MODULE_DESCRIPTION("Driver for Lexar \"Jumpshot\" Compact Flash reader");
 MODULE_AUTHOR("Jimmie Mayfield <mayfield+usb@sackheads.org>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(USB_STORAGE);
=20
 /*
  * The table of devices
diff --git a/drivers/usb/storage/karma.c b/drivers/usb/storage/karma.c
index 395cf8fb5870..05cec81dcd3f 100644
--- a/drivers/usb/storage/karma.c
+++ b/drivers/usb/storage/karma.c
@@ -23,6 +23,7 @@
 MODULE_DESCRIPTION("Driver for Rio Karma");
 MODULE_AUTHOR("Bob Copeland <me@bobcopeland.com>, Keith Bennett <keith@mcs=
.st-and.ac.uk>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(USB_STORAGE);
=20
 #define RIO_PREFIX "RIOP\x00"
 #define RIO_PREFIX_LEN 5
diff --git a/drivers/usb/storage/onetouch.c b/drivers/usb/storage/onetouch.=
c
index 39a5009a41a6..a989fe930e21 100644
--- a/drivers/usb/storage/onetouch.c
+++ b/drivers/usb/storage/onetouch.c
@@ -25,6 +25,7 @@
 MODULE_DESCRIPTION("Maxtor USB OneTouch hard drive button driver");
 MODULE_AUTHOR("Nick Sillik <n.sillik@temple.edu>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(USB_STORAGE);
=20
 #define ONETOUCH_PKT_LEN        0x02
 #define ONETOUCH_BUTTON         KEY_PROG1
diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek=
_cr.c
index cc794e25a0b6..edbe419053d6 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -35,6 +35,7 @@
 MODULE_DESCRIPTION("Driver for Realtek USB Card Reader");
 MODULE_AUTHOR("wwang <wei_wang@realsil.com.cn>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(USB_STORAGE);
=20
 static int auto_delink_en =3D 1;
 module_param(auto_delink_en, int, S_IRUGO | S_IWUSR);
diff --git a/drivers/usb/storage/sddr09.c b/drivers/usb/storage/sddr09.c
index bc9da736bdfc..51bcd4a43690 100644
--- a/drivers/usb/storage/sddr09.c
+++ b/drivers/usb/storage/sddr09.c
@@ -47,6 +47,7 @@
 MODULE_DESCRIPTION("Driver for SanDisk SDDR-09 SmartMedia reader");
 MODULE_AUTHOR("Andries Brouwer <aeb@cwi.nl>, Robert Baruch <autophile@star=
band.net>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(USB_STORAGE);
=20
 static int usb_stor_sddr09_dpcm_init(struct us_data *us);
 static int sddr09_transport(struct scsi_cmnd *srb, struct us_data *us);
diff --git a/drivers/usb/storage/sddr55.c b/drivers/usb/storage/sddr55.c
index b8527c55335b..ba955d65eb0e 100644
--- a/drivers/usb/storage/sddr55.c
+++ b/drivers/usb/storage/sddr55.c
@@ -29,6 +29,7 @@
 MODULE_DESCRIPTION("Driver for SanDisk SDDR-55 SmartMedia reader");
 MODULE_AUTHOR("Simon Munton");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(USB_STORAGE);
=20
 /*
  * The table of devices
diff --git a/drivers/usb/storage/shuttle_usbat.c b/drivers/usb/storage/shut=
tle_usbat.c
index 854498e1012c..54aa1392c9ca 100644
--- a/drivers/usb/storage/shuttle_usbat.c
+++ b/drivers/usb/storage/shuttle_usbat.c
@@ -48,6 +48,7 @@
 MODULE_DESCRIPTION("Driver for SCM Microsystems (a.k.a. Shuttle) USB-ATAPI=
 cable");
 MODULE_AUTHOR("Daniel Drake <dsd@gentoo.org>, Robert Baruch <autophile@sta=
rband.net>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(USB_STORAGE);
=20
 /* Supported device types */
 #define USBAT_DEV_HP8200	0x01
diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 047c5922618f..bf80d6f81f58 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -1219,5 +1219,6 @@ static struct usb_driver uas_driver =3D {
 module_usb_driver(uas_driver);
=20
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(USB_STORAGE);
 MODULE_AUTHOR(
 	"Hans de Goede <hdegoede@redhat.com>, Matthew Wilcox and Sarah Sharp");
--=20
2.23.0.rc1.153.gdeed80330f-goog

