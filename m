Return-Path: <linux-arch+bounces-12892-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C66EB0E2DE
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 19:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE78C1C85060
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 17:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4812F281526;
	Tue, 22 Jul 2025 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rEiQRwCl"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2027.outbound.protection.outlook.com [40.92.40.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DCA280338;
	Tue, 22 Jul 2025 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206280; cv=fail; b=YZTDYmkHfLzlKQF4H6OEpy+06bgxuObGg7GNOGSJpm63HmoaRFUlXJFBv+K085tucJLFQETa1JoMgV3+STwDlibn+tYTCSnm3EpYaP+85Gn9V5utgaQTI4/m4Fq7T61smO8SPUl/dLECkz9j6KobUXhVVP8aIcpa6p9SsmL9Dl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206280; c=relaxed/simple;
	bh=HTgWVpguyx1o9GXxRgUcq6AGZ01Om7dJV0dOyjPW38k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WHKB6FdcrUmpi0jxVN3i8XeZmT88jHaCQdLEaz8N17DCg0cY45CiEhPTtHIWBMKJrqtjtiihlkeVqsgJQ4HsTE2EI7d0L2cvnnARaBmG3qJ5O5U4E39KrNx3t8Ekp/XcGUZPe9ZjaXgs0yY+NA6B73YoC6RMz3ig3tBttZZ+emM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rEiQRwCl; arc=fail smtp.client-ip=40.92.40.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzfUCn6uX2ydN0mvaPwiAbBxvIC63Jg7tLwCPiChNU4wwSeVkfmuO/Aag8xeXQu0GeJBQgjG5CMqnINKlqSjaWlyyLuBoo7gkqM1oKSUxOHWPR3ILEOMQcrAWhsku97rR9GfNXAriviAOeV19NI5yhC582I7yF3o1bs+pO6o1/r2m22J+akrJvZn161zM3lPP5hRfcxG8ryWCePv4SloRmFqE3nO7pkzQbK69KBLHmQWfcJU2g4sLw1YIvCeVUOps5D5Z5vumm/HOu2XqVzZJ8Q/pSlINPcrv9QMlAw3d6qnNYBPwGr0UQ8FYWzEKY/dynMLCT4wk0h/Zto6fOF6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xz65ZGM7OsbTQX2G+VaLCAEq+eA1HWLGTOvCTaxoT/E=;
 b=M62bPub0+ZbWPZRJ7bGLCz5A0kPNK/fIb2Zk8A7U9tYvjLLZHxQeQ5RUOZVVhKW+biIdFkz4PwrrF9lMMbQqioIwkIsobj6paAy/paELKOOY5bbP5HWCruRWUbWuhKM/8ZaPExgxGwC1VoqtD+iMAniy1qgmHo6CYZaIDNAV+x3PeM4EpN/RC4OjmVTuwDlTyiARXjhN9Kd4hRh+PaDKwbsXgvBaACUAOBYRPQ4wIuQKRFun8TPEya6zZrp9qAJmk4neldvVjv0+HkGQuIiMB6wNxX8AlrmKNaMkCjgMJXgLzwNyBTKvfqFeaOhoBkJqcAP6rIqfGF3afiTDxCvGHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xz65ZGM7OsbTQX2G+VaLCAEq+eA1HWLGTOvCTaxoT/E=;
 b=rEiQRwCl/zsDq4SPGAR97VafCSeRegIIGOWFIkyUikwu811X4kTG5U8qgxRWckXf3fYacdPtgQX5My/zMlsoCdWnyK9BDiLvgtZ50v4z/CVoCrPFY1LgYqzKYFoZMdPCJPeknOE6xrVZB3RnQbirz2i5prZ31e66sTykR/30RE2GzwVi8A9RbCkV9sSd+4I5M9HoeZNku/QVZzyb1Sy3E8hND9R43Ak7aS/IemIwWBaTXlvMIMfJJ4SKKJte4HIInuZOLmHrs1Dxuhy8mUI3dFed/Ga45q9G1joBfZfmkMXvbHbRtO1NEbtPONaAt4g7ntLiDuJUZbJMidZO5yC5wQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9201.namprd02.prod.outlook.com (2603:10b6:930:9c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 17:44:33 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:44:33 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de"
	<bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "Tianyu.Lan@microsoft.com"
	<Tianyu.Lan@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v4 09/16] Drivers: hv: Check message and event
 pages for non-NULL before iounmap()
