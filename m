Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE326787136
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 16:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241501AbjHXOK4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 10:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241552AbjHXOKo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 10:10:44 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020024.outbound.protection.outlook.com [52.101.61.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F291F173F;
        Thu, 24 Aug 2023 07:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ow+pySLLZ4okMwL5/ilczfFrMfe1fxXzOaWrXxfOnLNFgTrdJ6yaR3Ug+zjECcs96zTOoQte9tnAWhKxuGesN8CE9uOov+VwBrqIPf+UwUt2wOiXhAtSRb9hJ0CYsEuda3thq4s+wuI2JC+3smW2iRz23I35yPirCoy98gagwNW9axkOeQKyCJt0OYxm15pOd8rSb+8PIT0WF8q7Kih/CABy44GUmRzN4HDhgRelgZFAYLgANvnj6AD7nTjKlYDSEjOxFIIK8ChhYiB+/9z1/DhwNBipRlvw6knwJaZBE0blaIDXHgcDd/eKQVqbyguT4hGUiBK7jdfmItv7FtQTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXSxRSdNr2J5JCc0t5YdRrHT+ZkuoPhP47tCIa4/DXY=;
 b=NhJ4dVnN635it5/LielUFMXzSvLYj2MuG3oz4WmkVt9PtqaTtVl3tp91UZzXvK4GZVG3r/xASZif3N/BHWfxey4ZP/8sxp0Ho21crwTPoxXsofTwcQbWa6JTlx9OtShNRQ/WvJqforTJTI2Yy9+iFCHqXJb/Ps9YXsZI0swG/FOuWWA0ipjFln6zoX53S0MAE3ULmdSFk8dPVa80Zr39rgMVYnO3mHRADHzft9Z0UzxXx7x240509QKBUYAuU3AUlU2FoLHucDWBM2/TBrXNSSclPU8hE8iVmDguO6BWe85HMs1J/kwCOwGVubh45dFfLmktWfiQ78fQVtbTICUqMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXSxRSdNr2J5JCc0t5YdRrHT+ZkuoPhP47tCIa4/DXY=;
 b=MuNx/eJEUpWbtieiQVCl7utxDnyXVFjCVlOgVJqVeztBvTQutj3e8YUkqpLPyjGN/e/SDRP4P234AmWTCsXgyOfUO1X3EE+v5SIHi/M7BsesaYJvUlCJPL3c8A1iVcYB633qvAuEFSo5nQJYjl9dcEg29N3tpmcyvkoVJH6Te4Q=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN2PR21MB1533.namprd21.prod.outlook.com (2603:10b6:208:1f5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.6; Thu, 24 Aug
 2023 14:10:38 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f%4]) with mapi id 15.20.6745.005; Thu, 24 Aug 2023
 14:10:38 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
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
        "nik.borisov@suse.com" <nik.borisov@suse.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        Anthony Davis <andavis@redhat.com>,
        Mark Heslin <mheslin@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "xiaoyao.li@intel.com" <xiaoyao.li@intel.com>
Subject: RE: [PATCH v3 10/10] x86/hyperv: Move the code in ivm.c around to
 avoid unnecessary ifdef's
Thread-Topic: [PATCH v3 10/10] x86/hyperv: Move the code in ivm.c around to
 avoid unnecessary ifdef's
Thread-Index: AQHZ1mIlxlgGKA6gWEKomYh/Hzb3gq/5fHPQ
Date:   Thu, 24 Aug 2023 14:10:38 +0000
Message-ID: <BYAPR21MB168808A61538748E214F405CD71DA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230824080712.30327-1-decui@microsoft.com>
 <20230824080712.30327-11-decui@microsoft.com>
