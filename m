Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5996B780C4B
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 15:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377015AbjHRNJ3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 09:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377017AbjHRNJB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 09:09:01 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF3F2710;
        Fri, 18 Aug 2023 06:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+EFouPflCJ2lmhSxAXM8kHXPdLeMeSmsKJetiMleMAPctRrdGIMAdXbyPvrKAOZj7SL6QltDWY6rtID7jhtlBSY5FuGGABML4lnkRgZ0i2KB6/sZDLviKQqKAg6aR1dty5zr7+tU5B+jdRVDzMwbImTimZtlwbUj0i7A1hEAeI2f4GNFCcoznc7Hjo1RhnT2kw7Q2aHqttlpIz7sfiW1xeKxl2za2UigSK5W2KEbaaF5LIkuTXnH+HU/xqeqo9v6pDcvRncKCKedDK4Rql/FjCj1fP753nq7Z2KcOv9yxRrS0Pn60bHmcWn4f2wyClBT7S+L6X0XunGxqFscz6Nzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93a4wbzzdA7YksktJYnALB2Qi22nSdBLNkYsH4CYCTI=;
 b=dQxuv8jbWfWy9DA5zjSAUVZnUGMmMcz0agZeYDnHE1btT51GKxWL2YTV4G5db5YqiiINSjM/MLHdVW597Zz8/ZTYLVD8T6AxqramEAQS4pEo+IVrOBGMC3BUlv/I50lQdQaidD6L77NtpaZo1U11WSnWi+4FvcWue8LWCTvMbauyN/IuaaIUbReIAUsbcUVAPnReSjPwH3d5RQwwJa+bkA2Ndd+60L/kS7E05vfw5MeaYY1gMtFh8G6zu2OY+e0BvYkDHcIz6RFBz5Z2sXJE7XkF65YJ8Ltm4GQR7xPrKx1UdgkU/Vev2z8OQ28p3iAirf5oB1+d5lbgABsLtvP4+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93a4wbzzdA7YksktJYnALB2Qi22nSdBLNkYsH4CYCTI=;
 b=GmstIxQLW5axzTTkpQzQJQAJ75YAClVxjDl1oTvOc7U+Dn/Nb5oGVJhGcVB0/Z56bUrSzoS1L0Gbf4xWK4CapVUMAyLz6DUVQBUpMsV+8J0qUkDn6mLzR4flYm9vgti+qx7zfXPaJsoYiMIStjR0wkB1UaKH+cIXx5HrWEIUl8k=
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e2::8) by
 PSAP153MB0407.APCP153.PROD.OUTLOOK.COM (2603:1096:301:3f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.11; Fri, 18 Aug 2023 13:08:50 +0000
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::4153:b8b:7077:5188]) by PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::4153:b8b:7077:5188%6]) with mapi id 15.20.6723.010; Fri, 18 Aug 2023
 13:08:50 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "apais@linux.microsoft.com" <apais@linux.microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        MUKESH RATHOR <mukeshrathor@microsoft.com>,
        "stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
        "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>
