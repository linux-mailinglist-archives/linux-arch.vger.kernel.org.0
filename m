Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF91B62F962
	for <lists+linux-arch@lfdr.de>; Fri, 18 Nov 2022 16:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242338AbiKRPgT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 10:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242322AbiKRPgR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 10:36:17 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2118.outbound.protection.outlook.com [40.107.93.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE7D72109;
        Fri, 18 Nov 2022 07:36:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsqwUPnpp/rAbB1GjIWYmm9ybTzUqqGd9ORZOu/L1KYvuZzU0tagpr6LMTSwpuz3eO7VwTnwH8oZXaXgP4Ds3Iq1yX6fS9VfPjcC90nXnFQFsAEZ8Pwo1GnZyCDqXLRC+dJN40NqVIENK7+bdCoYels+kHbPCORMBDmTAj8I9Sm+6RbvfFwlkQhn6K4YlmZG5cD+053Ql+VjOFw1KP14lbRjs9g+IOEU2zMIGOVXKEaOVOBZ5uesn6yDY9aR3Cjsxj4LTIb6FJ23CWQku+UOTcyBAnGi7n5kmc4uYnB28M96No2HoCU0bnC0txW4EBU2E4B6OeaHN9NeRCttF0EDCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joq+BxSOTceX3NWr9wZ3k5tUNPm8IaobFnMnQalls20=;
 b=MNGaE2ep8fXSA9qGIQGDNxiUoKruAvzSll7aKQCojWTnpRqnLTJXEcO2uR8d8wf/yi1tMD3hjm7xiOG9uHYm+vISTxNGIAbEyPLlM311dmCRphDT2+5pXoDFDJSc778f05x18jTwv24nQzLTpPLU7DwJPIFQK4GsEmrI8FUdpA/JoK90z+zVUN0CUtjAxoKgUOlJ7h9RHKRRSjPnjeQZEHxEj5Bb2BJe1hemNwh451H8UuoBTjHWpOABVAR1WHeZCV2ExpiKbAVk14l+kth28mIWByPJA0hMprbu39Yq+FSXgOfxltkSHO+GZ8jRvZ98A3WPucj9KqVu9lDxreO4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joq+BxSOTceX3NWr9wZ3k5tUNPm8IaobFnMnQalls20=;
 b=HD43+NrRjzcYNjdXq7OLO7WEnfPt0q8Z3XyXUV+Ah65caMPfw3tTwqJ0yhOu/r+dwz49higqoiHvn/n803z1OMO6yrv/Fqv7Wgu4K/8zF5FQ74P6ixtrdTGr67CCHrFIJRMq6w1mu+KGc/ULvOE+CV3igm3dIPfJLLh7WA0iB/M=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BL1PR21MB3331.namprd21.prod.outlook.com (2603:10b6:208:39c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.8; Fri, 18 Nov
 2022 15:36:11 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%4]) with mapi id 15.20.5857.008; Fri, 18 Nov 2022
 15:36:11 +0000
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
Subject: RE: [PATCH v4 4/5] Drivers: hv: Enable vmbus driver for nested root
 partition
Thread-Topic: [PATCH v4 4/5] Drivers: hv: Enable vmbus driver for nested root
 partition
Thread-Index: AQHY+jSq4MLAkSmqE0eqI/MxJ57/q65E0mDA
Date:   Fri, 18 Nov 2022 15:36:11 +0000
Message-ID: <BYAPR21MB16882C9353E80F6B0E97B26BD7099@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1668618583.git.jinankjain@linux.microsoft.com>
 <034117b286fa4cd6fa491325679052f8b71a8c41.1668618583.git.jinankjain@linux.microsoft.com>
