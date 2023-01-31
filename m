Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD2368356F
	for <lists+linux-arch@lfdr.de>; Tue, 31 Jan 2023 19:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjAaSfF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Jan 2023 13:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjAaSet (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2023 13:34:49 -0500
Received: from DM6FTOPR00CU001-vft-obe.outbound.protection.outlook.com (mail-cusazlp170100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834E459747;
        Tue, 31 Jan 2023 10:34:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gutKq6xlQuQrDQBzGd6CdUaAc4qKyR1SJC9/FhoF7nCx7BUuMqHuOoO769/oY7azovkH9WcKrP+pRj8xuK/T7Wixka3KLmJwcR7MBWjwv0KEBTrKCY0iMgwPIqZZxYognVTeEItR8nKb2o8QzkA9sC8G/KLiwTJ2DomT9W0jUbvfdxXITJUsVCSu0Ixtt1BxBMlQN8C6OShw1ZtHNyeo+j6KEYLOGLKGvk5M8FsziVySWPA+eiDDPTauuwDkN9d8NacWjZ4Y3XRHMpTw6IGDPmcrdow8uAiEp9llI9KG5OFa/rPpma9nTkTDnnPhWNHt7WhdtX2idPS0onShevrGAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r466BidaAyYzgDhZqIhX4AFoQVnLFgeETuiSgJRGvRk=;
 b=jx22JGPcZVfv3w54lLLAMfoM+wolcjO7Gqu1k0B/6Yax7niTWNgAtnbSDlqMYSrE/0Ynumou4q0cRuZ0oQdwR9vX/HFieqXIUkzy1Baxo0tDEhuIz6ZFB8DmWxAG2zCaJ+qjA/VNLQJ6/JB48aALcA2RbdHgOhHpeszmJgcmPaQzTtDj9i8O+VIWLgz5H3nqKb1xCd8fYgYd3SKe6uiU5iQi90q9S44BqTWvehKS5SkFuv6A22TObJtF6kkmWdO7fMtycmoJPu59oR5lWarAuUzoYJS0GYqLTCjPIIjI27wKiJAOxmalJ480BQZ5+E3vNVK3fqzTls5Xfcxa5h2mYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r466BidaAyYzgDhZqIhX4AFoQVnLFgeETuiSgJRGvRk=;
 b=M054JD7dK9WSL+1IvpFU61OLcTMMWrk6BhX9a68TY7+BmRN4a6l7ATAXkULkM0VfDtE6WzGSPBChgVgyCQCon13/c3qTxXHLpHth7py8+V25Hk4hLXUEKHb/ls7sVnGTBxqxeHi/bCfGt2TWr3ixki6qDmwEDhbaNKkK9sohPv8=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BY1PR21MB3917.namprd21.prod.outlook.com (2603:10b6:a03:527::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.4; Tue, 31 Jan
 2023 18:34:07 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e%8]) with mapi id 15.20.6086.005; Tue, 31 Jan 2023
 18:34:07 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
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
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC PATCH V3 10/16] x86/hyperv: Add smp support for sev-snp
 guest
Thread-Topic: [RFC PATCH V3 10/16] x86/hyperv: Add smp support for sev-snp
 guest
