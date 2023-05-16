Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161E870447B
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 07:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjEPFQ5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 01:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjEPFQ4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 01:16:56 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2138.outbound.protection.outlook.com [40.107.215.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0042119;
        Mon, 15 May 2023 22:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuvbUx5ppXla+isRfdmULjtrNp1HpLgexJyS4RIR26ccx/EI3qn8GHXtPbTNWWdBxQDCcBR89Yl4zcAXJ3Y10Zi4OBPSKfNsO7lu9Z8jtfceD16wvNPqPXoa2Y3qIXqQyRl7qzvx0NSQi5MqWqgg8tJGphYyHqNjgsQ6c9m1Xnr01Lt62uvTrHZX1kvzLOvcLKbG+nJNLZC9h33a1chMk1sgCxqdPiel3Naooyl4U9Ygp54O7KgqHYvUL3DvxoXMstFoVLxvs51b/N/XlIig2ugGzSu/f7rdqtpZlbTWXas4WWgDnU4KQ83i8X2k617MN/p6x9yXVYdC6WiDMN42sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qr35GpgDr1o66uGRlsyoGdxt++P/Fccv3pnmbliTHz8=;
 b=Tzfdy7clcKhw+6gIGtmufl24g2vVTPGfwzhrHMFR1B69lNcEGGkcAz9vwOjrHfaNtvANpBDfBYsiJqqkBTOi57+nz/kXxCLe1sQx2b+CY0wsL5S/9UvgthSx04e3ojvhg/u7po9gnsEScw7rJamgcKQIAZGSgAjLgIxoQ+DithkI4KyatvBP5lQycIsSuDNW3HcpB281+3dvNg6k+E4yDbySwIjBt0iHwhVor3s3/iZ6+QYZgkyB5ctGPyCsXG092UjKAC+T8wsVITvneC3uGzjHm/W2MVfmCcvL26DFlZ0t1idLethYrNxMkFL1qaAe2L/gWrBeTjnubeqjSsBYmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qr35GpgDr1o66uGRlsyoGdxt++P/Fccv3pnmbliTHz8=;
 b=aMEaGhYvINN0oA/KEPV0zFsXnK8UEfg+Kwdlyz2DaPMVpNnVnoL12pTlWJBlHEBfDkYao8SEctazV17fYMwOpYyH4W53crpbF5Xhg9vK0pPth/UmY/IgYeTLK6e5bCojFIqBz24hHDdwkKiJndJtsr95J4/w58Gu21WWhe5x0ZQ=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 PUZP153MB0728.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.4; Tue, 16 May 2023 05:16:47 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11%2]) with mapi id 15.20.6433.001; Tue, 16 May 2023
 05:16:47 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jgross@suse.com" <jgross@suse.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "jiangshan.ljs@antgroup.com" <jiangshan.ljs@antgroup.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "srutherford@google.com" <srutherford@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "venu.busireddy@oracle.com" <venu.busireddy@oracle.com>,
        "sterritt@google.com" <sterritt@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>
CC:     "pangupta@amd.com" <pangupta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [EXTERNAL] [RFC PATCH V6 13/14] x86/hyperv: Add smp support for
 sev-snp guest
Thread-Topic: [EXTERNAL] [RFC PATCH V6 13/14] x86/hyperv: Add smp support for
 sev-snp guest
Thread-Index: AQHZh07yGnCc2IeLu0KwFAqll07cNq9cWnvw
Date:   Tue, 16 May 2023 05:16:47 +0000
Message-ID: <PUZP153MB074906CBC3E7B13AEFD17472BE799@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <20230515165917.1306922-1-ltykernel@gmail.com>
 <20230515165917.1306922-14-ltykernel@gmail.com>
