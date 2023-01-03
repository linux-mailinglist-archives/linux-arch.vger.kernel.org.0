Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A9B65C714
	for <lists+linux-arch@lfdr.de>; Tue,  3 Jan 2023 20:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbjACTMv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Jan 2023 14:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238895AbjACTMi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jan 2023 14:12:38 -0500
Received: from MW2PR02CU001-vft-obe.outbound.protection.outlook.com (mail-westus2azon11022014.outbound.protection.outlook.com [52.101.48.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9FF12AD7;
        Tue,  3 Jan 2023 11:12:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhD/x+PRZRMquDQJOI5yod8laf5Sh23EJdknNJq8g3MOGDFJmhg+cnh34QfZ0YBFwfwcbK3re2toGaOdCqQ4XYZAuaUFQ9yZjHLg1uBTOOwekZNpOySjLomnedLgILXGdSYy8RkU3A3GFXJAgvnVW0wCcdMexr843fs6wkC0Wlj6+Lnh7XeKofgZNnwgaUUuc2uzBfdvZgaXEclWbM4miF+AhWE3j8waGMsukwuu7U8ndRwB/QgAHZ2UUkGzQ/BcPjlvhmfNxSrGS0seVata9Aa3tE2PTu9ol6q/HEKjJTeAg4crIjFSISFF5j5Z15tjKO/lPCuTmOMn8z7VGkPFxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHpNtPUeXJW+G53+X7MVfjk7nnFeSBEqSJFNHBU/Qy4=;
 b=kU3y2XgKWIe8qRKVHExy/9Ol5k1Ln9cc9QY9BTK1JMLz2hrriyctQlpWjkvT/r2FjMWwJ76XzOjkCGdbUtac8OHdjYY+4mUMl4FbK2BuoYL21hliSvJWtxqXg7UmvX14zX2Gr8SEHXvYfRBFkW2K28hUza+Y4cWHvm8zBzDYKu2pEXEgAdVzjNUcjZ1Cj+fjt58yFHSbGE4mAaYRLzUxtBbdtb+IB7VnEOS5jmnfNmnCTcUvVbOTe/PqLgV9lEPQik+hmNi0QNrn6jQz2apygddOnTyX8yoescNMQ6b066xWnaAV3nysuDB8RDOV66bKPoCRwgKW7P/hQ6zMnG97zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHpNtPUeXJW+G53+X7MVfjk7nnFeSBEqSJFNHBU/Qy4=;
 b=aRaIa+AsrmkvD29VcESSuigcMq2pd2xE1dMVcgTlLuJ2bOLUlSXG5mel44Fp+ANUXKi6swpRPpcQz+I9F7XhPxzKb6c0r2KMRNCRqwvqoTGAhLwLMUmtWBVqflAT3UJ+C2HscPnR5ntpvmleKNK4bcHP2hFGs7Op2EZWtlOHJac=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3749.namprd21.prod.outlook.com (2603:10b6:208:3d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.1; Tue, 3 Jan
 2023 19:12:33 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::db1a:4e71:c688:b7b1]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::db1a:4e71:c688:b7b1%4]) with mapi id 15.20.6002.005; Tue, 3 Jan 2023
 19:12:33 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jinank Jain <jinankjain@linux.microsoft.com>,
        Jinank Jain <jinankjain@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>
Subject: RE: [PATCH v10 4/5] Drivers: hv: Enable vmbus driver for nested root
 partition
Thread-Topic: [PATCH v10 4/5] Drivers: hv: Enable vmbus driver for nested root
 partition
Thread-Index: AQHZHnmpvVLD+m3uzEu9T0k4Q2fsXa6KtlAAgAJbS1A=
Date:   Tue, 3 Jan 2023 19:12:33 +0000
Message-ID: <BYAPR21MB16884F4749050078D9209D03D7F49@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1672639707.git.jinankjain@linux.microsoft.com>
 <c3cdd2cf2bffeba388688640eb61bc182e4c041d.1672639707.git.jinankjain@linux.microsoft.com>
