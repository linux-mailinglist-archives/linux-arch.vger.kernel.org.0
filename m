Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62C667C13B
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 00:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjAYX7V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 18:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjAYX7U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 18:59:20 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C27460C9A;
        Wed, 25 Jan 2023 15:59:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DY9NMSLYLooHa+rvnQfhepVXfEE6SHTF+husujyd4Wu+xGAz43W1KOTBxZqXJvj0pERnxu8KebgIaL5Ih7S4LY6m9UQTETrBIJK3a6do6V34VNsEUUuBqGbpFRN+gDyGClPmqgCOfUw13OW4vtuOJOh8kmSqSyLI7bJ50pTAQemx9wKD2JdzqNZFHfJPWPEAt+ugN6U2xaS72xD2r0mhykxPh9F0iX3+7J+n7+hsgtDKlfHMdOolnuYYgRPs1kh2toVk2baUlm0bB+Ta6R+YQij3E48sijCApW/Sk23lmA2aA7u1kWuQL7XmTTbSn2eRBLj13Uf86bGrpS2FgqVrBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dfyz/CoSJFVgo9P8KdVC/8xwZJv2oSUP4VBxZCoK+V0=;
 b=oVR1WwmwLODhaVPhZs/9tRTjoDTkTpFu55Fv/49jS0IEiuOOqUGRtAtinc3AwJ7MSGno4ecRaIgezByWrawRvW2ivfFHQPyBkI75V26OMkZ6MzriRcGPg2lijUk4mPR+BnPCI/FlHibHOBd6khfS9goFI5pysU33N990tHl61ovE3fMRjGmGGYK2vcSSTdAv/2VU1F2wLr7md2z2LMjsIYCRlAuWEqWLqAqNS/E8e4TX0DCf7Vr0pePqqC14xowfHkBWlIZemzVnUTF3Y1Qqiq7MtBqB9gRgulk+HNpNQLfU3IN/vR9j38yLs+CuJpCoYvC+ZqEqd2Oep3Wq9TkNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dfyz/CoSJFVgo9P8KdVC/8xwZJv2oSUP4VBxZCoK+V0=;
 b=HHzolz4WzH5IQd0nT2AzfVBjMYMTYYnzwEWAwbIQwQrpEdqCrtlfGDCXcX48AA03teDGOWDm7zJ9exZQTrkdpcjcnJ9wMXlLc46/DBomXXAZ/otydnSOYV9DzAq5eJnPAqP62VSXv6IfOvgQJKcpOekJUVCfI17PQs8DAfwwFu0=
Received: from IA1PR07MB9830.namprd07.prod.outlook.com (2603:10b6:208:44b::14)
 by MW4PR07MB8713.namprd07.prod.outlook.com (2603:10b6:303:106::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 23:59:08 +0000
Received: from IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::670b:627c:6340:583]) by IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::670b:627c:6340:583%3]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 23:59:08 +0000
From:   Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
To:     "anton@tuxera.com" <anton@tuxera.com>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "glider@google.com" <glider@google.com>,
        "elver@google.com" <elver@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "yury.norov@gmail.com" <yury.norov@gmail.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "alexandr.lobakin@intel.com" <alexandr.lobakin@intel.com>,
        "mpatocka@redhat.com" <mpatocka@redhat.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: KASAN: slab-out-of-bounds Read in ntfs_test_inode