Subject: RE: [PATCH v2 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Thread-Topic: [PATCH v2 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Thread-Index: AQHZ0VZ96EEPB9Xi80mUoj983vpcr6/v7KBw
Date:   Fri, 18 Aug 2023 13:08:49 +0000
Message-ID: <PUZP153MB063545036E6B547C009F6AECBE1BA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-16-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1692309711-5573-16-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ae410653-cd63-488e-8612-7918ddd44bfa;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-18T11:32:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0635:EE_|PSAP153MB0407:EE_
x-ms-office365-filtering-correlation-id: 4d35bb04-84c4-4161-5cf2-08db9fec432d
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zVfnFsbp0hJfCdVkY8iHZzqcs7nyNpdd3vOnUQXUuUeFfPZ3PXIGHME42qOsamSVGuGeclTnuxO5nSJCCMq17iw1sCjticPYDTCL/XesgV0bExLHeW5OxEJa2ysXiW9xsOySfXigf1pBHdRBF7iXs3KRisuZOa5LpTVGWCFJDtkFQLThEWEj3myIkZKmNtiFjvquFxgMw1kdDXbrrOfq0k7fLH9HFJ8l/m47u3NSPUeWAJPNdOtwXp9SrHrxksEQQXQuYuqygiCZ3rWhjC93/txEvar6iQ8CGWVxxD7EiV5ZLBWA9dVtlsBqNva6pkxtrgIIbbhWF/CAOIvGV1sOHkMyzHGT9zdmxoJSje37fZIsekohBsSuC/ln8yRIc1shJYn2Gqzj5HXY+EfLRCj5EielUrdfDHCoCbVd2/atGideDNMbur5B1x6lACvNEiKAli6T5ts1ELK8KHIzbeBY3MEdrgfoJUqxixjmuzy7z0vWjMbGb5WzXU7IDBJXfoH9sgvb71awXuBAslLirFg5szoiE4WJJX6UDgvMyWnbFBcroAb/sWJWPKeAW4N0RaSWBKOazKHeoGHctsgzjrc9zr7UwTrru+iuV/jHm1ATL3VjAesm86k3XKJp56i93NroLA3xNCfMF/gDPEes8Eeb2MeHspDQt4xqxtT8GVyqQNR9f1B0m+nywdjJN1epTkxWkaoQCg7MGOovwyo5Yel1FLaaJ1IpQ0+L7eSBJN/+Fps=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0635.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(1800799009)(186009)(451199024)(86362001)(30864003)(5660300002)(33656002)(7416002)(52536014)(66899024)(8676002)(8936002)(83380400001)(8990500004)(2906002)(55016003)(9686003)(66946007)(76116006)(7696005)(66446008)(66476007)(66556008)(64756008)(10290500003)(478600001)(110136005)(54906003)(53546011)(41300700001)(6506007)(71200400001)(4326008)(316002)(122000001)(38070700005)(82950400001)(82960400001)(38100700002)(12101799020)(60764002)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?31X3b9lvoM8aL1IhRFuTTnN6jrmMisMm0TyN2kN1VOCv36ra8iE9N8IF2h3R?=
 =?us-ascii?Q?kux+qcn19HyrjxiVvn3HDZlTjjOpQ8J3mXuzIUYEsVhEoACn085n3kgLWSqB?=
 =?us-ascii?Q?dAhFaLAVRI4rSE4RL2jJmm6ci4yNAwLwPqkgQ+HOYNErjmXEhSja3wlXKxrF?=
 =?us-ascii?Q?naLismdeAKeRoJq7o5cexWzhuqe/VjeazRmL6elAsd7Gb9VHtDpM31DaY9C6?=
 =?us-ascii?Q?jsUMJ11DmvLqaBRYzIkqejmP7TF8z2fzW/uhiNIJnMHRfiIGR8F6N5NY+7uB?=
 =?us-ascii?Q?9dRrKs3aFOQNgxu3W8H9V3pJHKo59LTs0SOHjXnKKRnLN684EkvNP9WntMut?=
 =?us-ascii?Q?NnzGiuufEQhccC9xyENHWFMqs8uYJQO4CDJiPdaNL4AHClh8hD3JBm/k+z7C?=
 =?us-ascii?Q?h34LhTViDZG678kOsbdm5recO0mUl1/44VFHxu+Vs8zOvERvY+To9aO0ZPxU?=
 =?us-ascii?Q?bICUTADxjHKW0L5KCwjqKjoDtaEhMrCx3EHHdZcGIx/RhYUD4k0W+juXUr5j?=
 =?us-ascii?Q?con0xETrZFxQESg9rcAkhTPwdsksdVesReSRHPOpywcdZM7/oJIv8ND2aRO5?=
 =?us-ascii?Q?D/L7z8WRJlxaRjH2nyR7NcJcCOY+pIBYAvrtajIkz+ZqXnB7JxwYe7MxfvFF?=
 =?us-ascii?Q?xXs7PDqZyiGGyor0TJW4TyE8jE8n+uYmaeQT2f3tbpLu/Qamqt31Qi9DR14x?=
 =?us-ascii?Q?jMSBF981t0r0S75/GAAaEHgcvRa4xRZfs7DixpaxJA/VxG6HQjpIFWuGtR3u?=
 =?us-ascii?Q?3qFMS9Eo6QpAUYmDSVbrX8OaZJgv5WvAa2udKpD20W/AK5WjP9s2IYdyhv/q?=
 =?us-ascii?Q?VOt9AGnRZO8XdPwSbQ9X3gCnilUHxW0W+20vfagujK05rwIqA1JO4oGFI5mB?=
 =?us-ascii?Q?S9zSeVH7w1cW34/yTCHorRCTl9RQf3gh7youmiBajnBb7b8z9Ta2xykBwQXN?=
 =?us-ascii?Q?/uqwl6U3VwsySXD60f2oFD4DGe4Vp1OuOTm5FgDe1Hn7ynnxBkKDLqU4QDBj?=
 =?us-ascii?Q?1xDwSK/VX+B07TvZQYw50kL3sHsVdLwwWTXXhHuKs7qFSLyddktIxWFPS1nm?=
 =?us-ascii?Q?w+Bv2zjYQf0bE/lNx6pQRsGnVjTus2S58gbzXprbrdulBLw9dyc16wgJVvwp?=
 =?us-ascii?Q?2m/oYA0+4xfgIwGZd+yiP0yUXb31LKTBO2IOgg36TN6Y4RADCTlfokRDIl3r?=
 =?us-ascii?Q?cGBMQyGjpXBiQ0JmfO/dFqCwy4S+WE42Yo+P9CsS64UmPiwE8oNJWg8d/OBq?=
 =?us-ascii?Q?HxkjLKkGcdrPnfk8kgq25NbhL+MpkSZ8VnVtu3hlM6Rvr7iWeVPqAIwvZrg1?=
 =?us-ascii?Q?ADaCp5N1RSq++f8LtC6d3qF3XKHlnKc7cXMwtlIUCOaLF5Lvy3VkOGzXigOm?=
 =?us-ascii?Q?924T88rqjNAlF+YLjU4VBk4jm5+Hui82amxRTIpXyKcsM36Kn1f7jhfCdL1z?=
 =?us-ascii?Q?qkH5CHkbOmAh1uk6tXLkGQqMMdvGOQFM/uc7kB92z8HNHwz7l5mrcg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d35bb04-84c4-4161-5cf2-08db9fec432d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 13:08:49.1162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3eXtyrXJPXXmIYHB2HGdrPPVmPEj23zw4joS1xeWU8nuzeJmDWFegBfXOO0u8G6jlHbzmcYbs/aJKm6bHWN3HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAP153MB0407
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> -----Original Message-----
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Sent: Friday, August 18, 2023 3:32 AM
> To: linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org;
> x86@kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> arch@vger.kernel.org
> Cc: patches@lists.linux.dev; Michael Kelley (LINUX)
> <mikelley@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> wei.liu@kernel.org; Haiyang Zhang <haiyangz@microsoft.com>; Dexuan Cui
> <decui@microsoft.com>; apais@linux.microsoft.com; Tianyu Lan
> <Tianyu.Lan@microsoft.com>; ssengar@linux.microsoft.com; MUKESH
> RATHOR <mukeshrathor@microsoft.com>; stanislav.kinsburskiy@gmail.com;
> jinankjain@linux.microsoft.com; vkuznets <vkuznets@redhat.com>;
> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
> dave.hansen@linux.intel.com; hpa@zytor.com; will@kernel.org;
> catalin.marinas@arm.com
> Subject: [PATCH v2 15/15] Drivers: hv: Add modules to expose /dev/mshv to
> VMMs running on Hyper-V
>=20
> Add mshv, mshv_root, and mshv_vtl modules:
>=20
> Module mshv is the parent module to the other two. It provides /dev/mshv,
> plus
> some common hypercall helper code. When one of the child modules is
> loaded, it
> is registered with the mshv module, which then provides entry point(s) to=
 the
> child module via the IOCTLs defined in uapi/linux/mshv.h.
>=20
> E.g. When the mshv_root module is loaded, it registers itself, and the
> MSHV_CREATE_PARTITION IOCTL becomes available in /dev/mshv. That is
> used to
> get a partition fd managed by mshv_root.
>=20
> Similarly for mshv_vtl module, there is MSHV_CREATE_VTL, which creates
> an fd representing the lower vtl, managed by mshv_vtl.
>=20
> Module mshv_root provides APIs for creating and managing child partitions=
.
> It
> defines abstractions for partitions (vms), vps (vcpus), and other things
> related to running a guest. It exposes the userspace interfaces for a VMM=
 to
> manage the guest.
>=20
> Module mshv_vtl provides VTL (Virtual Trust Level) support for VMMs. In
> this scenario, the host kernel and VMM run in a higher trust level than t=
he
> guest, but within the same partition. This provides better isolation and
> performance.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig             |   50 +
>  drivers/hv/Makefile            |   20 +
>  drivers/hv/hv_call.c           |  119 ++
>  drivers/hv/hv_common.c         |    4 +
>  drivers/hv/mshv.h              |  156 +++
>  drivers/hv/mshv_eventfd.c      |  758 ++++++++++++
>  drivers/hv/mshv_eventfd.h      |   80 ++
>  drivers/hv/mshv_main.c         |  208 ++++
>  drivers/hv/mshv_msi.c          |  129 +++
>  drivers/hv/mshv_portid_table.c |   84 ++
>  drivers/hv/mshv_root.h         |  194 ++++
>  drivers/hv/mshv_root_hv_call.c | 1064 +++++++++++++++++
>  drivers/hv/mshv_root_main.c    | 1964
> ++++++++++++++++++++++++++++++++
>  drivers/hv/mshv_synic.c        |  689 +++++++++++
>  drivers/hv/mshv_vtl.h          |   52 +
>  drivers/hv/mshv_vtl_main.c     | 1542 +++++++++++++++++++++++++
>  drivers/hv/xfer_to_guest.c     |   28 +
>  include/uapi/linux/mshv.h      |  298 +++++
>  18 files changed, 7439 insertions(+)
>  create mode 100644 drivers/hv/hv_call.c
>  create mode 100644 drivers/hv/mshv.h
>  create mode 100644 drivers/hv/mshv_eventfd.c
>  create mode 100644 drivers/hv/mshv_eventfd.h
>  create mode 100644 drivers/hv/mshv_main.c
>  create mode 100644 drivers/hv/mshv_msi.c
>  create mode 100644 drivers/hv/mshv_portid_table.c
>  create mode 100644 drivers/hv/mshv_root.h
>  create mode 100644 drivers/hv/mshv_root_hv_call.c
>  create mode 100644 drivers/hv/mshv_root_main.c
>  create mode 100644 drivers/hv/mshv_synic.c
>  create mode 100644 drivers/hv/mshv_vtl.h
>  create mode 100644 drivers/hv/mshv_vtl_main.c
>  create mode 100644 drivers/hv/xfer_to_guest.c
>  create mode 100644 include/uapi/linux/mshv.h
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 00242107d62e..0d9aefc07b15 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -54,4 +54,54 @@ config HYPERV_BALLOON
>  	help
>  	  Select this option to enable Hyper-V Balloon driver.
>=20
> +config MSHV
> +	tristate "Microsoft Hypervisor root partition interfaces: /dev/mshv"
> +	depends on X86_64 && HYPERV
> +	select EVENTFD
> +	select MSHV_XFER_TO_GUEST_WORK
> +	help
> +	  Select this option to enable core functionality for managing guest
> +	  virtual machines running under the Microsoft Hypervisor.
> +
> +	  The interfaces are provided via a device named /dev/mshv.
> +
> +	  To compile this as a module, choose M here.
> +
> +	  If unsure, say N.
> +
> +config MSHV_ROOT
> +	tristate "Microsoft Hyper-V root partition APIs driver"
> +	depends on MSHV
> +	help
> +	  Select this option to provide /dev/mshv interfaces specific to
> +	  running as the root partition on Microsoft Hypervisor.
> +
> +	  To compile this as a module, choose M here.
> +
> +	  If unsure, say N.
> +
> +config MSHV_VTL
> +	tristate "Microsoft Hyper-V VTL driver"
> +	depends on MSHV
> +	select HYPERV_VTL_MODE
> +	select TRANSPARENT_HUGEPAGE

TRANSPARENT_HUGEPAGE can be avoided for now.

> +	help
> +	  Select this option to enable Hyper-V VTL driver.
> +	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
> +	  enlightenments offered to host and guest partitions which enables
> +	  the creation and management of new security boundaries within
> +	  operating system software.
> +
> +	  VSM achieves and maintains isolation through Virtual Trust Levels
> +	  (VTLs). Virtual Trust Levels are hierarchical, with higher levels
> +	  being more privileged than lower levels. VTL0 is the least privileged
> +	  level, and currently only other level supported is VTL2.
> +
> +	  To compile this as a module, choose M here.
> +
> +	  If unsure, say N.
> +
> +config MSHV_XFER_TO_GUEST_WORK
> +	bool
> +
>  endmenu
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index d76df5c8c2a9..da7aa7542b05 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -2,10 +2,30 @@
>  obj-$(CONFIG_HYPERV)		+=3D hv_vmbus.o
>  obj-$(CONFIG_HYPERV_UTILS)	+=3D hv_utils.o
>  obj-$(CONFIG_HYPERV_BALLOON)	+=3D hv_balloon.o
> +obj-$(CONFIG_MSHV)			+=3D mshv.o
> +obj-$(CONFIG_MSHV_VTL)		+=3D mshv_vtl.o
> +obj-$(CONFIG_MSHV_ROOT)		+=3D mshv_root.o
>=20
>  CFLAGS_hv_trace.o =3D -I$(src)
>  CFLAGS_hv_balloon.o =3D -I$(src)
>=20
> +CFLAGS_mshv_main.o			=3D -DHV_HYPERV_DEFS
> +CFLAGS_hv_call.o			=3D -DHV_HYPERV_DEFS
> +CFLAGS_mshv_root_main.o		=3D -DHV_HYPERV_DEFS
> +CFLAGS_mshv_root_hv_call.o	=3D -DHV_HYPERV_DEFS
> +CFLAGS_mshv_synic.o			=3D -DHV_HYPERV_DEFS
> +CFLAGS_mshv_portid_table.o	=3D -DHV_HYPERV_DEFS
> +CFLAGS_mshv_eventfd.o		=3D -DHV_HYPERV_DEFS
> +CFLAGS_mshv_msi.o			=3D -DHV_HYPERV_DEFS
> +CFLAGS_mshv_vtl_main.o		=3D -DHV_HYPERV_DEFS
> +
> +mshv-y				+=3D mshv_main.o
> +mshv_root-y			:=3D mshv_root_main.o mshv_synic.o
> mshv_portid_table.o \
> +						mshv_eventfd.o mshv_msi.o
> mshv_root_hv_call.o hv_call.o
> +mshv_vtl-y			:=3D mshv_vtl_main.o hv_call.o
> +
> +obj-$(CONFIG_MSHV_XFER_TO_GUEST_WORK) +=3D xfer_to_guest.o
> +
>  hv_vmbus-y :=3D vmbus_drv.o \
>  		 hv.o connection.o channel.o \
>  		 channel_mgmt.o ring_buffer.o hv_trace.o
> diff --git a/drivers/hv/hv_call.c b/drivers/hv/hv_call.c
> new file mode 100644
> index 000000000000..4455001d8545
> --- /dev/null
> +++ b/drivers/hv/hv_call.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Microsoft Corporation.
> + *
> + * Hypercall helper functions shared between mshv modules.
> + *
> + * Authors:
> + *   Nuno Das Neves <nunodasneves@linux.microsoft.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <asm/mshyperv.h>
> +
> +#define HV_GET_REGISTER_BATCH_SIZE	\
> +	(HV_HYP_PAGE_SIZE / sizeof(union hv_register_value))
> +#define HV_SET_REGISTER_BATCH_SIZE	\
> +	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_set_vp_registers)) \
> +		/ sizeof(struct hv_register_assoc))
> +
> +int hv_call_get_vp_registers(
> +		u32 vp_index,
> +		u64 partition_id,
> +		u16 count,
> +		union hv_input_vtl input_vtl,
> +		struct hv_register_assoc *registers)
> +{
> +	struct hv_input_get_vp_registers *input_page;
> +	union hv_register_value *output_page;
> +	u16 completed =3D 0;
> +	unsigned long remaining =3D count;
> +	int rep_count, i;
> +	u64 status;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +
> +	input_page =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output_page =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	input_page->partition_id =3D partition_id;
> +	input_page->vp_index =3D vp_index;
> +	input_page->input_vtl.as_uint8 =3D input_vtl.as_uint8;
> +	input_page->rsvd_z8 =3D 0;
> +	input_page->rsvd_z16 =3D 0;
> +
> +	while (remaining) {
> +		rep_count =3D min(remaining, HV_GET_REGISTER_BATCH_SIZE);
> +		for (i =3D 0; i < rep_count; ++i)
> +			input_page->names[i] =3D registers[i].name;
> +
> +		status =3D hv_do_rep_hypercall(HVCALL_GET_VP_REGISTERS,
> rep_count,
> +					     0, input_page, output_page);

Is there any possibility that count value is passed 0 by mistake ? In that =
case
status will remain uninitialized.=20

> +		if (!hv_result_success(status)) {
> +			pr_err("%s: completed %li out of %u, %s\n",
> +			       __func__,
> +			       count - remaining, count,
> +			       hv_status_to_string(status));
> +			break;
> +		}
> +		completed =3D hv_repcomp(status);
> +		for (i =3D 0; i < completed; ++i)
> +			registers[i].value =3D output_page[i];
> +
> +		registers +=3D completed;
> +		remaining -=3D completed;
> +	}
> +	local_irq_restore(flags);
> +
> +	return hv_status_to_errno(status);
> +}
> +
> +int hv_call_set_vp_registers(
> +		u32 vp_index,
> +		u64 partition_id,
> +		u16 count,
> +		union hv_input_vtl input_vtl,
> +		struct hv_register_assoc *registers)
> +{
> +	struct hv_input_set_vp_registers *input_page;
> +	u16 completed =3D 0;
> +	unsigned long remaining =3D count;
> +	int rep_count;
> +	u64 status;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	input_page =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +	input_page->partition_id =3D partition_id;
> +	input_page->vp_index =3D vp_index;
> +	input_page->input_vtl.as_uint8 =3D input_vtl.as_uint8;
> +	input_page->rsvd_z8 =3D 0;
> +	input_page->rsvd_z16 =3D 0;
> +
> +	while (remaining) {
> +		rep_count =3D min(remaining, HV_SET_REGISTER_BATCH_SIZE);
> +		memcpy(input_page->elements, registers,
> +			sizeof(struct hv_register_assoc) * rep_count);
> +
> +		status =3D hv_do_rep_hypercall(HVCALL_SET_VP_REGISTERS,
> rep_count,
> +					     0, input_page, NULL);
> +		if (!hv_result_success(status)) {
> +			pr_err("%s: completed %li out of %u, %s\n",
> +			       __func__,
> +			       count - remaining, count,
> +			       hv_status_to_string(status));
> +			break;
> +		}
> +		completed =3D hv_repcomp(status);
> +		registers +=3D completed;
> +		remaining -=3D completed;
> +	}
> +
> +	local_irq_restore(flags);
> +
> +	return hv_status_to_errno(status);
> +}
> +
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 13f972e72375..ccd76f30a638 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -62,7 +62,11 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
>   */
>  static inline bool hv_output_arg_exists(void)
>  {
> +#ifdef CONFIG_MSHV_VTL

Although today both the option works together. But thinking
which is more accurate CONFIG_HYPERV_VTL_MODE or
CONFIG_MSHV_VTL here for scalability of VTL modules.

> +	return true;
> +#else
>  	return hv_root_partition ? true : false;
> +#endif
>  }
>=20
>  static void hv_kmsg_dump_unregister(void);
> diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
> new file mode 100644
> index 000000000000..166480a73f3f
> --- /dev/null
> +++ b/drivers/hv/mshv.h
> @@ -0,0 +1,156 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2023, Microsoft Corporation.
> + */
> +
> +#ifndef _MSHV_H_
> +#define _MSHV_H_
> +
> +#include <linux/spinlock.h>
> +#include <linux/mutex.h>
> +#include <linux/semaphore.h>
> +#include <linux/sched.h>
> +#include <linux/srcu.h>
> +#include <linux/wait.h>
> +#include <uapi/linux/mshv.h>
> +
> +/*
> + * Hyper-V hypercalls
> + */
> +
> +int hv_call_withdraw_memory(u64 count, int node, u64 partition_id);
> +int hv_call_create_partition(
> +		u64 flags,
> +		struct hv_partition_creation_properties creation_properties,
> +		union hv_partition_isolation_properties isolation_properties,
> +		u64 *partition_id);
> +int hv_call_initialize_partition(u64 partition_id);
> +int hv_call_finalize_partition(u64 partition_id);
> +int hv_call_delete_partition(u64 partition_id);
> +int hv_call_map_gpa_pages(
> +		u64 partition_id,
> +		u64 gpa_target,
> +		u64 page_count, u32 flags,
> +		struct page **pages);
> +int hv_call_unmap_gpa_pages(
> +		u64 partition_id,
> +		u64 gpa_target,
> +		u64 page_count, u32 flags);
> +int hv_call_get_vp_registers(
> +		u32 vp_index,
> +		u64 partition_id,
> +		u16 count,
> +		union hv_input_vtl input_vtl,
> +		struct hv_register_assoc *registers);
> +int hv_call_get_gpa_access_states(
> +		u64 partition_id,
> +		u32 count,
> +		u64 gpa_base_pfn,
> +		u64 state_flags,
> +		int *written_total,
> +		union hv_gpa_page_access_state *states);
> +
> +int hv_call_set_vp_registers(
> +		u32 vp_index,
> +		u64 partition_id,
> +		u16 count,
> +		union hv_input_vtl input_vtl,
> +		struct hv_register_assoc *registers);

