Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CCA648806
	for <lists+linux-arch@lfdr.de>; Fri,  9 Dec 2022 18:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiLIR4m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Dec 2022 12:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiLIR4l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Dec 2022 12:56:41 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2095.outbound.protection.outlook.com [40.107.94.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C05122296;
        Fri,  9 Dec 2022 09:56:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7ptky4nUenNNzRF57jHxkSV+IP5RaUqBRwaaPjjHU5AdbUqA8ctl/6XAOhNFnh3sY0Mx557+KsLwQqaTV8pwSO4dtUcpcnlu42+fEXuqprdxkRLpvs8lFLb4Gk9u4Uz1hKLzQ4liggixRU6Ao+5vfDY4ML8U8o0Wz+XjfmYZxPEwlOiQ3X44eiAHOBiXivEeX2x+mVwpjJzMxui25h+wZsuRJlqzK5GTHAFwxAOltmZ6MaCiKmw/Vbz126mbt76rvqKB+UMyCU3l1BmZ54r4HeCacIuziiqWxDzEQjJmNoZXarcGHll/YBhqyn8IBYN3APSbHUTiNv8zNC4scwnBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+FlZCquWGOqtVKcmYZ7ae0PZsu7oPkd4e+8NTq0Pkk=;
 b=U1OYVJg/KWA2gkbfo2i87faDXg7LeQ7VdWSybqZt0mzqyrzTRabQxGe4l3yrTO8axkEgzPxfGootYadIKyec1oDayG7s0jNroi9p8l2+tL59RS3mIyXfOm+1o2eEy4zqIpEq7O9ru350PJn8RjF0CDGmhmTAarg0OHxMwpI0HSlnv3WC7yzNzLAaNMV4v9qVohkGZkh4cUXdoPx7eEq9dJ1u2h4I7FwIPlgLRw7nHNws4Yh4IyptRO04vnk9th2R7pesYAtdtbJ5wieoUvmwRRXhB5D8QYv2MsmeFfEEqcn743VGvZjE/bYP1cNx3RKXcS0d32fU7MT8yxdnahN/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+FlZCquWGOqtVKcmYZ7ae0PZsu7oPkd4e+8NTq0Pkk=;
 b=gIM38vV6pKyPi34gk5bTJOJFR2UA/bd+uKlIJi3eggdr7lN5anYiPBbC3/gFSA+OHO7h0rfWOzfniW9WX25tMSbGjEYa4cVFi0HSI0ZI8cVN6SjVOIN8/naWalKH2nLpR+PULKTESoOpZYRD0G9KJn/AAaSxPlEcHGqd3W90VzE=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.4; Fri, 9 Dec
 2022 17:56:35 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%5]) with mapi id 15.20.5924.004; Fri, 9 Dec 2022
 17:56:35 +0000
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
Subject: RE: [PATCH v8 2/5] Drivers: hv: Setup synic registers in case of
 nested root partition
Thread-Topic: [PATCH v8 2/5] Drivers: hv: Setup synic registers in case of
 nested root partition
Thread-Index: AQHZC4+wa+5FZueAE0+b/KaDIWYs065l1Dqg
Date:   Fri, 9 Dec 2022 17:56:34 +0000
Message-ID: <BYAPR21MB1688B8F2C619A1BB29AA0DBCD71C9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1670561320.git.jinankjain@linux.microsoft.com>
 <9a6bcedcc7dab00982eae5c8b2622b46ee27d07e.1670561320.git.jinankjain@linux.microsoft.com>
