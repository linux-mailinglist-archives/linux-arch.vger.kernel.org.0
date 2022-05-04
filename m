Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF895197F7
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 09:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345305AbiEDHYw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 03:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiEDHYu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 03:24:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1904167EE;
        Wed,  4 May 2022 00:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651648873; x=1683184873;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fby6jJV8PoqgaAqdPBGy+CPeZla9rt7IIF3wFX7961o=;
  b=fcGtKFjHWDzwBMHSrn2ldznVZEDU4oLLfVzyhhUF9wTmU1K5O4jRjwGn
   EVtqOBj48Wmja71X37f3JQkddqFE6vbk9JctLITI/Zrfxt+Fkd+0Qt01g
   IhSW08a1/grxb9tBbeFBdPJcOQy/ucmsQV/nKdvZUN05OnIvWalBvt/NK
   Qpt3g1gnPvZ/bts/Qk+18PnMkti9ZfDPxEdrYxZx1TVqRUXjjgU80R46j
   ZpfXjoUQjtBpYinLUVH6i/uPncxwW0M0Enc9CglFqHPMM10Z7n5K7LVgl
   lXECIV/K/1UZyZT+Zv12Q9YNS9vrCjgOeZNCMKejMjjjSdm96wriUXrfu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="267284394"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="267284394"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 00:21:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="693450272"
Received: from unknown (HELO ijarvine-MOBL2) ([10.251.218.195])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 00:21:06 -0700
Date:   Wed, 4 May 2022 10:20:46 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>
cc:     Jiri Slaby <jirislaby@kernel.org>, linux-api@vger.kernel.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] termbits: Convert octal defines to hex
Message-ID: <2c8c96f-a12f-aadc-18ac-34c1d371929c@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1991360190-1651648872=:1623"
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1991360190-1651648872=:1623
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Many archs have termbits.h as octal numbers. It makes hard for humans
to parse the magnitude of large numbers correctly and to compare with
hex ones of the same define.

Convert octal values to hex.

First step is an automated conversion with:

for i in $(git ls-files | grep 'termbits\.h'); do
	awk --non-decimal-data '/^#define\s+[A-Z][A-Z0-9]*\s+0[0-9]/ {
		l=int(((length($3) - 1) * 3 + 3) / 4);
		repl = sprintf("0x%0" l "x", $3);
		print gensub(/[^[:blank:]]+/, repl, 3);
		next} {print}' $i > $i~;
	mv $i~ $i;
done

On top of that, some manual processing on alignment and number of zeros.
In addition, small tweaks to formatting of a few comments on the same 
lines.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

I prefer this to go in though Greg's tty tree.

 arch/alpha/include/uapi/asm/termbits.h   | 202 ++++++++++-----------
 arch/mips/include/uapi/asm/termbits.h    | 222 +++++++++++------------
 arch/parisc/include/uapi/asm/termbits.h  | 220 +++++++++++-----------
 arch/powerpc/include/uapi/asm/termbits.h | 202 ++++++++++-----------
 include/uapi/asm-generic/termbits.h      | 220 +++++++++++-----------
 5 files changed, 533 insertions(+), 533 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/termbits.h b/arch/alpha/include/uapi/asm/termbits.h
