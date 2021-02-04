Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEFA30F861
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 17:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbhBDQrQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 11:47:16 -0500
Received: from mail-dm6nam10on2132.outbound.protection.outlook.com ([40.107.93.132]:64512
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238136AbhBDQrD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Feb 2021 11:47:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYEA0Z4aGqW4hi0xqUtDLUSQ6mWyJ8diJkhK5sAdmOr4QtmkrdwZHU5ZOoQHSsoUA6Cki/ZDKjCFeeYM4fGcnMZVsDGm0MsHJNAWLlZbwMUhM7Ox36x2Kn0NJt57Czpnbr7/q7Zl6oqF27R3XuMI4XFyng4hK4PQqDEJlHC55aIlRs3S36IK+tu7KikMxNT8t5Bd54riEpwwTZmu0Wy+uIiuLkVkid50LqgJjNknedIDK91QiOVFZYYf/COYQ1zm82xZzRiaZIeaUUacsTu0fxTIUlimxoNK7BM/j0l/p/MuoFXsRui4A4avoo/xzygHHQG9PhjMCqNzwvluwZTCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fmllhiJL868aD5I8hJGzKfZ7SNim/ZdzlMRxKubEuc=;
 b=BxLyMPPZkCcoGobvnXJ7PMKcZCZK/+K3etyPEs9H3430y1OGSMmdvOaFth9Ud8ae2RDsS9SU/5PBqskRL+GMl/QitGL/G7IL2fiXUFZS2+/oqEFQaOrIM9yiiK+We9Rn45T9UzSiicug5DyW0ptAAzAzhC9t06L99GHd3qaqebUJv3f0+8OVlKlm57UCdyCbgHnnsCzyoru14A77kUyB1MWXe2AIDSm3cs+4zgwCZJNVkQaKigbLjet7zOtHbqQK0QzQtKIUipky1krUAVGMUq0ZDXh3UgDmKA2Htf+J9MhRF23mbf1XBluuwbauX86wqLmFijBWVYIakE6KumO11Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fmllhiJL868aD5I8hJGzKfZ7SNim/ZdzlMRxKubEuc=;
 b=UkyGdaqePc44ckJSeepATg+NGTiczdFoTIbR2x+Z9bxxgHDPZdqMx61tdbGRSVftWaBlum45OA+PjhX9ddxG5WuM7T9CN77C6ckG6eQDyYRM3JdwNBH9VLpJe3FEKWwOVmaoZehuBqnuvLk885lFgs7yO63i+fTBwf6c21wy0gU=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1874.namprd21.prod.outlook.com (2603:10b6:303:73::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.3; Thu, 4 Feb 2021 16:46:15 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3846.006; Thu, 4 Feb 2021
 16:46:14 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>, Arnd Bergmann <arnd@kernel.org>
CC:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v5 13/16] asm-generic/hyperv: introduce hv_device_id and
 auxiliary structures
Thread-Topic: [PATCH v5 13/16] asm-generic/hyperv: introduce hv_device_id and
 auxiliary structures
Thread-Index: AQHW7yP3XhY0LOeCcky/eXuYzxnTqao5JVQwgAwG2wCAAVXDgIAABquAgAAFXwCAAb2OcA==
Date:   Thu, 4 Feb 2021 16:46:14 +0000
Message-ID: <MWHPR21MB1593E9C0DAF03C9B651D15FBD7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-14-wei.liu@kernel.org>
 <MWHPR21MB1593959647DA60219E19C25ED7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210202170248.4hds554cyxpuayqc@liuwe-devbox-debian-v2>
 <20210203132601.ftpwgs57qtok47cg@liuwe-devbox-debian-v2>
 <CAK8P3a0m8jEij-RdP1PTcNcJW2+mXQ1dA4=s+JLXhnv+NyFiHw@mail.gmail.com>
 <20210203140906.g35zr7366hh7p5f3@liuwe-devbox-debian-v2>
In-Reply-To: <20210203140906.g35zr7366hh7p5f3@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-04T16:46:13Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=650ddec4-4cf3-4e24-8b94-27b26c42fb3c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce517e70-8b76-46ea-758d-08d8c92c6301
x-ms-traffictypediagnostic: MW4PR21MB1874:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1874714BE877DD3E444FB5B5D7B39@MW4PR21MB1874.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CQlf28DwhaeQ/++jo7N3rzsaOUd2H5+OvkAx2v3vgx2wgPlvQxB/mYetWLCeB2MeeGunyVfPbQIVR1lcT2vsraw6K0NKG2KQucCYhVdSE7ZlDkmKgm8U3YB2jvS1HpvehKVTjOgarpkwIC+OtJGlIoOH4ElgsKDNsV/JEgm99HORBWp3HrYP3j2t9aHHOPcNu3uUTnU7+/tUvI7WwseUmYSML8Rrrd7YHY5WuOFuVOdsdmP9k6zQndkDMlkSnYa3XOVVqoAf0YC8dOf6CNRSMPo72TX7jJd3y2eXr/eA/0lZUYZdZimHh6opfNyA9TV+YZRQPz/7wkeZq0KTiMaxsIQ08qBUGYQ5fF87a3MbsRP5aWiaT+68aIrzNtvDt0p6B7uSdOmox+g3zZkIVhYwunuDOxsRc8tC2gA75n6HBGTth+Vv9sGLV7JFN9W4oXajn2on7j2lIIhF+VJ+qjBDHYnAJg/CedYQliufLYV00mMcxSHkfUwxfsj+q+Bz+CM5He8q/YB1+HkP4puIqI6j7A+/M076zb76hFAEs34kzR3FF3ItVWT4zN0txxWLRh+6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(71200400001)(83380400001)(4326008)(76116006)(53546011)(82960400001)(82950400001)(52536014)(64756008)(66446008)(66556008)(66476007)(8676002)(66946007)(5660300002)(26005)(55016002)(9686003)(86362001)(8990500004)(10290500003)(8936002)(316002)(2906002)(478600001)(33656002)(7696005)(54906003)(110136005)(6506007)(186003)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vguOHSziFoucmR78902z0Nar/MjbTjp4yaR999vT5L6P5BIPDil77NRDKaYV?=
 =?us-ascii?Q?Wzq23M3BX44EeGEiX1ssqJt8Mp43EyMFVzZDhO+5IuKGFa39MZXiRVGRomZi?=
 =?us-ascii?Q?t3pJK6mHdUUsDUYCiqM851469mkD6W3wdY2xLNnVYRo8A6bBhuRreSOtoOAS?=
 =?us-ascii?Q?fsscO0KLvRucJMPoAXUfpYldmDdzgY8mXwRrDhDKFzqwJYC4MCUo2WoUBrNo?=
 =?us-ascii?Q?nFxrYIzUh7VdsUeBXrt4x86ajlAZgteDEhXzVZuEKYWu+YDPhnL+/h7tPOBF?=
 =?us-ascii?Q?xSMSyDg9iNMaLUZ/960sd6w2XrDK+tahOb93jOkBxklIcILv7LQ7CMfPFzGU?=
 =?us-ascii?Q?6pV4FsQEPYo3kBKp83hdwqkSiyRCI6Mz3CVa0aNFfo4jleoeP9BkcKEGeAP/?=
 =?us-ascii?Q?PoXGk676wAVMEgo+F6EfR/c7j0kwMB2aLow/hXyOCEyYXMTlhi+lOWfM1cdb?=
 =?us-ascii?Q?Kel4MFUDnR0SPMQ4i0LH79GBq+vuXcAhFS7p1Teb/HjrFCoci9twnkd0ASF1?=
 =?us-ascii?Q?HMYbMm95pB3yMwGjktlgDj5LzGaejHGeBWedEpXkw2BKmxtzCvy++un2k07S?=
 =?us-ascii?Q?EAhCw24AZMG6vJMhAlJ1YNvSOrEetTbK3owdLAUWDJGI5dsRtOB4hmY0xCTP?=
 =?us-ascii?Q?O0VOXLHqL8jfvwhWZOdckAfdOTG6mpTtFiQqQi9JvzGpc6TT19R/8N031/dp?=
 =?us-ascii?Q?6TBlSsIj4s+CdYrjuTj9t0XX3mwI5jRi9Xp7bEAQT5zJ9QtWO4zyo+PNX+Ws?=
 =?us-ascii?Q?auX3Y35uVGpp8ucBgaG3FwUp1ehtOlnJrezBXeek+afdbCBGk2ZMlcs4iJky?=
 =?us-ascii?Q?r4mf/qkuMdTpIBN4p35LYrzgieBBaCp9rRTNLQdj7nMvkt/KwbU/o9RVsvIa?=
 =?us-ascii?Q?37KuG2wR3N1PkOpXVFNGtTk+1FPgSoGLymq3gnR5UW2KE/D7t0Zcl9orTg7V?=
 =?us-ascii?Q?W1BZsW9hfldSWfjvexgUoexiiKZGdzqeVwLhtBoZv5Y4HjarlcMTMtutzLK8?=
 =?us-ascii?Q?shXVBp1tSu4tK/WtK1vPzOxCYZ3ZhMGHTGWVfA8I9kjQkmDwAeB0bCNxCEwR?=
 =?us-ascii?Q?yry6lcswQVT461mY+pRE7IElIk/4IfSEd+KzeeOnUDidLcc9dp8dRSDK2TZS?=
 =?us-ascii?Q?ngTqicvhtUzXCJM4Jwzg/1gdObOfMiv0SPGhzewJTPVfNQO+dWnIACeJRQtE?=
 =?us-ascii?Q?NP+eU1HuNTkRpccFaQMOnRqietKOWxzTggyqrqazXjucFeNOmIa7x44yq5E3?=
 =?us-ascii?Q?x9/Igq0BizzINTNEBmikigp+Al28CwMI7f44jMjw1hyLpIf6XfIsR0vEFkwp?=
 =?us-ascii?Q?v3Pdq2w2ZIJOvf8U5yMYzc7Q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce517e70-8b76-46ea-758d-08d8c92c6301
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 16:46:14.8110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HhTimow/kBox0In2o22jnXnHTEEHLI9M+nbt/1Vg/0/eYgSe9A0qDNLcVfCkWa/NlDX4fZHk+aFABW+bgibKCa+qeEagPAQD0KIPzGgAcN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1874
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, February 3, 2021 6:09 A=
M
>=20
> On Wed, Feb 03, 2021 at 02:49:53PM +0100, Arnd Bergmann wrote:
> > On Wed, Feb 3, 2021 at 2:26 PM Wei Liu <wei.liu@kernel.org> wrote:
> > > On Tue, Feb 02, 2021 at 05:02:48PM +0000, Wei Liu wrote:
> > > > On Tue, Jan 26, 2021 at 01:26:52AM +0000, Michael Kelley wrote:
> > > > > From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2=
021 4:01 AM
> > > > > > +union hv_device_id {
> > > > > > + u64 as_uint64;
> > > > > > +
> > > > > > + struct {
> > > > > > +         u64 :62;
> > > > > > +         u64 device_type:2;
> > > > > > + };
> > > > >
> > > > > Are the above 4 lines extraneous junk?
> > > > > If not, a comment would be helpful.  And we
> > > > > would normally label the 62 bit field as
> > > > > "reserved0" or something similar.
> > > > >
> > > >
> > > > No. It is not junk. I got this from a header in tree.
> > > >
> > > > I am inclined to just drop this hunk. If that breaks things, I will=
 use
> > > > "reserved0".
> > > >
> > >
> > > It turns out adding reserved0 is required. Dropping this hunk does no=
t
> > > work.
> >
> > Generally speaking, bitfields are not great for specifying binary inter=
faces,
> > as the actual bit order can differ by architecture. The normal way we g=
et
> > around it in the kernel is to use basic integer types and define macros
> > for bit masks. Ideally, each such field should also be marked with a
> > particular endianess as __le64 or __be64, in case this is ever used wit=
h
> > an Arm guest running a big-endian kernel.
>=20
> Thanks for the information.
>=20
> I think we will need to wait until Microsoft Hypervisor clearly defines
> the endianess in its header(s) before we can make changes to the copy in
> Linux.
>=20
> >
> > That said, if you do not care about the specific order of the bits, hav=
ing
> > anonymous bitfields for the reserved members is fine, I don't see a
> > reason to name it as reserved.
>=20
> Michael, let me know what you think. I'm not too fussed either way.
>=20
> Wei.

I'm OK either way.  In the Hyper-V code we've typically given such
fields a name rather than leave them anonymous, which is why it stuck
out.

Michael

>=20
> >
> >       Arnd
