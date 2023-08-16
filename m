Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3C977EA47
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 22:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjHPUBp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 16:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346030AbjHPUBa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 16:01:30 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020016.outbound.protection.outlook.com [52.101.61.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA51E56;
        Wed, 16 Aug 2023 13:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JU0AjYguCgZAQMHqFtlxyTt57FyjTq3K/qXka2jMirbH8DxbTMNx0uwMPldbWZitHEaIJDQ/hyO900QZJU2B1ODT+pc8HTnIcJAQYEL28XFPCHasvsIIrj0qQkgY3XIN85vyftj8Me1wS5GB243sAo2Es5y6Cca189Run2KjFUO12nhyxzy8uu5WLChE14xKCJod5pFkBKnNSv+EMsWbJ03BqLiZWNp/BFo3wfpyJ1Gz3iazu+iz2VCz001boB6FZrPuKQSiRAHisw8RG5zv9QNbU7q3TS5Nt2Agz8QqV4XirkDY3bFgVQ5rAKWMq/8T7ZNqlh8hu2AzghUJJmutrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmAxOIwBt9Ty99W3Z5PZz+tAq4t0+KkGF54AN3JumTc=;
 b=M9goV6qS/smrAEYLKxTxUl++WPAIDQu2cMKgXaibOghUJclS6WB4W8f7UhKXzL8/v2r0woxA9kny2+coe9tMY+V0SY9nwbuzmLiKOqj8AGeceEWSQsjuv9VVC1J7qhanPt5Ny04VsVqlff4FwAXQg0/fiBV5jORgVisZn8XxF6wkQuXDHOdfsGuonzFl/ErTTf/+o2LoSFxqM+J3Al0ZKWFDV3fXrtFwfwj1yeWPNWp6mi7AdHS1E9CrQZRUvY0DLu4jUAS1ukTUexN1G1NEcHnBqslHINXi7zQPO3EyMJ8mj+KigiqDPvXMeDvQKsFOuZQGHRlfy8G/4KdvTxOVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmAxOIwBt9Ty99W3Z5PZz+tAq4t0+KkGF54AN3JumTc=;
 b=M6s2G5ZYHsN7TY0oQx1N1qqEjesLNfCk+gHBxTDJikRhHOE83r/WRiSnj0kqFkG36HNd02au/uM3tTYLwwOozZyanjW1qMUW7W8An6C6easnCkLf9dZXThUMvdvg8kPww+OpBfG7z/m0sLRKMjMsS2jBYH4oTRF/8rro/Mbg+C0=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by PH7PR21MB3947.namprd21.prod.outlook.com (2603:10b6:510:24b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.9; Wed, 16 Aug
 2023 20:01:25 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%4]) with mapi id 15.20.6723.002; Wed, 16 Aug 2023
 20:01:25 +0000
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
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: RE: [PATCH v6 4/8] drivers: hv: Mark percpu hvcall input arg page
 unencrypted in SEV-SNP enlightened guest
Thread-Topic: [PATCH v6 4/8] drivers: hv: Mark percpu hvcall input arg page
 unencrypted in SEV-SNP enlightened guest
Thread-Index: AQHZ0FqV4rkKVaE+xEmYWrQReTIhLK/tV/9w
Date:   Wed, 16 Aug 2023 20:01:25 +0000
Message-ID: <SA1PR21MB133590F013F8C7361EF5987FBF15A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230816155850.1216996-1-ltykernel@gmail.com>
 <20230816155850.1216996-5-ltykernel@gmail.com>