Thread-Topic: [PATCH hyperv-next v4 09/16] Drivers: hv: Check message and
 event pages for non-NULL before iounmap()
Thread-Index: AQHb9QzbPfP7QI3lZUyGYXF+BSlQRLQ4mpPA
Date: Tue, 22 Jul 2025 17:44:33 +0000
Message-ID:
 <SN6PR02MB41570DA92377332FF272DF56D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
 <20250714221545.5615-10-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-10-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9201:EE_
x-ms-office365-filtering-correlation-id: 26e6d20b-1db8-4883-f45d-08ddc9476b56
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZcnlGMCdwv0d26z3osHHUiO2vE99knLqEYPiar7sCNiyMcCA8GYPc2tubrxF?=
 =?us-ascii?Q?76TVSjgZVTQf8vsblUBV/zJmo6fhJjFahlIdLw1VBvBLogAFR9Z9WgA2wWtI?=
 =?us-ascii?Q?TQgUntxj6wPQnQIFWA9CCZXpcrgc6qd81/BhPm/n4fhZFnEZI8+QFA7tiEI3?=
 =?us-ascii?Q?YopmGkAvyK6/ojnmVzA00Yid/Qp8oD19oXvyY34mpGUFsOIbniqDzN85bgQ9?=
 =?us-ascii?Q?W39HM3yV3Az7emMpSJwIZOzHoy4rJtkUCfFAhNwvc90+I16tTrqjaOL1NHi+?=
 =?us-ascii?Q?Y/9oI9dvKaSHAjgzHBPCZnvqKzPk2xUFvezyyp0UXuu+Kkz4nNaRFE1Tthye?=
 =?us-ascii?Q?P4LImJHTXF4VaBQ/olvOfsYgtMvwDG+Rj56+rMDbQv3dfbDf5Dg1G7OLBUjq?=
 =?us-ascii?Q?rTaNVnwJsPNgLUfIsvOfdojkHyW4zUYxLWLb8qzjFUerFGmbJgApb810Gx8/?=
 =?us-ascii?Q?fp/MEp0ICVo+B4XChy/aUgNStP0U6Wmk7RSmMm6jVuRgeBTHeMvhCShfpZK5?=
 =?us-ascii?Q?ZEA1HVgJh/XDtDTd3pJX63O6R6SOASU3K5mS4fYixQvHpuyV9HUkaob/EugV?=
 =?us-ascii?Q?rdwAIDGqdnAvKHJjQUay48pjW0kCbEDUeLrLui6NGo1UrFH0orfETIWi0rw8?=
 =?us-ascii?Q?u8nkDIo8YRQEcHjvao8a14z9f2BAlLjID0ur3+PVo4h4g5tikddivRc9/yHO?=
 =?us-ascii?Q?hHUubOlNWlms5URxJC8k1jUsUMGhd/SBzg+ozECQUyg49XEKeJmC1m625Ljs?=
 =?us-ascii?Q?HrsNzbPjkfxU1mONEq+66oTwQGGtmb1ni6LAOy4FpHrqbbfaJJOldP77VMP0?=
 =?us-ascii?Q?uWlV4kMkgBJSS2oV3GD/jqIWLhwi/c28bIMiLZ5R1bnqUfZhv95LlXmXl9wa?=
 =?us-ascii?Q?FR441ScoXX5yRiwBlHFzhIExh4paf2wbDSLVzOBszKfi/fog6KHVYMce2AEQ?=
 =?us-ascii?Q?Sqo8fUrqGrCtAZ5xnE9xACb7CwW2W+0JGa0U0S8hwD70sa1nKZVibN28QHiv?=
 =?us-ascii?Q?oCL5lmLnDYv2aIpvcYznnIAupQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pYsEwwIX+S5ft3TXk+0B4rkpsLxdea1hwqstcGmgUfI/uE4T+LQVEX9VRg2U?=
 =?us-ascii?Q?sj2kgePkVegS2hYzxz9Qh3doVTLrqTIn6KrnAOqTmbwZVu4pHUKnnOf6rYp8?=
 =?us-ascii?Q?B8p8yX9FA6vygNGlgflQB5npFoZgso6bO25JYT46VAaTV5Wer2i5snU10U+A?=
 =?us-ascii?Q?Cqodq27gEdEH15D5aYIr70M7Tb8NhlmQyuAAmSFTGO9LLdCCAF8IA7JpA1fb?=
 =?us-ascii?Q?WjBeXmRNeHWjEukiDvOURbAvM/ZGYysJEwhTX/FBPeX/To+UC9bRjFA5Bg2k?=
 =?us-ascii?Q?V5bhapWCLDW62BHWc8lBZt8KVtk9FbjO6WNvJ8HyoT+Trtzxu/rYak6SDOHs?=
 =?us-ascii?Q?0CLxNfO/Sci2Doh44tAPstaLqVcXM1ToQvHPHRcaGafyvM/gDlORGHHx/8wy?=
 =?us-ascii?Q?NvpFbemFpU2eiznPX7oSqsuGrD9vEgdIqG3etDSvY+ptR45uLFvylsxKp7yW?=
 =?us-ascii?Q?uwFy2nXSjqBauz6FVtNt2cX/bJqvexEJVZkexS6CgTDHf+lAgw9EkGW7+EJw?=
 =?us-ascii?Q?WYarGAh3qksa/RMstnRg6g9jzPHVqrrDxUYxfiKn4k5B+PpICT87I6TZJrxd?=
 =?us-ascii?Q?ZRGobkZtsARceNnkyx5j7dhXHbQjr63cKg0hDWYCxntGoBy4WnhOkmETQ3zg?=
 =?us-ascii?Q?wFMH2ih/rcAACbSzw49YHbPb5HfFlZDMqvGYzBXENYbaF5hZBmN5WwHA8xQh?=
 =?us-ascii?Q?UB4xv/C2An5QB4DB1r6MKJJ1s8a1FiW4YtJpRWfsw7wDTJKtEVcT4X/I9u3o?=
 =?us-ascii?Q?ymWAz8VAelWKnZpzyN132FjgEzmvEZNBZSGNvwBNnBje9G+R0HnbkAIN2Rrw?=
 =?us-ascii?Q?uuegSNnw172PFfoZ3PGA/j50jChyXBu9165hxxhM4jcxfZfNdgJVbgYvnSOK?=
 =?us-ascii?Q?KKrjxGid25QZLjrRlt1gQK8GVpY6YcvRhza3xYLnsTZ+KhSglY7qxzBRFkVc?=
 =?us-ascii?Q?FXksPU+nD+qlJCAQUqZLcX9FfzNuHjp3JlbmSdjWPq18x2QDZe1EwnED8xLg?=
 =?us-ascii?Q?S5RfVjUmWdYkyDUCDGHP0c7rSCDgz0HjXH4iyrfYBguy8j/PkcAKT0wtZaVR?=
 =?us-ascii?Q?h60Rp6rJXi36tHSZQ0udWmlApKXpuekm8I0uPbjXVJqk0ilp9AZaDK6u73f+?=
 =?us-ascii?Q?+lCEwZDlXq9snctW5WEyzmDkgXb0PPBvl0u0yE9ullfvAshL9f5YEOPGz8Ly?=
 =?us-ascii?Q?t0shTQDDWhSrYZv1WEiQaVNoLWxvqlto2n/nLCTDIJjk888t556XKvN472o?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e6d20b-1db8-4883-f45d-08ddc9476b56
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 17:44:33.7079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9201

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, July 14, 2025 =
3:16 PM
>=20
> It might happen that some hyp SynIC pages aren't allocated.
>=20
> Check for that and only then call iounmap().
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/hv.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 820711e954d1..a8669843c56e 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -367,8 +367,10 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	 */
>  	simp.simp_enabled =3D 0;
>  	if (ms_hyperv.paravisor_present || hv_root_partition()) {
> -		iounmap(hv_cpu->hyp_synic_message_page);
> -		hv_cpu->hyp_synic_message_page =3D NULL;
> +		if (hv_cpu->hyp_synic_message_page) {
> +			iounmap(hv_cpu->hyp_synic_message_page);
> +			hv_cpu->hyp_synic_message_page =3D NULL;
> +		}
>  	} else {
>  		simp.base_simp_gpa =3D 0;
>  	}
> @@ -379,8 +381,10 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	siefp.siefp_enabled =3D 0;
>=20
>  	if (ms_hyperv.paravisor_present || hv_root_partition()) {
> -		iounmap(hv_cpu->hyp_synic_event_page);
> -		hv_cpu->hyp_synic_event_page =3D NULL;
> +		if (hv_cpu->hyp_synic_event_page) {
> +			iounmap(hv_cpu->hyp_synic_event_page);
> +			hv_cpu->hyp_synic_event_page =3D NULL;
> +		}
>  	} else {
>  		siefp.base_siefp_gpa =3D 0;
>  	}
> --
> 2.43.0

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

