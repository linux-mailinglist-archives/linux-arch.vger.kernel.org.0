Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A867663E1
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jul 2023 08:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjG1GEv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Jul 2023 02:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbjG1GCt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Jul 2023 02:02:49 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020019.outbound.protection.outlook.com [52.101.61.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FA63ABE;
        Thu, 27 Jul 2023 23:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2afLBGocBQUCmZ0b2vAQG5BxIW2eqxdTZYaMCRhyXHdL/aIJGLYZkw79xcFpe5tKZ/c9ODFfquzcvthRkiLEaUJUEn9KHnqWjmZBxlnYJcbPY9RZ7P8u+nGr52fot6y+w28IkKzcKqtcUB1FikFnbEIL3WWHUceSXgIeACakbNMpBnl4xtfmk0a2aeMQjnGbDztGGefpK7omHVEmCRf4ihsAhwViSZjXCUr9KUk1SG9wS08fLC5S5DemomP39N6T+SO+eMnlDCX2Nt3CMVDuwoOBFXj9X4XLglfZ0RM4cc1xT9YN9SL8ngS0Y2OQkxqmfRwnLBPktm+HdvJLQrhSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lG23V13ciARhupABAemmm8ucH9RpCEdTFYDTaXzjN+k=;
 b=RJ+64H3HGSWUmO6JYkHEsbOzxBiYva/uLVJJU/JpXsuik3SwPCGlhP7fdf8MWoHeAevNL93COdaGrGKvd77HidcpIovrM3Q+pVVqzQLuEK2sJyIGMYwrdQoAusHb/5bpnNBLtLqbfh5IuAiYnJKRhFqFI/2hFROnBVCHqOAVPg2tjfM4Y/qmCqaYS14izUQZtnvYSG0UQlfY6dSTex04dWv7BynG2PKGmYF1/c3KLRtNSqDpV3DAxPwkk6dFz8feV6hyzuR6kHU2SeqsYQifw/5ZGEAjVrJVIvH7AXTIHehmmcTt+byH4v5nVprizXVmKkaeVZIsK38YkMrWKcM4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG23V13ciARhupABAemmm8ucH9RpCEdTFYDTaXzjN+k=;
 b=LZ0NFr96j5On+S2caVBwqK9kG9l0Hh68/XIh9J6rY5aS0pxeI7n2IhEJqPq8z4sfSDHTzHfgmP/d3yGZVXF61WI8wDZDqdssMmgmZFMJT/dV9/pPzBOJQ4EmUXDcFem7riODTBX38Bwt2P1Gl9pZUGIShW+I/YbjZ+Ue+dUqmpQ=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by LV2PR21MB3063.namprd21.prod.outlook.com (2603:10b6:408:17c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3; Fri, 28 Jul
 2023 06:02:34 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::49e7:77aa:3b13:3b3a]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::49e7:77aa:3b13:3b3a%6]) with mapi id 15.20.6652.002; Fri, 28 Jul 2023
 06:02:34 +0000
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
        "arnd@arndb.de" <arnd@arndb.de>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH V2] x86/hyperv: Rename hv_isolation_type_snp/en_snp() to
 isol_type_snp_paravisor/enlightened()
Thread-Topic: [PATCH V2] x86/hyperv: Rename hv_isolation_type_snp/en_snp() to
 isol_type_snp_paravisor/enlightened()
