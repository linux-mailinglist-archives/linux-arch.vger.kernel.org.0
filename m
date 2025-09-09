Return-Path: <linux-arch+bounces-13443-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE74DB4A02B
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 05:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1651BC5536
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 03:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D0D27A906;
	Tue,  9 Sep 2025 03:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Dsu/881j"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2039.outbound.protection.outlook.com [40.92.46.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23952BE7AA;
	Tue,  9 Sep 2025 03:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389361; cv=fail; b=IdNF+WLKmH5ESy89IEzkP9IkW5GGqCrob7gxVTIecMJrTF5Jt8+e4KGvJIm5BR2oyBXEVdVSCiXLvGxkmUFhZvnlfncjGTzzPIBxIRMWvY7HP44sISbCMXLWnaVZDDHzK5NFOZwP7JZTZ7CuXGDnsqgb1oSPvC57At3WEhTUe8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389361; c=relaxed/simple;
	bh=Ajv9M/TqZMasQ2d3W+co5nyn378K53jYedoTd4CJg9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OZ8tNBZA32tNLbH8MDkMwA73Z3obuyVzDWJ9AcvO5j8iXtIxpc07UTzeST6WNmFKtzhy9c8MOoHbUkP8R/Y5/AThOhTZV//dU6OO8VJUXZrPjbVdS0T3wK1m3l1189gkFqiA+nyLK4sVMEuQ11N7mVaX1n/MhsJHz2ChI+nHRbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Dsu/881j; arc=fail smtp.client-ip=40.92.46.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3RwWLSD8+8v8CIN8++opkOGDwv5nVR4klUS5LeeBmCU8Sj162L27dFrx8f1YtCxqxwFtHkIdY0m0ek4MEexdoeoKeO6n3UaGa0WtE2bAU/fYm3652q3tuTXscFerTQqTFyFlZO4cTJ0eWlwYf1XxVukOIxsMj8ZXGW+57NN4dwx3NB63aY9cVNMI3Ve8jxsJYQ5zqUrvkzOio1xOlCIbkvUsQxg2Vgsb7GDY/7VFGUFm77n4Rie/srtHjZk1if8auXAaLUJpP/LderGZ1k9jHurlHLEC7FTq/dDWns8tdVxiARQxc6lLvLmd9wIXsnmejEpaIM8o4fBhyantvC0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALEipQGgk0lBE9+VTQkB9W118JYw6sV+yLtCS40OUHY=;
 b=XM6I8FzLZQerd8Ik/+yPk4OJckxvXQSw1CBEZWeMVQjx6V0RbVMbMTfZNm35FlUu2xzgaFVAWLNokvADoAj5qhMr/M8LHWyyFlP9kXZnvUH4e9ZseVbjrv9TtjEU0RWsxKre/k/Awl3vjI8z6BCc8/0aMY3jSi3Aqhi5w7BS/lcB8Wc9i5+qOWkiQX+DpAhnAdr1fmIZCeuwCOg374sNm6ugtCxgofuz2lSOPyazJg9PBq7AFhRjPnGVN+W4AqJVXToeeABgRdqNzD9+lv90cczKA34E97bODc0xZYu0lnuGK54Lnl1jXh9qlH/e0AcHCyCqL1C9Argy030w6RDhrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALEipQGgk0lBE9+VTQkB9W118JYw6sV+yLtCS40OUHY=;
 b=Dsu/881jKyH1H0zOXFzI7FXG2mfVhe36JpMgIzusUOZjWhtYRWSwQz7cxfSoD/jvS+vfxygpkkDHYLbKSleZ/iFYh3oLkCdjS6gcUWdUFs1bdeIfFDAnSEV0fH34TJrFXJtKG/ZS577lS3dNYALzTkmDrCbmXWyKTQ40ed0kMSHzUl5qN0iz+8tbWHPKDeH3xm4pCHWxKjKzIcrnNHPO7TqqEYIG388r72jYL/y+/mpwR6m7TBGHulIMTVHyHWlDTOeZ86T/2fsdvdU5B6lkSoX8e3466YSG3kpT4u25y7N0yVd3LgU6d8DQ9jXC07WbT5v15tMVJ13zQiKVB+G4AA==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by SJ0PR02MB8484.namprd02.prod.outlook.com (2603:10b6:a03:3fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Tue, 9 Sep
 2025 03:12:22 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%4]) with mapi id 15.20.9094.018; Tue, 9 Sep 2025
 03:12:22 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mikelley@microsoft.com"
	<mikelley@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "Tianyu.Lan@microsoft.com"
	<Tianyu.Lan@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "benhill@microsoft.com" <benhill@microsoft.com>, "bperkins@microsoft.com"
	<bperkins@microsoft.com>, "sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v5 11/16] Drivers: hv: Functions for setting
 up and tearing down the paravisor SynIC
