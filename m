Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF9F771302
	for <lists+linux-arch@lfdr.de>; Sun,  6 Aug 2023 01:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjHEXhe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Aug 2023 19:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHEXhd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Aug 2023 19:37:33 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021027.outbound.protection.outlook.com [52.101.62.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AF5138;
        Sat,  5 Aug 2023 16:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxAbGjulguXl4sGs5HkKOe4LLqyXb1p5MRMEPrHoP5HhXaPF8n/e5WaEACJ8Y5RxqcLdtSLMa5ADaZx2QHp5CCHBHTrWsaDkoJe8GHXpkdq7H6rRvsub+75axAUCyIBAUruWmKJo+UAbrAfDA8dQTnZILhzz4V1dAZ0NqehbQPT9ywI8qiGHV9EX+My3kbEMfDuihu7kPISNaMQlZavMEbsopRtlDRfCP1BifcwrNd4MZ0SKZ4uLDk3To3YkBIqK/DrZP5ZcOSaZLvYK0fF61DzGRXsszVDXit0tIbX/lGOzsJJm7XMPE/sj/5dMPjf6g0H+qVi+Vsm7tjSCLN07ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OpGIMVP++bkPMfybdUbVqUgBwnfe6nxp+1aXlofc5U=;
 b=dMXgtNR/VeWgMcSGpgt5aL1TVp4MN1DxsnKcNN11N+pxq5HqnHzx5gIVlXL0Dvta9+GDUL2thouJNFxYbuI2YQdjgfwAuPf7JLPeNIEqFnNsTh2tWuMlx9AM9xzTG/tkw96i0JwR36TtBm5qaDBZUxzOu71Hr77a310F/gweiuNifO0g5E5CJ51j///Qo8l56XsCicXf0AsdwLjvWmt+YciWgDA6eIkQnTIOX5Nafe2ckOf4lZMVQ/tWfL3P3fSuVRwfRdc/PWBL5Q++/UrslZqLar2BPLMi2s0rKpY9WwEmjfPBM4DHPaTdVlzmmXXfSMWnR0jEatIkyF4Dktd1dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OpGIMVP++bkPMfybdUbVqUgBwnfe6nxp+1aXlofc5U=;
 b=d3228ocrSFAbbpEZYVC2uC6tMSGstpVkFio5wmcGgo+qBH/YJASKClvgykYA1jOTGOyWUUup9pbqTF4s41yXKwMhQJSRwOYV1RV0zQ8pscey8XO0lhl79Uu58jMkKaEFpwaSzRU6cYfqW7u6yt+rcuA6r8Z8sUR49DUEd4deXSg=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by IA0PR21MB4006.namprd21.prod.outlook.com (2603:10b6:208:493::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.0; Sat, 5 Aug
 2023 23:37:26 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870%5]) with mapi id 15.20.6699.000; Sat, 5 Aug 2023
 23:37:26 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>, Tianyu Lan <ltykernel@gmail.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH V4 0/9] x86/hyperv: Add AMD sev-snp enlightened guest
 support on hyperv
Thread-Topic: [PATCH V4 0/9] x86/hyperv: Add AMD sev-snp enlightened guest
 support on hyperv
Thread-Index: AQHZxyxCzsivoayvP0umqaqQjq23k6/cXC9A
Date:   Sat, 5 Aug 2023 23:37:26 +0000
Message-ID: <SA1PR21MB1335A21D5D037FE88D9CF820BF0EA@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230804152254.686317-1-ltykernel@gmail.com>
 <ZM2LDKrcXvVUVta9@liuwe-devbox-debian-v2>
