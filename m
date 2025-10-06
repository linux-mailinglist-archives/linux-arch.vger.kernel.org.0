Return-Path: <linux-arch+bounces-13932-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FA9BBEC04
	for <lists+linux-arch@lfdr.de>; Mon, 06 Oct 2025 18:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F823A37B1
	for <lists+linux-arch@lfdr.de>; Mon,  6 Oct 2025 16:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A13E2874F2;
	Mon,  6 Oct 2025 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qNf6UVom"
X-Original-To: linux-arch@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010026.outbound.protection.outlook.com [52.103.23.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE221D7E42;
	Mon,  6 Oct 2025 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769717; cv=fail; b=REpzkB9kXs8aoFJY1ae6JD1itWfQgBicA3lYQtBcsYIHB3dB9Xkp34ePktAkzURJXS/fbYS/eEln4E0XS6WAqcOIYWu9ygy6eR8bX04qOACSZweOOsPu7lTnFlSWloqGBpH9d3IMCLdEizIlYFJ8PMCEGGuq/MKRZC10blxQF7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769717; c=relaxed/simple;
	bh=CWWdPOcwYZGPo2xJXrBpeNSGK6Gzj1B40K4FzTYeHmU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=paq9J9NkqZUZZaUc9WOKFm2o+ozFOrGqwNMkggVgX1pmQeJRJorUJM2Gr9jeoVZpSBwALRQd0m0s3+tcv8BYSfkMzeDC9xbIsZnXgBs45p7BHZncuucHwgb+qp7ZHCN+RFfSbtJbZxz6v3x+j2o4NIvfvknoYwMY3qBKu4QZ424=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qNf6UVom; arc=fail smtp.client-ip=52.103.23.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1S+zEzWl4VcKpddBPVH2WIXz/9cwU5PtotC4nd2JqxxRWNSa0YhuRVLsRmMMmbZqRD5665RxBsClTfckXaOWU/E+t7HgSTczMUE49X+L1M3jVQrSd+mQW7+sw1NQHCDONNYMAXIFNhmUyHfHBGJFQagBFHNviDGpv3lAjc+X3Ckutjuyk5+hbMcwToKAqER/ORbuo5JmCn3X9sCM00vH/0O/kmXHIpB65pWv/UwPRo/sNSnzA+fHwkIULcmz7Oegr0MRi037vAGFNY1zXWuYiuLPKL4pI08/KXWsku6NZV0eWs9elpEFUPBEI6Wug/Z2ldEekkYIRBec9/rw03Vbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CndAPr31jxDDu/CeKEs0aj1fFk/DKpPbBuC6ygheEE4=;
 b=kB54J8QZi4/QVk//f7l2Z9pagq2Ls0Ao6Rnv7CSn6vn6i3bbOumWrPvx6SzVzry9J/dVBb5BVVXQEJ2oewrQGyb5RXjWTSG4MKC25Dq9U5v7Mk6vH2foZIv07aylS5OhjNL8mQhmjjkrr2+heP+xm20z67RQVmcULBynSJimMe956mmMxnanMna4haThAml123oFxgnTnQGuFhFvIqTVVmO7X5VyjIRft5UwAqHODgchP/rSXLphStSfXuQU0N6+GsOuXlVIV6yrZO4BZ7vZ2qYNnQhdDcnUje+QiTkhugyFNjFDwOTkGfwGdwtjKBXNO5zbCp43IPNZbPqHF7f5WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CndAPr31jxDDu/CeKEs0aj1fFk/DKpPbBuC6ygheEE4=;
 b=qNf6UVomKCTE/cgvOwikULKGfhTVD68TtEHXqg4VF0YyvrONTFTH1ODrt7dfUFyX3QGp0r4sdDMuvTd73fXEY8O98HnBlh1CkoKf847/mZmNWdE28W2UqYuUkpss1T+/EO6HlGyCEsm+yvdo/rcsXdN2svBYxz52TEjJKq8bbyUOWiBDhxsxLxRrQwa6JtI0clg6FtIxoZYpM23xsEKmy3vPS67yhBkTbHjsk6VDuFR8xEZqSNH0kBwzYUA5M0qlirRMVMw6P49FdoerIXN2b0DNpuCyC9jJYmIfyIHx+8iZWEJZ3d+H+Wn6NlMmMCdA0/dV+vwCjT2TiOTsppKGJA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6675.namprd02.prod.outlook.com (2603:10b6:a03:203::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.17; Mon, 6 Oct
 2025 16:55:08 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 16:55:08 +0000
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
Subject: RE: [PATCH hyperv-next v6 01/17] Documentation: hyperv: Confidential
 VMBus
Thread-Topic: [PATCH hyperv-next v6 01/17] Documentation: hyperv: Confidential
 VMBus
Thread-Index: AQHcNLUEcZ7kW6IS6U2Oe56MXqLpG7S0eAgA
Date: Mon, 6 Oct 2025 16:55:08 +0000
Message-ID:
 <SN6PR02MB4157D77CB5537E4DBCE4F4B5D4E3A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251003222710.6257-1-romank@linux.microsoft.com>
 <20251003222710.6257-2-romank@linux.microsoft.com>
In-Reply-To: <20251003222710.6257-2-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6675:EE_
x-ms-office365-filtering-correlation-id: fdf0e7f0-6f06-4ca5-54b6-08de04f91b0f
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|15080799012|19110799012|12121999013|461199028|31061999003|13091999003|56899033|40105399003|3412199025|440099028|10035399007|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?m7Gch3u3kFy3wstfMmaNRoLHJxh4H3wqdCnu3Tc1hviGXeVkzN1uSgokuna7?=
 =?us-ascii?Q?FSTfLb4ZGs+E54xogsIbFvaAL59uOTVgjmEx/TwU/m1hlubUdqG8nipQlXrt?=
 =?us-ascii?Q?/S6FdJeLgdziHGeZ7vmruccVDyVZ3nRMdCu3CZW1RUAzp0xJh0sNjv7EnzAs?=
 =?us-ascii?Q?ZHIMDvqXrP8iNKvd96ykNDPfXpouECcwZK0OJA9ZINyQOgD5Ka0x0kKW+J+o?=
 =?us-ascii?Q?x+IpSVhlhMFEDuVSABHYNOp+DKB1YnS6Tm6zHm7rLbw5V24KiZKiQ//6/tdc?=
 =?us-ascii?Q?RCV2BccM5K3TflKWMgJ4QKhO3w1q0j+jrlJS2He9T2r8vmnoz7IkKUVz2M/E?=
 =?us-ascii?Q?0ge5RcifhfmH1KcSMXZAWPPJdjUC55SP1qDE/zlpBdRba6Y4HjbClJLCnygl?=
 =?us-ascii?Q?yf9/WzS8VYB7eZgBF8ssRB3CYt9UdGwuiDzhz0orQlBruFb/+tkL8Fu3oDYd?=
 =?us-ascii?Q?HMr6smP9q2LEC9Vfi7HguVrFvPIrzH6HLEwsMD620C2JGr6rjr1HI1WXk94p?=
 =?us-ascii?Q?BYVdF2Eq6NdjdAuHKPu7qwMmbDdgEVheNq+u7jTdjCs18SI/sKiTvdqGWzNq?=
 =?us-ascii?Q?sKUKWEeXR8wseGo6nPnKkFQjrjt/9HQGW1pjODfwj3ryFY3NsdYqyvhEajmQ?=
 =?us-ascii?Q?VrJTImx2jas1Xy6omMbZ4Rr/IGNPziDnoFFPQRPKY/JDPhuzSm0zIOmdmCQO?=
 =?us-ascii?Q?hu+Bi33iXMtWELrSx3RjLkbn/FP6wdOHxy2pOVrNdA0FPgIOQbgMF7zfS+GY?=
 =?us-ascii?Q?aJ/6RMG8xmXvyicFRLGuxldJc8L9ga+1woWvZzhd54vGffy+ihYF/TLRSoEv?=
 =?us-ascii?Q?t1mpv6B0tkVLFoFByWWgCTsQ3ayLS3KrlyDX2ADbpCoALTksLEx3CaG0kds5?=
 =?us-ascii?Q?g520fzxctPiNcjhLceUJis7WamHH447lBFUpES9wzzRF0b7mqhdZLH6ql3i0?=
 =?us-ascii?Q?qWLYivziKQ7JdGWz6OakIXt6uW+4rF9wr3R3/t2V5pJTFOYuwFqHTAewAXR3?=
 =?us-ascii?Q?/C8RLIvSz3UbU63gtISREbJ+YYfxJZ/O4SYN38pTbUIcbf1jVC+MaoL/i6BY?=
 =?us-ascii?Q?vLBM7lWpYhJceaU2ZO78spSoiRz82jjs2R0LrGVecse/a55AKc/nxic6mxn9?=
 =?us-ascii?Q?ibRmn0tVXWx4vN3L12hwkGmoutGCcEsNXy/qGVW9xfnfgadsN69OmXzcaL0k?=
 =?us-ascii?Q?Eke7qsoKTGqWNIFXfR2JTjpx6K6yTnNpkF9WwDEFQuYQNTej8PvZZSpYeuJW?=
 =?us-ascii?Q?QlVRIE0tGrYEiMtNh+lG?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0FcuU/hWHh0RyPNduyB0/5j6mwWcQSlhj3q7x9zTJLUSgUFTMbDegvLoR8xC?=
 =?us-ascii?Q?Q7yXXzrn6o8vxaY3GKmlibRLL4ODeG+Dopx7qP+HAI6XHesSxG9Sx7EuZNdW?=
 =?us-ascii?Q?WpZg/Y/okaAPw8XQI9PmVCl8kHzX7iUYxSuU0qF9l3l9kXQ0COdV7jS+Taxv?=
 =?us-ascii?Q?+DBFpE2Di40F+HXd+thV5qyGFjBTBlzceYaOyYtio5f1ChwLFd37OyQZ4FoB?=
 =?us-ascii?Q?txpxCoTAAfPwZVnXoK0GXEJcHXzE/XCurU8jTxtfR3Y5DV4jgbBmHubAXRWF?=
 =?us-ascii?Q?rJX3Cmz8QF+Y071REizHQnzn3BeHQhFuW8eQudLfm0QX7Fc3NFojDzuxVS0R?=
 =?us-ascii?Q?v7kqfPUK0+A0lCjPpZKkxgqaN6Gpw1rPyzZ4r1PYGFynkDq5i1frHRqe96Io?=
 =?us-ascii?Q?WIQytlswqXWJwFq90GuKGnhjgNyb78t091cGZ1XLphhtVBBDGjevfxQ6gbLg?=
 =?us-ascii?Q?lHSMNWxIcsYW0OmIFBOUCdKUWRKyl/pn5pFJCoL8v01+AOVKZaHDOOYZbGNf?=
 =?us-ascii?Q?g6NkzQyew9P5X/7iBXdXgTib6x+WzXnp1ebkEj5h4DvFI9r3gCFeStDeYgeq?=
 =?us-ascii?Q?Qz/7wlsyVAETq7to7w8UK5wNZkbLYLdPTlOPAQhK6zPrC71mdLg9tQ3SCRxV?=
 =?us-ascii?Q?B2oeuMjbT5MXO7VM0Vt2r0H1wdN0O7nOwTtdsn+yUURBszResS2UFxorr9oq?=
 =?us-ascii?Q?fPH43GS97sWeKq/a4l+0vmrU3YohmCgJ+eWtwHJLWzdZTeU5txW2UPYfArfK?=
 =?us-ascii?Q?sF+sGK2zAvoIBOnBplZ41FwwGBE7i1Lo4slG1RRjfo82TjPFbvzBlOhiYJ/z?=
 =?us-ascii?Q?YwU7LwWQKW28BZiInXvvdDPGqBQs7kFB+Z3iLm1Y/erEvKcnCLDFzpKbmrpr?=
 =?us-ascii?Q?L07PB0KhG13gmTxHOfWpCViNC+v8f5krBkOvfXPhloBZwPePhID6V6HxaAU2?=
 =?us-ascii?Q?0rpDROQP3kVHveYcAuLpE+ui+nrUUR2cLTTbdiXfBsP0VPNX8rNND8I7B+1T?=
 =?us-ascii?Q?OLzv4IBeGQWaMgzsHSAARZWjVv8nh8Y8RplL6bnlMo9jtORccG6fB8o3PeZL?=
 =?us-ascii?Q?Btq8U0dXTYMioGO4Lfj4wlPlBrWbU5wvxp5XALi+KuX1MDfpbRfCkSqeVFQN?=
 =?us-ascii?Q?Tq0juKEx4jT4aw1BzBiBvMQv3e53gPkHrY54IIA7RupKqPEcruOXJ7KdHenT?=
 =?us-ascii?Q?FBZzPAM+mbjSVGnsGwYuifaqMFqDgX4DHUp8hOl6sSGWzAjfJI47TXdV2UE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf0e7f0-6f06-4ca5-54b6-08de04f91b0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 16:55:08.0178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6675

From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, October 3, 202=
5 3:27 PM
>
> Define what the confidential VMBus is and describe what advantages
> it offers on the capable hardware.
>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  Documentation/virt/hyperv/coco.rst | 139 ++++++++++++++++++++++++++++-
>  1 file changed, 138 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/virt/hyperv/coco.rst b/Documentation/virt/hype=
rv/coco.rst
> index c15d6fe34b4e..e00d94d9f88f 100644
> --- a/Documentation/virt/hyperv/coco.rst
> +++ b/Documentation/virt/hyperv/coco.rst
> @@ -178,7 +178,7 @@ These Hyper-V and VMBus memory pages are marked as de=
crypted:
>
>  * VMBus monitor pages
>
> -* Synthetic interrupt controller (synic) related pages (unless supplied =
by
> +* Synthetic interrupt controller (SynIC) related pages (unless supplied =
by
>    the paravisor)
>
>  * Per-cpu hypercall input and output pages (unless running with a paravi=
sor)
> @@ -232,6 +232,143 @@ with arguments explicitly describing the access. Se=
e
>  _hv_pcifront_read_config() and _hv_pcifront_write_config() and the
>  "use_calls" flag indicating to use hypercalls.
>
> +Confidential VMBus
> +------------------
> +The confidential VMBus enables the confidential guest not to interact wi=
th
> +the untrusted host partition and the untrusted hypervisor. Instead, the =
guest
> +relies on the trusted paravisor to communicate with the devices processi=
ng
> +sensitive data. The hardware (SNP or TDX) encrypts the guest memory and =
the
> +register state while measuring the paravisor image using the platform se=
curity
> +processor to ensure trusted and confidential computing.
> +
> +Confidential VMBus provides a secure communication channel between the g=
uest
> +and the paravisor, ensuring that sensitive data is protected from hyperv=
isor-
> +level access through memory encryption and register state isolation.
> +
> +Confidential VMBus is an extension of Confidential Computing (CoCo) VMs
> +(a.k.a. "Isolated" VMs in Hyper-V terminology). Without Confidential VMB=
us,
> +guest VMBus device drivers (the "VSC"s in VMBus terminology) communicate
> +with VMBus servers (the VSPs) running on the Hyper-V host. The
> +communication must be through memory that has been decrypted so the
> +host can access it. With Confidential VMBus, one or more of the VSPs res=
ide
> +in the trusted paravisor layer in the guest VM. Since the paravisor laye=
r also
> +operates in encrypted memory, the memory used for communication with
> +such VSPs does not need to be decrypted and thereby exposed to the
> +Hyper-V host. The paravisor is responsible for communicating securely
> +with the Hyper-V host as necessary.
> +
> +The data is transferred directly between the VM and a vPCI device (a.k.a=
.
> +a PCI pass-thru device, see :doc:`vpci`) that is directly assigned to VT=
L2
> +and that supports encrypted memory. In such a case, neither the host par=
tition
> +nor the hypervisor has any access to the data. The guest needs to establ=
ish
> +a VMBus connection only with the paravisor for the channels that process
> +sensitive data, and the paravisor abstracts the details of communicating
> +with the specific devices away providing the guest with the well-establi=
shed
> +VSP (Virtual Service Provider) interface that has had support in the Hyp=
er-V
> +drivers for a decade.
> +
> +In the case the device does not support encrypted memory, the paravisor
> +provides bounce-buffering, and although the data is not encrypted, the b=
acking
> +pages aren't mapped into the host partition through SLAT. While not impo=
ssible,
> +it becomes much more difficult for the host partition to exfiltrate the =
data
> +than it would be with a conventional VMBus connection where the host par=
tition
> +has direct access to the memory used for communication.
> +
> +Here is the data flow for a conventional VMBus connection (`C` stands fo=
r the
> +client or VSC, `S` for the server or VSP, the `DEVICE` is a physical one=
, might
> +be with multiple virtual functions)::
> +
> +  +---- GUEST ----+       +----- DEVICE ----+        +----- HOST -----+
> +  |               |       |                 |        |                |
> +  |               |       |                 |        |                |
> +  |               |       |                 =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D                |
> +  |               |       |                 |        |                |
> +  |               |       |                 |        |                |
> +  |               |       |                 |        |                |
> +  +----- C -------+       +-----------------+        +------- S ------+
> +         ||                                                   ||
> +         ||                                                   ||
> +  +------||------------------ VMBus --------------------------||------+
> +  |                     Interrupts, MMIO                              |
> +  +-------------------------------------------------------------------+
> +
> +and the Confidential VMBus connection::
> +
> +  +---- GUEST --------------- VTL0 ------+               +-- DEVICE --+
> +  |                                      |               |            |
> +  | +- PARAVISOR --------- VTL2 -----+   |               |            |
> +  | |     +-- VMBus Relay ------+    =3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D            |
> +  | |     |   Interrupts, MMIO  |    |   |               |            |
> +  | |     +-------- S ----------+    |   |               +------------+
> +  | |               ||               |   |
> +  | +---------+     ||               |   |
> +  | |  Linux  |     ||    OpenHCL    |   |
> +  | |  kernel |     ||               |   |
> +  | +---- C --+-----||---------------+   |
> +  |       ||        ||                   |
> +  +-------++------- C -------------------+               +------------+
> +          ||                                             |    HOST    |
> +          ||                                             +---- S -----+
> +  +-------||----------------- VMBus ---------------------------||-----+
> +  |                     Interrupts, MMIO                              |
> +  +-------------------------------------------------------------------+
> +
> +An implementation of the VMBus relay that offers the Confidential VMBus
> +channels is available in the OpenVMM project as a part of the OpenHCL
> +paravisor. Please refer to
> +
> +  *
> https://openvmm.dev/
> %2F&data=3D05%7C02%7C%7Ceb6de4b7295c4e8a8ab908de02cc219c%7C84df9e7fe9
> f640afb435aaaaaaaaaaaa%7C1%7C0%7C638951272987274372%7CUnknown%7CT
> WFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIs
> IkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D9iTXf52zezdCCpMv4
> wv1S1AkWvnokRyXJD7hF3vU6h4%3D&reserved=3D0, and
> +  *
> https://github.com/
> microsoft%2Fopenvmm&data=3D05%7C02%7C%7Ceb6de4b7295c4e8a8ab908de02cc2
> 19c%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C638951272987295766
> %7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwM
> CIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D=
r
> Dp0el9NwDfSpRLSTmdLQgIqXqgLxrFrWJFcZcgb3Zk%3D&reserved=3D0
> +
> +for more information about the OpenHCL paravisor.
> +
> +A guest that is running with a paravisor must determine at runtime if
> +Confidential VMBus is supported by the current paravisor.The x86_64-spec=
ific

Nit: Missing a space before "The".

> +approach relies on the CPUID Virtualization Stack leaf; the ARM64 implem=
entation
> +is expected to support the Confidential VMBus unconditionally when runni=
ng
> +the ARM CCA guests.

s/the ARM CCA/ARM CCA/

> +
> +Confidential VMBus is a characteristic of the VMBus connection as a whol=
e,
> +and of each VMBus channel that is created. When a Confidential VMBus
> +connection is established, the paravisor provides the guest the message-=
passing
> +path that is used for VMBus device creation and deletion, and it provide=
s a
> +per-CPU synthetic interrupt controller (SynIC) just like the SynIC that =
is
> +offered by the Hyper-V host. Each VMBus device that is offered to the gu=
est
> +indicates the degree to which it participates in Confidential VMBus. The=
 offer
> +indicates if the device uses encrypted ring buffers, and if the device u=
ses
> +encrypted memory for DMA that is done outside the ring buffer. These set=
tings
> +may be different for different devices using the same Confidential VMBus
> +connection.
> +
> +Although these settings are separate, in practice it'll always be encryp=
ted
> +ring buffer only, or both encrypted ring buffer and external data. If a =
channel
> +is offered by the paravisor with confidential VMBus, the ring buffer can=
 always
> +be encrypted since it's strictly for communication between the VTL2 para=
visor
> +and the VTL0 guest. However, other memory regions are often used for e.g=
. DMA,
> +so they need to be accessible by the underlying hardware, and must be
> +unencrypted (unless the device supports encrypted memory). Currently, th=
ere are
> +not any VSPs in OpenHCL that support encrypted external memory, but futu=
re
> +versions are expected to enable this capability.
> +
> +Because some devices on a Confidential VMBus may require decrypted ring =
buffers
> +and DMA transfers, the guest must interact with two SynICs -- the one pr=
ovided
> +by the paravisor and the one provided by the Hyper-V host when Confident=
ial
> +VMBus is not offered. Interrupts are always signaled by the paravisor Sy=
nIC,
> +but the guest must check for messages and for channel interrupts on both=
 SynICs.
> +
> +In the case of a confidential VMBus, regular SynIC access by the guest i=
s
> +intercepted by the paravisor (this includes various MSRs such as the SIM=
P and
> +SIEFP, as well as hypercalls like HvPostMessage and HvSignalEvent). If t=
he
> +guest actually wants to communicate with the hypervisor, it has to use s=
pecial
> +mechanisms (GHCB page on SNP, or tdcall on TDX). Messages can be of eith=
er
> +kind: with confidential VMBus, messages use the paravisor SynIC, and if =
the
> +guest chose to communicate directly to the hypervisor, they use the hype=
rvisor
> +SynIC. For interrupt signaling, some channels may be running on the host
> +(non-confidential, using the VMBus relay) and use the hypervisor SynIC, =
and
> +some on the paravisor and use its SynIC. The RelIDs are coordinated by t=
he
> +OpenHCL VMBus server and are guaranteed to be unique regardless of wheth=
er
> +the channel originated on the host or the paravisor.
> +
>  load_unaligned_zeropad()
>  ------------------------
>  When transitioning memory between encrypted and decrypted, the caller of
> --
> 2.43.0
>


