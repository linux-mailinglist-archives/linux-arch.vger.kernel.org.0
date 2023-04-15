Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E986E3313
	for <lists+linux-arch@lfdr.de>; Sat, 15 Apr 2023 20:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjDOSQX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 Apr 2023 14:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDOSQW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 15 Apr 2023 14:16:22 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021017.outbound.protection.outlook.com [52.101.62.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6AEC9;
        Sat, 15 Apr 2023 11:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBeJzabrCGJ1VfK7FPo2kLq91y4e/zzD0hXGg9rVscXhykxCQnVklk/M+/WbWsfhvc0YsISsi/GCUt0GOlQeOZDt+4lCkXBROp46dwSWA9mZ4TAXCBAEbn6wm24CikAF2i7cY/j8Ng6Xy5Hfp0WFFWFLz6dXFNhuFx7MYgtGDEMkd3aQhVOKH7o22nlgNX/LUrSjrTFGNviqGj2E5zLQ5gAJB0f+WRkBFfBh1ejaEVrmjvRyFaWhdzOAcOMlDJex+j9Eyw6Z4jlt5lBgaDcRpONM7UsgLO5YijjFcRzddewvG9X9P1XQarw/Rva6f4Z6k6V+GL+/rqQm5EFbhPQWbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzP2Ojod4dkK9EOfzh3qyCxgPJl98Q5Y7M/woPkqUZo=;
 b=W+zjOimA+7tyszjVze0CToQYzkzwKgCIFl58HtnY368wBMWpbW/senKd19J70MrQs6p7x49jj1XAquaNN5g/kwWmIFWc83Xa6L6mGmOZA9VfOJACSxvvU9aRWvHrAN3l5FBb1NmzqJRGYgorx+LWJQSiRlIOtb3ri7nKYBx65SXUNnT8ZgV7MgbCm6rJZHRWHyJSgRX3+Mo1kYxsCnHh+GymlB4YlDjJn0u7ZGiYDfs7ZcP11E/5WWx+LIs5QFnjVD1hX3LmDKVoAZYM3/nAWkSMH8Of2ACjDAuA16YEpCHpQ0m2bGF1qplCAWQoehPyqtGWsnSVkrZgIB4GyvAOag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzP2Ojod4dkK9EOfzh3qyCxgPJl98Q5Y7M/woPkqUZo=;
 b=P6y/ICG8mWdfaghcdKsjtnXh1Mq3/v9GK9T5RxRxOjaTay4Gas9tLDchooTT/EtjB4UeqfRjXwehax5Oo7PL+xvpdH+VM5ipFexjRmZ1L+hy97yZX7u67rxepqJTNjgvkUMBXK21Cgq4Qgmac18ig3uR+yjhSKnrR5Dbb9fEBzs=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3177.namprd21.prod.outlook.com (2603:10b6:8:65::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.4; Sat, 15 Apr
 2023 18:16:18 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.006; Sat, 15 Apr 2023
 18:16:12 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Long Li <longli@microsoft.com>
Subject: RE: [PATCH v2] Drivers: hv: move panic report code from vmbus to hv
 early init code
Thread-Topic: [PATCH v2] Drivers: hv: move panic report code from vmbus to hv
 early init code
Thread-Index: AQHZbnA77MM6sqvIDkuIKrkV/0d27K8sr1vA
Date:   Sat, 15 Apr 2023 18:16:11 +0000
Message-ID: <BYAPR21MB1688377B56A9A844EAABEEDAD79E9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1681435612-19282-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1681435612-19282-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4f3d9eac-c5e4-4ba5-a82c-5c3769ecb8ee;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-15T18:14:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3177:EE_
x-ms-office365-filtering-correlation-id: 7121b0c0-cf6f-47fb-6f63-08db3ddd7e41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qo0Utmxc8rHtui5gMx7i9DXJg21pdcyL3wvdm10xskzLiGLy3TAC0hHktAUtwc7qVKdT8YWWxSoqyPW9Kw+GqlbaRR/JW2bZGtZY25/L0zAEXlsx36xJRf2fxmMlHJRCxRAPPSV7W1B205ud5asiOzsOdgyfwcydbPgQa2phzTwZOcxZCP+msftH1Jdni8cEQ/GXRa5/M8mD4FYwhPEU23oy2q7AgmY9aZ4PzZT9B3Sypg9U4g4Wugs0YALpfhjn5aNqoudmWscBu/9YsU5oZVlAjmXPpS8dcwvp+8wdjV8q8mKZg629FsmQ74RTVHF3iXKJAPYghL+j2Ra6nArwD5TrEVZblD5LcxhPe5cdA9KFEUDvB3ygPwGr75ZcaFZlrhLygRIAOIdslc73WcSlqHft16xKE7DHE63emsJ+q+VtXgqgQex9Vq+xSZFxxbpUnowQ7j5g7O+HN5Xv6RwMped8+wwCKWyukKTzsyGMtDIXJFhpOv1WHrlm0bLvHk83IJn0NHboUiiNvRzL3IgwnKQc71TU72lOuqLcvGwq95JXZu5Y3Xa9M5kCjHVeuKKU2S8Dtpzb9aixev5hyr+aWAVYa+rpOjwI6p6lGV0Hd0dqn2zOu/sww3ZEN0LBM++ESh9LiGSXY+0FqxdnyVOveY00snRTwnzLBkMuZuUXmM4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(316002)(54906003)(66556008)(41300700001)(10290500003)(5660300002)(786003)(478600001)(110136005)(9686003)(26005)(6506007)(4326008)(8676002)(64756008)(71200400001)(7696005)(8936002)(66446008)(66476007)(76116006)(52536014)(66946007)(107886003)(83380400001)(186003)(2906002)(8990500004)(82960400001)(38100700002)(122000001)(82950400001)(55016003)(86362001)(38070700005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KzGzpiMy1kkIcHoly51MT1MEazOpoIu0/cyKLH8O8KS0/TbWi/rbafKJZexR?=
 =?us-ascii?Q?MP1Z4A+3e1G484bpFp1VHviQkePmbr/kSrO4RqqYR8oUxKihbtoFJ/hxCc8R?=
 =?us-ascii?Q?BCx/fIAPjwgJL2oZbxZeLYXP7wov+Jl5wC0ul72ZfSTmat6XZm/m9H/29sdm?=
 =?us-ascii?Q?nQUNTv4v+VTCic7dJ19MlzS329gGuF5IsnquLcadXyI/B6iHFAz3mZK8l82b?=
 =?us-ascii?Q?ruxZgXoluHTl1zWXu0QqJ20bMpRV8fBQYoGFkK0aE0h+PxFEO83XMdPV6Gf5?=
 =?us-ascii?Q?giMv2xIoBBxjq8SOt6QhlcwJQfj3FZ8MtD0p4SSps7f1NQocZLhod+dLhMJB?=
 =?us-ascii?Q?6YcMm5futyqL5jHLejyCc4stTICeYeSCzZa+BYTtAOS5DR4x6AMF2K5r1fra?=
 =?us-ascii?Q?Dqf6I85TbQwqasAm3pj4A76TjZXDwx6qi0HzD+LD30BPe554NY39uzC5PCE3?=
 =?us-ascii?Q?ybsXD3OFrecPUI94xrz0T2OZOpsPu2GUHB3SgkhF2IekySxhzhWx9JG+HxP0?=
 =?us-ascii?Q?ej94coJ+1TZvmIQyALvrIIN94zseSG7Khp5DxacMzsPFqVhvib9Nd8Y3WJpW?=
 =?us-ascii?Q?QlN4Z8u72Twan1k5qR3X7FhmMCCccCISh7KgSKq298zSPsLOEjG4OBIuAlJh?=
 =?us-ascii?Q?0sRCK5T3TcTfCSmWQ0RR1TZNVCbQ3sqc2xnxmkIklZrj6e57th7hzMnGYC0+?=
 =?us-ascii?Q?KU7UjATwBi4bar5fJE2Gq4241vR/hB3vDxv/XNwxvCWlbZQS83MByfVjKh8Q?=
 =?us-ascii?Q?p1tBcwHSDaXWO62ykC9Udj9YM71NNaYuKf4WHc2hPdSynvzFmWmNPPsMo4u/?=
 =?us-ascii?Q?iGyaDUeBlI14slVwji9YVPVHYF2qInckCl6uMbW8GNqy71lIZ1ioMPIHD4Dy?=
 =?us-ascii?Q?xdU86bNvVOL/nhSJu3YDJE1x+rv8aT+m9U1dw+wPYe5kAkMWobQwV8rGIpM2?=
 =?us-ascii?Q?ssxH3ws+f5K9uf3j9JXzgOED3QWkWmiw39Oy/4XtunQMj6kZUF+7btS4wzBK?=
 =?us-ascii?Q?cL3gU8DVG8v9zzIulwliGFGf07K6vJgNJMVJCjvjsP6iUhPtINxOv1bgeBtH?=
 =?us-ascii?Q?ZPuYiA+5at4eS5iykbBXRk1g6i8Ex470MW+IfK7ygDXzE/YUmEWjpEq9DjjA?=
 =?us-ascii?Q?MuHJhDPDMkXC28Cuuc9LbhpFJa6+7lPDHS5jSFMxj5oOciGVWXRoQ/KNRSIh?=
 =?us-ascii?Q?pHicoiotjO3QadnrZKPU7BKmpKXqrDCsxUbLyW2VooUSsxHYgxEk4UUgzapf?=
 =?us-ascii?Q?edCWhMY46OcccFrLaGLm2yUk3H2pVdWp1wFWq8OmE3hcKhjFJGoYM9LYmpwW?=
 =?us-ascii?Q?6CxSPZ6k+YZwbmmofFVGxMALBBhqpjaKtexhx+AW3xMHUMNMt4p8ZnisauqH?=
 =?us-ascii?Q?fUotTGWXTPNT9u+NyiAAy+Y7IB4vH017LdyPl6KlIFEi0sDaJqcXjVJLUISc?=
 =?us-ascii?Q?kVL3S0zGiaiQjHuKLRF4mcW7cPyuX7cfVgbZrc3PPfDEbRhPzsc828kHwmnR?=
 =?us-ascii?Q?Zx2xqEwAETe1fh/rCZeaq0XR1PSAu2uPq2H0NQnNuhrG/sgmMcF5MaV32Vka?=
 =?us-ascii?Q?EO326XPpQR/A1n1rFoSygI0AAfJFgzu/MnBqN6s7Arvo7IfwKkkO/vMUr45B?=
 =?us-ascii?Q?ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7121b0c0-cf6f-47fb-6f63-08db3ddd7e41
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2023 18:16:11.8286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJ+EzucToLEPiMcNqyiNVlvy3MlrNZ9RzPZ8nPalRWTsMgUN2zYXIwFD+hwhgQtJOfcnABoexWLbkm7vGWXrwGMHgpsdYaEByv1zUtmoTiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3177
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Thursday, A=
pril 13, 2023 6:27 PM
>=20
> The panic reporting code was added in commit 81b18bce48af
> ("Drivers: HV: Send one page worth of kmsg dump over Hyper-V during panic=
")
>=20
> It was added to the vmbus driver. The panic reporting has no dependence
> on vmbus, and can be enabled at an earlier boot time when Hyper-V is
> initialized.
>=20
> This patch moves the panic reporting code out of vmbus. There is no
> functionality changes. During moving, also refactored some cleanup
> functions into hv_kmsg_dump_unregister(), and removed unused function
> hv_alloc_hyperv_page().
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>=20
> Change log v2:
> 1. Check on hv_is_isolation_supported() before reporting crash dump
> 2. Remove hyperv_report_reg(), inline the check condition instead
> 3. Remove the test NULL on hv_panic_page when freeing it
>=20
>  drivers/hv/hv.c                |  36 ------
>  drivers/hv/hv_common.c         | 229 +++++++++++++++++++++++++++++++++
>  drivers/hv/vmbus_drv.c         | 199 ----------------------------
>  include/asm-generic/mshyperv.h |   1 -
>  4 files changed, 229 insertions(+), 236 deletions(-)

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
