Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DBF660389
	for <lists+linux-arch@lfdr.de>; Fri,  6 Jan 2023 16:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjAFPkC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Jan 2023 10:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbjAFPj6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Jan 2023 10:39:58 -0500
Received: from CO1PR02CU002-vft-obe.outbound.protection.outlook.com (mail-westus2azon11020014.outbound.protection.outlook.com [52.101.46.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B5877ACC;
        Fri,  6 Jan 2023 07:39:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiOnLz+VTL1dDBGcvpIfZDhjE0nL2pIPQOKo9LGtHhRe864BtOEumERsMzO1nPAH6E9MsvKaxsb+L4podPzYNn60+M7ASUW+dLiO7A32VioGg6i475K3ypG3isDaRMPHAqB6/83IgjEsYQuxhfyFPcvzO2oqLeDFJ1Pr0G72MEI1QBbEsmnjaAF+yLkE3jvE1ddEYsEvTbms0s9skJ6H+pAXs5Eaeke5eMWxecZp/GR4FNg/VA1FYbmKANIiTwVftJZQrGCDyGAniOJRV+JeL6Tk5/CCQn4brGNWVOe/A6LZtLFrT8QcqzQRP2H0slNDClliG1qZSirPrc4eOxW3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGVeFsyQQ8aIidZICZ8ftlB1EWPNeLBEBLUOfGMj0tg=;
 b=IU55muww7CIo6F7NEHGKBu01EFaf9/7oG8JWwKWr97GxEML1s9ynbO04HJ7jCz70S4DoT9K15x3KxNfZD1ZMI26LJyB2LtsxCO3om5P0L3I681Q4iGYY6V7YfKs1CB2SbM70ZYlNxA3Ij+ZgqeCHs3AC0BaPZQwXtt30cPvrYTdAC70yGOGOckc/55WgUaOi38N0EpdaCHtZYmsbflbeuEo5eVr8LBcTfFsx/6Fy9gbTvoVRT2CTS/AOR8OTeCi5Tdh/UzFpdxxRuSPVBquMjt22Cf5UcYESJu2ztY9SGwSkpumtXYvjxm9bThnLAp7BY7NA4bai+XMkWZDqAKsQpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGVeFsyQQ8aIidZICZ8ftlB1EWPNeLBEBLUOfGMj0tg=;
 b=i9hRj0UU6LysgxrsNT4mUjC7yo+KtI8t/xt0uHcABWEcPRLthK97AcS6cRyoHj2lS7rRPNm9LcLKRfXYiLFPw4OjfMc+p4L3Rm6di65Y8GsbWD10Pk7U/AI0CZ0PFD7dxhtklyVd5p+UujgUKBXhpqV9mv2ZrLq896wTvG+TcYs=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by IA1PR21MB3568.namprd21.prod.outlook.com (2603:10b6:208:3e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.9; Fri, 6 Jan
 2023 15:39:54 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::9244:f714:3c6d:ba37]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::9244:f714:3c6d:ba37%5]) with mapi id 15.20.6002.004; Fri, 6 Jan 2023
 15:39:53 +0000
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
Thread-Index: AQHZIOpXAghmsq3xdEqAL1zty4oDaa6QFLQAgAALbQCAACLkQIAA6XCAgABbXZA=
Date:   Fri, 6 Jan 2023 15:39:53 +0000
Message-ID: <SA1PR21MB133593372417A79174325350BFFB9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221207003325.21503-1-decui@microsoft.com>
        <20221207003325.21503-3-decui@microsoft.com>
        <20230105114435.000078e4@gmail.com>
        <SA1PR21MB133560538DDD7006CCB36E30BFFA9@SA1PR21MB1335.namprd21.prod.outlook.com>
        <20230105201024.00001ea0@gmail.com>
        <SA1PR21MB133576523E55BBC7300DE2B1BFFA9@SA1PR21MB1335.namprd21.prod.outlook.com>
 <20230106121047.00003048@gmail.com>