Thread-Topic: [PATCH hyperv-next v5 11/16] Drivers: hv: Functions for setting
 up and tearing down the paravisor SynIC
Thread-Index: AQHcF7hbL44+hc2Ypk60XogYlm6MALSKAKgw
Date: Tue, 9 Sep 2025 03:12:22 +0000
Message-ID:
 <BN7PR02MB4148F8059F6804E3101789DFD40FA@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20250828010557.123869-1-romank@linux.microsoft.com>
 <20250828010557.123869-12-romank@linux.microsoft.com>
In-Reply-To: <20250828010557.123869-12-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|SJ0PR02MB8484:EE_
x-ms-office365-filtering-correlation-id: 59a3cf2b-437d-43f9-2f3f-08ddef4eb1dc
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBtg1x3yx1r6QKZAk6LGeuzaJn89e6q5fbs9QcGSm4gg2WcWfi7X4KooLU8BOIwsPtqVrYAmUOHv2nwbFPcRjls3nfnozlZo8sH/+aVbNggfjcM5XHdyCUJJ30sNfmn04GKWFUbTI5JwtCmMmXUatYWVg/oTuq+mNSU3neonkTqPafxdUXrneg7nluu/q06CeVF/dtjPd2XMIfRiPvfqETAlPH4iXVzz4sqm1m5jGCHm2SxkGejuiBBzT5cC5VPVVQvceHI4LVvnNI1fanlT6adEzUfQ6S4a/nJMHcJ0gJSKfviAfJM3mqGYe46Khv58bkLNsgre9D/ndfOGiZg0ijxpudyunHPDR1vojDBB+zo87KdmIDd2ZF2RuzxZ4AMaBx28sPF8/v3ODX8FWY2mhq1PIKgntVIIzF6cl6qvRc97fNcGIl0voO91vAry/Ia8xvv3w43m4jeNB6mLl9ZAq/6O2FI2Pue1mkpLUI5J3LIuFhB7vUFdN+YjqeqZeI69xEYCRItN9Get80nDvN0jdB8gKbgJD9sEqCNOnmpVwK/+3k6JV3vfhEolCwcyLJHK7H0AbylzMIrAsGp2WD0NiHOh/ULP/B3ouXkBOSM/o6FAvfkqYzOwf+GLt9UyGjapIFOTiMTnQHkGN4ng2+M8IdBM0sxRfEQMoNHmgsS/sqAI+gktI0izWAmBgXeqf68UyX+WhXOHwToWjMWmn4a2Qo8CrjvbuuNR9Y/O9aPgqLhQwRKcV1wP9feBOz5IJpUVfKy7FPeHgdH7PsNbXfLcpXrm
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|8060799015|8062599012|31061999003|461199028|15080799012|41001999006|19110799012|440099028|40105399003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EHOJwPBkhuo5U9iuBm3jGC7kNiCwVdT7VFbkptFAYcxM0KhnRsggmd+Xyef2?=
 =?us-ascii?Q?UzAi8y7UD/SiTg20YWRFCIfuvDW4Xi+byN1LFRAOu5HnJVdw/INNJyzEUXQK?=
 =?us-ascii?Q?SiL08EppZL/SpPWzh+J1SthqQagvi0BiukcwNoYX8A+91atD7fbu2SK0NdX6?=
 =?us-ascii?Q?LBfnI3a3KXfsD9h5/ccZfDRQvQsdNnrQ4zluZMu3FbPA8TVAG60UOdisOujy?=
 =?us-ascii?Q?PlBnm54piahCI7qFFVQLicJr6WRmFuJ1Gx0ijjcKkzI64FSdgxvj8HIB00qc?=
 =?us-ascii?Q?12qYIqoVg/LNelBLF7HolUYnuZhY59F2w4IhrBHwYOWgEmCQ3XAngqp4pax+?=
 =?us-ascii?Q?XFcFb7bo2VG426Ivozxya2ug8VR4JPvMuBuzuQ1HeLkvqHMwY87fyFONsTJq?=
 =?us-ascii?Q?aT7b+qBDMSHbf9a1dNvo/8m9OXLWKrbnUK8Q0AqsYFiVA+8ajvGd80hwTnmO?=
 =?us-ascii?Q?rGr2thn04lXbqIkPUbnSPYOJruVsYlI2zsg8e3xAD/PkglKJnDV7lsC/rafn?=
 =?us-ascii?Q?oKRYCyWDU58//WVPaAdc+d+iVdBqo1NPqCk44bCDVCizn+/Ff+8L+YK0LzoP?=
 =?us-ascii?Q?5GjJhY339eqaU30hKhIspsmzUUqybBTsFWZ+zU66Y4fEzFE/fos0hh13CJEv?=
 =?us-ascii?Q?lRXRovd8IzUz/pODEfUkioToqq3s1VuoI+2mFgUmiuQRGqT1XK1uzygj7Cno?=
 =?us-ascii?Q?jTPz9BcICEvcATn531Qpntk3rFl1bg+GRYDnpxrLy0RBtMc2rl6zkKMKokor?=
 =?us-ascii?Q?/lzQrymXTYiOyTjzlvfABleYulavBNuhz30U5ZNahvcsiRewk86jOCElIVJd?=
 =?us-ascii?Q?yMsmaN6T2KZ7A8Q0dUawhYzg9j8DP4mqPV48vipOFqgOwM3TwzeSWNQyVa6h?=
 =?us-ascii?Q?8i+YOgRIl2TLI74cV8E7C68guE186GQ4PlHrokPFVCMlRXtDDLwceTjkEys5?=
 =?us-ascii?Q?m4vfvCjDaEQiRBfX50RnBN89VfomQrItpbe5o2p0lgqohZThuohsOXletD/a?=
 =?us-ascii?Q?VZdrHQ6oDKV6TiWMReIhYt9On5uSDdBw/SfkwAvzdqwxgjcq2/oChA4Eq1k9?=
 =?us-ascii?Q?jBNvwKhwkHgyA/9xbCDHoH9U5dUoz0y8ObSIiYyANoRB2mkjwAhtTbMX2TZj?=
 =?us-ascii?Q?z2eFRdwb0BwDNM/PS1/TZEoxtkkXbdi13ZSE0dmkSir+fR9JxmCBfUTa2nrQ?=
 =?us-ascii?Q?c4jfzi2vhlU6tb3sUfHCK90FEiLBZ2QF3nPktg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SdgmMoZZCg8uNRqbSlH4UFw2bSPdyuMsTeOe0CzMt63ooFZbavEAsl6ojabT?=
 =?us-ascii?Q?F1RxivJG9kxLWsGe+0vmbc/COewXKat5bEpZSPJzU7ueXh/16VPueq89ED4+?=
 =?us-ascii?Q?Fra5UHwbYsGeaS/bhRB1xrAbtOKtnDVGJiDCqasNZdqTkmFvZvoSOasHLt4p?=
 =?us-ascii?Q?b5ib+B+rPCV8tunYp+aDSE/cAL6g66jj7VRr5xb1kgT+m/J92cLXNuxxLhAY?=
 =?us-ascii?Q?cZ3E0FIo+ApI6DIoVhM944rpjj5xxMnLnV385UouR0g0b6n+VB4QHm1Oz3A2?=
 =?us-ascii?Q?7T0lKIRWwDUhwG2YFUJHMN5ZOmkhn5T4XKMxebQ0siTvwX4rCMrMia/EuEOl?=
 =?us-ascii?Q?UiXGyjrrbyfK372rOtfY/G6xFIQezZq84SIf1zR5e5FrQZonhOL98Fqsk8hD?=
 =?us-ascii?Q?4uxpxC9o0EgVnu92qBDaqczJt+TYtGLp7afcZrdihvJOKXyK80/lLUhPb2si?=
 =?us-ascii?Q?gUvrq1CnZa+xE6I6dYlxyKZCar+sy9k4maioBaqB/RVAyUQgcg5nn6cMK7p1?=
 =?us-ascii?Q?KDo06edB198wEqYMJweu/xPfR9MpzYsdFvMDcGamZ7XtvD2fM8ytxVyhoxjl?=
 =?us-ascii?Q?YjfypPBMtjncUxcA4EdTWICdbryX7IZoIl8fhdjO5waKupSh4hhaq10DXYfu?=
 =?us-ascii?Q?uhA4Ep6zEwuOXsh0dXeAglnRHgFmGxnseD8D/sl/IsQrg4uF9FCBhIIKYRrk?=
 =?us-ascii?Q?UuUl6ASOSaa8XjWxCTvimnrHr/6ari3RVVB2VWLl/7YzsLhqHLCTKOkmLtTA?=
 =?us-ascii?Q?2XbVBSBgumTvYGRZ2xGrdiNacCQZyvj/zpEcMwDh6ymOQWCkH0cG6qRGrxFl?=
 =?us-ascii?Q?zvgbghma92wMfk5ZrS/I4cUtKzIQKjPG9mF5HtEHgpYj7Fpcm5zcwvNVn9Wb?=
 =?us-ascii?Q?6aSftVZiV4Kz7cFnGAk4lLAIgJoE/xa3fdHw9drZlRBSM0oqRKoYuHN6TxyR?=
 =?us-ascii?Q?DwAnrt7R/vDZ7rDYCtaTcbSggM9ePiJ6Gqo8sPaTHjqaq00OHSxn6usyCaui?=
 =?us-ascii?Q?Vkj6kyIDxwBb/IOaMWkB1tW4Vpy00jhVtIeGvfdyuchSbo3azi6toTw2YxYw?=
 =?us-ascii?Q?JNhTjd0yyOZAybQQi9GENntgw5KBe2SMzgOPSWseJ0phgG6/22xlPjf3VwN7?=
 =?us-ascii?Q?o/El78wOiWczK8qqVyuo+W4vuS7nH4TsH9hxSwKtzuho/AAbo5CMNy3ECOPD?=
 =?us-ascii?Q?8L0OYO/rJfUCOIYYDXVwsv9O9j+PHBUliPi2pqSWjQbo70PdNir7nCEOO7I?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a3cf2b-437d-43f9-2f3f-08ddef4eb1dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 03:12:22.6495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8484

