Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396E3466645
	for <lists+linux-arch@lfdr.de>; Thu,  2 Dec 2021 16:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358909AbhLBPUJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Dec 2021 10:20:09 -0500
Received: from mail-cusazlp17010001.outbound.protection.outlook.com ([40.93.13.1]:10995
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236157AbhLBPUC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Dec 2021 10:20:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/U6g3c60MSqZkToKv/3tv9cDehF1NhqFG7wWvSdhGO23mdX8oqSJF0farvfcaN4VbeP3ZQ1ElyCrOAHRJN/n74YgSESI/PvqXQqDdj3pBVQl++I6TKDcOSv8fZo8rbr4l/48Bf+G1+w4BC3Ex3poh+yJ4dkFkL7ZmAUhOpSYS12fCqAUys/udYMiavEgly3hoMTBiGFVD8rivCEHwHC37n7X2gDCk2eMCaBK3pMmQm0r7NNSndhpDwE6gJ9b/CVtoDtjZ6b1kDThHe2/ImvxzsmoJHSSqbjQ33m92kJQKw5zr8DTYmkRdsmKHeunKsM5nYdm6zh2hHwp4PszQn3BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXuPOeJAPbtwczpiM1Kfwe/KvtCvjVzt9ieOZUplcxw=;
 b=Ko94BSdY/0jxvfi5kJpHTmGDQ5m20/PF9QzWn/qclwnFUDpRAu198yZl6yTnJ3xGvc9+seSUbsHyVh1y57QjgAaaVEhcvpsuVI09rL6OBSINi7nJyGViLoAib0VPkv1burXC5CIU+NcrwQXqJ3o9UvewBQY1keY0jPT5BVUUWatTlJGe9k5yfegKTPQVjS9pz1NW5vr4E20AgIrv9/Hs17s/oiKa74Hb5muePpiCtwDLKLqQo9evnl8YUrZZqFxoiRFMOwV2mkc5kEgmT1OCWxV6k4gDZFOasqf4LE7UN420eGIIhrV39kNcQa79nk4cmp7C3cnOZAB2NF3WE7dqSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXuPOeJAPbtwczpiM1Kfwe/KvtCvjVzt9ieOZUplcxw=;
 b=Drd8fYJFj5bnFG8hIIFuExVVWWdph7dvsNrCfx8Nqfs0em+nFhtpz2VWjTz86l3uIrWVRHzpIg/ev4+DMNm/OcZ8efJSM4gL9EK9xXLDwJDqVM1NfH+miXKCSkQADqS+RB194gy33FoGTwAcvKPN9ARUYhniDoIrJDuEpfDFtlk=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB3030.namprd21.prod.outlook.com (2603:10b6:303:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.5; Thu, 2 Dec
 2021 15:16:35 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9401:9c8b:c334:4336]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9401:9c8b:c334:4336%2]) with mapi id 15.20.4755.001; Thu, 2 Dec 2021
 15:16:35 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Sean Christopherson <seanjc@google.com>,
        vkuznets <vkuznets@redhat.com>
CC:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ajay Garg <ajaygargnsit@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v2 8/8] KVM: x86: Add checks for reserved-to-zero Hyper-V
 hypercall fields
Thread-Topic: [PATCH v2 8/8] KVM: x86: Add checks for reserved-to-zero Hyper-V
 hypercall fields
Thread-Index: AQHXzSJh65/VHj4xikGNZ9FzYT3jdKvufX8AgDAsmgCAANqFoA==
Date:   Thu, 2 Dec 2021 15:16:35 +0000
Message-ID: <MWHPR21MB1593E284E412873C64B54A32D7699@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20211030000800.3065132-1-seanjc@google.com>
 <20211030000800.3065132-9-seanjc@google.com>
 <87v91cjhch.fsf@vitty.brq.redhat.com> <YagrxIknF9DX8l8L@google.com>