In-Reply-To: <20230106121047.00003048@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bf7fea4a-c69f-4eb4-aa04-bd2a15909209;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-06T15:37:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|IA1PR21MB3568:EE_
x-ms-office365-filtering-correlation-id: e7963bc3-3bd7-4bf5-bd06-08daeffc41a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FNi/qWZ6C6PQ2yKLjG8Q9C7qAlY4POqNA4EwZUWnjMEZhSjGyqZlQ2/62y8PrEI7iOK9eQGXxfKZgGv3k+mhfR3Y8n/R0Ir1OBSXgcRmvSwu7yMfH+34z6T3PlBewveKEXlTPVxZGMb4SiU1exxPEubqPgasBEJ3sHWZf0oYAcyIE+ARlSR3iZ5WgZDLwRFr40lrMqhQYWoZOsARKAKD9VsMTRlLPAl5yDv3LoYc24Lb4v6mahDkfHRSril2zqTIiEnan3rjfNAFjL5x3KlziK5Z6h6IQLO/MRUlPMSL/AW7sFFESKBqjveIAZ2VvwVoQbD9VKqJipHECqk7MgXF+9r9qMoVfXjsOpEODYF6ESyV26wnSpgkhxDRX0cfFOSAvgWKOb2IxWtZntoQlpmVIwUoj14S4ztU6YGAllVkRadU4EQkQuqCBBw1fRD1T1hz2s0mOP4PE6Y15AjAhX6/7nFpK/f/cY13CIdfpYkHxg2m47LwNptm95Ioag1+meP9J1dkc3B7Mk+gvrPfaKq2hgMbcXIFhEKrxsbjKai6OF0VJNEnrDaRYXz76vWbQylvcmqge+HIDW48W0MxIFNdkgGZDpzp+eVrQyjUeQ9k4W7KeZ3p7NYDacDbXSCW915A6xHjhLj4Nr5XDbBrhfd8wC+nC2Rre0BtXXNkOuL/Y6qDZCOivUEcvNfDm5lAcgNJ0qwh4f5d/95fHHRRaz64+3FuM2U8YUnbfQukHq4mRvZW86XnTf3x+si+l3/vj8ng
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199015)(38070700005)(86362001)(478600001)(316002)(6916009)(9686003)(33656002)(10290500003)(55016003)(54906003)(5660300002)(66476007)(122000001)(53546011)(66946007)(64756008)(7696005)(4744005)(71200400001)(76116006)(41300700001)(52536014)(2906002)(8676002)(7416002)(66446008)(4326008)(8936002)(66556008)(8990500004)(38100700002)(82950400001)(82960400001)(6506007)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?COxI3IkyrRoIv3WNP9evF3GSqH5zB8g066OdGVowF98KX+/FBnqg1asVXLyZ?=
 =?us-ascii?Q?1SY0S3I3lw3Ni+nWGxMwQs8K+l1GzuDcLirmWkqGN/3bZ9n5PumPTdJjB0A6?=
 =?us-ascii?Q?LhvXq+lBEXbGEdYcEl36WLGg6hgaIuWhAD1dq/aSoDiBeUWV3BgUdDxMWY+z?=
 =?us-ascii?Q?28RN+Rj5to1aSL4B35sLmyOJDxbKdHTuWd7SQ2nHIGs+uekrYlwEBUUU38GP?=
 =?us-ascii?Q?Bfab9ayz/OglFBSrUs0e54S1L5Q/WUYXOStN1LheiK2coczYN9VQW2arnIu4?=
 =?us-ascii?Q?d225pF6HZqjewVaCVF7roAxuDV11mCV17Fh+ktsF0JBw6vgaiUKD0KupiRQA?=
 =?us-ascii?Q?jXPTymRWhatscW2CfJ1A/rU7HIMhyrqwDvMAun+dyanrErayitoFUsv/5Hfg?=
 =?us-ascii?Q?HLSVt1B5AX7qQzt4gCWkdHyxS4zEUjBkwdB+2kTpAWGGATjNyR7I8MIH/IJX?=
 =?us-ascii?Q?jRmANpAqnh8Gd7XN1p4yvgRloq7g4Zu2uL0q1BBOstKgItrfZRwXOyJrkC4F?=
 =?us-ascii?Q?hjVnlnCNoqd4Bew9K86V2Ok6Ymy9vOQ4F9q+S5ckBd48gQ227JyL7K9NFkEY?=
 =?us-ascii?Q?pnI1rgsTVCxlCP7Y+kv8bLd3lfaPHLqhrZddLztJyMQMSQczTo84qveZ5nIC?=
 =?us-ascii?Q?3fXd1RYkV5YuDnpyzQiboDblVV3bfnPoYHSm6RqeBLoE5ToMyqKFyZrwzWEV?=
 =?us-ascii?Q?W6g7jHqn5AtiabwVc6LNa80VwomyhesH3RJpVWXyPgp17o1bBOp13WHpRBhx?=
 =?us-ascii?Q?7ts5oSyjXn/BHQ/jFz9kfMOxNkDe1dBr4vswJFJ8vnWyOJ3XMKG/y4J4iNCg?=
 =?us-ascii?Q?d38uLZHVkOcqdbNojWTeIYPuBkIpa/CpVN9iqmW+g6iOz4XmHyTF5dyGSulA?=
 =?us-ascii?Q?mpUhk3RBOzLzxlW7B5vfIcK3ddmwUl4sOwpSQpYuq2M5DWt+Xw+txN1P1Ni8?=
 =?us-ascii?Q?Whka1mPgIylV/sKV133fjreb/3nWoeaTIJmhBBkGciEcuvdmeJ6a3/ARjh0s?=
 =?us-ascii?Q?o3DBFJVhvw2KfnpJvpt8ecLZxyyaQ7BaiRcsT39YWkBHvJi+71+7EnyCpKOI?=
 =?us-ascii?Q?oXkiMPSd304+eFLnsreHRVem94AcAfOaRXAXJfQn3YUOobml4Ta35RHvKXxo?=
 =?us-ascii?Q?ct/Y0/2eSXNgSLiU271r608NoJCxH/Fd3L9Bv8NjsxJUvXZu+wYECyqvh3ZN?=
 =?us-ascii?Q?Ed4PVZYW0LxQWvkRj3XdxbOfKLBU7jSMztYoWPYFTyofmu6Fvi2V0+dRFuAb?=
 =?us-ascii?Q?k/jjIYp2am6Qdpa65M51Zrw4/p3Lg4+o/ltC2VUvN3usjM2kFEBOIF5XLO1Y?=
 =?us-ascii?Q?p7pMS8+92mA0nuEAzKMVYb+Q0DyEcHFHsZ+BrJEzE5GN9p5efGLuxpSXV8QA?=
 =?us-ascii?Q?ScSwOJe9XchpOvXqECpSZA/6/76XLOItauLfnPdjDMXdZjJy50DkqrRh9CFf?=
 =?us-ascii?Q?wT2Z1Wz5JvTTEw/06DyLo703DnUy8vtAkaANPRSQlW7yD/Swsi8xAyzjMoaJ?=
 =?us-ascii?Q?BDkzH4QUc7ZLRlamE1yVepLN67NW9PMp/an/c0A3CjVOo/xDvmD8WnlxKVSe?=
 =?us-ascii?Q?0VyYWt0nxa+rMq0LmnhQDu9TV0mMM6jp8rAcTVuM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7963bc3-3bd7-4bf5-bd06-08daeffc41a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 15:39:53.8277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CNgBmz8Mvf29VYWVsvfSPG+8c73XM3Rlm7uqcdr1ywSrz0UTUohSAVuRbsKikFDY9Rr+JQDOuZ86hvmT1DRQYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3568
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
> Sent: Friday, January 6, 2023 2:11 AM
> To: Dexuan Cui <decui@microsoft.com>
>  [...]
> I guess we both agree that memory conversion in HV should be done through
> coco so the hv_map_memory can be removed (even the extra does not hurt
> currently)

Correct. As I mentioned, Michael's pachset is doing that and hopefully it w=
ould
be merged into the upstream soon.

> The memory conversion in current HV code is done by different approaches.
> Some are going through the coco, some are not, which ends up
> with if(hv_isolation_type_snp()) in memory allocation path. It can be
> confusing. I suppose a reasonable purpose of hv_isolation_type_snp()
> should cover the AMD SEV-SNP specific parts which haven't been (or are
> not going to be) covered by coco. For example the GHCB stuff.
>=20
> Thanks,
> Zhi.

Exactly.
