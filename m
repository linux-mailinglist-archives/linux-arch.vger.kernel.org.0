Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6D04A30ED
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jan 2022 18:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352863AbiA2RCs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sat, 29 Jan 2022 12:02:48 -0500
Received: from mail-eopbgr120075.outbound.protection.outlook.com ([40.107.12.75]:14542
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352921AbiA2RCb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Jan 2022 12:02:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzdIMkfYAmkDVNuC5iZTEa+JF/y3u6ACtcnoxro3KRT/FsrF5zKNrnMnkzuOFk89GL+uL29u5dH6qvJEG8+RTEbtlIEORha6L3aK9S4sFXoLc5TL+Eyns70Jnm9AYgEiErXcyTW/LulCOcVmZp9GPMtpgxYJOljvMCkmc7346Z3dHefuK03Cup/TpJkT4u5g1CIhrAS10BLmXo5Wz9cr1zpnMq37PMJMQoBGJlSZX8iMhWVBDS7pc0kczRWHbB7Og05pslfZeeJUHPfopaQV8QhfrFNG6WZhK+DL6HOXDenmqRa+86AYl2JCSPh672Ayw9Zup23FFIgHqO8SOWXsmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDmVjj830CtXExXD123euZ+os2WqKPyfIrNuhETOUf0=;
 b=GmBMH1vQPoffveeJA/PM3mu66uzJI8l3WPBZBVGMB/y/JtmkzqjdbnubmxOcG2djLuuhURUDMFDQoaH7uPCo9Qjh7s2wcxN6QfHc01iJZ9zAvrYYTGe4MonFxfYjP81sqoLM7ZehJ9Go+nXpDgrm+GekIUO/jNJz0c6W8qSnIUcO6EXro+ZduaBzPviQ8QTdDPAwYm50y8Ik7Llht7J6bfQEaMYBPUN43ZbW5pejks9bsG4Iodd4qCX+/N57RJYjszzSNQ4H1tG45nthmh+SbY1c+odwTKyJRGJNrLr4PZiLH+AsFkDQWzAHYh6/LQwboduK4re8mb/D3sG4nMUohw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2584.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Sat, 29 Jan
 2022 17:02:14 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%6]) with mapi id 15.20.4930.020; Sat, 29 Jan 2022
 17:02:14 +0000
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
Subject: [PATCH v3 6/6] powerpc: Select ARCH_WANTS_MODULES_DATA_IN_VMALLOC on
 book3s/32 and 8xx
Thread-Topic: [PATCH v3 6/6] powerpc: Select
 ARCH_WANTS_MODULES_DATA_IN_VMALLOC on book3s/32 and 8xx