index 4575ba34a0ea..30dc7ff777b8 100644
--- a/arch/alpha/include/uapi/asm/termbits.h
+++ b/arch/alpha/include/uapi/asm/termbits.h
@@ -72,57 +72,57 @@ struct ktermios {
 #define VTIME 17
 
 /* c_iflag bits */
-#define IGNBRK	0000001
-#define BRKINT	0000002
-#define IGNPAR	0000004
-#define PARMRK	0000010
-#define INPCK	0000020
-#define ISTRIP	0000040
-#define INLCR	0000100
-#define IGNCR	0000200
-#define ICRNL	0000400
-#define IXON	0001000
-#define IXOFF	0002000
-#define IXANY	0004000
-#define IUCLC	0010000
-#define IMAXBEL	0020000
-#define IUTF8	0040000
+#define IGNBRK	0x00001
+#define BRKINT	0x00002
+#define IGNPAR	0x00004
+#define PARMRK	0x00008
+#define INPCK	0x00010
+#define ISTRIP	0x00020
+#define INLCR	0x00040
+#define IGNCR	0x00080
+#define ICRNL	0x00100
+#define IXON	0x00200
+#define IXOFF	0x00400
+#define IXANY	0x00800
+#define IUCLC	0x01000
+#define IMAXBEL	0x02000
+#define IUTF8	0x04000
 
 /* c_oflag bits */
-#define OPOST	0000001
-#define ONLCR	0000002
-#define OLCUC	0000004
-
-#define OCRNL	0000010
-#define ONOCR	0000020
-#define ONLRET	0000040
-
-#define OFILL	00000100
-#define OFDEL	00000200
-#define NLDLY	00001400
-#define   NL0	00000000
-#define   NL1	00000400
-#define   NL2	00001000
-#define   NL3	00001400
-#define TABDLY	00006000
-#define   TAB0	00000000
-#define   TAB1	00002000
-#define   TAB2	00004000
-#define   TAB3	00006000
-#define CRDLY	00030000
-#define   CR0	00000000
-#define   CR1	00010000
-#define   CR2	00020000
-#define   CR3	00030000
-#define FFDLY	00040000
-#define   FF0	00000000
-#define   FF1	00040000
-#define BSDLY	00100000
-#define   BS0	00000000
-#define   BS1	00100000
-#define VTDLY	00200000
-#define   VT0	00000000
-#define   VT1	00200000
+#define OPOST	0x00001
+#define ONLCR	0x00002
+#define OLCUC	0x00004
+
+#define OCRNL	0x00008
+#define ONOCR	0x00010
+#define ONLRET	0x00020
+
+#define OFILL	0x000040
+#define OFDEL	0x000080
+#define NLDLY	0x000300
+#define   NL0	0x000000
+#define   NL1	0x000100
+#define   NL2	0x000200
+#define   NL3	0x000300
+#define TABDLY	0x000c00
+#define   TAB0	0x000000
+#define   TAB1	0x000400
+#define   TAB2	0x000800
+#define   TAB3	0x000c00
+#define CRDLY	0x003000
+#define   CR0	0x000000
+#define   CR1	0x001000
+#define   CR2	0x002000
+#define   CR3	0x003000
+#define FFDLY	0x004000
+#define   FF0	0x000000
+#define   FF1	0x004000
+#define BSDLY	0x008000
+#define   BS0	0x000000
+#define   BS1	0x008000
+#define VTDLY	0x010000
+#define   VT0	0x000000
+#define   VT1	0x010000
 /*
  * Should be equivalent to TAB3, see description of TAB3 in
  * POSIX.1-2008, Ch. 11.2.3 "Output Modes"
@@ -130,60 +130,60 @@ struct ktermios {
 #define XTABS	TAB3
 
 /* c_cflag bit meaning */
-#define CBAUD	0000037
-#define  B0	0000000		/* hang up */
-#define  B50	0000001
-#define  B75	0000002
-#define  B110	0000003
-#define  B134	0000004
-#define  B150	0000005
-#define  B200	0000006
-#define  B300	0000007
-#define  B600	0000010
-#define  B1200	0000011
-#define  B1800	0000012
-#define  B2400	0000013
-#define  B4800	0000014
-#define  B9600	0000015
-#define  B19200	0000016
-#define  B38400	0000017
+#define CBAUD		0x0000001f
+#define  B0		0x00000000	/* hang up */
+#define  B50		0x00000001
+#define  B75		0x00000002
+#define  B110		0x00000003
+#define  B134		0x00000004
+#define  B150		0x00000005
+#define  B200		0x00000006
+#define  B300		0x00000007
+#define  B600		0x00000008
+#define  B1200		0x00000009
+#define  B1800		0x0000000a
+#define  B2400		0x0000000b
+#define  B4800		0x0000000c
+#define  B9600		0x0000000d
+#define  B19200		0x0000000e
+#define  B38400		0x0000000f
 #define EXTA B19200
 #define EXTB B38400
-#define CBAUDEX 0000000
-#define  B57600   00020
-#define  B115200  00021
-#define  B230400  00022
-#define  B460800  00023
-#define  B500000  00024
-#define  B576000  00025
-#define  B921600  00026
-#define B1000000  00027
-#define B1152000  00030
-#define B1500000  00031
-#define B2000000  00032
-#define B2500000  00033
-#define B3000000  00034
-#define B3500000  00035
-#define B4000000  00036
-#define BOTHER    00037
-
-#define CSIZE	00001400
-#define   CS5	00000000
-#define   CS6	00000400
-#define   CS7	00001000
-#define   CS8	00001400
-
-#define CSTOPB	00002000
-#define CREAD	00004000
-#define PARENB	00010000
-#define PARODD	00020000
-#define HUPCL	00040000
-
-#define CLOCAL	00100000
-#define CMSPAR	  010000000000		/* mark or space (stick) parity */
-#define CRTSCTS	  020000000000		/* flow control */
-
-#define CIBAUD	07600000
+#define CBAUDEX		0x00000000
+#define  B57600		0x00000010
+#define  B115200	0x00000011
+#define  B230400	0x00000012
+#define  B460800	0x00000013
+#define  B500000	0x00000014
+#define  B576000	0x00000015
+#define  B921600	0x00000016
+#define B1000000	0x00000017
+#define B1152000	0x00000018
+#define B1500000	0x00000019
+#define B2000000	0x0000001a
+#define B2500000	0x0000001b
+#define B3000000	0x0000001c
+#define B3500000	0x0000001d
+#define B4000000	0x0000001e
+#define BOTHER		0x0000001f
+
+#define CSIZE		0x00000300
+#define   CS5		0x00000000
+#define   CS6		0x00000100
+#define   CS7		0x00000200
+#define   CS8		0x00000300
+
+#define CSTOPB		0x00000400
+#define CREAD		0x00000800
+#define PARENB		0x00001000
+#define PARODD		0x00002000
+#define HUPCL		0x00004000
+
+#define CLOCAL		0x00008000
+#define CMSPAR		0x40000000	/* mark or space (stick) parity */
+#define CRTSCTS		0x80000000	/* flow control */
+
+#define CIBAUD		0x1f0000
 #define IBSHIFT	16
 
 /* c_lflag bits */
diff --git a/arch/mips/include/uapi/asm/termbits.h b/arch/mips/include/uapi/asm/termbits.h
index dfeffba729b7..d1315ccdb39a 100644
--- a/arch/mips/include/uapi/asm/termbits.h
+++ b/arch/mips/include/uapi/asm/termbits.h
@@ -80,131 +80,131 @@ struct ktermios {
 #define VEOL		17		/* End-of-line character [ICANON].  */
 
 /* c_iflag bits */
-#define IGNBRK	0000001		/* Ignore break condition.  */
-#define BRKINT	0000002		/* Signal interrupt on break.  */
-#define IGNPAR	0000004		/* Ignore characters with parity errors.  */
-#define PARMRK	0000010		/* Mark parity and framing errors.  */
-#define INPCK	0000020		/* Enable input parity check.  */
-#define ISTRIP	0000040		/* Strip 8th bit off characters.  */
-#define INLCR	0000100		/* Map NL to CR on input.  */
-#define IGNCR	0000200		/* Ignore CR.  */
-#define ICRNL	0000400		/* Map CR to NL on input.  */
-#define IUCLC	0001000		/* Map upper case to lower case on input.  */
-#define IXON	0002000		/* Enable start/stop output control.  */
-#define IXANY	0004000		/* Any character will restart after stop.  */
-#define IXOFF	0010000		/* Enable start/stop input control.  */
-#define IMAXBEL 0020000		/* Ring bell when input queue is full.	*/
-#define IUTF8	0040000		/* Input is UTF-8 */
+#define IGNBRK	0x00001		/* Ignore break condition.  */
+#define BRKINT	0x00002		/* Signal interrupt on break.  */
+#define IGNPAR	0x00004		/* Ignore characters with parity errors.  */
+#define PARMRK	0x00008		/* Mark parity and framing errors.  */
+#define INPCK	0x00010		/* Enable input parity check.  */
+#define ISTRIP	0x00020		/* Strip 8th bit off characters.  */
+#define INLCR	0x00040		/* Map NL to CR on input.  */
+#define IGNCR	0x00080		/* Ignore CR.  */
+#define ICRNL	0x00100		/* Map CR to NL on input.  */
+#define IUCLC	0x00200		/* Map upper case to lower case on input.  */
+#define IXON	0x00400		/* Enable start/stop output control.  */
+#define IXANY	0x00800		/* Any character will restart after stop.  */
+#define IXOFF	0x01000		/* Enable start/stop input control.  */
+#define IMAXBEL	0x02000		/* Ring bell when input queue is full.	*/
+#define IUTF8	0x04000		/* Input is UTF-8 */
 
 /* c_oflag bits */
-#define OPOST	0000001		/* Perform output processing.  */
-#define OLCUC	0000002		/* Map lower case to upper case on output.  */
-#define ONLCR	0000004		/* Map NL to CR-NL on output.  */
-#define OCRNL	0000010
-#define ONOCR	0000020
-#define ONLRET	0000040
-#define OFILL	0000100
-#define OFDEL	0000200
-#define NLDLY	0000400
-#define	  NL0	0000000
-#define	  NL1	0000400
-#define CRDLY	0003000
-#define	  CR0	0000000
-#define	  CR1	0001000
-#define	  CR2	0002000
-#define	  CR3	0003000
-#define TABDLY	0014000
-#define	  TAB0	0000000
-#define	  TAB1	0004000
-#define	  TAB2	0010000
-#define	  TAB3	0014000
-#define	  XTABS 0014000
-#define BSDLY	0020000
-#define	  BS0	0000000
-#define	  BS1	0020000
-#define VTDLY	0040000
-#define	  VT0	0000000
-#define	  VT1	0040000
-#define FFDLY	0100000
-#define	  FF0	0000000
-#define	  FF1	0100000
+#define OPOST	0x00001		/* Perform output processing.  */
+#define OLCUC	0x00002		/* Map lower case to upper case on output.  */
+#define ONLCR	0x00004		/* Map NL to CR-NL on output.  */
+#define OCRNL	0x00008
+#define ONOCR	0x00010
+#define ONLRET	0x00020
+#define OFILL	0x00040
+#define OFDEL	0x00080
+#define NLDLY	0x00100
+#define	  NL0	0x00000
+#define	  NL1	0x00100
+#define CRDLY	0x00600
+#define	  CR0	0x00000
+#define	  CR1	0x00200
+#define	  CR2	0x00400
+#define	  CR3	0x00600
+#define TABDLY	0x01800
+#define	  TAB0	0x00000
+#define	  TAB1	0x00800
+#define	  TAB2	0x01000
+#define	  TAB3	0x01800
+#define	  XTABS	0x01800
+#define BSDLY	0x02000
+#define	  BS0	0x00000
+#define	  BS1	0x02000
+#define VTDLY	0x04000
+#define	  VT0	0x00000
+#define	  VT1	0x04000
+#define FFDLY	0x08000
+#define	  FF0	0x00000
+#define	  FF1	0x08000
 /*
 #define PAGEOUT ???
 #define WRAP	???
  */
 
 /* c_cflag bit meaning */
-#define CBAUD	0010017
-#define	 B0	0000000		/* hang up */
-#define	 B50	0000001
-#define	 B75	0000002
-#define	 B110	0000003
-#define	 B134	0000004
-#define	 B150	0000005
-#define	 B200	0000006
-#define	 B300	0000007
-#define	 B600	0000010
-#define	 B1200	0000011
-#define	 B1800	0000012
-#define	 B2400	0000013
-#define	 B4800	0000014
-#define	 B9600	0000015
-#define	 B19200 0000016
-#define	 B38400 0000017
+#define CBAUD		0x0000100f
+#define	 B0		0x00000000	/* hang up */
+#define	 B50		0x00000001
+#define	 B75		0x00000002
+#define	 B110		0x00000003
+#define	 B134		0x00000004
+#define	 B150		0x00000005
+#define	 B200		0x00000006
+#define	 B300		0x00000007
+#define	 B600		0x00000008
+#define	 B1200		0x00000009
+#define	 B1800		0x0000000a
+#define	 B2400		0x0000000b
+#define	 B4800		0x0000000c
+#define	 B9600		0x0000000d
+#define	 B19200		0x0000000e
+#define	 B38400		0x0000000f
 #define EXTA B19200
 #define EXTB B38400
-#define CSIZE	0000060		/* Number of bits per byte (mask).  */
-#define	  CS5	0000000		/* 5 bits per byte.  */
-#define	  CS6	0000020		/* 6 bits per byte.  */
-#define	  CS7	0000040		/* 7 bits per byte.  */
-#define	  CS8	0000060		/* 8 bits per byte.  */
-#define CSTOPB	0000100		/* Two stop bits instead of one.  */
-#define CREAD	0000200		/* Enable receiver.  */
-#define PARENB	0000400		/* Parity enable.  */
-#define PARODD	0001000		/* Odd parity instead of even.	*/
-#define HUPCL	0002000		/* Hang up on last close.  */
-#define CLOCAL	0004000		/* Ignore modem status lines.  */
-#define CBAUDEX 0010000
-#define	   BOTHER 0010000
-#define	   B57600 0010001
-#define	  B115200 0010002
-#define	  B230400 0010003
-#define	  B460800 0010004
-#define	  B500000 0010005
-#define	  B576000 0010006
-#define	  B921600 0010007
-#define	 B1000000 0010010
-#define	 B1152000 0010011
-#define	 B1500000 0010012
-#define	 B2000000 0010013
-#define	 B2500000 0010014
-#define	 B3000000 0010015
-#define	 B3500000 0010016
-#define	 B4000000 0010017
-#define CIBAUD	  002003600000	/* input baud rate */
-#define CMSPAR	  010000000000	/* mark or space (stick) parity */
-#define CRTSCTS	  020000000000	/* flow control */
+#define CSIZE		0x00000030	/* Number of bits per byte (mask) */
+#define	  CS5		0x00000000	/* 5 bits per byte */
+#define	  CS6		0x00000010	/* 6 bits per byte */
+#define	  CS7		0x00000020	/* 7 bits per byte */
+#define	  CS8		0x00000030	/* 8 bits per byte */
+#define CSTOPB		0x00000040	/* Two stop bits instead of one */
+#define CREAD		0x00000080	/* Enable receiver */
+#define PARENB		0x00000100	/* Parity enable */
+#define PARODD		0x00000200	/* Odd parity instead of even */
+#define HUPCL		0x00000400	/* Hang up on last close */
+#define CLOCAL		0x00000800	/* Ignore modem status lines */
+#define CBAUDEX		0x00001000
+#define	   BOTHER	0x00001000
+#define	   B57600	0x00001001
+#define	  B115200	0x00001002
+#define	  B230400	0x00001003
+#define	  B460800	0x00001004
+#define	  B500000	0x00001005
+#define	  B576000	0x00001006
+#define	  B921600	0x00001007
+#define	 B1000000	0x00001008
+#define	 B1152000	0x00001009
+#define	 B1500000	0x0000100a
+#define	 B2000000	0x0000100b
+#define	 B2500000	0x0000100c
+#define	 B3000000	0x0000100d
+#define	 B3500000	0x0000100e
+#define	 B4000000	0x0000100f
+#define CIBAUD		0x100f0000	/* input baud rate */
+#define CMSPAR		0x40000000	/* mark or space (stick) parity */
+#define CRTSCTS		0x80000000	/* flow control */
 
 #define IBSHIFT 16		/* Shift from CBAUD to CIBAUD */
 
 /* c_lflag bits */
-#define ISIG	0000001		/* Enable signals.  */
-#define ICANON	0000002		/* Do erase and kill processing.  */
-#define XCASE	0000004
-#define ECHO	0000010		/* Enable echo.	 */
-#define ECHOE	0000020		/* Visual erase for ERASE.  */
-#define ECHOK	0000040		/* Echo NL after KILL.	*/
-#define ECHONL	0000100		/* Echo NL even if ECHO is off.	 */
-#define NOFLSH	0000200		/* Disable flush after interrupt.  */
-#define IEXTEN	0000400		/* Enable DISCARD and LNEXT.  */
-#define ECHOCTL 0001000		/* Echo control characters as ^X.  */
-#define ECHOPRT 0002000		/* Hardcopy visual erase.  */
-#define ECHOKE	0004000		/* Visual erase for KILL.  */
-#define FLUSHO	0020000
-#define PENDIN	0040000		/* Retype pending input (state).  */
-#define TOSTOP	0100000		/* Send SIGTTOU for background output.	*/
-#define ITOSTOP TOSTOP
-#define EXTPROC 0200000		/* External processing on pty */
+#define ISIG	0x00001		/* Enable signals.  */
+#define ICANON	0x00002		/* Do erase and kill processing.  */
+#define XCASE	0x00004
+#define ECHO	0x00008		/* Enable echo.	 */
+#define ECHOE	0x00010		/* Visual erase for ERASE.  */
+#define ECHOK	0x00020		/* Echo NL after KILL.	*/
+#define ECHONL	0x00040		/* Echo NL even if ECHO is off.	 */
+#define NOFLSH	0x00080		/* Disable flush after interrupt.  */
+#define IEXTEN	0x00100		/* Enable DISCARD and LNEXT.  */
+#define ECHOCTL	0x00200		/* Echo control characters as ^X.  */
+#define ECHOPRT	0x00400		/* Hardcopy visual erase.  */
+#define ECHOKE	0x00800		/* Visual erase for KILL.  */
+#define FLUSHO	0x02000
+#define PENDIN	0x04000		/* Retype pending input (state).  */
+#define TOSTOP	0x08000		/* Send SIGTTOU for background output.	*/
+#define ITOSTOP	TOSTOP
+#define EXTPROC	0x10000		/* External processing on pty */
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 #define TIOCSER_TEMT	0x01	/* Transmitter physically empty */
diff --git a/arch/parisc/include/uapi/asm/termbits.h b/arch/parisc/include/uapi/asm/termbits.h
index 40e920f8d683..6017ee08f099 100644
--- a/arch/parisc/include/uapi/asm/termbits.h
+++ b/arch/parisc/include/uapi/asm/termbits.h
@@ -61,127 +61,127 @@ struct ktermios {
 
 
 /* c_iflag bits */
-#define IGNBRK	0000001
-#define BRKINT	0000002
-#define IGNPAR	0000004
-#define PARMRK	0000010
-#define INPCK	0000020
-#define ISTRIP	0000040
-#define INLCR	0000100
-#define IGNCR	0000200
-#define ICRNL	0000400
-#define IUCLC	0001000
-#define IXON	0002000
-#define IXANY	0004000
-#define IXOFF	0010000
-#define IMAXBEL	0040000
-#define IUTF8	0100000
+#define IGNBRK	0x00001
+#define BRKINT	0x00002
+#define IGNPAR	0x00004
+#define PARMRK	0x00008
+#define INPCK	0x00010
+#define ISTRIP	0x00020
+#define INLCR	0x00040
+#define IGNCR	0x00080
+#define ICRNL	0x00100
+#define IUCLC	0x00200
+#define IXON	0x00400
+#define IXANY	0x00800
+#define IXOFF	0x01000
+#define IMAXBEL	0x04000
+#define IUTF8	0x08000
 
 /* c_oflag bits */
-#define OPOST	0000001
-#define OLCUC	0000002
-#define ONLCR	0000004
-#define OCRNL	0000010
-#define ONOCR	0000020
-#define ONLRET	0000040
-#define OFILL	0000100
-#define OFDEL	0000200
-#define NLDLY	0000400
-#define   NL0	0000000
-#define   NL1	0000400
-#define CRDLY	0003000
-#define   CR0	0000000
-#define   CR1	0001000
-#define   CR2	0002000
-#define   CR3	0003000
-#define TABDLY	0014000
-#define   TAB0	0000000
-#define   TAB1	0004000
-#define   TAB2	0010000
-#define   TAB3	0014000
-#define   XTABS	0014000
-#define BSDLY	0020000
-#define   BS0	0000000
-#define   BS1	0020000
-#define VTDLY	0040000
-#define   VT0	0000000
-#define   VT1	0040000
-#define FFDLY	0100000
-#define   FF0	0000000
-#define   FF1	0100000
+#define OPOST	0x00001
+#define OLCUC	0x00002
+#define ONLCR	0x00004
+#define OCRNL	0x00008
+#define ONOCR	0x00010
+#define ONLRET	0x00020
+#define OFILL	0x00040
+#define OFDEL	0x00080
+#define NLDLY	0x00100
+#define   NL0	0x00000
+#define   NL1	0x00100
+#define CRDLY	0x00600
+#define   CR0	0x00000
+#define   CR1	0x00200
+#define   CR2	0x00400
+#define   CR3	0x00600
+#define TABDLY	0x01800
+#define   TAB0	0x00000
+#define   TAB1	0x00800
+#define   TAB2	0x01000
+#define   TAB3	0x01800
+#define   XTABS	0x01800
+#define BSDLY	0x02000
+#define   BS0	0x00000
+#define   BS1	0x02000
+#define VTDLY	0x04000
+#define   VT0	0x00000
+#define   VT1	0x04000
+#define FFDLY	0x08000
+#define   FF0	0x00000
+#define   FF1	0x08000
 
 /* c_cflag bit meaning */
-#define CBAUD   0010017
-#define  B0     0000000         /* hang up */
-#define  B50    0000001
-#define  B75    0000002
-#define  B110   0000003
-#define  B134   0000004
-#define  B150   0000005
-#define  B200   0000006
-#define  B300   0000007
-#define  B600   0000010
-#define  B1200  0000011
-#define  B1800  0000012
-#define  B2400  0000013
-#define  B4800  0000014
-#define  B9600  0000015
-#define  B19200 0000016
-#define  B38400 0000017
+#define CBAUD		0x0000100f
+#define  B0		0x00000000	/* hang up */
+#define  B50		0x00000001
+#define  B75		0x00000002
+#define  B110		0x00000003
+#define  B134		0x00000004
+#define  B150		0x00000005
+#define  B200		0x00000006
+#define  B300		0x00000007
+#define  B600		0x00000008
+#define  B1200		0x00000009
+#define  B1800		0x0000000a
+#define  B2400		0x0000000b
+#define  B4800		0x0000000c
+#define  B9600		0x0000000d
+#define  B19200		0x0000000e
+#define  B38400		0x0000000f
 #define EXTA B19200
 #define EXTB B38400
-#define CSIZE   0000060
-#define   CS5   0000000
-#define   CS6   0000020
-#define   CS7   0000040
-#define   CS8   0000060
-#define CSTOPB  0000100
-#define CREAD   0000200
-#define PARENB  0000400
-#define PARODD  0001000
-#define HUPCL   0002000
-#define CLOCAL  0004000
-#define CBAUDEX 0010000
-#define    BOTHER 0010000
-#define    B57600 0010001
-#define   B115200 0010002
-#define   B230400 0010003
-#define   B460800 0010004
-#define   B500000 0010005
-#define   B576000 0010006
-#define   B921600 0010007
-#define  B1000000 0010010
-#define  B1152000 0010011
-#define  B1500000 0010012
-#define  B2000000 0010013
-#define  B2500000 0010014
-#define  B3000000 0010015
-#define  B3500000 0010016
-#define  B4000000 0010017
-#define CIBAUD    002003600000		/* input baud rate */
-#define CMSPAR    010000000000          /* mark or space (stick) parity */
-#define CRTSCTS   020000000000          /* flow control */
+#define CSIZE		0x00000030
+#define   CS5		0x00000000
+#define   CS6		0x00000010
+#define   CS7		0x00000020
+#define   CS8		0x00000030
+#define CSTOPB		0x00000040
+#define CREAD		0x00000080
+#define PARENB		0x00000100
+#define PARODD		0x00000200
+#define HUPCL		0x00000400
+#define CLOCAL		0x00000800
+#define CBAUDEX		0x00001000
+#define    BOTHER	0x00001000
+#define    B57600	0x00001001
+#define   B115200	0x00001002
+#define   B230400	0x00001003
+#define   B460800	0x00001004
+#define   B500000	0x00001005
+#define   B576000	0x00001006
+#define   B921600	0x00001007
+#define  B1000000	0x00001008
+#define  B1152000	0x00001009
+#define  B1500000	0x0000100a
+#define  B2000000	0x0000100b
+#define  B2500000	0x0000100c
+#define  B3000000	0x0000100d
+#define  B3500000	0x0000100e
+#define  B4000000	0x0000100f
+#define CIBAUD		0x100f0000		/* input baud rate */
+#define CMSPAR		0x40000000		/* mark or space (stick) parity */
+#define CRTSCTS		0x80000000		/* flow control */
 
 #define IBSHIFT	16		/* Shift from CBAUD to CIBAUD */
 
 
 /* c_lflag bits */
-#define ISIG    0000001
-#define ICANON  0000002
-#define XCASE   0000004
-#define ECHO    0000010
-#define ECHOE   0000020
-#define ECHOK   0000040
-#define ECHONL  0000100
-#define NOFLSH  0000200
-#define TOSTOP  0000400
-#define ECHOCTL 0001000
-#define ECHOPRT 0002000
-#define ECHOKE  0004000
-#define FLUSHO  0010000
-#define PENDIN  0040000
-#define IEXTEN  0100000
-#define EXTPROC	0200000
+#define ISIG	0x00001
+#define ICANON	0x00002
+#define XCASE	0x00004
+#define ECHO	0x00008
+#define ECHOE	0x00010
+#define ECHOK	0x00020
+#define ECHONL	0x00040
+#define NOFLSH	0x00080
+#define TOSTOP	0x00100
+#define ECHOCTL	0x00200
+#define ECHOPRT	0x00400
+#define ECHOKE	0x00800
+#define FLUSHO	0x01000
+#define PENDIN	0x04000
+#define IEXTEN	0x08000
+#define EXTPROC	0x10000
 
 /* tcflow() and TCXONC use these */
 #define	TCOOFF		0
diff --git a/arch/powerpc/include/uapi/asm/termbits.h b/arch/powerpc/include/uapi/asm/termbits.h
index ed18bc61f63d..e4892f2d5592 100644
--- a/arch/powerpc/include/uapi/asm/termbits.h
+++ b/arch/powerpc/include/uapi/asm/termbits.h
@@ -64,115 +64,115 @@ struct ktermios {
 #define VDISCARD	16
 
 /* c_iflag bits */
-#define IGNBRK	0000001
-#define BRKINT	0000002
-#define IGNPAR	0000004
-#define PARMRK	0000010
-#define INPCK	0000020
-#define ISTRIP	0000040
-#define INLCR	0000100
-#define IGNCR	0000200
-#define ICRNL	0000400
-#define IXON	0001000
-#define IXOFF	0002000
-#define IXANY	0004000
-#define IUCLC	0010000
-#define IMAXBEL	0020000
-#define	IUTF8	0040000
+#define IGNBRK	0x00001
+#define BRKINT	0x00002
+#define IGNPAR	0x00004
+#define PARMRK	0x00008
+#define INPCK	0x00010
+#define ISTRIP	0x00020
+#define INLCR	0x00040
+#define IGNCR	0x00080
+#define ICRNL	0x00100
+#define IXON	0x00200
+#define IXOFF	0x00400
+#define IXANY	0x00800
+#define IUCLC	0x01000
+#define IMAXBEL	0x02000
+#define	IUTF8	0x04000
 
 /* c_oflag bits */
-#define OPOST	0000001
-#define ONLCR	0000002
-#define OLCUC	0000004
-
-#define OCRNL	0000010
-#define ONOCR	0000020
-#define ONLRET	0000040
-
-#define OFILL	00000100
-#define OFDEL	00000200
-#define NLDLY	00001400
-#define   NL0	00000000
-#define   NL1	00000400
-#define   NL2	00001000
-#define   NL3	00001400
-#define TABDLY	00006000
-#define   TAB0	00000000
-#define   TAB1	00002000
-#define   TAB2	00004000
-#define   TAB3	00006000
-#define   XTABS	00006000	/* required by POSIX to == TAB3 */
-#define CRDLY	00030000
-#define   CR0	00000000
-#define   CR1	00010000
-#define   CR2	00020000
-#define   CR3	00030000
-#define FFDLY	00040000
-#define   FF0	00000000
-#define   FF1	00040000
-#define BSDLY	00100000
-#define   BS0	00000000
-#define   BS1	00100000
-#define VTDLY	00200000
-#define   VT0	00000000
-#define   VT1	00200000
+#define OPOST	0x00001
+#define ONLCR	0x00002
+#define OLCUC	0x00004
+
+#define OCRNL	0x00008
+#define ONOCR	0x00010
+#define ONLRET	0x00020
+
+#define OFILL	0x000040
+#define OFDEL	0x000080
+#define NLDLY	0x000300
+#define   NL0	0x000000
+#define   NL1	0x000100
+#define   NL2	0x000200
+#define   NL3	0x000300
+#define TABDLY	0x000c00
+#define   TAB0	0x000000
+#define   TAB1	0x000400
+#define   TAB2	0x000800
+#define   TAB3	0x000c00
+#define   XTABS	0x000c00	/* required by POSIX to == TAB3 */
+#define CRDLY	0x003000
+#define   CR0	0x000000
+#define   CR1	0x001000
+#define   CR2	0x002000
+#define   CR3	0x003000
+#define FFDLY	0x004000
+#define   FF0	0x000000
+#define   FF1	0x004000
+#define BSDLY	0x008000
+#define   BS0	0x000000
+#define   BS1	0x008000
+#define VTDLY	0x010000
+#define   VT0	0x000000
+#define   VT1	0x010000
 
 /* c_cflag bit meaning */
-#define CBAUD	0000377
-#define  B0	0000000		/* hang up */
-#define  B50	0000001
-#define  B75	0000002
-#define  B110	0000003
-#define  B134	0000004
-#define  B150	0000005
-#define  B200	0000006
-#define  B300	0000007
-#define  B600	0000010
-#define  B1200	0000011
-#define  B1800	0000012
-#define  B2400	0000013
-#define  B4800	0000014
-#define  B9600	0000015
-#define  B19200	0000016
-#define  B38400	0000017
+#define CBAUD		0x000000ff
+#define  B0		0x00000000	/* hang up */
+#define  B50		0x00000001
+#define  B75		0x00000002
+#define  B110		0x00000003
+#define  B134		0x00000004
+#define  B150		0x00000005
+#define  B200		0x00000006
+#define  B300		0x00000007
+#define  B600		0x00000008
+#define  B1200		0x00000009
+#define  B1800		0x0000000a
+#define  B2400		0x0000000b
+#define  B4800		0x0000000c
+#define  B9600		0x0000000d
+#define  B19200		0x0000000e
+#define  B38400		0x0000000f
 #define  EXTA   B19200
 #define  EXTB   B38400
-#define  CBAUDEX 0000000
-#define  B57600   00020
-#define  B115200  00021
-#define  B230400  00022
-#define  B460800  00023
-#define  B500000  00024
-#define  B576000  00025
-#define  B921600  00026
-#define B1000000  00027
-#define B1152000  00030
-#define B1500000  00031
-#define B2000000  00032
-#define B2500000  00033
-#define B3000000  00034
-#define B3500000  00035
-#define B4000000  00036
-#define   BOTHER  00037
-
-#define CIBAUD	077600000
+#define CBAUDEX		0x00000000
+#define  B57600		0x00000010
+#define  B115200	0x00000011
+#define  B230400	0x00000012
+#define  B460800	0x00000013
+#define  B500000	0x00000014
+#define  B576000	0x00000015
+#define  B921600	0x00000016
+#define B1000000	0x00000017
+#define B1152000	0x00000018
+#define B1500000	0x00000019
+#define B2000000	0x0000001a
+#define B2500000	0x0000001b
+#define B3000000	0x0000001c
+#define B3500000	0x0000001d
+#define B4000000	0x0000001e
+#define   BOTHER	0x0000001f
+
+#define CIBAUD		0x00ff0000
 #define IBSHIFT	16		/* Shift from CBAUD to CIBAUD */
 
-#define CSIZE	00001400
-#define   CS5	00000000
-#define   CS6	00000400
-#define   CS7	00001000
-#define   CS8	00001400
-
-#define CSTOPB	00002000
-#define CREAD	00004000
-#define PARENB	00010000
-#define PARODD	00020000
-#define HUPCL	00040000
-
-#define CLOCAL	00100000
-#define CMSPAR	  010000000000		/* mark or space (stick) parity */
-#define CRTSCTS	  020000000000		/* flow control */
+#define CSIZE		0x00000300
+#define   CS5		0x00000000
+#define   CS6		0x00000100
+#define   CS7		0x00000200
+#define   CS8		0x00000300
+
+#define CSTOPB		0x00000400
+#define CREAD		0x00000800
+#define PARENB		0x00001000
+#define PARODD		0x00002000
+#define HUPCL		0x00004000
+
+#define CLOCAL		0x00008000
+#define CMSPAR		0x40000000	/* mark or space (stick) parity */
+#define CRTSCTS		0x80000000	/* flow control */
 
 /* c_lflag bits */
 #define ISIG	0x00000080
diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-generic/termbits.h
index 2fbaf9ae89dd..470fd673ff84 100644
--- a/include/uapi/asm-generic/termbits.h
+++ b/include/uapi/asm-generic/termbits.h
@@ -60,126 +60,126 @@ struct ktermios {
 #define VEOL2 16
 
 /* c_iflag bits */
-#define IGNBRK	0000001
-#define BRKINT	0000002
-#define IGNPAR	0000004
-#define PARMRK	0000010
-#define INPCK	0000020
-#define ISTRIP	0000040
-#define INLCR	0000100
-#define IGNCR	0000200
-#define ICRNL	0000400
-#define IUCLC	0001000
-#define IXON	0002000
-#define IXANY	0004000
-#define IXOFF	0010000
-#define IMAXBEL	0020000
-#define IUTF8	0040000
+#define IGNBRK	0x00001
+#define BRKINT	0x00002
+#define IGNPAR	0x00004
+#define PARMRK	0x00008
+#define INPCK	0x00010
+#define ISTRIP	0x00020
+#define INLCR	0x00040
+#define IGNCR	0x00080
+#define ICRNL	0x00100
+#define IUCLC	0x00200
+#define IXON	0x00400
+#define IXANY	0x00800
+#define IXOFF	0x01000
+#define IMAXBEL	0x02000
+#define IUTF8	0x04000
 
 /* c_oflag bits */
-#define OPOST	0000001
-#define OLCUC	0000002
-#define ONLCR	0000004
-#define OCRNL	0000010
-#define ONOCR	0000020
-#define ONLRET	0000040
-#define OFILL	0000100
-#define OFDEL	0000200
-#define NLDLY	0000400
-#define   NL0	0000000
-#define   NL1	0000400
-#define CRDLY	0003000
-#define   CR0	0000000
-#define   CR1	0001000
-#define   CR2	0002000
-#define   CR3	0003000
-#define TABDLY	0014000
-#define   TAB0	0000000
-#define   TAB1	0004000
-#define   TAB2	0010000
-#define   TAB3	0014000
-#define   XTABS	0014000
-#define BSDLY	0020000
-#define   BS0	0000000
-#define   BS1	0020000
-#define VTDLY	0040000
-#define   VT0	0000000
-#define   VT1	0040000
-#define FFDLY	0100000
-#define   FF0	0000000
-#define   FF1	0100000
+#define OPOST	0x00001
+#define OLCUC	0x00002
+#define ONLCR	0x00004
+#define OCRNL	0x00008
+#define ONOCR	0x00010
+#define ONLRET	0x00020
+#define OFILL	0x00040
+#define OFDEL	0x00080
+#define NLDLY	0x00100
+#define   NL0	0x00000
+#define   NL1	0x00100
+#define CRDLY	0x00600
+#define   CR0	0x00000
+#define   CR1	0x00200
+#define   CR2	0x00400
+#define   CR3	0x00600
+#define TABDLY	0x01800
+#define   TAB0	0x00000
+#define   TAB1	0x00800
+#define   TAB2	0x01000
+#define   TAB3	0x01800
+#define   XTABS	0x01800
+#define BSDLY	0x02000
+#define   BS0	0x00000
+#define   BS1	0x02000
+#define VTDLY	0x04000
+#define   VT0	0x00000
+#define   VT1	0x04000
+#define FFDLY	0x08000
+#define   FF0	0x00000
+#define   FF1	0x08000
 
 /* c_cflag bit meaning */
-#define CBAUD	0010017
-#define  B0	0000000		/* hang up */
-#define  B50	0000001
-#define  B75	0000002
-#define  B110	0000003
-#define  B134	0000004
-#define  B150	0000005
-#define  B200	0000006
-#define  B300	0000007
-#define  B600	0000010
-#define  B1200	0000011
-#define  B1800	0000012
-#define  B2400	0000013
-#define  B4800	0000014
-#define  B9600	0000015
-#define  B19200	0000016
-#define  B38400	0000017
+#define CBAUD		0x0000100f
+#define  B0		0x00000000	/* hang up */
+#define  B50		0x00000001
+#define  B75		0x00000002
+#define  B110		0x00000003
+#define  B134		0x00000004
+#define  B150		0x00000005
+#define  B200		0x00000006
+#define  B300		0x00000007
+#define  B600		0x00000008
+#define  B1200		0x00000009
+#define  B1800		0x0000000a
+#define  B2400		0x0000000b
+#define  B4800		0x0000000c
+#define  B9600		0x0000000d
+#define  B19200		0x0000000e
+#define  B38400		0x0000000f
 #define EXTA B19200
 #define EXTB B38400
-#define CSIZE	0000060
-#define   CS5	0000000
-#define   CS6	0000020
-#define   CS7	0000040
-#define   CS8	0000060
-#define CSTOPB	0000100
-#define CREAD	0000200
-#define PARENB	0000400
-#define PARODD	0001000
-#define HUPCL	0002000
-#define CLOCAL	0004000
-#define CBAUDEX 0010000
-#define    BOTHER 0010000
-#define    B57600 0010001
-#define   B115200 0010002
-#define   B230400 0010003
-#define   B460800 0010004
-#define   B500000 0010005
-#define   B576000 0010006
-#define   B921600 0010007
-#define  B1000000 0010010
-#define  B1152000 0010011
-#define  B1500000 0010012
-#define  B2000000 0010013
-#define  B2500000 0010014
-#define  B3000000 0010015
-#define  B3500000 0010016
-#define  B4000000 0010017
-#define CIBAUD	  002003600000	/* input baud rate */
-#define CMSPAR	  010000000000	/* mark or space (stick) parity */
-#define CRTSCTS	  020000000000	/* flow control */
+#define CSIZE		0x00000030
+#define   CS5		0x00000000
+#define   CS6		0x00000010
+#define   CS7		0x00000020
+#define   CS8		0x00000030
+#define CSTOPB		0x00000040
+#define CREAD		0x00000080
+#define PARENB		0x00000100
+#define PARODD		0x00000200
+#define HUPCL		0x00000400
+#define CLOCAL		0x00000800
+#define CBAUDEX		0x00001000
+#define    BOTHER	0x00001000
+#define    B57600	0x00001001
+#define   B115200	0x00001002
+#define   B230400	0x00001003
+#define   B460800	0x00001004
+#define   B500000	0x00001005
+#define   B576000	0x00001006
+#define   B921600	0x00001007
+#define  B1000000	0x00001008
+#define  B1152000	0x00001009
+#define  B1500000	0x0000100a
+#define  B2000000	0x0000100b
+#define  B2500000	0x0000100c
+#define  B3000000	0x0000100d
+#define  B3500000	0x0000100e
+#define  B4000000	0x0000100f
+#define CIBAUD		0x100f0000	/* input baud rate */
+#define CMSPAR		0x40000000	/* mark or space (stick) parity */
+#define CRTSCTS		0x80000000	/* flow control */
 
 #define IBSHIFT	  16		/* Shift from CBAUD to CIBAUD */
 
 /* c_lflag bits */
-#define ISIG	0000001
-#define ICANON	0000002
-#define XCASE	0000004
-#define ECHO	0000010
-#define ECHOE	0000020
-#define ECHOK	0000040
-#define ECHONL	0000100
-#define NOFLSH	0000200
-#define TOSTOP	0000400
-#define ECHOCTL	0001000
-#define ECHOPRT	0002000
-#define ECHOKE	0004000
-#define FLUSHO	0010000
-#define PENDIN	0040000
-#define IEXTEN	0100000
-#define EXTPROC	0200000
+#define ISIG	0x00001
+#define ICANON	0x00002
+#define XCASE	0x00004
+#define ECHO	0x00008
+#define ECHOE	0x00010
+#define ECHOK	0x00020
+#define ECHONL	0x00040
+#define NOFLSH	0x00080
+#define TOSTOP	0x00100
+#define ECHOCTL	0x00200
+#define ECHOPRT	0x00400
+#define ECHOKE	0x00800
+#define FLUSHO	0x01000
+#define PENDIN	0x04000
+#define IEXTEN	0x08000
+#define EXTPROC	0x10000
 
 /* tcflow() and TCXONC use these */
 #define	TCOOFF		0
-- 
2.30.2

--8323329-1991360190-1651648872=:1623--