Thread-Index: AQHZLgv5p74INTs2e0yVsqB8bihqMa645jAQ
Date:   Tue, 31 Jan 2023 18:34:07 +0000
Message-ID: <BYAPR21MB16886B496845962DFBFB112DD7D09@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-11-ltykernel@gmail.com>
In-Reply-To: <20230122024607.788454-11-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=991018ca-b8f8-4f53-8fc8-acf09c8286fb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-31T18:23:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BY1PR21MB3917:EE_
x-ms-office365-filtering-correlation-id: 9e78c053-16fb-427c-4839-08db03b9bccf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y06ZqI9vqZX8IQngxU3r6oHA6VXedeV+IBnUizjFHjGK06A9h8vIVjDVt34Mz2yGlvA9y0XuCdJvV2SYRlt0m1ladbHWlmKSjUKX26VqOseA0b89JvFWW8ybC/qm9/rl/9IToTkVCfJA91eB4hTuejhnrDkcRmNex5r8Uftsu/wpi7yD3FoY2CwaXFjFjK+2ehiafUw3N7wNBZY1aotbOJgZ0WsUDkcV89/p05b4yDbCj+4InX9uj9kTJ2I+E28l/kI82zMhDQA08nQbq6eOu6KmDmASt8H3YFtlUSus2dX03Z43ku1eB+Nln0V5YpaICf22E4wifC9Xx8UUXC5YEHABgpEnI+Lm4bXqRd1uYhE+3TTfCC2/2sGq8WoY5W8BgksW/JNL3ChvC0MFPuTAm9ffosHi/TSFuBwlwpJGvAqV1IKmGpJLQBsP+tpWuN0nOgxD1sUFKohLxyIHlPSM27SqjC9dCQEfXgwBML8xUwG/GbHDgVI/1o57+ltBddOV8j1i6/4AlWaskyZwn525JCD5O5HEbj/meCBcXsPD5/Bnyq5fgJhyII+sCAS+VgfoG6PPwlLaolP2kUAx4A9Te2veJQ5YeNup7q/Gk38mrZOwYHXGw0DXO6u9rRC+rIHeQdAtITs2IwDEn0iP3MHvPH3Taj/T+T0XnE3Ucpt9JIJfrczFKj4/wUl4KprFN6RZKOT3d9apK9LT6Wn97E3MQ65/sP2oV0Hg9Evl/hqSbqxuVRHUptxU5uikDWKUpzhBDPBtP3n4Tn/XUi+ccuywmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199018)(7406005)(5660300002)(7416002)(30864003)(8936002)(83380400001)(52536014)(2906002)(66556008)(66446008)(8990500004)(8676002)(4326008)(66476007)(41300700001)(76116006)(186003)(9686003)(33656002)(7696005)(64756008)(26005)(66946007)(86362001)(316002)(55016003)(6506007)(38070700005)(921005)(71200400001)(10290500003)(110136005)(82950400001)(38100700002)(122000001)(82960400001)(478600001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OIvV4CQWVDKCWRDoaVhsSUVofI4zpjjVE2r9sg6hp+q/HRqeSaAjSkKvYiiD?=
 =?us-ascii?Q?ElBCL2JEF101N+ZoCR+Qqh+kBi2sQPvgYL7olgutfahuViNvrBeQqt+auUhA?=
 =?us-ascii?Q?QiEd9zYUWerjDiKj6HO0XCVf76EohLfY8xYpATUHS4g8nEPnP/h19Qg/Dq2J?=
 =?us-ascii?Q?OvCCrEiMO7Ax3C6E9W3ZJHSJZUC/ca/zAVMsoi7kRNX2YdA/1RCme/A/Wgdh?=
 =?us-ascii?Q?s/ROad5LTCTlJgilHXH8IxvWd3b5Isfayp+DBo2nbL+khSbzlVY6/2b5r+or?=
 =?us-ascii?Q?b/nBVvslS6wEet7BwhOCv5IEllku65mEMPrQTYEE6vpRCoYZBLYElbL5IvDi?=
 =?us-ascii?Q?SieF6usfOwZxEM1EJBdQsofHKvg2yqliRLgMsb8ZsV26K/FIuwzE6CgUx1Pp?=
 =?us-ascii?Q?uPs1Ja0uLQVZX74aDWvdIwOl/EdOegZYM6gUIUFfTBMDQLKCBv0PBMGd7Jp6?=
 =?us-ascii?Q?K7VtyH5Qr7JKwT6iLxx/TWGLu10hhVQjVlBxoYojbPR1cwmpLXKni/SXsj7U?=
 =?us-ascii?Q?md75E+jDHwAzhGbUIM/5sLgnvTvRm1L2OeeCmgtXn2v7V1jQrQTpi7R1v9Sa?=
 =?us-ascii?Q?M9OR/a/ephDSv4kQkksuoM7Po+CA4uNhUlUPuwGT8wAJwDplWsfj17chlpqa?=
 =?us-ascii?Q?l1NeUMtJS9/nKiXAXLSsrlXXG/KV/EYnro3j0vEJfnK46r3bSdzo+hFIZ2Uy?=
 =?us-ascii?Q?XDv1eEUG00o6aq6Q1FhoyhkcpM/iaBr2791BOPDgBuW6gDL4GQQ7FRnJBHLd?=
 =?us-ascii?Q?u35GHrhkiRCLo5jJ8lXkDk5H8Gha5L+TXPWtD3XqkLG83wG3dJbjoruVv6H9?=
 =?us-ascii?Q?7ap2mb28cUu11b6nMkFYOFzF1cDkPcrzMdgVdKrQV52zJmrHQh7IDh1f8Lkz?=
 =?us-ascii?Q?56OQq6Hk8db7qqomkEMDe1QfxcLzuCzxGenyzni2n2jW7CZLBJqTJVeaHsHF?=
 =?us-ascii?Q?VPi00QSXwCqsaGkA7Rluu1uL2z3khpL02CBiEi+ROksTQZMR7KFuJrlLxEnp?=
 =?us-ascii?Q?AlwZEA+SrZIverRHY1vt9Ctml32uzuyWb4cnK7WHt40eRaq2UdavaxB1pgjr?=
 =?us-ascii?Q?hmWALSYZnkI/dD3g5k4fWOKicxIc7ioocJ+949taE3jIZydo58lp+CJHjLc9?=
 =?us-ascii?Q?J79WNwy4Q3RSlw3L2O/p91AV4yJr9NMCEjC1vPWwPSaHeHM+Ys9rZN9D3Z46?=
 =?us-ascii?Q?2D+/8yjIbScIR1q18Yl2RdkboFGqncgEGe0yYqrTbCyyyowx92z7KKEBFDUX?=
 =?us-ascii?Q?px+fMT169/fvBs+cOuUOET5egqPaZxixtBscl72a821O4gnV/bjFB0tt/jMC?=
 =?us-ascii?Q?gdtUba9mjfdiwsr4koKcgHj3Wtrzcer7KoOH9gPDHfxQBhdzeih4C2YU+c5+?=
 =?us-ascii?Q?wFf6tXCpr/4DGOyEtumprri2RvBthVH2632nEtpaCGrSJhnJ55DYWIvBnwa0?=
 =?us-ascii?Q?I2Hl2kMBDqxrhVxmuWH5HbsNa8SKo+0UAKEsVzhNXYJIVNjpskc8AkRxZHXW?=
 =?us-ascii?Q?EK6Z2HIt13rt7ydTVvxv23YnIj82Ijg684NFEbzUs5OX+Jc5OeG99hOxOk3S?=
 =?us-ascii?Q?2gP3HAYz4E+K7Go+TPGf3ItCwoSNVnnsE9n0ZBuKilTryVDgNW8Xrt1/DuQQ?=
 =?us-ascii?Q?8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e78c053-16fb-427c-4839-08db03b9bccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 18:34:07.3966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YBYzXgU5eIJ2WpkttCJozUJeSMK87zf+eUuIw4YhxKLd9MyIdhdg4+O4vue1gUHs07oPalkqAcwRgtK1S9rfBs4RmlqfOFfA3EfoAsmKW9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR21MB3917
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Saturday, January 21, 2023 6:4=
6 PM
>=20
> The wakeup_secondary_cpu callback was populated with wakeup_
> cpu_via_vmgexit() which doesn't work for Hyper-V. Override it
> with Hyper-V specific hook which uses HVCALL_START_VIRTUAL_
> PROCESSOR hvcall to start AP with vmsa data structure.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC v2:
>        * Add helper function to initialize segment
>        * Fix some coding style
> ---
>  arch/x86/include/asm/mshyperv.h   |   2 +
>  arch/x86/include/asm/sev.h        |  13 ++++
>  arch/x86/include/asm/svm.h        |  47 +++++++++++++
>  arch/x86/kernel/cpu/mshyperv.c    | 112 ++++++++++++++++++++++++++++--
>  include/asm-generic/hyperv-tlfs.h |  19 +++++
>  5 files changed, 189 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 7266d71d30d6..c69051eec0e1 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -203,6 +203,8 @@ struct irq_domain *hv_create_pci_msi_domain(void);
>  int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vec=
tor,
>  		struct hv_interrupt_entry *entry);
>  int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *=
entry);
> +int hv_set_mem_host_visibility(unsigned long addr, int numpages, bool vi=
sible);
> +int hv_snp_boot_ap(int cpu, unsigned long start_ip);
>=20
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  void hv_ghcb_msr_write(u64 msr, u64 value);
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index ebc271bb6d8e..e34aaf730220 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -86,6 +86,19 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
>=20
>  #define RMPADJUST_VMSA_PAGE_BIT		BIT(16)
>=20
> +union sev_rmp_adjust {
> +	u64 as_uint64;
> +	struct {
> +		unsigned long target_vmpl : 8;
> +		unsigned long enable_read : 1;
> +		unsigned long enable_write : 1;
> +		unsigned long enable_user_execute : 1;
> +		unsigned long enable_kernel_execute : 1;
> +		unsigned long reserved1 : 4;
> +		unsigned long vmsa : 1;
> +	};
> +};
> +
>  /* SNP Guest message request */
>  struct snp_req_data {
>  	unsigned long req_gpa;
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index cb1ee53ad3b1..f8b321a11ee4 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -336,6 +336,53 @@ struct vmcb_save_area {
>  	u64 last_excp_to;
>  	u8 reserved_0x298[72];
>  	u32 spec_ctrl;		/* Guest version of SPEC_CTRL at 0x2E0 */
> +	u8 reserved_7b[4];
> +	u32 pkru;
> +	u8 reserved_7a[20];
> +	u64 reserved_8;		/* rax already available at 0x01f8 */
> +	u64 rcx;
> +	u64 rdx;
> +	u64 rbx;
> +	u64 reserved_9;		/* rsp already available at 0x01d8 */
> +	u64 rbp;
> +	u64 rsi;
> +	u64 rdi;
> +	u64 r8;
> +	u64 r9;
> +	u64 r10;
> +	u64 r11;
> +	u64 r12;
> +	u64 r13;
> +	u64 r14;
> +	u64 r15;
> +	u8 reserved_10[16];
> +	u64 sw_exit_code;
> +	u64 sw_exit_info_1;
> +	u64 sw_exit_info_2;
> +	u64 sw_scratch;
> +	union {
> +		u64 sev_features;
> +		struct {
> +			u64 sev_feature_snp			: 1;
> +			u64 sev_feature_vtom			: 1;
> +			u64 sev_feature_reflectvc		: 1;
> +			u64 sev_feature_restrict_injection	: 1;
> +			u64 sev_feature_alternate_injection	: 1;
> +			u64 sev_feature_full_debug		: 1;
> +			u64 sev_feature_reserved1		: 1;
> +			u64 sev_feature_snpbtb_isolation	: 1;
> +			u64 sev_feature_resrved2		: 56;
> +		};
> +	};
> +	u64 vintr_ctrl;
> +	u64 guest_error_code;
> +	u64 virtual_tom;
> +	u64 tlb_id;
> +	u64 pcpu_id;
> +	u64 event_inject;
> +	u64 xcr0;
> +	u8 valid_bitmap[16];
> +	u64 x87_state_gpa;
>  } __packed;
>=20
>  /* Save area definition for SEV-ES and SEV-SNP guests */
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 197c8f2ec4eb..9d547751a1a7 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -39,6 +39,13 @@
>  #include <asm/realmode.h>
>  #include <asm/e820/api.h>
>=20
> +/*
> + * DEFAULT INIT GPAT and SEGMENT LIMIT value in struct VMSA
> + * to start AP in enlightened SEV guest.
> + */
> +#define HV_AP_INIT_GPAT_DEFAULT		0x0007040600070406ULL
> +#define HV_AP_SEGMENT_LIMIT		0xffffffff

If these values are defined by Hyper-V, they should probably go in
hyperv-tlfs.h.

> +
>  /* Is Linux running as the root partition? */
>  bool hv_root_partition;
>  struct ms_hyperv_info ms_hyperv;
> @@ -230,6 +237,94 @@ static void __init hv_smp_prepare_boot_cpu(void)
>  #endif
>  }
>=20
> +static u8 ap_start_input_arg[PAGE_SIZE] __bss_decrypted __aligned(PAGE_S=
IZE);
> +static u8 ap_start_stack[PAGE_SIZE] __aligned(PAGE_SIZE);
> +
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
> +int hv_snp_boot_ap(int cpu, unsigned long start_ip)
> +{
> +	struct vmcb_save_area *vmsa =3D (struct vmcb_save_area *)
> +		__get_free_page(GFP_KERNEL | __GFP_ZERO);
> +	struct desc_ptr gdtr;
> +	u64 ret, retry =3D 5;
> +	struct hv_start_virtual_processor_input *start_vp_input;
> +	union sev_rmp_adjust rmp_adjust;
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
> +	vmsa->sev_feature_snp =3D 1;
> +	vmsa->sev_feature_restrict_injection =3D 1;
> +
> +	rmp_adjust.as_uint64 =3D 0;
> +	rmp_adjust.target_vmpl =3D 1;
> +	rmp_adjust.vmsa =3D 1;
> +	ret =3D rmpadjust((unsigned long)vmsa, RMP_PG_SIZE_4K,
> +			rmp_adjust.as_uint64);
> +	if (ret !=3D 0) {
> +		pr_err("RMPADJUST(%llx) failed: %llx\n", (u64)vmsa, ret);
> +		return ret;
> +	}
> +
> +	local_irq_save(flags);
> +	start_vp_input =3D
> +		(struct hv_start_virtual_processor_input *)ap_start_input_arg;
> +	memset(start_vp_input, 0, sizeof(*start_vp_input));
> +	start_vp_input->partitionid =3D -1;
> +	start_vp_input->vpindex =3D cpu;
> +	start_vp_input->targetvtl =3D ms_hyperv.vtl;
> +	*(u64 *)&start_vp_input->context[0] =3D __pa(vmsa) | 1;
> +
> +	do {
> +		ret =3D hv_do_hypercall(HVCALL_START_VIRTUAL_PROCESSOR,
> +				      start_vp_input, NULL);
> +	} while (hv_result(ret) =3D=3D HV_STATUS_TIME_OUT && retry--);
> +
> +	if (!hv_result_success(ret)) {
> +		pr_err("HvCallStartVirtualProcessor failed: %llx\n", ret);
> +		goto done;
> +	}
> +
> +done:
> +	local_irq_restore(flags);
> +	return ret;
> +}
> +