Thread-Index: AQHYFTH2Z+9BZHr+mkubHJQ6ewTMHg==
Date:   Sat, 29 Jan 2022 17:02:14 +0000
Message-ID: <04a0d5550f331d68f7eab4b512d50978712f989e.1643475473.git.christophe.leroy@csgroup.eu>
References: <cover.1643475473.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1643475473.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8448cf0-569c-4b8b-c1a8-08d9e3491907
x-ms-traffictypediagnostic: PR0P264MB2584:EE_
x-microsoft-antispam-prvs: <PR0P264MB25847AFC69401D65E4663A16ED239@PR0P264MB2584.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iwv5BXfDzUnohE3Dhxxj3ViUEOzp38nRo/dx/VgebUiBPwRV9YmfDJbKwgK6+r4yiqqWejLAao2JiSi38V40BrAL2jiV36cPOHBxFW7+/lBX5/yriRbsohIMXTfuTN2hzlIqQVKsAHGhp33IioH/W2YkuJtJl9D6ljuhQR7uo7h98qLjk/V/bHiyLyTRuZh4k2ytLgiu90u9DFIe0S3K7ByVv3VFeeSjeV+PNHbdXTJeap3QfOg5bnUXLWfK5kDmcKGz2aduCSu+qHbk+j4GzKfycFqAOVFS+SQ742DNj9NbcI3u5PVW9WMzmn5QUggMgKQnE5w3o1DCE9/+ngAWa2N8cIXonrpvNHytzGUiWcjlPrSjXspJ53xsLAYQEDOmSaaw6Ftq3lJM1s1agvzVINB+I+fENd52KLy0qKVwWbzaoNmEHEIFkf1sajYzqn7GcCF1nbbIWGIHuHsQbkB8UruowWYZuxuu+8iboawcu0AOlIq1hmk/A+PoVUoL0Yg3uzDishAkdhfZi0KrrNtC2VBxHXJ67/pZOgAuQRy6m3tWjLG35cxoMY+2Yy4rYm2/o09kxI7ujAevof/XCR8K9mOAW0glv2leh0Q3tWgZMZH5q1RFwBScWLF5dmhFnu+r0Io4cvHl6GY23JbZudnXxc8V6GFEadJtWkrQNwuyGnm8G+qzV/67a0RCfK1xxsc962Ofb/5VCQzYUCGXolleQwjvXPDS0VwHuLVQcQ9cVOY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(110136005)(6512007)(2906002)(86362001)(6486002)(508600001)(4326008)(122000001)(38100700002)(91956017)(316002)(76116006)(26005)(64756008)(6506007)(8936002)(186003)(5660300002)(44832011)(66476007)(66556008)(71200400001)(66946007)(8676002)(66446008)(83380400001)(2616005)(7416002)(36756003)(38070700005)(32563001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?j73f71ns0JUnRc3p8L3L7g8Z4IvNoRIeizCMijE2bSQI4DpV3pUISSxIMv?=
 =?iso-8859-1?Q?mzb1QiLYfaneeZY6SxfvVc38aUbQJ4IG/vBvgeXZnp77QiDlCsY5Czwyie?=
 =?iso-8859-1?Q?jteFq/OG/nLKmFLKzc0Grz2cQhEbQkiwDhmtCHaRCqiLtfuefpZlGqaOMM?=
 =?iso-8859-1?Q?u/OKkZgwEOcPKatp9+Gf6bENwAUSeYMUFx8MksOVwlqGr76wkLEQ4Q84nA?=
 =?iso-8859-1?Q?IHEBpwM3xF4Cjfnz6z1R9jW96Uwu5WD2PJBpbbx29y2PzR2Wgl5STsbRSj?=
 =?iso-8859-1?Q?AxyfKAq6DsssLpsmtzRmN5L7DWpUAk63GC2+aaocPyJVO7JlXAwQqGS5m2?=
 =?iso-8859-1?Q?Ym5bC0veMAmaRPAZY1wxIh4VDIBqNRHtUSa0BZZsyalFKycBwBAVoZWsAP?=
 =?iso-8859-1?Q?n+0QOcL01AZwkS+mgmiFa7Q9kjdcNYXNDQpajtDYNyzz+tf9JnaqCO4UQU?=
 =?iso-8859-1?Q?B2WZcfc2Eepa/U5vPwhUert/GMlLz3dBMIhr9UqHK0hITi0BTTOEJid/rq?=
 =?iso-8859-1?Q?qXQ56ttalTeyXIp08TpJHYTZ+bE9+vrlrX3SHkmmxjWUnzMDDsCw7BrF91?=
 =?iso-8859-1?Q?l2KFsjE276J4nmv/5QpQPB5kNTfruNrjYhR05FnYh6vJ42QAUCjpsf/eZB?=
 =?iso-8859-1?Q?p0kv4q/ywLniv6gnF9VryRl255wgY71486gVzn1JbtQ0z6be01uot6JB+K?=
 =?iso-8859-1?Q?I02meSVAp37objuh2K4xdlrKcx+TbpX3mkEwwSNdUwEoWfu9mOTp1CHJsc?=
 =?iso-8859-1?Q?2q3/h4expdtXeYqCKoaF54ab/9GCXsrHV7oT2KyTmCJ7fqpEK3w3OHHrD+?=
 =?iso-8859-1?Q?2mkkeFQWpXPUC/aJIFb9FJiZS5QJYhfCpJvC1RsymC+5u2q+dzm6ClQZl0?=
 =?iso-8859-1?Q?4v3Zh0M5fi/UGDUPb5Xk5+hj9bIB5lIq5P8U8Mb1IsxL6p+CNswdYobuY1?=
 =?iso-8859-1?Q?wgovDwcHSMlH8u8O8JF+2NEpN5sjXKi4MO+W4ZSnTEOAHd+CkOw6ET8yMs?=
 =?iso-8859-1?Q?D9eJrYLHf9/ANSycaUa6LOAx621hXxWI6zAZ/ixf3eFCpuBUedX8lPM0wk?=
 =?iso-8859-1?Q?tEK6ZfGDpjABnYSyxaHrvryCfWyyKcnl//DS9dDMmzbGhBnyTASFLOYrpo?=
 =?iso-8859-1?Q?dWLXwo4zdR6aq1f4nJAh9z6dMK7GP+CT+tijozU7Ja3gGXTgH88/2h072t?=
 =?iso-8859-1?Q?8ReoWjkVPyV+ExjEVLLOOtD3QGmByXiwvQFENkjDhOftF8WDu+PS5zQ6vr?=
 =?iso-8859-1?Q?NSs9lprBNj5yIynZTo7kK7JSgV+EjLdYyvIhEEkW3qGxy+Xq3yajeWueYA?=
 =?iso-8859-1?Q?YxXNGl0qZT5knwTc4B/4zrChWa1O9Vwe3ePyCkF2VdLhJfFhwwQCYW0U5O?=
 =?iso-8859-1?Q?OMO9U30s0WUxE4CS/IqDOnXt3C9SEzyFaxMt8nnQJqWXFONh9p8pZjr3Lx?=
 =?iso-8859-1?Q?6EsAzGGs0RR8RsfqNegeiPu/+W8HNp3ITtYHNaNX/Ln1ARvEX8F7Ep8q2P?=
 =?iso-8859-1?Q?OGPY2hYc8epSLdNhT1jrJHFuSu76l93K0BSXx85uHjY9jpvAtqqeXZRCSt?=
 =?iso-8859-1?Q?lQ7FVMcbxQU3AqW4S27niYuqsS/xr+m3NbFAQJQ+voFMma7kfxx+NXPxlC?=
 =?iso-8859-1?Q?O2tDfDjVzVpQR7L4KRMS3qf9T9gj+ManbYnQKsqiZ3covKFzpsHiu5YPhE?=
 =?iso-8859-1?Q?++E7N8ShMfxyynz+40QXXjDXHsSIACrTukK0iZ/E408g9otiAm/yQL8fQ7?=
 =?iso-8859-1?Q?x1qHxTsBWsQmrHAFX7SizpTbY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c8448cf0-569c-4b8b-c1a8-08d9e3491907
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2022 17:02:14.0755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6djKFQr0cHMhrf6Tp+sNdDrT700aVyYKZ+t5IOoSqzEcz7ADs6/oGc5Y6d9B96S1UVn3cQi5o4s5j6QmgEjsM9VVhqWgKvn1wakt6iQfqC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2584
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