From: Roman Kisel <romank@linux.microsoft.com> Sent: Wednesday, August 27, =
2025 6:06 PM
>=20
> The confidential VMBus runs with the paravisor SynIC and requires
> configuring it with the paravisor.
>=20
> Add the functions for configuring the paravisor SynIC. Update
> overall SynIC initialization logic to initialize the SynIC if it
> is present. Finally, break out SynIC interrupt enable/disable
> code into separate functions so that SynIC interrupts can be
> enabled or disabled via the paravisor instead of the hypervisor
> if the paravisor SynIC is present.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  drivers/hv/hv.c | 192 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 180 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index efe161d95b25..78ae3e1381dc 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -281,9 +281,8 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
>  	union hv_synic_simp simp;
>  	union hv_synic_siefp siefp;
>  	union hv_synic_sint shared_sint;
> -	union hv_synic_scontrol sctrl;
>=20
> -	/* Setup the Synic's message page */
> +	/* Setup the Synic's message page with the hypervisor. */
>  	simp.as_uint64 =3D hv_get_msr(HV_MSR_SIMP);
>  	simp.simp_enabled =3D 1;
>=20
> @@ -302,7 +301,7 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
>=20
>  	hv_set_msr(HV_MSR_SIMP, simp.as_uint64);
>=20
> -	/* Setup the Synic's event page */
> +	/* Setup the Synic's event page with the hypervisor. */
>  	siefp.as_uint64 =3D hv_get_msr(HV_MSR_SIEFP);
>  	siefp.siefp_enabled =3D 1;
>=20
> @@ -330,6 +329,11 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
>  	shared_sint.masked =3D false;
>  	shared_sint.auto_eoi =3D hv_recommend_using_aeoi();
>  	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
> +}
> +
> +static void hv_hyp_synic_enable_interrupts(void)
> +{
> +	union hv_synic_scontrol sctrl;
>=20
>  	/* Enable the global synic bit */
>  	sctrl.as_uint64 =3D hv_get_msr(HV_MSR_SCONTROL);
> @@ -338,13 +342,101 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
>  	hv_set_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
>  }
>=20
> +/*
> + * The paravisor might not support proxying SynIC, and this
> + * function may fail.
> + */
> +static int hv_para_synic_enable_regs(unsigned int cpu)
> +{
> +	int err;
> +	union hv_synic_simp simp;
> +	union hv_synic_siefp siefp;
> +	struct hv_per_cpu_context *hv_cpu
> +		=3D per_cpu_ptr(hv_context.cpu_context, cpu);
> +
> +	/* Setup the Synic's message page with the paravisor. */
> +	err =3D hv_para_get_synic_register(HV_MSR_SIMP, &simp.as_uint64);
> +	if (err)
> +		return err;
> +	simp.simp_enabled =3D 1;
> +	simp.base_simp_gpa =3D virt_to_phys(hv_cpu->para_synic_message_page)
> +			>> HV_HYP_PAGE_SHIFT;
> +	err =3D hv_para_set_synic_register(HV_MSR_SIMP, simp.as_uint64);
> +	if (err)
> +		return err;
> +
> +	/* Setup the Synic's event page with the paravisor. */
> +	err =3D hv_para_get_synic_register(HV_MSR_SIEFP, &siefp.as_uint64);
> +	if (err)
> +		return err;
> +	siefp.siefp_enabled =3D 1;
> +	siefp.base_siefp_gpa =3D virt_to_phys(hv_cpu->para_synic_event_page)
> +			>> HV_HYP_PAGE_SHIFT;
> +	return hv_para_set_synic_register(HV_MSR_SIEFP, siefp.as_uint64);
> +}
> +
> +static int hv_para_synic_enable_interrupts(void)
> +{
> +	union hv_synic_scontrol sctrl;
> +	int err;
> +
> +	/* Enable the global synic bit */
> +	err =3D hv_para_get_synic_register(HV_MSR_SCONTROL, &sctrl.as_uint64);
> +	if (err)
> +		return err;
> +	sctrl.enable =3D 1;
> +
> +	return hv_para_set_synic_register(HV_MSR_SCONTROL, sctrl.as_uint64);
> +}
> +
>  int hv_synic_init(unsigned int cpu)
>  {
> +	int err;
> +
> +	/*
> +	 * The paravisor may not support the confidential VMBus,
> +	 * check on that first.
> +	 */
> +	if (vmbus_is_confidential()) {
> +		err =3D hv_para_synic_enable_regs(cpu);
> +		if (err)
> +			goto fail;
> +	}
> +
> +	/*
> +	 * The SINT is set in hv_hyp_synic_enable_regs() by calling
> +	 * hv_set_msr(). hv_set_msr() in turn has special case code for the
> +	 * SINT MSRs that write to the hypervisor version of the MSR *and*
> +	 * the paravisor version of the MSR (but *without* the proxy bit when
> +	 * VMBus is confidential).
> +	 *
> +	 * Then enable interrupts via the paravisor if VMBus is confidential,
> +	 * and otherwise via the hypervisor.
> +	 */
> +
>  	hv_hyp_synic_enable_regs(cpu);
> +	if (vmbus_is_confidential()) {
> +		err =3D hv_para_synic_enable_interrupts();
> +		if (err)
> +			goto fail;
> +	} else
> +		hv_hyp_synic_enable_interrupts();
>=20
>  	hv_stimer_legacy_init(cpu, VMBUS_MESSAGE_SINT);
>=20
>  	return 0;
> +
> +fail:
> +	/*
> +	 * The failure may only come from enabling the paravisor SynIC.
> +	 * That in turn means that the confidential VMBus cannot be used
> +	 * which is not an error: the setup will be re-tried with the
> +	 * non-confidential VMBus.

Isn't this code comment now out-of-date? Retrying is no longer
implemented since the CPUID bit explicitly indicates if Confidential
VMBus is present.

This failure is fatal now, correct?

> +	 *
> +	 * We also don't bother attempting to reset the paravisor registers
> +	 * as something isn't working there anyway.
> +	 */
> +	return err;
>  }
>=20
>  void hv_hyp_synic_disable_regs(unsigned int cpu)
> @@ -354,7 +446,6 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
>  	union hv_synic_sint shared_sint;
>  	union hv_synic_simp simp;
>  	union hv_synic_siefp siefp;
> -	union hv_synic_scontrol sctrl;
>=20
>  	shared_sint.as_uint64 =3D hv_get_msr(HV_MSR_SINT0 +
> VMBUS_MESSAGE_SINT);
>=20
> @@ -366,7 +457,7 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
>=20
>  	simp.as_uint64 =3D hv_get_msr(HV_MSR_SIMP);
>  	/*
> -	 * In Isolation VM, sim and sief pages are allocated by
> +	 * In Isolation VM, simp and sief pages are allocated by
>  	 * paravisor. These pages also will be used by kdump
>  	 * kernel. So just reset enable bit here and keep page
>  	 * addresses.
> @@ -396,14 +487,58 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
>  	}
>=20
>  	hv_set_msr(HV_MSR_SIEFP, siefp.as_uint64);
> +}
> +
> +static void hv_hyp_synic_disable_interrupts(void)
> +{
> +	union hv_synic_scontrol sctrl;
>=20
>  	/* Disable the global synic bit */
>  	sctrl.as_uint64 =3D hv_get_msr(HV_MSR_SCONTROL);
>  	sctrl.enable =3D 0;
>  	hv_set_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
> +}
>=20
> -	if (vmbus_irq !=3D -1)
> -		disable_percpu_irq(vmbus_irq);
> +static void hv_para_synic_disable_regs(unsigned int cpu)
> +{
> +	/*
> +	 * When a get/set register error is encountered, the function
> +	 * returns as the paravisor may not support these registers.
> +	 */
> +	int err;
> +	union hv_synic_simp simp;
> +	union hv_synic_siefp siefp;
> +
> +	/* Disable SynIC's message page in the paravisor. */
> +	err =3D hv_para_get_synic_register(HV_MSR_SIMP, &simp.as_uint64);
> +	if (err)
> +		return;
> +	simp.simp_enabled =3D 0;
> +
> +	err =3D hv_para_set_synic_register(HV_MSR_SIMP, simp.as_uint64);
> +	if (err)
> +		return;
> +
> +	/* Disable SynIC's event page in the paravisor. */
> +	err =3D hv_para_get_synic_register(HV_MSR_SIEFP, &siefp.as_uint64);
> +	if (err)
> +		return;
> +	siefp.siefp_enabled =3D 0;
> +
> +	hv_para_set_synic_register(HV_MSR_SIEFP, siefp.as_uint64);
> +}
> +
> +static void hv_para_synic_disable_interrupts(void)
> +{
> +	union hv_synic_scontrol sctrl;
> +	int err;
> +
> +	/* Disable the global synic bit */
> +	err =3D hv_para_get_synic_register(HV_MSR_SCONTROL, &sctrl.as_uint64);
> +	if (err)
> +		return;
> +	sctrl.enable =3D 0;
> +	hv_para_set_synic_register(HV_MSR_SCONTROL, sctrl.as_uint64);
>  }
>=20
>  #define HV_MAX_TRIES 3
> @@ -416,16 +551,18 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
>   * that the normal interrupt handling mechanism will find and process th=
e channel
> interrupt
>   * "very soon", and in the process clear the bit.
>   */
> -static bool hv_synic_event_pending(void)
> +static bool __hv_synic_event_pending(union hv_synic_event_flags *event, =
int sint)
>  {
> -	struct hv_per_cpu_context *hv_cpu =3D this_cpu_ptr(hv_context.cpu_conte=
xt);
> -	union hv_synic_event_flags *event =3D
> -		(union hv_synic_event_flags *)hv_cpu->hyp_synic_event_page +
> VMBUS_MESSAGE_SINT;
> -	unsigned long *recv_int_page =3D event->flags; /* assumes VMBus version=
 >=3D
> VERSION_WIN8 */
> +	unsigned long *recv_int_page;
>  	bool pending;
>  	u32 relid;
>  	int tries =3D 0;
>=20
> +	if (!event)
> +		return false;
> +
> +	event +=3D sint;
> +	recv_int_page =3D event->flags; /* assumes VMBus version >=3D VERSION_W=
IN8 */
>  retry:
>  	pending =3D false;
>  	for_each_set_bit(relid, recv_int_page, HV_EVENT_FLAGS_COUNT) {
> @@ -442,6 +579,17 @@ static bool hv_synic_event_pending(void)
>  	return pending;
>  }
>=20
> +static bool hv_synic_event_pending(void)
> +{
> +	struct hv_per_cpu_context *hv_cpu =3D this_cpu_ptr(hv_context.cpu_conte=
xt);
> +	union hv_synic_event_flags *hyp_synic_event_page =3D hv_cpu-
> >hyp_synic_event_page;
> +	union hv_synic_event_flags *para_synic_event_page =3D hv_cpu-
> >para_synic_event_page;
> +
> +	return
> +		__hv_synic_event_pending(hyp_synic_event_page,
> VMBUS_MESSAGE_SINT) ||
> +		__hv_synic_event_pending(para_synic_event_page,
> VMBUS_MESSAGE_SINT);
> +}
> +
>  static int hv_pick_new_cpu(struct vmbus_channel *channel)
>  {
>  	int ret =3D -EBUSY;
> @@ -534,7 +682,27 @@ int hv_synic_cleanup(unsigned int cpu)
>  always_cleanup:
>  	hv_stimer_legacy_cleanup(cpu);
>=20
> +	/*
> +	 * First, disable the event and message pages
> +	 * used for communicating with the host, and then
> +	 * disable the host interrupts if VMBus is not
> +	 * confidential.
> +	 */
>  	hv_hyp_synic_disable_regs(cpu);
> +	if (!vmbus_is_confidential())
> +		hv_hyp_synic_disable_interrupts();
> +
> +	/*
> +	 * Perform the same steps for the Confidential VMBus.
> +	 * The sequencing provides the guarantee that no data
> +	 * may be posted for processing before disabling interrupts.
> +	 */
> +	if (vmbus_is_confidential()) {
> +		hv_para_synic_disable_regs(cpu);
> +		hv_para_synic_disable_interrupts();
> +	}
> +	if (vmbus_irq !=3D -1)
> +		disable_percpu_irq(vmbus_irq);
>=20
>  	return ret;
>  }
> --
> 2.43.0
>=20


