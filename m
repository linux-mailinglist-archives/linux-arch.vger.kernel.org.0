Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BA17DBE2A
	for <lists+linux-arch@lfdr.de>; Mon, 30 Oct 2023 17:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjJ3Qm2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Oct 2023 12:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjJ3Qm1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Oct 2023 12:42:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5F8DA;
        Mon, 30 Oct 2023 09:42:23 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UDkwq8002791;
        Mon, 30 Oct 2023 16:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Z2jXVO4hl1wrQB3bDyl9yo/p7WU1EngbAiRM1KEv51o=;
 b=vuSZeLnv750kbKLUpmX6fI0yeuEE3BvaK32K1qBo8jS8IYhLJg4d8fAV3xmwgZ49lhtw
 SwHZCHIbxdkct65wGl/EL2kAKTRKKNK+wJRAF5PfwAATOM+0uxUtVAY8v57lsMjvQqEg
 GQJzWXyv4W3VAWgrF2q0KBLry/TjPKmdUaEQy2abWmSi0gy+msu2QRfPDuuGsIai7A29
 16VkIHqnwy6hsMKx9NgRjgFMQpbVHaoEUncDOigLYmRxaQl06w0gt3oegQipFke6IlBW
 rvjjDVsIY1yzns/PduTjYWKtGyLuzWi5B5jGuugTqrDts5XFcCe/b/U0p7N2BOh0xEtd yg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tuub5gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 16:41:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39UFZfWQ020095;
        Mon, 30 Oct 2023 16:41:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrarn34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 16:41:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0yxAtKmxsvBOGnVOpDjX79laUscoDIGb15KM6WwddfruIV5oA/PUVbBLmWa6YcjjKtuLOFN1L9JZ6dIxO0dkr1g4WUPVZnoRPoROmQaD9GD2r3VWR84jupT4Xlocdj/R1hY+QldMWb99UR2d3wW4DdGBFN8oG2fUObfgODqO7dYvSnvrCNnrqqzWX/S4I6a7koKo28sJHJ3b1fvmI2jxIf4w88FxzYHXJqlzpyKZjG8jNIjMLp9EbSRmGB1v6JsikmuvtNv1cmU/d6bevYhDyFBvxsl44B4dzk1nsvArIdzlxMuOIPBSz3Qo/RB2u4lH2ovWJa2ZW+aE8seGZV6Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2jXVO4hl1wrQB3bDyl9yo/p7WU1EngbAiRM1KEv51o=;
 b=EL4b730S3olAcYWje170TBNb7f57T0s5YAFU8rtdfpPjl2xNK2HNWSMtQ80IFD1h59riwTJ9/3neT9c/Fi2wUHiJcftxyoejLFfkBL9suT34VW5zjeSoLfNredibdlq28ptTJvMg35DdtnnXw5hWvwD871Vy4Ev7xiH/eqxeXd2f6oO8dW95wYydu/k0Y/mU6L56jxpC6cx/7GqXnEpTW76KTPpQPHXzShxtYVrOK7Y1MVymw8MlNL/AKdTRLcUl3IutUShnNO47qSXRYJU3ijGTSwjTkA0GtVMt8jMdNe4zt4VseEZSCkmSNMx2xrGlENt94hvIGF17YOjwK973xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2jXVO4hl1wrQB3bDyl9yo/p7WU1EngbAiRM1KEv51o=;
 b=ePtdatU17WLevJcB8gCokhQKKbl/G1QUi/t6owhs/sO642ulEwbcB4lzLmkZxUS/GeR0Xm/mWSKupLmxgizVbXNtZUSOzYg24qw3T6JSHU3Ccexko94Q3UFoubLXmv3VSgvpVcnD9OBY6You7PE+HTcsOdetk0oGpF2oPbtg/DQ=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DS7PR10MB7180.namprd10.prod.outlook.com (2603:10b6:8:ed::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Mon, 30 Oct 2023 16:41:19 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a39e:b72:a65a:a518]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a39e:b72:a65a:a518%4]) with mapi id 15.20.6933.024; Mon, 30 Oct 2023
 16:41:19 +0000
