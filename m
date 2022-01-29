Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7D04A30DA
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jan 2022 18:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243882AbiA2RCH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sat, 29 Jan 2022 12:02:07 -0500
Received: from mail-eopbgr120075.outbound.protection.outlook.com ([40.107.12.75]:14542
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235519AbiA2RCF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Jan 2022 12:02:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkmIiCXT4ziPRqsLlezbz2h5AhfE8z9FKOljrTvAaJqSV7C+O/jNh8mqFHOg2MV3O6GzIdOg0kSvG/NxA4mC9l9Gr0qA9+V5F6fkmgQRXN9aHH4Ec6krYi6uPwfEwaHoXVEuEaxCGudkNaK0zCryNxyVlRLfmVERTsKFOaKpbg3fVGooQPMVVDL7F5W4QZ7lO04yYXIvJKuG3udVG3+QtXWfQVINiS7/XfhVHZRf2hqhNcICr3iFy/ZqmpeWggvT1YP+YnU4A55pjh5Y+lS2IRRTZTHIabVxlj5kezCLfqYGWJu1hesIkRAyBAPbB56ZT3BetRZx3Hs1sPEZvzRfrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFe2jru4e765k+AtEaywltcFddJL0rBEMrtvg51fbp8=;
 b=nwBiU1qFnoXLEw+8x7ZxGxgk62DZauDrHVgA2U8tOyZsU+mGEyX71bWPV1S1uEiqgGzIukk5oq5TnztBHU2MMGtdQWeBemdtqsZDRd2yk9MtSrb0o0qfF0+NKSP4+lpjfmZRNMwAkKQN8F88LiJZUWmprqDSSIefbSenNvK1sgaJzHx/y8rp9wGqFGFOFTiHD81wVfPoyPmkn6D+4cTGIVQVDwbZ9dPmLbDxkkpFsTDIn5czzhaPOSY2Z2+lhmbi65Qbnsn51dQmPKjvQFMTvaRLcmNmXi2OP2Qee1RfEtRSr3Edg4DdAQHvaEGDRkf2NNSuBiBxonI7+ovv5cg0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2584.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Sat, 29 Jan
 2022 17:02:03 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%6]) with mapi id 15.20.4930.020; Sat, 29 Jan 2022
 17:02:03 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: [PATCH v3 0/6] Allocate module text and data separately
