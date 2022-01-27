Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B8149E0DA
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jan 2022 12:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbiA0L2S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 27 Jan 2022 06:28:18 -0500
Received: from mail-eopbgr90088.outbound.protection.outlook.com ([40.107.9.88]:21829
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240334AbiA0L2N (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Jan 2022 06:28:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HONsLZcHH0WoHGXT0+zCH1t2xJvj//2SpjrRmBzgbXv0j5g+IlaHoLHK65TMa7UCYmQsvdbZlc/N0k6akNXmRtC9+qgeafT5NAnpJIvdauJT8ahqxOQn+YLkKrV95qpyMNZ5lhCkqLbDjy5RyEs49C3VCWEAea1W4QxiszVRPB+vqPrlnJjMt1+kKXE9Pfku8H3AyEZSlkF5kzBwK1lyt3ORlPmuKIdNu7jjJE4nzBnQXkaU2zjbBQc8BNxuRBXt///i3HEyFm9g54YYdWhU4oVdTsKjDkY+vxS8aAc/JJoHzJvGphtUaOKNQeS48B7QrcmVuIBPVe5jCtI14dhM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDmVjj830CtXExXD123euZ+os2WqKPyfIrNuhETOUf0=;
 b=PhDFfC15sYA5sS1yfPxZ/4tBEafzLuMimPYpmp9mZF1X6jfbYczFnF312UTOUVA96JFQ9f3sVmKsk2K10v5zIws/kpYuE6oHLpkW9IY15d70WdAgp0wle/AQMGQXZQ9/twx8ZboS7aOenkjsfxCtl/G6Krycio1qI/bOEBJNw3nKgdxC9zum3F1PNQ8fKVHuOLgyYW2aRPGt6OSR1lSvLUddGmAnk9QJNnnw3KzkVuqT2mmwmG8YcR8PmA9JFZ61ejad/BnelRX9PQrsA1CK0G6tHV4OYMkWR3+ABZxDxvOJ+JnLBvtkqt6dCIXH5lQeD/gfjtKabAsQ2twUNt8GDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB3227.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:30::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 11:28:12 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%6]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 11:28:12 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH v2 5/5] powerpc: Select ARCH_WANTS_MODULES_DATA_IN_VMALLOC on
 book3s/32 and 8xx
Thread-Topic: [PATCH v2 5/5] powerpc: Select
 ARCH_WANTS_MODULES_DATA_IN_VMALLOC on book3s/32 and 8xx
