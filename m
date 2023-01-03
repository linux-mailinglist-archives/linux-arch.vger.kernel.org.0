Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE0D65C703
	for <lists+linux-arch@lfdr.de>; Tue,  3 Jan 2023 20:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbjACTLq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Jan 2023 14:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbjACTLf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jan 2023 14:11:35 -0500
Received: from MW2PR02CU001-vft-obe.outbound.protection.outlook.com (mail-westus2azon11022021.outbound.protection.outlook.com [52.101.48.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48BDC2C;
        Tue,  3 Jan 2023 11:11:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWT3auTKIPVxrhzeyny7za3ThWvmB4rrulQftpOH6IuW6jndUdmxi7+8T6lDwq1BsBtEdLsP7doEsSv047jmkgqwv2Vu0Iyoeslx5UjMjRUfIGfM0TaLU28EZnCsgX89DQFmesslZBRslV3ZLRQQVozhPsikeh3VzUcPY9tq3xT/O02hQC8g+b8BfrtHIh7HnC/NxmDKWYE8hGzG6MZKqvt5JhLILmuUvY+V08UDLjFwhhHko7Q3E9CMoGkdLPFDZaQ3ZtnPz8IX+MrISutofW0LyiF3tFocD9mHr7/YslLnRsKiWhT74FC0eVJ+tdPhB2+loFQhhdlUVqUwvc2q/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvC3nOVAKERIm2j8oS8nL+6sKZnAfClMfNKR2Rqv3LY=;
 b=ncE9yYG+/srTdwuCjyPLUNDeCoOStUbtd9dnxFW7rC83OGWj2mzf1bGF9ZPO7r1bYyAJURf9r2kkhEWOFnUNBdTTH9g4oY2921VCyMwLmUNGfzyNnGyPM6Ozi/Xqm+N/PSy+HhwroYL5iKNKhYc02DfKucTs18qoF0BIYfFLivP87ax4jIPGcRcQBljfVOZdfiV2QCp2nSMDcstcrzkm5p4AZT7ZhRTt/+Wt7G1AKDu43iI/0ZfUZfLFZ6kCeRdMXuireImqK2fw3x55brAv9bSSVl39Lzp5exMiBcFrgHlr+dCB9Wz0LjNA7raE2GEf2pMTRDzjmLSrWKR4hqmjKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvC3nOVAKERIm2j8oS8nL+6sKZnAfClMfNKR2Rqv3LY=;
 b=Zy9214k2eBE9m1k778qA0iRLDZ/dcmkh03niPXUup8iPpajANtg2M56D7zP7xZsi24Y2FXsdR3Wf9Rsxgt0CNRJVD5OFVHApRAMpuqOA1C3fRBWYFKYupj9wLv4JVnL5wuA6JMC3LOi1rwTstcBGH9ZSQnAMDZZ1IPM9JZqygwU=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3749.namprd21.prod.outlook.com (2603:10b6:208:3d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.1; Tue, 3 Jan
 2023 19:11:30 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::db1a:4e71:c688:b7b1]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::db1a:4e71:c688:b7b1%4]) with mapi id 15.20.6002.005; Tue, 3 Jan 2023
 19:11:30 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jinank Jain <jinankjain@linux.microsoft.com>,
        Jinank Jain <jinankjain@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>
Subject: RE: [PATCH v10 2/5] Drivers: hv: Setup synic registers in case of
 nested root partition
Thread-Topic: [PATCH v10 2/5] Drivers: hv: Setup synic registers in case of
 nested root partition
Thread-Index: AQHZHnmpvVLD+m3uzEu9T0k4Q2fsXa6Ktk4AgAJaq9A=
Date:   Tue, 3 Jan 2023 19:11:30 +0000
Message-ID: <BYAPR21MB1688B18CAC4A51989A538C97D7F49@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1672639707.git.jinankjain@linux.microsoft.com>
 <cb951fb1ad6814996fc54f4a255c5841a20a151f.1672639707.git.jinankjain@linux.microsoft.com>
