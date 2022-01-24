Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD79497BDB
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jan 2022 10:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbiAXJX0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 24 Jan 2022 04:23:26 -0500
Received: from mail-eopbgr120058.outbound.protection.outlook.com ([40.107.12.58]:40064
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233202AbiAXJXS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Jan 2022 04:23:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZvPCiowM6RklnpLKurfUmRyj/3v/oVq7u15JqkzyNQAYBJvc/ujagae9SmNnHVx18ZsEtu62yztIb/CcreuX+i5a0drjGHtPVsvmAEjPdi8ooT53oVnWuffhu8bH99Wxu/p5+Klu+7SLIUK6yH+eDA6Rgm5eHMlCfv5YNBjbomEa9TlcyecTPiXhe9+u/IgQqtq+55NvsqirWjmtm2+2mCGN2p06cX9M/Nsgvo6GTW2iYZ/6RsqbHzrxv6LN46qAaL6zJs6WgzN/TVWclURYUq45Sv20NjDQ4XT4mZwoEobogJEubxMD1hDTIoqaL+As6aF1oQirSt0XFuQur1Yjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8ARt3PLVJ2vGaO0xkEt2cByxv0ww6gnOJLBp5FiZNw=;
 b=B8rxeU2rxmlmqIQBePLr0nE+VqG0OG3YDUqAXY8ACehY06w/s+KHokMPmwehucKKLAgPXcjifrZihtU7pfMSKWOj6hN2FGASA5Uxn7WBrb2VZxRZAopwFEX85dZnECK8q+aXe+uNBnktcxy95t+CJZddmWYHWUvJYjntnVzH515rw6Eut8+7PUxxWzA/hl5Y8jJajiF7AA4x4EbZRJL1jUBI93hMt9YPxkZ1caUTPhBZ5mjHe6b+9acwJut7ThkME17V9RPOPft/IICzIeNVLJrVRrOfVR3maWEMGcCB7JKdBeREdoy02Hh7G5m1qrBDhnhwQcuir9hFbJn+rcSa0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB1742.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 09:22:38 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d4f:1090:9b36:3fc5]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d4f:1090:9b36:3fc5%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 09:22:38 +0000
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
Subject: [PATCH 7/7] powerpc: Select ARCH_WANTS_MODULES_DATA_IN_VMALLOC on
 book3s/32 and 8xx
Thread-Topic: [PATCH 7/7] powerpc: Select ARCH_WANTS_MODULES_DATA_IN_VMALLOC
 on book3s/32 and 8xx