Thread-Index: AQHYE3D37kysOO3Vq0mRXtsXlcd4bQ==
Date:   Thu, 27 Jan 2022 11:28:12 +0000
Message-ID: <a20285472ad0a0a13a1d93c4707180be5b4fa092.1643282353.git.christophe.leroy@csgroup.eu>
References: <cover.1643282353.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1643282353.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4585b1ea-b2ce-4c99-123b-08d9e1881a38
x-ms-traffictypediagnostic: MRZP264MB3227:EE_
x-microsoft-antispam-prvs: <MRZP264MB3227CDF1A6B3F028198C27DDED219@MRZP264MB3227.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 35pcxN+/jFlfzwNgWNHWKW/Q2UU2LHTZ4TO0dk9fUscOlugP7i/hLWo1VXGJU305Qub4W3b2+u8Lv5V4lPxJXV+GwCc9Vw88jgvye4V3QHZm88itjM1w39VAtWXgQQxWTdvBqGog4QTzAyow9REztVaIHcG9OjzqqM7J6u4FwpBkvwbX7oNQOUPgw50c5YA8qsBZxNVojE8yzBGbbBjJRCI69X/idFqnUTJbpK0x9oNIokKhHcLwzceZ9sc1zN1VfTkN3GIbMNBzK4z0MbJeMIopCva7cMqqhnnsJ7QtdJ3LULxZ65qrwEyUoobpZaSf9mBxKtjl4KPKxbIGphx42kUhUk1M29r3b3Sj+4XgxuOQd4O6M9FhPEw1AtUeY4EIZAyMomBB6yr73QpHXhgsYOuYIFhbLad/DLKPleizlAtnIRPAU6RS37qXBg8cndrJ2gu7kbFtpguZRaRgh5Bnw0ghe1yoWnach3bZNLum5YBW4iwBmholLoh+VRnUoFnCOBs7GAGy3nc+fDMUxjiCuKJ535lC8GEDRKTu18FYZ81vjYY/iGBUBZXK5QlQkjxQH9HxDnHUU7OEbKlERnA88hSY7ElBCcgsfwThgrziC9PXHB4SVvaBAPX4dEzoBnW1ZGSyGHYJ1UIVtJb1I9evumbOIfFrgWpfZjCVPbtud+eg3wGiCNFtnuFKfFjFWXvV3TuChWsdiaUCwSxggs5znmfMIDlUTyJ1+0sTjS6AhZk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(316002)(66946007)(6506007)(6512007)(76116006)(508600001)(66476007)(5660300002)(66446008)(66556008)(91956017)(44832011)(4326008)(64756008)(7416002)(8936002)(8676002)(2616005)(36756003)(6486002)(71200400001)(38070700005)(2906002)(83380400001)(122000001)(26005)(186003)(38100700002)(110136005)(54906003)(32563001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?r4ylYb/DVh5IEiPzk8bl+g2hJaYN2XN0pZJ6EcqpJnU3Q8sfiMUqHfMBjn?=
 =?iso-8859-1?Q?A+diI2mQnZyydLqHXz7xCK+Esp3niwmZ32CPE60GpuV8fy1UXEWNTJFqZx?=
 =?iso-8859-1?Q?P+CcvyUQpVSvDLJ45r+q7rQSq5kb+eRwX38jNkSsuAzeBJmtKUcmvcvJc9?=
 =?iso-8859-1?Q?xfUv4vohmmUl6dQi95Zev4B3QDWXClraT94pAZn3eQudBRxp0hdNML+vCc?=
 =?iso-8859-1?Q?bS0v9oOvKrrcyLmr7wszwHi8QJAMql7XznR+1tBr7H2e4iyRfBxflFNykD?=
 =?iso-8859-1?Q?xmcy4GUZPelqfWeQ2UOSLXtPzmxXnMRl1FrJa0i+t4AZs/X63LDIhCQabk?=
 =?iso-8859-1?Q?8NLN0ZP7tUuDfmCvVWkgHbn5+A6JU8qB1DWw894aoRYLfvQfJ6gnNC47cH?=
 =?iso-8859-1?Q?05d6RHYHdT4jO+L/DrHxO6hFHC8CoHGEuTrnruHPFArKtP6VecwUMIuh+y?=
 =?iso-8859-1?Q?bhNoz+1EVLF9dLev8pzIU10OVfWjPSzU11mexKSCPfb0h/V+h62pE7vWUk?=
 =?iso-8859-1?Q?9Shao1uvUrg5tiRRRyMuO/b10oAJPOlWylCK9OoTfqPRw/SKxe6YhUqcrR?=
 =?iso-8859-1?Q?3ZhiLl2B9QKss6bzO8z1cHzD/PKaDfP/vHfEYjLUN0ha+NlAuGv+auW63B?=
 =?iso-8859-1?Q?JUz5Vj03hdmHBz3tM2WZ9yshI4o/yHSZs38DeQzRgKIaC2LsuSpqBD84pq?=
 =?iso-8859-1?Q?cITvB0ZuLXNUe3SSBLj9Vkb36U2SqB0V8NG+zRO2pxKPMme4OebUtTJBJA?=
 =?iso-8859-1?Q?+uxQTdZLDL6hnItTypQvaSgXXD6hXIZdaLCxGclS1CXKNsG2KvOUIBJ7FZ?=
 =?iso-8859-1?Q?+g8UqckqNKNJty1qlVsgN5i16TGU6ThwjxKBJB9V+Dq0iQapvwqCiYJDGF?=
 =?iso-8859-1?Q?l4X7O4I3XPUWSvii/CYH02HAMkBHzx89BKeuVM/TreUMytuRd4LswReMzO?=
 =?iso-8859-1?Q?Yj7ivY3UhebrSgsSOzTgdV8hOLuh0sGn6klu2ZlaAH52hAcOMlWQZK5vSW?=
 =?iso-8859-1?Q?bv31xPsS3WpS8aJvNPtjcvj7byiAaMM8NovvsNwn91KbAmyLB0HjGl+w4S?=
 =?iso-8859-1?Q?WwCJHQvOu7hrtAqKKODRBVnqUr+X6R2RliKU+6Bd3U71OX2JAeDRvKSniY?=
 =?iso-8859-1?Q?qkLOqVc8DbVBa5ryEW4kiprrbAE9uKAQRxN+gYIqdWYHovCvL3O/1pTd11?=
 =?iso-8859-1?Q?s/uilaDBcS9mmHAPO5ro2fiCzvO7YJyQwuNQvsopIvtD8Wnvp0v+Rk0bCk?=
 =?iso-8859-1?Q?WCImRrDw3cFZNCAVjGxv1cWORov4jkFRfNkp4niBN2kT8Vc/qVm+pgNZwh?=
 =?iso-8859-1?Q?5ucSV8WNqNCmt0e3mIwi6EdzifTqn/8jx5J85frAsw/9AQNgv28+4dwuWg?=
 =?iso-8859-1?Q?iaD3KhrISo1i/e7iBxQGPJtYlz2p7XNMWzlPbK/jh/PapiQQBgLkJsJ3bp?=
 =?iso-8859-1?Q?gMxTJGiF/o9h54ytrQ1s8XotPGpL1MKmkqtBub9ihD+Jlx2OEC315XN24/?=
 =?iso-8859-1?Q?pL6mu8boDlQ4NMXu50sbYxPkIgGtgI2yK3gfYYfGRt1HI5t91HibudK1TC?=
 =?iso-8859-1?Q?YO74g+UFvY5vQFroMRHjf9s4i5C6deVqtQ0sLK1ihj9oM1J87wYUMoq7AB?=
 =?iso-8859-1?Q?u8gl9fZDFjbl5XpZoa1TduM8YbiDY0W4LDFr/P+AD9PYibqzd1oiRGxjoT?=
 =?iso-8859-1?Q?FEtvW8JVRLOjBjkGAVtdDKfz8DVyfjREas8Nsh/S5ENUa9pQDc1Y3qvc5j?=
 =?iso-8859-1?Q?W6v6DbrFQvRMyeRhCLrN3mVOk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4585b1ea-b2ce-4c99-123b-08d9e1881a38
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 11:28:12.0695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QE2iG1lyjB9puRxP2Hd1tDfbjnaBnOmweFdBgashU8HvUP92dDUohHGQ3rGumku00QDcnqdar4JxoeOtPudlJ76L4s2y5bSEfUoD+mNBhhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3227
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

book3s/32 and 8xx have a separate area for allocating modules,
defined by MODULES_VADDR / MODULES_END.

On book3s/32, it is not possible to protect against execution
on a page basis. A full 256M segment is either Exec or NoExec.
The module area is in an Exec segment while vmalloc area is
in a NoExec segment.

In order to protect module data against execution, select
ARCH_WANTS_MODULES_DATA_IN_VMALLOC.

For the 8xx (and possibly other 32 bits platform in the future),
there is no such constraint on Exec/NoExec protection, however
there is a critical distance between kernel functions and callers
that needs to remain below 32Mbytes in order to avoid costly
trampolines. By allocating data outside of module area, we
increase the chance for module text to remain within acceptable
distance from kernel core text.

So select ARCH_WANTS_MODULES_DATA_IN_VMALLOC for 8xx as well.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b779603978e1..242eed8cedf8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -152,6 +152,7 @@ config PPC
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	select ARCH_WANT_LD_ORPHAN_WARN
+	select ARCH_WANTS_MODULES_DATA_IN_VMALLOC	if PPC_BOOK3S_32 || PPC_8xx
 	select ARCH_WEAK_RELEASE_ACQUIRE
 	select BINFMT_ELF
 	select BUILDTIME_TABLE_SORT
-- 
2.33.1