In-Reply-To: <ZM2LDKrcXvVUVta9@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=37bda7a6-2038-4d7f-8679-761f964c4b79;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-05T23:33:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|IA0PR21MB4006:EE_
x-ms-office365-filtering-correlation-id: bbbe4c18-e404-464e-d319-08db960cecfa
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: trbHxKqyhhuTe3vXiuy0McK9A99HIv5w/7jxs5V/GxMTDI4ksozmfItlaFMEhAJ/MrmTk4Gi6IKv3gJmvOB7vtrWEd3kOjUeFsWKhGgqedH9AtsoFp81Oe/VQc4vYOa+jRVZsxxyITRVWbad1pUtd1MT7WhNp5wvEBG9/LPd5eaBBxygoVHByuJS58P7VlBX/KTYTcl4QD1ovFbytoILRScfnCuQLF4ra+ic3DLbK1yi489+kWCl10SV7i0RfilVqpsQbAbrhOhUyZEk3aIFv0FssatcydAyiGQ3gB/ncnU2zdHOiDIqNpBi4UPv4pH25FrUKVd96mSkJwwcNiLQxUR9Qnsy1XJ1MqomvhUeri8ul9Ss9P4/Fq4VPPAcSa+sewqh2JohFJ0rVTab7aLm9VKtayH6ra0EzDTSep814ZTp4V87DGXzrLSfRFeeC3WiDZtupwoss+TyxahQFMSjALhS9TMWVLy0+lMdy5xrx/eZx+YfiJQNhl/1y4udNJU4Z/uu0frdmN9KzZ3zXeI5V0xWB3d7B+DwLHaaDuQwpOYlkVj8qElq2A1ONLpjabo6ckzaSxjdBz8xTf1jgTquM0rOxh+x874OiwkmEHEtZv/hYOlKdvK0khdgguY2vX7nN94NNT7gaEq2KdhvIlWcuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199021)(186006)(1800799003)(316002)(786003)(83380400001)(66946007)(66476007)(66556008)(64756008)(66446008)(8936002)(8676002)(41300700001)(7696005)(110136005)(966005)(54906003)(10290500003)(71200400001)(478600001)(26005)(6506007)(53546011)(76116006)(4326008)(9686003)(2906002)(38070700005)(33656002)(8990500004)(55016003)(86362001)(5660300002)(38100700002)(122000001)(7416002)(52536014)(82950400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?itDSKIL4oh+j7eQHN8rtGMgwfkhSpIg8wPPWT/slrPJi2dj7smGeixJ+QNNO?=
 =?us-ascii?Q?QMb8C+IpQL5g/xu8LsBufLw2L2K2TPy7HdaPugLx4xyKh81EtWlomMhbFU9m?=
 =?us-ascii?Q?mNgVIiQvB8S+ozy4nes4XDrzrnK1V6Jm29f2k/K5jFmogqnxZeA4Rqw55G7f?=
 =?us-ascii?Q?mX8tFut9TkNwGYlBSOnnf67ydjhZ9hggQ76ZKYJh4KvUKBrmYeGHAyY8Va9v?=
 =?us-ascii?Q?giirHiDiCDn95CWS6gaVf5BTrdWG/EWLeuffpR6dSXnG2K+ttntmkAExdAoU?=
 =?us-ascii?Q?Sc6jHrmp9lWwPx5t7aqxWZgSEwPXPDnUAr9oL11A/0IILncMMc/j/dlrr8i8?=
 =?us-ascii?Q?g1XCcAMcGyg+uukFa+2wVoMrf+1u7mTfQKjuvuAx7xPeJN4BE6dUUUriM7j9?=
 =?us-ascii?Q?F+ip1zHK1qnu9XUa+onEL/60A+3ObUujfj9tk+HPAUbxlc++MSTCHkm7NFVR?=
 =?us-ascii?Q?nCBFiTEzKdrv8MeIOTAZnkRRkqiSp3BxtgmNVlFX2RxT1/Za3eL0LYiFcggX?=
 =?us-ascii?Q?9VB0LgAc+9qSlhHe5Qz4SiVSqr+gsWl4aOXFp74vXyDmv9tRUkWJXVubodrX?=
 =?us-ascii?Q?T2cgjtRcDTClsFq8zq6ll0RfwX5OKBRSRJjymS5e6jQjqTbaPeUAE7PTh1jF?=
 =?us-ascii?Q?9AAgcBW2D0uSsEQnJLdB1DD3If7NmLjaFSoVpDpY6O7x7Q/XHLLEHwZp3DUr?=
 =?us-ascii?Q?SlI3D8cK9w7FEaLwhXS99rEyTXcz1nSbBnivFduGClZk7B/gm16mu+2HCyR1?=
 =?us-ascii?Q?q1QBMp4qIaw6twzimejRNPSsygNetVZeB2PAupIDgBJnPgdcljG+58Pj/8HC?=
 =?us-ascii?Q?E2KhMOfnE21JpcNu7FCgeTn75I7EhIz85jB0IxBOMoLo104dVSmM9DDBSSvo?=
 =?us-ascii?Q?QlSaaynoJpqffSkZ+NPrFZuMyoB181UySvDuwXAUXPCBWf6OiR3iSvVNV8C/?=
 =?us-ascii?Q?NzZ88/zXap0GPkYgRVHfWl7Zt6BCb5vw9kBzzCE379dOqv7wkdenXTmUsMfh?=
 =?us-ascii?Q?cg4ZyIVac8ZLE+2jCea51EneA24DNELUwtG2++LDzWPJPzLR9wYPm8sY8qnY?=
 =?us-ascii?Q?Oq9QnESsVswVNPDkacLNNMU3ITcBTAch+nAng5j5fTV92d5ptNTofZGTeTRE?=
 =?us-ascii?Q?sUObxqGsBbI6bMZtVZpnRWS98AJwJ34dksX7A/Xf1xhJ0Vxzm8uMyqqI4C6Z?=
 =?us-ascii?Q?czcZUK2WJhpRtNYFHHSPDiFpxKvrsmfqen3ZK67Zx9RKwRMQi8Um2N6aoGts?=
 =?us-ascii?Q?7HH+7wTHkpoo/W7zygVgvfXMqnF+AImxcj1E6RXX8+5p1taUoEw8wrKA0HvO?=
 =?us-ascii?Q?ET+BbHXJIeJayG1g4mfdarirEauqArjJzIiVr3ORToN9H+nfeMtFBQSIQkwJ?=
 =?us-ascii?Q?mrLOZU+RvSo0GZ8/tXri+lbXXH3o222BXy8k5ER5VdV2V8Gv7TfoJX7iyf0w?=
 =?us-ascii?Q?bp2Ms7sKUBMPkzHAv8JrtFOF1p0JqrfB0UnadgidMdFE5JyVyAJFhxmvazL1?=
 =?us-ascii?Q?zgPG/eokXd0miXL9EdeeFDLcEyhdFCRn1ujG8gdoVyREc7iQGFP3mAh5FL0/?=
 =?us-ascii?Q?KpJCGxIVclBqTmdw3lk3qZqpE60v5fucbiCqyIaY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbe4c18-e404-464e-d319-08db960cecfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2023 23:37:26.2635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dhxfjW/ToiZ72qytapZt5z1wqIISQ76Gy40CjnbVxml41Q4aR4xUoEQS8SF4L68kD85q2fwXNAnYM3dJShGV3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR21MB4006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Wei Liu <wei.liu@kernel.org>
> Sent: Friday, August 4, 2023 4:35 PM
> To: Tianyu Lan <ltykernel@gmail.com>
>  [...]
> On Fri, Aug 04, 2023 at 11:22:44AM -0400, Tianyu Lan wrote:
> > From: Tianyu Lan <tiala@microsoft.com>
> [...]
> > Tianyu Lan (9):
[...]
> >   x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp ...

Unluckily this commit causes a crash on Intel CPUs (see the below call-trac=
e).

I made a fix here:
https://github.com/dcui/linux/commit/c4db45f6256248435b2a303b264ecbb41320c4=
1d
I guess Wei can squash the fix into Tianyu's commit in the hyperv-next bran=
ch?

[    0.861465] invalid opcode: 0000 [#1] PREEMPT SMP
[    0.865489] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.5.0-rc4-decui-hc=
l+ #1
[    0.869194] Hardware name: Microsoft Corporation Virtual Machine/Virtual=
 Machine, BIOS Hyper-V UEFI Release v4.1 04/20/2023
[    0.875049] RIP: 0010:hv_query_ext_cap+0x7a/0x130
[    0.879626] Code: 83 72 57 48 c7 c6 00 00 00 80 48 2b 35 0f f2 9d 00 48 =
01 f0 48 8b 35 5d 3e 3d 01 48 85 f6 74 2a b9 01 80 00 00 31 d2 49 89 c0 <0f=
> 01 d9 c6 05 d4 f2 20 02 01 66 85 c0 74 aa 48 89 c6 48 c7 c7 20
[    0.897457] RSP: 0000:ffffffff82803e50 EFLAGS: 00010246
[    0.900194] RAX: 00000000074f72e0 RBX: 0000000000000000 RCX: 00000000000=
08001
[    0.903955] RDX: 0000000000000000 RSI: ffffc90000017000 RDI: 00000000000=
00000
[    0.908445] RBP: ffffffff82803e60 R08: 00000000074f72e0 R09: 00000000000=
00001
[    0.916354] R10: 0720072007200720 R11: 0720072007200720 R12: 00000000000=
00000
[    0.924285] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff828=
0edb8
[    0.929481] FS:  0000000000000000(0000) GS:ffff8880f6800000(0000) knlGS:=
0000000000000000
[    0.933589] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.936526] CR2: ffff888507fff000 CR3: 0000000006036001 CR4: 00000000000=
200f0
[    0.942279] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[    0.950573] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[    0.958417] Call Trace:
[    0.959827]  <TASK>
[    0.961044]  ? show_regs+0x64/0x70
[    0.962872]  ? __die_body+0x20/0x70
[    0.964741]  ? die+0x3e/0x60
[    0.966273]  ? do_trap+0xd7/0x100
[    0.967922]  ? do_error_trap+0x71/0x90
[    0.970027]  ? hv_query_ext_cap+0x7a/0x130
[    0.974573]  ? exc_invalid_op+0x53/0x70
[    0.978961]  ? hv_query_ext_cap+0x7a/0x130
[    0.983977]  ? asm_exc_invalid_op+0x1b/0x20
[    0.988932]  ? hv_query_ext_cap+0x7a/0x130
[    0.991413]  hyperv_init+0x2fe/0x5f0
[    0.993373]  apic_intr_mode_init+0x3e/0x100
[    0.995655]  x86_late_time_init+0x1b/0x30
[    0.997832]  start_kernel+0x617/0xa70
[    0.999546]  x86_64_start_reservations+0x18/0x30
[    1.003761]  x86_64_start_kernel+0xc0/0x110
[    1.008815]  secondary_startup_64_no_verify+0x17e/0x18b
[  Ubuntu
[ *Advanced options for Ubuntu
[    1.021465] ---[ end trace 0000000000000000 ]---
[    1.024093] RIP: 0010:hv_query_ext_cap+0x7a/0x130
[    1.026769] Code: 83 72 57 48 c7 c6 00 00 00 80 48 2b 35 0f f2 9d 00 48 =
01 f0 48 8b 35 5d 3e 3d 01 48 85 f6 74 2a b9 01 80 00 00 31 d2 49 89 c0 <0f=
> 01 d9 c6 05 d4 f2 20 02 01 66 85 c0 74 aa 48 89 c6 48 c7 c7 20
[    1.042358] RSP: 0000:ffffffff82803e50 EFLAGS: 00010246
[    1.049317] RAX: 00000000074f72e0 RBX: 0000000000000000 RCX: 00000000000=
08001
[    1.054740] RDX: 0000000000000000 RSI: ffffc90000017000 RDI: 00000000000=
00000
[    1.059058] RBP: ffffffff82803e60 R08: 00000000074f72e0 R09: 00000000000=
00001
[    1.062406] R10: 0720072007200720 R11: 0720072007200720 R12: 00000000000=
00000
[    1.070915] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff828=
0edb8
[    1.080300] FS:  0000000000000000(0000) GS:ffff8880f6800000(0000) knlGS:=
0000000000000000
[    1.086956] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.090242] CR2: ffff888507fff000 CR3: 0000000006036001 CR4: 00000000000=
200f0
[    1.093949] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[    1.101352] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400

