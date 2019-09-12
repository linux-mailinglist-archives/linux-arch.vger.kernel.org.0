Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD17B0A95
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2019 10:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbfILIry (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Sep 2019 04:47:54 -0400
Received: from smtpcmd0871.aruba.it ([62.149.156.71]:46879 "EHLO
        smtpcmd0871.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfILIry (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Sep 2019 04:47:54 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Sep 2019 04:47:50 EDT
Received: from localhost.localdomain ([93.146.66.165])
        by smtpcmd08.ad.aruba.it with bizsmtp
        id 0Ygg210103Zw7e501YgmEB; Thu, 12 Sep 2019 10:40:47 +0200
From:   Rodolfo Giometti <giometti@enneenne.com>
To:     linux-arch@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Richard Genoud <richard.genoud@gmail.com>,
        Rodolfo Giometti <giometti@linux.it>,
        Joshua Henderson <joshua.henderson@microchip.com>
Subject: [PATCH 1/2] tty: add bits to manage multidrop mode
Date:   Thu, 12 Sep 2019 10:40:31 +0200
Message-Id: <20190912084032.16927-2-giometti@enneenne.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912084032.16927-1-giometti@enneenne.com>
References: <20190912084032.16927-1-giometti@enneenne.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1568277647; bh=BNy6Oq1BrICTkJD/VaTl9WDsQxXyqFOYAYH4hi/POhM=;
        h=From:To:Subject:Date;
        b=bW9ARQF2TAHBdloE1A6lLxLDDFCEIkedizO5lBLl+Pmw/cvJZT6xqb4DVC3AU/hJg
         QmdckCowAzPB19TfmWVIwbLp9r1DhbjqewAx67eZjPVdhgGBxnxtH73Z0Xo2TmXmpP
         bDp67EBj4atd1QWqCHFlN/UyhC4/vrE/GpsJoG11fyzPRXcdW40xGISw1jqp5k2msM
         A6jK3U3drGVm71uaMsZ7pVvu3dnf4VZMGgNJwKr4DJtOT2ywZcmb53AGUSd3MVkuaw
         Tfsxe6MFTy+dpjB9mySbtm6zYiSflcK6l8wblUmzgFJTupMIIJ0+hystK6THl+R3/x
         6Os3iKvef6kPA==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Rodolfo Giometti <giometti@linux.it>

Multidrop mode differentiates the data characters and the address
characters. Data is transmitted with the parity bit to 0 and addresses
are transmitted with the parity bit to 1. However this usually slow
down communication by adding a delay between the first byte and the
others.

This patch defines two non-stadard bits PARMD (that enables multidrop)
and SENDA (that marks the next transmitted byte as address) that can
be used to completely remove the delay during transmission by
correctly managing the parity bit generation in hardware.

A simple example code about how to set up it is reported below:

    struct termios term;

    tcgetattr(fd, &term);

    /* Transmission: enable parity multidrop and mark 1st byte as address */
    term.c_cflag |= PARENB | CMSPAR | PARMD | SENDA;
    /* Reception: enable parity multidrop and parity check */
    term.c_iflag |= PARENB | PARMD | INPCK;

    tcsetattr(fd, TCSADRAIN, &term);

After that we can start 9 bits data transmission.

Signed-off-by: Rodolfo Giometti <giometti@linux.it>
Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
---
 include/linux/tty.h                 | 2 ++
 include/uapi/asm-generic/termbits.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index bfa4e2ee94a9..66a25294f125 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -168,6 +168,8 @@ struct tty_bufhead {
 #define C_CIBAUD(tty)	_C_FLAG((tty), CIBAUD)
 #define C_CRTSCTS(tty)	_C_FLAG((tty), CRTSCTS)
 #define C_CMSPAR(tty)	_C_FLAG((tty), CMSPAR)
+#define C_PARMD(tty)	_C_FLAG((tty), PARMD)
+#define C_SENDA(tty)	_C_FLAG((tty), SENDA)
 
 #define L_ISIG(tty)	_L_FLAG((tty), ISIG)
 #define L_ICANON(tty)	_L_FLAG((tty), ICANON)
diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-generic/termbits.h
index 2fbaf9ae89dd..ead5eaebdd3b 100644
--- a/include/uapi/asm-generic/termbits.h
+++ b/include/uapi/asm-generic/termbits.h
@@ -141,6 +141,8 @@ struct ktermios {
 #define HUPCL	0002000
 #define CLOCAL	0004000
 #define CBAUDEX 0010000
+#define PARMD   040000000
+#define SENDA   0100000000
 #define    BOTHER 0010000
 #define    B57600 0010001
 #define   B115200 0010002
-- 
2.17.1

