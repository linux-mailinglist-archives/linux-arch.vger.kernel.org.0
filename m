Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D071F44B30F
	for <lists+linux-arch@lfdr.de>; Tue,  9 Nov 2021 20:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242976AbhKITOU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Nov 2021 14:14:20 -0500
Received: from mail-cusazon11020016.outbound.protection.outlook.com ([52.101.61.16]:55004
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242971AbhKITOT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 Nov 2021 14:14:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ie5DP2e0DrG7Lxl+E/OdrmxvjdHrXqgQTT03AOkeCOQa7ydCQkUvALFnHydahZ2To8F7HHMtuYQtI+ltgLOWaHjR/010lzov/4JIae2O+ugLC/1aXxB6MNFN5TB5k4KFdYljIoXWHqJkG2OedFYm0w+eNehPLM3J6EbuXE67Tv4AUNQLNiY4RRKx3gJ6Dmkb9yCPpFzO+I7dS9UCUz5cWmu3mhDkUftO32jrUmbWfDVxPxgFnr4uznCuOF6yMJFrCaQY4p7CajTAFX5VCb9ez4PkXTbv61Sc48GDbS+xCOiKb8sJDDAJFDg2+S2a5/ldcXiOn/8YChbYFBW8+nZZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3Bcb1ZlpyFnveclqZT0KmlcYzd8G5+hIO96JlpeFL8=;
 b=GvEca2GO2VcnFP//14TligCxn8oLlYl5YGUD36hGdT9lLsbAO3Omi1yDBz6F8NVbPxPYCRiFvqyxY+I23G0gsTjOcGfUsgTAb6eK7vmvXinxDVaofUVZ5xSLT6p+W+pDM0Lxwegxo0QmwBIO9o2HYaj/VhXvgxXR9Z9FOisZpsNUEV9fyINfOjGROuOw8gjF8g6/NW2uY4Jel3vduZ0V3nLhny5UsTe6wZsmJC0YAOzsJ0I4Ff1L/IPCX4Wim7mvs53H9WMm4doKOB1jo3vS1MvMmRZ81BybZt4KZsSTCiG5VwTMLqKa5ANdSaPijvNEa9zRVJrE9yqenfBozvkhww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3Bcb1ZlpyFnveclqZT0KmlcYzd8G5+hIO96JlpeFL8=;
 b=ZGe0VZ8QDz1ca1r58FQ4/zFSjhtME7rbnr9DdpeqXdatU/XGnBmYIhE8QAVmftTjPhCYj50AhnifgaDDfQ2pHGqCKoHn6IHmuVrbDd6ViRK2qWFx9bOG+MhlPFOO5Zc50QX5lyE0ef/XOlXk4Luqg/uMz0GUrGFBB00JFPCv4a4=
Received: from BN8PR21MB1140.namprd21.prod.outlook.com (2603:10b6:408:72::11)
 by BN8PR21MB1172.namprd21.prod.outlook.com (2603:10b6:408:74::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.4; Tue, 9 Nov
 2021 19:11:29 +0000
Received: from BN8PR21MB1140.namprd21.prod.outlook.com
 ([fe80::48fb:8577:ba03:23a5]) by BN8PR21MB1140.namprd21.prod.outlook.com
 ([fe80::48fb:8577:ba03:23a5%9]) with mapi id 15.20.4713.005; Tue, 9 Nov 2021
 19:11:28 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Sunil Muthuswamy <sunilmut@linux.microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
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
        "arnd@arndb.de" <arnd@arndb.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v3 1/2] PCI: hv: Make the code arch neutral
 by adding arch specific interfaces
Thread-Topic: [EXTERNAL] Re: [PATCH v3 1/2] PCI: hv: Make the code arch
 neutral by adding arch specific interfaces
Thread-Index: AQHXwRPKo1wIQ2n9aUePdw/5KVA2savcRmmAgB9xZ6A=
Date:   Tue, 9 Nov 2021 19:11:28 +0000
Message-ID: <BN8PR21MB1140B95A5D59F9119CE35421C0929@BN8PR21MB1140.namprd21.prod.outlook.com>
References: <1634226794-9540-2-git-send-email-sunilmut@linux.microsoft.com>
 <20211020185709.GA2630556@bhelgaas>
In-Reply-To: <20211020185709.GA2630556@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9b86821a-a139-4a08-b329-d10c08952c7e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-11-09T19:07:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d948588b-781e-43cd-3c97-08d9a3b4bbcb
x-ms-traffictypediagnostic: BN8PR21MB1172:
x-microsoft-antispam-prvs: <BN8PR21MB11726527A5FB531CECED7DCAC0929@BN8PR21MB1172.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: urcjQn0nnAGBHsziW9PRXfRqUpFPAI8zp4WreE1ItoOQkbnpzEkaapiCGawqH2FUngUSvhi0FJwJIFr1a/+NiPhjbcPb5QYx+H4flQW+fCVdRjpnK1G55mbUjhCXIfBe7MXFY5FOKre9h4UZZ7PNdxu4hOjFO+yW5viIzBHWwHklyfjbYm4acGRSa+uRUij4SYi8MQHgWwpJ6RiWTyk3hcZfoN1BKLUBCwQiaHYg37DqO1hwwWLJe4l1tGuhTLREiYoy93IjIdxBTUD4PbE6nH+ZRYttiTOJPHDG/Luny4Y0u1hW8WssvmjOE63OMrHkth2zv8DqnJqenBvThyauGzj1uaCv692AbgZ3W/f4ByVznQXqpsWOWI7R41dTOG7RYudbftXxV4JmYbKZRRHkkJK4Y1/8Y7csISgPFQqDqvyaYXhM49254ILVVLGChCKSh8104WpbLp77k08Q/1Zwr/aRbRF2a5GB36ABnK4StCdt34XHiveVIaMuzu8NLlz1JccM61M4o5lbR01Pr5P33l5FibOqGQP1+DGcf+XCmoJJCh5pr81avniknZ8tRhQy8Gen2M0R0MDd9FLZ+0bd60M34oTwjkpJPurX/YBGq6vdEbCTaN6WJUhPg9uZnmYgPnNmdddGpQthYVuH1AbtdCRLgk9WF1zo4UOkF0F1mQB8p1Eo0suP4WZnqKIxcxR0MQkhjWJLlzTh0a72N4pMcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1140.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(8990500004)(82950400001)(10290500003)(66946007)(7416002)(508600001)(76116006)(38070700005)(66556008)(66476007)(54906003)(316002)(110136005)(7696005)(8676002)(6506007)(66446008)(4326008)(71200400001)(53546011)(64756008)(33656002)(4744005)(52536014)(2906002)(122000001)(38100700002)(86362001)(82960400001)(9686003)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TiDYrGsYObH9Shq+/OrSKYQstj+au6VXQYpDhRiGiuxpRQx6n/OiJgG+45AZ?=
 =?us-ascii?Q?YUFYGeWgz0EIR8THm+p9ANAkBQiNHcwulNTsYjUBw9vXM61bJ8Rpt+dJXO82?=
 =?us-ascii?Q?DI7vPvR7nihTVxu9+lBrVM9/fhMs64oVItGFYGjt6c4T5gYtjjcaQ8X17ELp?=
 =?us-ascii?Q?6EokNUjiN3E30G6xiO1kbmjirQ6TyBNpDEqChPLjyIVss3HNcxsAGPSRtcT1?=
 =?us-ascii?Q?jSw4uw3il02E/qBPZCGZeJmKaADGMKtoWyTXwJ5o9JlBzRyYnBtDmdS96p1m?=
 =?us-ascii?Q?qfJNt0MjSWhYjaiNi/Z7o1E5YPVYDsSjgN5ngJWzinBtNiTkvS6hYoX+oUab?=
 =?us-ascii?Q?veUDITvOdNYgH2nbB+68kgFNJLuGTIhm/3n/1dRhLEJHQwljC0HcKIRLJzTq?=
 =?us-ascii?Q?RIqwHP/Hf1TLMQHW0CUXm/CiDfTcDYg55h4npQJ/HIMwH8+5O3/MeAP8IbhK?=
 =?us-ascii?Q?SXd+QKbODL6t6pizW6mYASVfO4NSEJr0RCeN2huvnvI8MY22/IIwy56DwWmV?=
 =?us-ascii?Q?ap+0EHFd5t7F8FVMrH6tvEpp6BbSo8wzLWphhaaMy27dOctzNYrX4QXUTMHw?=
 =?us-ascii?Q?q1AYHBzvfGt+iHUH8hHdVBZHw43GaMM6sMtl0NZQkNs6n0JLBGUF7HZozuKK?=
 =?us-ascii?Q?7oGlWEatvk++B/gR5v81IFT46Hsgurj+A2NthCwyDQEo8gJmp24ETRh/SXlE?=
 =?us-ascii?Q?FsXMo3HntPIklpW3mJe1NtCl0E4t28BO4SVzgt4dT+nf3uDcoVnG4MH8l77Y?=
 =?us-ascii?Q?0YE+d5UDnzqnHFRreE0klXAanWAprVkwBuB8PwZWfVVY49jXZR4godgMPOFa?=
 =?us-ascii?Q?squhK4wrKo20UMdEmx33K7vQsVe+5C+fcnrFRdetS7usB1W2HWLgNSnEgGsy?=
 =?us-ascii?Q?umKs0+a2a0JC3wrXpOx9ZixB3hIA0MtuebYv7rB3R65WJndVBwiLaYH5DjPh?=
 =?us-ascii?Q?O+y5H/J0/FDxGDbVNiDjVdz2bR62kH4nySZ+VLVW+uoRLRYBpNFJIl5cr1l4?=
 =?us-ascii?Q?eIeUNtrRwYi7q2OZg/+qvkkRnju5VrsEwQ2S9WPksMOz09rf+GL1iQivnOQl?=
 =?us-ascii?Q?K87Dhm+KbJvJppfbYX/J3/Ps8ZkCVQmDjcAHrhb8OK2rYCi9jVvSN4f0ZnsP?=
 =?us-ascii?Q?qK7buRjPktIOWDeVHcp+iriKVeKBNBgJkkmsJtYbBMbZE+mbtcIRoObOScqT?=
 =?us-ascii?Q?z4PUoPfq+/Voi4oytG30S4amR3eGzKk/X2+0ZzTlo3uROVNGgOrXo4dgtBNZ?=
 =?us-ascii?Q?VlUm6M81fQF/WtkM0sR2ofi1RbJIC8MDm9q0NKw9DWm72Uu19XlUKSNqsLTf?=
 =?us-ascii?Q?9R2uaDQcfS6d8r9gIACh043A4FXo3AbendNdtI9E1AvxTUcM/ikRjcP17SJe?=
 =?us-ascii?Q?HpBJlUQGJ7VMvqnF9b0DJiqEa4q8WTm/vGu5Gz2I6Q7zC+He9ZFuUKMBM0dm?=
 =?us-ascii?Q?ZG81GulTM4k+nghsv7CfwjE32Yi+Xo3nPiELH0PWMwZetYaQXymhCusoygcG?=
 =?us-ascii?Q?elWhKiWgTBYZEaicSHfz3GzqnL4rJtcqRiZJMtlM/SbfncLfrfhK5enpJIOg?=
 =?us-ascii?Q?YiLSQ7V+Csy481/KoqmyqgBpYGDJzhZwNH7uuNifRhggkO/gLVYxD8DD87WR?=
 =?us-ascii?Q?F8ve8lD5Ubi3Oye8FdOChQtRHm7t63Rdpsksjb+ADgliLwa20hDorrcjlsuD?=
 =?us-ascii?Q?cUHRzd2yXaf+4UVbf5V4Avc1NiDR/FPpBuof0wKdvJn7NIBeDXTiEIb7TnjE?=
 =?us-ascii?Q?Un83/k4tsg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1140.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d948588b-781e-43cd-3c97-08d9a3b4bbcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 19:11:28.8176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KiFEnWIJbW8ZPMW48mEqGy9rJlmJr9W8oqOybDjouC2aLjFdaACZzj+8hi7NkzWO/8y4fej9PNIXnOEjWuwOZjntrUE7lQeinjAVXzXxslk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1172
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wednesday, October 20, 2021 11:57 AM,
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Thu, Oct 14, 2021 at 08:53:13AM -0700, Sunil Muthuswamy wrote:
> > From: Sunil Muthuswamy <sunilmut@microsoft.com>
> >
> > Encapsulate arch dependencies in Hyper-V vPCI through a set of interfac=
es,
> > listed below. Adding these arch specific interfaces will allow for an
> > implementation for other arch, such as ARM64.
> >
> > Implement the interfaces for X64, which is essentially just moving over=
 the
> > current implementation.
>=20
> I think you mean x86, not X64, right?

Yes. This will get addressed in v4.

- Sunil