In-Reply-To: <9a6bcedcc7dab00982eae5c8b2622b46ee27d07e.1670561320.git.jinankjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b452afbe-d44c-4c54-9677-b397e991b753;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-09T17:42:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BY5PR21MB1506:EE_
x-ms-office365-filtering-correlation-id: 1e7744a1-1c03-4530-f159-08dada0eb64c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pnyVjc4rkQGWa0IdBib1TP21S/SIq578ct4FaynyjqLMrYlVKLEA1wJ/DMR+6gcd4mww1RaeF/QYsqEKykZ+KB/mUtM7dMlMGRZaJhfcajjXFdGTT+FITJR4/JqOAv1k1jGx4alIAsznSW5WDP0NXg8WBMcRT0DnQxr0RXuRi2GJ3XKjfRRnpZaPu1iH0bGO+UhqQr73BqUrU6d1csiAnv92ZtHwZXwOst5rOyZfP88wFsZ5ngDnDs7ADmX71aRAlG3wRJy9v+DWAIjj9cGQrcpDjVCwo2VNsSswtTFCBvhs09td1I1M07aW06p6Bk6MCkx6SNT3Qtepq3kfH4zlvcSs8troFGtfPsxk7GQOgKlDgqJoLZ46MBiJNBX2pSyluL7K3govVOiCgE7kx867d2oSrKhruTnBGx3XMaSNYXnpjal+Cnh6Z3nDkZoGPquGOqLmdwrvPFz4NKAvzrzK1xTY47vQUX6odkpdwXRiMav0rNKjW3EcoOwyxjtsF88bup4oe7d4Yq+VocdQeNa3jZLWW4heGWo3M9845Kfetp+g313l00YcypTdnwbUL/kzbN3bgw8DsI89rMr3pdG3wau07daVslqrl+fQVUpm5MqfzFXqCnIOp13Az5EAy8gaY+tDD4nsXhZAkS11syvwC+PW5lYVheV7+aedkISeBSZa2K5e1M2DrKWPN8jMAwBmRgOFUp2YZXJz5KgEgDV+eaKFNGc9Onk97UrKy6j7laAEPDMax+hI/XBPUUa1Dxxk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199015)(64756008)(82950400001)(82960400001)(52536014)(38100700002)(122000001)(41300700001)(110136005)(66946007)(478600001)(66446008)(2906002)(7416002)(83380400001)(8990500004)(71200400001)(86362001)(10290500003)(186003)(8676002)(55016003)(5660300002)(9686003)(26005)(107886003)(6506007)(7696005)(8936002)(33656002)(4326008)(316002)(66476007)(38070700005)(76116006)(6636002)(54906003)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0zQWK/M3hmh83mWj01eEV/+qyWBqQRggvK9HjAeZYe4lGqDJ3fp3sItcxgaS?=
 =?us-ascii?Q?p4U54xmq0hfg30C8P4IXIScN/SMyLZ3tHjqkUNeERF+9ecIqnawK5UXcN9IJ?=
 =?us-ascii?Q?ys1+7jVgdBZX8SMEpLeP6oqC5iJJ1FEVef31jb6q70h/EOUegccv2EKeRPFM?=
 =?us-ascii?Q?wGzy+qhc5n5qrqoBywkifW4IaBapAXywzBFFVhz88i/DQZaNj1oQwdcBmUEF?=
 =?us-ascii?Q?cnqlxhP4jdFtrjnUcww6PcxbGkPwQ+Xjoqdrtiwc6piH+cI8OEf61+uIq4Fy?=
 =?us-ascii?Q?ekojb5roKlC8/ScweDB0EqvgSG7gXrvxI/rjXh1JdeKWkHt3hRLsT+HSIcRP?=
 =?us-ascii?Q?pyUO/rltfsVON5SWhsD15gbfxc1O/o50Wkdj+ju1V0Hdhs6vS/Q0itd8ycnF?=
 =?us-ascii?Q?IcHFVOQzzWi6tSSVasduAaeFZLa7UGu6BZEkcfs5TcgQt7bqVMew/Trqt26z?=
 =?us-ascii?Q?QpiRKEuj+kj0byCAAYrb7J88rkZ0mF6l+Vj6i5Up1lykjE5zcptCVLnyAEws?=
 =?us-ascii?Q?6bXsfwBBfKtS+3sB5liaUPklbGqrFeQTU345G96aD04O9A2sqEh2sZjlpDK1?=
 =?us-ascii?Q?BUuK+k+02FdwIrKB80csF2dP5kxhYln2NoJmyzDJCgIx7fMuDBTdoQoXzKVZ?=
 =?us-ascii?Q?KBDsOYqTiHocw3xl5fB8XqBUgCX6M39DjKFKkm1tKowVfbW0r6+So4ZEpqv1?=
 =?us-ascii?Q?AZXw0j24sCVj2qpRa4MQwgHQrQoP0duMImIBvl++IhHhUW4/Kzr8pXd2VQf1?=
 =?us-ascii?Q?8dk+vOXOHhPpbbW1p0xF6BxJx3qEyd6JnJVQ5sPbjATcMsEp762nFqA5Sf6f?=
 =?us-ascii?Q?SqTFW+vAU95ZEN4jFrcoBoWL4MkfbPxM89QvNvUtHvGqrg4iyoObb7hFvGFj?=
 =?us-ascii?Q?arW+Weed3JgaYDpzOWraeVwFP52PywqJcY8xagbb5RfD4z/+Xto/sMX0dYUI?=
 =?us-ascii?Q?WmfIMTovHRLJ3HjGIDX3wl2+h5G3+RlGq1VcMXOAnpAqnYWZfjKrPZclP9Xf?=
 =?us-ascii?Q?akcRRtpp2tMPejgJ6zuNzTmQdbyA0qvltxhErKZyTrMZUaT5R7h0oafyaMiX?=
 =?us-ascii?Q?TipfClhjLps2pW202r4GDC67PrEYGL2T3kBfi8CBiWelUXYlIGqhahFsy8Bo?=
 =?us-ascii?Q?rzxi8avGT6uSvkSyZ7Ipq8PC8Z/BK6UHfBbakq96yldQ8ZyUd+NyYUakq2z0?=
 =?us-ascii?Q?PukS7EAxUy+R0/9YWgMxkESvifQ9YSWmiMP3IqzE77dXZJOtEysw/D2LTs3+?=
 =?us-ascii?Q?R2YdAk8J9WC5HxfuxdMDZJ44bzK4Vezey/l3bPkbgsyePjURaoeiErDhBpfG?=
 =?us-ascii?Q?uq9sdskf26ZOJBdeRkEKrDFoqXsqq6Xp6ISReDs1P0EIeIS4AojnaX4HWPWH?=
 =?us-ascii?Q?rPi3XrzahFslvEJj9UAEq3y9BamAr74/HjMOp8ZJoWHuTzjgTX1o7Q/TCBE4?=
 =?us-ascii?Q?a6f/ndMBjYUZ3SOjLnKuFxjsje2Vu8oyhtBtoWzvDVXiIv35pr4QYZ42zLtG?=
 =?us-ascii?Q?kkRAszKNnZ3SZmRgU6w11oEuE+8dJVoQNPxayKxXAhEzmiBQEpK4T1dr3gzG?=
 =?us-ascii?Q?u/M8Xdctsofu0h4Dz8yEVt/hC0mXOL/8M7yFWjpdcpiz3CQv+fm/r7B/sBWB?=
 =?us-ascii?Q?Zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7744a1-1c03-4530-f159-08dada0eb64c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 17:56:34.8927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5s4kVoKazQO+LO3qx0fM7Pu4oxgKBfUE/6XISPmoIzO5Bcp3ainvWe5kltJb/3KAMKxxjPutbju6ZtSjml40e2TDoFboF2bPjKXV5OlQTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1506
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jinank Jain <jinankjain@linux.microsoft.com> Sent: Thursday, December=
 8, 2022 9:32 PM
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
>  arch/x86/include/asm/hyperv-tlfs.h | 11 ++++++
>  arch/x86/include/asm/mshyperv.h    | 30 +++------------
>  arch/x86/kernel/cpu/mshyperv.c     | 61 ++++++++++++++++++++++++++++++
>  drivers/hv/hv.c                    | 32 ++++++++++------
>  4 files changed, 99 insertions(+), 35 deletions(-)
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
> index f9b78d4829e3..47ffec5de9b8 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -41,7 +41,68 @@ bool hv_root_partition;
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
> +
> +u64 hv_get_register(unsigned int reg)
> +{
> +	if (hv_nested)
> +		reg =3D hv_get_nested_reg(reg);
> +
> +	return hv_get_non_nested_register(reg);
> +}
> +
> +void hv_set_register(unsigned int reg, u64 value)
> +{
> +	if (hv_nested)
> +		reg =3D hv_get_nested_reg(reg);
> +
> +	hv_set_non_nested_register(reg, value);
> +}
> +