Thread-Topic: KASAN: slab-out-of-bounds Read in ntfs_test_inode
Thread-Index: AQHZMRD+n+nlipTnJkil/gls/hqoiA==
Date:   Wed, 25 Jan 2023 23:59:07 +0000
Message-ID: <IA1PR07MB9830B66A4EA036D79BC66CA5ABCE9@IA1PR07MB9830.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Knights.ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR07MB9830:EE_|MW4PR07MB8713:EE_
x-ms-office365-filtering-correlation-id: 9481de60-6d3d-4511-488a-08daff302599
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jG+iQZvm6xPajj6xWl8CLigLQTYWUKO0gSsngVfpBMxl4vbhNjhJmlfwJVMkAMJcGg3o6tLSZm7yLD5w6V/EHipl16Zv3Wlk44dj7aWE8dmOuDkcTu3YyHCd1CU9jWGfKu553lDQvrA4ZxckMNwQWctc2tMLB9+WMgsiLlMDfK297nCRuRTIc6X8U/qJX/vjKfayQy58UaqIYT48dDvorUh7TdCBZWAzw/UteU3cVhdqv2jCpdo5DvgAK+xTXCVGRV21TYZaOCtwHr/7A+uisfkcvTpTlemO8PU41WF2SZ5G4bcMKqwW/ME3gWxiL+tdY57H7yTfw0prul+gQNJBGppWKbXBvkvl/InRCHLaw3rArRzJvQKrqZh+8350mGxMl2yUXTuxZN3+EfFqOz7Prsky0NV66GKk0fVEcHbo7ceQrchyikosP30lfvuuhoB2FhwztqYH7Rn9QNpaTOHyIrE8vdA/9u6ecwRruAXnEgBQmVwCX00JPOARmCosMW++nPTsnaweopkjON4t3Bs1fE05c8XbE9HXwm3mzrvTxmklmHPiDbKHlFAIsV4sNYzH4UwK9sbIXMGndb3wnBb3m7bMM0jOs2K35InE+MewOQIe+/my4jjDrYVjQeg5YTJ/edGt0qpVQIIiBIFsrNpjgh5eHGexUijqqXLRVn0iYp+ZLDTQz1oAGSxlV5pbw+bqsFF2/Sf/BJwRhCnlTJrXeWidOrhyWJM28612ptBMYGuIEqxn/Efio5Q7eESCQ+16CapLRSxnJ5nOAXDNW8x9lSInxBfHdPkE75WMGc2EY+suK8m/GTE3+GiHC60dX9YAK67th2hbTEbG9mjesQ2VWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR07MB9830.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199018)(5930299012)(76116006)(66556008)(64756008)(86362001)(41320700001)(83380400001)(66446008)(38070700005)(5660300002)(52536014)(122000001)(38100700002)(41300700001)(66476007)(7416002)(66946007)(2906002)(44832011)(8936002)(786003)(9686003)(54906003)(4326008)(33656002)(8676002)(71200400001)(6506007)(7696005)(316002)(186003)(26005)(75432002)(478600001)(55016003)(110136005)(921005)(966005)(505234007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8GMFof676ZU8uq2GGCQhhXoRGSFsguT5jp0nwmsHwVWNlD83p+zGXREaL0?=
 =?iso-8859-1?Q?RPoJCHhx0DFcxE37iWtqkOl0RVYeqb11vqHqtYZFo3MJzv4sLyCJYYJd/p?=
 =?iso-8859-1?Q?nrDn05w40HUvkt1knB5QyAvM0mhTgFZIdyHxs08J8rRW+gsbI4w9i1xXkr?=
 =?iso-8859-1?Q?G6wO5CRrW1c70ksCJGN1lyvi8KbsiK+teFUp8fMpJt0KdKUFr2uZndIZ/g?=
 =?iso-8859-1?Q?+rwbulfvQz++zpjZPMFKR5WsQkIvGyMsu85LdD2Cx8WSIE/S9iXLhLUCTn?=
 =?iso-8859-1?Q?H9rHYCquQhhPQGtxphPE/Jceh/Jk/HjRHMDwzqxhsOQiTcopk4Xj+6fzpw?=
 =?iso-8859-1?Q?6V6rZI769v1YBW3gg17XExIk/p/16YgcKRJgnM0wipv5/kAlipAUTggNMU?=
 =?iso-8859-1?Q?/NWXZN2R3bFjrjk2AZ9pCY/GtJNM1Gt8BLsfXklKhVLDUrstNdrDcj1o3Y?=
 =?iso-8859-1?Q?7SF/linGi3edZ+m3lj8DrpcXB08qtp97s2qesTrEj2Xw+rf1c+7MGIbPWI?=
 =?iso-8859-1?Q?UjA05CuhzAuYPzWSwK7tD99TrVRXphFmo5Wa4Cz7cHvdCMANLhhlqGOz9E?=
 =?iso-8859-1?Q?wtHWYv+s8bk+K0q6+oQ5ymbfmPklbU8bD7DYWz/UkkUNrfr7IUIllq6V0a?=
 =?iso-8859-1?Q?3KM6oAecrFZDutztaXv1SQYW8AZ5n23QCqGoPtaBwgxKim7P7Kaf0qIEeX?=
 =?iso-8859-1?Q?rEFvN2hqAifjgsLYUtwOijUiyHziXHRqz8VCfyDvdzErq5H7Vjb60V4Rj1?=
 =?iso-8859-1?Q?s+WY9bp9ofYL5Jv01PF2eUYm20rFnbn9lQnAIpwucmIiUKt71Y+uBqhfQG?=
 =?iso-8859-1?Q?iUQFKpWL+BmQtxfggvWjuXT8xhxKJ8HQX0scYZF5TtOcWAVlOWjGH6zOrj?=
 =?iso-8859-1?Q?IcO/yAQimoSdel9D6coETtEqMpmSinCXtqQ5UH3fByR6T6pUet4+t99zvw?=
 =?iso-8859-1?Q?oHci+F5IGyn3XrBmDPS2s2aK+els7bDL5WBur/mXuDUDJkLWT5TeAgPe8U?=
 =?iso-8859-1?Q?Ctto/NSGi1xYhDRAHfyLFfAw95uWvDtvFTBTxpEyewMXCz+nNx1aDDffSX?=
 =?iso-8859-1?Q?xOpRNzBh8Gi2FDzwSNbN3jDWcNiWWGNm691FcpKVnV7mNANmLAB5XQRmBh?=
 =?iso-8859-1?Q?V/yFEDfMi9aWTnRsjQWF9Q6Gge9mWTYM/JrZJXVrkyhtaLhfs+UBwXBH2a?=
 =?iso-8859-1?Q?i3VU+zJJlZet8F+NZKkxX6Z5wZefoXMgtqSar3+L4vTanPzg7xdfqqV+zx?=
 =?iso-8859-1?Q?qXypm287D1O/hzOOrUvpbMzSUFSIfzc6qBB6l52pUpBF4/nzbfp4r1YiKf?=
 =?iso-8859-1?Q?aM0RPsGL5LkpNuEn81N+VFHNcfkZTWNDI/HKvZNdjhpYW/B2ZuOcyqNiVQ?=
 =?iso-8859-1?Q?WdZWfn2SHOTJxVdpa0pqV8DOM/Y3gxALuDniqPQKzZQ6qDtZQsMDggkEom?=
 =?iso-8859-1?Q?ZujnqgnYd9XDKyc77dwJq0zFoizE16m0zKJMNUaurtaGLXJtGyJfZyOBH4?=
 =?iso-8859-1?Q?GXq1GLHjEROBmdQQxD//uERkMkWWOuK5tk/6IQi8AWzUDqN59wKjEQ3zq4?=
 =?iso-8859-1?Q?ahIM138eEmLA8YpYUgV15FDp0PvMHMVbEwTzlKISbFBN4C3VAUVO5cr8Mf?=
 =?iso-8859-1?Q?P0yWJSVoLZdBp+xraQmTePtT+hXen73ztfFRGt1KFF2GJTrrtB5XHwwg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR07MB9830.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9481de60-6d3d-4511-488a-08daff302599
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 23:59:08.0037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /xxcPhe/1xIPT1mZexp5xLejbhLvWgmv0XE8v6WtVCpAULkgv/aHCkn9Qd0KxsTwwogYCMuJvTqnZFe3BO2lofDpgACMCAeFUf6PyWvuNgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR07MB8713
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Good day, dear maintainers,=0A=
=0A=
We found a bug using a modified kernel configuration file used by syzbot.=
=0A=
=0A=
We enhanced the coverage of the configuration file using our tool, klocaliz=
er.=0A=
=0A=
Kernel Branch:=A06.2.0-rc5-next-20230124=0A=
Kernel config:=A0https://drive.google.com/file/d/1F-LszDAizEEH0ZX0HcSR06v5q=
8FPl2Uv/view?usp=3Dsharing=0A=
Reproducer:=A0https://drive.google.com/file/d/1gufgF45viKoO91FN6MNaC3yu_ZSC=
7cBS/view?usp=3Dsharing=0A=
=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
ntfs: volume version 3.1.=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
BUG: KASAN: slab-out-of-bounds in instrument_atomic_read include/linux/inst=
rumented.h:72 [inline]=0A=
BUG: KASAN: slab-out-of-bounds in _test_bit include/asm-generic/bitops/inst=
rumented-non-atomic.h:141 [inline]=0A=
BUG: KASAN: slab-out-of-bounds in NInoAttr fs/ntfs/inode.h:200 [inline]=0A=
BUG: KASAN: slab-out-of-bounds in ntfs_test_inode+0x9a/0x2f0 fs/ntfs/inode.=
c:55=0A=
Read of size 8 at addr ffff88804360fec0 by task syz-executor.0/7772=0A=
=0A=
CPU: 0 PID: 7772 Comm: syz-executor.0 Not tainted 6.2.0-rc5-next-20230124 #=
1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
Call Trace:=0A=
 <TASK>=0A=
 __dump_stack lib/dump_stack.c:88 [inline]=0A=
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106=0A=
 print_address_description mm/kasan/report.c:306 [inline]=0A=
 print_report+0x156/0x455 mm/kasan/report.c:417=0A=
 kasan_report+0xc0/0xf0 mm/kasan/report.c:517=0A=
 check_region_inline mm/kasan/generic.c:183 [inline]=0A=
 kasan_check_range+0x144/0x190 mm/kasan/generic.c:189=0A=
 instrument_atomic_read include/linux/instrumented.h:72 [inline]=0A=
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline=
]=0A=
 NInoAttr fs/ntfs/inode.h:200 [inline]=0A=
 ntfs_test_inode+0x9a/0x2f0 fs/ntfs/inode.c:55=0A=
 find_inode+0xe4/0x220 fs/inode.c:916=0A=
 ilookup5_nowait fs/inode.c:1429 [inline]=0A=
 ilookup5 fs/inode.c:1458 [inline]=0A=
 iget5_locked+0xb6/0x270 fs/inode.c:1239=0A=
 ntfs_iget+0xa1/0x180 fs/ntfs/inode.c:168=0A=
 load_and_check_logfile fs/ntfs/super.c:1216 [inline]=0A=
 load_system_files fs/ntfs/super.c:1949 [inline]=0A=
 ntfs_fill_super+0x5988/0x9250 fs/ntfs/super.c:2900=0A=
 mount_bdev+0x351/0x410 fs/super.c:1359=0A=
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610=0A=
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1489=0A=
 do_new_mount fs/namespace.c:3031 [inline]=0A=
 path_mount+0x675/0x1e20 fs/namespace.c:3361=0A=
 do_mount fs/namespace.c:3374 [inline]=0A=
 __do_sys_mount fs/namespace.c:3583 [inline]=0A=
 __se_sys_mount fs/namespace.c:3560 [inline]=0A=
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3560=0A=
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]=0A=
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
RIP: 0033:0x7f815329176e=0A=
Code: 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 =
00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48=0A=
RSP: 002b:00007f8154488a08 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5=0A=
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f815329176e=0A=
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f8154488a60=0A=
RBP: 00007f8154488aa0 R08: 00007f8154488aa0 R09: 0000000020000000=0A=
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000=0A=
R13: 0000000020000100 R14: 00007f8154488a60 R15: 0000000020076700=0A=
 </TASK>=0A=
