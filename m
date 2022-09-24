Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8810F5E888B
	for <lists+linux-arch@lfdr.de>; Sat, 24 Sep 2022 07:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiIXFbk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Sep 2022 01:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiIXFbj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Sep 2022 01:31:39 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020027.outbound.protection.outlook.com [52.101.61.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B1BAC259;
        Fri, 23 Sep 2022 22:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzL9OYm34TbvDCN+oG0kHHoezVr74VGPZC75E7IACHOEWPhyWLheh497YGKN842JF3QfQVOAylGIHzFYgQmra5KI/35o/MycKNhKKvVN9Rv9N8AeumDM9Rvtj1+skTcVP2DrwXAAieS+85BT6Lh9VDKSycdOBCXWxuoFoZLGtxzSVE7XimSPTLLyqM+YOj/WCKWIXLoRFiufVz28TzbPe58P6WnaZ/JRt9rv4g0CXJhPpNXgp6ZFtGQbvBb2M/TtmiFZjPVr+0h9SPW7pUMM5od/NuMXyRnG37vti/1CGe6z4hZjn/7SYlctA9z0Gi855DP/p5w/7tgjZ1BcOGTFrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMKJN6DJI1t3GY3ePnG+FQLlP8AC33ACh+PkjUFw1yQ=;
 b=Cx1YJ4OtQZDzUsOn2I0CEJ0nSAnP4CGDv6R+6TBV+7gerWGc8Vw2/o15YJQL4dwvBGbgMJD9J8h3YvWZNoIeJcuWj0hOcXS3e4h/apU7mkkbWu+mlQDbtvpSqnCyZclNigCFbHFugNQPyj0QoEGTAfjJW/XdI7/KDoZtk5xuLIkTQG91ck8izovbYJO9B5soswjq82sKocWRWrbysVJ1djygunir/vCyO1Zw2+zl/MGwlk9vSTsqWVj7MinSQGsaBWp0jblacwHa5XQt8D+Kl5qYlSSDyERb8ShjThGEOTLetCLSQknSQ4Eo7+Ui/TM5hU9o9lmzi0enkemM5+sAQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMKJN6DJI1t3GY3ePnG+FQLlP8AC33ACh+PkjUFw1yQ=;
 b=LT9FubuBWmuLKHL7QSnTAzZP4zHIRBkN+GaluzyBd4mKeq1iqRWfOJ/BtvkI/1M0/a9EXXcHRJCUKVhcy6C+DYiJQtnNahe4t4YsUjp1pcwP2ZQN0DH2V3sqbFIX3azybalBz6n3hMjIYXVrXy3cFh+5ct1/REnaSDMmUwOIASY=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3439.namprd21.prod.outlook.com (2603:10b6:208:3d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9; Sat, 24 Sep
 2022 05:31:34 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::17f5:70e:721f:df7e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::17f5:70e:721f:df7e%4]) with mapi id 15.20.5676.009; Sat, 24 Sep 2022
 05:31:34 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Olaf Hering <olaf@aepfle.de>, Li kunyu <kunyu@nfschina.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v3] hyperv: simplify and rename generate_guest_id
Thread-Topic: [PATCH v3] hyperv: simplify and rename generate_guest_id
Thread-Index: AQHYz0GurzqyloJRkEuW72OO+2hVKq3tgveAgACIcrA=
Date:   Sat, 24 Sep 2022 05:31:34 +0000
Message-ID: <BYAPR21MB1688890F578A59F69DEB55C1D7509@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20220923114259.2945-1-kunyu@nfschina.com>
 <20220923230917.1506b24c.olaf@aepfle.de>
