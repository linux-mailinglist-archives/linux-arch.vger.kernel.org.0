Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7694C6DAFFF
	for <lists+linux-arch@lfdr.de>; Fri,  7 Apr 2023 17:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239778AbjDGP71 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Apr 2023 11:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjDGP7V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Apr 2023 11:59:21 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021020.outbound.protection.outlook.com [52.101.57.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261B3B440;
        Fri,  7 Apr 2023 08:59:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKHgIQGjyleNZ0/cZi18BWOWRY4x/BVy2sisBJsEHxR/J+CDizZwoc5AUNNd5ea0gMBKF1/0ACyU34biOsSsZ0QG8a5/gmNQYAYzmznJtPz5hWax/tdg+mZysky6Uihjf2brM/mLYDGx1HjXq4LeVjWjjVsqChuRjjCeiADK0SZsvlF+e4FUuwlab6Eh2FXywM8cy9n+d08nriik3pQCpJreM4kWmI/Bcbnl7uEHqCQuSt1iA3Ga3w0IUmyzcfkdg04XDMbs/JC8vDIhQ5WxJnYEsyX0qTs4gGYf+pNXs5BWYMf8Cvdhq+aBScudtIfLP2q1OqWdcQ5VQSeIe9MA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohz4tnR+92PEr/E0yzXk+03P7+0ZQt/p9cgdA8URk/o=;
 b=mkHRIgJnfX9GR3GQ22MbdPqXHculNTMksU9SZgr88YJbgyIgSGKLPjMVZSHE/7vGmdj1BbbFFl7T22WeOMqr1rGm7xVVQR9RMG/bbhXsM3XIsmtRDCbq09eq26KmuUVqHPZUnvO4Hj4vXEa2Xm279R7qm9BENW4/7P1nCVXlUxJEJsPUZhd8w2x0VLh4MwDUJXF/ptSZv1juI5efkAYmzcr04OSaYVDm98ob0AEVK2wFSCEtq2s8100zxNhVC2wzg4/uA6Rs3pkB/B/CncAYfuXZ5VwSb/kRMCixh8L21a8nqw4dc2R+9BGNoLkK6ukYhr4l8sBOsNHTYWDyhg/XUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohz4tnR+92PEr/E0yzXk+03P7+0ZQt/p9cgdA8URk/o=;
 b=UHLvnsc9Y2NYR3tFFLo16ZOCb1zX397s1gVXOjr+iAJbs8s/IDBaKk2NTMhosmYHzXCTojQfhXjo+N+Urtst/xdLhEXjnK6rxEN+3Krg3bj6wKvjth4VGNejJX/YF5CTWrWqXqFxMxQ5xZpp1/LW6rCd44GTreUMmwRLKR25Xtw=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BY5PR21MB1377.namprd21.prod.outlook.com (2603:10b6:a03:23c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.20; Fri, 7 Apr
 2023 15:59:02 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6298.018; Fri, 7 Apr 2023
 15:59:02 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "mat.jonczyk@o2.pl" <mat.jonczyk@o2.pl>
Subject: RE: [PATCH v4 4/5] Drivers: hv: Kconfig: Add HYPERV_VTL_MODE
Thread-Topic: [PATCH v4 4/5] Drivers: hv: Kconfig: Add HYPERV_VTL_MODE
Thread-Index: AQHZZtQD/nUJh0YZe0Gm96vcHnabua8gBeWw
Date:   Fri, 7 Apr 2023 15:59:02 +0000
Message-ID: <BYAPR21MB1688D9855577B42407C77687D7969@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1680598864-16981-1-git-send-email-ssengar@linux.microsoft.com>
 <1680598864-16981-5-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1680598864-16981-5-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8c0c8a52-6a6c-429c-a011-27c27dac1745;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-07T15:58:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BY5PR21MB1377:EE_
x-ms-office365-filtering-correlation-id: 0884a359-6391-4eec-26cf-08db378101a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Zke2DOwuwzqMUXDWt1+3H2vMtNvVBHXOM/hUhwAlK3dWD/Yz2C0sbeAMyeenuOVkt/cI01/mbFDXmNstg5XzDA78R1Y3I2N1e4SwPagHeetRzlKwOFPkkOp4mBWPEIXgRBWP5j0igSiWthE0eyUUMGel+YyXW9nWAVaD+psWIG4Y6LV0sLdLkwq+k+cWY5dP2Y6CfIuqCVhytNCsUT9WEsvNPAxVFWUJAWMb75v026/7kwawdXCHEqVWWDr+nDy+dn5e8q4sCj9MponupENgetPijCZHIP8KwETdCqbAQcp94CigRxj+zbjtAZV/4PC8Rz22TWR5Gh6p5h2+OmCBrLUviS7JHv90CnW7jnCmy57UyINrwoBnazyYnSP4Qgjpy8Z/LVpioRVO4MtGewTPS0iNHVmGI5d2Na8uCRuSglq+G4bglR+wlthzATqJC00AaRZlXd4GIW7YDQERUib9dn+66hGsBQ5bXhZQEIc+sCGiW7e1ZYqdE+is9NEB6IcSXnakGZPIWQBEz7vQoEhnEW9nB6rEzQLq6ZfMvjUch7/iHCIPn2wUhi6Tj1B1kNOjHKiSety3p444V67g52tln1WCoixo/KkrDbSbnCf4M3yJBQDehtqEiOWF3DsGVhcqAJcwlEtTH4DN9DsORjoWtVbiMfcS1ngXFreTyPLA8j9Ks/fBM1C/ymlej2kEKrq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199021)(66899021)(66556008)(8676002)(66946007)(478600001)(64756008)(66476007)(66446008)(71200400001)(7696005)(41300700001)(316002)(786003)(76116006)(110136005)(33656002)(86362001)(83380400001)(9686003)(6506007)(26005)(8936002)(2906002)(5660300002)(7416002)(10290500003)(8990500004)(55016003)(52536014)(82960400001)(38100700002)(82950400001)(921005)(186003)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bnCv6Y9HQwKAI92BWCSCd/iHladfV6TyrHwNkdXIietA0CsBMlDgAAJMXnmK?=
 =?us-ascii?Q?12SQtYaj5jQduZRD3LR6btSI6JWQLE68iQ6QEQe2V3VUN90cfsk75hOpgxjJ?=
 =?us-ascii?Q?3cm70T7xwETlt9yxVCUwcwNVnRZM6XN2YZb+1Ak08tM4bNvoLlrzIcTy9omc?=
 =?us-ascii?Q?3vHALQV5pe8+6DniBSjWaHyMn7KuXhAXpnhM6W84beaI5zm/VBRMwOYkicLr?=
 =?us-ascii?Q?twpaqwBQE4thknkDMBbA8VBN1BeMyNTWRfiay7eOU6Hg+MNPnWbTEa1ksZpq?=
 =?us-ascii?Q?LCJWgLnO+J0N97URoAaKlnUZ5q9kXNeWFhj+za0a0uhq9UuL28zFnFOaoURM?=
 =?us-ascii?Q?azhFGLNKw101NzzwOsSxkgO8Kq7lPms4HxkuR+iqId6CnxHwrWsSEfMUehdK?=
 =?us-ascii?Q?Z2mywcd3BQ1eOr/uC8aAn4HNTi9d++/cGcOm35a/CyHItZKMfL8R7cNE91zT?=
 =?us-ascii?Q?53pbC30CtlzrjFlaXNfMMb7ZTXz2H+sST53mVvqEhnYnZZdlwsluaEzl9eGc?=
 =?us-ascii?Q?Ta5UuPtj7oBCWVnFUbe7wpjTA89nETsEwGEL7fKbW6ew7fbD7nttXAtvN1KG?=
 =?us-ascii?Q?TBrrNsGmNUVaZB1Rulj0JuUKbtkaEHZsL2IAwa0YYU1k2SFGH4sWAGhJRNf/?=
 =?us-ascii?Q?RHYU3JqvCB9RnxnHf5tH8AtQDjTAK3Fu83gesSsmSpwkcGVOEocx1I19C47v?=
 =?us-ascii?Q?nYVxtw2G0dj9q16WjSIqYTtBy1vXsUkVjIwJR8bz31k80SWx3AtFKVJAQ3t1?=
 =?us-ascii?Q?JL67TdmJLxOoVKDo1Up+JCV3X2EVW5lXIwtBHNbmVA/MxTsGmYMRARsmw1QU?=
 =?us-ascii?Q?VMjPiIAefy+M2AFk25CKRVgp18RHaEY69rh94DAo0Qrznb1ONFclmCjcykhH?=
 =?us-ascii?Q?99hCifqxB2IRTdFaiPA1f0b45CoP82Mc6kUTUbEA3ZziOD8SwrzYVHd2VQLc?=
 =?us-ascii?Q?pz/HJ0vn3zH5KaMrBRa+rVoRN9HKZMszlwXGU9Ekas7V9pNMdQLWtvZ9bNU3?=
 =?us-ascii?Q?/msyVNFYbYDXHq1p6ZnovGlAqo2nVFgwXRRKc+lVfSqnQPjsEZCrYJ8bCTb+?=
 =?us-ascii?Q?0zyXhLGqYkFl8FCBUeK+Il2/UuzcS3mxjbelqJWnY/TC2JlLPVSBKyhjgvVY?=
 =?us-ascii?Q?PBTEDQp8rMQczPa9qpru6laX+yueNyuZR/5EDGS7rNlwk28R11uSzbbMbu7o?=
 =?us-ascii?Q?VP79U2ZwOeQOK1vowFwoHk8MWLokrjzIlDwl+4RGNhRDpJZIKiZoqKEFkCjg?=
 =?us-ascii?Q?jCT+e5gKoJ2N+1eq0JxaFoO3309F8cMWRel1eygTUwjLTwDs67VEyWfI5rT1?=
 =?us-ascii?Q?fZofb2vughdFAZ5lIENuEHRL/yXs5tAjwHVsr9HEet0RhKCpddNvoGiA3gv7?=
 =?us-ascii?Q?cFgHnRHlgbh/OIDb4xFbAQjgiQfMaYAk0u3yHF1VFreGpLs9lcM11Mw9OL4q?=
 =?us-ascii?Q?Bsy6mC7SI+XBLS4JMOwGtxJ7Zt+sWMZHeSK349nzCkyqujVygGYAU44m2WI7?=
 =?us-ascii?Q?tO2F49zgFCNryoj9mpYpgeDDPXRtEKj3/DvI4xFjTGjhHL6JRsd4imupgZ5A?=
 =?us-ascii?Q?Rx5WIVrY/tBNt7HyLGoFtLuYoYxaHUFdfoQKznCtSXu1p8+lrd6cUh/VDJJi?=
 =?us-ascii?Q?Cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0884a359-6391-4eec-26cf-08db378101a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 15:59:02.0721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n7EV+KEpvlpwic9gjuvmCPlGJRkO0wMtYoP5PbHl7b+VjsT1lGysGVrczBnWiVw93KHK0atb5U2wruC2Pen47pVpqKOWdRCRdF8rj4eO6EY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1377
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Tuesday, April 4, =
2023 2:01 AM
>=20
> Add HYPERV_VTL_MODE Kconfig flag for VTL mode.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 0747a8f1fcee..511f2e012c59 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -13,6 +13,30 @@ config HYPERV
>  	  Select this option to run Linux as a Hyper-V client operating
>  	  system.
>=20
> +config HYPERV_VTL_MODE
> +	bool "Enable Linux to boot in VTL context"
> +	depends on X86_64 && HYPERV
> +	default n
> +	help
> +	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
> +	  enlightenments offered to host and guest partitions which enables
> +	  the creation and management of new security boundaries within
> +	  operating system software.
> +
> +	  VSM achieves and maintains isolation through Virtual Trust Levels
> +	  (VTLs). Virtual Trust Levels are hierarchical, with higher levels
> +	  being more privileged than lower levels. VTL0 is the least privileged
> +	  level, and currently only other level supported is VTL2.
> +
> +	  Select this option to build a Linux kernel to run at a VTL other than
> +	  the normal VTL0, which currently is only VTL2.  This option
> +	  initializes the x86 platform for VTL2, and adds the ability to boot
> +	  secondary CPUs directly into 64-bit context as required for VTLs othe=
r
> +	  than 0.  A kernel built with this option must run at VTL2, and will
> +	  not run as a normal guest.
> +
> +	  If unsure, say N
> +
>  config HYPERV_TIMER
>  	def_bool HYPERV && X86
>=20
> --
> 2.34.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

