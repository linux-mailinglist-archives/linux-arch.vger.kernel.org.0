Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1995C77D960
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 06:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241733AbjHPEOc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 00:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241743AbjHPEOI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 00:14:08 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020018.outbound.protection.outlook.com [52.101.56.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9EA1FEC;
        Tue, 15 Aug 2023 21:14:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l73sYwqizlq2msOfCB2b88fb8OpSmLV/Btaphon9ZBnMSSUFIHQmP93EB8lDBU/T3E7z9QTh7QS+Rx9wqdvmadQdi191rYkCQgyiKzDaPbLnhXlyU/ZlkCK8xq1e1rFWQnjOPhzF5nm8/oXOhEWhCDD9X9KtS3P0gGzC7T3oO9fLKICrdZWt1BaF76riEiX8T82X7vllXACfsWqWFXQLme7W1YjS1K1JzU0gqnjt9vws0GED3orHzmcHvQAAJPNW7jJxCkGVTEA+6GkZyxgPDJsRT6vg7antuQn2UlWTzUV4JyyuAQnTaxb4OnA8WotTITl8HNFGjNcmDhdn0QUqZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bALi9gZIbW3xRiIaZ+pfVYksNn0YbpJZCDUoYSxaUwA=;
 b=U2T4GY8AOFXZNbbZ98CE35TO2Cz+XHpnwFLYNv17kYb7K7ot8dDTyMQ27vwgT0hMUSq8yzkXS4jzAYPcPIwenRHVQjGt0C0wPqg3qp5dS2nRykYVmMz3eeLRBxBncsBtu73WRdOCdjJQMiMt3uO2EnmvPDtjJo6dYQi2Nmb6wDBWpGSVB4iB9mIAIHlfs7N8q3lQb1T5vWD+FacX8hMc+zT2A66ui4r/9MmooKbxmU4XD770Rtst7XHVl2MXuDLjkISm3bOuYwZnIjUnUxcE15vnKhGFrsH3B83CNlOgPpMZ6JYsilRD2AbkEvSgNDmwCHN44HAGf3cdEVPX1/2nmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bALi9gZIbW3xRiIaZ+pfVYksNn0YbpJZCDUoYSxaUwA=;
 b=alJ69Q9bur5vgjNfS55BhGx+Io868J/mDTfdBIVSZMiDBQyUD2q0hD34LDcZusMnbuFQZ+9qBM1RsB1ORRBo9ESO2OLKmZPkZCZMzBpXt2ist6oHtKXelzQn+MVj62hTGlaSL6L9aXCcmpYGNQGmoYbZia3SOD42zgZIANyXSCA=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by BL1PR21MB3210.namprd21.prod.outlook.com (2603:10b6:208:397::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.4; Wed, 16 Aug
 2023 04:14:04 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%4]) with mapi id 15.20.6723.002; Wed, 16 Aug 2023
 04:14:03 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>, jason <jason@zx2c4.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        Anthony Davis <andavis@redhat.com>,
        Mark Heslin <mheslin@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "xiaoyao.li@intel.com" <xiaoyao.li@intel.com>
Subject: RE: [PATCH 9/9] x86/hyperv: Remove hv_isolation_type_en_snp
Thread-Topic: [PATCH 9/9] x86/hyperv: Remove hv_isolation_type_en_snp
Thread-Index: AQHZzKHuUaTQPT9OYU+xvQ41hzOz2K/sVcJQ
Date:   Wed, 16 Aug 2023 04:14:03 +0000
Message-ID: <SA1PR21MB13356E356362026E87BC6412BF15A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230811221851.10244-1-decui@microsoft.com>
 <20230811221851.10244-10-decui@microsoft.com>
