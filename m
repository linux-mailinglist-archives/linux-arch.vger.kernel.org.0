Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A537A6A72
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2019 15:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfICNwZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Sep 2019 09:52:25 -0400
Received: from mail-eopbgr760102.outbound.protection.outlook.com ([40.107.76.102]:62180
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728854AbfICNwZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Sep 2019 09:52:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4s8vLBw4QMslGZScDC9NbOHMBBRKjz4WEuj8vKAWuGCH46TyMBIcGFPCAgp7aw/7EvG3wXUincJQQYuZcU1vbGUGdF/duaEw46qVarpdyPyL07ugAsXs6NpiZ7e30jloT7H5SajwEMG/5DfJi1Rjg7/xNXsYsjB+xRjcylFe977+awwcX0kpbXqyk+V45OEofaq67mzysNJyeajwTetK+lVTyyN3/WJbFDrv2CSteg12rv2GQDABnRF+sStE7iknRV3oOfzGQMey+BNaZqDArtJFm0QLgEYItgyCSkoxY/lCniEfnDo1jTRMVXB/3yLB8E6Deqk91M56acVA++Czw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOaSNsAjqJZ7pDfuJuIYgxDqqsE1OPM6+taj+dBiaB0=;
 b=hthI+mDkEU+ACYQBnOs1s4YTmwO/94PyZujqfzFOSKFd5XMejuuPt2fPs70VmjfFUPHTonrQRrqqon5eeQAyXl5c//hepmAv/bhQrKVZyh58hf+ut9Q2pJLj29IxsRQrFnZye3DLrBz3GN4lWGHID2oA9dwFlhS/2Pp80KVLai6Lh0rEkTnd8V3m6CD0g6kKamsk+P7G/3pD80MvPufX5LpZ9myXk2tssgwZ7AtsxduGn/Z1tw6eXSnOeimRbjLE6MeU4n0jazkpaq9LcJcmOn7t1kTs08LTmkg9DTHLG8JP+WjdKNsiyESAk20XNqeKauNuPh7OJepKe+fS/ROIJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=mips.com;
 dkim=pass header.d=mips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOaSNsAjqJZ7pDfuJuIYgxDqqsE1OPM6+taj+dBiaB0=;
 b=TNwz2Xt2o5B3xaep7E1HEL7v+Emq0FVqz9XViVYKnDVmpGB0pfgxOZvjs1uGhs6pMT1Ebps2G21H8HNw3ehCytT0cBCyD1Upd7eP3oDQsWsemOaEysLpYRiv+Wil+5ny6VbZQhxcyvPy99CeOsuaNxxTQB59KmiXFSGD07y+VXI=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.172.60.12) by
 MWHPR2201MB1232.namprd22.prod.outlook.com (10.174.160.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Tue, 3 Sep 2019 13:52:19 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::f9e8:5e8c:7194:fad3]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::f9e8:5e8c:7194:fad3%11]) with mapi id 15.20.2220.021; Tue, 3 Sep 2019
 13:52:19 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "salyzyn@android.com" <salyzyn@android.com>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>
Subject: Re: [PATCH v2 3/8] mips: compat: vdso: Use legacy syscalls as
 fallback
Thread-Topic: [PATCH v2 3/8] mips: compat: vdso: Use legacy syscalls as
 fallback
Thread-Index: AQHVYl7NprE2FODnDUK5Ts14pqNdYA==
Date:   Tue, 3 Sep 2019 13:52:19 +0000
Message-ID: <20190903134335.uxxf5kvp3afe7rfr@pburton-laptop>
References: <20190830135902.20861-1-vincenzo.frascino@arm.com>
 <20190830135902.20861-4-vincenzo.frascino@arm.com>
In-Reply-To: <20190830135902.20861-4-vincenzo.frascino@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::33) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:18::12)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.196.167.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf3c4a5e-2f6c-4cb6-cd04-08d73075f02c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR2201MB1232;
x-ms-traffictypediagnostic: MWHPR2201MB1232:
x-microsoft-antispam-prvs: <MWHPR2201MB1232EA41CC0C6C4CB764F514C1B90@MWHPR2201MB1232.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(39840400004)(396003)(376002)(136003)(346002)(189003)(199004)(66556008)(7416002)(1076003)(25786009)(66946007)(4326008)(6506007)(305945005)(229853002)(6486002)(33716001)(5660300002)(6916009)(42882007)(55236004)(52116002)(7736002)(53936002)(386003)(102836004)(54906003)(58126008)(99286004)(26005)(186003)(478600001)(476003)(486006)(11346002)(316002)(76176011)(44832011)(8936002)(6512007)(6116002)(71190400001)(71200400001)(8676002)(2906002)(9686003)(14454004)(64756008)(66066001)(66476007)(6246003)(66446008)(81166006)(3846002)(446003)(6436002)(81156014)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1232;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IwcDt83UpZhML3wyHgvhHXTzVhD1PnHhkbQZOH/KFFFwaHGtDZtLP7M8jH/z92PG8gXbS4BwJ9gNw9K6Ca7RNmwLxn6mIZ5mcD2aNyG/JnQlLTc3M6CHAX6v9lOKPtyDMIa73K0y0QEBMqyIjQv3VJo7vQZBo3L0PGltzb5R1BvHmJHPYr/VgE1q3bo5agttMSlshAMorENeClGRlMLQcS4/YXcz5q4gKyAVvWJuXI60qJVOKSP2Kin6+px0A/cwW+KF94mdhSuNF5OKMJWs+3xVTA3vJJWMXMhIWU+XYl9Sx5FAs7+VH3L0qXFM3U1Jzi8M9HNlY5AgeYhZxCubXBZvZfwH0BeUW9YGDaw6vwkgXiDVePM+eV8pf2vCBztJqNB2MaIdOlIfx6R3hubaID6T1ImVyuYaqL4Yk9IU3cY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3823FA0127B0C948AAF60B176567B40D@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3c4a5e-2f6c-4cb6-cd04-08d73075f02c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 13:52:19.6498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M4/IykoGagHyxGv2VUVnxWxZ5rQmAUdZtgi0EnCy/4RtFEzhcTUg8AFDUB/Mtzf525pHdUutGW+OVqdKOMXnDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1232
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Vincenzo,