This refactoring looks good.  But there's still one tweak needed.
These four functions must be marked as exported because they
are used in code in drivers/hv that is part of the Hyper-V module.
If CONFIG_HYPERV=3Dm, you'll get a link error if these functions
aren't exported.  By "exported", I mean adding

EXPORT_SYMBOL_GPL(<func_name>);

after each of the above four functions.  A good test is to build
with CONFIG_HYPERV=3Dm instead of CONFIG_HYPERV=3Dy.

>  static void (*vmbus_handler)(void);
>  static void (*hv_stimer0_handler)(void);
>  static void (*hv_kexec_handler)(void);
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 4d6480d57546..a422cb7b18d3 100644
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
> @@ -188,8 +188,16 @@ void hv_synic_free(void)
>  		struct hv_per_cpu_context *hv_cpu
>  			=3D per_cpu_ptr(hv_context.cpu_context, cpu);
>=20
> -		free_page((unsigned long)hv_cpu->synic_event_page);
> -		free_page((unsigned long)hv_cpu->synic_message_page);
> +		if (hv_root_partition) {
> +			if (hv_cpu->synic_event_page !=3D NULL)
> +				memunmap(hv_cpu->synic_event_page);
> +
> +			if (hv_cpu->synic_message_page !=3D NULL)
> +				memunmap(hv_cpu->synic_message_page);
> +		} else {
> +			free_page((unsigned long)hv_cpu->synic_event_page);
> +			free_page((unsigned long)hv_cpu->synic_message_page);
> +		}
>  		free_page((unsigned long)hv_cpu->post_msg_page);
>  	}
>=20
> @@ -214,9 +222,10 @@ void hv_synic_enable_regs(unsigned int cpu)
>=20
>  	/* Setup the Synic's message page */
>  	simp.as_uint64 =3D hv_get_register(HV_REGISTER_SIMP);
> +