In-Reply-To: <20220923230917.1506b24c.olaf@aepfle.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3439:EE_
x-ms-office365-filtering-correlation-id: ab656a3b-8c6e-4f15-d65f-08da9dee0b4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BXpQCRJa6Bmzviq0GP+kmDlC0f2TLxT1IUhiEqSU5W/WP+BeWfAGmzGZ16UShNa3UnA2zht/aav3j6tM+Cw8jrGUlui6r3WmSjiLSoX93rOxZ1YP/GxaYONniasrHv124cn15iP8z+eHMZBfoeh13bziZbPw6+W9cc2oiorqXSN/20g1RjaSpVW5iQC75tpqaAjgjB+9ma6wAxjXivRQq4hTYe5h3RmPOY6fZZ7vwYhH0L6T5lEwAgu4vpI/ophREX4LwxGKKAAoaTUmyEyV9B9vIrz1aJxsGccVVz+Vhrd/A5xK7PWt1ekp7YZWpDDQNwdfmKUsV9rb7uUkiGFhzZYjLIqzQxJS1BkVwYwQX2th6twN3h9OwzhXe3twFQ3JVMRev0LxfVtIRDY8KShL3xTnaachA7nE0o59EDsxhC1ZSN5Hz44OSKPJRpkIZuuIcBhtLe+1FvYHCLWwQElh9wO37z14a7/8WZMzzPGBrmXnU2k9kGM7st30/uGC5tAc6W2JLgZikd1wG6UOJ/HiVSig1+zb5ivuwJG9L/4ZPKImDBz8vbKCaQyLIoNaWBrvvgapXyCoNv3yimJooNiFIbWiDP/m418y9lJHDP43I+myiZ7JU3Qm6M9Lqe9Oj4t+scWK3pvERvJdEy8T9qbwMs60bxyHx1Q95ucrSrUa0XdWLCRXLfkePk9zLgmNu71oyOXPOnRLsL1qShwVxrtxEZ+To2I+zkqoOBOAjQVRSh9rlewAU08Wswd4/SByYHhAV5+fbTLxT90q/1d7Gy52YqaVStBCMCqAt61VtB//Qm/QKT/cOMELi3FLJgAYA5Ep
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199015)(7696005)(5660300002)(2906002)(10290500003)(6506007)(26005)(478600001)(7416002)(8936002)(8676002)(64756008)(4326008)(66946007)(9686003)(66556008)(66476007)(55016003)(66446008)(52536014)(186003)(41300700001)(8990500004)(71200400001)(54906003)(76116006)(110136005)(4744005)(316002)(38100700002)(122000001)(82950400001)(82960400001)(86362001)(33656002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bBVUG7z6ZsypLtwYFcXVj41XEaSz+ufVj+z3Gt/yF9e3jeG9cgGnP4EmUt9V?=
 =?us-ascii?Q?8i5HXw/F4zdcMlKXotz0w79ej3f1TuJ6Pr/9Gbczl5Xrd57VHkseLMAUE4Hc?=
 =?us-ascii?Q?czVTpHSkBB7vKFbnb5zHEcww0jHJnPAYfY83l3n/fMIYioB6R4FnNEsP+E/d?=
 =?us-ascii?Q?vzMJbMUXk7mP54sRtsJqKtnL53LE/7jz22gR+s4XxnmtuSb5hfvmj7sGtD8u?=
 =?us-ascii?Q?q0utYpKkYFyNRCDEuTt/zZYLP8Y1KQM9NTna5KaE/hZGXyEsJxiB+BWt6RsL?=
 =?us-ascii?Q?7PDVMZ4LU4LDWzXwjh/zhy951PuOWRsP++kFP78nmu/efeHx6LzjAZKw+RlL?=
 =?us-ascii?Q?hwsFcCGFrVL7tR8HTz3j5ajb4J2cVdYe8s8/WSDThy7SatU0ZJTh3IWB3xKg?=
 =?us-ascii?Q?zlFHVzNcas21MGCqhNzkbt/kKT12hUbRGDfzmI1CZP86DqF1lIAtZwkRzZO2?=
 =?us-ascii?Q?p6gQt7UKz6Pa+7efggCy/OXQrqDneBwdpbY42zqdaIyKo4b5aSJ32n4HGeM3?=
 =?us-ascii?Q?4HOezD5ND3ODpYi7hVPSgKg625ExX5xSXPDqIH/VvP4NJiPqN5S3iEKYl8D8?=
 =?us-ascii?Q?W94QGvh/jQ4qGAmLESTCUdsUj6HsQ3lye2CHwSxMwa5HxEu6jIsnv7GpvGPe?=
 =?us-ascii?Q?E18ZMy2mSdHGJ/XCAilWC2SSMBNJQWDcx50QOwnOCQid9/db5m4C2UDsuDlV?=
 =?us-ascii?Q?3uzkgYKo58QSQA/KEirh1Ob81fm33Qix4uFX2U/t7DnQ6FmPeOYry6Pm5ETN?=
 =?us-ascii?Q?yl/H336VubVxQtWvYEDS/Nwaqzb+VnhxioJl+82PihFrfQaI9AYMkzrc3u/+?=
 =?us-ascii?Q?JNVPlkbgPci42HOs2sVEFDP2/Xju12tejTy/Cw4o65PAtLq6Jg8OyaUXELBk?=
 =?us-ascii?Q?ecmQ9kW6yHHwXDRVdyLnAeCYP7u+Liz0Iam40unUoYyU3Z+t/DFjfnbDourc?=
 =?us-ascii?Q?Y14KVzwDjA3lCMr22JBHj9a2kODmgjE49U5oFvQ5zZTfLj/BiHucRUDacd68?=
 =?us-ascii?Q?004ogxQgnbwwM9v8NGd16lvGV8PSjeX+EwdIPyWe1i383GePnIQ+jBmwNX03?=
 =?us-ascii?Q?V5VpkzuyNO/d57tSLy599XKUk/3uKWv1uJQQyeW09As6M/t8MuIpeJwk9N9c?=
 =?us-ascii?Q?iBCnPtHWx/KYmNwfY9AQqoq5loYiQu3kIX39uGcBHwnMvcx2eKXdQIX4XOdC?=
 =?us-ascii?Q?IpKgMFzP9zkAYyhttyp+VUbCF2vGQcZwyccidWdl+oAHztanO07yFJI0HAkP?=
 =?us-ascii?Q?a8zRwsHFam+QvvxKjlG4I3Rdy6mYz1Z4WfcY9ODI+N0S37ysg2Q1XDrBhQjc?=
 =?us-ascii?Q?WQuIM7y9JLs9ZyvEnppjsCaNKHAs4BtUVdCBYcMpvvpE2X2yepkv7VblbUtP?=
 =?us-ascii?Q?28Vk78whcsbdtvs0PkyIhcdh0it340rYgW8mEiS1EIAaZ1/HGdg+ob+OmvQ1?=
 =?us-ascii?Q?EX6Qb/5d/NVM1Qb2QCoej/dnTn0vCXJYQWASZ0g1ajCqMJgBcRLo0N4aZoNh?=
 =?us-ascii?Q?jBmbyOjiyIYTzhSwy7nJo1pj91DCCxAIzdmWEKvzGlREh9HNMW4p2puyS7DH?=
 =?us-ascii?Q?qUqFhh515fDtxfEqm3tjaTkBLkhFSo4fECyyOwpYE3byrAW6BcCU54fmx3Jr?=
 =?us-ascii?Q?GQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab656a3b-8c6e-4f15-d65f-08da9dee0b4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2022 05:31:34.3447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kbQipk89RnRSCJiWATBYFacLS5tvI329lEjz7hMm2JI9e7RiH5gBDWwsyoc02p5zL+wMKURp8htCA06Y58KPXW7Etbi43m9O9usnZLVUm6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3439
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Olaf Hering <olaf@aepfle.de> Sent: Friday, September 23, 2022 2:09 PM
>=20
> Fri, 23 Sep 2022 19:42:59 +0800 Li kunyu <kunyu@nfschina.com>:
>=20
> > +++ b/include/asm-generic/mshyperv.h
> > +#include <linux/version.h>
>=20
> A very long time ago I removed most usage of version.h AFAIR,
> so that changing uname -r will dirty just a tiny amount of objects.
>=20
> But, this header is always coming back, like bad weed.
>=20
> Please reconsider the suggested approach.

Could you elaborate?  This code is getting the Linux kernel version
to pass to the hypervisor for later diagnostic purposes.  In a large
cloud environment like Azure, it's helpful sometimes to be able to
correlate emerging fleet-wide issues to particular kernel versions.
The Hyper-V code in Linux has been using LINUX_VERSION_CODE
this way for the past 10 years, so this isn't new.

Is there a more preferred mechanism for kernel code to get its version?=20

Michael