Thread-Index: AQHYEQPtzPfcZbAkPk+3M/R7ScopBg==
Date:   Mon, 24 Jan 2022 09:22:38 +0000
Message-ID: <ff7a8bdc9a90a77de2ebc059beb4f644b34186c1.1643015752.git.christophe.leroy@csgroup.eu>
References: <cover.1643015752.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1643015752.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 951a93e4-71c8-410a-c590-08d9df1b1071
x-ms-traffictypediagnostic: PR1P264MB1742:EE_
x-microsoft-antispam-prvs: <PR1P264MB1742FD81EA5575BFFA7101B4ED5E9@PR1P264MB1742.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1XG+OFX+DNek76q0RmoVN2k5+bFN69HGG8d8edjH52fr+z18S5PgYrUM9aM60HXLYEmmOfopPWqQ672nTKyAI/nDnm1UZt50vPrObfCgOpU7aMI5M11CHsucnBSrqFnhIKMS00oB8dirag129/ij+tyhQ5OU6KS7mSzuCuaqG6rIzxPCPe6H/xmN9q6C24HyOwohzh3qmqw9yIEhuR2e1hNDgSa0jK+1LFvriFofOOuaCkimFCsEfz21FyG3vNEvn3mkJZ5PPxE1HGokSC8dwYN0Q7pty60/zB+S4fXokWap1XCSN2rtU+gvc2kgRy+MkKOIrIRDFtV9GD7nbMlUE/dFx75PLCgV7spaijGkAALTAKdSm1hRBsVckHl4QtUCM+wCHqHR9uJNb+rQ8a4XLxvJsUtRtf6wQ6AvK0zsiK0wx5OuZVqTDW7BAWswJe+UgZokGePImHfvHwdpcs0PRRoVvHANwLKx1jtTk8oh1In3ovZ25EnMkvGhSf4lS7fZF+5uCA3pTFRv7mvZkp6y3Olf6gY4nZm0afEk2prw9BdekiJ2b52P8zBkYC7INeqny+9f8xLGD9pA+iiZfMOscpq/MMj1J6zgWqk8P7/xxVtzbej1o1BpZ7KdO9TxvJ1i4/+b1udq0qSCFNZ7Cg5jd2d83t+CJVryZ/mz6e8Bo8/lxC7lBWSPbqk6P695f1QmtAQZqKvfEHSsWzHQJDmj6GU+vag5uuRyH5rrbkW6sGM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(7416002)(66476007)(91956017)(316002)(6486002)(54906003)(110136005)(6512007)(508600001)(64756008)(2616005)(86362001)(8676002)(186003)(26005)(5660300002)(66446008)(83380400001)(2906002)(76116006)(38100700002)(122000001)(44832011)(71200400001)(38070700005)(6506007)(66946007)(4326008)(36756003)(8936002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?szicDs3f8vXOo1JDPRq5MSHuh2A2foLMymUFO25+7PHtEc+tp1QpzMgtAe?=
 =?iso-8859-1?Q?lUCuVslqItxXN0v6DwxZeMzVTVJ1FLOvf4tqD3k6FX1/+TH3g8QrgbPPxe?=
 =?iso-8859-1?Q?ECRG0+9v/gWmSTwa+jPhaBGAI6l96UsDOOaXrFN6NHl6amRC4qPKy7lrPV?=
 =?iso-8859-1?Q?i9H9gVHjN5bDSzM4xr62fTMC4dMSOVvUObKrlpz1DN7rC02SpOz7Mwgwf0?=
 =?iso-8859-1?Q?+C43xOY63hWRQmuX4ZvLm0vAhwBoIF+NYsvVJ4cO7s62Egiky0Xxr+Ts8o?=
 =?iso-8859-1?Q?kgklFTAb4L7uCobXdo0nTLPWtWokY9/ez/KDvx71GrCHyCBWeRFozik1tE?=
 =?iso-8859-1?Q?VrGJc4YV2dQC0+Hx6JpEiljgt3WNG07GuaPyF6E2SlRRxwa5t8fvhTeCDc?=
 =?iso-8859-1?Q?zyTEl0zojVhe5WqwoxgZiIDQ63o6T/maMBjxLIJrxTbR9PkgwF/XWQ7YMP?=
 =?iso-8859-1?Q?PExqZ3szxmX7XzJeIsu45V4TjsihJ4DDTfOX4fJPtmZGOkL/MLtf/mZUpo?=
 =?iso-8859-1?Q?L8p1h0CLyveerVX9gY+ob/a2MKBB3FZD93NNxZa2DM4m8KVPpAxbsJ7ud5?=
 =?iso-8859-1?Q?+8CM8GPWkFPnoN4uutg9f2vSLzc8CdfdRmG3X9k318XJENGe/+0IFHoh0t?=
 =?iso-8859-1?Q?fFi5xVDIgV6LULSySTeoajYpEaldEjPuSpAeKuhM2+fep+u+UzwJ4IbtMn?=
 =?iso-8859-1?Q?UzFidIcdp8D7JpY7OQAM6Eq0Dljcyafjfz4DhLRxdsJ+/Ig1Je4W+o66V4?=
 =?iso-8859-1?Q?JR058H/VJ0zG8H6Iwh5ZESuYKIOcQQ2dVqDs3p3HYJhtpgcpVPBM9c4yhA?=
 =?iso-8859-1?Q?q6NUmFpKEcU3I+tJY+GjgwydmUuhY0djKsUY6s4mguCuwr4b3Q7XlsL1zt?=
 =?iso-8859-1?Q?qQq+2q/v0SlLapsqQ921H13O+buWlW+E/NNFr1znRVlrfZXHe1NapsiLh5?=
 =?iso-8859-1?Q?UTP6DL3NJRbfN8sU8FEiZcoawN8kmTdlIkEDzjEH0uPVRaFrvCSubUjQcx?=
 =?iso-8859-1?Q?aeQjBMpAnBRnUFH8VEUeH5nYttIas2B4v/XOY20YQwLeC1lLiev6E9hI9V?=
 =?iso-8859-1?Q?kJ5kBpyaMHKaYJ2WtT6A/9Nq02Jrjn/leixdz28gA2gl4z5pbvhFXm/ZAe?=
 =?iso-8859-1?Q?So8XFmRcLILrhActohC8uAr1SW9QYzReX9lvlSpgYBMo2E9OADkz5oy9DD?=
 =?iso-8859-1?Q?koUGmXM0VqQou+KDtEU6iV9hYGX1+dOKOTi1QZq6BIYsXZFFJo4DI6/L62?=
 =?iso-8859-1?Q?IBV5AdjWRmgNcNZSwYWS+b6Zutyk51z5h2zNuUd+uCS2xJyKBlpM+CDd4T?=
 =?iso-8859-1?Q?HCZLorHCz+/q+lyO21PBCxnFkQLXkYjpa8STBd37PssBS2dfyvrSx/pqgi?=
 =?iso-8859-1?Q?wV106zITu92LsCv7TDCA3MUHorMkGwKLhbWVRGO8ISRzL/CEF/l8j3SyTQ?=
 =?iso-8859-1?Q?UU6rlSy4JYOEZmV/Q6E16m81ZVK5KxPCljuvJi1FHBxc8dF8QcAvln/p0C?=
 =?iso-8859-1?Q?1WgcNHBghMoHn3JyOaSY/f1XylQBYKwThFDizSNgFvNaFm/NyVE5lVKqu1?=
 =?iso-8859-1?Q?VJVq64QG/52qLz+vUjPKzfsGQSU/AH0/JnYEfCXwNJsYPLRsxxy8RBL/yw?=
 =?iso-8859-1?Q?B921QdRsYxbbe3DFWC0/4dbfTBzfTe3WuSixxhysW/kpYLBqMS10dj+H1t?=
 =?iso-8859-1?Q?MPV9OFdcKS8d/Hpg+RtZrsGmIKrxTtSte4yxCDNzCMcAKKMqJWnO9BIIeb?=
 =?iso-8859-1?Q?Zyxd00m0V7qYVI1hl7E/1Uo6o=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 951a93e4-71c8-410a-c590-08d9df1b1071
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 09:22:38.2013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BC6hWK1UsZeHvMIgQaAMnlrQ9NxGrCRqxd7qYldE3euGCt9xO2uBtTJEjm+ikdtXblt6yFmMVoHGpKB+JEVRjcrKnlU1+dj9W6gD1TH8Uh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1742
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
index 0631c9241af3..0360d6438359 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -161,6 +161,7 @@ config PPC
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	select ARCH_WANT_LD_ORPHAN_WARN
+	select ARCH_WANTS_MODULES_DATA_IN_VMALLOC	if PPC_BOOK3S_32 || PPC_8xx
 	select ARCH_WEAK_RELEASE_ACQUIRE
 	select BINFMT_ELF
 	select BUILDTIME_TABLE_SORT
-- 
2.33.1
