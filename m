Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4838636877
	for <lists+linux-arch@lfdr.de>; Wed, 23 Nov 2022 19:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239487AbiKWSPw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Nov 2022 13:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239619AbiKWSP3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Nov 2022 13:15:29 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westus2azon11021026.outbound.protection.outlook.com [52.101.47.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F32213D56;
        Wed, 23 Nov 2022 10:13:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcZU8tIWvVZ/twJAJs277gHXfK6DFMK9jgtIJB4yw0TgRfUIqWViZ+gK99yV9DnHF+T7Aa4er2uu+xO75NvfrqbWxQDUG/eo7dWvLT0pS8Ea5dN1IGR2YL0Za5WpwTtC4yIS7GYT2Pd7WZp9oys2iEnsM6K3YIa7CtbcXJrbwLgZt5QXcUu/f7ingtk4E0LX/hHZIUiEli6y5HCdrbf9mNiFvOcKjTDkQydzCTi/b15asTmhDZJmikfyHdF++iCwcDQrAH/qO3dfZgGXdoYDO+GxrZYUNPNOFaeBlZDeWY6b+0PzkV2o/yBX4whKh/m3lCvOKCs4udU3F7Zm9/Ss0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR/QuwxJBsgbLd5rUBF+cJmKEACiJIIfE+8Nqx9QwkM=;
 b=itT8pRvEKwTdIyvrarYDptF6jy24u3q2+Rfs3qtF+VAbtz9R/3xDcqBtwF4jPAEpB+yAUJ3Z7NWIdMBr/DuqgNbdL/MvNA07JRQtPYH4g4DJKIshjLxRdcLLY5ZOqCafBGR/ssS7+dYvqXuvPuSpyeXgcuxv2L0RmrsFLCi35sX6u2G6sTZV1s/l1lzAvdYZCOqewRJFqfYO3dKEswQLYzikMn8leBCN6Z4jaMmg+SajVfPHPkjXlJ4Crlwlfbqpc3F7O65+RUkQLRNfKKFW0VvALBNvE+8gLD2qXV2r8EHy+dfLJV3rywE1rZUCR0ULOhUUTAQ/4rJipNtQBmP7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kR/QuwxJBsgbLd5rUBF+cJmKEACiJIIfE+8Nqx9QwkM=;
 b=RFmzfydg2+G3z9sw5nSuSFuSrCd+Yd5zqPi2MxQAminms532HuX6GvGIyuFK/NURUi6XQUfd2FQyZerxVsdd4b45/fI444hM5rALbty0J41PlLL7GW4wySxwIVDrgcmPnwRjYnisxF4lkeM7nZGSvaIOfSfD7/eOoeuiRWij41A=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by BL1PR21MB3305.namprd21.prod.outlook.com (2603:10b6:208:39a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.4; Wed, 23 Nov
 2022 18:13:46 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%5]) with mapi id 15.20.5880.004; Wed, 23 Nov 2022
 18:13:45 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     Dave Hansen <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
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
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Topic: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Index: AQHY/eSSvJMCdibbbUqzNA0JVsxn0a5LwurggADWQACAADkUAA==
Date:   Wed, 23 Nov 2022 18:13:45 +0000
Message-ID: <SA1PR21MB13351374767F524FC413E79DBF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-6-decui@microsoft.com>
 <344c8b55-b5c3-85c4-72b3-4120e425201e@intel.com>
 <SA1PR21MB13359D878631F5C327DE8148BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
 <20221123144714.vjp6alujwgzdjz5v@box.shutemov.name>
