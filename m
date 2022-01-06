Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDE9485F72
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jan 2022 05:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiAFEC5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 23:02:57 -0500
Received: from mail-eus2azon11021014.outbound.protection.outlook.com ([52.101.57.14]:37223
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230171AbiAFEC4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Jan 2022 23:02:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLRYfJRVKln1DQlplh/zToZRzFcnzaFKU3mgjZNXTCq/ccA58M+gLXDIJQJxk9c6vUNf6kixsuc1j7ZDuXO9fsCpAFfX3EH+5Z/5xbp5Ity1TI9ZeWd12GxFG6+Jc+CKrJKjznvyjr+p1GoiEKU/AyjhHOyUeDJs+/d1fF7tSnn/74k/rL9K64q82l82fW765X9FIe6ggA1C3QR7KHzALvmCTJTdmDHidjykURSQAKr81CY3F6xIGzXcqbm92vM2zN8Rdq/YuIhUbYiZyTaT9FoKuFOIQNFpm2EY68gFqwQoi3ZTWl8LA1KtC5JBiOzrUpFbXUeQ/AyGDqPmi+ooHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwVsmES8ipJcI0EEie73iHYLhmVDAma+zkD7PWhznXs=;
 b=ZTUW+22kgOq+4qXlahjnImNH+NhbuJm/o36vQ3Ok9N60zWuXzbwjPP7fiahONPzhl/SJsNt0ByYtSL8bOSyPRpZGr1I+q+9g8X50TGxDaAV8l3m2RUTVJOJntBj9MGQnnP1g/FAO/FEfRA3GmJ8fgcC15mjmzy/DY4pfguYV9+vSGpa7XcI2uxbl/Fn06VWyQjvKp6rKtx7I8923wA9YB9/cZzPaadyvZsu0UlytuMfzo+rqbEVFIq7fF8TcBDMCV+wjoyLa/cJbr046u0o+PtxR7YZ+3FWW8TLLp+Oru00w7h3y7lsiYBRFUT40WbKpQ284hnjMMxLPLeigU68RTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwVsmES8ipJcI0EEie73iHYLhmVDAma+zkD7PWhznXs=;
 b=SzAEk1WZpFk2FgPDNXobq1EJ7NLZbPSFVtCUiUtruV7n3wl4H2rYqG+8E8FyXd1uuOIb07M+dXsKKNtyWxHaEMDozke/C0xw8FAjVqY8UKgOSEVXEHnxNfO0wuLLJTKNRM8JMluI2/SYSgBlQKUhuG7/w1AUIP+VPTWEWxjr3Mo=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by BN8PR21MB1298.namprd21.prod.outlook.com (2603:10b6:408:a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.5; Thu, 6 Jan
 2022 04:02:51 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::50dc:69b4:f328:519d]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::50dc:69b4:f328:519d%7]) with mapi id 15.20.4888.001; Thu, 6 Jan 2022
 04:02:50 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Sunil Muthuswamy <sunilmut@linux.microsoft.com>,
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
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: RE: [PATCH v8 1/2] PCI: hv: Make the code arch neutral by adding arch
 specific interfaces
Thread-Topic: [PATCH v8 1/2] PCI: hv: Make the code arch neutral by adding
 arch specific interfaces
Thread-Index: AQHYAmr9Y5PO0PHNsUauY37OPyPHSKxVX2dg
Date:   Thu, 6 Jan 2022 04:02:50 +0000
Message-ID: <MWHPR21MB1593ABA9B4F16C75F957D782D74C9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1641411156-31705-1-git-send-email-sunilmut@linux.microsoft.com>
 <1641411156-31705-2-git-send-email-sunilmut@linux.microsoft.com>