In-Reply-To: <cb951fb1ad6814996fc54f4a255c5841a20a151f.1672639707.git.jinankjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4cc76ffc-1500-4fa0-b5fd-4f24d6395506;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-03T19:09:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3749:EE_
x-ms-office365-filtering-correlation-id: 871316f4-b10a-4fd5-e424-08daedbe520a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OEWppT9VdETSF4iJa6DgMM2+qmscO6HAjvGb8dhlhC8TUIYVy7DmnjIXMmJjCDulQDnegXmQMQPmcdBohMe9PkX2l/Lyw76gr8BGfYT1nHRUcc8wrvBKpgKJcSK3LbPcmOYMuB+ViQMHiBFyAolvR5Oi/jVtIhMKYH9Z7f9GUTgTWLI2e66EYw2JP0u0YBzE16tb0DNn/XOMtnfV2EGZZujNYZRhZ/FwaYMXv6rClx5st4rbL4JM5jCh0apJF0cbAsvYtdu+Q485KDAo91b4kAbdSMbFqHKjs5azlAZwdKDx5u7cHgMyZqAnOQDpkveRueSoUYNDEbnKKYm3kmihLY3HazENTVPWJNq6It1wZf+e0dRdB5SAx7huLxpWIv6cJiPmH5+CXqIqcE+yNacLGT98hMFnVh0CqdIGBG8PugJ4QGZhC5TBzKc8RDfup+dSDTnAkgFgBbB/RD54Vq91uFxhW9bkzcnVYSztD5JGL/Q5+cGbRRdTJO07mX1yys6DprOBtW0CVqHNnkv7mJJhIbpybjbiQQ+ABJMcqLJ1yex7yYlxrSBFL0v9RzEOJr658SjhUfrOW8CnEQ7HspHw32sgpaNjvxpUyz6MCk8paCgccEXq9GnSowk09+uEBusWEK3q1DeAMgrvc9zgFzuLIrLaFkaxDUdp54yawbrnIzG1dKs6TqMGqlN9k67nadZSbi2yEJomWYR5bIz9kRn2VaF8lCGfyTxuaA6V+8c8eKH2X24a8L/xlXKGGgxlSjZDum3ZTNPGQJVrsKHAbpd5bQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199015)(8936002)(7416002)(52536014)(8676002)(66476007)(4326008)(66446008)(76116006)(66556008)(64756008)(5660300002)(41300700001)(2906002)(6636002)(54906003)(316002)(10290500003)(71200400001)(110136005)(478600001)(8990500004)(6506007)(107886003)(186003)(33656002)(26005)(9686003)(7696005)(66946007)(83380400001)(82960400001)(82950400001)(55016003)(86362001)(122000001)(38100700002)(38070700005)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GcPpW3VJXolrzeiGBTnvXO1K9Y2i1LxNk2Ad2e6qnn8vMFKIEk24AO+PRMbe?=
 =?us-ascii?Q?uGHeoluzvveH87tVB9zMV3IE4GZQlRmq3Zs/91XX+iWTXGS+Ittstox7ATUw?=
 =?us-ascii?Q?Ah5HrkiBqbIidETZbfnTEm1rsNyVEGagjKA2Ubq4X8IRLkZun8rgGC/SANC1?=
 =?us-ascii?Q?+c4E3cb1YLHqNbq9AqyP+88KnTgR+RiAZ1rSbHuufkEk0Byx4K+Zx+C6WVU9?=
 =?us-ascii?Q?t0AAM8E6kTVKpTXKaE8cS+3oGSdHJe0DSjOmVKdSPK/2IMrp1tnxsbwulT7g?=
 =?us-ascii?Q?t43xqC6ZkgqmB9SJpekvbl3DVS4PJTrbyPZNG3gQK0JNwxZKJ3OIblDga/Oe?=
 =?us-ascii?Q?s/ahxsGY9Xgt0vMgICNOCVkIzmdFAuoQsyyo8wnvL/FGTOVl19XOkblEARbl?=
 =?us-ascii?Q?igQEzEqN3pj+VowfC0o9XwWGweYNSXGRfOT9YyEJw/HlWDuYqdB46FL9cNDr?=
 =?us-ascii?Q?eZ1fCIZQTtFw83s4wy5f8Xd++sn036QhGU2fMscO5hPI/zdtqOdTpTs2rByH?=
 =?us-ascii?Q?VxQvMsnezK2teEA0ZlSMbk9yWpNcJhJ2/UcZcoCq/YNYyXCEwCfZWtxe7ing?=
 =?us-ascii?Q?Oy7Ws8Qg3gody7QO+wHT6DgqnUVDQD3gmtz5w1a4A3Hw71hsD1j0ws5L14MM?=
 =?us-ascii?Q?GKj/XKjKiy+/iblu5xDwuQL70zORc4F1QHgv36ov+jYQqTEdAHac5O9CgtPY?=
 =?us-ascii?Q?MeOACekoHI+M/haLGi8GLh4w8xIJpOSrevZW8lnHmQXt4bHMhvlhKmAj5A+g?=
 =?us-ascii?Q?lapJNl7ueoCv7SyG5hPl5PXoT2q0VHOzb4wOkSTy49JWR67gQaISojMkJtS8?=
 =?us-ascii?Q?sXr6v4EvADrzojgYOdPX7XUdTIxznBljkzqCmagKW0BIE8f8aGgs8SmQQT89?=
 =?us-ascii?Q?Xy9yd/nwOPQ75XM9nPnqCYCnGgRo7i+MGRQRLgf+nXjD2YHM5ci7T5aVG0wU?=
 =?us-ascii?Q?eRbQML/MWMnzqQxzge1uL+S8cRujGgtdAypGmcUBj3MAqAvzj06kqK9zTO2+?=
 =?us-ascii?Q?cuH8TkUHBqLQokOEUPIyrKHLz47PeLaqkvtRoZldQdWBy3/MB8FF218Xtxi3?=
 =?us-ascii?Q?GVZereXwLYHBAr0R0QwCcsf3qZeEqMxDg5u3mmTz0Zz4U1abBQqfVDr5eLSt?=
 =?us-ascii?Q?YXoFqcljU1VZkhmFRpJATrPQ01moNZJP6N2lXa9bUwbUMf1yPO0RzlE2McEj?=
 =?us-ascii?Q?62iPjAyxFWCpqvpQZeeT4dIPVDEnHriqBlEXaAMALv7VSUxJw7SYDbyZYvBd?=
 =?us-ascii?Q?nnuiV8n6FPqDUUx/Ju8Adc8N4Xta3/Vbbc/8VhFLzW2GB/mcSpvagPJD5Bk2?=
 =?us-ascii?Q?qqHl4wkjvIRCqH/ivbcdIj+n433ziuSpd3QajUhjkrSRfQsf3yvLdQ8XsaDl?=
 =?us-ascii?Q?qdOWoJ0LmYtWUDmQ+V5XpD49EBThfLdWVq3IIRSi47EQg5+WuxIXh2Kx+cuZ?=
 =?us-ascii?Q?d6K7iM+OrXm7b7qWXM4pAbjOxHe/7XdbgW6bCpJXxG79R0/d2Vbjqb+QrJC1?=
 =?us-ascii?Q?y3i3sdUscgT3fUKvmDG7rjq6VFUw8X2ivEofzo/85kv8a8SJCYkaBo3GODpZ?=
 =?us-ascii?Q?4JdxtFG2KlMWwQT1y0Lyne5ZrEXeM6WMVQvwFw1wyl48ybsq4H71mJsu5Pt4?=
 =?us-ascii?Q?DQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871316f4-b10a-4fd5-e424-08daedbe520a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 19:11:30.1736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QwbLCwzKBwVpa7sIgCmIjdA8pc1BK/HixR8JdXDxIY8cek478w4ZfqXaFVO+yd1LVlstGvJ3j4lx9H3SnyyNlBuO1/pZ0/WZzYIVBzgJK1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3749
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jinank Jain <jinankjain@linux.microsoft.com> Sent: Sunday, January 1,=
 2023 11:13 PM