Like a comment in an earlier patch, I'm wondering if the bulk of
this code could move to ivm.c, to avoid overloading mshyperv.c.

>  static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
>  {
>  #ifdef CONFIG_X86_64
> @@ -239,6 +334,16 @@ static void __init hv_smp_prepare_cpus(unsigned int =
max_cpus)
>=20
>  	native_smp_prepare_cpus(max_cpus);
>=20
> +	/*
> +	 *  Override wakeup_secondary_cpu callback for SEV-SNP
> +	 *  enlightened guest.
> +	 */
> +	if (hv_isolation_type_en_snp())
> +		apic->wakeup_secondary_cpu =3D hv_snp_boot_ap;
> +
> +	if (!hv_root_partition)
> +		return;
> +
>  #ifdef CONFIG_X86_64
>  	for_each_present_cpu(i) {
>  		if (i =3D=3D 0)
> @@ -475,8 +580,7 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  # ifdef CONFIG_SMP
>  	smp_ops.smp_prepare_boot_cpu =3D hv_smp_prepare_boot_cpu;
> -	if (hv_root_partition)
> -		smp_ops.smp_prepare_cpus =3D hv_smp_prepare_cpus;
> +	smp_ops.smp_prepare_cpus =3D hv_smp_prepare_cpus;
>  # endif
>=20
>  	/*
> @@ -501,7 +605,7 @@ static void __init ms_hyperv_init_platform(void)
>  	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
>  		mark_tsc_unstable("running on Hyper-V");
>=20
> -	if (isolation_type_en_snp()) {
> +	if (hv_isolation_type_en_snp()) {

Also a bug fix to an earlier patch in this series.

>  		/*
>  		 * Hyper-V enlightened snp guest boots kernel
>  		 * directly without bootloader and so roms,
> @@ -511,7 +615,7 @@ static void __init ms_hyperv_init_platform(void)
>  		x86_platform.legacy.rtc =3D 0;
>  		x86_platform.set_wallclock =3D set_rtc_noop;
>  		x86_platform.get_wallclock =3D get_rtc_noop;
> -		x86_platform.legacy.reserve_bios_regions =3D x86_init_noop;
> +		x86_platform.legacy.reserve_bios_regions =3D 0;

This looks like a bug fix to Patch 8 of the series.  It should be fixed
in patch 8.

>  		x86_init.resources.probe_roms =3D x86_init_noop;
>  		x86_init.resources.reserve_resources =3D x86_init_noop;
>  		x86_init.mpparse.find_smp_config =3D x86_init_noop;
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index c1cc3ec36ad5..3d7c67be9f56 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -148,6 +148,7 @@ union hv_reference_tsc_msr {
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
>  #define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
>  #define HVCALL_SEND_IPI				0x000b
> +#define HVCALL_ENABLE_VP_VTL			0x000f
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
>  #define HVCALL_SEND_IPI_EX			0x0015
> @@ -165,6 +166,7 @@ union hv_reference_tsc_msr {
>  #define HVCALL_MAP_DEVICE_INTERRUPT		0x007c
>  #define HVCALL_UNMAP_DEVICE_INTERRUPT		0x007d
>  #define HVCALL_RETARGET_INTERRUPT		0x007e
> +#define HVCALL_START_VIRTUAL_PROCESSOR		0x0099
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
>  #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY 0x00db
> @@ -219,6 +221,7 @@ enum HV_GENERIC_SET_FORMAT {
>  #define HV_STATUS_INVALID_PORT_ID		17
>  #define HV_STATUS_INVALID_CONNECTION_ID		18
>  #define HV_STATUS_INSUFFICIENT_BUFFERS		19
> +#define HV_STATUS_TIME_OUT                     0x78
>=20
>  /*
>   * The Hyper-V TimeRefCount register and the TSC
> @@ -778,6 +781,22 @@ struct hv_input_unmap_device_interrupt {
>  	struct hv_interrupt_entry interrupt_entry;
>  } __packed;
>=20
> +struct hv_enable_vp_vtl_input {
> +	u64 partitionid;
> +	u32 vpindex;
> +	u8 targetvtl;
> +	u8 padding[3];
> +	u8 context[0xe0];
> +} __packed;
> +
> +struct hv_start_virtual_processor_input {
> +	u64 partitionid;
> +	u32 vpindex;
> +	u8 targetvtl;
> +	u8 padding[3];
> +	u8 context[0xe0];
> +} __packed;
> +
>  #define HV_SOURCE_SHADOW_NONE               0x0
>  #define HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE   0x1
>=20
> --
> 2.25.1