In-Reply-To: <c3cdd2cf2bffeba388688640eb61bc182e4c041d.1672639707.git.jinankjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=28cca444-8899-41b9-beb8-77ecc57b196b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-03T19:12:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3749:EE_
x-ms-office365-filtering-correlation-id: 5986d3d2-5de1-4b68-b659-08daedbe77e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2MPk9Xs28LbEyzSWZVmeWkTXNz6HLMlYFgf/MXqloyPe6Jku6VIFJaZQd8L/Y+4vSKtdB736SYRslRrKUFPPtOQCz18PSPWw+1k8+M7wwb4GwPz//YnVoDDDxIDraOcMjOZgeSJPWfKNYdokeAQTqO4KeoRwhfTKY8GyMXUvqmugRnrnBLeAn+lnT2qRWSLw5d87cuKgkNFnfubhgjGu/1l14aY3JkV9C2ZFjaI2wPho8zIy/i3PmLSzwL06QFD5U5TCm6hvUX3HJ5MohPXYHIlGcH8HPy8a1msg4FczxncJm+3NtcjjoNVE66ASqT0oVvVKdkc5qLWSrElCsw83FIWEQNHUSOe7pq7kwgkZRWFZPn4HZp7lxTJKvRTcZIwKNAFqen3eohdC0KtmuonC3xOHQYyudruqzL+qesHZg8Nhc/GMCrCKQ78NB6KuXD3x+INWfjy2/qb4cdxFxirhRG3VUn+PzvJMXYbuJANPeAbjNLse9f1OO7k/a4FHW5PPpzYU3mC+O+fUc8Ap4R58WeWZHAni31jUSb3JFMTp01akJbWCAENJof+AcgFcFFxmXNiYWv5rld8uu8o8qLdvz9ay7K1ltTA2PDkI6qRh699FNV8+bCsQpU8X4I5v9UEySU06SxB9c++8vTxgEh1xv6+BRJ3xx6Y2+P3OWlwmi2PBr7esQitPoDdlDbJ0mPftnyuT53O16PfGfKwl56uA3yW+E1YoJ3JAGGSljQcqyhEI9aJp4TGn9KK+qDMcqxT5Xn6eH9RH1NFgQvtReRbY0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199015)(8936002)(7416002)(52536014)(8676002)(66476007)(4326008)(66446008)(76116006)(66556008)(64756008)(5660300002)(41300700001)(2906002)(6636002)(54906003)(4744005)(316002)(10290500003)(71200400001)(110136005)(478600001)(8990500004)(6506007)(107886003)(186003)(33656002)(26005)(9686003)(7696005)(66946007)(83380400001)(82960400001)(82950400001)(55016003)(86362001)(122000001)(38100700002)(38070700005)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P9qnAJgo/X/XxHwykzfl7kJ6CQhxAkknWtU5e9t9k1nIF38BFEOtOclw+3ot?=
 =?us-ascii?Q?7Iz1HSB9kc89zIQWdbcS25A7bfSDNaBCZnBQn/5N8jtYVctaBMlUSjZfuPmq?=
 =?us-ascii?Q?O6zsEUgzrTq35JO4HrdCazz3wo+1cMA9x03GfNcIaAGbuvrt1wAked92a44R?=
 =?us-ascii?Q?BG3ARlkyqrLWDx7K0m778okQ7xo8tJ4aEyr3Yc9t3lTmxtpDAQfMHJ1e2qWI?=
 =?us-ascii?Q?snOE/5lKeKTWXMtzsVeOMrUyydJN6B5Ei0qsSHKdGkKSHx/yjgIOFtIYwP2G?=
 =?us-ascii?Q?HZrJOnVaIH93QmIMxo3dCiUU1SadyqOINHNXdnu3g2SvMIBcpcsQUqN36+RO?=
 =?us-ascii?Q?DLPNbLHASv3/F8gfocO6eJfA+PPTPrYtqYH8UggbBLWNXywemAsH54NkzUJ5?=
 =?us-ascii?Q?CEIusQZ6Oum65uyzWvw4PQu9XL+Nra2zSwZ90PcMS0/9MbQQa6vuAVx5u4L1?=
 =?us-ascii?Q?qkyTZsEYu+7r1JQ6BJYdlcENJangdSnE3Isakv0DQHHxTk1OE2WMGsAnP+7/?=
 =?us-ascii?Q?ghduZOcY/va4z93zIyKqHZ/Mwb7cGlhCzrxAnS9NmP85ZOQPo5EwB75kqjEp?=
 =?us-ascii?Q?XIqdaWmMulD8vv7O3G8foowy2aKfkeBCXoZt7EsM2uzvpml6zGNT/mGLSPbA?=
 =?us-ascii?Q?jzM+H4dFUoqzKAGfhVv7vtwYGa6b8ougrqTkZn0qiO7pSrmvB1yOba4L/R6A?=
 =?us-ascii?Q?70llgDxT3kap2UhlPZxUz8M4Z6ksR+EWUV4EO/1b0QL5BfXCOrUpLCosXtDl?=
 =?us-ascii?Q?fYOlvq2FZ/n20YBNQIP13K0/i0rBoO7e1yPa5KbH4f9RAlPLMvkHa+1v76uy?=
 =?us-ascii?Q?83hFly+0iLq/fB0xq9u5Mbubp1DR8WA7ffJcxSROL6x7r6C5K9OphXftB64/?=
 =?us-ascii?Q?GwIFRpx2hOj2QnMBUQHqdWydZPUFwwLd7FDBbzIJWAdEenfgWmgKWHZ0SKQF?=
 =?us-ascii?Q?y47mvA71O0MolqnQOYM5ztvdgcWlh0VnPsw2uXp9ufxGn+ZuYemRINyng4FI?=
 =?us-ascii?Q?anBcGciDe8GCKZ1KAgX9COBrVR83yPRVcXKlP+bNN+QtJOAr/8thbPuWR9Y3?=
 =?us-ascii?Q?P8umirMGoEnjV9jHWUBju3csjcscABWZrKzO34IVUUi6nrNOEdtkPCGIHA0h?=
 =?us-ascii?Q?yKg3qfzLOKHrJgUvI4A8sd+8fAYbjF7PVqNHwu3qHgXSEmTqTeVAAWQp6vvd?=
 =?us-ascii?Q?W3R/pGQy8AgJtogbCxrj0XOtH1KJAjKgzOr5OPMZPW2vfvnDT59xEZfDb1Mp?=
 =?us-ascii?Q?NJ3uIsswdCMKjB47i5zS0MB41TMKMr9cG0dN8/YvxHHNEef57vDjnQuFm3dd?=
 =?us-ascii?Q?Oo5Wc/21VHxr3e8fU9FCO57649OFlGDOfwmMm8K4fSPQ/LMu3Qtib8AsC9Tx?=
 =?us-ascii?Q?ZqLL5vuJT/L7cB1y8uehhV2ebEto6YcFZhpX0rW5dBCiSIzhdMgPqSW847DQ?=
 =?us-ascii?Q?U8KeBVXAlfUXJwRqaxuiL8tUvlveLy/28dAdRX5EBpxYIdwHlgJ+sEqJ4CZ4?=
 =?us-ascii?Q?HHTnyoLuyO+SGCvUiyXwQh4T7fNgogXL5oZpe2AfbTG7COz1P3zButUVA9mE?=
 =?us-ascii?Q?PgcQKnL3hi10mTEXB2MBL4w3aI9ExXE+E3UE3Q7sXFKxzc2NWsmF3nK+guPt?=
 =?us-ascii?Q?QQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5986d3d2-5de1-4b68-b659-08daedbe77e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 19:12:33.6833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ei3xd/Gv3+Sa4VUPoMO/UJxDEtqMJUmnVpvrLhSF9h/bQVVj7JEEuz4eanMZeeOOWvIPgaQQMStDEIftLLJoIy8QPNNY4clWQx5cTg39M2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3749
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jinank Jain <jinankjain@linux.microsoft.com> Sent: Sunday, January 1,=
 2023 11:13 PM
>=20
> Currently VMBus driver is not initialized for root partition but we need
> to enable the VMBus driver for nested root partition. This is required,
> so that L2 root can use the VMBus devices.
>=20
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 0f00d57b7c25..6324e01d5eec 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2745,7 +2745,7 @@ static int __init hv_acpi_init(void)
>  	if (!hv_is_hyperv_initialized())
>  		return -ENODEV;
>=20
> -	if (hv_root_partition)
> +	if (hv_root_partition && !hv_nested)
>  		return 0;
>=20
>  	/*
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
