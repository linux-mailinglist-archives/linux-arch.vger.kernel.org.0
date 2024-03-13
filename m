Return-Path: <linux-arch+bounces-2965-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C5987A280
	for <lists+linux-arch@lfdr.de>; Wed, 13 Mar 2024 05:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829091F22D7B
	for <lists+linux-arch@lfdr.de>; Wed, 13 Mar 2024 04:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC90134C8;
	Wed, 13 Mar 2024 04:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aEE4LVRS"
X-Original-To: linux-arch@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11023018.outbound.protection.outlook.com [52.101.56.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092CA134BE;
	Wed, 13 Mar 2024 04:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710305467; cv=fail; b=ZvEwm9QJi2lStq9o+iISVIaHCIsK7JjVfCHdHWjAkaUtQg/UEBnFG0v4RkXqv7Uqx5rZezzOItzUu0v2pdzuvdWoT6tWlHWN8dMVxxfw3RlEhTAurVlLjQoc82mAc+ewrPtszCF67yvhU51aLxW/ycLTufJmodt3g6qVFnwLOk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710305467; c=relaxed/simple;
	bh=ra8gO1o5lfXvVTqnzgLCErczKszcKpQzq1Nb+FZ64Hw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TRciSgSKGDTGMg5pzfyiazbKYhkUg8Y8lToBcFXmdNFa52rIo8H0JZrgErpIIJIM2C65sCSbRw1Y1ctjwSo5Kf5P+Fnf6muD6O4xAE4fbA5WZuvQAaUhGxM4tc7YSw3LMWScd09bjfJl4ngQWqAj1AkXF3sEai8R2IT8yWPowqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=aEE4LVRS; arc=fail smtp.client-ip=52.101.56.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVQKWKU/lgQAubc3OUJadsXbhlgx4lKbxgkXv+Flys/E7c/tzwLCvcFssFYxSDZzDWqaROUSIXu7U7vcMZmcLNFs1L30hBquSb8i9m/spXHgJ0oAuPyDiRczK/ERwTXF9VbYKSLMv9rATE8JXxf3gq8r92QGV8b2zDE6Ir7E3o7JLpuLiAud76X89NBY2vZxyTKYYaixEJd8NhqKJ3qyKqYKvL0y9waMMWLSffNJl65DDQR9A73I1Z6cmLtHugxeHolBhfkdUDUgtSAnjR+gvLch0+apzZh9lPTYFQc4YV2JEIfCHYtPTY4AXbObJq6j7+DX3Mu65kHocJZAxqcxxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSrN9Mxen8HOv2T1PT3jDbN1w0RuvE/e4nNcBtAJZqQ=;
 b=EFfMaOEGPkcS/cgMuzwnwiIdHc35Ay+jM6C/YfFb7a7BnbCx79KJLZmXBlhFfJ+LhCObPUrEy4bNz2TFbz92GyyDQjQ+X5RW2zwfLLHa+SPP1MR6RbJPSg7sjOk2mZHg2fMxQmIgVBJIqeKualDecSo+9eGtIKtbvr6SNtQeo7rElnAIzDZnKPyw0bEBvUCoupkkFBREs1EzIp/1LcXymM/Vv1MBQXgCysFS8MShRaqPH+6NqnEIoJgdMuq7GS23WsnwGUMStZbZrPIJ/R2rNIRpSHhHt8Eew8Vw53n6C71RkGeWb6DlSsn0q7CK+qgn+IZ9ntB1QFg97ADYEkZ0hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSrN9Mxen8HOv2T1PT3jDbN1w0RuvE/e4nNcBtAJZqQ=;
 b=aEE4LVRSCUWF+zEMmrJp2pGd11uVzYmSpPqs3tgs8nfbFG8ek29zI7e+73KpY3ypWChTpyV61Z6XWxf+fqlrNgeYzsFZAfOekB2Zu2DQHkNrLnCbkOamiL/niLBLidoACnYAw0vA58oReddm5bgarsPzJmdCq5g4caTuje2fT0o=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by MN0PR21MB3072.namprd21.prod.outlook.com (2603:10b6:208:370::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.2; Wed, 13 Mar
 2024 04:51:02 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7%4]) with mapi id 15.20.7409.004; Wed, 13 Mar 2024
 04:50:59 +0000
