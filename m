Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDEB51ADB
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2019 20:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbfFXSmM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jun 2019 14:42:12 -0400
Received: from mail-eopbgr740091.outbound.protection.outlook.com ([40.107.74.91]:51795
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727664AbfFXSmM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Jun 2019 14:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bwa7WxpERdX0z2NKRNbkuJnFvJ07CLf+VIHp89xBq2U=;
 b=AkcG2qBy765ZyDYQTKfBdc7qhNMjSbU6+NvHSvSUK/qnuKY7lGXg1KsEkiiK4lV4PjXPxgdcdREsOaIt/yC0G96iE3YMV+0CvqOV6EcNZTcSUY7qqofvK+Ff6kYrjmJ2i/Pe0gU5KUDU8emg0i1Hm0Xk8o9wgQ1Xd12EVuQGvnY=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.172.60.12) by
 MWHPR2201MB1455.namprd22.prod.outlook.com (10.174.170.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Mon, 24 Jun 2019 18:41:59 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::6975:b632:c85b:9e40]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::6975:b632:c85b:9e40%2]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 18:41:59 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@openvz.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v7 00/25] Unify vDSOs across more architectures
Thread-Topic: [PATCH v7 00/25] Unify vDSOs across more architectures
Thread-Index: AQHVKBcjN6FJrtEBy0+FRUrPEWueWKap+PYAgAEv3IA=
Date:   Mon, 24 Jun 2019 18:41:59 +0000
Message-ID: <20190624184157.mu6n74a7qqa4z5z5@pburton-laptop>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0062.namprd07.prod.outlook.com
 (2603:10b6:a03:60::39) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:18::12)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.94.197.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0278fd0c-aa61-463a-87b9-08d6f8d3a3c0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR2201MB1455;
x-ms-traffictypediagnostic: MWHPR2201MB1455:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR2201MB1455BEC50694CB15A99F7FFBC1E00@MWHPR2201MB1455.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39840400004)(136003)(346002)(376002)(366004)(396003)(189003)(199004)(52116002)(26005)(33716001)(99286004)(7736002)(3846002)(6116002)(8936002)(81166006)(8676002)(81156014)(6506007)(76176011)(66066001)(6436002)(7416002)(6486002)(2906002)(102836004)(229853002)(386003)(305945005)(478600001)(256004)(14444005)(5660300002)(1076003)(476003)(30864003)(44832011)(486006)(71190400001)(71200400001)(4326008)(73956011)(66476007)(64756008)(66946007)(66446008)(66556008)(6512007)(53946003)(68736007)(6306002)(58126008)(54906003)(186003)(6246003)(316002)(25786009)(966005)(110136005)(14454004)(53936002)(42882007)(11346002)(9686003)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1455;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3pH/8GNVePaIwsTHUljMBKTYuNFygEnHJ9NsPdBM5wJH4kg4nL5MTppnQjON2fyAHynmWz/HY0wk5ukxD1rVXkKCQDbl9pMzSDzNZu4fGvrB5egBQmUuGrfpFGdTBjdg7IwK/9ko64K+M/2R5wrsBBh194nh422C+V6BRExCIho//NJT1AWFRTbynp5EXz1UExvI0Su/Og+v3xLifG2lUIs057kGDNa6XV3CWpIuvKJWKvKRYtu9Q4GucPk/2hMSsusC/dJJ29b+Vh5u5etfo2rmweSOJElDsH+GsYILbgpUQjjESpwLD1eZ1STviaQYxEo6D687bcI/b4YaBVNcy9tlWex6AN9na/Oqj0h/fnVHSGdIh9YCqfcROnWcfhf7Jr70n/nmY/i+xQLbO9Pm9bJTy1K9aacJSFNe04slK+Q=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <64025CA1F21A8D4AB537FC251ED3392D@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0278fd0c-aa61-463a-87b9-08d6f8d3a3c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 18:41:59.3439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pburton@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1455
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,

