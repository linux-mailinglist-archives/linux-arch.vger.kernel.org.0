Return-Path: <linux-arch+bounces-15750-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C25D100F9
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jan 2026 23:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D9DC30393D2
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jan 2026 22:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E562D3231;
	Sun, 11 Jan 2026 22:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="avqZ82Dr"
X-Original-To: linux-arch@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011058.outbound.protection.outlook.com [52.103.14.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9528A241CB2;
	Sun, 11 Jan 2026 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768170431; cv=fail; b=VLL+DWahbby3UA3oreTHj3LeD9UliPL5gAqdUM2S2V/2SikYqi0uAjGVEqonY1YfHQCsMDgk3kz8HcCv/d4pom00m5MkeQM/Uc7DWa/uWlJ9oCmCIuX4EbsCdKbZv9thOOd/p99nnuFyg5mUwv68OV1lSj6JOpLw06Xgbp+NEuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768170431; c=relaxed/simple;
	bh=qZbkHLmP6HDXlXc/PV1x/vtcTRzIzIvrkv0dnb21guY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E4JLmznaY6Yox5JiGmEHPKSsynm5jkEuZ6bXAQnaHzQiXj8uMnSCeEeMySImc7IMQ+HpUoSDFdNaJRcYgK4xLDAE8vyDFeC5yAcITkE2O/yRR+LWRUSdC1tHtmUYJ/PeZAltT4B/Lzvqs/jhIsrtH69Bn4U6TyiBdNqd9UMaIrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=avqZ82Dr; arc=fail smtp.client-ip=52.103.14.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3jZpBNX49iPu2gVxgszJc3ZrIOWxQAzRQ79aHYGgIAxzEWrYf4WZleo0bULnahwWPbUadGdRSqhIRgYSTY62yVgmsxmMfn5MJDw3DmLiVHfSIx2eXD81qDqxmFZ3C1RTr28rcNXX1JA4tRQKyC/HHLlWXaDZ8dAh8ryiSOXaSOFD0tZi+TmH3A2AG4j4EaQfItQmNLkNF3SO8cWtOaB9Sz6xrSR4I5zRLxoICTs+JMjw39v4CHxRQQa34MeZw3M+DI+mNbZBvScHct8qzb4h1x3o/kmz9x4Zg4DzACDR2gp940F2fziygI2M5Xn6vrdfOPaesBtT5sUU/AAb88lcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZbkHLmP6HDXlXc/PV1x/vtcTRzIzIvrkv0dnb21guY=;
 b=Qae3vDBIAVYI4WFTVoKec1ikJF74MO62gSvdOjuplX+IrMPjPTVT90HUSHZsTRjUWa8WHAasVtNLRb7yx3aok+5Z67xJqCyml442XKPMaVsJJ/CQ7WiEtp/eOlzqZR8G75HNMvsazOvnZ/3F0RZMqu0yCfRQawLOUX6GaE1FD3CdcznOuFTQVU8rvGmPnb09uibaukf3LBuwOSaEsJeSuGkylPnMp4rSJEBeezelWASBYXskfwNa9YxJOsNk+9bAhUt+8eza4ITaehdUx3ejrj3ysbB1v1kzWLafAvHg5u+XNAvyJXZ6Zs8SubJN8rJcjrphBG9Fzwk1Vp/ZVtJARw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZbkHLmP6HDXlXc/PV1x/vtcTRzIzIvrkv0dnb21guY=;
 b=avqZ82DrSW+v1LAjqW5sg+tWwFyquJgF8d31m/m822nAByfYnJZyAnmSGG8KONLMwxe9mRrMlsj47cyn9WnVgAGr/7S72DNuKAuTYkFO5AI/heiV3DCOCSKfvaVAI9Q4HyyHJkeiUsaF7O5dX6dz/5QaOZBImoJ3h5BlgAZ42NnZTUxeEm7pe+/pu1iQSgCh2DXFKsx/eTYTX9MbMewlWHvay8KumGBblLiX2KNKQYVg3RnlPpqverk4tUoi+ArgYuS2KAh++UzrfcSKkZ8KYb4et0KREZN6ZDYeNJ07EOxXDMYjdj5C4DsOzb91t7P/caG5XkJ9wJJhjl2UIyKrHw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA6PR02MB10525.namprd02.prod.outlook.com (2603:10b6:806:406::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 22:27:07 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 22:27:07 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
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
Thread-Index: AQHcaMpYMcvd+eE890K4YEStkk+XyrVIp9qQgAJkeACAAq2vgA==
Date: Sun, 11 Jan 2026 22:27:06 +0000
Message-ID:
 <SN6PR02MB4157BF936EBDA23AD1EC5183D480A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
 <20251209051128.76913-5-zhangyu1@linux.microsoft.com>
 <SN6PR02MB4157C3EF6617A7BA4CA9E432D485A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <4xjdq3js7w4qxcev727ujedpcujvzgrhf4xsfn3plfrn7fskxu@2qwxljanz3i6>
In-Reply-To: <4xjdq3js7w4qxcev727ujedpcujvzgrhf4xsfn3plfrn7fskxu@2qwxljanz3i6>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA6PR02MB10525:EE_
x-ms-office365-filtering-correlation-id: f1415578-182f-4b03-1b6e-08de51608dab
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799012|31061999003|51005399006|12121999013|13091999003|19110799012|8062599012|8060799015|3412199025|440099028|10035399007|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0DIB/ZU7wlXui83GSrV9/y3BjMciY8xEviEALZncNsdYZedeG7LQ0xWr92Zw?=
 =?us-ascii?Q?Z8mbyvyiV0AXjAIDyBUwaciX2Fw5XyWVqUkO4XuPzxgtlQGkj/5LM+n87JR7?=
 =?us-ascii?Q?sR0iAHIO1A2wu7i3kPilCDKqV+M+H+p6KxxKo/3XRdVu9S5odgP3t0+N49jS?=
 =?us-ascii?Q?V7D3nITJCaon2C0ZsjR3bDwXZpLbkZOLEfJoEsHZ2c00jlCk1Ov0CJFMBmMh?=
 =?us-ascii?Q?4xvwxnp7J/itDhGXgg2zz1/dfQgkR51gK3P50Ox4o6EFTRpwOK1FnOciD7SA?=
 =?us-ascii?Q?WCfE73vKu3GPzdDi7JvvoJs5KRC0lSSqYc5Yfy6eJEjE+p22bgCHhFMxv2oh?=
 =?us-ascii?Q?odx9lmaQxklmse0AtJn//lLZjrtjFfTglE497wZBjZzf0BDH4wcGD+KL/n42?=
 =?us-ascii?Q?HCNQ3kNVNH2mGISQ2vZZON9CIZCLvtUy2k3TrvPT/Woa8vJ5yl//2ElIxLnj?=
 =?us-ascii?Q?2yfQYt90vPFGkhRHidcYd1aZgHLQ8Vs90JMKK8cESofla+Z5Zd5MECTH0I1W?=
 =?us-ascii?Q?Ts6p+RUSTHvFLo8W3QjsfCHDDEK60yBqOttq0hUzfDvjuaBBO1D2hBmxu8CK?=
 =?us-ascii?Q?OxN5/cxUZdnEo3FHvQGE8K2gY9vL+3vTplXMqPjDqnlEb/cSa1+G7FweZAc0?=
 =?us-ascii?Q?Rv5b4R8x0GR4TN1a0cGN+ixsCTp8u+7so3XC7Fng2IEE0XSzWk/KSlRMcOsl?=
 =?us-ascii?Q?J14sut7lo1w5R9MEO/gqOsMgjHoXGo3SM8tQXo3fsrWx86GIAe9L+TTPoc23?=
 =?us-ascii?Q?+EV2QY+05U/UaGFW2Gb4dM76a7PlyaRa7gOTZTcgnCF0XM/mJjdXJqsclsx+?=
 =?us-ascii?Q?HgY4YbVV2ezjvpxTNXOjL2tYXK7sHOklSN3aH64cbboC3zamcaTh55ogHiQM?=
 =?us-ascii?Q?ghO49ABQENmCabn47j2u7sKFFkXtWPvljGrfROkd6VAOQXATNaN+Y0OqpF6z?=
 =?us-ascii?Q?y/6bNOJYfHIJraThiThEZFCqQAD4CIt/bS6CN4908E/4/ODrQr6cfv4w3CNR?=
 =?us-ascii?Q?uwXCWJClqnvbcKTTOZRLK+Gy8XUpcGVczpR9KKmP2mcVzK/0oPKRizQGUMkR?=
 =?us-ascii?Q?swDAwePB8iZDSphcqtU62nD17WGOUzgVGfItZjJP4WDo15VcBOPlVHAC5S77?=
 =?us-ascii?Q?EdBNB3Jdw9mc55wj9KL7Gryuo4MgVgusDX2gLCbexULR4Mg07xZb/cOZxAOu?=
 =?us-ascii?Q?QA5NWaNYXbLMDZENpoXCK2uI2fD+GgzNAI/7OSrK5AndnCjAOOJ89s3hFEdS?=
 =?us-ascii?Q?j4U8ds4yEsJMXvt11D2+GvyPbzi+FCr+f1s/kcboRTh4rXXOHRikN0sivgin?=
 =?us-ascii?Q?CLaT3Fc1deJpOJgqq9QwLyJx?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hxkVpdi1xGxtKA4WRm3pon+aFAik8S+AnG+vso5RWl6OsAyMaZ6g7OPQdXnG?=
 =?us-ascii?Q?3us+2rC7uFjzDhdW2aWEN5MUyUe7h8lJ837pkKVIXo/lAkhvJPc1KIGrGGv8?=
 =?us-ascii?Q?Jwbby0e2b6g+DZhBb0HuutM64sol4I9M4xfm8+XRwbY3xMT3LsHNi6Bzr07n?=
 =?us-ascii?Q?+0sc5k63A8O1JqO/bbTOAieNPQDbQngYfQLin62ZD7vv3310awAKXaMp+8NL?=
 =?us-ascii?Q?TVRE5pXWpAz8WvItK3gT50irLNREQgFo28CW2fg868itdE4bhLBRdk0N7cKk?=
 =?us-ascii?Q?A/Fz+n7L3wHGjtyvzQDU3b5QUwWk0PCBsn/mIxPcNlV0Yu8TzNxkV6fhpsx1?=
 =?us-ascii?Q?PR6JquL7m3jgNWNcH0/xv2u/C8p5Z24Te0o/Bw28jiqX6LaubFWnNFZ6CD44?=
 =?us-ascii?Q?hPyUhmFHcRxd2keJhFryQlOhVBEqTRPMv/rTG7OREfiF1gHyHKtZbI3A6sPX?=
 =?us-ascii?Q?bOtzxie897npBo8QUTlJr5CrS0xqQOJjnZ7/PmeUEe407RZE0OvUMnnGPE1T?=
 =?us-ascii?Q?r7iCqrLpQ7RnguVbZLP6O797cCe1lvjwr3x9AlATefIDIZLLKJ0Q1BhxMUTN?=
 =?us-ascii?Q?vQ+2ip1SqvLf613OpAwgfXlDm9yc6ZbDXRYSDATNinQMr+ltnYGjIKCmlU+B?=
 =?us-ascii?Q?bLr9+7XeP/Jm4UXVixzeg2XgjZiHgDT+Z+pEnB/Gbij7TxjcHX3ZYUZAARyd?=
 =?us-ascii?Q?x3mQA7L/Mx/OJxg0ro37ppSjriBakiIBzx0hYirfLFO+RSEc56sflxNBwRoa?=
 =?us-ascii?Q?YMCNiWM4KwVfK8sqi5A230vftimnlQ5mRVjXNEQqSuDIasqf7Whxg7fXne6K?=
 =?us-ascii?Q?1e3VnmqhHCxCqyTFl3faJfDhyynAQWrbZxinPTlSjoMAbqKKsd7Ica4LPgVz?=
 =?us-ascii?Q?EheiBOvOPNabYc6qWDE046BP7Ht/dpht89+IK48PAO8CyvnRpA+XxgljZBC0?=
 =?us-ascii?Q?rxvv3jqKrgfkeaKKplgzY6xPgK3Vgm2+RBusSoPVAH3I8tIGa5RnwvGYjdL9?=
 =?us-ascii?Q?hNHJcYvSP6hecqq81uhSH5OCzSLqdMN77WbLIsBOUgQVFlnXnjw3YSqRDHER?=
 =?us-ascii?Q?EKN39WUNVYjh6KjlvqJJ2hixB9SriV3V2h9yzdZjlDSDuuEkkpBJD0kDHxpt?=
 =?us-ascii?Q?+iCaJk9eiE0irfSn7BDRFH9B7RpRu8K9KmAeso1AQ9/fmRrRIeOhm/GOh2+z?=
 =?us-ascii?Q?NmFwggd5Vip1IuQQk5nWqlo+lexxe0q7ekKreDzubZaJ+FVXEGZ2JisfeByM?=
 =?us-ascii?Q?eTV525Qeb3nHPGdagM9ZKsEvLqSgsUsaYiJg6OgA7c1gNUFC08sH78RFjCmq?=
 =?us-ascii?Q?7R1Q1p9mjXai/CoC66spl3goit8K5ntIfiIEi32qd90VsA0WghS0iKXBitzV?=
 =?us-ascii?Q?i10Sq80=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f1415578-182f-4b03-1b6e-08de51608dab
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2026 22:27:06.8326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10525

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, January 9, 2026=
 9:07 PM
>=20
> On Thu, Jan 08, 2026 at 06:47:44PM +0000, Michael Kelley wrote:
> > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, December 8,=
 2025
> 9:11 PM
> > >
> >
> > The "Subject:" line prefix for this patch should probably be "Drivers: =
hv:"
> > to be consistent with most other changes to this source code file.
> >
> > > Previously, the allocation of per-CPU output argument pages was restr=
icted
> > > to root partitions or those operating in VTL mode.
> > >
> > > Remove this restriction to support guest IOMMU related hypercalls, wh=
ich
> > > require valid output pages to function correctly.
> >
> > The thinking here isn't quite correct. Just because a hypercall produce=
s output
> > doesn't mean that Linux needs to allocate a page for the output that is=
 separate
> > from the input. It's perfectly OK to use the same page for both input a=
nd output,
> > as long as the two areas don't overlap. Yes, the page is called
> > "hyperv_pcpu_input_arg", but that's a historical artifact from before t=
he time
> > it was realized that the same page can be used for both input and outpu=
t.
> >
> > Of course, if there's ever a hypercall that needs lots of input and lot=
s of output
> > such that the combined size doesn't fit in a single page, then separate=
 input
> > and output pages will be needed. But I'm skeptical that will ever happe=
n. Rep
> > hypercalls could have large amounts of input and/or output, but I'd ven=
ture
> > that the rep count can always be managed so everything fits in a single=
 page.
> >
>=20
> Thanks, Michael.
>=20
> Is there an existing hypercall precedent that reuses the input page for o=
utput?
> I believe reusing the input page should be acceptable, at least for pvIOM=
MU's
> hypercalls, but I will confirm these interfaces with the Hyper-V team.

See hv_pci_read_mmio() for a precedent in current kernel code.

There's also hv_get_partition_id() which uses hyperv_pcpu_input_page for
the hypercall output. But in this case, there is no input, so input and out=
put
aren't actually sharing the page.

In the kernel 6.13 and earlier, get_vtl() used the hyperv_pcpu_input_page
for both input and output, but it did it wrong because the input and output=
 areas
overlapped. While overlap worked because the hypercall is a simple "one-sho=
t"
operation (i.e., read the input, then write the output), it's not legal acc=
ording
to the TLFS. When the illegal overlap was fixed in commit 07412e1f163d, the
developer decided to allocate the hyperv_pcpu_output_page for VTL2 images,
so the fix uses separate pages for the input and output. There was extensiv=
e
discussion of the tradeoffs in allocating the output page for VTL2. In my v=
iew
it was an unnecessary use of memory, but the developer preferred to do it f=
or
consistency, and I didn't press the argument because it was limited to VTL2=
.
Similarly, I won't press the argument here if folks really want to always a=
llocate
the output page. My only request is that the commit message not be misleadi=
ng
about the reason.

See https://elixir.bootlin.com/linux/v6.13/source/arch/x86/hyperv/hv_init.c=
#L416
for the older get_vtl() code that puts the input and output in the same pag=
e, but
improperly overlaps.

>=20
> > >
> > > While unconditionally allocating per-CPU output pages scales with the=
 number
> > > of vCPUs, and potentially adding overhead for guests that may not uti=
lize the
> > > IOMMU, this change anticipates that future hypercalls from child part=
itions
> > > may also require these output pages.
> >
> > I've heard the argument that the amount of overhead is modest relative =
to the
> > overall amount of memory that is typically in a VM, particularly VMs wi=
th high
> > vCPU counts. And I don't disagree. But on the flip side, why tie up mem=
ory when
> > there's no need to do so? I'd argue for dropping this patch, and changi=
ng the
> > two hypercall call sites in Patch 5 to just use part of the so-called h=
ypercall input
> > page for the output as well. It's only a one-line change in each hyperc=
all call site.
> >
>=20
> I share your concern about unconditionally allocating a separate output p=
age
> for each vCPU. And if reusing the input page isn't accepted by the Hyper-=
V team,
> perhaps we could gate the allocation by checking
> IS_ENABLED(CONFIG_HYPERV_PVIOMMU)
> in hv_output_page_exist()?

Yes, that's doable, though I hope it doesn't come to that. At some point th=
e
additional complexity starts to favor just allocating the output page. :-)

Michael

