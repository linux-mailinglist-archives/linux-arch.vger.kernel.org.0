Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEBA6591DD
	for <lists+linux-arch@lfdr.de>; Thu, 29 Dec 2022 21:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiL2U5I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Dec 2022 15:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiL2U5H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Dec 2022 15:57:07 -0500
Received: from CY4PR02CU007-vft-obe.outbound.protection.outlook.com (mail-westcentralusazon11021027.outbound.protection.outlook.com [40.93.199.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86695B1FD;
        Thu, 29 Dec 2022 12:57:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QV5pXjyAKk76/qzgQCqH7a95+kzaGWKCk3UINIXEOcZ7eVRVXJVAVppi1AqKaazV1QGBEnbt0V5sif/+luPgudczVzCOW0nb5zbTij624pT3lO2nZg9iBr5MvznI4jfADp4Dp+WQ2PVgvUEELayUsX088lOpOv16tnUQrLGtpN167YjFfK3mYZMRBdSN6MdGYnWEu/QLHoAztgw7OAUACvhEN48iorDhcwMArgCOPHJxnTX0U6rIQPSCbBKna+F4lmkLsYOe4xxkxA9b+xoKSxe87XA6ZX5pBnsFLiRUaDfEj2SyzYiOfrJtaaO0JChzjZ9wFh6XO4TsVdQAZaUKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UEbUXEvDR6UNPz9/BlptzknXjXm45s47Hz+GlAaXaw=;
 b=d3dY9On0pdwH5ZVMY3B74nEgbbJA9dU/IsXfCQEo5ONmgaDOLUjI5t7hBzy/UBLEZL40GngE0o1CctoKL07bsiLl3kY4PCuw5e6LqcCofi12/EqPF6xT4PQBDrw3ldsaA2CrtrBq+XKOi5U/yuGQLZjk47cNjuj1T8XyUTRc3V66EVcYuhN0+VWzO2WeVpgizYLQaWkunSgm1qVDiW2nlWiBKW8JOaRJJIKRKNPirh+2FbvseDg3W+vbYVCraDCsomtw+ujSJehuT377iAAmPGVnjUwl71bCww4h7xQTYizeDOdO/Bqu8R/IBZNuYoa+31DckZ/MlSvnZXhSNtsJ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UEbUXEvDR6UNPz9/BlptzknXjXm45s47Hz+GlAaXaw=;
 b=PIPkVpPu1tmhZ32XXUpDKScFIuS5myFf9rWYobsCFiZogecGqDy6o2vhU0bg4ZxVTkRrFeggMQddE3I3BnN9fY82qXtn71gHNT+59WKjGkqU4Z2dyRhN6uVQbnM6G9K2glZDuh3BiHDd97G29FtWGjiHr/NdpMfcBOohDatHk7g=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH7PR21MB3897.namprd21.prod.outlook.com (2603:10b6:510:24b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.6; Thu, 29 Dec
 2022 20:57:03 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::db1a:4e71:c688:b7b1]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::db1a:4e71:c688:b7b1%7]) with mapi id 15.20.5986.007; Thu, 29 Dec 2022
 20:57:03 +0000
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
Subject: RE: [PATCH v9 2/5] Drivers: hv: Setup synic registers in case of
 nested root partition
Thread-Topic: [PATCH v9 2/5] Drivers: hv: Setup synic registers in case of
 nested root partition
Thread-Index: AQHZD4X3xn/bwiu050KbrFPtb4de466Fa/bg
Date:   Thu, 29 Dec 2022 20:57:03 +0000
Message-ID: <BYAPR21MB1688A97F70DBF8BECE92FB7CD7F39@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1670749201.git.jinankjain@linux.microsoft.com>
 <ba13c6e6be30220b18e576578356ff4b6d041381.1670749201.git.jinankjain@linux.microsoft.com>