Thread-Topic: [PATCH v3 0/6] Allocate module text and data separately
Thread-Index: AQHYFTHvUwh0xR1dj0+CyueZIq28OA==
Date:   Sat, 29 Jan 2022 17:02:03 +0000
Message-ID: <cover.1643475473.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 892d4223-8cff-472b-6752-08d9e3491279
x-ms-traffictypediagnostic: PR0P264MB2584:EE_
x-microsoft-antispam-prvs: <PR0P264MB2584A5D015F68D597D1E572EED239@PR0P264MB2584.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RKfoTkUtOawyjK5uczxHEECkyxYbemWn3txATQY9icTrbqBP8t8MGPN/9mIi/qPMlalfA3NzT5o7aSK6+bqO0Fd+phGV5a2+egkbzNq8eNQ6q+2Tuw5s5uHq0nFoRzj8tWZD+R5JdD+LwKjXh023r1ZnU6ZwvSG0x9x2OHb9qEfFyhPsEVGF0291F75yJ2iyx4Je5bigwgNf13gwIWM8d0yLQZXJT2oTzcDZSDLB3P7wyY7cWr+N2EtCiqXRn3imWUpzzTZniItsD0so2BDeXBTQbJJLY6fJ3Mcd4/oQz7wQ+1QMI1j04PF8vMrIDWVxQIrSqKf4iK7onxgoDrSPZp8bWgCPpzorFDWNmh/092DBOdEd2vCesyMhKubrLwxSma44E5WX9qho2XBtWornC3hMHZdkuqT2V5tQiazcXi8a/HEbxClufevt8hOVHEi8hr185WFyD2qZmvSfwUUy+vb4haPbEn19SQn9AcG5ktLCneNH1Vo6Nqx4yzIScIGIFta3QMCwlxxXG3Cugg6nQIMUpqpiKUu3ccTijdaPVNoVhJyXhicB8FS1IYEg1+Pdkb2Ce6MivnNqGXNLmI3g13xfRUsGZ7Lc62/cd+caobzqDIvzQEiGZMedm7dfwepkUTWvs053hrXPpyR6H1v0VY8W3U/f/NmveGclr0D/tw4fVsWYAF32ZG4vf2KCCe2fZls76ynsBX8oPwhLWs2A6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(110136005)(6512007)(2906002)(86362001)(6486002)(508600001)(4326008)(122000001)(38100700002)(91956017)(316002)(76116006)(26005)(64756008)(6506007)(8936002)(186003)(5660300002)(44832011)(66476007)(66556008)(71200400001)(66946007)(8676002)(66446008)(83380400001)(2616005)(36756003)(38070700005)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?20FFZVBRKvjedqRUl/SSTnbdtLAYkCaoCuzqhwUGtys4VKy4HrtuzssWDR?=
 =?iso-8859-1?Q?7X9M/JRHJh3FP+np6aBauLAPIRY7LlF2pP5GyqcdWJNXMy2orfkG6sxmZC?=
 =?iso-8859-1?Q?VBZug+EAig9nedRdjzMj9SGTxBVkUDHPvAVRBSU09DJO+IIKyrVSX7BX7O?=
 =?iso-8859-1?Q?bAKMEb3enosmeIelB297yzVU2YerWMJxa2EIsbRDnI9UgCGwkPrzWdOuX7?=
 =?iso-8859-1?Q?SmJfX6vuucCOiuJDyG5AQtTAFXGW28TreBgqwncUK2TCil+2bRq23sY7LP?=
 =?iso-8859-1?Q?9v9Ara+u9Nwd3RuI1utiR4XBxW4Gh3pVcUccyF3CWnXBWStJDtPefMI0Qj?=
 =?iso-8859-1?Q?2NPWa2ZRdRGcwJLTuEYfeNAoJYoARJmVgQjc4C9rsUrBWidTZh2Ugy2m5k?=
 =?iso-8859-1?Q?jVrSPTqmZSI4zvR/oJ4zFpLxAQqa+zcPWL+xVSyYVjqLXf+0mQbLODW964?=
 =?iso-8859-1?Q?xHGqqfyFQ9mD5tsOxZRvtg0SbLQ8FGVPZg4oBrvtyI4m0kSuhqA/ic8AmR?=
 =?iso-8859-1?Q?LiMA16eHozarleSUZAPD5zp7ycB2PTNTUq7zoLW8pva1l6m73ecG9ui0oy?=
 =?iso-8859-1?Q?7PE6BZExxhsI+mqyyx3aezQS+iBcGueLe640LcwFwl/oKdnCJtkfKSrBCF?=
 =?iso-8859-1?Q?cUPHDaD4Demp+zhbPdSovxaXGTE6oF6HMeE7vcjtjWYAw+6Vox//mnbUDu?=
 =?iso-8859-1?Q?vUZfBQx6OdutWF8WFfj6vS9qh7UlTT/n5SZEASi1nMN+soXj6W4M1RGVYc?=
 =?iso-8859-1?Q?IAevN8l5xTy9EY+hmmo4FqsCSmHu2Ha+MSi00eXoPZCChcNs772TimSqft?=
 =?iso-8859-1?Q?mvDbMzb2I8itaODDqbohNpzp7Nzd86/Oy6MKKfg4Cd2qRs3DYr7ZHCPOcI?=
 =?iso-8859-1?Q?b63lA6+tncllH0F586rSwhK+mfo0lwnD/m8W1G12OAfzpIXxkezdwj65ZB?=
 =?iso-8859-1?Q?o4TVj2QJcg78UkAMC2e4b00cC+koXfQqcU2IwbYhD536FkWw4HdcFCzorQ?=
 =?iso-8859-1?Q?NpwKXazzRfnIT1sxeKyLPk9KLgVF2VX4BNcO6HnmS314FECqmVSVZ7jMvd?=
 =?iso-8859-1?Q?x8jgiKEhDtTZCGVKP/95mMz4OMsOkaaybj9Och8XvS4833OiPXsMLJ9b5v?=
 =?iso-8859-1?Q?BHqpowX1FTnkG7yN12oseJlw2olcTsjUVd3bNs+UktcaNmKaGtK2q4bHqU?=
 =?iso-8859-1?Q?Jc2+9UXdOPqEP9hHJMzfZomBiXbiBo+ajMFg/pdkDi+UgfMYao1eg/mc23?=
 =?iso-8859-1?Q?4lBCFQR3EjOVU4sgFlC0b8JH7tG3o7euD4+TRvhunWkqosL8q7g6JIv5iC?=
 =?iso-8859-1?Q?0ot2xzJB9hfL2uQjBadlMCH0CklzQbR5uJqFoeRzDOYQgOw1QMAVjjGwu4?=
 =?iso-8859-1?Q?BbUZ0twOPEb12z6ri3xiweVKSHxW1qLjK7RfxwlrnTUvsC2n6dr3sCbZCn?=
 =?iso-8859-1?Q?ZkzhmpFS8ohXLZjKpRiwAq12xEjIjExC6Yy4N5PzbL67jRenZ1C1AKoMUV?=
 =?iso-8859-1?Q?boVshmuJxoUYUvTWi017IuXxLUCc2Hnsh9htcvyiM2aj7nbF8cDIZRYA2D?=
 =?iso-8859-1?Q?/KTDBC8z0C12VLKQmzKuSoJid97Akj3TxhQPWunLOQrJPzWppcTIjMJRXj?=
 =?iso-8859-1?Q?NNsdlCrF/BSNw9okwpAlpdAj56Icd66xahMBpkO5BGFxrQdZ4sHUHxztaq?=
 =?iso-8859-1?Q?yoOs3qKmII1uZmXCCToJMqxEXftJeKPs3OdZNvzh6sV/ECcYuHui7X98Rk?=
 =?iso-8859-1?Q?YObev7s6DDDu+oaqkJuZkNUmA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 892d4223-8cff-472b-6752-08d9e3491279
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2022 17:02:03.0606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yMU6eVPzk9t5QNlyd7FgGd6fDDBSBK6/4w4wjs9bqsy31YHUXQoC5yuSbSyKke1IPtSEMfUydPDLLs4it14pucPnlsIoiXXzcTS8y6VPzh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2584
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series allow architectures to request having modules data in
vmalloc area instead of module area.