From:   Miguel Luis <miguel.luis@oracle.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>,
        "acpica-devel@lists.linuxfoundation.org" 
        <acpica-devel@lists.linuxfoundation.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "jianyong.wu@arm.com" <jianyong.wu@arm.com>,
        "justin.he@arm.com" <justin.he@arm.com>,
        James Morse <james.morse@arm.com>
Subject: Re: [RFC PATCH v3 00/39] ACPI/arm64: add support for virtual
 cpuhotplug
Thread-Topic: [RFC PATCH v3 00/39] ACPI/arm64: add support for virtual
 cpuhotplug
Thread-Index: AQHaBoz/gz8+D0QBJ0OvgVA5gCA45LBikqiA
Date:   Mon, 30 Oct 2023 16:41:19 +0000
Message-ID: <C2C5C292-AD2C-4D98-8225-39ABE68C5395@oracle.com>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
In-Reply-To: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|DS7PR10MB7180:EE_
x-ms-office365-filtering-correlation-id: 352f7470-aaa1-40b2-e68d-08dbd9670ae9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dtBjv69eHoPZZjaiJQg9PTYHlJJsBqEC8g2tYj4XPow0JwJWvKcPBmmTZYWnUbAXYfppCBy5WwPH/Afg3fj4H2yaVeNeAypJW3H/V7eBzGNDvNaOFDDu5G7HbKhzm+ovsX4RK3/RcQb9kfeulwXdnU4tbgh8epNcICAy12ye1LUwMZIu7sl1qK/c3gN5EVEW3krSya8Fd8SqHlltucKfaWDqSqYj6yf76t/BA/KZOwLgCxpQa2QOOGJeh1KE05o5CC3pN+sKz55xLwmt4Z+sZZo0A4tiOL1XTfuRbacVRLAPOThqIhw10zyuForoAES3lR4BG8rUOzeC4aWlqAu0XdcflJtvjUIRCO7PxuesZEfor0E1owwWkIycwa7XBGgnBRv2Ioy2DyOTDMRt8fyeiqn4Fa5mN79ZmC4Jz58OBOJBbC08d2GShUtVH5FZLq08Bw4S7z7hlRANc9qnGF6Tn3tHJpHtLQP52a4/ePoqPbmd6oxPy/meSjHDFDJ4ZewsI/yaULFkFpaBcM77fNfH9FUENmFVPPpwuAZZ7YESkRLeBKx+MvH4sQSSYHrTdqHJ6jzfIFszM/T3STuBfbes7AzZrj+2tKIgPL1OfJHyzGAxlSciABz63m4o40F+2hWOPyJAZsO5t+1ZKLXDh8qS1aUdu/5UrGfMqWI20W0FIYSvOl5rZKLy/oiD1BMLxK2OPvkvBjpjY48AeBWwcbR0Ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(966005)(122000001)(478600001)(6486002)(66946007)(53546011)(71200400001)(6506007)(76116006)(6512007)(2616005)(54906003)(91956017)(66446008)(6916009)(66476007)(64756008)(66556008)(38070700009)(83380400001)(38100700002)(5660300002)(4326008)(41300700001)(36756003)(30864003)(44832011)(7416002)(316002)(33656002)(8936002)(8676002)(86362001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QXgY9ih9Ftv/8b63f0a4ww+84RQYt5yMmbEDxcITKrmCipsmbw199LZoGcS/?=
 =?us-ascii?Q?pO8ujvj4fdVs4lVM9Ne0ogc6IWOFz47kuerXP2DWDq68nL+jS9B9r4ywLbUw?=
 =?us-ascii?Q?ZeNMRR7t5aKKfgWbPSNW0hg/I+kvjp0e0vm388HZ/bJTn0BZQGvrL5kZ0/Br?=
 =?us-ascii?Q?/p+gXcrEPKAX/h26Mlwlyq2UqyvkCW/0OLMDLn8qmVRsWo4PVNPQAUZ5ky2F?=
 =?us-ascii?Q?J83S6a0x0DuyxJ5RNfp+PERWS7wBuS101PVEw5bczgpfNkalpfuRVKcerpO6?=
 =?us-ascii?Q?Xa7JWnCyEYUf1KJs0fhcRNz4mt7BIarNg3uDMOMnrG18DIYYr5x9TTd414+Q?=
 =?us-ascii?Q?2WcDTGZE+wflYeusnWfyNQLdjGYVl1VGHaZL9Qu7LK2tUnp1jdvst0QVaxSa?=
 =?us-ascii?Q?/RbbskgbhrnREaJ6V0Usm4IuiVj8STeDTdi3HiyJSPNoGpb/qui+g/pjEAmc?=
 =?us-ascii?Q?ihvF9ob19ZcUMKuKmwFhabkuX3r+xivdtHCQkYfJ3rI6fdHr3EoBsx5Q82TF?=
 =?us-ascii?Q?y4X6Dp18XuNVVwl/x5nTJxsC5sTB0OozSdiTy04w3lEmdiChIWXdNopJ1EUO?=
 =?us-ascii?Q?+RuLp+EjyF6Rc2iOIfJrC2pYYDMif+ggRZ8WIJUuVScMIfBbQCgvwB4+O13O?=
 =?us-ascii?Q?vh+fPIJzySWWQYNv2hsbeIe5yyQVb9Pbe9RexUPFTzTSGItdqto5R1nXYSQ/?=
 =?us-ascii?Q?QLpyQNmxol4SDcJQulukUdxavHgyC6ar513s7yREvpgwOe5XE2ejkM6TLsR9?=
 =?us-ascii?Q?PRD/hV3XKk5u03xu2XkLjBx4FCJrDeLYjj35qQBkgnlbn/tes1vCOayogJLI?=
 =?us-ascii?Q?YOI3n8S0duiFOAf2tn0ZZ4HSz5VLXNYbhM7c1berX9YAy3GSJGhZlC6sW0pl?=
 =?us-ascii?Q?kWVDH/Y9eFJ3B5K9vr/PLC1wOwybyD7kX10Q6LthhTWszDbAxZ7Yeb9SvF7e?=
 =?us-ascii?Q?F2KUrPHTikR6MZNErh7h/e5+51AAgqXKtng0TRKGbsy4fUDvkRCz5nk5/pWx?=
 =?us-ascii?Q?2s0guyxMQClVxG7kLRwNEc/oFx8c7IRVy1VDcqm8YZgb6qC3pbO/62TeghpB?=
 =?us-ascii?Q?lutE7ZgcvDMk43ylhgxHYeoTK8o9RbSDa7bU8qOZtIuSr7WfojyXDHd+2RSM?=
 =?us-ascii?Q?Vctg01BYfpnS1bYtEVMO70NKd4K2AIOxQkeHo1VKAXoYSV/xkLZmmkHcM8KO?=
 =?us-ascii?Q?EglFKvvku/mI/jU2kDNGA0pbGBZ9FL5OXp8Z6LMiTRWI9lAr8TE0C5km2VSi?=
 =?us-ascii?Q?ZeWMe3eK9AqP/r2aDOC+LI/nhBldsE2C2rOLh0AiTd+swftbixD3NbE+6Lys?=
 =?us-ascii?Q?1xFqEhAFacXimJ06zhhWpHpZ17m8gQDzWHyNg6K7IkyXVPwerTsNVxAjIeYe?=
 =?us-ascii?Q?TIhyIUdkVD0o6seaRLaoFnketZL3VdqPD3qe+fsoBjDC9qj4z1HqwmwjCyGq?=
 =?us-ascii?Q?ruza6SAvSc4QPNY4hunOh+CDeK5Ie/U4lsPxQS3UZAn5OeeFbTFbmRs10zeq?=
 =?us-ascii?Q?3/BbSpKjqWhVQ/vL8Ijw6TRWoDnLuk0X63x0eboHLVlHhtf4qgIF2bvCPuHN?=
 =?us-ascii?Q?FRT+mJqGoXOizpN6Vs016RuYBlOKYB92rKkH2fDoWvHF9bVCQa0BPtxFxF49?=
 =?us-ascii?Q?8/Fdd0RCaJ5U7ylzafuOj/k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1D5E7B22C1FE2F4B9D62B2D8021B6A07@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GhcxK5xlxUeR8vH6droezNxOUZZxsO8uhf5VzmFtZj00ROmukbNNi9d2pNX8?=
 =?us-ascii?Q?kTjJNKBFZBBDGj3FTkBMCfPxbvGd7soK5wJWo0br2aM0H5H1csV4TjYgnXVl?=
 =?us-ascii?Q?pomOMbaZBIM6XxseP2P/GGSC/1ZPeRxpZ2Of5n+mn4jfRqqzPvc1JseSAlOh?=
 =?us-ascii?Q?yv30PiwBvs9vLGJMmc16C2Uwj14fhZ4VVOVRHtrpqRcMzWST/eu6KpNH/5cd?=
 =?us-ascii?Q?SWLfiX/dZSbff7qaNTJ4TrTEHNfhxhkcEVP+IwPWZfh3/aTB5rofaWx6CBlg?=
 =?us-ascii?Q?mxaO8oqo8QHJAtWbyKQnBDpB8ilJ4o+JO8De+H52Ye4+DI+opMk8SWTEH3ic?=
 =?us-ascii?Q?BRuBwSjZFVcLOSS7zSlGWG5Gfj7qiTa6O9g5ZQrMfpoWU3Rzd8Ik0V/i9/tJ?=
 =?us-ascii?Q?3Ea0yeZStthukYD8CZ+JWwkyX+0g9olPECWMuFqucF880dQmS/z/TRl5cGWD?=
 =?us-ascii?Q?lPvOZ6aB/ZFi2APm3rt6G+cZSasnU1a7pyVqGCk3nNB2q7rBXI9/BF1n4vZq?=
 =?us-ascii?Q?XQulcfYzp2vX+RXwUuutP3mNdheAiFb4qhFzniOvyopXXlWQdtNbSlpGOnJY?=
 =?us-ascii?Q?5qlJogv1E0AeXzLzjuj9ArdklH+D3rXSgUUIJ4By1Yb05aU/5UDZ/aAvyaX4?=
 =?us-ascii?Q?WUbKR6J1NwjdqDVF9h5Huqzepelinqd6Oa1p6CXRuZrOTzuByT+nsF5e9SwR?=
 =?us-ascii?Q?i40k8BOeRPC64cvwmkcXOHiAB/WDRBeoZu7WitXw8xb5gwiRz27Br2yxVPyb?=
 =?us-ascii?Q?+fn4FYQwyoGZSnxRrsr7WhxqlFC13HHyLWtQ1VBNqZTTVCTmFwHAdgGzYJjq?=
 =?us-ascii?Q?zJpaUvsrtmdgW5m4oatFF4tsuYNGJ/CBQt3TT6ZsmqRYBeONEECeOpF8wzj1?=
 =?us-ascii?Q?XJM9/kzNjrMY2vMij8fBOBdjb6//1AYV5ZFUWsMZ4g4Gg4uKiBWQgqmaqoL5?=
 =?us-ascii?Q?dRgkRhH/SCiqadMKIivnlUi+E+NJwBWClCvcIr87xFG+Mpszj6kOo279V6LI?=
 =?us-ascii?Q?000BN/TInnoEM4KGaWPnGJ9DAV7x5HG8XCYtdKH68IErAQEU3NJgfJVFpyIu?=
 =?us-ascii?Q?SPmFbQ9Sy+CkUKLKf3t1QR641VybPw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352f7470-aaa1-40b2-e68d-08dbd9670ae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 16:41:19.0930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o2OBiepMl9gtSHV77l/iEbSw9BnGPVA4G78hxwGwFoPJ6uLmGneBYhFzUvMMZFxfnang5Vq77WqYq9hPckc+9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300130
X-Proofpoint-GUID: ucOdzP0fhsH5nETGQyZRU63BYmvaVYwE
X-Proofpoint-ORIG-GUID: ucOdzP0fhsH5nETGQyZRU63BYmvaVYwE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Russell,

> On 24 Oct 2023, at 15:15, Russell King (Oracle) <linux@armlinux.org.uk> w=
rote:
>=20
> Hi,
>=20
> I'm posting James' patch set updated with most of the review comments
> from his RFC v2 series back in September. Individual patches have a
> changelog attached at the bottom of the commit message. Those which
> I have finished updating have my S-o-b on them, those which still have
> outstanding review comments from RFC v2 do not. In some of these cases
> I've asked questions and am waiting for responses.
>=20
> I'm posting this as RFC v3 because there's still some unaddressed
> comments and it's clearly not ready for merging. Even if it was ready
> to be merged, it is too late in this development cycle to be taking
> this change in, so there would be little point posting it non-RFC.
> Also James stated that he's waiting for confirmation from the
> Kubernetes/Kata folk - I have no idea what the status is there.
>=20
> I will be sending each patch individually to a wider audience
> appropriate for that patch - apologies to those missing out on this
> cover message. I have added more mailing lists to the series with the
> exception of the acpica list in a hope of this cover message also
> reaching those folk.
>=20
> The changes that aren't included are:
>=20
> 1. Updates for my patch that was merged via Thomas (thanks!):
>   c4dd854f740c cpu-hotplug: Provide prototypes for arch CPU registration
>   rather than having this change spread through James' patches.
>=20
> 2. New patch - simplification of PA-RISC's smp_prepare_boot_cpu()
>=20
> 3. Moved "ACPI: Use the acpi_device_is_present() helper in more places"
>   and "ACPI: Rename acpi_scan_device_not_present() to be about
>   enumeration" to the beginning of the series - these two patches are
>   already queued up for merging into 6.7.
>=20
> 4. Moved "arm64, irqchip/gic-v3, ACPI: Move MADT GICC enabled check into
>   a helper" to the beginning of the series, which has been submitted,
>   but as yet the fate of that posting isn't known.
>=20
> The first four patches in this series are provided for completness only.
>=20
> There is an additional patch in James' git tree that isn't in the set
> of patches that James posted: "ACPI: processor: Only call
> arch_unregister_cpu() if HOTPLUG_CPU is selected" which looks to me to
> be a workaround for arch_unregister_cpu() being under the ifdef. I've
> commented on this on the RFC v2 posting making a suggestion, but as yet
> haven't had any response.
>=20
> I've included almost all of James' original covering body below the
> diffstat.
>=20
> The reason that I'm doing this is to help move this code forward so
> hopefully it can be merged - which is why I have been keen to dig out
> from James' patches anything that can be merged and submit it
> separately, since this is a feature for which some users have a
> definite need for.
>=20
> Please note that I haven't tested this beyond building for aarch64 at
> the present time.
>=20
> The series can be found at:
>=20
> git://git.armlinux.org.uk/~rmk/linux-arm.git aarch64/hotplug-vcpu/v6.6-rc=
7
>=20
> Documentation/arch/arm64/cpu-hotplug.rst   |  79 +++++++++++++++
> Documentation/arch/arm64/index.rst         |   1 +
> arch/arm64/Kconfig                         |   1 +
> arch/arm64/include/asm/acpi.h              |  11 +++
> arch/arm64/include/asm/cpu.h               |   1 -
> arch/arm64/kernel/acpi_numa.c              |  11 ---
> arch/arm64/kernel/psci.c                   |   2 +-
> arch/arm64/kernel/setup.c                  |  13 +--
> arch/arm64/kernel/smp.c                    |   5 +-
> arch/ia64/Kconfig                          |   3 +
> arch/ia64/include/asm/acpi.h               |   2 +-
> arch/ia64/include/asm/cpu.h                |   6 --
> arch/ia64/kernel/acpi.c                    |   6 +-
> arch/ia64/kernel/setup.c                   |   2 +-
> arch/ia64/kernel/topology.c                |  35 +------
> arch/loongarch/Kconfig                     |   2 +
> arch/loongarch/configs/loongson3_defconfig |   2 +-
> arch/loongarch/kernel/acpi.c               |   4 +-
> arch/loongarch/kernel/topology.c           |  38 +-------
> arch/parisc/kernel/smp.c                   |   8 +-
> arch/riscv/Kconfig                         |   1 +
> arch/riscv/kernel/setup.c                  |  19 +---
> arch/x86/Kconfig                           |   3 +
> arch/x86/include/asm/cpu.h                 |   4 -
> arch/x86/kernel/acpi/boot.c                |   4 +-
> arch/x86/kernel/cpu/intel_epb.c            |   2 +-
> arch/x86/kernel/topology.c                 |  27 +-----
> drivers/acpi/Kconfig                       |  14 ++-
> drivers/acpi/acpi_processor.c              | 151 +++++++++++++++++++++++-=
-----
> drivers/acpi/bus.c                         |  16 +++
> drivers/acpi/device_pm.c                   |   2 +-
> drivers/acpi/device_sysfs.c                |   2 +-
> drivers/acpi/internal.h                    |   1 -
> drivers/acpi/processor_core.c              |   2 +-
> drivers/acpi/property.c                    |   2 +-
> drivers/acpi/scan.c                        | 148 ++++++++++++++++++------=
----
> drivers/base/arch_topology.c               |  38 +++++---
> drivers/base/cpu.c                         |  44 +++++++--
> drivers/base/init.c                        |   2 +-
> drivers/base/node.c                        |   7 --
> drivers/firmware/psci/psci.c               |   2 +
> drivers/irqchip/irq-gic-v3.c               |  38 +++++---
> include/acpi/acpi_bus.h                    |   1 +
> include/acpi/actbl2.h                      |   1 +
> include/linux/acpi.h                       |  13 ++-
> include/linux/cpu.h                        |   4 +
> include/linux/cpumask.h                    |  25 +++++
> kernel/cpu.c                               |   3 +
> 48 files changed, 516 insertions(+), 292 deletions(-)
>=20
>=20
> On Wed, Sep 13, 2023 at 04:37:48PM +0000, James Morse wrote:
>> Hello!
>>=20
>> Changes since RFC-v1:
>> * riscv is new, ia64 is gone
>> * The KVM support is different, and upstream - no need to patch the host=
.
>>=20
>> ---
>>=20
>> This series adds what looks like cpuhotplug support to arm64 for use in
>> virtual machines. It does this by moving the cpu_register() calls for
>> architectures that support ACPI out of the arch code by using
>> GENERIC_CPU_DEVICES, then into the ACPI processor driver.
>>=20
>> The kubernetes folk really want to be able to add CPUs to an existing VM=
,
>> in exactly the same way they do on x86. The use-case is pre-booting gues=
ts
>> with one CPU, then adding the number that were actually needed when the
>> workload is provisioned.
>>=20
>> Wait? Doesn't arm64 support cpuhotplug already!?
>> In the arm world, cpuhotplug gets used to mean removing the power from a=
 CPU.
>> The CPU is offline, and remains present. For x86, and ACPI, cpuhotplug
>> has the additional step of physically removing the CPU, so that it isn't
>> present anymore.
>>=20
>> Arm64 doesn't support this, and can't support it: CPUs are really a slic=
e
>> of the SoC, and there is not enough information in the existing ACPI tab=
les
>> to describe which bits of the slice also got removed. Without a referenc=
e
>> machine: adding this support to the spec is a wild goose chase.
>>=20
>> Critically: everything described in the firmware tables must remain pres=
ent.
>>=20
>> For a virtual machine this is easy as all the other bits of 'virtual SoC=
'
>> are emulated, so they can (and do) remain present when a vCPU is 'remove=
d'.
>>=20
>> On a system that supports cpuhotplug the MADT has to describe every poss=
ible
>> CPU at boot. Under KVM, the vGIC needs to know about every possible vCPU=
 before
>> the guest is started.
>> With these constraints, virtual-cpuhotplug is really just a hypervisor/f=
irmware
>> policy about which CPUs can be brought online.
>>=20
>> This series adds support for virtual-cpuhotplug as exactly that: firmwar=
e
>> policy. This may even work on a physical machine too; for a guest the pa=
rt of
>> firmware is played by the VMM. (typically Qemu).
>>=20
>> PSCI support is modified to return 'DENIED' if the CPU can't be brought
>> online/enabled yet. The CPU object's _STA method's enabled bit is used t=
o
>> indicate firmware's current disposition. If the CPU has its enabled bit =
clear,
>> it will not be registered with sysfs, and attempts to bring it online wi=
ll
>> fail. The notifications that _STA has changed its value then work in the=
 same
>> way as physical hotplug, and firmware can cause the CPU to be registered=
 some
>> time later, allowing it to be brought online.
>>=20
>> This creates something that looks like cpuhotplug to user-space, as the =
sysfs
>> files appear and disappear, and the udev notifications look the same.
>>=20
>> One notable difference is the CPU present mask, which is exposed via sys=
fs.
>> Because the CPUs remain present throughout, they can still be seen in th=
at mask.
>> This value does get used by webbrowsers to estimate the number of CPUs
>> as the CPU online mask is constantly changed on mobile phones.
>>=20
>> Linux is tolerant of PSCI returning errors, as its always been allowed t=
o do
>> that. To avoid confusing OS that can't tolerate this, we needed an addit=
ional
>> bit in the MADT GICC flags. This series copies ACPI_MADT_ONLINE_CAPABLE,=
 which
>> appears to be for this purpose, but calls it ACPI_MADT_GICC_CPU_CAPABLE =
as it
>> has a different bit position in the GICC.
>>=20
>> This code is unconditionally enabled for all ACPI architectures.
>> If there are problems with firmware tables on some devices, the CPUs wil=
l
>> already be online by the time the acpi_processor_make_enabled() is calle=
d.
>> A mismatch here causes a firmware-bug message and kernel taint. This sho=
uld
>> only affect people with broken firmware who also boot with maxcpus=3D1, =
and
>> bring CPUs online later.
>>=20
>> I had a go at switching the remaining architectures over to GENERIC_CPU_=
DEVICES,
>> so that the Kconfig symbol can be removed, but I got stuck with powerpc
>> and s390.
>>=20
>> I've only build tested Loongarch and riscv. I've removed the ia64 specif=
ic
>> patches, but left the changes in other patches to make git-grep review o=
f
>> renames easier.
>>=20
>> If folk want to play along at home, you'll need a copy of Qemu that supp=
orts this.
>> https://github.com/salil-mehta/qemu.git salil/virt-cpuhp-armv8/rfc-v2-rc=
6
>>=20
>> Replace your '-smp' argument with something like:
>> | -smp cpus=3D1,maxcpus=3D3,cores=3D3,threads=3D1,sockets=3D1
>>=20
>> then feed the following to the Qemu montior;
>> | (qemu) device_add driver=3Dhost-arm-cpu,core-id=3D1,id=3Dcpu1
>> | (qemu) device_del cpu1
>>=20
>>=20
>> Why is this still an RFC? I'm still looking for confirmation from the
>> kubernetes/kata folk that this works for them. Because of this I've cull=
ed
>> the CC list...
>>=20
>>=20
>> This series is based on v6.6-rc1, and can be retrieved from:
>> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/ virtual=
_cpu_hotplug/rfc/v2
>>=20
>>=20
>> Thanks,
>>=20
>> James Morse (34):
>>  ACPI: Move ACPI_HOTPLUG_CPU to be disabled on arm64 and riscv
>>  drivers: base: Use present CPUs in GENERIC_CPU_DEVICES
>>  drivers: base: Allow parts of GENERIC_CPU_DEVICES to be overridden
>>  drivers: base: Move cpu_dev_init() after node_dev_init()
>>  drivers: base: Print a warning instead of panic() when register_cpu()
>>    fails
>>  arm64: setup: Switch over to GENERIC_CPU_DEVICES using
>>    arch_register_cpu()
>>  x86: intel_epb: Don't rely on link order
>>  x86/topology: Switch over to GENERIC_CPU_DEVICES
>>  LoongArch: Switch over to GENERIC_CPU_DEVICES
>>  riscv: Switch over to GENERIC_CPU_DEVICES
>>  arch_topology: Make register_cpu_capacity_sysctl() tolerant to late
>>    CPUs
>>  ACPI: Use the acpi_device_is_present() helper in more places
>>  ACPI: Rename acpi_scan_device_not_present() to be about enumeration
>>  ACPI: Only enumerate enabled (or functional) devices
>>  ACPI: processor: Add support for processors described as container
>>    packages
>>  ACPI: processor: Register CPUs that are online, but not described in
>>    the DSDT
>>  ACPI: processor: Register all CPUs from acpi_processor_get_info()
>>  ACPI: Rename ACPI_HOTPLUG_CPU to include 'present'
>>  ACPI: Move acpi_bus_trim_one() before acpi_scan_hot_remove()
>>  ACPI: Rename acpi_processor_hotadd_init and remove pre-processor
>>    guards
>>  ACPI: Add post_eject to struct acpi_scan_handler for cpu hotplug
>>  ACPI: Check _STA present bit before making CPUs not present
>>  ACPI: Warn when the present bit changes but the feature is not enabled
>>  drivers: base: Implement weak arch_unregister_cpu()
>>  LoongArch: Use the __weak version of arch_unregister_cpu()
>>  arm64: acpi: Move get_cpu_for_acpi_id() to a header
>>  ACPICA: Add new MADT GICC flags fields [code first?]
>>  arm64, irqchip/gic-v3, ACPI: Move MADT GICC enabled check into a
>>    helper
>>  irqchip/gic-v3: Don't return errors from gic_acpi_match_gicc()
>>  irqchip/gic-v3: Add support for ACPI's disabled but 'online capable'
>>    CPUs
>>  ACPI: add support to register CPUs based on the _STA enabled bit
>>  arm64: document virtual CPU hotplug's expectations
>>  ACPI: Add _OSC bits to advertise OS support for toggling CPU
>>    present/enabled
>>  cpumask: Add enabled cpumask for present CPUs that can be brought
>>    online
>>=20
>> Jean-Philippe Brucker (1):
>>  arm64: psci: Ignore DENIED CPUs
>=20

Tested on QEMU, based on Salil's RFC v2 [1], running with KVM.
- boot
- hotplug up to 'maxcpus'
- hotunplug down to the number of boot cpus
- hotplug vcpus and migrate with vcpus offline
- hotplug vcpus and migrate with vcpus online
- hotplug vcpus then unplug vcpus then migrate
- successive live migrations (up until 6)

Feel free to add:
Tested-by: Miguel Luis <miguel.luis@oracle.com>

Thank you
Miguel

[1] https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@h=
uawei.com/

> --=20
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
>=20