>=20
> Child partitions are free to allocate SynIC message and event page but in
> case of root partition it must use the pages allocated by Microsoft
> Hypervisor (MSHV). Base address for these pages can be found using
> synthetic MSRs exposed by MSHV. There is a slight difference in those MSR=
s
> for nested vs non-nested root partition.
>=20
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 11 +++++
>  arch/x86/include/asm/mshyperv.h    | 30 +++-----------
>  arch/x86/kernel/cpu/mshyperv.c     | 65 ++++++++++++++++++++++++++++++
>  drivers/hv/hv.c                    | 18 +++++----
>  4 files changed, 93 insertions(+), 31 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index 58c03d18c235..b5019becb618 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -225,6 +225,17 @@ enum hv_isolation_type {
>  #define HV_REGISTER_SINT14			0x4000009E
>  #define HV_REGISTER_SINT15			0x4000009F
>=20
> +/*
> + * Define synthetic interrupt controller model specific registers for
> + * nested hypervisor.
> + */
> +#define HV_REGISTER_NESTED_SCONTROL            0x40001080
> +#define HV_REGISTER_NESTED_SVERSION            0x40001081
> +#define HV_REGISTER_NESTED_SIEFP               0x40001082
> +#define HV_REGISTER_NESTED_SIMP                0x40001083
> +#define HV_REGISTER_NESTED_EOM                 0x40001084
> +#define HV_REGISTER_NESTED_SINT0               0x40001090
> +
>  /*
>   * Synthetic Timer MSRs. Four timers per vcpu.
>   */
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 61f0c206bff0..c38e4c66a3ac 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -198,30 +198,10 @@ static inline bool hv_is_synic_reg(unsigned int reg=
)
>  	return false;
>  }
>=20
> -static inline u64 hv_get_register(unsigned int reg)
> -{
> -	u64 value;
> -
> -	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
> -		hv_ghcb_msr_read(reg, &value);
> -	else
> -		rdmsrl(reg, value);
> -	return value;
> -}
> -
> -static inline void hv_set_register(unsigned int reg, u64 value)
> -{
> -	if (hv_is_synic_reg(reg) && hv_isolation_type_snp()) {
> -		hv_ghcb_msr_write(reg, value);
> -
> -		/* Write proxy bit via wrmsl instruction */
> -		if (reg >=3D HV_REGISTER_SINT0 &&
> -		    reg <=3D HV_REGISTER_SINT15)
> -			wrmsrl(reg, value | 1 << 20);
> -	} else {
> -		wrmsrl(reg, value);
> -	}
> -}
> +u64 hv_get_register(unsigned int reg);
> +void hv_set_register(unsigned int reg, u64 value);
> +u64 hv_get_non_nested_register(unsigned int reg);
> +void hv_set_non_nested_register(unsigned int reg, u64 value);
>=20
>  #else /* CONFIG_HYPERV */
>  static inline void hyperv_init(void) {}
> @@ -241,6 +221,8 @@ static inline int hyperv_flush_guest_mapping_range(u6=
4 as,
>  }
>  static inline void hv_set_register(unsigned int reg, u64 value) { }
>  static inline u64 hv_get_register(unsigned int reg) { return 0; }
> +static inline void hv_set_non_nested_register(unsigned int reg, u64 valu=
e) { }
> +static inline u64 hv_get_non_nested_register(unsigned int reg) { return =
0; }
>  static inline int hv_set_mem_host_visibility(unsigned long addr, int num=
pages,
>  					     bool visible)
>  {
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index f9b78d4829e3..938fc82edf05 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -41,7 +41,72 @@ bool hv_root_partition;
>  bool hv_nested;
>  struct ms_hyperv_info ms_hyperv;
>=20
> +static inline unsigned int hv_get_nested_reg(unsigned int reg)
> +{
> +	switch (reg) {
> +	case HV_REGISTER_SIMP:
> +		return HV_REGISTER_NESTED_SIMP;
> +	case HV_REGISTER_SIEFP:
> +		return HV_REGISTER_NESTED_SIEFP;
> +	case HV_REGISTER_SVERSION:
> +		return HV_REGISTER_NESTED_SVERSION;
> +	case HV_REGISTER_SCONTROL:
> +		return HV_REGISTER_NESTED_SCONTROL;
> +	case HV_REGISTER_SINT0:
> +		return HV_REGISTER_NESTED_SINT0;
> +	case HV_REGISTER_EOM:
> +		return HV_REGISTER_NESTED_EOM;
> +	default:
> +		return reg;
> +	}
> +}
> +
>  #if IS_ENABLED(CONFIG_HYPERV)
> +u64 hv_get_non_nested_register(unsigned int reg)
> +{
> +	u64 value;
> +
> +	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
> +		hv_ghcb_msr_read(reg, &value);
> +	else
> +		rdmsrl(reg, value);
> +	return value;
> +}
> +EXPORT_SYMBOL_GPL(hv_get_non_nested_register);
> +
> +void hv_set_non_nested_register(unsigned int reg, u64 value)
> +{
> +	if (hv_is_synic_reg(reg) && hv_isolation_type_snp()) {
> +		hv_ghcb_msr_write(reg, value);
> +
> +		/* Write proxy bit via wrmsl instruction */
> +		if (reg >=3D HV_REGISTER_SINT0 &&
> +		    reg <=3D HV_REGISTER_SINT15)
> +			wrmsrl(reg, value | 1 << 20);
> +	} else {
> +		wrmsrl(reg, value);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(hv_set_non_nested_register);
> +
> +u64 hv_get_register(unsigned int reg)
> +{
> +	if (hv_nested)
> +		reg =3D hv_get_nested_reg(reg);
> +
> +	return hv_get_non_nested_register(reg);
> +}
> +EXPORT_SYMBOL_GPL(hv_get_register);
> +
> +void hv_set_register(unsigned int reg, u64 value)
> +{
> +	if (hv_nested)
> +		reg =3D hv_get_nested_reg(reg);
> +
> +	hv_set_non_nested_register(reg, value);
> +}
> +EXPORT_SYMBOL_GPL(hv_set_register);
> +
>  static void (*vmbus_handler)(void);
>  static void (*hv_stimer0_handler)(void);
>  static void (*hv_kexec_handler)(void);
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 4d6480d57546..8b0dd8e5244d 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -147,7 +147,7 @@ int hv_synic_alloc(void)
>  		 * Synic message and event pages are allocated by paravisor.
>  		 * Skip these pages allocation here.
>  		 */
> -		if (!hv_isolation_type_snp()) {
> +		if (!hv_isolation_type_snp() && !hv_root_partition) {
>  			hv_cpu->synic_message_page =3D
>  				(void *)get_zeroed_page(GFP_ATOMIC);
>  			if (hv_cpu->synic_message_page =3D=3D NULL) {
> @@ -216,7 +216,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	simp.as_uint64 =3D hv_get_register(HV_REGISTER_SIMP);
>  	simp.simp_enabled =3D 1;
>=20
> -	if (hv_isolation_type_snp()) {
> +	if (hv_isolation_type_snp() || hv_root_partition) {
>  		hv_cpu->synic_message_page
>  			=3D memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
>  				   HV_HYP_PAGE_SIZE, MEMREMAP_WB);
> @@ -233,7 +233,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	siefp.as_uint64 =3D hv_get_register(HV_REGISTER_SIEFP);
>  	siefp.siefp_enabled =3D 1;
>=20
> -	if (hv_isolation_type_snp()) {
> +	if (hv_isolation_type_snp() || hv_root_partition) {
>  		hv_cpu->synic_event_page =3D
>  			memremap(siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT,
>  				 HV_HYP_PAGE_SIZE, MEMREMAP_WB);
> @@ -315,20 +315,24 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	 * addresses.
>  	 */
>  	simp.simp_enabled =3D 0;
> -	if (hv_isolation_type_snp())
> +	if (hv_isolation_type_snp() || hv_root_partition) {
>  		memunmap(hv_cpu->synic_message_page);
> -	else
> +		hv_cpu->synic_message_page =3D NULL;
> +	} else {
>  		simp.base_simp_gpa =3D 0;
> +	}
>=20
>  	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
>=20
>  	siefp.as_uint64 =3D hv_get_register(HV_REGISTER_SIEFP);
>  	siefp.siefp_enabled =3D 0;
>=20
> -	if (hv_isolation_type_snp())
> +	if (hv_isolation_type_snp() || hv_root_partition) {
>  		memunmap(hv_cpu->synic_event_page);
> -	else
> +		hv_cpu->synic_event_page =3D NULL;
> +	} else {
>  		siefp.base_siefp_gpa =3D 0;
> +	}
>=20
>  	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
>=20
> --
> 2.25.1

Looks good!  Thanks for persisting and addressing my concerns.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