In-Reply-To: <ba13c6e6be30220b18e576578356ff4b6d041381.1670749201.git.jinankjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a4a8b576-48de-4e49-914f-6f0f55815c68;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-29T20:38:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH7PR21MB3897:EE_
x-ms-office365-filtering-correlation-id: 463578fc-40e7-42a4-58c6-08dae9df3ca2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u252oVdW7HnntDtIZ4ZmU7I5OD5eg99DYk6NpL1AD8GouBUaUoMR5QawS9SZw93oLxFQC/DBcrkT9NZj1rAI69kyyWfbTOZlFqqapKgyiyf+0Cg1dz8vMVgLAt4Q0Hct9yeKaGaDXeKc4UQqulLaIafQiFhuXUZ5TZjBquMSD+S6STWjokIznNd75+XzAw84fiGyMBi7/mfpLyPWaWWCgNWgalZpWEbGFbPwxbxa69is7i5yaBzob6jFOtRGCIWs/TxOkfj0QZzcxO5RJCk6bi1JXTDmkMbuAhVxREOoEYsP5w6EhbRBjRx07o4F8pH09ZlU7XYMJNoI3kGfDpfeEyQ3Jyqyx1K2caMwUoRYinon/mgDsAnyyUd2+fv9vU/i+rd9i+o3qtw4jdpXxesc9UyNjKledoVWxYSaQ6SwvFXtBZsTuV/x0GS2I86PsgySSGY5YnPlApmj+Ff5J744nOdDMSJv7WD9gALsG5MUBFWpPYycgbRaZQ6xJMV+eCtu8iZWqOYio4HktQZFYuHg1I4RgfLUNJUt76BJ8w9h7+93MlJz53TbwC6V2j8W/MNNfEeh8BDs4ohXPf7VyM3iWX2gEAtumgJpNq9B287MZkFen6PXVqcuEY+pccv/h4K5Ik+J8d815atIntDLKriyggDtiiSnmvlGisfBzVccTAJx66RqQ4YtDeCBk6PZ6I5NjUhs3czbO15pFC1WC0qE/uG5p7QRA9QGHVJjElFdI63Ru5/ihqO3PQdLGrMirBra
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199015)(86362001)(55016003)(26005)(33656002)(8990500004)(478600001)(10290500003)(7696005)(71200400001)(186003)(9686003)(107886003)(4326008)(6506007)(7416002)(66476007)(66556008)(64756008)(66446008)(8676002)(76116006)(5660300002)(66946007)(8936002)(41300700001)(2906002)(54906003)(6636002)(52536014)(110136005)(316002)(122000001)(38070700005)(38100700002)(82960400001)(82950400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fCsZ3fzEDehUnxlL0BIZQPPhigcHPl0BBGLBMBv0WEcNlo1xuYcHaFnEbZbW?=
 =?us-ascii?Q?yNRtPt4Io3EdJ46FbFMt4CuTW4sFfuwx3n0zIrsl9vT+BohksOKa9m2wHRGf?=
 =?us-ascii?Q?1RvXNcylH9pkTBIvJQe0RBGMpH7nh8v7whQUsZftqB5WHMQ/O+yvM2AIgURL?=
 =?us-ascii?Q?w24OqIx6le36hxim47cDUAwZUAKUDq011zCE0EIYAGi69BpxpGZumNIiQMgM?=
 =?us-ascii?Q?h3jcDZGvqaaaiZrdqafcsG80ygShpW0W1jkVzUq1zOjluiWrg+/AEn9hKaRW?=
 =?us-ascii?Q?YPg0y9P4srlXPuB1+k1mNzawO3fCOFZfdcbMQEBNqjvGm0vb9V8Mdn7n4xii?=
 =?us-ascii?Q?hl+xVjjgubUaToW7Vrt+fndUk93eUF9f0vCqA/6DpLF2QUeexVh2WvedIOL/?=
 =?us-ascii?Q?rOWrEzMXiky1c0csoJaoYOhjG0K/FLv1+mp/vBX11JxbGUekFi3yn45b2oBm?=
 =?us-ascii?Q?OU6+lObo6RArMr5f5IAq81qDoO2WfuPL8wFwwINkEZKNQBfAfKQVGG3lxmXN?=
 =?us-ascii?Q?gztlXMWtfBSoLUGOkHLODS52SejT/M9eJL12oHf5XYN3I5uooCRWQg7r45w5?=
 =?us-ascii?Q?zgBX9bWqWFZVLapwK8y4omVr3KrOQ8pH/UbmSRf848naS68/xzQaeSrBIzj6?=
 =?us-ascii?Q?keYhicaIVd8HkeTQsY9zDyUA2d+bfFIoG6OUezh5fC7ngH3DNG6BuNIB+qGv?=
 =?us-ascii?Q?bSBW3Z4M1aL77Hh64bRWPT9hofMHva3Mqpapwbx7Z6F3epdnpWlcYTs/t01R?=
 =?us-ascii?Q?nt3PWbo3EUjRZkrQZqi+CjhJPEu7opcG9lIfDgskl5V7WZAhsfZwufAJaT96?=
 =?us-ascii?Q?aDVHQMb3cs6FdDzywej1/ZBy4/6/PnRn4VsYjBVOkL0EZPK5LL8bGN5AK0Mi?=
 =?us-ascii?Q?9G40T0Cu7QmL9S8QTG7zvv+zSTORSIjhMlYIHkifejFxMl2MnhYsMdS2DQy4?=
 =?us-ascii?Q?Y2ZbarTcZT6eMR/k7yYs3b5nmUB9OS3HJS6FhCXLHHNvAMY5qHUuup24hrVF?=
 =?us-ascii?Q?lUAgVocl82Vh6RhbEgPl6XYnz15gnigMcPp/LlQ5SmAwgb6/9KXx3QQyBE1c?=
 =?us-ascii?Q?ISUQ3UkpRNUIAgCsr5r96kNH736QNl0WEbUdH77HsdxT7gHD4dTrOQk5HQVu?=
 =?us-ascii?Q?B6ysJCTC99+K79+ecdFilcqoz5gkvHctj58WBWn5iyDQtm2rliLqQmUf/4ye?=
 =?us-ascii?Q?t5tjs1wOq1thdNugvd9K7GU9Roidgw5iIvcdGv2jmqGdIEsk5AlHQNCwfJ7F?=
 =?us-ascii?Q?t5VqoqcyycZtPgx7RpDOG2PPl1vt44ZsHEfNkFGD2TYD8l0nK0SeY0avXyEt?=
 =?us-ascii?Q?n6iZfgDMlQUOv8qUSIbuZG9Mo6I7Z5H91W6wnw7P+UrEZliSa7GmLtif0ZFi?=
 =?us-ascii?Q?6CnMYUrBXS2r3RXIWmzsv+O/iqE0KYlrXoRCMokEVaRkGhjI2ZE4dQmGarDV?=
 =?us-ascii?Q?qQdRQYEXRbCmGJW8uKsB524G1VXOv0xCUA3IoKkradElLCKwfkQzS3TW7YvF?=
 =?us-ascii?Q?hE5wt2EioTgLXHtcGSaCuCJVlKF4j7Um6MwD1fDpi5dfMjUC1AMRI8BBLpFe?=
 =?us-ascii?Q?Dloxl/5jFzwukRLZRocT6h+SYmAXaDZ7J3BSDbOgG8ExL/OvG1eRxyJVery7?=
 =?us-ascii?Q?Ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 463578fc-40e7-42a4-58c6-08dae9df3ca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2022 20:57:03.0441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i04+5bzMV2NJ54zBls0vcR3YMxn3Cxq+EFU4XZ/yvQsmQRczrELBMpsx/ImZMax5so2L3x487tSWxUXt51nmvKf5QahOa1UnDdEKUfJw1rE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3897
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jinank Jain <jinankjain@linux.microsoft.com> Sent: Tuesday, December =
13, 2022 10:33 PM
>=20
> Child partitions are free to allocate SynIC message and event page but in
> case of root partition it must use the pages allocated by Microsoft
> Hypervisor (MSHV). Base address for these pages can be found using
> synthetic MSRs exposed by MSHV. There is a slight difference in those MSR=
s
> for nested vs non-nested root partition.
>=20
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>

You have addressed all my previous comments and those areas
look good.  But I see a new issue that I had not noticed before.
See comment below.

> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 11 +++++
>  arch/x86/include/asm/mshyperv.h    | 30 +++-----------
>  arch/x86/kernel/cpu/mshyperv.c     | 65 ++++++++++++++++++++++++++++++
>  drivers/hv/hv.c                    | 19 ++++++---
>  4 files changed, 96 insertions(+), 29 deletions(-)
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
> index 4d6480d57546..986814a903ee 100644
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

These memunmap() calls seem to be done in the wrong place.  There are two
pairs of functions that should be symmetrical unless there's a really good
reason otherwise:

1. hv_synic_alloc() and hv_synic_free()
2. hv_synic_enable_regs() and hv_synic_disable_regs()

The functions in #1 handle the allocation and freeing of these three
pages: synic_event_page, synic_message_page, and post_msg_page.
If the synic_event_page and synic_message_page don't need to be
allocated because they are provided by the hypervisor or paravisor,
then the allocation is skipped in hv_synic_alloc(), and the free_page
operations in hv_synic_free() are no-ops if the corresponding pointer
is NULL.

The functions in #2 should handle the mapping and unmapping in the
case of pages provided by the hypervisor or paravisor.   It appears
that the hv_isolation_type_snp() case does this (mostly) correctly.
But your code does the unmap in hv_synic_free(), which isn't
symmetrical.  Unless there's something unique about the situation
when running in the root partition, the unmap should be done in
hv_synic_disable_regs() like it is for the SNP case.

My "mostly" correctly comment above is because the current code
in hv_synic_disable_regs() should be setting hv_cpu->synic_message_page
and hv_cpu->synic_event_page to NULL after the unmap is done.
Those pointers must be reverted to NULL so that if hv_synic_free() is
then run, it won't try to free pages that were provided by the hypervisor
or paravisor.

Michael

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
> --
> 2.25.1