In-Reply-To: <20230824080712.30327-11-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a3d222ce-d313-4c8d-b7d5-13f32f5cc63a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-24T14:09:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN2PR21MB1533:EE_
x-ms-office365-filtering-correlation-id: ce492722-56f6-4d8e-bb39-08dba4abe49b
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JJFFZxWrqPuHVOcIJmfMe1AJcqrvZmqRbipOe0GACfOZS87vDE01iXQfB0Z03+Qny3HJ9wDzP9/CHFKYX/f70yllgqgt5B2X9jhv6KSanMjEWZApWBsu0c4yx2zurhJNJ3QuNlJsfnqwywu7etPV4qR8PLaPYzl6/GRBkEsznKUGF2XqXoVatl4aH2pe4/UqrHLpGhTPkJ5PyUYniwkWh9v5AmGq1zeAP2Rkqc0Zim3iQ+wH3skzt43S1okThQ6xWIxw1DBJZDr0TGGq6YP49Pv13q9waV0pLJponbWXv8pl3TvMmhCeKTCMblVdpHeKPwYEJ7KWZPhvfhOKucYtydvwnGNtZ1lsHhE8d/MCgzNkpmJxEzvZcyCyRPKnxx/6p+Y9qryx+K8vVT0o3ISNivQ0tig4+Q0mNPFZAzr6EBbnYfdJqyQd5Xd42L3yI+IB1vLONizpfvLLsyFPmQPHz2ot0b1qsLwopra7sg8XDycMHz5sl2jnVMDd7ZI6a3upejUB7vm9sPN4JNaavC5jWAlv8TRSkypoTVNXwWwaDvyMbUrtTXG+eyOl2aW0/MIsxuZfrg/Z47aVW0x5IqVXBpIESJApqCkxHdDw582mqmqn5qKdSy4MoFSLTn944pL9FFEFcx/Vv+Jcv5w2owGZSY+q0NMlvObYfMpOEYKprKDOqwZ7zDG7q5NL3oakRhGf6rs53fUZVYrdMNaZD5apIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199024)(1800799009)(186009)(7696005)(6506007)(71200400001)(10290500003)(9686003)(478600001)(83380400001)(4744005)(26005)(2906002)(7416002)(7406005)(110136005)(54906003)(8990500004)(316002)(64756008)(52536014)(66476007)(76116006)(66946007)(41300700001)(66556008)(4326008)(8936002)(8676002)(5660300002)(921005)(33656002)(38100700002)(55016003)(82960400001)(86362001)(82950400001)(122000001)(38070700005)(12101799020)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dKnjaF4CZVGcDjFS+3FU5sQjHTqtgGGVFce/Y/RzeBjiOfZJMx0ugA14cy5B?=
 =?us-ascii?Q?0LPtIpfU0zI0b5NBMODT+v2y4vFUXYM67qdHR8LusDhVh8HyOAgZOqOyxm8H?=
 =?us-ascii?Q?+NfjWEx47WwFItPvVa+otT1tnJZ9RacpLwSCtuYlhi7fiTeaC8ScdjLJafq5?=
 =?us-ascii?Q?1ZfUQbCcX56Y3h1E/i6y88SwKGsFbgJTf9rjlXxca+lttBncAEJtOlQ7yKhe?=
 =?us-ascii?Q?XVJl4btvIkwXhJX44cx3pPxo1hM0V/4uXIh0uK/VPGljJWCjt9mS4K//fh9Y?=
 =?us-ascii?Q?lTymtDtBNAWX4a5VpwX2d8wXd2LRpocgjwx5fWJNdM1z1D0TTgPAp7wIrXuG?=
 =?us-ascii?Q?naKF4bUfFUtIC8hM0qIs/Rz8H0s+VNrThwk1sHXQOAZLp/D+BYzOc/1v5R4l?=
 =?us-ascii?Q?fRllkj4SmuKZth4z2DLPksiAlXVfDEKQVKYI4mqJmzSQX3pcOJS2iDl3YBHm?=
 =?us-ascii?Q?6Pot4e5xB83/75TtdK6igrSElhYtWQ4q6xq298KMdOM/2H+ewTU3sNd3gV+1?=
 =?us-ascii?Q?Kt+D15spTfuCg2NmHnxR8YinYtHJIgyomwvABYYURM4XKMmjcJnHxHkgimt/?=
 =?us-ascii?Q?g+QSVugAabL26bvuYvzS4hKqUqwWfenY8CYMm97UaCeeIzjG0x6YAJgkw5KC?=
 =?us-ascii?Q?lZuw4fPUkH24r7UjhbZYxguWhQEf+SK6bcY0kWokmmXLpR5kYA3eISgVaWsq?=
 =?us-ascii?Q?Zdraw8O4TL8aLejSPQm9bFd/N+qewSpr+yRPxqlbetebXwEyqZYyiFzKVLNE?=
 =?us-ascii?Q?TXSFwM9vgCkpU7/ZzI1tWk10qMTD0j2GtkSbVan4aOnDUSBJFVj6bD8PuiBZ?=
 =?us-ascii?Q?ltdA157ZvE5uYjx3aDaHUsDvB6hmis3pA8aOCXeu+x3NTb5ePw2YJGYQONye?=
 =?us-ascii?Q?kHCDw0mghPJWaBdY1ygy+ylViwp9Ts55ktEj+SQO5wdX0gaENXuLzuW+XpKX?=
 =?us-ascii?Q?y9RrlnMhZq5BxWOgBmwpyAW4cBQAqOGhKmaCSX4A1Q/3tSdwGm98iFE2qokm?=
 =?us-ascii?Q?30yz13jn5gnd1XGgqpSCTzxlWcisP4zfHhR16DVpJEhdz33tv0T2kxDOezhA?=
 =?us-ascii?Q?B73gBSGfccWTX2YhD2mrpDWUj4MT8h5tR0WkK+HxrLoJwHHLvhCIl0IOe/P8?=
 =?us-ascii?Q?DwaRK1eUxF9FLOtiC0aXDtnsRb9MsaHwUmT8ao7IM5L2WMb93PtLToNzLStV?=
 =?us-ascii?Q?Yy0FmvWx9c4gkLxl41ylMp2KReDY/uGNdtCE3a+432CoUT5QSIfvEx61wgBb?=
 =?us-ascii?Q?GWrKJVdHuq0LRuvffxDG1I2xZKj5QO9Qmpkv1f40FP+J9vpeQwc3y8ng/chL?=
 =?us-ascii?Q?lxq8NBBdR6B7p6U3nywglSBU/FxP3EtYQVljIH4JPXjni8Cd3vSoNuMliqef?=
 =?us-ascii?Q?QVnQ0WS251aoB3PSVW8dcvuzAuICd9L1JIDE1FBnuru02dkjhXnXlVbxDAqs?=
 =?us-ascii?Q?HaZ9OXPTrs861uN2Ti3gOTAknkT0ms8ti27VHnFyjfC4aVCaINWZrq2r83cZ?=
 =?us-ascii?Q?puAP5OgelrOaNLlAVX736naNPN4w9FvakEFZS/h/oU3oDuxYCrJd0cSvWf8U?=
 =?us-ascii?Q?oaBFwPxSWVSC8RNP+lNWW+gQGVvRn6ivTG88c7d1zCz5XE2Srqmzcptqv31E?=
 =?us-ascii?Q?ug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce492722-56f6-4d8e-bb39-08dba4abe49b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 14:10:38.4245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nhzGY5Ij2BuhIwXt6WjmuNlZUDAls5tRNGevgNun4V21yfyZbeJ0K7hIgrtstJ/jXBOhJDwL1FoD+ZZih5/N6SBSSdVS5fRVi35DlIOrZAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1533
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Thursday, August 24, 2023 1:07=
 AM
>=20
> Group the code this way so that we can avoid too many ifdef's:
>=20
>   Data only used in an SNP VM with the paravisor;
>   Functions only used in an SNP VM with the paravisor;
>=20
>   Data only used in an SNP VM without the paravisor;
>   Functions only used in an SNP VM without the paravisor;
>=20
>   Functions only used in a TDX VM, with and without the paravisor;
>=20
>   Functions used in an SNP or TDX VM, when the paravisor is present;
>=20
>   Functions always used, even in a regular non-CoCo VM.
>=20
> No functional change.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
>    This patch appears the first time in v3.
>=20
>  arch/x86/hyperv/ivm.c | 309 ++++++++++++++++++++----------------------
>  1 file changed, 150 insertions(+), 159 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