In-Reply-To: <20230515165917.1306922-14-ltykernel@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=45694349-e327-4f6a-8743-a806ad73b8eb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-16T05:09:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|PUZP153MB0728:EE_
x-ms-office365-filtering-correlation-id: 6f5e1c2c-f2e2-4f8f-00cb-08db55ccbf53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e+KwXnvjcZFld/x8IHgE/L5ZIHVODu6d+KZxZgAwjdigr1GsRcackEsRg9EqlNx7ktRhdQse8dguDw6kABHbZAziAkh3lPpA7DPKFl/ww9YRfOSbRBVaZgov8vsZ5C98qcjzWemch70qL4LyteT0Tp9dAqM2wJxmD4w4xHysCj55DjUOPfXaP0phzv8rOKIvP2ubak39EFMfMiVQES04ZxJrZH/SSYH6f4DGyraQW3iEY9LCI1iiF58KBr6KMu/W0AT97qaaatl9slpThYTEsiGMekDur56k0D/bFrVEfbVHA++brHtnqsIZWH6WnrOr9wEYsYZqH+vHiv/DLU0aSkwtOfk7bwN+ocCM03P7yIZoOnr+GzKgkzIq8PWd6qiMmzhjZzpH606t501SD/3nzwKXmzuKogUNlRNUZ0bUxKLOlfGsfWKNKkek2RRopww8piRWnCZ97EueYrAbEUJtmZAI6htoZrifK0+Je5R8unmr9zOJ2sj4lq/Gu2hvxrnwhbVI8w24EWRzRs68/73PaQ/ZfWxEVNX0hQGKfn7MY/lDeeOp+b91HA2d4Bzvkeqo6y8dKcnJG2LSwiYB4AgqxXRSRmAU9hnHXgMuQ9lON7O1bai0Pyy/6IPcA//YO8qiZzISECXT0+uA1+s8a/W5nlwqcJ32anxtQbeFSzkEPjsZWmkb6PSrfw9uQRGI8i2x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199021)(10290500003)(8676002)(478600001)(41300700001)(55016003)(66476007)(76116006)(66946007)(786003)(921005)(4326008)(122000001)(64756008)(82950400001)(82960400001)(66556008)(66446008)(316002)(110136005)(54906003)(38100700002)(8936002)(71200400001)(186003)(8990500004)(6506007)(9686003)(38070700005)(53546011)(2906002)(83380400001)(33656002)(86362001)(7416002)(7696005)(7406005)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DJ2r/9RAJS1qPJbu6Yr+yyxCAurrSyQeNg6xgD0+/7Sh8dHMuPN3pWm8Qnvu?=
 =?us-ascii?Q?XaziFbtL+Gm5oJl9XMmPcAErIMhfg7f2yN/ClvZhzCC3LEl9e0kX8l4KPaO6?=
 =?us-ascii?Q?GWi9l5SVu6w9fM5s1cHpTJu/qXQUyLyHnZzIyvoVEHgCkeYYZVxENRR/72Kh?=
 =?us-ascii?Q?yM+UbDJpmFzT2HvxGId1qe8zDCt3vkIVZQ7fYqUO9DLDahGOSpyKPCTbBllf?=
 =?us-ascii?Q?NCfF0TJPDalh8+eGABS2+JFtZgJBouZkpGTsorbR/feb9wmI+f2ntMb3wT3E?=
 =?us-ascii?Q?WnDKDe7e5lTJcruNh6W47cnayE6cLcl3idi6zD808SPdXbkO3UWOg+3Gn25R?=
 =?us-ascii?Q?rOupOl6jGsfvdXlH2maw0CyrVvQ3OJ/iA7gbAVaP8s3X9dxMEaDa9K7QSivR?=
 =?us-ascii?Q?uN1f1PTcGDwbnj60cI/SHiyT5YV2TEYVEnARfWomhR2GRj1omMQ/Xq8EFCQE?=
 =?us-ascii?Q?uoH3uU7scipsWU9aJZOoVXpmiKmR4paHyya0DNxjihJqhb5MoIZfgI0ylOeY?=
 =?us-ascii?Q?pby/0w4/G/COEzbGsgI3pAxjTt6G5MtGg0iGSrltm/ZcZMV2T/nOQjOtiDva?=
 =?us-ascii?Q?2gtldnfMzGFdYrJ0FD/uVbBLADI0TS/t7V/Jo1EFkx9paBm2s2pmj//LOtYd?=
 =?us-ascii?Q?E+CHHsrqAGHn3aYWNi1XVw2Z5E8GrjLSEOdhmuZ6zuyl0Be7DfjiM/tQN8F1?=
 =?us-ascii?Q?mOEw7O/Arw3oq1By/f5P3MF4obos1DeS4dhpDVKBcdWj4tHeA0Gb4RfGCL/l?=
 =?us-ascii?Q?kOioSc0qFr5+kRKMxWeWyfQew1wbibrsnHu2ReuSFWWApoZujyzO2uBcQr9h?=
 =?us-ascii?Q?4srf8APH7+XP6K03QaZSdb4NeRnWMGKZDmcvcKsQhJpIBKFGp6wyQT4iVOy6?=
 =?us-ascii?Q?ObomCyWRwCxqDZqLJGby4rsNFWT1JmRGup+ev8ASBCsUuY5XEK+Ps0N5wncx?=
 =?us-ascii?Q?+txaS7T5Ab0NIvUl2jMY+nSzmkuwqtJB/rLIcfkAfi+fOPuySo64Ik46PfaN?=
 =?us-ascii?Q?C/1zJgblySJP4bcMud6SihVBcb/RezZixFUtORM1v8xYgUUL7lCh6q9qDUSu?=
 =?us-ascii?Q?tQaHvyDSEM3fPXtVi8gQzIk03d4iHBcVN+vu6QjlWoO/SidyXmBBULTB/nuQ?=
 =?us-ascii?Q?ZxkkeimfXfne5eFR7jAl6hNF9uTpn4C33njE/8ArCAGvttl+FsYkdBDurwxt?=
 =?us-ascii?Q?UFkcsTL0fkGZtBCjNPkZn7pE9asxAdSW2zLELy9Xe/Kkm4/yvqbWxlUuxfeW?=
 =?us-ascii?Q?5GpNEwrfzfLO1BycP/JRd+CRrhwDOtdtWs3bi5SaVzX4kRAxeDDn0EU8g07S?=
 =?us-ascii?Q?Jtt8aXULuaX2coZBIY1/4a/US+nyxvRpr5DLr1lztsync3KfdWkMd9Ox6Zxf?=
 =?us-ascii?Q?f0jDLgATf+tjsx9DOZ7lyiT606VsmeLqxm4um+gDAwG2Fyt28j2Ti3Jw3y/g?=
 =?us-ascii?Q?HYzGgKmzV84QuPVqT/L7H+MJpYOrU+/XcvVJXEydJaHci6j9bZjAEmHukkPx?=
 =?us-ascii?Q?egZc6dEgxFDzLV3nRpAvLSvrRpou52s7eWlEqEfwP0W4N8m+vnoocf/C6Feb?=
 =?us-ascii?Q?4c38gsxnFUzZHJUukMFnP2m88TyHArGwRH9/59ax?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5e1c2c-f2e2-4f8f-00cb-08db55ccbf53
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 05:16:47.4330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zrpfr/buXANVA0tA+DM0INeagkJbKyuIdIE4bhFlchD/bbITI/ZjFqLZrnvWJS8r0mMR9QLQKHbDP7fo2zSuCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZP153MB0728
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> -----Original Message-----
> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Monday, May 15, 2023 10:29 PM
> To: luto@kernel.org; tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
> dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com;
> seanjc@google.com; pbonzini@redhat.com; jgross@suse.com; Tianyu Lan
> <Tianyu.Lan@microsoft.com>; kirill@shutemov.name;
> jiangshan.ljs@antgroup.com; peterz@infradead.org; ashish.kalra@amd.com;
> srutherford@google.com; akpm@linux-foundation.org;
> anshuman.khandual@arm.com; pawan.kumar.gupta@linux.intel.com;
> adrian.hunter@intel.com; daniel.sneddon@linux.intel.com;
> alexander.shishkin@linux.intel.com; sandipan.das@amd.com;
> ray.huang@amd.com; brijesh.singh@amd.com; michael.roth@amd.com;
> thomas.lendacky@amd.com; venu.busireddy@oracle.com;
> sterritt@google.com; tony.luck@intel.com; samitolvanen@google.com;
> fenghua.yu@intel.com
> Cc: pangupta@amd.com; linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> linux-hyperv@vger.kernel.org; linux-arch@vger.kernel.org
> Subject: [EXTERNAL] [RFC PATCH V6 13/14] x86/hyperv: Add smp support for
> sev-snp guest
>=20
> From: Tianyu Lan <tiala@microsoft.com>
>=20
> The wakeup_secondary_cpu callback was populated with wakeup_
> cpu_via_vmgexit() which doesn't work for Hyper-V and Hyper-V requires to
> call Hyper-V specific hvcall to start APs. So override it with Hyper-V sp=
ecific
> hook to start AP sev_es_save_area data structure.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC v5:
>        * Remove some redundant structure definitions
>=20
> Change sicne RFC v3:
>        * Replace struct sev_es_save_area with struct
>          vmcb_save_area
>        * Move code from mshyperv.c to ivm.c
>=20
> Change since RFC v2:
>        * Add helper function to initialize segment
>        * Fix some coding style
> ---
>  arch/x86/hyperv/ivm.c             | 98 +++++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   | 10 ++++
>  arch/x86/kernel/cpu/mshyperv.c    | 13 +++-
>  include/asm-generic/hyperv-tlfs.h |  3 +-
>  4 files changed, 121 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c index
> 85e4378f052f..b7b8e1ba8223 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -22,11 +22,15 @@
>  #include <asm/sev.h>
>  #include <asm/realmode.h>
>  #include <asm/e820/api.h>
> +#include <asm/desc.h>
>=20
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>=20
>  #define GHCB_USAGE_HYPERV_CALL	1
>=20
> +static u8 ap_start_input_arg[PAGE_SIZE] __bss_decrypted
> +__aligned(PAGE_SIZE); static u8 ap_start_stack[PAGE_SIZE]
> +__aligned(PAGE_SIZE);
> +
>  union hv_ghcb {
>  	struct ghcb ghcb;
>  	struct {
> @@ -443,6 +447,100 @@ __init void hv_sev_init_mem_and_cpu(void)
>  	}
>  }
>=20
> +#define hv_populate_vmcb_seg(seg, gdtr_base)			\
> +do {								\
> +	if (seg.selector) {					\
> +		seg.base =3D 0;					\
> +		seg.limit =3D HV_AP_SEGMENT_LIMIT;		\
> +		seg.attrib =3D *(u16 *)(gdtr_base + seg.selector + 5);	\
> +		seg.attrib =3D (seg.attrib & 0xFF) | ((seg.attrib >> 4) & 0xF00); \
> +	}							\
> +} while (0)							\
> +
> +int hv_snp_boot_ap(int cpu, unsigned long start_ip) {
> +	struct sev_es_save_area *vmsa =3D (struct sev_es_save_area *)
> +		__get_free_page(GFP_KERNEL | __GFP_ZERO);
> +	struct desc_ptr gdtr;
> +	u64 ret, rmp_adjust, retry =3D 5;
> +	struct hv_enable_vp_vtl *start_vp_input;
> +	unsigned long flags;
> +
> +	native_store_gdt(&gdtr);
> +
> +	vmsa->gdtr.base =3D gdtr.address;
> +	vmsa->gdtr.limit =3D gdtr.size;
> +
> +	asm volatile("movl %%es, %%eax;" : "=3Da" (vmsa->es.selector));
> +	hv_populate_vmcb_seg(vmsa->es, vmsa->gdtr.base);
> +
> +	asm volatile("movl %%cs, %%eax;" : "=3Da" (vmsa->cs.selector));
> +	hv_populate_vmcb_seg(vmsa->cs, vmsa->gdtr.base);
> +
> +	asm volatile("movl %%ss, %%eax;" : "=3Da" (vmsa->ss.selector));
> +	hv_populate_vmcb_seg(vmsa->ss, vmsa->gdtr.base);
> +
> +	asm volatile("movl %%ds, %%eax;" : "=3Da" (vmsa->ds.selector));
> +	hv_populate_vmcb_seg(vmsa->ds, vmsa->gdtr.base);
> +
> +	vmsa->efer =3D native_read_msr(MSR_EFER);
> +
> +	asm volatile("movq %%cr4, %%rax;" : "=3Da" (vmsa->cr4));
> +	asm volatile("movq %%cr3, %%rax;" : "=3Da" (vmsa->cr3));
> +	asm volatile("movq %%cr0, %%rax;" : "=3Da" (vmsa->cr0));
> +
> +	vmsa->xcr0 =3D 1;
> +	vmsa->g_pat =3D HV_AP_INIT_GPAT_DEFAULT;
> +	vmsa->rip =3D (u64)secondary_startup_64_no_verify;
> +	vmsa->rsp =3D (u64)&ap_start_stack[PAGE_SIZE];
> +
> +	/*
> +	 * Set the SNP-specific fields for this VMSA:
> +	 *   VMPL level
> +	 *   SEV_FEATURES (matches the SEV STATUS MSR right shifted 2 bits)
> +	 */;
> +	vmsa->vmpl =3D 0;
> +	vmsa->sev_features =3D sev_status >> 2;
> +
> +	/*
> +	 * Running at VMPL0 allows the kernel to change the VMSA bit for a
> page
> +	 * using the RMPADJUST instruction. However, for the instruction to
> +	 * succeed it must target the permissions of a lesser privileged
> +	 * (higher numbered) VMPL level, so use VMPL1 (refer to the
> RMPADJUST
> +	 * instruction in the AMD64 APM Volume 3).
> +	 */
> +	rmp_adjust =3D RMPADJUST_VMSA_PAGE_BIT | 1;
> +	ret =3D rmpadjust((unsigned long)vmsa, RMP_PG_SIZE_4K,
> +			rmp_adjust);
> +	if (ret !=3D 0) {
> +		pr_err("RMPADJUST(%llx) failed: %llx\n", (u64)vmsa, ret);
> +		return ret;
> +	}
> +
> +	local_irq_save(flags);
> +	start_vp_input =3D
> +		(struct hv_enable_vp_vtl *)ap_start_input_arg;
> +	memset(start_vp_input, 0, sizeof(*start_vp_input));
> +	start_vp_input->partition_id =3D -1;
> +	start_vp_input->vp_index =3D cpu;
> +	start_vp_input->target_vtl.target_vtl =3D ms_hyperv.vtl;
> +	*(u64 *)&start_vp_input->vp_context =3D __pa(vmsa) | 1;
> +
> +	do {
> +		ret =3D hv_do_hypercall(HVCALL_START_VP,
> +				      start_vp_input, NULL);
> +	} while (hv_result(ret) =3D=3D HV_STATUS_TIME_OUT && retry--);

can we restore local_irq here ?

> +
> +	if (!hv_result_success(ret)) {
> +		pr_err("HvCallStartVirtualProcessor failed: %llx\n", ret);
> +		goto done;

No need of goto here.

Regards,
Saurabh

> +	}
> +
> +done:
> +	local_irq_restore(flags);
> +	return ret;
> +}
> +
>  void __init hv_vtom_init(void)
>  {
>  	/*
> diff --git a/arch/x86/include/asm/mshyperv.h
> b/arch/x86/include/asm/mshyperv.h index 84e024ffacd5..9ad2a0f21d68
> 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -65,6 +65,13 @@ struct memory_map_entry {
>  	u32 reserved;
>  };
>=20
> +/*
> + * DEFAULT INIT GPAT and SEGMENT LIMIT value in struct VMSA
> + * to start AP in enlightened SEV guest.
> + */
> +#define HV_AP_INIT_GPAT_DEFAULT		0x0007040600070406ULL
> +#define HV_AP_SEGMENT_LIMIT		0xffffffff
> +
>  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);  i=
nt
> hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);  int
> hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags); @=
@ -
> 263,6 +270,7 @@ struct irq_domain *hv_create_pci_msi_domain(void);  int
> hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
>  		struct hv_interrupt_entry *entry);
>  int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry
> *entry);
> +int hv_snp_boot_ap(int cpu, unsigned long start_ip);
>=20
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  void hv_ghcb_msr_write(u64 msr, u64 value); @@ -271,6 +279,7 @@ bool
> hv_ghcb_negotiate_protocol(void);  void hv_ghcb_terminate(unsigned int se=
t,
> unsigned int reason);  void hv_vtom_init(void);  void
> hv_sev_init_mem_and_cpu(void);
> +int hv_snp_boot_ap(int cpu, unsigned long start_ip);
>  #else
>  static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}  static inli=
ne void
> hv_ghcb_msr_read(u64 msr, u64 *value) {} @@ -278,6 +287,7 @@ static
> inline bool hv_ghcb_negotiate_protocol(void) { return false; }  static in=
line
> void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}  static =
inline
> void hv_vtom_init(void) {}  static inline void hv_sev_init_mem_and_cpu(vo=
id)
> {}
> +static int hv_snp_boot_ap(int cpu, unsigned long start_ip) {}
>  #endif
>=20
>  extern bool hv_isolation_type_snp(void); diff --git
> a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c index
> dea9b881180b..0c5f9f7bd7ba 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -295,6 +295,16 @@ static void __init hv_smp_prepare_cpus(unsigned int
> max_cpus)
>=20
>  	native_smp_prepare_cpus(max_cpus);
>=20
> +	/*
> +	 *  Override wakeup_secondary_cpu_64 callback for SEV-SNP
> +	 *  enlightened guest.
> +	 */
> +	if (hv_isolation_type_en_snp())
> +		apic->wakeup_secondary_cpu_64 =3D hv_snp_boot_ap;
> +
> +	if (!hv_root_partition)
> +		return;
> +
>  #ifdef CONFIG_X86_64
>  	for_each_present_cpu(i) {
>  		if (i =3D=3D 0)
> @@ -502,8 +512,7 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  # ifdef CONFIG_SMP
>  	smp_ops.smp_prepare_boot_cpu =3D hv_smp_prepare_boot_cpu;
> -	if (hv_root_partition)
> -		smp_ops.smp_prepare_cpus =3D hv_smp_prepare_cpus;
> +	smp_ops.smp_prepare_cpus =3D hv_smp_prepare_cpus;
>  # endif
>=20
>  	/*
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-
> tlfs.h
> index f4e4cc4f965f..92dcc530350c 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -146,9 +146,9 @@ union hv_reference_tsc_msr {
>  /* Declare the various hypercall operations. */
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE	0x0002
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
> -#define HVCALL_ENABLE_VP_VTL			0x000f
>  #define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
>  #define HVCALL_SEND_IPI				0x000b
> +#define HVCALL_ENABLE_VP_VTL			0x000f
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
>  #define HVCALL_SEND_IPI_EX			0x0015
> @@ -223,6 +223,7 @@ enum HV_GENERIC_SET_FORMAT {
>  #define HV_STATUS_INVALID_PORT_ID		17
>  #define HV_STATUS_INVALID_CONNECTION_ID		18
>  #define HV_STATUS_INSUFFICIENT_BUFFERS		19
> +#define HV_STATUS_TIME_OUT                      120
>  #define HV_STATUS_VTL_ALREADY_ENABLED		134
>=20
>  /*
> --
> 2.25.1

