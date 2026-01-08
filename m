Return-Path: <linux-arch+bounces-15713-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 067D5D05A76
	for <lists+linux-arch@lfdr.de>; Thu, 08 Jan 2026 19:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 537DA300793D
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jan 2026 18:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A059428851F;
	Thu,  8 Jan 2026 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oAIUQvcN"
X-Original-To: linux-arch@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012015.outbound.protection.outlook.com [52.103.23.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AAB3090E0;
	Thu,  8 Jan 2026 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767898068; cv=fail; b=Po5gbXjiYEUcLAq5NbjWuhxciJyHLB1CjDj0WNnXB0I5uZxvNddWJCGr2WGzQBe7kR+D+8lKsrMmB2DmH5Wb6ChMNBEeTCl6vxNySIppoNe+TCmT3zCh/Z12TfKbRKYcyf7Qn763ySJznInBr6gxybqFbVaK45Gw2ndwmmz8rsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767898068; c=relaxed/simple;
	bh=ET/2+3VDp6+uc3bVybcsFSXoiVI0QqtDzNOmafjmSxM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lv+HAv8ueqwkCBN6bUYJxz0x3RURpxqA71EBt+AF6A5vNGmtI8mwjCcVNCPiXdXdQPgiRt+MKLfSKCMKqpl8UNJv+WGYDndlk+/sA+1Tgsopl/WV25AqLi4vEuciDJ1q+QLxNl3zD6RjsmbJGq1TT0oQNVW8BUhXafXySo5o8PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oAIUQvcN; arc=fail smtp.client-ip=52.103.23.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6+T8Ks9WnxlZbDGOyer+XrajQAV76NIGzgz7Ri8DHA6bHuU6o9A2f4cm1LWIWNg2JubObYF4RKM3DTZ6C2p2G2GS132D3TCU/gEmqfZ1XK74QBy3KLpMI7KXHcpQLslsPbmYUH1WqZxL7MH/OHWyY/i+BumK7sG0t/QeLILGx2/7Nm7WPu150EShy/Uy7eOb7epBxmqYjyKNLkXU/c78PyiKiNwjJXgkGe9rgyfCe+4Rqov7kMzwxLsb9zQvJq39R6Q7eLjEpbHKNg1XdhaY/vqSzgoNjnW1YTtXsE/krbNTQphdiKNRMbwpMYqFVLGUAwoZDkcWnzT/zkzhYrjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05XDJirDpfSHC5dPQ+s8aQRa1sj9tuqZwf1BTxjQALo=;
 b=VqMgnYA8u+/6hSQ4Dxlvz6+XGxyqqUphFEpbKWN4w/K2dbxDQdgTL/X7OSwnOQ9uN9bqKo0YbnhM3cICk6/vJ4yPCK/D6jXtP1YTUzbFretZgTyukEjnRSovu6B8w5k0JPIZl1KRvonnR3fgKS28/FEfdtQsb2AvriKvjdAQQkeKmt64AKYsOn4QWFuCzTrgDhvhPwr8f8nVqVqfvjf5F6kjk35rJaIvykjg15BFKUpuMEA790klh/ICDzhn84j4jd4dY+rpfqKydzlOViLk1CR2mVXg6nyrIFzcdW4kVEcofkpncau/2SJxILoJEb2ODwRC9oliLslNM8YDC3a8IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05XDJirDpfSHC5dPQ+s8aQRa1sj9tuqZwf1BTxjQALo=;
 b=oAIUQvcNDzE6KNplIRr2MGNYUqPAqwceV9oksOa64xStbaOxp9Np1c1W0gZvOA0HRNtMPHTK89UNpm/FyCKAOPlO7JbsoRr47k0rcjDCpjTtK6Jyit8CMfhOK8kjH7OUUdaFsCfDSSENNVlsQJg6lPSqPlAqU9E95lQ+x0JLvz6yqZfXal3Jf3DkiEQ+7G28/dn/g8dAEJAmuiqWTcJ6MSy6qKvxA2rlrY75OFWWiQ7mgiiqmAdNbJECA1gOQmuvRVQ9KgtkiUH+2uc50nm5cFFP/1ztfQa87eAi5m4KzC+RQ3/GxgEDNd+CnX33No5Ir0pTSxkp/zyKkkjqTD0k9g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7542.namprd02.prod.outlook.com (2603:10b6:510:51::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 18:47:44 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 18:47:44 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>, "nunodasneves@linux.microsoft.com"
	<nunodasneves@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC v1 4/5] hyperv: allow hypercall output pages to be allocated
 for child partitions
Thread-Topic: [RFC v1 4/5] hyperv: allow hypercall output pages to be
 allocated for child partitions
Thread-Index: AQHcaMpYMcvd+eE890K4YEStkk+XyrVIp9qQ
Date: Thu, 8 Jan 2026 18:47:44 +0000
Message-ID:
 <SN6PR02MB4157C3EF6617A7BA4CA9E432D485A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
 <20251209051128.76913-5-zhangyu1@linux.microsoft.com>
In-Reply-To: <20251209051128.76913-5-zhangyu1@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7542:EE_
x-ms-office365-filtering-correlation-id: 7117990a-d02d-4222-f7d9-08de4ee668d2
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6Sa9pKQ/z/1isoIHUJNjiMn6fGc2K0YHopN6916f0fbTgfKSxd3fbHeDSD2tgG7VDTQsuYkFr+zOh48nbxwXNkhMPscbxXa4FgVPuUyk4lujPA8oC+CcJaEYq2ObupkyWBc9Es/TEtDAVH6c+MDWxhXoqUwXlFptGnccGMgRGinkkxTREtT4Jgc/Xn+T1G0nxWaB61W6zKc7+iIzmAkT5Ro+lyxbxSK9pGmNDSrLWFPhmvQ3xCOkOhvPNeCY8NxLHHA5rYBSUIxskLOaAlSc7ol/n3QhnLs1tJdR1br4nSFyMlRj10mFQRCZQjKXThnkRsNVupIKoXzp6u7OtPMfE1HkNkzIdh9TDXHs9lLpjaR1Z047h4rsA/fop6SVZm6KpAN17ogJMDOQTJKv850N7KPh4yHfjIzQKOLPkFdMP6nOsgsWQrCPVG/0gUAzIGVjaRhKjbIt3QigUirn4U3Uk7UZaS5T/Q0+JlQbeE7Uh7A6j3KlYF9ZE/p3oOgCsVRISeCGmT15lUPUVO4deNkSmYuQ0ShD3a4U88xUZ+hyoq9X6MkNO5pzhh6RBxoaC5KuBHUC3gAOMdc4WdQF5+zLfPerb6fCoBly2Sbi0SMIqIE/EutwFfJaS4sjuswF9JTZq7Q5DaIl+VeiptsRgnKm7H7jj0FfZ3UPW+uFvZwFDg3OtvjF80VVIoFWKxHZWvKQOQxxFsvzA96xecO1/8KiTQFag/FbSKTzTQ614oHmgUFHs=
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|19110799012|12121999013|8060799015|8062599012|461199028|41001999006|51005399006|15080799012|31061999003|3412199025|440099028|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rzIMveZ4YBX1khqPwhRM2eh9fUUEBIpuOhb1mIeo4dAXAhKe8CbgmnRVxxlp?=
 =?us-ascii?Q?JKd7sx56Ht2IfFuBT14hP1CJA5GKMAEmSf4Oy8cz+v31qM33ZR5cHTR1udBN?=
 =?us-ascii?Q?z/0TVs7Pr2vyn8zLLiYNypaV8o+1hnCXB97BTh3XTCEhTayNKhKtnfCxPLZL?=
 =?us-ascii?Q?hrnoVuIzBX3CgpWoQt6tpeYAixxjrBsXriA9zXUio37gPekT7SXBf9FKYA4d?=
 =?us-ascii?Q?1d68RjgOzNVZruJJ0TdnHYDqq+MZQujHNAqNZq0C6F5tJRe6D70NRHVnXw6M?=
 =?us-ascii?Q?JDS5997mRa0KGSkgWRFV23kk7KaaFalsmNCyQPbDE7tYAi1w5fKEapfz6AQc?=
 =?us-ascii?Q?4d2mcc/4uCGu8MG/DWG86hKro59KURYr+AaK22ZKpYH9Aa8RELZ3QonQnXku?=
 =?us-ascii?Q?pwv6HHmAsek/37P1tI0Ge3tEG7ZlDXmlvTZli3EQIMbUuKLhzykKGJ/XHHp1?=
 =?us-ascii?Q?OJub8mhOfdwE/3wr4PaAMLOLWyU1LfvHxrIrlr/ghiDQxSpW0S1m9bZI5+SX?=
 =?us-ascii?Q?fwvdpNr1AlFpw592sOhesGRAx7f2qiHGoZQWbjS9XApzaMc0YUOILgzGnPc4?=
 =?us-ascii?Q?NubZUMsfWYjcg+DGKkUmHFVw2dj/Wn+xWaS0D3gKH/Utde54SI/0K+BxDCgM?=
 =?us-ascii?Q?15F0aKhAenSdjeatwb9qKTjkhoY+iQj7Mip3ZH7TKvCf1B6JG/BReMW2Rade?=
 =?us-ascii?Q?7GL0ZO0XWrl3etzDKg4azrz359+oydBpK8yTuO6pJtSTVQJ4D49Vpq7V2jpT?=
 =?us-ascii?Q?p8N9uk2e+Al9qmm89uEzTgh9FXEowphlV44o7cotxNoZvH1Yzj4/6yYRuNNf?=
 =?us-ascii?Q?PLdLk1Kp592i8Phk43rCznvWZOOUN46THgDza3aHKMunXFc9rc4LQNo6YUkQ?=
 =?us-ascii?Q?3EhiKis/enlIq0wFimz+9hML22mVkGcWRFCd+epfH753m8lRf5r0zLS5f/Gh?=
 =?us-ascii?Q?cN8p19Nf4gZrPla3B/ysmZrfOOmYAGQbLExE3t6x42pwQUC3Vft9qJ1C5utn?=
 =?us-ascii?Q?/dJePZKzXEP9vulVI+eRAOLto87FK8PmMI4zV3jU3QWbot+OaEGMn4JI3QSq?=
 =?us-ascii?Q?WHe+kggvFsCWDPeHqBCBzPYfLCGLqHekoYGmS1FrH8Os1ALi9oD3AFTVhbhG?=
 =?us-ascii?Q?W359vQrQdA0CQIknyOT00kuH7pKT3R7E+gtehrSlJxdDLVp4gWRfhQf0AXGa?=
 =?us-ascii?Q?XxMuVciFwdju84z+sB0QsOV1YZOYyFYzjH+R9LFJdW9iZysV3WiSocfno/kS?=
 =?us-ascii?Q?dO6alGpVrLQTf0ClRGq4W8pdm7TwqMa9uUoMPXKDjg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rnq5YWivPZA1IqpvHVmoa+2EjYbaB169sCHJgADQ5+CtbqnIp65gj87quzvi?=
 =?us-ascii?Q?FM6tIbmzSesCkSdf8f2na1ggUxwHKPrlDJhMTobo3jjRhE6PEO7XRTZiflgj?=
 =?us-ascii?Q?mUoEF5WGcSvF6spHtHTc5CyQRUSz7MDCQ2BHYimUaV4XFjAgEoRTZ9G5Mvy9?=
 =?us-ascii?Q?diX/PAET1cn0HKfLgJ3ZnE7y7HYsbh4AvBZSj63r7T5xpMEYaXbnQ7IaN69c?=
 =?us-ascii?Q?h/4YrABsHsK0wv4bApKkF5uNOB0JBUO3u0zUZZwFsuN7ok82bA80nwr8JE+l?=
 =?us-ascii?Q?rkANWdF9pVSfw92oAjhUmjTA3wGFzdxwlUVZDfR5Wp01Tgwki+1gdYwLVfzu?=
 =?us-ascii?Q?jwQVLEublLNroOAjR9NqQR+pl49VnhZnm2i/YzTHQzF7K+40lRxsbxnVC2Kr?=
 =?us-ascii?Q?6UQj5fwVXJr1ta4CcwQ17pAkrxpgHWtwGAX48oHIO/PSucW+MZhswTfKvZOY?=
 =?us-ascii?Q?zNTQPwfsFDQRI/Pd+VAt0VOsInskSLz/oJKw1ZmO2Ri1gvavDHTDvb8MHcaN?=
 =?us-ascii?Q?BKhgZgmTe0PHREdfhxM9xkLsYuJVR1Nw3H5W0n2kL3mvabyaTgdI8ceQYhZD?=
 =?us-ascii?Q?ZOwjl7r9/majS9GcFqUiozzexd13aa32lVnBOPo48hob4bBnVzDD0zSVSFyV?=
 =?us-ascii?Q?/r2clMbETYLeerbdNoxoba8jNCNkou+xfKsEy+12WZ+ZU7tdHDbE5VMCcMTO?=
 =?us-ascii?Q?/dX4Fv8fQfCtJcenNSRS90nb2/uzomZMSNWlroph3qEgT0yWxyxuMwrKq8ib?=
 =?us-ascii?Q?yd9h16S8j1pGHZbqJ21l0i/0fAXH1jqUyjuRj73O1nRINX1M6U+hySfA2TUp?=
 =?us-ascii?Q?jIz34jQkPiQjYQjGcfZRYjuT/G8zCw9qYV3fUBsA3Uac6ZfCmWH40b17lfD1?=
 =?us-ascii?Q?uIGApZkigrCnYSVwHP1rjgAafqq7nPSffzhwYip7+xCRoXWUKLCY1c1RE5qX?=
 =?us-ascii?Q?OG3KDT/CJGIzHDHJ0WG8jo6rwOyPwRtpnDKCdhqmpHxZiQVCBxMvxEoQWy3K?=
 =?us-ascii?Q?3Cw6VZS0cqDOoQ6jSH6h41iBvS8zajO0d6u/InwdGfydw8zaYnTVKt1rX2VQ?=
 =?us-ascii?Q?sBq/tUXsrOF0zXBN1+1iyGyrSe3859hRd0/6oxR1hIno+qUCxLEN4hz51rU5?=
 =?us-ascii?Q?cDfRWRl1H/0PtJIcgtvT4HJKcyhkRdHZsb7q6hxLzXFcmiZbJzPa+tKkeTIz?=
 =?us-ascii?Q?I4EcMnx1TNzAaRzopH6fCQjOOgxytFjiuC8a2xL9wHsidZaBxz2HmBDYbKHj?=
 =?us-ascii?Q?D6T5h6y8lRKbYYalNQih+BRyqzoAWX0hPP3odgQSv6lKemRa7MMXOBF+LB8V?=
 =?us-ascii?Q?qx4+u8OYwk2qiqXEF9hb15JG2flofnD67oqgQWD+TRgN/Rlu+wJvLiJemGKQ?=
 =?us-ascii?Q?yvAd5A4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7117990a-d02d-4222-f7d9-08de4ee668d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 18:47:44.1224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7542

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, December 8, 202=
5 9:11 PM
>=20

The "Subject:" line prefix for this patch should probably be "Drivers: hv:"
to be consistent with most other changes to this source code file.

> Previously, the allocation of per-CPU output argument pages was restricte=
d
> to root partitions or those operating in VTL mode.
>=20
> Remove this restriction to support guest IOMMU related hypercalls, which
> require valid output pages to function correctly.

The thinking here isn't quite correct. Just because a hypercall produces ou=
tput
doesn't mean that Linux needs to allocate a page for the output that is sep=
arate
from the input. It's perfectly OK to use the same page for both input and o=
utput,
as long as the two areas don't overlap. Yes, the page is called
"hyperv_pcpu_input_arg", but that's a historical artifact from before the t=
ime
it was realized that the same page can be used for both input and output.

Of course, if there's ever a hypercall that needs lots of input and lots of=
 output
such that the combined size doesn't fit in a single page, then separate inp=
ut
and output pages will be needed. But I'm skeptical that will ever happen. R=
ep
hypercalls could have large amounts of input and/or output, but I'd venture
that the rep count can always be managed so everything fits in a single pag=
e.

>=20
> While unconditionally allocating per-CPU output pages scales with the num=
ber
> of vCPUs, and potentially adding overhead for guests that may not utilize=
 the
> IOMMU, this change anticipates that future hypercalls from child partitio=
ns
> may also require these output pages.

I've heard the argument that the amount of overhead is modest relative to t=
he
overall amount of memory that is typically in a VM, particularly VMs with h=
igh
vCPU counts. And I don't disagree. But on the flip side, why tie up memory =
when
there's no need to do so? I'd argue for dropping this patch, and changing t=
he
two hypercall call sites in Patch 5 to just use part of the so-called hyper=
call input
page for the output as well. It's only a one-line change in each hypercall =
call site.

If folks really want to always allocate the separate output page, it's not =
an
issue that I'll continue to fight. But at least give a valid reason "why" i=
n the
commit message.

Michael

>=20
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> ---
>  drivers/hv/hv_common.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index e109a620c83f..034fb2592884 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -255,11 +255,6 @@ static void hv_kmsg_dump_register(void)
>  	}
>  }
>=20
> -static inline bool hv_output_page_exists(void)
> -{
> -	return hv_parent_partition() || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
> -}
> -
>  void __init hv_get_partition_id(void)
>  {
>  	struct hv_output_get_partition_id *output;
> @@ -371,11 +366,9 @@ int __init hv_common_init(void)
>  	hyperv_pcpu_input_arg =3D alloc_percpu(void  *);
>  	BUG_ON(!hyperv_pcpu_input_arg);
>=20
> -	/* Allocate the per-CPU state for output arg for root */
> -	if (hv_output_page_exists()) {
> -		hyperv_pcpu_output_arg =3D alloc_percpu(void *);
> -		BUG_ON(!hyperv_pcpu_output_arg);
> -	}
> +	/* Allocate the per-CPU state for output arg*/
> +	hyperv_pcpu_output_arg =3D alloc_percpu(void *);
> +	BUG_ON(!hyperv_pcpu_output_arg);
>=20
>  	if (hv_parent_partition()) {
>  		hv_synic_eventring_tail =3D alloc_percpu(u8 *);
> @@ -473,7 +466,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  	u8 **synic_eventring_tail;
>  	u64 msr_vp_index;
>  	gfp_t flags;
> -	const int pgcount =3D hv_output_page_exists() ? 2 : 1;
> +	const int pgcount =3D 2;
>  	void *mem;
>  	int ret =3D 0;
>=20
> @@ -491,10 +484,8 @@ int hv_common_cpu_init(unsigned int cpu)
>  		if (!mem)
>  			return -ENOMEM;
>=20
> -		if (hv_output_page_exists()) {
> -			outputarg =3D (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> -			*outputarg =3D (char *)mem + HV_HYP_PAGE_SIZE;
> -		}
> +		outputarg =3D (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> +		*outputarg =3D (char *)mem + HV_HYP_PAGE_SIZE;
>=20
>  		if (!ms_hyperv.paravisor_present &&
>  		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
> --
> 2.49.0


