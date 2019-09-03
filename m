Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6770A6BC6
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2019 16:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfICOqw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Sep 2019 10:46:52 -0400
Received: from mail-eopbgr810109.outbound.protection.outlook.com ([40.107.81.109]:14213
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727624AbfICOqw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Sep 2019 10:46:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+3+AvajZl5hRcEmSt0MWtuQAgDxpGKyk6NrgEknGMQy8zbnLSp437vJhxmWqAORjyFIl4e7hBDrlbvhn1EUntzh3hbg6xYeRXH/zwG7ZErVkgfSwbJHaF28SA5l7Sl0R9RRnLUr8boFSN5w4UFtQNhf24xLMDwr6mAw7y5E5P9VJ27FPICPcEuE2S/c8ng9E0tD2LsS0vSDZtkutMD3JoVwroZ0HI4hMidg0qy9dGfdzPkat0Ze7HFLqFmZXzDBFUgwcDiZRRIazrCJIg2cIZ1sC9/Cn3udoUxD/OCk9X6Gc1r0mq7HYUykwALuM3e70F/cgSqd5LVD5Adj7VmUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2dtdEHJXcN9+WtdTUFqQ0eyc4qTJl5/hCb1fiKQ5rs=;
 b=mQM9eWWfSX4RN9KZ56Inznc7MLfAjHqsk6i4DyaTAHmYM0WUF7puZGarYMdl76pTJgXAdD5XvIMBl5jimQpuE97EWYWy+ajwIRuvCGoHyYYEB8+6JtmkOuASARHzEtMP3ylPEmStbfNFz6aHV/7fcQIKT/IwEflFwfekRck6V6faZdkCHnWnQc24M9DiYlCMKAnily+X15gQN7SuGeFFHmaWWbfGPuj1H6H05Je4D/Fh76yPSZjCYHpzeeArXyx9Go54ww+Y/7lqLd6ehbW7KyzZqWBoYrA5JXelGQ+SpOmtlIcQtwR1cs80GmtosjcXUMBs80JxZY1lOvtzPrpeVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=mips.com;
 dkim=pass header.d=mips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2dtdEHJXcN9+WtdTUFqQ0eyc4qTJl5/hCb1fiKQ5rs=;
 b=MawT0w1UEc5RXPrt7VRsbpCfbifKXOwiIsw3nE7xiEnFqXD5ezYrZVrhNxPQTX3SI7qGvxg+q2kf9/fgOerslb4dPWkJCKw6wOkQIvRgEGfsSzQptY1h2D8PJBbyb44DZlc085Tv3qp0rCB0tgQ+d70QppJSiBJ3kQt2qqs8v8s=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.172.60.12) by
 MWHPR2201MB1038.namprd22.prod.outlook.com (10.174.167.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.13; Tue, 3 Sep 2019 14:46:46 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::f9e8:5e8c:7194:fad3]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::f9e8:5e8c:7194:fad3%11]) with mapi id 15.20.2220.021; Tue, 3 Sep 2019
 14:46:46 +0000
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
Subject: Re: [PATCH v2 7/8] mips: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK
Thread-Topic: [PATCH v2 7/8] mips: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK
Thread-Index: AQHVYmZolDG5W8Ccs0Osntbpyln8KA==
Date:   Tue, 3 Sep 2019 14:46:45 +0000
Message-ID: <20190903143801.7upetfqe6upouzlh@pburton-laptop>
References: <20190830135902.20861-1-vincenzo.frascino@arm.com>
 <20190830135902.20861-8-vincenzo.frascino@arm.com>
In-Reply-To: <20190830135902.20861-8-vincenzo.frascino@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0065.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::29) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:18::12)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.196.167.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 191c575a-871f-4f0c-c469-08d7307d8afc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR2201MB1038;
x-ms-traffictypediagnostic: MWHPR2201MB1038:
x-microsoft-antispam-prvs: <MWHPR2201MB103838333F82D0AC004289CEC1B90@MWHPR2201MB1038.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(346002)(366004)(376002)(136003)(39840400004)(189003)(199004)(8676002)(6512007)(9686003)(55236004)(102836004)(33716001)(6506007)(386003)(66946007)(6486002)(6116002)(305945005)(7736002)(3846002)(4326008)(71200400001)(5660300002)(71190400001)(81166006)(76176011)(81156014)(66476007)(229853002)(66446008)(64756008)(66556008)(256004)(486006)(478600001)(8936002)(44832011)(446003)(11346002)(476003)(7416002)(14454004)(53936002)(25786009)(2906002)(186003)(42882007)(316002)(54906003)(58126008)(66066001)(6436002)(99286004)(6916009)(26005)(6246003)(52116002)(1076003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1038;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B6LdeD6ARa35RtAijdqKNArBm3t/8A9hKXqTAJN1zI4pQnH0PHd/1Tt6OZXQNYobdEbZrLthmjAgUpXvFfFmsoCyVekecBhTw4G32beibyf7kO+4+VPxA6P9kl6wYty+SUTJZIxNDxo7qUOTQf2aEI3MsoCVtzp9bRxfTteizZ33keTpOqL4R6QaqiW/1NtPuKaIB6LZwE0J4fvLMzdH7P5akBD7lP9TzrKqfKpvXQtS5yWACSSNxpYptdhn9BQdfbcc9ag/i3zhzKR9E7la9SYfgppXd695v+FhpjEXrv3LG4u+ZDqztGJ+NyI1x9RrbOylmLb8SsXCNXTiYhoSEx04WtbS+z8HUScKp+P8aFd+DvOCOXQNVN1C/jTGj827HI3eKRRr/ktKcJHihQZUjWn4fkuJTY9M9ZyUhtXUQJU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AC316F9566DBF246B86E082AA7B4F9C9@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191c575a-871f-4f0c-c469-08d7307d8afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 14:46:45.8460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 43If+A1jkVysJ79RZxyyjgZKbY7njpb/vP+0GBFJH8Yr+6b+gU88ABJvtBjIed3Hb9b3YXIDyAOw2SEG8+a0Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1038
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Vincenzo,

On Fri, Aug 30, 2019 at 02:59:01PM +0100, Vincenzo Frascino wrote:
> VDSO_HAS_32BIT_FALLBACK has been removed from the core since
> the architectures that support the generic vDSO library have
> been converted to support the 32 bit fallbacks.
>=20
> Remove unused VDSO_HAS_32BIT_FALLBACK from mips vdso.
>=20
> Cc: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Do you want this one in mips-next too, or applied somewhere else along
with the rest of the series? If the latter:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

> ---
>  arch/mips/include/asm/vdso/gettimeofday.h | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/includ=
e/asm/vdso/gettimeofday.h
> index e78462e8ca2e..5ad2b086626d 100644
> --- a/arch/mips/include/asm/vdso/gettimeofday.h
> +++ b/arch/mips/include/asm/vdso/gettimeofday.h
> @@ -107,8 +107,6 @@ static __always_inline int clock_getres_fallback(
> =20
>  #if _MIPS_SIM !=3D _MIPS_SIM_ABI64
> =20
> -#define VDSO_HAS_32BIT_FALLBACK	1
> -
>  static __always_inline long clock_gettime32_fallback(
>  					clockid_t _clkid,
>  					struct old_timespec32 *_ts)
> --=20
> 2.23.0
>=20
