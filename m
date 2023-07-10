Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729B974DC2C
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 19:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjGJRUl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 13:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjGJRUh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 13:20:37 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020027.outbound.protection.outlook.com [52.101.56.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7EF128;
        Mon, 10 Jul 2023 10:20:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koGy4WCn2juc4D9ovzx3ZCKCYLiFVthtag4H4qOpd5fhLAHNKBHdI4VBpiIIxtEhVk35XB5Of69cljZ1zkqtunaGYpaDPcqE7J78+OUsdDjvKcBXYIKN41DYo7QA8lw6mgYDzZqkDIIR1n+ETGsU/NciJfrwaPdttgHgrE+gH6G7D8THCIpb8A9OlZtYylGu3vK/04yiqgQzT6s3189i9a8GZLA+q/iBVIqtbT3/3Y9onb+IuEi62ge9WnI8huFgdWFLQHiGX/bWX4KrytvHG4LJUDtiwwWyWltF2rRYqqMIOUhyHAXojBmzigEtW9JuCFwOQaRlblpPzx3ofiEpvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNo4sehsNFZJYkmI9cgiZceIAYbtHkQujVvN08U5e5o=;
 b=BmYAAuYOrrTKBdqtE1jdlbaiWINSIJCYzfQ4OwRlEOFvDeAOpjrlJXDfT2qRHhODXNA6nNMDVHofl515kHR61CFB62taPH8FbLHL0X2RH9+bUFAL4xeBacQ3dnRyPLC5jtE1UhuKgbxiI4mDrlgaZ1is6nJXgJWFQ0IE7vJACXK4Amj9y31UYP8Vri4Ggf+mNfL69kAf/xpfHL4B2loKbbGDZe6fOrUQsf1/yoJbKiKTz1HFlda6gaCbqJq0iRUROwkMgex0t7eSUC3l4xY2gjz8EmCUglC2QbDzuj/pBHViGrKRrCovrMJHddOaBt02CXWLg4p6oz4LFMfON3NhJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNo4sehsNFZJYkmI9cgiZceIAYbtHkQujVvN08U5e5o=;
 b=IW9ZyLRgBmnzI25BUqDUUdPq+ufESwOS7Yk8FhYemlFClks6vfu1DAiF+sZoxRLqzaUaB3v6TW+ix/Dw261qGCYGADExfbc1530ysMCO6C2y0rrodWX9LRwL8qUSmzAKX7ZjsXQpWPmJNrhR7KmZlJuInuVw0caYB8eh/sqItu8=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DS7PR21MB3525.namprd21.prod.outlook.com (2603:10b6:8:92::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.6; Mon, 10 Jul
 2023 17:20:32 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::718a:bd58:c08f:f54d]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::718a:bd58:c08f:f54d%4]) with mapi id 15.20.6609.003; Mon, 10 Jul 2023
 17:20:32 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
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
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
Subject: RE: [PATCH v9 0/2] Support TDX guests on Hyper-V (the x86/tdx part)
Thread-Topic: [PATCH v9 0/2] Support TDX guests on Hyper-V (the x86/tdx part)
Thread-Index: AQHZqesomMpIPtubN0K/S6c9+nGnj6+gi4RwgBLE6uA=
Date:   Mon, 10 Jul 2023 17:20:32 +0000
Message-ID: <SA1PR21MB133517719A03FCE05A9251C0BF30A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230621191317.4129-1-decui@microsoft.com>
 <ZJx2cm1HaMEcNIYy@liuwe-devbox-debian-v2>
 <SA1PR21MB133517262C2D1DFB881BE8B2BF24A@SA1PR21MB1335.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB133517262C2D1DFB881BE8B2BF24A@SA1PR21MB1335.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9b79af80-4a3e-40cf-8e4e-0deac849eee3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-28T18:38:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DS7PR21MB3525:EE_