Nit: Opportunity to fix many of the checkpatch.pl related to line break her=
e
and many other places.

> +int hv_call_install_intercept(u64 partition_id, u32 access_type,
> +		enum hv_intercept_type intercept_type,
> +		union hv_intercept_parameters intercept_parameter);
> +int hv_call_assert_virtual_interrupt(
> +		u64 partition_id,
> +		u32 vector,
> +		u64 dest_addr,
> +		union hv_interrupt_control control);
> +int hv_call_clear_virtual_interrupt(u64 partition_id);
> +
> +#ifdef HV_SUPPORTS_VP_STATE
> +int hv_call_get_vp_state(
> +		u32 vp_index,
> +		u64 partition_id,
> +		enum hv_get_set_vp_state_type type,
> +		struct hv_vp_state_data_xsave xsave,
> +		/* Choose between pages and ret_output */
> +		u64 page_count,
> +		struct page **pages,
> +		union hv_output_get_vp_state *ret_output);
> +int hv_call_set_vp_state(
> +		u32 vp_index,
> +		u64 partition_id,
> +		enum hv_get_set_vp_state_type type,
> +		struct hv_vp_state_data_xsave xsave,
> +		/* Choose between pages and bytes */
> +		u64 page_count,
> +		struct page **pages,
> +		u32 num_bytes,
> +		u8 *bytes);
> +#endif
> +
> +int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> +				struct page **state_page);
> +int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32
> type);
> +int hv_call_get_partition_property(
> +		u64 partition_id,
> +		u64 property_code,
> +		u64 *property_value);
> +int hv_call_set_partition_property(
> +	u64 partition_id, u64 property_code, u64 property_value,
> +	void (*completion_handler)(void * /* data */, u64 * /* status */),
> +	void *completion_data);
> +int hv_call_translate_virtual_address(
> +		u32 vp_index,
> +		u64 partition_id,
> +		u64 flags,
> +		u64 gva,
> +		u64 *gpa,
> +		union hv_translate_gva_result *result);
> +int hv_call_get_vp_cpuid_values(
> +		u32 vp_index,
> +		u64 partition_id,
> +		union hv_get_vp_cpuid_values_flags values_flags,
> +		struct hv_cpuid_leaf_info *info,
> +		union hv_output_get_vp_cpuid_values *result);
> +
> +int hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
> +			u64 connection_partition_id, struct hv_port_info
> *port_info,
> +			u8 port_vtl, u8 min_connection_vtl, int node);
> +int hv_call_delete_port(u64 port_partition_id, union hv_port_id port_id)=
;
> +int hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id=
,
> +			 u64 connection_partition_id,
> +			 union hv_connection_id connection_id,
> +			 struct hv_connection_info *connection_info,
> +			 u8 connection_vtl, int node);
> +int hv_call_disconnect_port(u64 connection_partition_id,
> +			    union hv_connection_id connection_id);
> +int hv_call_notify_port_ring_empty(u32 sint_index);
> +#ifdef HV_SUPPORTS_REGISTER_INTERCEPT
> +int hv_call_register_intercept_result(u32 vp_index,
> +				  u64 partition_id,
> +				  enum hv_intercept_type intercept_type,
> +				  union
> hv_register_intercept_result_parameters *params);
> +#endif
> +int hv_call_signal_event_direct(u32 vp_index,
> +				u64 partition_id,
> +				u8 vtl,
> +				u8 sint,
> +				u16 flag_number,
> +				u8 *newly_signaled);
> +int hv_call_post_message_direct(u32 vp_index,
> +				u64 partition_id,
> +				u8 vtl,
> +				u32 sint_index,
> +				u8 *message);
> +
> +struct mshv_partition *mshv_partition_find(u64 partition_id)
> __must_hold(RCU);
> +
> +int mshv_xfer_to_guest_mode_handle_work(unsigned long ti_work);
> +
> +typedef long (*mshv_create_func_t)(void __user *user_arg);
> +typedef long (*mshv_check_ext_func_t)(u32 arg);
> +int mshv_setup_vtl_func(const mshv_create_func_t create_vtl,
> +			const mshv_check_ext_func_t check_ext);
> +int mshv_set_create_partition_func(const mshv_create_func_t func);
> +
> +#endif /* _MSHV_H */
> diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
> new file mode 100644
> index 000000000000..ddc64fe3920e
> --- /dev/null
> +++ b/drivers/hv/mshv_eventfd.c
> @@ -0,0 +1,758 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * eventfd support for mshv
> + *
> + * Heavily inspired from KVM implementation of irqfd/ioeventfd. The basi=
c
> + * framework code is taken from the kvm implementation.
> + *
> + * All credits to kvm developers.
> + */
> +
> +#include <linux/syscalls.h>
> +#include <linux/wait.h>
> +#include <linux/poll.h>
> +#include <linux/file.h>
> +#include <linux/list.h>
> +#include <linux/workqueue.h>
> +#include <linux/eventfd.h>
> +
> +#include "mshv_eventfd.h"
> +#include "mshv.h"
> +#include "mshv_root.h"
> +
> +static struct workqueue_struct *irqfd_cleanup_wq;
> +
> +void
> +mshv_register_irq_ack_notifier(struct mshv_partition *partition,
> +			       struct mshv_irq_ack_notifier *mian)
> +{
> +	mutex_lock(&partition->irq_lock);
> +	hlist_add_head_rcu(&mian->link, &partition->irq_ack_notifier_list);
> +	mutex_unlock(&partition->irq_lock);
> +}
> +
> +void
> +mshv_unregister_irq_ack_notifier(struct mshv_partition *partition,
> +				 struct mshv_irq_ack_notifier *mian)
> +{
> +	mutex_lock(&partition->irq_lock);
> +	hlist_del_init_rcu(&mian->link);
> +	mutex_unlock(&partition->irq_lock);
> +	synchronize_rcu();
> +}
> +
> +bool
> +mshv_notify_acked_gsi(struct mshv_partition *partition, int gsi)
> +{
> +	struct mshv_irq_ack_notifier *mian;
> +	bool acked =3D false;
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(mian, &partition->irq_ack_notifier_list,
> +			link) {
> +		if (mian->gsi =3D=3D gsi) {
> +			mian->irq_acked(mian);
> +			acked =3D true;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	return acked;
> +}
> +
> +static inline bool hv_should_clear_interrupt(enum hv_interrupt_type type=
)
> +{
> +	return type =3D=3D HV_X64_INTERRUPT_TYPE_EXTINT;
> +}
> +
> +static void
> +irqfd_resampler_ack(struct mshv_irq_ack_notifier *mian)
> +{
> +	struct mshv_kernel_irqfd_resampler *resampler;
> +	struct mshv_partition *partition;
> +	struct mshv_kernel_irqfd *irqfd;
> +	int idx;
> +
> +	resampler =3D container_of(mian,
> +			struct mshv_kernel_irqfd_resampler, notifier);
> +	partition =3D resampler->partition;
> +
> +	idx =3D srcu_read_lock(&partition->irq_srcu);
> +
> +	hlist_for_each_entry_rcu(irqfd, &resampler->irqfds_list,
> resampler_hnode) {
> +		if (hv_should_clear_interrupt(irqfd-
> >lapic_irq.control.interrupt_type))
> +			hv_call_clear_virtual_interrupt(partition->id);
> +
> +		eventfd_signal(irqfd->resamplefd, 1);
> +	}
> +
> +	srcu_read_unlock(&partition->irq_srcu, idx);
> +}
> +
> +static void
> +irqfd_assert(struct work_struct *work)
> +{
> +	struct mshv_kernel_irqfd *irqfd =3D
> +		container_of(work, struct mshv_kernel_irqfd, assert);
> +	struct mshv_lapic_irq *irq =3D &irqfd->lapic_irq;
> +
> +	hv_call_assert_virtual_interrupt(irqfd->partition->id,
> +					 irq->vector, irq->apic_id,
> +					 irq->control);
> +}
> +
> +static void
> +irqfd_inject(struct mshv_kernel_irqfd *irqfd)
> +{
> +	struct mshv_partition *partition =3D irqfd->partition;
> +	struct mshv_lapic_irq *irq =3D &irqfd->lapic_irq;
> +	unsigned int seq;
> +	int idx;
> +
> +	WARN_ON(irqfd->resampler &&
> +		!irq->control.level_triggered);
> +
> +	idx =3D srcu_read_lock(&partition->irq_srcu);
> +	if (irqfd->msi_entry.gsi) {
> +		if (!irqfd->msi_entry.entry_valid) {
> +			pr_warn("Invalid routing info for gsi %u",
> +				irqfd->msi_entry.gsi);
> +			srcu_read_unlock(&partition->irq_srcu, idx);
> +			return;
> +		}
> +
> +		do {
> +			seq =3D read_seqcount_begin(&irqfd->msi_entry_sc);
> +		} while (read_seqcount_retry(&irqfd->msi_entry_sc, seq));
> +	}
> +
> +	srcu_read_unlock(&partition->irq_srcu, idx);
> +
> +	schedule_work(&irqfd->assert);
> +}
> +
> +static void
> +irqfd_resampler_shutdown(struct mshv_kernel_irqfd *irqfd)
> +{
> +	struct mshv_kernel_irqfd_resampler *resampler =3D irqfd->resampler;
> +	struct mshv_partition *partition =3D resampler->partition;
> +
> +	mutex_lock(&partition->irqfds.resampler_lock);
> +
> +	hlist_del_rcu(&irqfd->resampler_hnode);
> +	synchronize_srcu(&partition->irq_srcu);
> +
> +	if (hlist_empty(&resampler->irqfds_list)) {
> +		hlist_del(&resampler->hnode);
> +		mshv_unregister_irq_ack_notifier(partition, &resampler-
> >notifier);
> +		kfree(resampler);
> +	}
> +
> +	mutex_unlock(&partition->irqfds.resampler_lock);
> +}
> +
> +/*
> + * Race-free decouple logic (ordering is critical)
> + */
> +static void
> +irqfd_shutdown(struct work_struct *work)
> +{
> +	struct mshv_kernel_irqfd *irqfd =3D
> +		container_of(work, struct mshv_kernel_irqfd, shutdown);
> +
> +	/*
> +	 * Synchronize with the wait-queue and unhook ourselves to prevent
> +	 * further events.
> +	 */
> +	remove_wait_queue(irqfd->wqh, &irqfd->wait);
> +
> +	if (irqfd->resampler) {
> +		irqfd_resampler_shutdown(irqfd);
> +		eventfd_ctx_put(irqfd->resamplefd);
> +	}
> +
> +	/*
> +	 * We know no new events will be scheduled at this point, so block
> +	 * until all previously outstanding events have completed
> +	 */
> +	flush_work(&irqfd->assert);
> +
> +	/*
> +	 * It is now safe to release the object's resources
> +	 */
> +	eventfd_ctx_put(irqfd->eventfd);
> +	kfree(irqfd);
> +}
> +
> +/* assumes partition->irqfds.lock is held */
> +static bool
> +irqfd_is_active(struct mshv_kernel_irqfd *irqfd)
> +{
> +	return !hlist_unhashed(&irqfd->hnode);
> +}
> +
> +/*
> + * Mark the irqfd as inactive and schedule it for removal
> + *
> + * assumes partition->irqfds.lock is held
> + */
> +static void
> +irqfd_deactivate(struct mshv_kernel_irqfd *irqfd)
> +{
> +	WARN_ON(!irqfd_is_active(irqfd));
> +
> +	hlist_del(&irqfd->hnode);
> +
> +	queue_work(irqfd_cleanup_wq, &irqfd->shutdown);
> +}
> +
> +/*
> + * Called with wqh->lock held and interrupts disabled
> + */
> +static int
> +irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode,
> +		int sync, void *key)
> +{
> +	struct mshv_kernel_irqfd *irqfd =3D
> +		container_of(wait, struct mshv_kernel_irqfd, wait);
> +	unsigned long flags =3D (unsigned long)key;
> +	int idx;
> +	unsigned int seq;
> +	struct mshv_partition *partition =3D irqfd->partition;
> +	int ret =3D 0;
> +
> +	if (flags & POLLIN) {
> +		u64 cnt;
> +
> +		eventfd_ctx_do_read(irqfd->eventfd, &cnt);
> +		idx =3D srcu_read_lock(&partition->irq_srcu);
> +		do {
> +			seq =3D read_seqcount_begin(&irqfd->msi_entry_sc);
> +		} while (read_seqcount_retry(&irqfd->msi_entry_sc, seq));
> +
> +		/* An event has been signaled, inject an interrupt */
> +		irqfd_inject(irqfd);
> +		srcu_read_unlock(&partition->irq_srcu, idx);
> +
> +		ret =3D 1;
> +	}
> +
> +	if (flags & POLLHUP) {
> +		/* The eventfd is closing, detach from Partition */
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&partition->irqfds.lock, flags);
> +
> +		/*
> +		 * We must check if someone deactivated the irqfd before
> +		 * we could acquire the irqfds.lock since the item is
> +		 * deactivated from the mshv side before it is unhooked from
> +		 * the wait-queue.  If it is already deactivated, we can
> +		 * simply return knowing the other side will cleanup for us.
> +		 * We cannot race against the irqfd going away since the
> +		 * other side is required to acquire wqh->lock, which we hold
> +		 */
> +		if (irqfd_is_active(irqfd))
> +			irqfd_deactivate(irqfd);
> +
> +		spin_unlock_irqrestore(&partition->irqfds.lock, flags);
> +	}
> +
> +	return ret;
> +}
> +
> +/* Must be called under irqfds.lock */
> +static void irqfd_update(struct mshv_partition *partition,
> +			 struct mshv_kernel_irqfd *irqfd)
> +{
> +	write_seqcount_begin(&irqfd->msi_entry_sc);
> +	irqfd->msi_entry =3D mshv_msi_map_gsi(partition, irqfd->gsi);
> +	mshv_set_msi_irq(&irqfd->msi_entry, &irqfd->lapic_irq);
> +	write_seqcount_end(&irqfd->msi_entry_sc);
> +}
> +
> +void mshv_irqfd_routing_update(struct mshv_partition *partition)
> +{
> +	struct mshv_kernel_irqfd *irqfd;
> +
> +	spin_lock_irq(&partition->irqfds.lock);
> +	hlist_for_each_entry(irqfd, &partition->irqfds.items, hnode)
> +		irqfd_update(partition, irqfd);
> +	spin_unlock_irq(&partition->irqfds.lock);
> +}
> +
> +static void
> +irqfd_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh,
> +			poll_table *pt)
> +{
> +	struct mshv_kernel_irqfd *irqfd =3D
> +		container_of(pt, struct mshv_kernel_irqfd, pt);
> +
> +	irqfd->wqh =3D wqh;
> +	add_wait_queue_priority(wqh, &irqfd->wait);
> +}
> +
> +static int
> +mshv_irqfd_assign(struct mshv_partition *partition,
> +		  struct mshv_irqfd *args)
> +{
> +	struct eventfd_ctx *eventfd =3D NULL, *resamplefd =3D NULL;
> +	struct mshv_kernel_irqfd *irqfd, *tmp;
> +	unsigned int events;
> +	struct fd f;
> +	int ret;
> +	int idx;
> +
> +	irqfd =3D kzalloc(sizeof(*irqfd), GFP_KERNEL);
> +	if (!irqfd)
> +		return -ENOMEM;
> +
> +	irqfd->partition =3D partition;
> +	irqfd->gsi =3D args->gsi;
> +	INIT_WORK(&irqfd->shutdown, irqfd_shutdown);
> +	INIT_WORK(&irqfd->assert, irqfd_assert);
> +	seqcount_spinlock_init(&irqfd->msi_entry_sc,
> +			       &partition->irqfds.lock);
> +
> +	f =3D fdget(args->fd);
> +	if (!f.file) {
> +		ret =3D -EBADF;
> +		goto out;
> +	}
> +
> +	eventfd =3D eventfd_ctx_fileget(f.file);
> +	if (IS_ERR(eventfd)) {
> +		ret =3D PTR_ERR(eventfd);
> +		goto fail;
> +	}
> +
> +	irqfd->eventfd =3D eventfd;
> +
> +	if (args->flags & MSHV_IRQFD_FLAG_RESAMPLE) {
> +		struct mshv_kernel_irqfd_resampler *resampler;
> +
> +		resamplefd =3D eventfd_ctx_fdget(args->resamplefd);
> +		if (IS_ERR(resamplefd)) {
> +			ret =3D PTR_ERR(resamplefd);
> +			goto fail;
> +		}
> +
> +		irqfd->resamplefd =3D resamplefd;
> +
> +		mutex_lock(&partition->irqfds.resampler_lock);
> +
> +		hlist_for_each_entry(resampler,
> +				    &partition->irqfds.resampler_list, hnode) {
> +			if (resampler->notifier.gsi =3D=3D irqfd->gsi) {
> +				irqfd->resampler =3D resampler;
> +				break;
> +			}
> +		}
> +
> +		if (!irqfd->resampler) {
> +			resampler =3D kzalloc(sizeof(*resampler),
> +					    GFP_KERNEL_ACCOUNT);
> +			if (!resampler) {
> +				ret =3D -ENOMEM;
> +				mutex_unlock(&partition-
> >irqfds.resampler_lock);
> +				goto fail;
> +			}
> +
> +			resampler->partition =3D partition;
> +			INIT_HLIST_HEAD(&resampler->irqfds_list);
> +			resampler->notifier.gsi =3D irqfd->gsi;
> +			resampler->notifier.irq_acked =3D irqfd_resampler_ack;
> +
> +			hlist_add_head(&resampler->hnode, &partition-
> >irqfds.resampler_list);
> +			mshv_register_irq_ack_notifier(partition,
> +						      &resampler->notifier);
> +			irqfd->resampler =3D resampler;
> +		}
> +
> +		hlist_add_head_rcu(&irqfd->resampler_hnode, &irqfd-
> >resampler->irqfds_list);
> +
> +		mutex_unlock(&partition->irqfds.resampler_lock);
> +	}
> +
> +	/*
> +	 * Install our own custom wake-up handling so we are notified via
> +	 * a callback whenever someone signals the underlying eventfd
> +	 */
> +	init_waitqueue_func_entry(&irqfd->wait, irqfd_wakeup);
> +	init_poll_funcptr(&irqfd->pt, irqfd_ptable_queue_proc);
> +
> +	spin_lock_irq(&partition->irqfds.lock);
> +	if (args->flags & MSHV_IRQFD_FLAG_RESAMPLE &&
> +	    !irqfd->lapic_irq.control.level_triggered) {
> +		/*
> +		 * Resample Fd must be for level triggered interrupt
> +		 * Otherwise return with failure
> +		 */
> +		spin_unlock_irq(&partition->irqfds.lock);
> +		ret =3D -EINVAL;
> +		goto fail;
> +	}
> +	ret =3D 0;
> +	hlist_for_each_entry(tmp, &partition->irqfds.items, hnode) {
> +		if (irqfd->eventfd !=3D tmp->eventfd)
> +			continue;
> +		/* This fd is used for another irq already. */
> +		ret =3D -EBUSY;
> +		spin_unlock_irq(&partition->irqfds.lock);
> +		goto fail;
> +	}
> +
> +	idx =3D srcu_read_lock(&partition->irq_srcu);
> +	irqfd_update(partition, irqfd);
> +	hlist_add_head(&irqfd->hnode, &partition->irqfds.items);
> +	spin_unlock_irq(&partition->irqfds.lock);
> +
> +	/*
> +	 * Check if there was an event already pending on the eventfd
> +	 * before we registered, and trigger it as if we didn't miss it.
> +	 */
> +	events =3D vfs_poll(f.file, &irqfd->pt);
> +
> +	if (events & POLLIN)
> +		irqfd_inject(irqfd);
> +
> +	srcu_read_unlock(&partition->irq_srcu, idx);
> +	/*
> +	 * do not drop the file until the irqfd is fully initialized, otherwise
> +	 * we might race against the POLLHUP
> +	 */
> +	fdput(f);
> +
> +	return 0;
> +
> +fail:
> +	if (irqfd->resampler)
> +		irqfd_resampler_shutdown(irqfd);
> +
> +	if (resamplefd && !IS_ERR(resamplefd))
> +		eventfd_ctx_put(resamplefd);
> +
> +	if (eventfd && !IS_ERR(eventfd))
> +		eventfd_ctx_put(eventfd);
> +
> +	fdput(f);
> +
> +out:
> +	kfree(irqfd);
> +	return ret;
> +}
> +
> +/*
> + * shutdown any irqfd's that match fd+gsi
> + */
> +static int
> +mshv_irqfd_deassign(struct mshv_partition *partition,
> +		    struct mshv_irqfd *args)
> +{
> +	struct mshv_kernel_irqfd *irqfd;
> +	struct hlist_node *n;
> +	struct eventfd_ctx *eventfd;
> +
> +	eventfd =3D eventfd_ctx_fdget(args->fd);
> +	if (IS_ERR(eventfd))
> +		return PTR_ERR(eventfd);
> +
> +	hlist_for_each_entry_safe(irqfd, n, &partition->irqfds.items, hnode) {
> +		if (irqfd->eventfd =3D=3D eventfd && irqfd->gsi =3D=3D args->gsi)
> +			irqfd_deactivate(irqfd);
> +	}
> +
> +	eventfd_ctx_put(eventfd);
> +
> +	/*
> +	 * Block until we know all outstanding shutdown jobs have completed
> +	 * so that we guarantee there will not be any more interrupts on this
> +	 * gsi once this deassign function returns.
> +	 */
> +	flush_workqueue(irqfd_cleanup_wq);
> +
> +	return 0;
> +}
> +
> +int
> +mshv_irqfd(struct mshv_partition *partition, struct mshv_irqfd *args)
> +{
> +	if (args->flags & MSHV_IRQFD_FLAG_DEASSIGN)
> +		return mshv_irqfd_deassign(partition, args);
> +
> +	return mshv_irqfd_assign(partition, args);
> +}
> +
> +/*
> + * This function is called as the mshv VM fd is being released.
> + * Shutdown all irqfds that still remain open
> + */
> +static void
> +mshv_irqfd_release(struct mshv_partition *partition)
> +{
> +	struct mshv_kernel_irqfd *irqfd;
> +	struct hlist_node *n;
> +
> +	spin_lock_irq(&partition->irqfds.lock);
> +
> +	hlist_for_each_entry_safe(irqfd, n, &partition->irqfds.items, hnode)
> +		irqfd_deactivate(irqfd);
> +
> +	spin_unlock_irq(&partition->irqfds.lock);
> +
> +	/*
> +	 * Block until we know all outstanding shutdown jobs have completed
> +	 * since we do not take a mshv_partition* reference.
> +	 */
> +	flush_workqueue(irqfd_cleanup_wq);
> +
> +}
> +
> +int mshv_irqfd_wq_init(void)
> +{
> +	irqfd_cleanup_wq =3D alloc_workqueue("mshv-irqfd-cleanup", 0, 0);
> +	if (!irqfd_cleanup_wq)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +void mshv_irqfd_wq_cleanup(void)
> +{
> +	destroy_workqueue(irqfd_cleanup_wq);
> +}
> +
> +/*
> + * --------------------------------------------------------------------
> + * ioeventfd: translate a MMIO memory write to an eventfd signal.
> + *
> + * userspace can register a MMIO address with an eventfd for receiving
> + * notification when the memory has been touched.
> + *
> + * TODO: Implement eventfd for PIO as well.
> + * --------------------------------------------------------------------
> + */
> +
> +static void
> +ioeventfd_release(struct kernel_mshv_ioeventfd *p, u64 partition_id)
> +{
> +	if (p->doorbell_id > 0)
> +		mshv_unregister_doorbell(partition_id, p->doorbell_id);
> +	eventfd_ctx_put(p->eventfd);
> +	kfree(p);
> +}
> +
> +/* MMIO writes trigger an event if the addr/val match */
> +static void
> +ioeventfd_mmio_write(int doorbell_id, void *data)
> +{
> +	struct mshv_partition *partition =3D (struct mshv_partition *)data;
> +	struct kernel_mshv_ioeventfd *p;
> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(p, &partition->ioeventfds.items, hnode) {
> +		if (p->doorbell_id =3D=3D doorbell_id) {
> +			eventfd_signal(p->eventfd, 1);
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +}
> +
> +static bool
> +ioeventfd_check_collision(struct mshv_partition *partition,
> +			  struct kernel_mshv_ioeventfd *p)
> +	__must_hold(&partition->mutex)
> +{
> +	struct kernel_mshv_ioeventfd *_p;
> +
> +	hlist_for_each_entry(_p, &partition->ioeventfds.items, hnode)
> +		if (_p->addr =3D=3D p->addr && _p->length =3D=3D p->length &&
> +		    (_p->wildcard || p->wildcard ||
> +		     _p->datamatch =3D=3D p->datamatch))
> +			return true;
> +
> +	return false;
> +}
> +
> +static int
> +mshv_assign_ioeventfd(struct mshv_partition *partition,
> +		      struct mshv_ioeventfd *args)
> +	__must_hold(&partition->mutex)
> +{
> +	struct kernel_mshv_ioeventfd *p;
> +	struct eventfd_ctx *eventfd;
> +	u64 doorbell_flags =3D 0;
> +	int ret;
> +
> +	/* This mutex is currently protecting ioeventfd.items list */
> +	WARN_ON_ONCE(!mutex_is_locked(&partition->mutex));
> +
> +	if (args->flags & MSHV_IOEVENTFD_FLAG_PIO)
> +		return -EOPNOTSUPP;
> +
> +	/* must be natural-word sized */
> +	switch (args->len) {
> +	case 0:
> +		doorbell_flags =3D HV_DOORBELL_FLAG_TRIGGER_SIZE_ANY;
> +		break;
> +	case 1:
> +		doorbell_flags =3D HV_DOORBELL_FLAG_TRIGGER_SIZE_BYTE;
> +		break;
> +	case 2:
> +		doorbell_flags =3D HV_DOORBELL_FLAG_TRIGGER_SIZE_WORD;
> +		break;
> +	case 4:
> +		doorbell_flags =3D
> HV_DOORBELL_FLAG_TRIGGER_SIZE_DWORD;
> +		break;
> +	case 8:
> +		doorbell_flags =3D
> HV_DOORBELL_FLAG_TRIGGER_SIZE_QWORD;
> +		break;
> +	default:
> +		pr_warn("ioeventfd: invalid length specified\n");
> +		return -EINVAL;
> +	}
> +
> +	/* check for range overflow */
> +	if (args->addr + args->len < args->addr)
> +		return -EINVAL;
> +
> +	/* check for extra flags that we don't understand */
> +	if (args->flags & ~MSHV_IOEVENTFD_VALID_FLAG_MASK)
> +		return -EINVAL;
> +
> +	eventfd =3D eventfd_ctx_fdget(args->fd);
> +	if (IS_ERR(eventfd))
> +		return PTR_ERR(eventfd);
> +
> +	p =3D kzalloc(sizeof(*p), GFP_KERNEL);
> +	if (!p) {
> +		ret =3D -ENOMEM;
> +		goto fail;
> +	}
> +
> +	p->addr    =3D args->addr;
> +	p->length  =3D args->len;
> +	p->eventfd =3D eventfd;
> +
> +	/* The datamatch feature is optional, otherwise this is a wildcard */
> +	if (args->flags & MSHV_IOEVENTFD_FLAG_DATAMATCH)
> +		p->datamatch =3D args->datamatch;
> +	else {
> +		p->wildcard =3D true;
> +		doorbell_flags |=3D
> HV_DOORBELL_FLAG_TRIGGER_ANY_VALUE;
> +	}
> +
> +	if (ioeventfd_check_collision(partition, p)) {
> +		ret =3D -EEXIST;
> +		goto unlock_fail;
> +	}
> +
> +	ret =3D mshv_register_doorbell(partition->id, ioeventfd_mmio_write,
> +				     (void *)partition, p->addr,
> +				     p->datamatch, doorbell_flags);
> +	if (ret < 0) {
> +		pr_err("Failed to register ioeventfd doorbell!\n");

Nit: Do we like to print function name at the start of pr_err.=20

- Saurabh