In-Reply-To: <20230811221851.10244-10-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a88103fa-1e74-4a5a-a98c-3d98f4674378;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-16T04:09:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|BL1PR21MB3210:EE_
x-ms-office365-filtering-correlation-id: 6e610e47-8940-4c35-bf56-08db9e0f39de
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LW7ErrJVCijDSr8Tc/rbvxevrp99D37V/5QHEZiDZeg1nl0nW2DxtlRiFYg1n5w8zmvr2X4p84QXt0M9iFpJi0wlsbpM082kW2ldE3klS3fusq3P0HRBBxfaThfzS5pl/6l4XgdTHtqS2Z04VxI9afELsUbEI+DFJyNhAkivlxexeXsNcCg3seJAiwrl5RcSIVbSRetQERsbN97Wfvjv+4Xp5ljxW0e0GSNdZ7JV8VrbyE+umE2uO3Zgn4HRzbCiTBxf4sy2pCdmBzd+NGc4+k2YNpo7IfI0IfPNPb6OT8Gifhg6g9hAzNk+AR+2LFGYBEQEjOGhhUNQAVcVbX5w37W+1Gtpaw5rnqt0vg30/FvSkkHHVha6nH1lackFOBAiCcZm22lwFTuar7M8gBZDMKD+HK9PqbaQR0CewVP1Zm6B7TOkLqYix+ie0xIjeNUXy+6tpHrztNpXGmuhqrKsiPiPQElwmFaxVpLkd0rWWhUWdiQGOBLc9CUk9RUv9vj+Su2yJn85Bfgo+Dr4rkbUy8o9b+5s1Dt9rHrN3jo63WW8JrTT4QSX4EkuOXccjjCyK18yoly5WuPY1px28iTBPmaMW5Q+SHYuEXukGUfYENo6W2f/XuqFYNOOBEvCqQV/FoIWLw1iOTuKxukKySqdJtBvzK0MpGcdYaulniAqnOv/glqXoHtzlV8at62u3WY+V2hAr/yCbbSm8OUyZeZEPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(1800799009)(186009)(451199024)(12101799020)(7696005)(110136005)(478600001)(38100700002)(54906003)(55016003)(7406005)(33656002)(86362001)(7416002)(71200400001)(5660300002)(921005)(82960400001)(82950400001)(52536014)(38070700005)(2906002)(122000001)(8990500004)(10290500003)(66446008)(76116006)(8676002)(6636002)(64756008)(4326008)(41300700001)(66946007)(66476007)(8936002)(66556008)(316002)(966005)(26005)(6506007)(9686003)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vMZdH8d7DeVauz5x//KaZt9ykZa78j2M+C61slJ4TJTaM0rv/1u5IHz/ZDbJ?=
 =?us-ascii?Q?eaqohdB9s4alINMN/P5T3o/hmvAe4wU1eEcbuusWIIMKc09D8RYuUIeCO1w0?=
 =?us-ascii?Q?Oe80zMICTt/e521SeGeDHTdDTcQigctPa+PGboDkXJao3LBhncBByGTtuqvF?=
 =?us-ascii?Q?1N8OZLtAB3hghtM6KdasrVwUtDBNGLNCtxydUqim63Z+8AE4S9wioddhS5+v?=
 =?us-ascii?Q?rzEdhBnFKXYuwXJDF/8LaGYGhH4zzE5Cn6zLY1SG6x77yyOtCrbfsLNJEBQN?=
 =?us-ascii?Q?bbuLbfOqBFLIt6MOs1woTUEM6q3O550a+fXEzkvvhyamcWXvk1/IIYyYW9oV?=
 =?us-ascii?Q?LzBfwf5Tdx97qvBArOQJ5pwul1U4h2wf22UBO8thoRlUvMrpHzOtA+iDZbkv?=
 =?us-ascii?Q?KQAIOoBHTffJUSoJCs8q1iP2LrIBDo7JwMXYWbh15jqLxIodnSafGWHwUJyC?=
 =?us-ascii?Q?hky/l4vVeKXhpmt1YQHa3/CsMawhLrcaOabcrJzWuLQYq23BoPh0AM6oEQHR?=
 =?us-ascii?Q?9PpVx8ILrt1R57ADbpLdujeQcyzrMMwqmODIDap7t1IDVYnseGt14Z1P3dgb?=
 =?us-ascii?Q?oMEfCaEGmPzL7N9SJhK4mE+V7L8zFwpaz0EJiTjAapyy1TRJyofrCvpyEbWF?=
 =?us-ascii?Q?qvQGO0/OrFTthisjpoWjfIxE0KT/T4p81jUEyKk0G7WGHcAJ5V7fjvd+Ol/E?=
 =?us-ascii?Q?uHOYLuzs0FpWvjSIUymmVes4MJtxJ3bYSM89TXuRTdtNMadqJlOo3vkVSUpv?=
 =?us-ascii?Q?LarasI1wZNg/lgU/afIR2sIaKEIk7VQNRZyprFOfAE3UXAtiE6n1UPCuZ27B?=
 =?us-ascii?Q?4MVtT1DeuGeWrraEtKKDvT94B/B8GSfCTvqHyyVyUzHaVAZRWxIlVrwzHEDe?=
 =?us-ascii?Q?GQhARpctIW2fqt7GZ6J+a8cHhq9YyomKceZ6iiJTnw3KLNHU+wwuZhx9IBNq?=
 =?us-ascii?Q?53K3kXWU3N9tWmj6hvaq0ZvRaWFRsdQMBpK6O4w/tQ3QPKr2L3c3IkHpE3OI?=
 =?us-ascii?Q?r9Vv8yvtO64zPE4GozHreSNjFomw4QW8VcB2F4sQhPWx+EMi7rjNwF/eKmMo?=
 =?us-ascii?Q?aYoo/EDd++jxKqKdypuWOQvOQIGMGfntjNVeq8HRKB36HOnlN1bTbjL1/3yj?=
 =?us-ascii?Q?U3PAq4Wbs103qrTK3T/xtN4pWS2VrIiy9O9URowmwmAkRzmNzyS4VRsdITWG?=
 =?us-ascii?Q?fWII27OOMnW7s6NvQ9WTQUE3Tx0N7XzAIrone/TpqPeKLQbtlBpSdvUMeFuR?=
 =?us-ascii?Q?ofRQUHtrlKYePS2lXQ+OXWsYucrDJmb583HLsFj0wBLT3ktzGIANz5xWiIcG?=
 =?us-ascii?Q?iCYI/Ql8SztZBNp7x5NLMSwglJEQS+ntAiYak50Io6HFxEMdKdGUoEqthGFe?=
 =?us-ascii?Q?SsxbW/Wog+XSVBqWMvU7fA5G6tmfHwbpP0wwWDUly+iKf3zyW//ShF3BmBYH?=
 =?us-ascii?Q?7ZWTOC+pDiPI9ifVQ+IuXeYF4qiQDkYHO2Amo2zm4C63PPrk8qERyBnE9aez?=
 =?us-ascii?Q?rN3WPQ5dtF/Nk/OVaOljCUUfzi0k55uqpUYF0ApMCHHHVf3YfDEeXZ4JC2Ib?=
 =?us-ascii?Q?yIG75qReqHzl8yirqy4vV+Nq6/kcDUGNxNQ442pK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e610e47-8940-4c35-bf56-08db9e0f39de
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 04:14:03.5619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E4jEZm7S6tPyU8MQXAvZvShBEZAeQxKsVrJYRPCy6FU/UAJZ9pTlLoIJvAwSuZPEwl+cd8OCAA//mTg4vmrJJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Friday, August 11, 2023 3:19 PM
> To: ak@linux.intel.com; arnd@arndb.de; bp@alien8.de;
> ...
> In ms_hyperv_init_platform(), do not distinguish between a SNP VM with
> the paravisor and a SNP VM without the paravisor.
>=20
> Replace hv_isolation_type_en_snp() with
> !hyperv_paravisor_present && hv_isolation_type_snp().
>=20
> The hv_isolation_type_en_snp() in drivers/hv/hv.c and
> drivers/hv/hv_common.c can be changed to hv_isolation_type_snp() since
> we know !hyperv_paravisor_present is true there.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Some of the existing hv_isolation_type_snp()'s need to test=20
hyperv_paravisor_present as well, e.g.

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
@@ -52,7 +52,7 @@ static int hyperv_init_ghcb(void)
 	void *ghcb_va;
 	void **ghcb_base;
=20
-	if (!hv_isolation_type_snp())
+	if (!hyperv_paravisor_present || !hv_isolation_type_snp())
 		return 0;
=20
 	if (!hv_ghcb_pg)

The new version of this patch is here:
https://github.com/dcui/tdx/commit/323de396984e3c222ded23dce46155ae48a1992a

After Tianyu posts his v6 of the fully enlightened SNP patchset,
I'll rebase to his patchset and post v2.
