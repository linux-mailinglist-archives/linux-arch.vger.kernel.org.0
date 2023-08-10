Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A287783F8
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 01:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjHJXML (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Aug 2023 19:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjHJXMK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Aug 2023 19:12:10 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021023.outbound.protection.outlook.com [52.101.57.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1472D44;
        Thu, 10 Aug 2023 16:12:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEKpAxvZ6pP04K9Qs73ogsjC1OsIVvL4gU0ABRvIbgEm9rSIO+bizX639fG93YNxB8OPGBuuajuLXgNDs4G5l+pjVSf/g9RpoL6Of+SHW4Cvj4gaL5gT9Hr7w4Q+5958L+SbJF+dKwEBDWI73KVNmihQs2+LZk2J2EKsU3EElJo9aNXjk5nor8hufMZNHoWKjhl5rzkQWU5crPj73mOgL1JdTvyWULuKRFmWe3UbsqCdXn+7DpRjfqahSuHHi+tZlbxsma8ZLqCbpd4u+K+ARqxK+bnReL7jmAIMZycIDFmgQmWE6BFy5BllAm8+zfr3mlFJx1ifORQwPfC+vAoq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9L/f919RrVZ7NdXBOF1+S+mj3StTN3K+4hg3X03zQEc=;
 b=T9GUVJnkWYpw8Ddswe5k4OfoBxBwFpgiKaZ2KIcwUfBuyXZ+liUVM8Gt9FPbxfMx/GtFMLPTKW3C6h/6JL6yOx+IiDsvh8HPtUIFZ2bTfH+1wdJzGiO+WXpw+iYqHN5cRni8rLOAxhFBPXWdPPi4wM/zSp2ihxKDfG1A1WYT997v6tSN7tRrclv6yeOQ1GhE0aSvZzq56ocJGnPIwzo3OEW2UAkrGFN3zc5Ud2rKuX9Iaw5ZjqgGiNgrPPcGZAArm+4dBiX22hSZl+aB/yj/M63Q7YdZUvGlunILRI0Zjo8neBOAo60ris9ouJloBPrqzK7h2cvnSynXcEBZFHx6dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9L/f919RrVZ7NdXBOF1+S+mj3StTN3K+4hg3X03zQEc=;
 b=HoARCBgZozMAyZD0mIjnzvDLhBSWEMICSKP42TxaOWx3N1/ys/WXpeNY46pvXRr2kwhkkHHmE6lmfkwTP/R7gnjLvhlK1fFupaQF1Fxu82cjMaQqe5fSdIk4OGgoum+GBHnmW/t/SupZBUHh5yWMvggFVexmd4bGwACwBpIGlLA=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DS7PR21MB3151.namprd21.prod.outlook.com (2603:10b6:8:7b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.7; Thu, 10 Aug 2023 23:12:03 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870%5]) with mapi id 15.20.6699.004; Thu, 10 Aug 2023
 23:12:03 +0000
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
Subject: RE: [PATCH V5 3/8] x86/hyperv: Mark Hyper-V vp assist page
 unencrypted in SEV-SNP enlightened guest
Thread-Topic: [PATCH V5 3/8] x86/hyperv: Mark Hyper-V vp assist page
 unencrypted in SEV-SNP enlightened guest
Thread-Index: AQHZy6RawUgv+4tcV0WfLxaLQTtH8q/kKMLQ
Date:   Thu, 10 Aug 2023 23:12:03 +0000
Message-ID: <SA1PR21MB133501D70D1FFA8F51FEC106BF13A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230810160412.820246-1-ltykernel@gmail.com>
 <20230810160412.820246-4-ltykernel@gmail.com>
In-Reply-To: <20230810160412.820246-4-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b106d3ac-21d2-4c08-93bd-cec5d9a15825;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-10T23:11:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DS7PR21MB3151:EE_
x-ms-office365-filtering-correlation-id: 421ee467-f62d-467f-4be5-08db99f73554
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jwAokuiZ6y9tFFtreuz+7FZAV6YSpT7/FeghWg0Y4ANG2nbqIBmwnpt4gSqX4TeEwQek1za0Atblr13+85yYl0rg9MjskkwqdwYU1tkFdXWm8xP/mSDq0f/o6/L36xx/RP2OdI2GrGNsniIiJIGMzsZ+aTQkQmxTs1kkjquR/H8Mt0UoBWnhKI223C/hclGftpB4AHuZZzg+XzJ2phkCRaWBcgEPgda90g+QTxc4k9LPOksHEgEGCGxQ/LGFAu4whFaHAmUtN+ee9/GLXRHWTWOex4TTH0eDWPQcidbpPB/Rm+PhygLWMxLk84z3O8RdGH1hk4juia1h/DoxeaVpluMZLXIScZFmC0J5ou+NR5tx4Rokw+uzQeyNQ6orn3mKtJTpUwTruKqWZhxHl+xwynfMNoozxQbtU/xrfoBjiGMiNm8iFfe+R7ud/zowZQmwQ0HS0L8ADY02OOB3yCLLxRDMrVUdmRISHzdEYuz4bcrh4SVHSf/Cc2Y8ZNrKH2Ztrw+2NTXjnVYR1Wp8g+s1gujjHIR6V/QtMNcuZmyY+PcCEdd85Xfm9GDS/6mPftSONwl/wW4+gV3/I/isZ9CKVnnX5YAlOGUz8QHWbSQVwwXPyX9tNi2hg5cxcI3iDUpchTS6EoTWwKYgCEhMfJmmIMroyiTn/lJfd8T8Za4Z7G+2LXDij4+1T1Y08iOQ4NSVbZQR40QK7p+EpdCEmCTVVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(1800799006)(186006)(921005)(55016003)(8936002)(7416002)(52536014)(8676002)(86362001)(107886003)(6506007)(558084003)(26005)(2906002)(33656002)(8990500004)(38100700002)(122000001)(82960400001)(82950400001)(38070700005)(9686003)(7696005)(71200400001)(110136005)(10290500003)(478600001)(41300700001)(316002)(6636002)(54906003)(4326008)(66946007)(12101799016)(76116006)(5660300002)(66556008)(66446008)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BCXpYos5JkQ/EY1HAe6txOh9QsDS7sXE8LPuJfRyRMSH2DdZ+oCbLhdDPHcA?=
 =?us-ascii?Q?fWNoZjFbehGGDe776L3mvBgyUag+smeqKQNGYvJOwx/RaBJm6ydrRJy9hX14?=
 =?us-ascii?Q?/fNODNiHIF3BsdiZ0MGSD/3qQyCwSRkzJBZ/TsasQFnzdmeXqZ0XhRwGPdV+?=
 =?us-ascii?Q?RrvgqX3HAgeeFkhFSrvr17bLNqEtDcIBdXYHkWEbFUw3VAseqMmeWzCCNzsm?=
 =?us-ascii?Q?z5Nm4WzAmKb7OLuCG/swkfEVEgFANhV5XnwQ7U4VQHlhiAPtcivNRar1kddg?=
 =?us-ascii?Q?83+rusXBdbh5xdEqIH56AVJfq2wEagmaNrYY5TQzD4Th+jSHiYo0olOwSywN?=
 =?us-ascii?Q?CXmBexbKTzClqehBZLqDDLkwtYK+/2cE615sTvyer873kU6giI1K/OE5kroY?=
 =?us-ascii?Q?J3E6Vt+h5Z4TPIu4Bticxc2jmIEB8nnZp6svFy4u04IzR9xzSr0Hp2Ot+T08?=
 =?us-ascii?Q?oOLyctauyu/GXSAh293O1T7Y+vE1LvgGHOAA5JkiIH34yQPK1k4PDlRjZbvq?=
 =?us-ascii?Q?OC0Hk7Z4wfyrKYAG9sjfBxqPLRy0ukEQSaSsLQtPfrhF+39AHlCPJPQi/b/E?=
 =?us-ascii?Q?S+9TsACglejUQJSUeQ5D45UZvySeYr9Xt+d37g/LBwu1kq3Pmz9aNb/bSgPX?=
 =?us-ascii?Q?skecdXEAV6qtuzWGIF4khf2mZsCu6bNXwaE/O84mZ7d1ci+m0wf3x91x4a/a?=
 =?us-ascii?Q?FDwltRrprWqsTOjf42v1/r9C+dDFREE1kbnjUneZQcwhzuSXFP5hG0P4d2JK?=
 =?us-ascii?Q?qaBH2TGaUCYYLn/z3ot+zVMtEYpFRr/wTbSWFTrLKZ2hOX1afA+JdEKDaFtK?=
 =?us-ascii?Q?4V+8I0xPCNzogiMMsC0kN0FFzRM+cXfWj8FVg3N6gxWzQiDRkqFwJZ4epYEo?=
 =?us-ascii?Q?WcY0o2/LvKosIwHKxk+kpJgubaW26B10oi18wpjJ87M6mliSDiGv2vnjJkx2?=
 =?us-ascii?Q?TiAPbMGOldU467w785rWce6eigtCfJNxVYBOjznIRPwBJTrLY92DOcPEQFPg?=
 =?us-ascii?Q?zmusy476da8uhMqQuhoYktoNqK/1ikp1BZvDECBbWmPr+YLC+IXKPxc4I6E1?=
 =?us-ascii?Q?Mo+Buex++py6XUcBHMvG+pDgMEFXPh5SnNbsRvsh7LDdgu66M3WHKZkb1SWk?=
 =?us-ascii?Q?SXA5eMsttXFDW/hjEq1/VkOWbFmSwzFbIAKj55DekmFXECFvljMnoYi8eROW?=
 =?us-ascii?Q?lIyGf3ED9Nt17ho8qRtip3FyEso2Xb8wCENbpcAlPNxICoqZJ3/FEaEQM6Kb?=
 =?us-ascii?Q?eZM5cdq738B9DQkqM20/Y6KhStPb11/5tQSuxCUZxLWQ+URbzyY3T7Hq7kHv?=
 =?us-ascii?Q?RlKrkmAmcXDyvRz4LgKS4jTgUgYHQl4G9sNIY8vUX4Pa28vZN5Rrm0U3/GHg?=
 =?us-ascii?Q?y+Qe3avFii5On20ykiI7oiEGYSJbn2x64Pmkv9uKhbh8ObPGWW2OyB54f/SO?=
 =?us-ascii?Q?au3NespaYb2hRAscyxAESkBr91yrItHrD5wUrXqvXjy1ohXCFo+79z2YUmW1?=
 =?us-ascii?Q?K8BKIWY1jPFOYMBIhSRAxfKF6hr8hCdi4H6QMSFDtvYYBxE6xDoOBqm2lSga?=
 =?us-ascii?Q?mOb4NHLTbbGZKanY/WwrbKN9bKE4bgNCUH/5syHT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421ee467-f62d-467f-4be5-08db99f73554
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 23:12:03.3577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZ+KixBuSCCMxtq3hUFa5du/t36LSy5h4vPw75BaiNZdlSs0kfQ+8kYvLYDC9Ah6tV3UDORWnmCuUEcTKUDauA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3151
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Thursday, August 10, 2023 9:04 AM
> [...]
> hv vp assist page needs to be shared between SEV-SNP guest and Hyper-V.
> So mark the page unencrypted in the SEV-SNP guest.
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>

Reviewed-by: Dexuan Cui <decui@microsoft.com>