On Mon, Jun 24, 2019 at 02:34:24AM +0200, Thomas Gleixner wrote:
> I did not merge the ARM and MIPS parts as they lack any form of
> acknowlegment from their maintainers. Please talk to those folks. If they
> ack/review the changes then I can pick them up and they go into 5.3 or th=
ey
> have to go in a later cycle. Nevertheless it was well worth the trouble t=
o
> have those conversions done to confirm that the new common library fits a
> bunch of different architectures.

Apologies for not being more proactive on the MIPS front here; life &
work are extra busy at the moment... But thanks Vincenzo for including
MIPS in the work here.

Unfortunately after applying the 3 MIPS patches (19-21) atop the current
tip.git timers/vdso branch at ecf9db3d1f1a ("x86/vdso: Give the
[ph]vclock_page declarations real types") I see build failures for the
o32 compat VDSO, shown below. This is using the gcc 8.1.0 mips-linux
toolchain from here:

  https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.=
0/x86_64-gcc-8.1.0-nolibc-mips-linux.tar.xz

Configuration is 64r6el_defconfig. The following helps remove the
implicit declaration warnings (and eww to including C files via CFLAGS),
but it still doesn't build:

  diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
  index 95df49402a53..aa38049bdb24 100644
  --- a/arch/mips/vdso/Makefile
  +++ b/arch/mips/vdso/Makefile
  @@ -36,6 +36,8 @@ aflags-vdso :=3D $(ccflags-vdso) \
 =20
   ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o =3D -include $(c-gettimeofday-y)
  +CFLAGS_vgettimeofday-o32.o =3D -include $(c-gettimeofday-y)
  +CFLAGS_vgettimeofday-n32.o =3D -include $(c-gettimeofday-y)
   endif

 CFLAGS_REMOVE_vgettimeofday.o =3D -pg

So the MIPS bits here need more work.

Thanks,
    Paul

  CC      arch/mips/vdso/vgettimeofday-o32.o
In file included from ./include/linux/bitops.h:19,
                 from ./include/linux/kernel.h:12,
                 from ./include/linux/list.h:9,
                 from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:51,
                 from ./include/linux/seqlock.h:36,
                 from ./include/linux/time.h:6,
                 from arch/mips/vdso/vgettimeofday.c:10:
./arch/mips/include/asm/bitops.h: In function '__fls':
./arch/mips/include/asm/bitops.h:518:21: warning: left shift count >=3D wid=
th of type [-Wshift-count-overflow]
  if (!(word & (~0ul << 32))) {
                     ^~
./arch/mips/include/asm/bitops.h:520:8: warning: left shift count >=3D widt=
h of type [-Wshift-count-overflow]
   word <<=3D 32;
        ^~~
./arch/mips/include/asm/bitops.h:523:21: warning: left shift count >=3D wid=
th of type [-Wshift-count-overflow]
  if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
                     ^~
./arch/mips/include/asm/bitops.h:527:21: warning: left shift count >=3D wid=
th of type [-Wshift-count-overflow]
  if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
                     ^~
./arch/mips/include/asm/bitops.h:531:21: warning: left shift count >=3D wid=
th of type [-Wshift-count-overflow]
  if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
                     ^~
./arch/mips/include/asm/bitops.h:535:21: warning: left shift count >=3D wid=
th of type [-Wshift-count-overflow]
  if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
                     ^~
./arch/mips/include/asm/bitops.h:539:21: warning: left shift count >=3D wid=
th of type [-Wshift-count-overflow]
  if (!(word & (~0ul << (BITS_PER_LONG-1))))
                     ^~
In file included from ./arch/mips/include/asm/mmiowb.h:5,
                 from ./include/linux/spinlock.h:60,
                 from ./include/linux/seqlock.h:36,
                 from ./include/linux/time.h:6,
                 from arch/mips/vdso/vgettimeofday.c:10:
./arch/mips/include/asm/io.h: In function 'phys_to_virt':
./arch/mips/include/asm/io.h:136:9: warning: cast to pointer from integer o=
f different size [-Wint-to-pointer-cast]
  return (void *)(address + PAGE_OFFSET - PHYS_OFFSET);
         ^
In file included from ./include/linux/bitops.h:5,
                 from ./include/linux/kernel.h:12,
                 from ./include/linux/list.h:9,
                 from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:51,
                 from ./include/linux/seqlock.h:36,
                 from ./include/linux/time.h:6,
                 from arch/mips/vdso/vgettimeofday.c:10:
./arch/mips/include/asm/mips-cm.h: In function 'mips_cm_max_vp_width':
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:152:28: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_REV_MAJOR   GENMASK(15, 8)
                            ^~~~~~~
./arch/mips/include/asm/mips-cm.h:156:22: note: in expansion of macro 'CM_G=
CR_REV_MAJOR'
   (((major) << __ffs(CM_GCR_REV_MAJOR)) | \
                      ^~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cm.h:161:23: note: in expansion of macro 'CM_E=
NCODE_REV'
 #define CM_REV_CM3    CM_ENCODE_REV(8, 0)
                       ^~~~~~~~~~~~~
./arch/mips/include/asm/mips-cm.h:367:28: note: in expansion of macro 'CM_R=
EV_CM3'
  if (mips_cm_revision() >=3D CM_REV_CM3)
                            ^~~~~~~~~~
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:153:28: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_REV_MINOR   GENMASK(7, 0)
                            ^~~~~~~
./arch/mips/include/asm/mips-cm.h:157:22: note: in expansion of macro 'CM_G=
CR_REV_MINOR'
    ((minor) << __ffs(CM_GCR_REV_MINOR)))
                      ^~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cm.h:161:23: note: in expansion of macro 'CM_E=
NCODE_REV'
 #define CM_REV_CM3    CM_ENCODE_REV(8, 0)
                       ^~~~~~~~~~~~~
./arch/mips/include/asm/mips-cm.h:367:28: note: in expansion of macro 'CM_R=
EV_CM3'
  if (mips_cm_revision() >=3D CM_REV_CM3)
                            ^~~~~~~~~~
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:239:36: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_SYS_CONFIG2_MAXVPW  GENMASK(3, 0)
                                    ^~~~~~~
./arch/mips/include/asm/mips-cm.h:368:35: note: in expansion of macro 'CM_G=
CR_SYS_CONFIG2_MAXVPW'
   return read_gcr_sys_config2() & CM_GCR_SYS_CONFIG2_MAXVPW;
                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:293:33: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_Cx_CONFIG_PVPE   GENMASK(9, 0)
                                 ^~~~~~~
./arch/mips/include/asm/mips-cm.h:376:32: note: in expansion of macro 'CM_G=
CR_Cx_CONFIG_PVPE'
   cfg =3D read_gcr_cl_config() & CM_GCR_Cx_CONFIG_PVPE;
                                ^~~~~~~~~~~~~~~~~~~~~
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:293:33: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_Cx_CONFIG_PVPE   GENMASK(9, 0)
                                 ^~~~~~~
./arch/mips/include/asm/mips-cm.h:377:24: note: in expansion of macro 'CM_G=
CR_Cx_CONFIG_PVPE'
   return (cfg >> __ffs(CM_GCR_Cx_CONFIG_PVPE)) + 1;
                        ^~~~~~~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cps.h: In function 'mips_cps_numclusters':
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:152:28: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_REV_MAJOR   GENMASK(15, 8)
                            ^~~~~~~
./arch/mips/include/asm/mips-cm.h:156:22: note: in expansion of macro 'CM_G=
CR_REV_MAJOR'
   (((major) << __ffs(CM_GCR_REV_MAJOR)) | \
                      ^~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cm.h:162:25: note: in expansion of macro 'CM_E=
NCODE_REV'
 #define CM_REV_CM3_5    CM_ENCODE_REV(9, 0)
                         ^~~~~~~~~~~~~
./arch/mips/include/asm/mips-cps.h:117:27: note: in expansion of macro 'CM_=
REV_CM3_5'
  if (mips_cm_revision() < CM_REV_CM3_5)
                           ^~~~~~~~~~~~
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:153:28: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_REV_MINOR   GENMASK(7, 0)
                            ^~~~~~~
./arch/mips/include/asm/mips-cm.h:157:22: note: in expansion of macro 'CM_G=
CR_REV_MINOR'
    ((minor) << __ffs(CM_GCR_REV_MINOR)))
                      ^~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cm.h:162:25: note: in expansion of macro 'CM_E=
NCODE_REV'
 #define CM_REV_CM3_5    CM_ENCODE_REV(9, 0)
                         ^~~~~~~~~~~~~
./arch/mips/include/asm/mips-cps.h:117:27: note: in expansion of macro 'CM_=
REV_CM3_5'
  if (mips_cm_revision() < CM_REV_CM3_5)
                           ^~~~~~~~~~~~
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:133:37: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_CONFIG_NUM_CLUSTERS  GENMASK(29, 23)
                                     ^~~~~~~
./arch/mips/include/asm/mips-cps.h:120:37: note: in expansion of macro 'CM_=
GCR_CONFIG_NUM_CLUSTERS'
  num_clusters =3D read_gcr_config() & CM_GCR_CONFIG_NUM_CLUSTERS;
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:133:37: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_CONFIG_NUM_CLUSTERS  GENMASK(29, 23)
                                     ^~~~~~~
./arch/mips/include/asm/mips-cps.h:121:25: note: in expansion of macro 'CM_=
GCR_CONFIG_NUM_CLUSTERS'
  num_clusters >>=3D __ffs(CM_GCR_CONFIG_NUM_CLUSTERS);
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cps.h: In function 'mips_cps_cluster_config':
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:152:28: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_REV_MAJOR   GENMASK(15, 8)
                            ^~~~~~~
./arch/mips/include/asm/mips-cm.h:156:22: note: in expansion of macro 'CM_G=
CR_REV_MAJOR'
   (((major) << __ffs(CM_GCR_REV_MAJOR)) | \
                      ^~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cm.h:162:25: note: in expansion of macro 'CM_E=
NCODE_REV'
 #define CM_REV_CM3_5    CM_ENCODE_REV(9, 0)
                         ^~~~~~~~~~~~~
./arch/mips/include/asm/mips-cps.h:137:27: note: in expansion of macro 'CM_=
REV_CM3_5'
  if (mips_cm_revision() < CM_REV_CM3_5) {
                           ^~~~~~~~~~~~
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:153:28: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_REV_MINOR   GENMASK(7, 0)
                            ^~~~~~~
./arch/mips/include/asm/mips-cm.h:157:22: note: in expansion of macro 'CM_G=
CR_REV_MINOR'
    ((minor) << __ffs(CM_GCR_REV_MINOR)))
                      ^~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cm.h:162:25: note: in expansion of macro 'CM_E=
NCODE_REV'
 #define CM_REV_CM3_5    CM_ENCODE_REV(9, 0)
                         ^~~~~~~~~~~~~
./arch/mips/include/asm/mips-cps.h:137:27: note: in expansion of macro 'CM_=
REV_CM3_5'
  if (mips_cm_revision() < CM_REV_CM3_5) {
                           ^~~~~~~~~~~~
./arch/mips/include/asm/mips-cps.h: In function 'mips_cps_numcores':
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:135:32: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_CONFIG_PCORES   GENMASK(7, 0)
                                ^~~~~~~
./arch/mips/include/asm/mips-cps.h:172:50: note: in expansion of macro 'CM_=
GCR_CONFIG_PCORES'
  return (mips_cps_cluster_config(cluster) + 1) & CM_GCR_CONFIG_PCORES;
                                                  ^~~~~~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cps.h: In function 'mips_cps_numiocu':
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:134:33: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_CONFIG_NUMIOCU   GENMASK(15, 8)
                                 ^~~~~~~
./arch/mips/include/asm/mips-cps.h:189:48: note: in expansion of macro 'CM_=
GCR_CONFIG_NUMIOCU'
  num_iocu =3D mips_cps_cluster_config(cluster) & CM_GCR_CONFIG_NUMIOCU;
                                                ^~~~~~~~~~~~~~~~~~~~~
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:134:33: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_CONFIG_NUMIOCU   GENMASK(15, 8)
                                 ^~~~~~~
./arch/mips/include/asm/mips-cps.h:190:21: note: in expansion of macro 'CM_=
GCR_CONFIG_NUMIOCU'
  num_iocu >>=3D __ffs(CM_GCR_CONFIG_NUMIOCU);
                     ^~~~~~~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cps.h: In function 'mips_cps_numvps':
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:152:28: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_REV_MAJOR   GENMASK(15, 8)
                            ^~~~~~~
./arch/mips/include/asm/mips-cm.h:156:22: note: in expansion of macro 'CM_G=
CR_REV_MAJOR'
   (((major) << __ffs(CM_GCR_REV_MAJOR)) | \
                      ^~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cm.h:162:25: note: in expansion of macro 'CM_E=
NCODE_REV'
 #define CM_REV_CM3_5    CM_ENCODE_REV(9, 0)
                         ^~~~~~~~~~~~~
./arch/mips/include/asm/mips-cps.h:216:27: note: in expansion of macro 'CM_=
REV_CM3_5'
  if (mips_cm_revision() < CM_REV_CM3_5) {
                           ^~~~~~~~~~~~
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:153:28: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_REV_MINOR   GENMASK(7, 0)
                            ^~~~~~~
./arch/mips/include/asm/mips-cm.h:157:22: note: in expansion of macro 'CM_G=
CR_REV_MINOR'
    ((minor) << __ffs(CM_GCR_REV_MINOR)))
                      ^~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cm.h:162:25: note: in expansion of macro 'CM_E=
NCODE_REV'
 #define CM_REV_CM3_5    CM_ENCODE_REV(9, 0)
                         ^~~~~~~~~~~~~
./arch/mips/include/asm/mips-cps.h:216:27: note: in expansion of macro 'CM_=
REV_CM3_5'
  if (mips_cm_revision() < CM_REV_CM3_5) {
                           ^~~~~~~~~~~~
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:293:33: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_Cx_CONFIG_PVPE   GENMASK(9, 0)
                                 ^~~~~~~
./arch/mips/include/asm/mips-cps.h:233:21: note: in expansion of macro 'CM_=
GCR_Cx_CONFIG_PVPE'
  return (cfg + 1) & CM_GCR_Cx_CONFIG_PVPE;
                     ^~~~~~~~~~~~~~~~~~~~~
arch/mips/vdso/vgettimeofday.c: In function '__vdso_clock_gettime':
arch/mips/vdso/vgettimeofday.c:17:9: error: implicit declaration of functio=
n '__cvdso_clock_gettime32'; did you mean '__vdso_clock_gettime'? [-Werror=
=3Dimplicit-function-declaration]
  return __cvdso_clock_gettime32(clock, ts);
         ^~~~~~~~~~~~~~~~~~~~~~~
         __vdso_clock_gettime
arch/mips/vdso/vgettimeofday.c: In function '__vdso_gettimeofday':
arch/mips/vdso/vgettimeofday.c:23:9: error: implicit declaration of functio=
n '__cvdso_gettimeofday'; did you mean '__vdso_gettimeofday'? [-Werror=3Dim=
plicit-function-declaration]
  return __cvdso_gettimeofday(tv, tz);
         ^~~~~~~~~~~~~~~~~~~~
         __vdso_gettimeofday
arch/mips/vdso/vgettimeofday.c: In function '__vdso_clock_getres':
arch/mips/vdso/vgettimeofday.c:29:9: error: implicit declaration of functio=
n '__cvdso_clock_getres_time32'; did you mean '__vdso_clock_gettime'? [-Wer=
ror=3Dimplicit-function-declaration]
  return __cvdso_clock_getres_time32(clock_id, res);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         __vdso_clock_gettime
arch/mips/vdso/vgettimeofday.c: In function '__vdso_clock_gettime64':
arch/mips/vdso/vgettimeofday.c:35:9: error: implicit declaration of functio=
n '__cvdso_clock_gettime'; did you mean '__vdso_clock_gettime'? [-Werror=3D=
implicit-function-declaration]
  return __cvdso_clock_gettime(clock, ts);
         ^~~~~~~~~~~~~~~~~~~~~
         __vdso_clock_gettime
cc1: some warnings being treated as errors
make[1]: *** [arch/mips/vdso/Makefile:148: arch/mips/vdso/vgettimeofday-o32=
.o] Error 1
make: *** [Makefile:1746: arch/mips/vdso/vgettimeofday-o32.o] Error 2