Thread-Index: AQHZv7+Rs4lk3HyDvUCk+V2TKWFDQ6/OpCBA
Date:   Fri, 28 Jul 2023 06:02:34 +0000
Message-ID: <SA1PR21MB13355308BB925BA96ABDCC22BF06A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230726124900.300258-1-ltykernel@gmail.com>
In-Reply-To: <20230726124900.300258-1-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f08e122a-da33-4cd1-bd0a-c46c1b6de5c5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-28T05:10:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|LV2PR21MB3063:EE_
x-ms-office365-filtering-correlation-id: a06cc02c-fc9d-4758-61c1-08db8f303cc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aiJO3WFa9jreh0Edxt8r23eE4CP5zU3AtFDSntQ1sEEMaYCI/fdv8NOt1n/YvWyqEWwsNbfGTlwg4/MZ2Me9IuHJirSknJ1Op64WXKEIRGzv45mLbr/Dlqa2wqFYiV3WVje1Cy8dpby0LyrHUXaPZNSaNQuygltmDmK2hpB51+8MEfmPX3FaTAdLuaAVGUldYgtU6gtET6rvbyLX2bLZPM1FgbsoP3UqPzqysdSefkY2SmDd+oJHdL1JeXo8+DQEOLqqCz45GY87zk7awFdBAz6iXgN4qkUwdBSi4a9RAxtcWhnKdNUdJ8doV5y2aQZv64mWhUrPxW1GU2PB/wygOv/vIiWwCmljMZF7SXdlZZDDJ15/NNPiY5X4jWNPoNcBJOTpLD9DAJBYICWlOufGTS3HG+uliq/r2M6qOUkkYxRBwHRO3mEK3W/rSapEGdBWlUn9MCsrwgHDNWBwSqPEQy6M78CcWoFfkQzMoM7CD5TpyxZ+gYOANdmCRYtX5Hi5AacAk9aT/gz01cnQ2T/YPXOgAu82RMFry4Wnof6rGhqT3ZWeGVeflf8x6H2zb8LpxI93RaeES0/NLw1jkbspi7aLt27bWvATEi9s4CwIKkCcnaVsNedPM9I66458+4f5AFE2PDT+v2lYJ15NUbW5WDoPAhoLZO/5B7fRmMdQcPE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199021)(8990500004)(921005)(76116006)(66476007)(38070700005)(110136005)(7416002)(66946007)(52536014)(122000001)(86362001)(33656002)(5660300002)(64756008)(41300700001)(316002)(8676002)(8936002)(66556008)(38100700002)(4326008)(66446008)(82950400001)(55016003)(82960400001)(6636002)(966005)(9686003)(6506007)(53546011)(2906002)(10290500003)(71200400001)(186003)(478600001)(54906003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r3YZq7jpwpvklzPAxXoNH9A66ZLNF3ZdAJD0Brtuif84lZSwGBK/LVFNfCWe?=
 =?us-ascii?Q?qb6Ccsdfj5hXjyVfk3rBmm+KNsFMLabzRx2OAAh+xcnmdXfW5fUxl4Sgq+Eh?=
 =?us-ascii?Q?wbqWawLQm1IHUmrvk3ILvpSHTDMmRbJl2VNIdW7tK5E3qkzTl7Di8YSCnLik?=
 =?us-ascii?Q?syhFWk0rR449r8C7mY/xubDmHyZr9p1dlpvWLXP+YyiEww5AQzaBO+YT8boy?=
 =?us-ascii?Q?hIuqrv6otd7e0DApdJP/1OcS5BrT9BZlNTwoQ1hapCcQWoMcRUUP9NBXAyD0?=
 =?us-ascii?Q?hdSG0ZsArdE4mxvmeEiJIu4cW5dzWSLUm0nN3i+8LCLoZLaePpjtUxIw6qJ/?=
 =?us-ascii?Q?YHtvSpDTGVoRV5cNXQnA1C9v+D9+qHhxKIluuOHSdVUx3sOceI/vYN0mukcG?=
 =?us-ascii?Q?0JrneEFWTCveAjanPfNMpATYcTBFw1/ZBddBvPoTSJSL7iSTznMGZf+X/yKF?=
 =?us-ascii?Q?UaOr3aWHyutPBsIh2+Db3TIGj9LtnjHObRuVV86WC6LbZYYm21xwYOnBOjI+?=
 =?us-ascii?Q?8M81CT0I0BTt5kEuedzx5X9LVJzcTx5u6zIDTSmyE9O5Sq0VMB7BsJ4G8A7M?=
 =?us-ascii?Q?xr6Mj/Gl6ZhFUCcCOfWDV2AmDlxvfdy1GS9BHb1kdUcLSYvLZ1GbxQuQGwBS?=
 =?us-ascii?Q?Ri4r1Mb9w2ZbRrFrgU7ARMg+8bpRU9Dc2IaXW5lRFGfQVgmUnsYawQ5dY2Ry?=
 =?us-ascii?Q?lZ2Ex/flPxDLBkOW8hHiE8+SjZc8awucxuc16u1O4KgPI0lMWlgo+/e1U54f?=
 =?us-ascii?Q?z52liA6tHswv29Lug+QrTuWJEMXzGOE8lvOOdLmdc6N+7npM3XARAYVOUEhY?=
 =?us-ascii?Q?sC1sBXwYvh07/s98AbKgQ5N6feTzBF0KngCxW2H/gda7qmDgOqkRCmi6ScuF?=
 =?us-ascii?Q?pfO1Yyta33xy2v8yCCro9Hj8xmgbCYGnTmvGFmPN5n1bdoYsQW+ZR3dLqGHh?=
 =?us-ascii?Q?OBlDQlz2TUZegUdylOU4INsTuOOnHu1kcIGTK+QuNFYQU2MRzqd+EYqtFjOA?=
 =?us-ascii?Q?PSAdXyRY56nJwoC/mEhFb+HOAFebvxnb7c9+IpDiwVZ2eBak2iaIw/E3xe35?=
 =?us-ascii?Q?3PVQyF1VnAJNIObAgdmhsAfc45cxC+0ubtwaMue60B+Q54nudjN3qUkANuFK?=
 =?us-ascii?Q?UC++PyLHtbPQTWBwtylbdHnbsPFtZ241QKpEEmm/MyL5jbVRtQbi0O29YKtq?=
 =?us-ascii?Q?CHv2HrAyVo5xpzW792uWh9ADymVZMD9J+YEX/JArxz4eQ612YnwfaWA5Zlmb?=
 =?us-ascii?Q?O+80VPpJoCZm3ZWmaCb5AUiSsNQEVf5thBh4+/OEvZRf35WFpX2PW9kKURuJ?=
 =?us-ascii?Q?vQbRhpzVnwjdB1OdxCMXWMePTg36Jb6Tf7JjsxcT2OFt4jHmGuQka6UIFC0E?=
 =?us-ascii?Q?kQKtWSR2bOHXhqEHXsNA/CKQ1ZdW5Hh8/1bk1uGv9fxQcxNGnQ4H46SyQ9cF?=
 =?us-ascii?Q?ZhkzTyeO+VoeCmgqzA475ubJiguVyDxe/fQ2ffN89Ak+Wrpb1X9qCNJFe6+p?=
 =?us-ascii?Q?ISPJG0iniJw2o76nLt0JOdQ/wVbfBm3GZypzHJH7qGLzYGjjClb+TQw9/ruT?=
 =?us-ascii?Q?heVF1tO41E2adI62gOOt5H0++B6ESHF9TZqfuMMJcr6Pa707KBBSJetQ2PpI?=
 =?us-ascii?Q?i6LJmIxndVN/lfHjqQ2hmRrCD8Il8gCpgMCd0mffLZmv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06cc02c-fc9d-4758-61c1-08db8f303cc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 06:02:34.3610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xzCZtccZpvvWaTj9lyR7JnugGQcVdh4jNXYpKRjEZL5jcbmFOlpH16qW4BD3R1QrsQD7qjNQGcwAJEizknJUeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3063
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Wednesday, July 26, 2023 5:49 AM
> Subject: [PATCH V2] x86/hyperv: Rename hv_isolation_type_snp/en_snp() to
> isol_type_snp_paravisor/enlightened()
>=20
> From: Tianyu Lan <tiala@microsoft.com>
>=20
> Rename hv_isolation_type_snp and hv_isolation_type_en_snp()
> to make them much intuitiver.
>=20
> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>

Can we make the names a little shorter by replacing "isol_type" with "cvm"?
e.g. hv_isolation_type_en_snp --> hv_cvm_snp_enlightened,
        hv_isolation_type_snp --> hv_cvm_snp_paravisor.

IMO hv_cvm_snp_enlightened is better than hv_isol_type_snp_enlightened?

BTW, I'm not sure if we really want hv_isol_type_snp_enlightened()
and hv_isol_type_snp_paravisor().=20

I think probably we can use
"hv_cvm_snp() && !hyperv_paravisor_present" and
"hv_cvm_snp() && hyperv_paravisor_present" instead, respectively.

A lot of usage of hv_isol_type_snp_paravisor() in drivers/hv/hv.c and
arch/x86/kernel/cpu/mshyperv.c will need to be changed to=20
hyperv_paravisor_present for TDX VMs with paravisor.

Some of the hv_isol_type_snp_enlightened() usage will need to be
changed for TDX VMs without paravisor.

Can we hold off the patch before the fully enlightened SNP patches
and the TDX patches are accepted? IMO it's better to have the core
logic to be accepted first and then we can do clean-up later.

I have a drafted patch for TDX HCL support here:
https://github.com/dcui/linux/commit/9893873bdef6f1e5574f784ed6e1d9d5bc54f1=
d8
(the patch introduces a global variable " hyperv_paravisor_present")
I'm further polishing the patches and will post soon.

Thanks,
Dexuan
