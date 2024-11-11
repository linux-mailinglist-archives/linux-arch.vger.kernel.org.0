Return-Path: <linux-arch+bounces-8965-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8629C3755
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 05:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB599B215B8
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 04:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579091537DA;
	Mon, 11 Nov 2024 04:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="b/SQZdTG"
X-Original-To: linux-arch@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011038.outbound.protection.outlook.com [52.103.12.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFA414373F;
	Mon, 11 Nov 2024 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731298397; cv=fail; b=Myr0xUn9mjWx6FKXI41tm8GQs+GDFS/G7H/tKZ4Pzqz9Gi+KIrJNCveZOIrYiFbIcTageUxIqZJKJ3L9jyPq+uPAYJ/Q9KwCWyOIjprxDe1opDxjltb3pNHSeSrYGzz7saZASl+vu06p3T6EFKc9JwKsJwMfuXKGkltGGbfkpJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731298397; c=relaxed/simple;
	bh=QiDmu5/my4dpknxNdvQOmpefiedLm67y1Sr15eK/TGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EBzzOll45fyWmQyFE7MsY4OsXHKVZ6FwMI4HXDmtckAOC/AWFpxywDwUoipvwTzWWhT5W5l1khK7Tg0rXIJtkekPgy4hG2u7JRekzwIG7e32Le4yDus78I+zIwlMOHn/kYd+Y1aBh6c27j4jXQFAM6gJ+LGCFfppsnRE/2uE+is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=b/SQZdTG; arc=fail smtp.client-ip=52.103.12.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhsxZ/KlzzT/zuAWot2eQF+fGiMsWeSuXyWtYx0sVFIfcO818IfvNCsnalry9A87WahpjCCocCDRFTnOiQG9b4bGSmmtj59m8C+0SKFzangd4bmYsjk37nTr2A2rtUSs3+Ayw84DPznAHjN9NWOLKBM+TDE97Z6wM+BvV29Rs4RlcEvoYrMQygA+cGfZxWOL6/vzdZxqjOK3F1cZwBoHeOJ39lZtU+VVm7RbCEwtwhKG/G5tKwdPCLCWjyxP8A770NujIxxePd0E5Vpd5kInhwetaUvmm7r/7QDVPyoeNUAt3wlX2Mb02LVh+o+60RBkc2in0TBDN9SKVjeaS0OVZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A21ZFeomPobSxK3jX9ThV6UuJLfIwvEb9WaeECKvjLw=;
 b=kgtrFlm0uy0kZhERsxSpzrpJ48/yw+vqFH1fuOCcnXE+/6okjwzC7EmPFq5iV3CiKAf9a90UnItP9peYK1sB+RNo+Zi6qCs3M2q/YVEJX3OFVI1HPCVrORfWBcmVhPs2WEVtMZokNvpBrKH3zxFiNmSZduozz3BU2dmeJm5+0C6hS5+XFNK1/ktrxRm02bMcBvMK21YD4KjFJxafQ1jYrfzCtEGgQpHKbSlYFLvOp8T/F8oRFOG8v/5DbxRdEWMqkJiCMmi49C2fl26CiF9Tdpm22aseEvM/K05T+lADXprZ5qPoWyIL9ysIRzwuuWWvVeN70KHkvNN82Zh8KsYkSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A21ZFeomPobSxK3jX9ThV6UuJLfIwvEb9WaeECKvjLw=;
 b=b/SQZdTGmUR/aHOs/l0Z1S18qKjjb7/YMgDg7PbDy6eOHTOucGnX9Vwq3Wb7MckKX1Q5uGxALvsW5DXEYrTWM/BqmThyPxtYhK9AKY3r9b1eqJw3175WE2YwFMLDbtnKNaYtb4yXveXyxdzoU0aQ9KLtrSo2S12LI4YTxVwXfwZX4aTPFFBeW/1Y5kwKnT1X7ml3V/DZ9JtPu/Z1l98k9W5m1RLxSrSp69xHPEpBYyvjyA9k42FJr5OoyUjlgHLdvBhdnB6hXaQvkNS+QrT2OFf/QABBSIHl5qGWthF0KUHjWzUcyHHuKTzx93Nps+BM+GYH9HrjU+u/2cbS1gAVoA==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by DM4PR02MB8958.namprd02.prod.outlook.com (2603:10b6:8:bf::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.20; Mon, 11 Nov 2024 04:13:12 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%5]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 04:13:12 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"luto@kernel.org" <luto@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"muminulrussell@gmail.com" <muminulrussell@gmail.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mukeshrathor@microsoft.com" <mukeshrathor@microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "apais@linux.microsoft.com"
	<apais@linux.microsoft.com>
Subject: RE: [PATCH v2 1/4] hyperv: Move hv_connection_id to hyperv-tlfs.h
Thread-Topic: [PATCH v2 1/4] hyperv: Move hv_connection_id to hyperv-tlfs.h
Thread-Index: AQHbMWTxR9DbWRBrEkSncYJF+rrup7KvpSgQ
Date: Mon, 11 Nov 2024 04:13:12 +0000
Message-ID:
 <BN7PR02MB4148AD2F4AE323BFF22EEDD1D4582@BN7PR02MB4148.namprd02.prod.outlook.com>
References:
 <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1731018746-25914-2-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1731018746-25914-2-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|DM4PR02MB8958:EE_
x-ms-office365-filtering-correlation-id: 3c481909-f824-40f0-2a64-08dd020728ab
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|461199028|8062599003|15080799006|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7xhiFSAKWeJ+QsWeUf4Sst7h4p3BruegqOM6cFsMgfdxFqNig3U+Rm2da7JX?=
 =?us-ascii?Q?nE59z8UJzoNH4bo7pARtxJfMINnRl5UHkkBwlgErWHtQSjr+hc1gIWCdFOKy?=
 =?us-ascii?Q?QiUB9oguhV2AZduluWwnuT+SnqECRiO75iznJbX+jJ+GzxGLIfjex5cx74qC?=
 =?us-ascii?Q?go13HIbvUTHZd7h2aCS2MHg57RPC6GwhrHI3fqHjlKeQRx5RZBF3ebKqsFQT?=
 =?us-ascii?Q?mvpg6yBigONxrG4KOgXSomNMdhVviSJOKxPKB/pPxwBEbpO3fuPTC+LqQPk5?=
 =?us-ascii?Q?RvSCDSpinca4wAqCAqmeOjmF2WLKwKqy0zWpnlk7wqpAo7rUWd0Jmv5x26b7?=
 =?us-ascii?Q?OGiYgq1Yxn3bFc+2aN4V1znpgyBm2fQcPQo9SIjSce4yW5rHwCEw5qiYuJcr?=
 =?us-ascii?Q?7TEmIz52NA/GhpqlazKP0+eshDz2Hq66V5kMb7sxgm8jSEte6ivvnec0ghL+?=
 =?us-ascii?Q?KU1gVp2EH9RpSoBKKtRdQ7sKE5/uf7S6bu8kxDEqQg3E9DQ3gt5DXTEXL+ev?=
 =?us-ascii?Q?BSgRxX8RUWZn7Y+NptiQ0+ZKU03r3PsJDSpsLwDkv0/PZd6uStqmdyt7c1GB?=
 =?us-ascii?Q?LIDo6axOVPIM7Pk1HSMeeiw7DUnISR6zmVVcYHsByx7hhYdCTW/XQZK5L3KS?=
 =?us-ascii?Q?PT08i5Y7PtAWkFeUSuzY6X9oqMC+1NkTlSajzd9PYKQHhtglzXKVjxhYGug+?=
 =?us-ascii?Q?aTsqA7A37APQ0bwM2LRhoSFI1xEicufoiMmFh/jFRDrUeMKM1dk6/R7z6qzb?=
 =?us-ascii?Q?fwn4mHdtdRaDR+r6nvCvFYJQV/TCYDz8L/Q7UYOvgo0jeyCqoNAsKYx+FyHo?=
 =?us-ascii?Q?NIDqJxRiVY0ocbvHlxFs8LeBXznbjUP53WyctV9YuMS1Ey9YJFAxH8V8tEnl?=
 =?us-ascii?Q?7hvzA4SrAaLu4nS7XX2YT9eUbTdSXtymNULXcnfWHLpDa+vbttbKbAb7HLMa?=
 =?us-ascii?Q?7yX4rHIUdgedKeaCYcVPw8bgAWPnTrRKLS65UIYOaOoX7H2vHA9gb1r7MIUT?=
 =?us-ascii?Q?xKc2ph0KGgZ7c8N92MpqaehX5A=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xo0YRJtEp43Q/d5ozg0yfwpC7s6hqyCsKFnwNNjODm7Vtn61Owkip36hVK8n?=
 =?us-ascii?Q?Ufz/jY9X+IpZsWQXrI250uuaQNSbyXOs+G351JVEjhxCWh3/eHkJY3LfWaBG?=
 =?us-ascii?Q?eeWwIK8fScQ2GaQyWM83oPcHwQWdSuqsZwSPMEprn8Pwfj1gz473svWSZBqe?=
 =?us-ascii?Q?DymVQ/1tlcAnWdwxgfu+4iGj/2rlv9vUNMT5tKDCf1bIx8PTnOOpnAj/7ue7?=
 =?us-ascii?Q?eA2sKtPAkfgF1+vcH1s0GhKPw7MCpH8BKZegYm7TjKukfKD0z/Jw7Pdy5HbE?=
 =?us-ascii?Q?IKQ2DdUsyPpoiMHYlTbGSGH7JEH50WrBMsNqiKL1V+BdoozThf+J+Z8MUjZf?=
 =?us-ascii?Q?pozo4FhEd3OAKp5HYn6r8Pyknkd7SIp7qbGEK+se8M3NDwDukSIjdmyBKJ9t?=
 =?us-ascii?Q?eyLZVCo8qE/VqW702DFq60OOeK/uQ94UUVhLjx9Xt+yVN5iceVYCfjr7foRI?=
 =?us-ascii?Q?B/8QYFTCv+qAM2KKof9mM1Se6Ek74wwbW6AQHBE0uGiJ8mG5NMiLnk31IKU9?=
 =?us-ascii?Q?FeB93SuW+XoZcNctpICj2EY+FykdbrZa0JTfZAZa7ezp+JMEt594cE1HR0yu?=
 =?us-ascii?Q?Rk6r2BCCEAJvMuOVYMNehrF9hL7Zg9B7BsbmdayFjADbunR3TWn5v2hd8r08?=
 =?us-ascii?Q?mWeNv+ph1K/wfFtDQvVa+MIjKcP8thpn8/3OP48ENOgYwHVx0zPnX2ogtO2O?=
 =?us-ascii?Q?hzdffDNrE+FzOEVSRvpVLW5hdgp/GhjDVuasZfP2DvU/3Q4vanAGgtTcrFAI?=
 =?us-ascii?Q?QWwu82/yClq7zKkN3/rdAoCjhzhAFN9kqaL4j+5dnh2UALdI6wFMDz8dLsth?=
 =?us-ascii?Q?SCogwnyGfja9KGZOvOtscPVzcfURIG/6PPFlaIdsVqfym1kv5z5gSGoMLuWv?=
 =?us-ascii?Q?w2KDH/47pMw4V1AIdsVIuk7cjleBCjUoZEd7ez/vaD4I0BaP7oS7XnAQO000?=
 =?us-ascii?Q?BcQw/KYUXV0a9AUjn25JajSzaubqhLxMXt+uw6gXOfPHMzKdejLRWe0pKhvB?=
 =?us-ascii?Q?c8L/O69dRdSbT5TCVgHq46lj1ViercHZhgDa0f6Xrf4mUVZBdPpFiZNMMLX1?=
 =?us-ascii?Q?+krDK5nJlX8IYSVHq7Ufrx20ZeJBky43oGd0I0W2+c76EgFZvEjhWAlGReiE?=
 =?us-ascii?Q?wtREF0ww8f/DnVMyleXpZzPU928m9XhvQ96j8AB7cHPv255NCAPDYlqycr7j?=
 =?us-ascii?Q?YVEBVpRTIiZX7alXCvQuchySGKZ+aUZjXHDSAk/Bkfy/hlqIamcboE7UDvs?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c481909-f824-40f0-2a64-08dd020728ab
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 04:13:12.6638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB8958

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Nov=
ember 7, 2024 2:32 PM
>=20
> This definition is in the wrong file; it is part of the TLFS doc.
>=20
> Acked-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  include/asm-generic/hyperv-tlfs.h | 9 +++++++++
>  include/linux/hyperv.h            | 9 ---------
>  2 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index 814207e7c37f..52274c9aefef 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -871,4 +871,13 @@ struct hv_mmio_write_input {
>  	u8 data[HV_HYPERCALL_MMIO_MAX_DATA_LENGTH];
>  } __packed;
>=20
> +/* Define connection identifier type. */
> +union hv_connection_id {
> +	u32 asu32;
> +	struct {
> +		u32 id:24;
> +		u32 reserved:8;
> +	} u;
> +};
> +
>  #endif
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 22c22fb91042..d0893ec488ae 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -768,15 +768,6 @@ struct vmbus_close_msg {
>  	struct vmbus_channel_close_channel msg;
>  };
>=20
> -/* Define connection identifier type. */
> -union hv_connection_id {
> -	u32 asu32;
> -	struct {
> -		u32 id:24;
> -		u32 reserved:8;
> -	} u;
> -};
> -
>  enum vmbus_device_type {
>  	HV_IDE =3D 0,
>  	HV_SCSI,
> --
> 2.34.1

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