On Fri, Aug 30, 2019 at 02:58:57PM +0100, Vincenzo Frascino wrote:
> The generic VDSO implementation uses the Y2038 safe clock_gettime64() and
> clock_getres_time64() syscalls as fallback for 32bit VDSO. This breaks
> seccomp setups because these syscalls might be not (yet) allowed.
>=20
> Implement the 32bit variants which use the legacy syscalls and select the
> variant in the core library.
>=20
> The 64bit time variants are not removed because they are required for the
> time64 based vdso accessors.
>=20
> Cc: Paul Burton <paul.burton@mips.com>
> Fixes: 00b26474c2f1 ("lib/vdso: Provide generic VDSO implementation")
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

How would you like this to be applied? I'd be happy to apply this one to
mips-next, where commit 24640f233b46 ("mips: Add support for generic
vDSO") added the file being modified here. Otherwise:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

> ---
>  arch/mips/include/asm/vdso/gettimeofday.h | 45 +++++++++++++++++++++++
>  arch/mips/vdso/config-n32-o32-env.c       |  1 +
>  2 files changed, 46 insertions(+)
>=20
> diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/includ=
e/asm/vdso/gettimeofday.h
> index c59fe08b0347..e78462e8ca2e 100644
> --- a/arch/mips/include/asm/vdso/gettimeofday.h
> +++ b/arch/mips/include/asm/vdso/gettimeofday.h
> @@ -105,6 +105,51 @@ static __always_inline int clock_getres_fallback(
>  	return error ? -ret : ret;
>  }
> =20
> +#if _MIPS_SIM !=3D _MIPS_SIM_ABI64
> +
> +#define VDSO_HAS_32BIT_FALLBACK	1
> +
> +static __always_inline long clock_gettime32_fallback(
> +					clockid_t _clkid,
> +					struct old_timespec32 *_ts)
> +{
> +	register struct old_timespec32 *ts asm("a1") =3D _ts;
> +	register clockid_t clkid asm("a0") =3D _clkid;
> +	register long ret asm("v0");
> +	register long nr asm("v0") =3D __NR_clock_gettime;
> +	register long error asm("a3");
> +
> +	asm volatile(
> +	"       syscall\n"
> +	: "=3Dr" (ret), "=3Dr" (error)
> +	: "r" (clkid), "r" (ts), "r" (nr)
> +	: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
> +	  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
> +
> +	return error ? -ret : ret;
> +}
> +
> +static __always_inline int clock_getres32_fallback(
> +					clockid_t _clkid,
> +					struct old_timespec32 *_ts)
> +{
> +	register struct old_timespec32 *ts asm("a1") =3D _ts;
> +	register clockid_t clkid asm("a0") =3D _clkid;
> +	register long ret asm("v0");
> +	register long nr asm("v0") =3D __NR_clock_getres;
> +	register long error asm("a3");
> +
> +	asm volatile(
> +	"       syscall\n"
> +	: "=3Dr" (ret), "=3Dr" (error)
> +	: "r" (clkid), "r" (ts), "r" (nr)
> +	: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
> +	  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
> +
> +	return error ? -ret : ret;
> +}
> +#endif
> +
>  #ifdef CONFIG_CSRC_R4K
> =20
>  static __always_inline u64 read_r4k_count(void)
> diff --git a/arch/mips/vdso/config-n32-o32-env.c b/arch/mips/vdso/config-=
n32-o32-env.c
> index 7f8d957abd4a..0011a632aef2 100644
> --- a/arch/mips/vdso/config-n32-o32-env.c
> +++ b/arch/mips/vdso/config-n32-o32-env.c
> @@ -10,6 +10,7 @@
>   */
>  #undef CONFIG_64BIT
> =20
> +#define BUILD_VDSO32
>  #define CONFIG_32BIT 1
>  #define CONFIG_GENERIC_ATOMIC64 1
>  #define BUILD_VDSO32_64
> --=20
> 2.23.0
>=20
