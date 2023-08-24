Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3721B787116
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 16:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241278AbjHXOHn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 10:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241503AbjHXOHb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 10:07:31 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020017.outbound.protection.outlook.com [52.101.61.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC2F1BC8;
        Thu, 24 Aug 2023 07:07:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSZ/j/zkgV+wpXBwVDgHkjO6WBNqr7J5CzfFPZFg8Ajhpqb0E6R4zWpDY1xoyumx5jmePa+dLk5huJyp/xtUGhpFczPUieZUCrKiE6BPwmskrukuYUqFdopMWEcqfAPz6XVO9uPPuikjAjFdWfXyK4CYJZdcx3ZgFB8U3PzF8ilTseQ6XV1alWtGzl6rU2jZWSqX/sKbCCTq30s3zawdsAD3W08tn0JVvgqVbPC+xzqwCpcNKWZmLXIFrlk3e5hWHnCKFYanaFuKmJyUzSN+BQisJ0UoHEeFbnAKZ5nk3Si+7PBs5t446k2p8Bcp34zFGSsmZnA2uSnPk+QKYGU6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51yXcvNmM3igKtZ+TLao7qUv7ivWHFO5ur7yi26FmY8=;
 b=JiLDfksu6orpATbntiyPmNY/+PvcD28izFP6gVxvtRc9JsMxkWsxNKIiIJuM3cK3OekZjE1BPIlizK8FCAifqjoxM/Ls/8RYeYLBJcJo/X+pJdYRGBHeD8PEfD+nLKjnlFLTHe7dHPzZ6YKSpIGVyzaU3o6mr2FYsUPVT0Mw+YXa4AITVEpkPwBXGF4y6hl6l4SbMFMaT9bvPUFzaMrtTVxw5ssaNaWqP8rVaQt5J1hbIFMrgVNfwQUuriBdHfv2oYAfz7Wu5nbklu3iG8gSlm+sUkwlvZKz+cQ+xGndqJnE+u8jMSPd2/Zn7gVWOjZ5nJWMD47qSMDmZvAya/Jofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51yXcvNmM3igKtZ+TLao7qUv7ivWHFO5ur7yi26FmY8=;
 b=SrpLJEj9kUHmZjtdU8sHIJBgoxnLbj/HEik6gJNx7lqz4/QdKfCSa87BFN4qtlz/LzQw2tnEmF+JkueWBrCn7mchZfNoK0XdsUDPjq3BiSj0KhXeLEADGo3hiKn0QYx8hacy+j0BuiNA1qZS4j8HDLgZQbopSsr7bI6oIuGyUUw=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN2PR21MB1533.namprd21.prod.outlook.com (2603:10b6:208:1f5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.6; Thu, 24 Aug
 2023 14:07:23 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f%4]) with mapi id 15.20.6745.005; Thu, 24 Aug 2023
 14:07:23 +0000
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
Subject: RE: [PATCH v3 07/10] Drivers: hv: vmbus: Bring the post_msg_page back
 for TDX VMs with the paravisor
Thread-Topic: [PATCH v3 07/10] Drivers: hv: vmbus: Bring the post_msg_page
 back for TDX VMs with the paravisor
Thread-Index: AQHZ1mIhcicL42dbeU244QzuzL31Aa/5e6rg
Date:   Thu, 24 Aug 2023 14:07:23 +0000
Message-ID: <BYAPR21MB1688C7407CB6BA9A540F5683D71DA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230824080712.30327-1-decui@microsoft.com>
 <20230824080712.30327-8-decui@microsoft.com>