In-Reply-To: <034117b286fa4cd6fa491325679052f8b71a8c41.1668618583.git.jinankjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=22000962-d6fb-43b8-9913-a6c29591142b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-18T15:35:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BL1PR21MB3331:EE_
x-ms-office365-filtering-correlation-id: 8fbad20d-cbf9-4cab-058d-08dac97a9ef1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zph4LdsL0/eBRsaFn/YABVn3hbP59x0IxAme1eDNvWTdjumuvxtDeEYHSiYb9kwQ12J4w1UnGS5r0KJCJWvFiq9PgFXh/6Jxk4okH6ULgRkYco95sxQvgmQIKVzADz7tZhBVxlc3aTvb+HL8r+MbZjFTfn32n9xuWh5KKNVuYdgcqMDl5/7IP7bBfmr0OGLaSjfBLzjtqf//wN8lCR5+tW5GgV390Mb+8+WD1Frbkbxs7IvtX9nexuQnQnCLShxDvr3mO/2PqNrSQ+GhRk+zvQl/b6TijoOeMqEWP+AzBKPXb7Q3E4jr/zkhqJJcBATgS/rPz4Hotz3HFoTUrQDQkJozA7U9yO8XNpJFQpUFTsRxfay2pS+HwJDFdI5F5PoRQ/f6RB/8AG1Zrin1XQT/w/LhIvNpDvI/Fk7yAU8+m/iFzm3hNX55I6xpLLspy2JMQ0Od5cKg11zHV1lDqzlQDOv3iIwdY1PScW8kpiIrISZKXUkXzev7HoHVfr+W9/+UyeVDSH8ZD4UN+hURr516PBJDe3Q7fDCcyGPZ2ShE3C9P2PVmjVztk668Ymfpj/rhPHm99ryGwdLnnZbXs8+dG4XcjGC7oV1n59LIGD+OkoURBUmkTtxtgDCdXcsgexVCGmrmsKKNIcQUd3jMdRNZwFqPmNh7mgub4ul0phVghVeyATjhrNA2T2aq/wv6kM9jW5pv4B8Av6G+PX4TPlNxrYYpNEcMLGReqXtFWQD/DVIOEMc9TPbNebBUfNJ0WS8j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(5660300002)(316002)(7416002)(122000001)(71200400001)(478600001)(8676002)(86362001)(64756008)(66946007)(76116006)(66556008)(66446008)(66476007)(4326008)(8990500004)(26005)(107886003)(41300700001)(55016003)(82960400001)(8936002)(82950400001)(38100700002)(110136005)(6636002)(38070700005)(54906003)(52536014)(10290500003)(33656002)(2906002)(186003)(7696005)(6506007)(9686003)(4744005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8MIxwNtMROnogG+YK/5ivJH26fz0L6GBNno2R1AbIggFJj/FwC7W/NiHg/MU?=
 =?us-ascii?Q?oRQXtAUMJiZFh3DGNVuvQsReXLGyT3UydN3sziuUSn8nAwAlZjf59HdTUlzN?=
 =?us-ascii?Q?IlRrRQte16qiwe4z/wWhpWkz+MMe/aAumeqfQT4avxvPvceJ/YAixe59SZ00?=
 =?us-ascii?Q?Ad2NDHFQqlMOrceEO72kZyfMmTLlRTTf2kruOSyTFfj0JDAaQg/RvzvK+5Ck?=
 =?us-ascii?Q?MsLkUd4tnqQYXmovLbAOapY0Iflpn6t3YctA6uBHsq6dJMDhBROEw7JDf8Jx?=
 =?us-ascii?Q?kf7zek0/9FZxfai0v5O7fgks3eoxba3rvv22SoWRPI0ktgN5HEfJEnXVe3S+?=
 =?us-ascii?Q?z9jfGjFo7RngLJEYbB9bsUBdIYx0rmV+OmUHZKnm+6jMelPyFKOqjIb/RbIB?=
 =?us-ascii?Q?y6hgjA5hwqMlhjRWTNwEMtGhcpmAVRU2tJHzdXnXxXey+tyypppGag+9G9/I?=
 =?us-ascii?Q?aXhP0etzPRoj0L89GP9YcOyFHFCldermItW/VJzs++svnL/NHOY3Spuzad9L?=
 =?us-ascii?Q?wK+HRnJ+/0y4FW14SzoqbMfF0vL32Sisoc+3vT77AJuRZ6DqZBXLpfiKtHiW?=
 =?us-ascii?Q?n4LrcLyFgnjegA5uf6O3Uttub9/EbJEV6TtDO0BAOadm6KFQxq7ta43m9Mmy?=
 =?us-ascii?Q?/Y6TS210Uv7KSY/fsbzV2Is+zMLBfmpPZwMv3Hssb/XnHFBj6b0eKnMILj+s?=
 =?us-ascii?Q?wsPrMCM63+fCeAd2I7lX8dzNCJvj4gqdrHZSFLU0t5vVhfJ0UqBFf5vT2kOU?=
 =?us-ascii?Q?vS7vtyFcRzP7gk5SwESicp2zBukPncyXuBpo6dO++TL6fWzhxMI+1ULiC9+J?=
 =?us-ascii?Q?291UylVREJGSzN500siJRR9JUlhJktlvIe6SxTjMi/28rJ9YXxwxUK3B4TeU?=
 =?us-ascii?Q?weQiBL0G1Vb1QVJPXpQ64h2gnYif/iAsw73yzr9i2ry4bI5zmNLIHU3UBLhQ?=
 =?us-ascii?Q?+gX+5/g9WWeeisyb7USEV2FRj642i/ZzTJ1p7X4mXIiYBhTLK+NR8LjTv57b?=
 =?us-ascii?Q?hsMmNr00stAyJZ/HTjwevPMnROG11jzouMnIPx3LAUL0DwCBdjhJWznM6k8n?=
 =?us-ascii?Q?fCZLRSyBXBEMppyQ3coGKddoZgbi5i2vo9TBNfmyNXVb0dfZGWc14X4Ntn3o?=
 =?us-ascii?Q?x76nD0tsuQd8bNKyhMQHrvOxKohtsm4to3m9GrF+sHabAeTVvxPFOsKqkgoD?=
 =?us-ascii?Q?BvLCfY8uMoRon5PNSOPZBAPeTc3Me1TlpOVrhN8G+k2d4Q0EuH6PAi0Gvitd?=
 =?us-ascii?Q?h3ZjQWUp/zOtKr3Wzsh1lyc667GGOoufV/dYnSjN6c4Uzz4pPIyorojnMdxT?=
 =?us-ascii?Q?hSEgM8BjGT7U4oMU14QCzm3z87UYggW5hF0oeG94IdbUDTmKSqKvIxS3RJSe?=
 =?us-ascii?Q?lfUmmd7iuqKj5U0xWWHYvIQP2fFrRpCRtotlE41GLQK++VYzEdhmfrmn3anB?=
 =?us-ascii?Q?qovCVjSMBXGxSJR5vqYjWMDX/SH6tPpJFUzXrlGP+6X+FIPxEJKxqqlekscf?=
 =?us-ascii?Q?QxxcwFCSW3VqLQ+fSHlUiV8uwuYCf7udANF/LvcCri86vHX/WRDd1VT3RU5D?=
 =?us-ascii?Q?CqYRKjVi1Nc8TjLqkbU8NvtuAQEadIbtRljEuzd06xXkyhhsYCLYyuvO7mKF?=
 =?us-ascii?Q?/w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbad20d-cbf9-4cab-058d-08dac97a9ef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 15:36:11.5822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qdtJzUU3SOkyIFIccHoim0JixighA09iUd8tCOGkZ7F5xSDyXfUSt1hXZGFVWBBLcEAFOb7jL9wNQ0+sSHTUn7E94ihHtmU1B+5sPxUE6aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3331
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jinank Jain <jinankjain@linux.microsoft.com> Sent: Wednesday, Novembe=
r 16, 2022 7:28 PM
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
> index db00d20c726d..0937877eade9 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2744,7 +2744,7 @@ static int __init hv_acpi_init(void)
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

