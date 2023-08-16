Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D6677EA34
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 21:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243944AbjHPT7G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 15:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346072AbjHPT7A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 15:59:00 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021018.outbound.protection.outlook.com [52.101.62.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A0A2133;
        Wed, 16 Aug 2023 12:58:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTb6mZ0KTYrrxU7d/6i/a8op4Eej2HZIIE40e+2ILi+JGvaYE6M6BS+kqZt/ucTao+UG2ywB6GiIzQcJJuEWzI21yYtijXhpWnCS6ur7Wy+dZ9gJ/dPctE3HtPZUgoDNr/JkeLQfRqpe4LEz2ytpdqIuJnnS9FBwS8utCY01VITmkkkZ14+5svA9i4LyI6c5dMf85Q3OC7egjgazpDU41G92eOX5CcD5YWACJ0Gtzs9AV1xm/BXHCQkghd6QKFdtp0S+wvvzbC//wByixcBHItsXElMxj198hq9u/shYrYINlmbU5K675F4/BqZl6h+/nHfz9rhcXVUBHkczWJpDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kqb9a8T3d3ubcgZZsshZpI2JNWx1R1xDW0LaOIm02DY=;
 b=WSTlZG8g7Q6CEkiwdfKVi+xy74SR6tM8BN3uCuo9Mk1UMzEz4/67FhVcMVpxtoY2Uma8UJowFCPDpEsSzdPbM+oCzatJJ8LPclEL2oWdo6qTPW/4pIML/C86yPQ7HT8fgb2Pa52u6nb2YJjvpSQgpwCMQnlE3YX/mBI99iLqYuqVvrjqYkr4ulos9c0AageXksXWPcsTe1J6UATGbba0Xpk4ypTEHrFFAsHZnNCRg5OahukAjqYGkdo1P3qKEl5nsKOCWrYooczCcZfkv4ommB136P3uUgdNSevttq/ejkeKVBcASGku4AqrTO9GS4K2vU2lI9Nlo0uiOktF9alnUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kqb9a8T3d3ubcgZZsshZpI2JNWx1R1xDW0LaOIm02DY=;
 b=C1pDChewqSzvl2dlQ5FaQrEGm/83u7k9kma9P7W3vrdtZ8nElPPRhusakSKXg7IDLSskyZDLvx2xJrqUu5XqINY/xcQiXl8v3BDy3tGnvatJawb4A6gDyejjZkQUfzo0wyTfgZaZBtrBwpOg2p6JgxC1HZdMIqOlXYnoNlnRuEE=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DS7PR21MB3743.namprd21.prod.outlook.com (2603:10b6:8:92::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.3; Wed, 16 Aug
 2023 19:58:26 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%4]) with mapi id 15.20.6723.002; Wed, 16 Aug 2023
 19:58:26 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: RE: [PATCH v6 3/8] x86/hyperv: Mark Hyper-V vp assist page
 unencrypted in SEV-SNP enlightened guest
Thread-Topic: [PATCH v6 3/8] x86/hyperv: Mark Hyper-V vp assist page
 unencrypted in SEV-SNP enlightened guest
Thread-Index: AQHZ0FqUrb4ypgNxWEKL2cwRgfelp6/tVzOA
Date:   Wed, 16 Aug 2023 19:58:26 +0000
Message-ID: <SA1PR21MB1335022AD578B3E297273C08BF15A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230816155850.1216996-1-ltykernel@gmail.com>
 <20230816155850.1216996-4-ltykernel@gmail.com>