This is required on powerpc book3s/32 in order to set data non
executable, because it is not possible to set executability on page
basis, this is done per 256 Mbytes segments. The module area has exec
right, vmalloc area has noexec. Without this change module data
remains executable regardless of CONFIG_STRICT_MODULES_RWX.

This can also be useful on other powerpc/32 in order to maximize the
chance of code being close enough to kernel core to avoid branch
trampolines.

Changes in v3:
- Fixed the tree for data_layout at one place (Thanks Miroslav)
- Moved removal of module_addr_min/module_addr_max macro out of patch 1 in a new patch at the end of the series to reduce churn.

Changes in v2:
- Dropped first two patches which are not necessary. They may be added back later as a follow-up series.
- Fixed the printks in GDB

Christophe Leroy (6):
  modules: Always have struct mod_tree_root
  modules: Prepare for handling several RB trees
  modules: Introduce data_layout
  modules: Add CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
  modules: Remove module_addr_min and module_addr_max
  powerpc: Select ARCH_WANTS_MODULES_DATA_IN_VMALLOC on book3s/32 and
    8xx

 arch/Kconfig                |   6 ++
 arch/powerpc/Kconfig        |   1 +
 include/linux/module.h      |   8 ++
 kernel/debug/kdb/kdb_main.c |  10 +-
 kernel/module.c             | 193 +++++++++++++++++++++++++-----------
 5 files changed, 156 insertions(+), 62 deletions(-)

-- 
2.33.1