=0A=
Allocated by task 7394:=0A=
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45=0A=
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52=0A=
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:325=0A=
 kasan_slab_alloc include/linux/kasan.h:186 [inline]=0A=
 slab_post_alloc_hook mm/slab.h:769 [inline]=0A=
 slab_alloc_node mm/slub.c:3452 [inline]=0A=
 slab_alloc mm/slub.c:3460 [inline]=0A=
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]=0A=
 kmem_cache_alloc_lru+0x20e/0x580 mm/slub.c:3483=0A=
 __d_alloc+0x32/0x980 fs/dcache.c:1769=0A=
 d_alloc+0x4e/0x240 fs/dcache.c:1849=0A=
 __lookup_hash+0xc8/0x180 fs/namei.c:1598=0A=
 filename_create+0x1d6/0x4a0 fs/namei.c:3809=0A=
 do_mkdirat+0x9d/0x310 fs/namei.c:4053=0A=
 __do_sys_mkdirat fs/namei.c:4076 [inline]=0A=
 __se_sys_mkdirat fs/namei.c:4074 [inline]=0A=
 __x64_sys_mkdirat+0x119/0x170 fs/namei.c:4074=0A=
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]=0A=
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
=0A=
Last potentially related work creation:=0A=
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45=0A=
 __kasan_record_aux_stack+0xbf/0xd0 mm/kasan/generic.c:488=0A=
 __call_rcu_common.constprop.0+0x99/0x790 kernel/rcu/tree.c:2624=0A=
 dentry_free+0xc3/0x160 fs/dcache.c:377=0A=
 __dentry_kill+0x4c8/0x640 fs/dcache.c:621=0A=
 dentry_kill fs/dcache.c:745 [inline]=0A=
 dput+0x6b5/0xe10 fs/dcache.c:913=0A=
 do_unlinkat+0x3ef/0x670 fs/namei.c:4319=0A=
 __do_sys_unlink fs/namei.c:4364 [inline]=0A=
 __se_sys_unlink fs/namei.c:4362 [inline]=0A=
 __x64_sys_unlink+0xca/0x110 fs/namei.c:4362=0A=
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]=0A=
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
=0A=
Second to last potentially related work creation:=0A=
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45=0A=
 __kasan_record_aux_stack+0xbf/0xd0 mm/kasan/generic.c:488=0A=
 __call_rcu_common.constprop.0+0x99/0x790 kernel/rcu/tree.c:2624=0A=
 dentry_free+0xc3/0x160 fs/dcache.c:377=0A=
 __dentry_kill+0x4c8/0x640 fs/dcache.c:621=0A=
 shrink_dentry_list+0x12c/0x4f0 fs/dcache.c:1201=0A=
 shrink_dcache_parent+0xa7/0x3f0 fs/dcache.c:1652=0A=
 vfs_rmdir fs/namei.c:4125 [inline]=0A=
 vfs_rmdir+0x2fa/0x630 fs/namei.c:4098=0A=
 do_rmdir+0x329/0x390 fs/namei.c:4180=0A=
 __do_sys_unlinkat fs/namei.c:4358 [inline]=0A=
 __se_sys_unlinkat fs/namei.c:4352 [inline]=0A=
 __x64_sys_unlinkat+0xef/0x130 fs/namei.c:4352=0A=
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]=0A=
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
=0A=
The buggy address belongs to the object at ffff88804360fd60=0A=
 which belongs to the cache dentry of size 312=0A=
The buggy address is located 40 bytes to the right of=0A=
 312-byte region [ffff88804360fd60, ffff88804360fe98)=0A=
=0A=
The buggy address belongs to the physical page:=0A=
page:0000000042a7ca23 refcount:1 mapcount:0 mapping:0000000000000000 index:=
0x0 pfn:0x4360e=0A=
head:0000000042a7ca23 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:=
0=0A=
ksm flags: 0xfff00000010200(slab|head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)=
=0A=
raw: 00fff00000010200 ffff88810021b2c0 ffffea00010d3280 dead000000000003=0A=
raw: 0000000000000000 0000000000150015 00000001ffffffff 0000000000000000=0A=
page dumped because: kasan: bad access detected=0A=
=0A=
Memory state around the buggy address:=0A=
 ffff88804360fd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
 ffff88804360fe00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
>ffff88804360fe80: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
                                           ^=0A=
 ffff88804360ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
 ffff88804360ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