In-Reply-To: <20230816155850.1216996-4-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=90745f7d-9b69-471d-b213-9cbe437e1bd5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-16T19:57:58Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DS7PR21MB3743:EE_
x-ms-office365-filtering-correlation-id: c9690ad7-02ec-4acc-5f4f-08db9e9327ae
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: od4pxbclWnxmQ3DNd0QUxaO+tPcC84SAPvRGG1VNaWG54X5wnrCjE3BTENuiiRGzeNJpmEFjz3s+xJm5XtyqEx8OmH8GDduHLseQ0H5th0MismUKB6W5+gii6c6XwDXXjR+znvQwWJKiPJmsTotTtvbJFq8xrIYqQSxlebHuPzoZrQkoXXdM9yW8iGe4oh0CDQFw9fppHO8CdFuOB71FUkDVqMIapLyij6uUf7fzF+5o+yrQAVHmh2ahfJI0Wf2GqqX14BVzIG7zbYXIhnABbV84Gy5Yp+7Wxx2kSLjA4AVg33rqdB7iNs/AGVwrtTNUkRZuIidk/Q1VX3SnpahyzEZa/k/HcWeScyKJVwnEfV0x3DsREqhEMaV/Uatmm274AK1nGNyyy/aSNZqVpl8bipo6w8HKsfrXqWRZCHRFba55xLG4R1lpVvUMVNtGL7dBow9jx6RNIrJagHo9ExcSR8Ku/T3YcLFORaItZMF0DiW16ZwWhGVJBBHvDzPxDMzT7+bw2TChcyrx+bP3NWz5E4GQN0ZcsorwsmvroaZqQO+oWSqe4BEx4swy3KW20QXUvh/Geu6SUj64+Q5pUSBt+S8F/GCgpU8NRuKZtP2RgJc/Omq7FRxw1WG/7a8X2godUZpSwqDlCNLsUKMhnFsOWkOtuzXPIZntGz3i8I3K0Tl3gCpzXL7kxSyWy4+NtbZzLChGZY29EY+AN9Dk9w+sGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(366004)(136003)(1800799009)(186009)(451199024)(12101799020)(66946007)(82950400001)(86362001)(55016003)(66476007)(7416002)(7696005)(10290500003)(33656002)(64756008)(9686003)(66556008)(76116006)(478600001)(8936002)(38100700002)(66446008)(8676002)(110136005)(54906003)(52536014)(316002)(41300700001)(4326008)(8990500004)(107886003)(71200400001)(6636002)(921005)(6506007)(122000001)(2906002)(82960400001)(38070700005)(5660300002)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4pUlT4GXE1We3vK2+LtPW2N35wuyYxcqNqRmccoNHcE7DfLBG1nCGZLwHWci?=
 =?us-ascii?Q?E3TBDGbpeuEekYxpcTQtfyVZikYyF5Z2KQ1k3tTEhUqZZ+HiopuPO4ux8QKW?=
 =?us-ascii?Q?OK20hDDXtC9jbrtdEgieI8J68IsZ6iPM+47PY0hobhli0TLSV1A/UkLnReI0?=
 =?us-ascii?Q?K8oaIrNGNUDzUg+aOIiSzI80TUMHI09iXbtzRMt5EQks8oaXcA38NYGax+N6?=
 =?us-ascii?Q?JSPb3cUyqyFrueKi3P7RCmivGeVOmZ083IgnCE+N8v2Mgq0mWBhRqcuvJvoM?=
 =?us-ascii?Q?kRwRcYiG4d+AiXM123Y4E2bgzN7Q8umaa6xBlyTnjBEQSa9FDoYbwyt2qawg?=
 =?us-ascii?Q?hVO8/jTfyoB4PY8OUyzTM6Vq8BsqxtIFOzNrsm6XwZRg82LkjuHd0Bq7yU/q?=
 =?us-ascii?Q?WYYR4eUPBPataxqRH6bGWIooeHcOlHegP/SAOGIVnS+OjxwG+amKMVazEuSc?=
 =?us-ascii?Q?aPcFmiW0KTxhfJLCvyp6EDk4V18F6WgpVNXllnQu1fFDpcwPtQDoeTK3LLJ6?=
 =?us-ascii?Q?y8ogY0gRpbpsYLugPD1zVziQspHu4mxlB+xhA8jf9dkRD0hYrJCvMC34IoTG?=
 =?us-ascii?Q?JvHexm/GvfCdRh/dKpeYtTykZPy7P5xGIznyVlCwB3WiHhEB5H+l/9cjssgk?=
 =?us-ascii?Q?N2TqDE3K7LhD557VSN9LowZS2jiZWxrNI2MPip5W8M7SOcMv8GVKDGsitkrE?=
 =?us-ascii?Q?/jCFvqKk+T8NauP8EHZehj5P8DtdzSyvQ2qiIHSNLxmJ8HpYQ01Mw/nQxESM?=
 =?us-ascii?Q?7s6ocDOh4LrsPXeOoSpgY3QoubunPR+aP3kgUZ3RNZnfEXcTHdz8U9rQrk5B?=
 =?us-ascii?Q?LwNwMweVj18LmPLEaebXvTudZOeQc8f7lE0lXzzdIn0PmbZg+4SIhLMp2JEg?=
 =?us-ascii?Q?SZHEea5vWMNpJ3Zxbrmm52BETAkDEC35AjW5nHtthFNSOQrc8QXPRhyBEVmy?=
 =?us-ascii?Q?m9M6TRU1aLhGqMeqzbzNzKuPEV3/owfdXslmVt8RWeXek7K7WJPADGveER6f?=
 =?us-ascii?Q?HmvurKtmDY0f+y9mwLc2PSH0V1WiBO+aXxtn9WHsjdu23KDt0siC9CxjdrOp?=
 =?us-ascii?Q?i+ofgXmNYgHyzBu4sdDlXWzijqnFxF7vnbqscRfhOl/xeEPeUmd92VEogHSD?=
 =?us-ascii?Q?mRqLso12ms1Ohc+A9I7g4Zbc357mxedObY3TZrKkFrgtNv73lbqoAz7VUqut?=
 =?us-ascii?Q?yrYyRT3laRHv43m16O+AO45EoIJJcEwWTqnSrF84/FQwXDkr+bEyqfr1KsVJ?=
 =?us-ascii?Q?5kgUdPeI497e8Ym9xKLTEc0S9EV2N6S2quac+o1PJ4ryzL/xStiDc6WJveof?=
 =?us-ascii?Q?uUNnJqCAm2bC9K6YFSrCY8ZDyCsOryDICIMi9NIztpi+dXSg/dIA/MTAx5FG?=
 =?us-ascii?Q?0K3S9U/teaYZth77XGX4zoFudV+6lURDH/Ln7HwXCjOO9lbR5WmJWtZqi3+1?=
 =?us-ascii?Q?T73UB2ayK9bw9e7byIa8YEop3/db8maXgryhJ63TA2hUKoFf822tJmkkmwGO?=
 =?us-ascii?Q?kOsQ7t59w5KzPsjGm2Y2Jvuads4Fzi2W4g6lw6VoJRBF2ePGzJasxa0csHWt?=
 =?us-ascii?Q?hJvj3n9+3KOsCFLq+zLNfz4fuXFEiNyRFrJzxJ9e0BKn8/8md5o4C2Z8QU64?=
 =?us-ascii?Q?v/ZnceGlO/nEFZdcW5emDhs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9690ad7-02ec-4acc-5f4f-08db9e9327ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 19:58:26.6141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PTKzHu8IByC0mg4i9/VDv4R1a5jLBWg+6xgEkD4BgSDgcgMzJb9hXzycRLamHQSqTk99xYGA/6o64/i6mQn6zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3743
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Wednesday, August 16, 2023 8:59 AM
> [...]
> hv vp assist page needs to be shared between SEV-SNP guest and Hyper-V.
> So mark the page unencrypted in the SEV-SNP guest.
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---

Reviewed-by: Dexuan Cui <decui@microsoft.com>
