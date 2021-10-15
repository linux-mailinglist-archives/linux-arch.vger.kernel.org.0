Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED6442FA81
	for <lists+linux-arch@lfdr.de>; Fri, 15 Oct 2021 19:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbhJORuH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Oct 2021 13:50:07 -0400
Received: from mail-oln040093003013.outbound.protection.outlook.com ([40.93.3.13]:58898
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237559AbhJORuH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 Oct 2021 13:50:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgsK6h7Bd0Y7cbYALByugLmivGc4xUXnAgfFsR/oeOK4fXkik83XZ3Lq9AK7x9vLf5kbjDxOzEitN0REihyWEmAU3EckksFZF46qRFNVOHO78jcaZeQ1K6K/QS6c/KC7S0E7ZMvTb2bH2tolcaI1LbSOa8Mzw1mFA+gsfjFHE3wwXFtoa4uCHtnXZLhBAlvPZbSPuaGfJS0Tna13GLaISCIP4hVESQOGtUJ5NivZqkijS1agdAGhz2eCUR6CvUZX/2s3hN/wV3FiEff8CQ3Tj4LJqddG+ElyK6yPGw6Nca8A0vYSwqj4hfWNyY6strVwQts0dEfD7MzAmQJs0L/55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNd4wMw8xnjXcwNLfCCoSeeRdEq6zOf+HViSasevvoU=;
 b=JVSWfiIeSfWXicPH4Ejf6LArud92N5+oaARISpMYViIsAhJNBPX+Syvbad5e8Gh43DfwhpvIC60IPSUbmACeNotomt5R/6W1iNWwINRdDklmXVSFZGnd4dCqujxjqXlNQwua0wPZbuwED/7qUtz49ayqkgY6AI2HpzVoSVzg4Yx2V+rQ9KdWK169cFDXbc/IjKUmFuYId7JthxU4YJWtx1SySEFXMz+p0C6/R8kg3XDpE8jbUJXuPgqFunPeFjZC9TVvhgOPN5pcfyrahKrrBIbxDbGHXgkd06Je9qC1XWxdz6jaEvXIMRv58wu/rjftEKW7/PD9stQWigy/Vg9/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNd4wMw8xnjXcwNLfCCoSeeRdEq6zOf+HViSasevvoU=;
 b=Brm7/2Xz81wHFhIA/VIUVr6blU5G4yejWj7hSu5BWGdZ4DAnVwNza3TQ3MIWWgM6uaZS6GdwqInzJxCRfgbKGUlGsoLYpzgs9nTE0cmf2GGJiwhADem4uh5boS4hjChr//Vflwi5tHnSRnfXuYhZlud3oR9MpEN7JCrWxtotkJo=
Received: from BN8PR21MB1140.namprd21.prod.outlook.com (2603:10b6:408:72::11)
 by BN8PR21MB1219.namprd21.prod.outlook.com (2603:10b6:408:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.10; Fri, 15 Oct
 2021 17:47:42 +0000
Received: from BN8PR21MB1140.namprd21.prod.outlook.com
 ([fe80::f136:50fe:4475:5f17]) by BN8PR21MB1140.namprd21.prod.outlook.com
 ([fe80::f136:50fe:4475:5f17%5]) with mapi id 15.20.4628.011; Fri, 15 Oct 2021
 17:47:42 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Sunil Muthuswamy <sunilmut@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v3 0/2] PCI: hv: Hyper-V vPCI for ARM64
Thread-Topic: [PATCH v3 0/2] PCI: hv: Hyper-V vPCI for ARM64
Thread-Index: AQHXwRPElntqyzuI1km8kiJ+0MEBF6vTZdqAgADu1hA=
Date:   Fri, 15 Oct 2021 17:47:42 +0000
Message-ID: <BN8PR21MB1140D7D99F0144D398E2D832C0B99@BN8PR21MB1140.namprd21.prod.outlook.com>
References: <1634226794-9540-1-git-send-email-sunilmut@linux.microsoft.com>
 <MWHPR21MB1593DB0B2A35C3C6759E24DDD7B99@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB1593DB0B2A35C3C6759E24DDD7B99@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e8e169db-070b-44af-a0a4-022ffc2e7eec;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-15T03:00:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ac15128-f303-44f3-82d0-08d99003e359
x-ms-traffictypediagnostic: BN8PR21MB1219:
x-microsoft-antispam-prvs: <BN8PR21MB12198E007F268353DC972BF1C0B99@BN8PR21MB1219.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dPZ7HhwZYm3w61LLx5cQEArUe3hoZTWyGstJ5bH2jQKklVg/hRsMGRKxIVStKkjTD5HRNr1zoppMUigVO7sv+FVmf+6zEG6Ew0N/5NPtcf6UTu7wBhuLefxvpUQL0M/XMxr6GbQDG8unQWBkrIbYfIwZrKOB8TZIlIi8rWzvxt54mv1NXC5Cnh86WtWBnmqBFn/gAxylxUo4Fh75LYx5hzObry1KFNwhCkpA1yi44qX/xcrbEjnsWqo3XDyRR/g6iy7VSolvxPtgRr6o0TxiXRYdH7H3IcnbYkVQMYaLMge04l3PUI67LqY2+jswl+UdTqhIxAC/jv/bNLb4cy4dq+a09CDAgjZPesZYP6dQSMdh2uaMuMmRVJ1vj4WZjZ1XoZIBJLNEZKSWL6+z+9Sl0eV5aX0rzVCa/ej4YSR68wyDm8NLG3FxY+QVXAvjVvDtqZcl5Fz0A1Ku2Y+cmD4t/8P731OsrR+TLa9fFVjma1JDTV4InP/ty9zeO/DSQuuhraQb3WYCeST6sObtkUT49PwdmF80FYA/MkeQBc9IE/2cGU1/EKOnmAhiHq1NwsVXbcNubVTY9SmV+Vi9xXXZScJQ8xkpbOJSstVO3wCeNpwxno9JcEkBAMyaYFSjVFj4EEl3bPEfJ2VXi7ETCMSFNvwCv2bU9xFrk4eB2csDBT4idAurowkLfVRngOBjy84uljv3e1g35soCNeHHqXO643iL4tINjBYlLQtnlI+U6HU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1140.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(4326008)(2906002)(33656002)(122000001)(38100700002)(7696005)(82960400001)(86362001)(7416002)(55016002)(54906003)(316002)(82950400001)(5660300002)(66446008)(66556008)(83380400001)(66946007)(64756008)(66476007)(52536014)(8990500004)(8936002)(110136005)(508600001)(186003)(10290500003)(9686003)(76116006)(71200400001)(38070700005)(921005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1SyFz03nxLCATuF2QEHAKRlJAHlotwEH5LJsFZzWsAcPij+lE17toWhuW0bF?=
 =?us-ascii?Q?ENIFBLCdEZ0SzM/n1u28Yg0BM46iKaR8t4in2dxtr9k+c4P8pAsUeMGmUuAB?=
 =?us-ascii?Q?fSubJKaVwdH+987/SP7JU4Sx7dj2ChqNeb/cdnmHICET04mCgTmV9f7Ir3S3?=
 =?us-ascii?Q?IJ0JO0zDUiSPaUUFH7dJWc5Z99fVt1ayX4+hADuPQiRZ4neaKzUIBsOx+hBp?=
 =?us-ascii?Q?CnW4DdHE4LLibf+vbbIFTK1kS/5Zpab04LXbsaUgb4Tgnm26sXMOtxzNpueH?=
 =?us-ascii?Q?jqi9INbSu4SRyLy0frwpNWWQjOoTZhIH2PYY9utBiTHQmTP8vZu5N5o0Nu0b?=
 =?us-ascii?Q?yrtPK25lZ2ePcQnT+We15+wRCr6hKIYQ9FhdvJxfcgK7WfukiRLFS26MRudG?=
 =?us-ascii?Q?0mZWZTsaXy81/uhZm44KWc80tNB1Jp4grRZnzd41X9g8kGQ9UPIRnN//Dlin?=
 =?us-ascii?Q?Mtk2ZZW3nzfgbwHUqlHtNrCQxts5Ily73111vYxgATSTcAkTgfluq2V4jdex?=
 =?us-ascii?Q?MbEB5I6r2O1n2zinom12I6lVagjREBOg7qLZEqlZl0wLxGTV1cxDbdLkks9c?=
 =?us-ascii?Q?nOZxALZtPTqBxjHHzlpyH9yZi3WU/DRWIjyGgi1slFmR1NkuY7pHPjADa6Qe?=
 =?us-ascii?Q?cTLqXrtRIuD8tQRQApP7NsdTR8NqjDjNo/fAeTJ5igV2KIvv9HiW+HudmxSt?=
 =?us-ascii?Q?xoDQuIS4VTs13SWfOpY/BLNmDzf/GmplZBEwlbxxlbK5Br7dxLHL7pPDsNxY?=
 =?us-ascii?Q?BVJmarG422Uyn1AUgcWZ8DvBVHBvccyFaCcHqNOLJ4nqExrQeKzAovJ5PDE/?=
 =?us-ascii?Q?W5GR3H0phEkc7t/bMNP7xgwesZQaxE0XLlhZkn7dXeTyexH08E16FNUv8TuH?=
 =?us-ascii?Q?gCnh4hpJBAFi79g4wyH9RX3U8nJBeU1d202aHSg5b8wI8a9q6nBnlTCUXF0s?=
 =?us-ascii?Q?2CG4bH/06m+yhQsCj11F1/5KRIOCyVKCxUYynIIOq9McWSfxCdUXd2mTOXG9?=
 =?us-ascii?Q?EGuoNOppqovEZD/wHirx/e/zgFAwy2loNx6PoUuhyIjBwX+5jBmMNT1GfX3+?=
 =?us-ascii?Q?Nk5xevYkHM6OJ+UATI/lt4LmfQKxvtMLovQHzt+XrGnyq2zeytCrva0ITmZX?=
 =?us-ascii?Q?fX+ns8Hz4BeIfXyv85Nywhfb60Bk+7Tlmrda0hnTW2mPphg5U4+ACZ4MovFP?=
 =?us-ascii?Q?sXl+P3cbBLPXGupbfeXFmrR9RJ3xoU+CMk2Zk8gPdAvWFqwaR8qx9ZZpIEwf?=
 =?us-ascii?Q?CIPH2OeiqACzv0gfY/zuoy3sTQYKLEYaAWJ/fR7wtJHzrwoNntmoQPI9PWqm?=
 =?us-ascii?Q?vLrf2GZ1WGGkSE9VtXg6+DWCH4m6boOIs7FHQCgZ/qloNHxI7lrObp97XBv+?=
 =?us-ascii?Q?816WGLbtMDml3Xs8qjoav2sbrPwu8Ml1BLcA/z3/DcsCyXXCtEL6FwecEMw9?=
 =?us-ascii?Q?YDI19dJcE+HY18DJzrrGQnnB7f3PlsUXnEW2uEhL/lUmsJG5AMVfVwSYPcGq?=
 =?us-ascii?Q?TJh3D75yxbCRLFLt97XTkAacXAhszVLvZ0NLTqfHAbLkDR1gfx+JEY0plev3?=
 =?us-ascii?Q?IIjuXIkKs+EZCAxrXDAXnsFqej68Je13b/QJryAYAJjndNSOe35KTOkSKZUk?=
 =?us-ascii?Q?NJoRIxmN0oASe6A3ZkvQ5upgnsEHLOfBb5Hklm4I5f8tWf4gNjYPjNG+cQbZ?=
 =?us-ascii?Q?+X+LcK/DZPNsvpu2nlE85SdpkApU0dEXktY5bsH35G99urnCrWaxPB2RwWhj?=
 =?us-ascii?Q?pSB+c0AHwQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1140.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac15128-f303-44f3-82d0-08d99003e359
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 17:47:42.1802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: owmU/fgdhyfgX52l58Mk8VF9ZNx8hM5LO5xExYL361MReHvBePQff6462ZeVDI6OC9RoHnFjhZctF0ScCUHsnba2XSkv4W966gnPblKjCds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1219
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thursday, October 14, 2021 8:23 PM,
Michael Kelley <mikelley@microsoft.com>=20
>=20
> At a micro-level, I've reviewed the patch set and could give my
> Reviewed-By, though someone more expert on IRQ domains
> than I am should definitely review as well.
>=20
> But I've been thinking about the macro-level organization of
> the code, and the handling of the x86 and ARM64 differences.
> Short of creating two new .c files, one x86 specific and one
> ARM64 specific (which seems like overkill), there's no getting
> away from a few #ifdef's, and indeed pci-hyperv.c already
> has a couple.  The problem space is just messy.
>=20
> So if that's the case, then I'm not seeing much value in having
> the code in pci-hyperv-irqchip.c broken out into a separate
> source code file.  I did some playing around with organizing
> the new functionality into the existing pci-hyperv.c with the
> needed #ifdef's, and it seems a bit cleaner to me.   The new
> .h file is also eliminated, and there are other small simplifications
> that can be made by having everything in pci-hyperv.c.   With
> this reorg, there are 50+ fewer lines added (though some of
> the savings is admittedly just source code file headers).   I
> can send you a .diff of the reorg'ed code if you want it.
>=20
> Also, a good bit of the code under #ifdef ARM64 will compile
> just fine on x86, though it wouldn't be used.  It's actually the
> ARM64 side that more naturally fits the Linux IRQ domain model,
> with the x86 side being the special case because of the quirks of
> the x86 interrupt architecture.  When thinking about the code
> from that standpoint, it's another reason to put the code all
> into pci-hyperv.c.
>=20
> The best overall structure to use is a judgment call because
> there are tradeoffs for any of the choices.  There's no clear
> "right" answer.  As such, my preference to combine all the
> code into pci-hyperv.c is just a suggestion.  I won't try to hold
> up accepting the code if you decide you want to keep the
> current structure with separate pci-hyperv-irqchip.[ch] files.
>=20
> Michael

Thanks for the feedback. Overall, I think it makes sense to keep
the irq chip implementation in a separate file because it will give
us more flexibility in the future to alter the irq chip implementation
or which irq chip we pick as parent (for example, we likely will
parent to the LPI irq chip in future) without having to touch the
core of the pci-hyperv. To me that separation sounds more logical
and beneficial than reducing a few lines of code immediately.

- Sunil