x-ms-office365-filtering-correlation-id: ce9a62ea-b732-4b28-1d6a-08db8169f77b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KpIrwYNztoTspE5GBrDkDMdj3L2QF8bAt/UmuAc8OYU60GiprI3z3IF8wrKHG0LG78sA416VGFNId722a4o/m99yeROe7SELQV1iWRzdlMThxRMi8d8n6BCOcbJQCACwbnW2RUyjaFZHghYOxEtvXh3qEf3iilvcgWwjegr6XuWTEQM/dWt5OYawMFzulOGG+fjdqIXkDZZoDntpJ/zMq0590Ca11ElJcLvs3sckcOltzW4QSLFKLBj4flJbbLROekqdTV1au2Qs+lJkG2ShFXu78GA2JhuSd78DwqvZIgJw92RNyIUn/2Kpi1t1NvsLitilc4/4MjFGpbkGwf88uAyvKoX2f1DdSZDNuv3TAoKekyyuUen856Xg/eR3K1Bv0Ij+nMWZychZZSkj2DcBZE7lOvzzmrt8umZmfGxs6Uu6Dlsp9A9tvuLumQSx88RTzteVakR5yBro2QGnVqAAPm8+PSlgDxl6j++V6197hCrom8NtN8u/gAg9JPmBctmj+hluNLiTNecBUvYH9bIG2f0iZQlnb7tMUJ9LvzJy4GIYCzCM6aM1JvV1soQo+3B0XktJmR/1F3FmvfGKxld7Ilm4hX05TN851GGK3I9BbzKK1BW4MtkMv4ceePHGVU2hsVx8PgI7C30gpAwqr8OtLv+XPXfupliQ2TK2k0skB5Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(71200400001)(33656002)(10290500003)(478600001)(55016003)(9686003)(186003)(26005)(53546011)(6506007)(7696005)(2906002)(316002)(41300700001)(38100700002)(4326008)(66556008)(66476007)(66446008)(66946007)(64756008)(122000001)(76116006)(82950400001)(82960400001)(7416002)(5660300002)(86362001)(38070700005)(8936002)(8676002)(52536014)(54906003)(110136005)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fqe9FbYSg8T17C4OE60C2GHcZVTfIa2Kb6j8mY0Yl3HBB2Dcp1G3w/HFESP6?=
 =?us-ascii?Q?m+8kylR8cnzcNDfxuP3/DVhAWGet5HiPnUT7pZMVAQmgwrbYL4G0Lf0jMBwo?=
 =?us-ascii?Q?++DHIUwc2GKU1ogAmxrUjj3uLnaWuALJjF0J2JNLJO/cqxHq3TEvH2/JUw7B?=
 =?us-ascii?Q?po0xaIAUfSG4G2tCBHjqtNMsXctqOx/btXTjQcFtbSlC8JXa3ZTpLjSnlCln?=
 =?us-ascii?Q?lLyUkRffsVoX34aAgR14ipBQVmqbQ9L+j3ymXr2IeXFA5iQSjbfMI0XxzjR/?=
 =?us-ascii?Q?e/7292ccpbRGgFR7tK/asfCx3EuzPkUQAoF0x1+/kr2vb3buaN5+SmMs6Zh7?=
 =?us-ascii?Q?xSAHTKvWkCwJIVxmCffpOptwf4uKc3dABmb8nt3RJTXi7zcYoLfH0F7613Lt?=
 =?us-ascii?Q?YdUpdQPI9V3Aiz+P9yqDiL/KIRwNehNUZ+2ptbYXmAN64f3EgNsu7z0p31h2?=
 =?us-ascii?Q?pOqe5a8Z0N/rvWBkDifPHGrnCpqVxieDRTfo+00lxNzmk+OF8/72JPH+rxI+?=
 =?us-ascii?Q?7PUXv8aHnsQBDQqta0DkQ8aaoNXPsBtY6g5XC+CtNKBVZSbY5l4Exd3bIji9?=
 =?us-ascii?Q?BhgPbnu5aB7Rv4A2I1U2w8PQUjkkPxJNjNijXCeHNWxtJrkQ87AIOpzlECkD?=
 =?us-ascii?Q?UNEHFxdC76XJyNvu3bsHZfnU7NWa7U5O9oNINoBlW7mHwBzoAEF5J7vXgobN?=
 =?us-ascii?Q?sAQIoStNg+uZzoMIMeZFKvmuTmZ/S+JZsDWbgmV9e+y4D/S7gJ0bbotUVcj/?=
 =?us-ascii?Q?RJVk0vsrYqz08JgMIyqzwTwQrfZxDuHX+rQVlNkJ+khMf83ZspB1U/OOCXzm?=
 =?us-ascii?Q?jC2OYVbDGJSyhR6wU1CdvBkW5Q5PevGqKLjIv7jBqke3NG0GR49pVdx7qRAX?=
 =?us-ascii?Q?ApryYmS4gCwzJrLvGxqd7D/je4bG4xUuVi+GHQzxK2bM9Xlu4wubjDGdFrG0?=
 =?us-ascii?Q?VWwyu+IiUeAEKDfJSjBhYG5shq0eppk+6FNzTFYd+5VtAodELcAtOySjg3VN?=
 =?us-ascii?Q?eeHOVLHXIwuBfru8dPASUKdf+yna4xdLIsIE/lsSG4bn8/hMAuoOp1BXmoyd?=
 =?us-ascii?Q?P6zuHGWcWvJHNNYqI1SrVn42ms/LbGE3cO1z9EFzBeyU1FFKu/4hL16Gabsa?=
 =?us-ascii?Q?bLk77zAP02Ci7tyTQyixqy+YtF1KlkpS45rg7scp1c+3DN5R4RHZGOOx9GOf?=
 =?us-ascii?Q?cn0amdkOL74xvtqqzCHwF7XhNaOZ4+RI4BxAEUxb6PZmy4ko118sETUmnFnw?=
 =?us-ascii?Q?nSafqlexQFa0D6fNoaVuA211boF02RWXA43dLQTpfvdUCE3GsnpV2rVQHzQA?=
 =?us-ascii?Q?ceJWjBokSzgxIf6TbsmQDRi9Mn4LTtwIhWQuI/wiZTgvYhhCcd1CgdaqiXTM?=
 =?us-ascii?Q?431ZgSleD0ghrw4i3BprWmJytRSe0ELRf/qNHe7fTLv9TLZ1aQVLpsB8zd8n?=
 =?us-ascii?Q?//T/em3ufM7lwOlKsbeBgTwagYQnpIaetglEFFBEmgR4u9heoovt9KKzOfLw?=
 =?us-ascii?Q?tiz3mRmhotyppFUGmAEKy3Al+iTuVpW2TuqOVlRT45msN7QQdlPJkaq1j8Sg?=
 =?us-ascii?Q?1tLJw83ZWKRQ8TK89r9AwTvgPIVG+6GxmYCnFU8J?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9a62ea-b732-4b28-1d6a-08db8169f77b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 17:20:32.6222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lpg4NqrN5LAEsb0Cnwd1lu5pWj3KOvul1usOZyTO/KPO/juwXW3IXz53yxyNn0H8YLgT2vxHX9eqwEY5hu1wKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3525
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Wednesday, June 28, 2023 11:45 AM
> To: Wei Liu <wei.liu@kernel.org>
> ...
> > From: Wei Liu <wei.liu@kernel.org>
> > Sent: Wednesday, June 28, 2023 11:06 AM
> > To: Dexuan Cui <decui@microsoft.com>
> > Subject: Re: [PATCH v9 0/2] Support TDX guests on Hyper-V (the x86/tdx
> > part)
> >
> > On Wed, Jun 21, 2023 at 12:13:15PM -0700, Dexuan Cui wrote:
> > > The two patches are based on today's tip.git's master branch.
> > >
> > > Note: the two patches don't apply to the current x86/tdx branch, whic=
h
> > > doesn't have commit 75d090fd167a ("x86/tdx: Add unaccepted memory
> > support").
> > >
> > > As Dave suggested, I moved some local variables of tdx_map_gpa() to
> > > inside the loop. I added Sathyanarayanan's Reviewed-by.
> > >
> > > Please review.
> > > ...
> > > Dexuan Cui (2):
> > >   x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
> > >   x86/tdx: Support vmalloc() for tdx_enc_status_changed()
> > ...
> > Dexuan, do you expect these to go through the Hyper-V tree?
> >
> > Thanks,
> > Wei.
>=20
> I suppose Dave and/or other x86 folks would like the 2 patches to go
> through the tip tree if the patches look good.
>=20
> Hi Dave, any comments on the patches?

Hi Dave, would you please take a look at the 2 patches?

The patches have got Reviewed-by/Acked-by from Kirill, Sathyanarayanan
and Michael.
The patches can still apply cleanly on today's tip tree's master branch.
=20
Thanks,
Dexuan