In-Reply-To: <1641411156-31705-2-git-send-email-sunilmut@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=99ca33b1-f476-4fac-b10f-d127c3529327;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-06T04:01:44Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a1fdfc4-cf02-4473-5b50-08d9d0c9687a
x-ms-traffictypediagnostic: BN8PR21MB1298:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BN8PR21MB1298891BF7AAC8FEACEFC64BD74C9@BN8PR21MB1298.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qk5RdrptK6iGa6zthM4gegVMqRspRf0x3MJUnPEwZXJ7lkA9DEtR1fdRFxxD0iK9FE/nyP3H0jHJ3TA8DYX4iOmvRupsTvspz2NTJxL2Mv0kJkkBFvT/Pc+8i2WR7LOGXsRML0sCVJSEp+O1GMyfEW8Y+EW9RmH3aHRZ811IQJF0ABARD3jpb1m+kChb+nJpX/UaQRqz53RaFGzrXSrWw8v0xs9j3fqy9v0/GG7pghPg/Tha+oBOsJBMiLWgaUXSgSTvyRsefEQaHOn1mqKbniKp/jEwQ88pZHWpDm+OqswHpzzkYHFjaPgBOcsI44pM+HWRObLv73K0gLUywDpeDhwifD27cnLiFKT0pj8QC6dC+ZQRZyBRmatwK23GsdIUHvcOsWe+pIq9DkzGmJhC2LAFGsBi3zGNpG814090Km02M4WuwS+zX0caTVKelpxZQNyOYJq5eYmoYGkn7axI0EAHSdiE01khJiDx8mz9+GXlp3MTkxQP5VWjTZiJjr6xacCYvCxBepDj4CKV8349Mi0rl/jc3jTCes3dShofX2v+XrusRqNOqKV7v5w+T5+qd2ZeLSVC1LcaVG2UQiiA9IwqU2xFFr3UaD/7lVELIfkeRz15syr6tP5i4EMYh615M7q8Q89HvRwH6i8gvSRAH5ibKlWLGAs6QBemdMUWAdPtXbuoLfEadTGOF2A00kjLKNMj30tFuYSGPTSlwlzc3j6SDuRrjDtuRF5tBCLop0gvaqjTahq+pU9J+iF4xTLx+u2mSaiw1tyD/J7fHWUqnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(921005)(107886003)(54906003)(76116006)(316002)(110136005)(5660300002)(26005)(10290500003)(508600001)(186003)(9686003)(66946007)(66476007)(66446008)(64756008)(66556008)(8676002)(4326008)(8936002)(71200400001)(38070700005)(86362001)(6506007)(7696005)(8990500004)(55016003)(83380400001)(4744005)(38100700002)(7416002)(122000001)(82960400001)(2906002)(82950400001)(33656002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cvmlvoXTKLeO2M6nu7sxUFkXrqvtu4RNoTiCEazBtW9kdhd/vMXM+lnaK8Uv?=
 =?us-ascii?Q?yEO3B4dM/bovU+ZiiV77spuQ33PjFWlY8LhZKhYgRz42pV/tamzU8eHmuXZ1?=
 =?us-ascii?Q?zh1JHRx8u0/lS7/emnRr7DS33mm9PDpAIbNHmZdR+o0VbYsLKB6sLyDTAx8M?=
 =?us-ascii?Q?++4hD6TwFDJqxjEwRoZ6bxSQuZZ9VvaCOP828U3dWQH1Bi7yKMT9MPM2mb3q?=
 =?us-ascii?Q?4mmdohwXhJjEZdSwjMXT9lckG4DaOTpC4Ao0YIltC1HQQOsYUI/v0V4bjqaM?=
 =?us-ascii?Q?He4syKc6KJX5MGVQ/heei9WnY9xZJSTgwHJrKndLqMxfSrpDWoH5XFMv1JGW?=
 =?us-ascii?Q?9EhPHah5BLcut2m9pAjQLDJfKiu66jE9zPBfg50yxIihHueVmBsLzp/tbF3g?=
 =?us-ascii?Q?dx8PFB+CbvzGTwlJQq6hKojJHGzSlO8hGd/9zG7V2yzCvw8AvPmV8q2yUEni?=
 =?us-ascii?Q?sPx+7/G8/OAM0gG5YzUB/BxaLJMsEmCAgElWEbizRUrDdgS3uALp6q4SGr8E?=
 =?us-ascii?Q?WXxNiXdHgVwNwKs09PWIRqvX3SMTJnbm+UzA9DcYJ1l7IRMJfs4km7WptO4q?=
 =?us-ascii?Q?7AyKS/lIUzse746coCBzh60p8r39wuZYL1N3sH76WzvjDURGdfADvU+zTXan?=
 =?us-ascii?Q?uRuHRXDD5VzCkJXU+ZkHm8EzdS4xRs9EFjGUKC0wB+iGADh83qqXBHphE0e0?=
 =?us-ascii?Q?SApj6RXzDYq2A/W+enbEz7w+m+qu798sR8m/ewBg7KF98AfmNF1RVj83zMDU?=
 =?us-ascii?Q?E8cXr+oJKyhwRovc/WGAiuedtemzwnLazhVI6YS7/AiRpdHAKdWPrIf7giZI?=
 =?us-ascii?Q?CV9G1nsCePVJxaSFSH5ybUj088yg3nVimfk0ZvE4+q4kyCJ0M9mbfXIq2dbu?=
 =?us-ascii?Q?RGMlTCXb0JZj2NcReqRcsCjQ8wUnqVJ65jDNJjGWpvaSHCmG44Ab1sp3mEgg?=
 =?us-ascii?Q?hRy0tIoPiNiN8IzyxVsqp0u/55nawC2usHejiw3xiZu5pgWv/sAZxLovJvtg?=
 =?us-ascii?Q?+LVVvjULKsLfX+9V99r49s9CxtGSwO47UAL16pI7yN4NammJRBgLxKY6eTrD?=
 =?us-ascii?Q?G4dwyQdAOWvIW8fku/AXFGnBrum20wCdYy4OLXTyRiu3jzkf5H9Sym6kopG0?=
 =?us-ascii?Q?CAvBWBbgX3UPzKLkC0D/4iVLV9t8p25a/XA6jBlhge0asGKkUpx9Z+RMOFl+?=
 =?us-ascii?Q?Zjupq9C9V1kyLxGDxz1Fxjkq8vrujN418u7OgvTz88MSCtkuyRGfxjRwUV9t?=
 =?us-ascii?Q?ZpX2OoFS/fqv/hWdCT3wInuXMgsbiZEWA9iPxkVc0thZBhtVuH3NtIJVnFb3?=
 =?us-ascii?Q?j0q8aG5unkrSrPGEvDj3zvpml69QHPVy7B3Cg5QzJ7YciLOYSefDEsvlezei?=
 =?us-ascii?Q?w3da6He+SeqMy2eV+j5DkNg71pMsMnEABZGWiZYNOCsKo/tdxytCLZQfCQNX?=
 =?us-ascii?Q?HSd97s8V3sUQENiHIkiJvuKKxclQj+y441akGP6XaftrcbdQITWrhQojonP4?=
 =?us-ascii?Q?90y6K3OHDbVailKjV8VcWdipjZge1G34HFIRcO/2/A9vH2/uBcQ0OUYRXEus?=
 =?us-ascii?Q?5hXE1hRjQwy9KWOr3RXVJR5lHg9sZodULdroxBumPsk8Roc++TmBaWe2xQ4d?=
 =?us-ascii?Q?oAy6IqfCUPZ5q33faLhJHjllmQTFK5fwPildHXotSHqneOjmgWbdJnRUUIFU?=
 =?us-ascii?Q?xxHUsw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1fdfc4-cf02-4473-5b50-08d9d0c9687a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 04:02:50.8189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H6qh2b4JBrZCLpFuxVHHfGGcYjSKggG65mD5zxHMBDyEB7jWPJBpxc4TkxtYEopNqzk9rmjIj+AfkfqoXCHX8Z7YjycBRx56KjStt+6QvLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1298
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@linux.microsoft.com> Sent: Wednesday, Janu=
ary 5, 2022 11:33 AM
>=20
> Encapsulate arch dependencies in Hyper-V vPCI through a set of
> arch-dependent interfaces. Adding these arch specific interfaces will
> allow for an implementation for other architectures, such as arm64.
>=20
> There are no functional changes expected from this patch.
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> ---
> In v2, v3, v4, v5, v6, v7 & v8:
>  Changes are described in the cover letter. No changes from v4 -> v5,
>  v6 -> v7 or v7 -> v8.
>=20
>  arch/x86/include/asm/hyperv-tlfs.h  | 33 ++++++++++++
>  arch/x86/include/asm/mshyperv.h     |  7 ---
>  drivers/pci/controller/pci-hyperv.c | 79 ++++++++++++++++++++---------
>  include/asm-generic/hyperv-tlfs.h   | 33 ------------
>  4 files changed, 87 insertions(+), 65 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