In-Reply-To: <20230816155850.1216996-5-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d0ccb005-70fc-446c-b19d-0e528bacd8ea;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-16T20:00:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|PH7PR21MB3947:EE_
x-ms-office365-filtering-correlation-id: 50ec14cc-521a-477d-ae17-08db9e939255
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xP5tBRNxk+AZawioQbkQknR7rPmz75lHRdlKuPYqvOf7vyvx3bB7TNV84f1EV5djcDDYU3ImKLEokuUE8kOkYVKcJhS/XWQ3fT1aoR13P0hRpfryi4vCSgGM93bcaLg5bOhsv+EKNaBethF9ghotrMsTDIL0qVPEbPtz0YfIAqfd39Ilx+GuNunjYBBZRwnzyuba6N4NfKQllV0kB8jCbCGvyAeKTu4IkEHuuYTkO0FPxUV4Fwta/YIgbNBEz2JNracO1BOLA3naitdBwRKsuouL20ywWz/bIUNrziGF2JzBE+ol57O7XLoCRVm481tEnsnHqtKUR6rzpgbKEWNsp/lmWNeFC58asIHK2uAFP18KoWH+h/seLfgiEIobwH7ZiJjif/rk+HKyEexCn3t2XiIC2ES4raRt3bVEBZAu5yMzMw3vvgijSicFXxw6ngS3YoLf89WJcvyRXFNwXt+LlkDHZoyn2IucF7DsQ/0J3R/pdCe1mhw/SHhclY+RMfZOdRgGs8vk1tCJejQ0mYOxgBTvQVsWE7Dw5cTd50/nQ2nM3/k0J1oxszUEdycjFrbV5lcrQGDLug9SJZeEcnywWsIkTJ8ToooP4EcTTZ+ibviFhakbynmzCJWxQCh7hrCf/5sPkxEmDgr64mDxYZ38mh6M7OWEOwjxflcYzVaAA6a59JWlZiOeJV7QkN0r6Q014AjyUPM34lxZIP2uRGSK0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(396003)(366004)(1800799009)(186009)(451199024)(12101799020)(38100700002)(316002)(71200400001)(9686003)(55016003)(41300700001)(6506007)(478600001)(66476007)(110136005)(6636002)(4326008)(52536014)(66556008)(7696005)(64756008)(66946007)(76116006)(66446008)(54906003)(107886003)(82950400001)(82960400001)(921005)(38070700005)(33656002)(122000001)(83380400001)(86362001)(5660300002)(10290500003)(4744005)(8936002)(7416002)(2906002)(8990500004)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cgp6rdUWEVGEZfXjRU2AW4tnjSme1j1TfKhq3RnVyWqaJhTZezOhz+DJjXz0?=
 =?us-ascii?Q?tTsPTvAwTmUNXMhF0rjgD3nqavVk8Y/0JoYfjKPdkuPeNvt41OiAS4PBKY8z?=
 =?us-ascii?Q?WD3ZqMLSWUxkphiHuZkES+Xt4zQV5XxQ2jxeQHEG94Oqu1og7LyTyrjhd5/B?=
 =?us-ascii?Q?5oQ7TO2EWML0DYfrOW9B10sBNrEDKep8dNBwJw9Kx5LVxDIhIRWjLiprZam8?=
 =?us-ascii?Q?PRsq3kccEYlIwdQEVeG3qpRpPAeQ5f4w5744Wc87hF8Q/Nn0hb4BD2muQqmt?=
 =?us-ascii?Q?g5wda59H4VEKHfvT9LjJDbcX9PzeXRia+rxYS2d0pZAhZJzPG+9YMkxaR3qu?=
 =?us-ascii?Q?XpnF9X/f8ibP51sjtuYZIYaqSSCGsw0swpMA7Zocho5xu6EwbsKQ5kEcsUzf?=
 =?us-ascii?Q?aqydqmKFpS8Z7b3YwtqJKMyslZg/RUxxxyMOrnZY6CPKoZfkt3gG0F/yZqXy?=
 =?us-ascii?Q?3+U8XtX6ZKjZbkiuTOOMobh4hVqxiDyB0BAQkd3lkz6DZvctWeFOEKVWfdVz?=
 =?us-ascii?Q?qffaZpXrSWmQOga5AZIixVTDWnrcp5JLUo8XZOS4nYG5iQi5DM0bjTD7v3WD?=
 =?us-ascii?Q?RN0kpIYIkUqSkk5QFNsJR10yj/Z9XXwCQ6xq0Ks4DIl6fXvGuYEy46T0Xptp?=
 =?us-ascii?Q?eh2D2M6t/lQwdcIzK8CyEnA2bfPWQOo+MyYC10We5xktK9NStlyll7tfbBX3?=
 =?us-ascii?Q?As2V3LIQ2sDNEMKchGr7hA4S9DfwGh242fL7yNgb821+mK+1EzMP/sciPOXT?=
 =?us-ascii?Q?2Mi/ZdAMZji6b2dKONBEnEw0vx8qJEnkzEJG1ZVhCYUfYBotGivGyzAsE1Nw?=
 =?us-ascii?Q?UPbkERgBnl1/lGAaxWjwOEuU2muEVgwJu9Dez6t9q9APnKB83k1FIxPPqCXe?=
 =?us-ascii?Q?uwrKZObL58MoJ0yQ1GCzaHeBhFcwMn5CnC+j9UHOBvySCiIuVjk9bU5l1rC/?=
 =?us-ascii?Q?tGhfXSkGxvJiQofHHXp7o+yk3Fql3WQ58b3Ye8gJ2pfL0OIvIhxNhohxI6bC?=
 =?us-ascii?Q?Bt9qkknTP2d76ATznX0dGX3Su5dtoMIQrFymtZviLvCVlyWH8rFQXK68/DJw?=
 =?us-ascii?Q?ybyrvOA5Hfub08Qma3C19366X9xELPv4Z0QrlPktl6/akZuTgOVzGcXiHlI6?=
 =?us-ascii?Q?AkQjqvpVcb+hGt9uoyXHonwnLcNWit+OIuYSr86au/kqwrs9b80vPP6ILlQJ?=
 =?us-ascii?Q?ooHlmX581qwCAokuR6d0tvTINmltmxf6IFOiKrZtk2pRENVNdhxPe8uSah0Y?=
 =?us-ascii?Q?ulVIPNMylqmBASTjfGdBZKrbKPngyjLBzAr7kfmeUEP4g/3j/tkNWbQdzne5?=
 =?us-ascii?Q?7qBoMF2If95nBo+/gpc4goeNw3fbycYTrCWsUJcZGvNeGMePysBl+aRthj4W?=
 =?us-ascii?Q?l9UUKcnfAXmItsimy7WQG2AUTTOmEq5/hAC62YPhtxNsvYOBVFsmWdMeBVj3?=
 =?us-ascii?Q?Jz1jCXsujI6eE091Ua1BfoBERn6UH0ibCh6a3UOjTcb60OTp4pB3xaD0WHim?=
 =?us-ascii?Q?LGwjZoKIDOsmKlZD+orjJytuohtACWUSH2b6kwQhIAUgRy0Xds45ZNpdbW5v?=
 =?us-ascii?Q?69yERYMVh55uGXDg9Jdqc5N/kutBnNzjCDvwBqomYUy8PDiI7Wg7u1xAwswp?=
 =?us-ascii?Q?atv/0phLDBMGE6rlAHzqYC8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ec14cc-521a-477d-ae17-08db9e939255
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 20:01:25.5228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PiX5bQVZUUhWphqBvpqtvZNetczEn3cOz1uKUWd33p9x3OLWMiCwIQbbkk2/7Q9pnXXXLNqSiCOl1WjNy+tCnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3947
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Wednesday, August 16, 2023 8:59 AM
> [...]
> Hypervisor needs to access input arg, VMBus synic event and
> message pages. Mark these pages unencrypted in the SEV-SNP
> guest and free them only if they have been marked encrypted
> successfully.
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---

Reviewed-by: Dexuan Cui <decui@microsoft.com>