In-Reply-To: <20230824080712.30327-8-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c9f16ba2-cbb3-467b-ac64-7e802dd82122;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-24T14:06:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN2PR21MB1533:EE_
x-ms-office365-filtering-correlation-id: 932ada72-43dd-4d44-d94b-08dba4ab708b
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z+vcTlZ/23xB8iobF2Nnrm0Sa4QS0a3M+GU31xq/WAVtQm2RIoGVyC0BKlu6Fi8hgAu0WjjjmgojcJwGSFjmo/yQItc1ZO3fAWHo/Sz9Xkfqr6CH+a09SFQmQkFSX40OmXaygabu0WgJM+V/tpK6SDSYbZJT25yGarvJU58Eb5CqScCQZO75m00dblBNEYooI2ZpMJ22Z2hUKO5HVd4VkIlGaA/IbnUkw7u/IKRCRE8NkBLYMq1Tq6r1M5wiOi90vaUDGzUmhISkjuEGD8Wt+5wHrGaEj7kNb7pRu8zWdlcfLoXTOU0/lbzli0lHm5TmyPsEtolZdJ2n5tot9uJGJqnEo3APgu5i8drNy32Pm13YAD17XooBZcHIuxe1NxVRIfq1Zlvrr89lXE13WqxEU8tMsRY5ldGaaknmz85/FT7I/I9JwSUNrY0ATBFDbnSqVpD5d6Qvki4cOlVcCkZ66E3ddPcVC/cFCN/w7Yg2qAsBd63G2uqnl370N7xA/vwFD4Wgo+EizePNTBF8Vbrm/rFpRX4csTHr6rlhvrwaUIhztIXf7ONjgrVEw+mXtn/6VD+MnDyrHl5EzSeXz24kKbKFrLTsOYUE5I3dQoJ+QhN2LCOAwVBKrYqd97ed2gGsyidHynbrcEC+/fjnetXAg89GYaoGWcQ94aLqlCWhE6qhBreMVh+mB4GogyNIzPEkx1t3s2FFknZtL5lddqwiiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199024)(1800799009)(186009)(7696005)(6506007)(71200400001)(10290500003)(9686003)(478600001)(83380400001)(26005)(2906002)(7416002)(7406005)(110136005)(54906003)(8990500004)(316002)(64756008)(52536014)(66476007)(76116006)(66946007)(41300700001)(66556008)(4326008)(8936002)(8676002)(5660300002)(921005)(33656002)(38100700002)(55016003)(82960400001)(86362001)(82950400001)(122000001)(38070700005)(12101799020)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d+G+KTXvHBvJzVN3z8f9JsCJj908NogFnnD4e6+SlprgB1hPcb43jfc1hRMm?=
 =?us-ascii?Q?bGHC7OavFOF11PA/cViL5CTz+YYikq3ptQYAZ/pnBTx4GWUc920uPcEIzl+8?=
 =?us-ascii?Q?4tz0s+EUKHYcKFh0jdTNYVs0HzD4qs9FKrd9YT5hn7sN2DNUsiAXKgXepwNp?=
 =?us-ascii?Q?3exq7eXsH9Sj++zlm5V7cI55SC08gym9GKotzcg5AprQDYpdWm2Rr9iepv/Y?=
 =?us-ascii?Q?iqfZaEbreHE7VGnlp1N2l2lhakq+p8JyqcpfNj5J3z3iFNwBJnbmpDK2zBvf?=
 =?us-ascii?Q?+A5m/JvxUZRQtqnXC0FJzxFvclxJ3eP19ABbF7/KXX1ow5Ni5qVXebVcMXWE?=
 =?us-ascii?Q?cwhi+4fM6J/PVakljlkIuSG7XMQL5GTLhwe8ZTP/gRwZMcRNCFzQKWcoJ1i/?=
 =?us-ascii?Q?+JD8P0eXXDOrPQG3mqVtQczlib+5/jWWnFZr8ZzdF3JWDv/VrAJm11xswvDW?=
 =?us-ascii?Q?mXGgf7xzWToRavWkIZzuu4g8rSLfCGb3a6ZSh7Qfl1xc2uIa/+mhaWvDFoLD?=
 =?us-ascii?Q?Zyp9TtsDxkXm5RrYyGKMJfLmeIxodltqFyFY8/T78fEfOIEsiSprM1eldcRv?=
 =?us-ascii?Q?A93DiySt5U8unO86xPjnv10bHgdTtGXyJDEABokbcuoUBvcWsWYWJsRa6JWk?=
 =?us-ascii?Q?2Sop1C4hcbfuvN36J03xY5wbTfAgudASqP9EnCYJ4NM/HouNirfwXJ/Fzeyz?=
 =?us-ascii?Q?lc90yTX3aXvDz4H0f8EfNRZ11hGr4o0aaK9lrO3nUJnlsksReQHNuduU+x6s?=
 =?us-ascii?Q?VLVK+HhPkJad5bisfBnTpEgC4LgqEI+MDq6eiLsV28Ik8nUGq9Z69ocwGuR6?=
 =?us-ascii?Q?RjXxlSkTpxCdLhOpYrC2At1E68Smuhcxo8wa+c7/605a097gwugLJU5uhFcz?=
 =?us-ascii?Q?JCqOZpbufnCrT7VJ19U9zosMd9JC2/Obow2iAaRe6VDIbGNEMyWANEKOnnp6?=
 =?us-ascii?Q?hKj8yU87D9dElKtkx638jpEaHjDgIYlI8KGYKG94StA/iJ/tP6xujvE2lrEL?=
 =?us-ascii?Q?7eXR1iQlI1hz/mVnhSq+3GsiEhOrN2VX1VYbmvRi8hwzSMNQYb3X7zk5TB0L?=
 =?us-ascii?Q?3yBJs3N9L0lh3beoCUJO2ied0LzKdPbzcNPP9flHS+GMBgdp0yIWsJ9T88Am?=
 =?us-ascii?Q?m3SzatZ6EoqKi2cVQaTRtK7bPhDdTsOU1EHxnB0o+wlTwSJp1DFY3Bdq7EES?=
 =?us-ascii?Q?QsH4ncw/Ob2PDzXIGhwJOuh+rGDm3UiUhyETmiHNR3UgG8rhNnwFZSxcmz6a?=
 =?us-ascii?Q?7+FLYzFj2WdqXGCb4bE9ZNCrmgAg+2VaN+/ugD46qSvBruqwVyN8xWNTE3ig?=
 =?us-ascii?Q?bxj+VkQtay7d5cMij4FpwCixbvVl18hGXzGvc8zMeeWJwhYJwwCXRMHycX1q?=
 =?us-ascii?Q?yluUZIcYLjPNX8oyDxO1we/5Cny9NAP7iniWGEKXzlXmYopchxakJ9thUiTV?=
 =?us-ascii?Q?pmKgyyljUrnhHqQdPyRIYZRW8zqS+gq0Woxu2wVi+az1E0C128/Nldqrc/Om?=
 =?us-ascii?Q?mcxhx7nd5179J9g2HCt/ZUGPHNvENo/xCL5dg3uabPcAQQImYhpuJP9H1wur?=
 =?us-ascii?Q?kKXM/J9xkTTGadak37D5FDlkomm098T3ykIYhbokLFzzT4ZYWtyKwSbGreIm?=
 =?us-ascii?Q?jQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932ada72-43dd-4d44-d94b-08dba4ab708b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 14:07:23.7358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sFF5LlsFaUlzb7hNAN1Q2emXgszvuFWjrp4cemszlKXpJuwGGKYHAMntpY2GOtPamsYMQ1sjv9kKtP+1ku4VuJp0PiYU6sHnHRyZTRn5I5I=
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
> The post_msg_page was removed in
> commit 9a6b1a170ca8 ("Drivers: hv: vmbus: Remove the per-CPU post_msg_pag=
e")
>=20
> However, it turns out that we need to bring it back, but only for a TDX V=
M
> with the paravisor: in such a VM, the hyperv_pcpu_input_arg is not decryp=
ted,
> but the HVCALL_POST_MESSAGE in such a VM needs a decrypted page as the
> hypercall input page: see the comments in hyperv_init() for a detailed
> explanation.
>=20
> Except for HVCALL_POST_MESSAGE and HVCALL_SIGNAL_EVENT, the other hyperca=
lls
> in a TDX VM with the paravisor still use hv_hypercall_pg and must use the
> hyperv_pcpu_input_arg (which is encrypted in such a VM), when a hypercall
> input page is used.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> Changes in v2: None
>=20
> Changes in v3:
>   hyperv_paravisor_present -> ms_hyperv.paravisor_present
>=20
>  arch/x86/hyperv/hv_init.c | 20 +++++++++++--
>  drivers/hv/hv.c           | 59 +++++++++++++++++++++++++++++++++++----
>  drivers/hv/hyperv_vmbus.h | 11 ++++++++
>  3 files changed, 82 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