In-Reply-To: <YagrxIknF9DX8l8L@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a26e8b93-53af-4503-a5ab-6b6c42f9dce0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-12-02T15:15:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40e5ac26-24f8-474a-c9bb-08d9b5a6bb2f
x-ms-traffictypediagnostic: MW4PR21MB3030:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB303039CACDDA6EAD5D5FFFEAD7699@MW4PR21MB3030.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /q3OxKW94+Kj9Ewz3gSDbhgbORJaMa/zfm7CCOMhATcGJJ73lELOqpKERMqCuMNGZQMPlPgYLe2H0j3gVHKGULPIVyVLEXOHbzaAxIKaJDGzHlcdwPCsSIDNN11NU/6y3Yvl2ljwKpg6RQuqj1fClFHBNaFtxcDQ12Q/mw6KuEs9+9RMK06HKhZlo73N2/6wI4aVa1qkfVtuAnMjBIFa0P1IGJXfRfOBDS1SiQuzZyw9GcKYhBFi6lQBoKeSErgan1P1Co3t2IdaeNj1vycRA17P6h9NauocjAODSjm7aWk8jEV54cKeEgXJugm5fEzG23A0yGJmtZpSa40z+2Uxt/oWbiBst6XsnLIyz4BjZYxMQkIIGRfMvMqHT1BQB+dXpDvKtCisyAvA+rAZ2DxYXqy0q7sby63L4BonzPEfzKMSMeBKfQeR4j3iW1BSANgD1oUT3JgOMu1XUfXgd5G76lUhUFLgAAssa/4NEy6Y+tJxH763YkIWdmLzV5ExV/uReoJN+/djgqm/5d4hHJAHAjvBxJzFAUsOEyAEM0VZGeBcB2AT2MyacuBixCnDAzPb5reEM8yIiGyUVzLBS2g34BIxvamI0cLH/9depGA0f5BLRvUPBubbESo+7DiPf36/z/jv9YygPXZDdq3N/AnVzhXd1vHHT5QsQq0k84GcIL/XAigtwMSp2FEMPKSszXaPCF7uizzazio2b8bkXiMAVfR5qKHj3FMaEVNQbJNdp+yuw1hFkM/chKNF4NG4bX0q0ndwGxjGdCdbKRy7EbLpF91CY/3YeKRO9VbGKxClTnzXgAVBw3rDY9S22iYSsgysGxiOBD0XOHNpyy6/Fsnc7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(33656002)(38070700005)(38100700002)(6506007)(7416002)(8990500004)(66556008)(186003)(55016003)(2906002)(26005)(122000001)(4326008)(8936002)(54906003)(7696005)(66476007)(316002)(64756008)(52536014)(66446008)(82960400001)(76116006)(8676002)(966005)(66946007)(4744005)(5660300002)(82950400001)(71200400001)(110136005)(508600001)(86362001)(10290500003)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8pzP9tZ3jqGvhuppaNuVc2TIHkk9ifk+XKfPJLa9xBv5Mglz9xAAYaiAa2ER?=
 =?us-ascii?Q?3qYW+wMguO9l5u51TGTlfxSC6JsnkZuSZmxfbgb3UTsN+J9N7q3jj5FhAIJP?=
 =?us-ascii?Q?9XUtJ1ejJc52YlKFD5nNHxwwdVCUeaDFyY6dzDVoyyPYqgHwiuBySck7oyQk?=
 =?us-ascii?Q?NgbOzePAwXtFj1bSit5zOA26cOb2gtApZ91+Mk6RSSu1WDqNvKM3IVhgKoVd?=
 =?us-ascii?Q?LAYGbC0jO+rvWuaIGw/f1AWleZiP55Xa+3ndn59sWCj+nBHmUlU48vCKAvdR?=
 =?us-ascii?Q?lf9kqfi++VMHXeF+iK+7O1D5YQK5kQNRaI5ieTpY2V0G3QhdxDmPsmO2abaa?=
 =?us-ascii?Q?nJeeeqhQFG+lqwoVBaVACRIyEVdH2Rb6OzAxHqfnEAGX3O92R3KmYneue2ks?=
 =?us-ascii?Q?xTd5KIPG76y0p4ttz0F0qsqQVjqudx3+caDhiTced/g0B5Gd3EI/MQ0qV865?=
 =?us-ascii?Q?XLDun+sMW5/cxXssfuGGNIy+b3a0BncwLmhWUmePbNW0Pa7qo/27wAkPDgJ0?=
 =?us-ascii?Q?9vt/JSfaMEl4BlBjQ9jUeKR2KlHOxPiTPyMJ2LvsCvIdrFNon6BrJP29qioc?=
 =?us-ascii?Q?KWfJV64FQ0IrWsv4Eavdr2nLJ/08kBKxKRuLqNbnwbkb/UZuCsbd/rzXG0ej?=
 =?us-ascii?Q?xjdJn+nSm6OvnnH+Gf1CpTl96/3+4tzhOwAoCStZeHLPySS9HqPLK+e/5DqT?=
 =?us-ascii?Q?yDo624K7Rqvty6n42N69QKMLQs6bZry70dOsP351GRFmnYwOJTeESi9sft0G?=
 =?us-ascii?Q?ET8VHllG8fiRdbFev55sKA+8mAs0oFxsUZ5YJIpwJS/e0y9VGn3fJBfW2mQS?=
 =?us-ascii?Q?DV51I3cQ8WvAB2bXSPxdMpAGP1kzV9n6lf8dtCs2vI3sRPYaUX+AogMNigv9?=
 =?us-ascii?Q?JrwQYhi4NjWgqfHMGtlKZuEqM4iZdN6BDfQ+5nS0NNiHeQbHdKlMPTszmtGj?=
 =?us-ascii?Q?iQsSrSklzLDxS8AGraV59EF2LRNoPfgU3DZJLZgNJ6v5qLiCbk5yL1QxAvdt?=
 =?us-ascii?Q?+k425IZdrYP8hFlDzs3wCPAv9RGpuo0qUX/uLo1nezJNmxK5uem4MZ3aXAJz?=
 =?us-ascii?Q?KpYwoRTplz8Hkc7Ibg4CrUEkaCq2QNPJPedS9LyQsMZZC5lM5VyzGigj2vYS?=
 =?us-ascii?Q?OwEvoDn1pF2vuPBGBqOXjlcoUwZiDUVl9SOTQdYtwb+5dipWOclMYOKm0jQa?=
 =?us-ascii?Q?V9iYkqZk9CNykAtHKbOB+KbIG9rTvydrjRmolMfGOlMWsC0xHKdsb86QDYjs?=
 =?us-ascii?Q?hDN0V1qIn6H8DI8+RWS4ve8rnTsIvbK12j2wTCQaQfohQ2AJ4CypKFbJ0hm/?=
 =?us-ascii?Q?RnLZNVCyRZZwtL0eh/YsFs2r3H83nicb8lsQYkmiARuiILkNn3pQ+YwrJWqq?=
 =?us-ascii?Q?UWQkBG1IRN8vRTWUtQGE6+ghJFGMj+tewUXJyYI4Jf2SUQDDlXm1k4IHue1F?=
 =?us-ascii?Q?R1MJabw6pQiGhsUjk6lj4pgABLxgCyI9/1Ey2Mo/Ow/wcP48dUo9jLf3UL3D?=
 =?us-ascii?Q?aLSGEznaYrEsSS3uDcDGik3g3jAhsykbzxwrP2OgokbkwvuYUOcNqADk1JAY?=
 =?us-ascii?Q?/XJgm9BaXjlF5cbp3ifWT5UsC80J3Sob56VqmUpe7OGjz2KqYcyy2g35eV0K?=
 =?us-ascii?Q?7yDv3HOIrEdDA6vzF7mVwkSrOFhcKyzNrF7YJ6Ut9kpU6uPTMqM4uq1NlmcD?=
 =?us-ascii?Q?lohwaQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e5ac26-24f8-474a-c9bb-08d9b5a6bb2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 15:16:35.7406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Li/Qvu9m74m4LFq2rZP0ubOD25fzzqVVMmiwsZyzq3SRrhNg8MtVVu3p6jekMl8DvKfGDgDIMBQ4uXXF0YWxXGHwacCp7P9TlP2fEkuqKXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB3030
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Sean Christopherson <seanjc@google.com> Sent: Wednesday, December 1, =
2021 6:13 PM
>=20
> On Mon, Nov 01, 2021, Vitaly Kuznetsov wrote:
> > Sean Christopherson <seanjc@google.com> writes:
> >
> > > Add checks for the three fields in Hyper-V's hypercall params that mu=
st
> > > be zero.  Per the TLFS, HV_STATUS_INVALID_HYPERCALL_INPUT is returned=
 if
> > > "A reserved bit in the specified hypercall input value is non-zero."
> > >
> > > Note, the TLFS has an off-by-one bug for the last reserved field, whi=
ch
> > > it defines as being bits 64:60.  The same section states "The input f=
ield
> > > 64-bit value called a hypercall input value.", i.e. bit 64 doesn't
> > > exist.
> >
> > This version are you looking at? I can't see this issue in 6.0b
>=20
> It's the web-based documentation, the 6.0b PDF indeed does not have the s=
ame bug.
>=20
> https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/h=
ypercall-interface#hypercall-inputs

Did you (or Vitaly) file a bug report on this doc issue?  If not, I can do =
so.

Michael
