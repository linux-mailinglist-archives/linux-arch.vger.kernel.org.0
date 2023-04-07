Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978966DB005
	for <lists+linux-arch@lfdr.de>; Fri,  7 Apr 2023 18:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjDGQAq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Apr 2023 12:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240412AbjDGQAm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Apr 2023 12:00:42 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021020.outbound.protection.outlook.com [52.101.57.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1E230FB;
        Fri,  7 Apr 2023 09:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kk4sFaPDGbhEnt2WQHH2vRvOlOkBzeYk0VapUCUqgwMn49DcoRJlyMTFClkZJit5SGgaeWeQF90OLJypQ2wHjEa2wZVSMMMXxdcC5UBEM7aw1hdqTb9JWoemCO3WOHN29kAKFJwyecanT6ss5pmNpx4UkZP9QlL8ApNaNkTrcNxrSPaarxyaQT1yJZUeMsjy0ki2xYa20SIpd+JNCbKNrU6/wn5MldLtmkr71JDdH2QtyfezGAeMGCAyXWNRdANh96T8gmdiwjk6VafHNUvgaQdiBCT1dt2loreIhYZOtpRPNhyAeB3+vI5+PHtzfP6Vww76Lwxv+VRMJMIsKcXu/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVDqIr16mYBV9jn2iJf7g4LbXg01jPy0ky8KULqFMo4=;
 b=eC5yZkKXAde7IQBgvxqU3yDg5o3flU5Dd5Y7SpaTCPp7thBZnkbIXOFDE0OxgtGxcpGS8LC4Vxc6EvqXkvZxrUFtjPINAWllBehqUQupLVyBd806Yya1mlBPNKV4q9gwUUywnRnHoxohXH6qgbi7bHhLhiV6vlS7YayyHuAptVBvNH4hkhtW+k5U/wzDcvL7iB1J2pdaNyuBLQAi2qdmC2++s1Ji9ZcngD0HbbFp9SVre74eYcRN3ZFJyAzJYIFUaAikFKUlnquDgU0MyBMIR8e3RU1BlDdAMr8M+iD+gMDNWGGLsXokWy0ibIobmvNkGcYkhGMw9A2dRkOlYaqyuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVDqIr16mYBV9jn2iJf7g4LbXg01jPy0ky8KULqFMo4=;
 b=PjpQOYFdWR1/tsYaVzgt/hhrdSMIZpOGB7B/U8oBSxxZtT9SD6TrSJm2lv1bzl6J1aQ5eJHs++kX9sXvJZxrLPL5VgYcO366QEVhre2A5H4HNNt+btY5ngN8WUnfuyE2lPqX3jsuJagLGUAIXMUi+oiuXIie3D2MqcQVmrTCXNI=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BY5PR21MB1377.namprd21.prod.outlook.com (2603:10b6:a03:23c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.20; Fri, 7 Apr
 2023 16:00:23 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6298.018; Fri, 7 Apr 2023
 16:00:23 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "mat.jonczyk@o2.pl" <mat.jonczyk@o2.pl>
Subject: RE: [PATCH v4 5/5] x86/hyperv: VTL support for Hyper-V
Thread-Topic: [PATCH v4 5/5] x86/hyperv: VTL support for Hyper-V
Thread-Index: AQHZZtQDm7r7516jUUWroUo0jRWt9K8gBhdg
Date:   Fri, 7 Apr 2023 16:00:23 +0000
Message-ID: <BYAPR21MB1688B6A7BA3FCEE36C746C06D7969@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1680598864-16981-1-git-send-email-ssengar@linux.microsoft.com>
 <1680598864-16981-6-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1680598864-16981-6-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e35f8879-c39a-4dea-abd5-68b33058a0bc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-07T15:59:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BY5PR21MB1377:EE_
x-ms-office365-filtering-correlation-id: 028c7597-7a01-4c81-3038-08db3781324d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qt6VRtV41AuiM8rEae7/6L88njudAgP6N+Af8WPn5GgD95JtdpA1VbSWsqpKrybtcnJssojpzQfW9R7H7DoV29PjZHhVqQyFWq7hC1K5+pcOvnv2FtaQ8v8gKCLPYq2DOim+jV59bcm6P6HaHiFOG9pYB8MAU2DBBIUK0JZ2EC9r99YQh13d5PfFkTjnJrdfGWblFU6ww1IY/MiDPVpTyfSw5I5VFLkYRcHtzkRkYePK0lBTdECrK2IxC/kcZyrdgOiNY01cgASHND920dCPgG2dTwMnRQq0YpMTye074ZmMMVmU5jgzzNgC6Wskp4qIIplr0jRaoRM/fIYTIo2Ftem0CTku7UXpklpj3cBkYwKWQgZ53wAk8mBtE4wr8EMO0cxcAQOmdW0Y5Rcy8Ntu/oiRGUyVwzuU8zviiK2s7vQRYkZIjikjAqp43cQZ88RydzDWrRPegmPMXE84zLfq5AnqP5C0hKf1gPWWyOo8s2jl+bEsgjN2Uwxw5XcZGC2yuFhwUiSvbaVC0UyNrpJMeSDuyggT8yUmrQCBKOlEOFUfRsucSVWvY7NjTvvnSNg2HtotGQRfli1SHeB2xes7uLyvUE60hIFvUhzuj2C65CuXCPX/Db9Oh8lQgW9IbQsF5U8KxlkbM4sbBtiaJEUz6qJjHirPYcKeqhzWxTHoN69HVPHWADlzx+P58ojX2rKr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199021)(66899021)(66556008)(8676002)(66946007)(478600001)(64756008)(66476007)(66446008)(71200400001)(7696005)(41300700001)(316002)(786003)(76116006)(110136005)(33656002)(86362001)(83380400001)(9686003)(6506007)(26005)(8936002)(2906002)(5660300002)(7416002)(10290500003)(8990500004)(55016003)(52536014)(82960400001)(38100700002)(82950400001)(921005)(186003)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MVRsdfWeDO51p/2UTKIkfQMBqGPkDxo7YRSLTTSUxEqTee/6cXBR/H1Wa+JX?=
 =?us-ascii?Q?KVsESyxQp4i1VqkAWx7VkUZYyg7UBNsm7Xxd2B+uIK57Q5s8k2tNdA8jAh9c?=
 =?us-ascii?Q?jA0s9MpleEoRdGR2XXaiCsrZjIsU5a9ptXt8EsW+eIw/+pc3lAx3+V2yIJzV?=
 =?us-ascii?Q?Rs2Cflj/TlJJTmyHl2hIgICKYAIggYFt99eSsq95KsFQqCo226DiAF6ev12n?=
 =?us-ascii?Q?aphe+om11ay0tiQ2Jj2yMPnIOFaRF50NUchNxCfdTYl26jvO+wLtlMaAajeJ?=
 =?us-ascii?Q?8kg0x1t2yJAlzV+DwTj00ZAifIAszi1qxpbS3dJs/F5EzKhX8JYvEwsG+pIq?=
 =?us-ascii?Q?tir/6xRNJXKEdN/Pa5F7ggxPiISbtECNFF6NFb+s5dbTpON8QfT1+hKcBbrz?=
 =?us-ascii?Q?SurXKxIxKHmRjHYkXxFXFYDWIjQlurI1h19C8jpTA+uDzIjQ0f2aZ79PRyY7?=
 =?us-ascii?Q?qWiz50NppJUEBjRZLNr0Hhl+Rd+8Oy9+lSAJE0s7FnFWwtAM4CQxiWP/BHlx?=
 =?us-ascii?Q?ga0zrsXx+ylZFJsJN7CZHRwOCG+jH2AQ1iM9IX+NQNAuU2T1qcH7ZNKT+Sph?=
 =?us-ascii?Q?d8iZbG2alHThCot1f/G4gD2umk4fXoKFhsEfoQfRxHNBNFr5XAq89N5K9rD/?=
 =?us-ascii?Q?p+VLkThNvcznYmTZXtmqhSjL9M7dI+zloi82epnSHanU5oevO43Dt3WthXhh?=
 =?us-ascii?Q?gjSOlpmAqnXH2pZgH0Vv0oa0xGX0zvPdZeUGnKN9OUXGBHKkcj00J3KS0Z3j?=
 =?us-ascii?Q?vhr6Vg6VbRdmWbS2+05zlcBLFXxloww3ktn3p9nnNADKOVKxxa0BEMYsweAJ?=
 =?us-ascii?Q?w+tk2Nxdrxt3u+wNhIlsT6mREKJUyp1kdjK5FQLo7VSH9VsOi/QjyghgMbLV?=
 =?us-ascii?Q?WNknyGtZRyZj7jfFyqr0axhqm0xtyxTQQY/bK92xkmpkzaE9jH0jcYnBvqvo?=
 =?us-ascii?Q?tytIx+Z312V7nNcMZ+1o/tATJz7MZx0EUF5mtDDb9+lYk32gNkRJRigZrN9I?=
 =?us-ascii?Q?zGYbdUrZD+kKMpKYOWh4OtP13Br3M3pO1BKlvP8xblmjp+3+NreG2d+LI+n8?=
 =?us-ascii?Q?HKdzpog7M23qB/xx9k41mXZihQ73mO9GbT/D6RYaTtkI5jvEjayGq9XGT/73?=
 =?us-ascii?Q?V+MjWipgxaovGfdkQ7qsomyhJP4iagyju7aF+l1VqYKUKgLq0QC+atdJtqC4?=
 =?us-ascii?Q?JCiFPPo6yMBtfmnWqwNjT+ZVWq38Sm3t2EVo0VKiTS/NQaXYCT5tzfxrtD08?=
 =?us-ascii?Q?MmT00LOk1Z1cLq/jOtFhVsKPJq9lxbO/FdC3SYj7PCmI/681JV1ZYo6382MV?=
 =?us-ascii?Q?lXGiT/YvJywNk+awKE/XnByPt4uuOtYxkuR8kkG9mCkGN6MksKPgUFbmIJBn?=
 =?us-ascii?Q?iluEiIIY65Ng6PPRrydnXn0BrL4qGtj0h9O4RldScovPkUWBsLk8ahgka4Bf?=
 =?us-ascii?Q?PT+2ltv59jjvYmYLG7n6vb4wH1BJGsR26l0YX39UvtWQ8Tq+jAuaFBCOmCyl?=
 =?us-ascii?Q?yStnq4WSrNkuEPgzOGQW46eg2egmcPOlJaqM1OKxYZ5Hf08HprNu4MoupJ1x?=
 =?us-ascii?Q?pCBmFitMRArt/P2MrroKJKKz7luEaAP6CBerPIlptIGKiGje+KQeOYYCQzb8?=
 =?us-ascii?Q?9Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028c7597-7a01-4c81-3038-08db3781324d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 16:00:23.7157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wt3OinwGta3qhNH3TlicA+OyqBtZQH6XPRrPplCJBsmVOKlJT9P/E2Q6nDMutg6Xp2/AeDjcCOPWi05cn2GeueAqlSZC2qKPx6uPdOql5UY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1377
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Tuesday, April 4, =
2023 2:01 AM
>=20
> Virtual Trust Levels (VTL) helps enable Hyper-V Virtual Secure Mode (VSM)
> feature. VSM is a set of hypervisor capabilities and enlightenments
> offered to host and guest partitions which enable the creation and
> management of new security boundaries within operating system software.
> VSM achieves and maintains isolation through VTLs.
>=20
> Add early initialization for Virtual Trust Levels (VTL). This includes
> initializing the x86 platform for VTL and enabling boot support for
> secondary CPUs to start in targeted VTL context. For now, only enable
> the code for targeted VTL level as 2.
>=20
> When starting an AP at a VTL other than VTL0, the AP must start directly
> in 64-bit mode, bypassing the usual 16-bit -> 32-bit -> 64-bit mode
> transition sequence that occurs after waking up an AP with SIPI whose
> vector points to the 16-bit AP startup trampoline code.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> [V4]
> - replace initial_stack with current->thread.sp as per recent upstream ch=
anges
>=20
>  arch/x86/hyperv/Makefile        |   1 +
>  arch/x86/hyperv/hv_vtl.c        | 227 ++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h |  10 ++
>  arch/x86/kernel/cpu/mshyperv.c  |   1 +
>  4 files changed, 239 insertions(+)
>  create mode 100644 arch/x86/hyperv/hv_vtl.c
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