This additional blank line is a spurious/gratuitous whitespace change, whic=
h
should be avoided.  Especially when a patch has gone through several revisi=
ons,
it's likely that you'll end up with some whitespace changes like this.  But=
 it's
important to go back and remove them so that the patch isn't cluttered with
changes that don't add any value.  Such gratuitous changes make it harder
to review the patch, and are unnecessary code churn.


>  	simp.simp_enabled =3D 1;
>=20
> -	if (hv_isolation_type_snp()) {
> +	if (hv_isolation_type_snp() || hv_root_partition) {
>  		hv_cpu->synic_message_page
>  			=3D memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
>  				   HV_HYP_PAGE_SIZE, MEMREMAP_WB);
> @@ -233,7 +242,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	siefp.as_uint64 =3D hv_get_register(HV_REGISTER_SIEFP);
>  	siefp.siefp_enabled =3D 1;
>=20
> -	if (hv_isolation_type_snp()) {
> +	if (hv_isolation_type_snp() || hv_root_partition) {
>  		hv_cpu->synic_event_page =3D
>  			memremap(siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT,
>  				 HV_HYP_PAGE_SIZE, MEMREMAP_WB);
> @@ -250,8 +259,8 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	/* Setup the shared SINT. */
>  	if (vmbus_irq !=3D -1)
>  		enable_percpu_irq(vmbus_irq, 0);
> -	shared_sint.as_uint64 =3D hv_get_register(HV_REGISTER_SINT0 +
> -					VMBUS_MESSAGE_SINT);
> +	shared_sint.as_uint64 =3D
> +		hv_get_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT);

The above change, and all the changes from here down in this patch, are
spurious/gratuitous whitespace changes that should be removed.  Go back
to the original code and formatting.  Doing so will make the patch a lot
shorter. :-)

Michael

>=20
>  	shared_sint.vector =3D vmbus_interrupt;
>  	shared_sint.masked =3D false;
> @@ -267,7 +276,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	shared_sint.auto_eoi =3D 0;
>  #endif
>  	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
> -				shared_sint.as_uint64);
> +			shared_sint.as_uint64);
>=20
>  	/* Enable the global synic bit */
>  	sctrl.as_uint64 =3D hv_get_register(HV_REGISTER_SCONTROL);
> @@ -297,15 +306,15 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	union hv_synic_siefp siefp;
>  	union hv_synic_scontrol sctrl;
>=20
> -	shared_sint.as_uint64 =3D hv_get_register(HV_REGISTER_SINT0 +
> -					VMBUS_MESSAGE_SINT);
> +	shared_sint.as_uint64 =3D
> +		hv_get_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT);
>=20
>  	shared_sint.masked =3D 1;
>=20
>  	/* Need to correctly cleanup in the case of SMP!!! */
>  	/* Disable the interrupt */
>  	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
> -				shared_sint.as_uint64);
> +			shared_sint.as_uint64);
>=20
>  	simp.as_uint64 =3D hv_get_register(HV_REGISTER_SIMP);
>  	/*
> @@ -335,6 +344,7 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	/* Disable the global synic bit */
>  	sctrl.as_uint64 =3D hv_get_register(HV_REGISTER_SCONTROL);
>  	sctrl.enable =3D 0;
> +
>  	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
>=20
>  	if (vmbus_irq !=3D -1)
> --
> 2.25.1