From: Long Li <longli@microsoft.com>
To: "mhklinux@outlook.com" <mhklinux@outlook.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>, "tytso@mit.edu"
	<tytso@mit.edu>, jason <jason@zx2c4.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] x86/hyperv: Use Hyper-V entropy to seed guest
 random number generator
Thread-Topic: [PATCH v2 1/1] x86/hyperv: Use Hyper-V entropy to seed guest
 random number generator
Thread-Index: AQHacMAmGe+doP7+JUap2rkXt0C9bbE1H/cA
Date: Wed, 13 Mar 2024 04:50:59 +0000
Message-ID:
 <SJ1PR21MB34571493BC1473790F5917E0CE2A2@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <20240307184820.70589-1-mhklinux@outlook.com>
In-Reply-To: <20240307184820.70589-1-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|MN0PR21MB3072:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uNaas9j4oFxa32AWKOU38HtQ575/6i+67gQA1r+19Lj5nK3aKCAn5en5NTpYulYc29A8AbeBQ24E5c5VYUoU7aOvIAXF7o4YHW7A0VtA6+0a1SukrLUw2rVpIGot1EsjFfYwO9SzXHsSo8okTzGLjzUQwbis+TGMlbHbTkfgF/nLL6hnpLf4XVda5RP/HCOsnXIYcsLyWebcj1jYj/T3LzKNKA5IJR6hXDfrLDZQg+x8/mDIQKPku4ZRAE8cVa4jj4FAXQSntlLLlglIwHSBz+JIDZzSjAoJzk4tUl8fPj5Xp3CW2xrFfeNMVh9g8N/vf6a37NG7iXfWdst07W7fiKs9wnpU++eYSlKMXGMImlccHRllwO8rnJBy1QDBG32TIQo2861OfdIc9h12fXqzzXpcrouvFAjcGKcT7JN0rSadi24HXvSznnQf/YN4Mksx1G48q3yoqaApVAtwhGzriAtOAFSqLkGgdEbRkszvHi34fhbP1CWg7nRqpJdJR1fPuAoGRZu6mBHdZO1DV9rKKXroMNBzU9rw4m1+WeMyV2bc/fi/OsXts5YV70bO/FpIIHVL/K8u9sJU0973/rIroipLEu2vKU2TKroJxqK9m5fZdjkw1jsEE7bRGfzDSSBrqNLwosolA3sJ2J+8fKum3eJd02hG9lzGGZ0H8EbWPl/bLrAsT0crkYosA2dn1cGiDSON3Q+wM3imzeEFx5XtEw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bnwBxejsjYmJmWlblpmWapoNjU07e5175zTHyn4Sy+iXqLxVLtle6nG6x1n8?=
 =?us-ascii?Q?5JIbDYdWSmAxDI0+1eGyAHtKBiloUBfWuBvk0dWtW97ztMtgriFLFpPkvcm+?=
 =?us-ascii?Q?pE+DmVrOhmGw/x34anDJrFbSBalxmxYbG33nMeBbbxCtH6XxuQSWRH+H3aU2?=
 =?us-ascii?Q?bNHPbS161pZQHbJPPhej2wnuxILA9G/NPHFpePNsRSkE2FUYrLVOnlY4awYU?=
 =?us-ascii?Q?3Xctwrr1sa/lLDgt7Kkt3ASP9/ethoJPZ4FJRjt7kqJR4KiAiaA+1R6n7waD?=
 =?us-ascii?Q?cj7033SZBdFDWS3D9w820m9i0i6JmkZ9Z2zRDXCnstSRdpeMar05oCHcSzj/?=
 =?us-ascii?Q?G4CW7fUYrwYtIv7Kbuz6pp/YYQXrH0jOmqEGdYiTI5oxQJhYXeDq/EIYh51L?=
 =?us-ascii?Q?YuNGZwW15e5uX9JBl+Phdj0RSVQ2GGf5kmF8hV4+NZ5QBzL9miSyZzi1Dgz2?=
 =?us-ascii?Q?RbBZJVxipb32sRd4Y4JFoKd2Nz3WZFKS5ddGcv1AYD3ug1t2SBDv7Kksm35Y?=
 =?us-ascii?Q?4us4OhhyefO1BOlctB4ITsIpq5FIyBqdC2fVVwKSdlDXt1H2PILr68hNjG3L?=
 =?us-ascii?Q?Xt8PhI6/9qGK5NYcuwHobvQ1qQpvgB7nA4bMX0RfJLQ+qAShxL5747wwbIVd?=
 =?us-ascii?Q?BfO7iER2ow9BK44vflN6cEeTf+1ZmfBN4XktAtjWxursiO1FLMzDaDQWx3zO?=
 =?us-ascii?Q?5zr4jrGbJ0B4R05kIJiu9J3ZprFyuobe53Bkp0b/39XKfMzqOwb9r1LJe3iT?=
 =?us-ascii?Q?PE2A2Zgj0VCa+p+9aIBaNJXCgLc7xRT6d4r6ORrJeNQdYRssqnGBSSKqx0oV?=
 =?us-ascii?Q?7Cjt0iKO4IYbOq5X736Mrk8jYH/pJjfJs3/S9xftCDLO7xQMAUh32vyYoyKk?=
 =?us-ascii?Q?bBGwc6tgtqy14dWKn1q73UOVugt5qWYORzKaExHVhWVwcUduz8h/qJupk8Bu?=
 =?us-ascii?Q?8YxlXL/0OxRzavOd3R5nHUSVX82jVVuEi7a7Yl4P3VIBboaajYgBDpyd0+od?=
 =?us-ascii?Q?1OZf7Zccc1MnHZ4iSlvn+MeQHcO3yNYrVPPZHZE4VTBSrWdjB8vd3eh1X6u1?=
 =?us-ascii?Q?Rl5c/zeUn+XevVNlM8cCtpKi7cGj9R85E36pSd/2J8eUCKGBkn4jkxl88dQg?=
 =?us-ascii?Q?K4Zw9GUJ81dNpqxmhAolESu1qqW8Z25P8/80jFGKtIP+te3DYCO+Rdcw1BlN?=
 =?us-ascii?Q?Njpha7D8FYrHjd6kcIL5W8J4XcYN3UPfkHeEEyWnZIgUpRoBeF0FXGYJBr6F?=
 =?us-ascii?Q?9kqieY9SH03UPVFH0j+w5ZwydQu6EIEhatAAOniUGfgVzxk5XeAdI3q6QorN?=
 =?us-ascii?Q?T3lAfBOnKvD+mIMfRe3s9/Crz8Horq0YgxM5ciV8eQMmg2suSAF5s9zKKHKL?=
 =?us-ascii?Q?DQ/Xi+xlV/ckRxzMMclTBZjDiUuTH4a1c1dmsJociYsm2DiZn5dnNAvETosp?=
 =?us-ascii?Q?vGhkNQ5qR2RgUKwbEgIbWbJ8Vmnj1bnGaykAQV2AvXEP7mcA3iFll38mqn01?=
 =?us-ascii?Q?gDCHKnnOZdwsp5ZSKUh5hMyA0Sc7n0hhb1CZOULEpJN4ZKG+nawselDPcptg?=
 =?us-ascii?Q?jDAWxo/nrzskxT/xi4ZqmkJueydUDxUrwBwIP0/q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3457.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc39837-62b3-4cc2-92ce-08dc43192d7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 04:50:59.5445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +fuKOg2rX4f+dTwigZ/IwAqUkpN8fqF8/BAIiSOccGEIMyC0fCanRbjHNCtx3PE7U6Gw4tt4cMDtTEG3XWCALA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3072

> +void __init ms_hyperv_late_init(void)
> +{
> +       struct acpi_table_header *header;
> +       acpi_status status;
> +       u8 *randomdata;
> +       u32 length, i;
> +
> +       /*
> +        * Seed the Linux random number generator with entropy provided b=
y
> +        * the Hyper-V host in ACPI table OEM0.  It would be nice to do t=
his
> +        * even earlier in ms_hyperv_init_platform(), but the ACPI subsys=
tem
> +        * isn't set up at that point. Skip if booted via EFI as generic =
EFI
> +        * code has already done some seeding using the EFI RNG protocol.
> +        */
> +       if (!IS_ENABLED(CONFIG_ACPI) || efi_enabled(EFI_BOOT))
> +               return;
> +
> +       status =3D acpi_get_table("OEM0", 0, &header);
> +       if (ACPI_FAILURE(status) || !header)
> +               return;

Should we call acpi_put_table() if header =3D=3D 0? It will also be helpful=
 doing a pr_info() here so user knows that hyper-v random number is not use=
d.

