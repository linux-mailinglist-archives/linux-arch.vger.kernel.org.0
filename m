Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0AC65F2C3
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jan 2023 18:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjAERdg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Jan 2023 12:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjAERdU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Jan 2023 12:33:20 -0500
Received: from MW2PR02CU002-vft-obe.outbound.protection.outlook.com (mail-westus2azon11023023.outbound.protection.outlook.com [52.101.49.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01CE102E;
        Thu,  5 Jan 2023 09:33:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqP83Oq2ToJpkNqUHbGFSSW1LYZ82v1/wdiAwibNGsKjYJkzYE905oprdYWsusQRWK7L6IVFNIAX4arRqo8J4Ybhb4Z7ikOfvKLpTUcGkIwbgDifWSdfgM2fJSelNWozTWUVkvKXi9X11kXa+0h0ZgrFVKNqpwolJxyzA5jQtWTK4W065Xd1pAkSTe3XwcMY8OXgnl+HhCRmjxGaGGmYmcOCQNFhDN0tiznwrZV1jYQoFU1mjQwZ9z3cf3HPP2FQ0CCIiKbFWR1OucGUKj0bYmSowHDcAlmct3Tdl4sytzwLR87dqWjjhfmn7LpJ6Gwul1hKjOUh3W76GWoiFzvgxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14REUeKia6Fuz5CbhLmiuR7oIvvn3QHfGHvIKq4ytoo=;
 b=DTs0vG4iOGDMjffmwjFoQvi9Vn/jfkWXb7m8ohgBRV5gzqDxbVahjvyhSAFEellDTsdFiSSgAAF8w71AlmqvOXLUuMdJxG/8iPZXHTKxFNxWH6nUY0SK1kn4MzxQh2gLr6U41RRzui5Y0YPJe4m2U8C6fCHH7xRBgXGgSLT4085xwqubtvyQSLeY5rSYjPoJ4qc0CH0YHrMqzM3LYohE0LEQg5YJ45IhoLCKxu0gr2pxaH28wpcC4lslawG7O/f/w4ednU1pGTEMFJ0QV0Ad0PTZBlbQry/ker8H/yBiI6scV2UXgbPfjHz9KLtsqNkKN1KN3ML6euBGZYKQsYR15w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14REUeKia6Fuz5CbhLmiuR7oIvvn3QHfGHvIKq4ytoo=;
 b=HtkxcLdIbi8YYZeNb4+g6irxcUULKkol4GjbS3OfDdRBVu1Z50/2yHSKAyNlJ19DDRNMD844uSSvufJbwL6pnmnNjhe0iRWeGm0CxtEafmRJ+sGvCNS95PJ/+vgxztWJiCK1eRf3YUlOR+kCx55PnEaEr1nOfaRxOHymAWAGh78=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SJ1PR21MB3603.namprd21.prod.outlook.com (2603:10b6:a03:451::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.1; Thu, 5 Jan
 2023 17:33:17 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::9244:f714:3c6d:ba37]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::9244:f714:3c6d:ba37%5]) with mapi id 15.20.6002.004; Thu, 5 Jan 2023
 17:33:17 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Zhi Wang <zhi.wang.linux@gmail.com>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
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
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhi.a.wang@intel.com" <zhi.a.wang@intel.com>
Subject: RE: [PATCH v2 2/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Topic: [PATCH v2 2/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Index: AQHZIOpXAghmsq3xdEqAL1zty4oDaa6QFLQA
Date:   Thu, 5 Jan 2023 17:33:16 +0000
Message-ID: <SA1PR21MB133560538DDD7006CCB36E30BFFA9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221207003325.21503-1-decui@microsoft.com>
        <20221207003325.21503-3-decui@microsoft.com>
 <20230105114435.000078e4@gmail.com>
In-Reply-To: <20230105114435.000078e4@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4e3da588-a713-44fd-9895-e37794a6080a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-05T17:29:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SJ1PR21MB3603:EE_
x-ms-office365-filtering-correlation-id: 05f6cf05-4331-4e0f-c861-08daef42ee40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2xErlSLY1a8mqhyFg1DOQ/mJQYFXwMeInZxDJhySnA4HfBbA73APE7D5slpl+mmrBQXQTkGamXNPt1D3qxnpfBh5G1x2NgKG5obni0XCxY6I5GKr5nkR4KoAL4FivhAclWqEU00DKdg8iQ+huvSAplys58Sz8IGG523qaTvigGqU9eaaMHiiZTY0N8Uot2juShO4Flq7dSG6dcko5IXocLOIp+4JGtOi5tMHKb9M7Z5swA8/Gpmlrhbh9ZHDoESAWLrL0QDdHN0l0rVfI40FoeXFUXkkkxFgHjCdh8c8FywVBP/DmLBN9kU1HWK1Rs80x/8HzQNRdVXemiDtoUA+OBC0GgLcd65cpYEQE79DvL9r6D+3dT7A4HbJhSHk/k8A3Rpuv46wUTdE1UMq6ePXBO+M2iqliMdPcmax88GS0lrG8g9F8w5YcIC5XS86Xi5SVdeTEw4iEy4BlqmjJv5iYJAkrt2R/qN0GtRgqb01t6VxOZYrqgxFYYn1VEru3e8bWqO2KrLRbmTp2zXCQunduRguk28180HXtjzSg4ZQebb7br9KdsWLXxRJ1t6dw3Zya0GSuylPHC7bHvi99Jip+r+4LLg92U5crOdX36GILZuwJGnTxJGbBv+uk56thgaPoX9rBPMkoOtCPmtl0wKmYXb+rZvlO4LZu6BNnhWf7x81M904R0m17qtF/UuybzUM68RE6uw7bFINvYL77m6ihrRO6Jbn6btA2WARn1tD1ayY0nd1o45jv7CUpzZDWfYl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(33656002)(82960400001)(8936002)(5660300002)(7416002)(8990500004)(82950400001)(38100700002)(2906002)(86362001)(41300700001)(52536014)(66556008)(4744005)(38070700005)(122000001)(71200400001)(66946007)(7696005)(6916009)(54906003)(76116006)(66476007)(6506007)(55016003)(186003)(478600001)(10290500003)(4326008)(26005)(64756008)(8676002)(66446008)(9686003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0bPrGYPZF+6xWes+TEF5igJsF1X+Mn7CuUPrq8zVkqMbjtT9sHTsTsJPPAmy?=
 =?us-ascii?Q?3HaWB1/y9b93WM+Vkd66eBJJXnBRbjNaQZuA6qrVZc4mKPfkcs8zIgESHxsa?=
 =?us-ascii?Q?xiwovQxJlAS31RNawfxz2XD+xJzS6vNuLszbi8Iazw/0S/ZVupLxp8dBql6/?=
 =?us-ascii?Q?wBzIA0Kv0VbOTvQ/LDDFZdxN//VqJqIA4QpQyOiu+y9OKcVrwmXFqLiB++ZG?=
 =?us-ascii?Q?C6bN4ORWOf+311/XqSv8XHF7qFdFwjs/KRqBSLoMnKo9wt/6ph5q6X1jy3lG?=
 =?us-ascii?Q?yTy/UJY+7k7lNcQZnFW+EmMoLCz7NXukWndGIfPVrt5wGJupYquCQ+BvfEyP?=
 =?us-ascii?Q?TbUGDE200S8V/RWJzN/aHyFbl0CYbxoz8syWiV1CKNn40eWoSZxPUCPBvEgN?=
 =?us-ascii?Q?koUtPPoM8djdbE9uJ+OI97Hv4p69hLq9JBO8fmwHUh0tckf+N7dQgfzNsUEC?=
 =?us-ascii?Q?CM8WZau3xo8G8TLZWmZhLTdYYFY2iFNG8rVUrdefHRUpdKSP1SyU/SZYDf56?=
 =?us-ascii?Q?YFw5T5y1dsSAly8TWSgJhmurv3jpe684nnvGvxpEqE8h0PYp+u05rXY0xYnQ?=
 =?us-ascii?Q?1JwwcX3EDgiWvLgaD9sQvO+Him7dmIJt/4aG9Fe3CjjTvv9sbXcd0havu8ds?=
 =?us-ascii?Q?vsx8nbc2b/t9uOnUU/DhRggK57hZT5XKj80fBDEs3JiUEj1mdvfq+G84Znb+?=
 =?us-ascii?Q?zocZhZUHlAtY9tAudN0K0yHv3E7bX3WRhvco0CdUtCGUNcENCeOFtR5znaa+?=
 =?us-ascii?Q?LNFNLmxpmcb16296eNS79pNMgT/P01Eto7vh9bqpABcepq+EqmYRACC5yxR+?=
 =?us-ascii?Q?MVWgdmNH5/j5jJ6TfA3YZ/uqFPMnMB8dCKuOHjtHxHk5EpkcfCjuivXh/G+Y?=
 =?us-ascii?Q?52A+GAbExfzsJUiuu2yF7tclwjSTbuVnjWMHM8Q9gNEco24c+sDXrR/ej+9i?=
 =?us-ascii?Q?KAvtIYmF6NeAOn90i5ArQhlKk1usXRCPmmslkLQri2+Hw7ovSH5X9gtMyz1q?=
 =?us-ascii?Q?KkQzNsNQrIWuTapi5TPpzzNPA6GiduSMGOyqgE/pJCcoIABvmx78q0ZdFuU5?=
 =?us-ascii?Q?3e363nJRwDqr4vbbm7ZcQ0Fwc5uXZFtYElJudLc/bOjFfjHaao3Ms1po4dXB?=
 =?us-ascii?Q?pkL1lNYhlDZakEQo7cmJ308ZNI9yg9brgBzRKHJv4TM56BmYtmIoDtxFY39U?=
 =?us-ascii?Q?T+DE9zfmqyAQ9UUuv/FG66peYHRG8riYZ3HlDEYCl1vzEzVEMlMvX0Q5LYdt?=
 =?us-ascii?Q?Ja62e7GIvECkDrcxg+G1DBMpC7rYGpqszWCUe+sL93D6u6VokK0L2A+3kDLC?=
 =?us-ascii?Q?DL+dsq5ajnWa+TUKRgaoqYZyepcPoFWfSVlWn7S5PX0fEPg7t7vfnImvjZBT?=
 =?us-ascii?Q?PPi56QBpIFtcDSRXxbdQN6ssPMFqbqT9U6llpTVixuL/UcaWiUjZgIx3H0l/?=
 =?us-ascii?Q?YrFv+mIw0grg7hgnVBpkAyTL6axa/HisPSfgb3UxMxT52q7SP0kGli0q+eHO?=
 =?us-ascii?Q?6drOsp5MGjFChoccheg6/ZaDSlpni7aHvV6xZLGWVoMg7BeXjGYiJnrgsd1K?=
 =?us-ascii?Q?uDWsvZHoTDIkO6XMC7/rkD1xwKr9DQr0ZvsxoiGG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f6cf05-4331-4e0f-c861-08daef42ee40
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 17:33:16.9980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AfVfqyFR4aHFZcDYH29UIr20OcvEXqtzIhl0jhEShuT49RMXdI3LBvPZK8d71Y0967o6/ClBlmz4kz7ti1lNSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3603
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Zhi Wang <zhi.wang.linux@gmail.com>
> Sent: Thursday, January 5, 2023 1:45 AM
>  [...]
> On Tue,  6 Dec 2022 16:33:21 -0800
> Dexuan Cui <decui@microsoft.com> wrote:
>=20
> > When a TDX guest runs on Hyper-V, the hv_netvsc driver's
> > netvsc_init_buf() allocates buffers using vzalloc(), and needs to share
> > the buffers with the host OS by calling set_memory_decrypted(), which i=
s
> > not working for vmalloc() yet. Add the support by handling the pages on=
e
> > by one.
>=20
> It seems calling set_memory_decrypted() in netvsc_init_buf() is missing i=
n
> this patch series. I guess there should be another one extra patch to cov=
er
> that.

set_memory_decrypted() is not missing here. In netvsc_init_buf(), after
the line "net_device->recv_buf =3D vzalloc(buf_size);", we have=20

vmbus_establish_gpadl(device->channel, net_device->recv_buf, ...), which

calls __vmbus_establish_gpadl(), which calls=20

set_memory_decrypted((unsigned long)kbuffer, ...)