In-Reply-To: <20221123144714.vjp6alujwgzdjz5v@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d7668516-5611-48d3-a35d-e97c8bc6acee;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-23T18:11:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|BL1PR21MB3305:EE_
x-ms-office365-filtering-correlation-id: 517ee120-f31e-4a22-c318-08dacd7e7626
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FrscV4tG3nItHrUlevzL9v0odyDnHPhgiIYTGAS5o14WCPsXdVXGSZ1ZXaKvbioRF15g+Skdk9ZA9YiIcH5eFnsSrBYFeoCuFpT7YX67Lsn1Eb6+z1Wyr9iHmqzmu+knbNb2dFPVlVFvB9ffl3XgSEiwahypNLUkWx0Q/5y3L7pnIWWoPhNA/2PHCmSHORAeK/IqhWfxeU8DgZ3mVFvy6BjTd6temvsEZrOSDlL0Zclj6s8kB4DyViycY0LBcBMJ56TTypcVNvuOMr6IRPIh759LP49u40XH72HxVotOxODO6d+yFtbBnP/VgxEpWhzusQa5NZTIhj8KjdTUfsH/eHKRUu0b6WZGri/JGe+SWTE78FAVQT8F1MONq3q+Rv1UOELQWAyeNThThSCkM/Z87wJqbfCcjs2g/QCjU7j24tjzERjyOA+9quc0P9MmPyBVZd/QohwgQTagRqcizrwgPzDSBZgdIjWZrG9W235m/Oj9Jh3GnRupOTiaIbeE5JyFm2X3RBxR7HxKbYCW4FmIXtCzgv1qXolpqtHX7k9ZHhft4mPBQlge35q8FdZ17aMGuKTxmCBVsxKtjN4/E36KQAWRNCglYIvd+mr/8bec7PeG3U5V2rVzYuL5FcNTlRhdJdPt38Sh05NE567s1twweonswqwjsY57tnU977u//DT9MqyoPD+kyQ5b2qj7M4gPcanItYdaElIeF4HxHASY8XVC39TK3xVzeF9IEuo7mKu9Dum3roUiaVVqmaW0TYo6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(110136005)(6636002)(54906003)(316002)(5660300002)(41300700001)(52536014)(55016003)(64756008)(76116006)(66476007)(66446008)(8676002)(66556008)(66946007)(4326008)(26005)(7696005)(9686003)(6506007)(86362001)(186003)(10290500003)(33656002)(71200400001)(478600001)(38100700002)(2906002)(82950400001)(82960400001)(4744005)(7416002)(8936002)(122000001)(8990500004)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VLPsEMPqHwkelg9pB11vn8o2qTiJ3J74oRPMLIOTvDJDYJnkA8jmq0f2JLud?=
 =?us-ascii?Q?A5WW14zNerNs7eecnPovT1uhi21fOSEMYEb6ldIks8z54DAJo0WkJsBHQSv0?=
 =?us-ascii?Q?wOA38xd8TX6Cl7TE7AAYXcLmTNUcwj3RTA6ZviyiNVABmDVFxZ8d7BTnEM0V?=
 =?us-ascii?Q?xBRFUgzYytNZ/egSaTcc+mTW7a6nEd0MkYp2lQsGxbyEdbybvUruHNmozxEg?=
 =?us-ascii?Q?wmolHjss0AtKfN4AJ4qfVRci3X7NsgbnbNbN4ecOiozidyLnuVps7Q0AgMk6?=
 =?us-ascii?Q?ycFGnO8Gy0BYxNEkCNbZzFFE8xPBTufC7ukge6TvhkMI83ncC0J/fkiDtim3?=
 =?us-ascii?Q?eOwhoYsGyKKyA5NUKW237F1NCJWFsp9NF3lAjeYN6kJbW5agCdD7cObAN1Q4?=
 =?us-ascii?Q?TZV+O0eYm+6FfqzdCOZhcXTJclvBdADjjTshIvecaF54FRiZ9/lPXkhvbkN2?=
 =?us-ascii?Q?6KRjdWfMiiyf2qH6iZ3t9k5x1HjcEzSSScPchoPRebRvfoAuMb8cho7qLQXF?=
 =?us-ascii?Q?bh6Cpfl6WNWqq+SNSAm8QuwWA+P5dEAIlJo4oGg/SuCZkohvYMb2PREEL5wQ?=
 =?us-ascii?Q?NniaHZE7Op8iA2aWEf/9Tz3RedZQ9WF/o7p92eOSvQ2di8kZKattxRd/HI+j?=
 =?us-ascii?Q?Cg0RgEq60WHbAZ6SdQJwCA+eCS6Rpky2eHfEh+0siP/cpf3fwSn38Ry+VNAU?=
 =?us-ascii?Q?mq9XNr3A/OFnZXL01a6Mpd0VaJFBMfZTHgPCypnu4qk5N8/gnTZIxy0A786v?=
 =?us-ascii?Q?owDRznXP6VNK9AgWsNqOdfY+t5vuYf/FGz2dcrVJ0XL0uEXCQb1BKIilH4Yr?=
 =?us-ascii?Q?K9i0bsgdQqrvoCCZOidrEWKtaAY2tNlZiqWaR+4qwvcfwz5NeJEgpufG6zAW?=
 =?us-ascii?Q?9tWUP0GnWg1J95jvvAhSoibisvzwzldFV7V+eHWbNIeBwvuK2v9n+KtuCl9B?=
 =?us-ascii?Q?HZPGbz4mtv+93hjvMirWq3OGTqBkJ77Inr4L4XDcnqU+IQGCf4e6m+qe4S2A?=
 =?us-ascii?Q?bxTQPPSE727qQeq2UsNSKQJkQCnDu77Ay1S8PcBW7NHboi6uwnTsIK5cQuE8?=
 =?us-ascii?Q?9QUfh2Bhh8LWcWPr2Of5OXHrdxUVo4te5ccegOQjfP1kJEgu5CwyqqrAg0yg?=
 =?us-ascii?Q?wlX4YFKI7zMU/jXN1NyS8h6y6Xj0lXg4KXdjjXsxoopRpTDGoqAtnJ41CpGp?=
 =?us-ascii?Q?ubP0UFkHghAksSXLKmJLDz/m6LmrPniy9U0mLbKoKL4IrmeITE/G+XytWCCR?=
 =?us-ascii?Q?SywcAXbSExCE2+8MuU9HFRr96wT7Vr2D0trRjjII3WgfmWr2Maqzd47AQdqY?=
 =?us-ascii?Q?Esp7dHuzsBY7Aq4++9dgtJV5wIprck3natgBvQZ8fJEqCzcx1E42owr4r+T4?=
 =?us-ascii?Q?LuardlXMNKZlKOTwft9vp6j7mTFTsAGdlMv+C1hb0LWDTThNTymFPQBz7SE+?=
 =?us-ascii?Q?ffbQaWDayY+jMQveMbelFpMctxIPoo91kzm6jg55Mc0uWZOUdn8gHnnGJ2bo?=
 =?us-ascii?Q?7JEOab6N/N9ySABaimJg7wScLNFBqcxL25TrSLas5Fl+QbLB5iT/FgFCpXDz?=
 =?us-ascii?Q?iFuXBHZ3zN8lJLX7EtRHtRoaE8m3ozQedJzTxm7o?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517ee120-f31e-4a22-c318-08dacd7e7626
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 18:13:45.8015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1IIuVpflgNs1MTrt1DeHAm1G/aP3cxiDeKBvPjQMU84cxrApnToclN6UbzvXjwTFHXkQIivdyHG6Bs9V6kAugQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3305
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Kirill A. Shutemov <kirill@shutemov.name>
> [...]
> > >
> > > The "no #ifdef's in C files" rule would be good to apply here.  Pleas=
e
> > > do one #ifdef in a header.
> >
> > Sorry, I should use #ifdef rather than #if. I'll fix it like the below.
>=20
> No, can we hide preprocessor hell inside hv_isolation_type_tdx()?
>=20
> Like make it return false for !CONFIG_INTEL_TDX_GUEST and avoid all
> #if/#ifdefs in C file.

Ok, let me try to apply Michael's good ideas he shared in another email.
