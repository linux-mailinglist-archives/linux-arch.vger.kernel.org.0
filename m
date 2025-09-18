Return-Path: <linux-arch+bounces-13689-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12E8B876CA
	for <lists+linux-arch@lfdr.de>; Fri, 19 Sep 2025 01:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD711B22A09
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 23:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D6E27F4D5;
	Thu, 18 Sep 2025 23:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mXoACXQ9"
X-Original-To: linux-arch@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010005.outbound.protection.outlook.com [52.103.12.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4825127A456;
	Thu, 18 Sep 2025 23:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239608; cv=fail; b=PDUupiRrg62yArMI/vhdaOnkz8jRjFn8nHoey55PBwKMuBeSXPYo2l0GnsqxvBA1URQJMYLIxkG/cYVAc1TUuGzgtcd75R5/n8oeNhgXLjLUi4Zp1DUGmWgE2SgDU2+vz1FXbrsL2oHrHCgRiiSzUxBm2nVnpOH8uipprhHE0sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239608; c=relaxed/simple;
	bh=2/kwfCD3QLUwIs45UxxeOznsWoYdcjQ7nKwH+DM9Ta8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CdESTX01WNCg1C/Tyjjs9mKAzVVFSWAFzKb591FAfY9ti9qMySdhhgvagLXOYmGlLbWFDLztiSCKuNrGYIcZ60C2M2umfV/wL9S83SKEJJPr8tNaLQIVdG7WkFqO5G0Nmsi8Ol/0PZk5NvcTllA9yMqtZRntuvgmKZ+K2Nlm8FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mXoACXQ9; arc=fail smtp.client-ip=52.103.12.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZP6UoKH90UWVghwNNMFSv/smI2Rnxnkq2llm9jetKemJXpg/BjH10+ZS6cLvICd2mf7ciFkG8ANfF9VOcI7i81GmK9rg67WWvApfJk9Vd8h/p+XOJ34tAAff9Uz/YEsrMPDxT5JvOrlpeB4/slF9SGMa/xqSfYHCdpvgHggyY5OjMHnDzz3DEd6qfu6RBXD6nXzJ+lmsWoyvWEdTMNQaGvbTTdExaWHaCDQwnugpcbUT5Eq1TQsSWiLEj/+2ccGH9LuG/MWb9SwKl/YjruTJNLAHrCKLMrkG6D9ngGy8uB5wCFyw/SBGswcXk8fxybM2xdMX2K5E9frMHN1zbH0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15lnG7zCEY67ovJTB84OkvnyyaFaceuI8B/bAiT25k8=;
 b=pjLYI4hqoca33CfBjrDTSIj8kTT1uM9DLU4zFG3gTINVSpw+M/tngU7IuJ2bcv6fDFfzLzFM1CNQ4iB4vhlzI6i3j0d/t0bcOu7s+3gzscEc5nmjjgXrf3HjBGq1V5WXIWTfpyfO2ds4v5SuaLshOf7VC4e37NvtiP6mFFpL29pTl8blY/8WmjIeCZN+0rEDhttikpWTY2VuNVlivzwHjLQW7d12gbPUj6vA9jaMM11+PDZaZWUB0TDrwwt8nNaGMD4+RvF/jMssxzLra3ufiTeu6+zZJ5r6t0B0eD/15o7ZJO3rUWMStbAeTSWU/ZFTZ/1pcfVqx31pyblLI8iR7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15lnG7zCEY67ovJTB84OkvnyyaFaceuI8B/bAiT25k8=;
 b=mXoACXQ9pMcqAFVmfNFQ50vTKS+grJxdoOFrXhLlzlHQYwgrf2VMdTVzxZ+zvRf8/l9QgvR1HKlc/U3JuISl1t/oqT6mrgwt6OumwUGdtXX08sNQb+R6VraGN+jUDnflzJmELj5gWeInb1UNEDSPGncOgwXs5GwFd6tFojcDHyKGiGjj6j5wlFXnY9DMCrt36EAMAm5u6H3CDpV9FUP+dmi6+fj+VdcnepSprgXZ652nXXDFwo+IG8iwmYEtyPSGbrYGEYXqKlHfpPq0EtG0WS/YVLol4U3JjiSffnayJeRn8VofO8gCGmHM/FTyAwgHgWvowyU0MuiDzcYzT+R29w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6733.namprd02.prod.outlook.com (2603:10b6:208:1de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 23:53:22 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 23:53:21 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh R <mrathor@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH v1 6/6] x86/hyperv: Enable build of hypervisor crashdump
 collection files
Thread-Topic: [PATCH v1 6/6] x86/hyperv: Enable build of hypervisor crashdump
 collection files
Thread-Index: AQHcIeeD/3QUCmD7EEewGvIyXSLQYbSUe5GAgAIh2YCAApawgA==
Date: Thu, 18 Sep 2025 23:53:21 +0000
Message-ID:
 <SN6PR02MB41575C12515CFF532B8B51C8D416A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
 <20250910001009.2651481-7-mrathor@linux.microsoft.com>
 <SN6PR02MB415730C50D722D289E33296ED415A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <daa1e607-26ca-887c-b32c-d39addd6fa44@linux.microsoft.com>
In-Reply-To: <daa1e607-26ca-887c-b32c-d39addd6fa44@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6733:EE_
x-ms-office365-filtering-correlation-id: ea59be80-5db1-43f5-be97-08ddf70e8cbd
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|31061999003|41001999006|8060799015|8062599012|19110799012|13091999003|440099028|3412199025|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/EHvS7m4D9zgr78aedeAycpgHA+Ida6kOV6QKXUJCceqb1eUiLhlWGPiPdH+?=
 =?us-ascii?Q?ObbJVW6dSxHJXgemDaQVHnk6zG0qQ8195sJmZj5aGeuZkJdRs6bBIXs1cf6z?=
 =?us-ascii?Q?T2z9hVx9Nlr+oKDhWUN3kHX36bqFx1+Z3S+8JMV4gYBjb0Boz3eRmQoI/1hm?=
 =?us-ascii?Q?gIsmcB5+eWNgXS3JYojWkZAgWkm2AzKz3QTGcb+b5P6FNWe+CWwxuWuZLirX?=
 =?us-ascii?Q?Jv2PG6QrTo82J02BzAT+OGdBgLV7dA5orFHW7S/VyCvVvhCReFyr3cCwuhDP?=
 =?us-ascii?Q?fszLCYu2y5OfBI5LkzwklaDj19cPT81ZkFdMfee5Hgm2PtAf3oTDsucSattJ?=
 =?us-ascii?Q?y4Vs5RGFrB269gC2cm3GWE9ijcKGWN8wrZAp08irRX7KLHDQn5IK+mgTA80R?=
 =?us-ascii?Q?YRoJVX+4MoLsIZUO8rqJDwMULWXBvBS7UKwYPohRnAluMmdLYiUWs3mb0YJm?=
 =?us-ascii?Q?C/gSugf+wz8cEd9XM5AiRSOmMPPs91YGfLFI9lneXb66koDePqW0vdrHjtpc?=
 =?us-ascii?Q?qeWnMKFvU7c1wHvfXv9KqZEgUk+FOJ4nXHVEqcSoUpQUthbi3B2Fa+hGicHI?=
 =?us-ascii?Q?IXFFrWF+ja81u7KiVA/vJrEX61kC8vl0JGPLxZzf92b6DqUmGt3NpuqzD745?=
 =?us-ascii?Q?ZrrsHVa5bDDzbQPwXNWvn+2/Fjsz5vzGEuVtmiNwb1b0AwUbx/nMKbxIJCnX?=
 =?us-ascii?Q?xiu48umgZvGTxQXPa7QVUPX0qhB1Ce8Z76mrsMkeZzOisVAyPpbLbttlQ4Ow?=
 =?us-ascii?Q?5NHyil0TGDjH28Myo7ym4aRcx9Lv1JZJ39nrH+xM6di0bsE9164Exa/q13N3?=
 =?us-ascii?Q?arjkgPOrvHn8M9kxV/w+/jjUztI304TIdMyirdboTxKx/UtQANYhIb+tCzfl?=
 =?us-ascii?Q?W29qJk500MFSjFtl5+Sk9ct+P8m+MfDBgOmbY8LAj56ZVtozV8Zbb37DdDxW?=
 =?us-ascii?Q?LEINW6czYHdHMkPquBgReAXeuoFNYS+8ukUpa1OHeIE+KzmqO7yeSKQfmo4C?=
 =?us-ascii?Q?uC6sDd8CZDMqhxDqUS3Hf7x61umO6FWXOwvgJ4le9N9n4mh/YdFl6iVSEU36?=
 =?us-ascii?Q?azriGAP/gt5iLlNA+Rllb8gTEqrbE4uUxgWipJzaEbM9W+yhKyTjDE0PdTuW?=
 =?us-ascii?Q?2NpR6TRpcUiUwZ7rWP8jF4RifhPyD+IZX3jdkUBom/3g9XaC8ReDbH6YUKrU?=
 =?us-ascii?Q?zIECTelr9Rkun19InNz1Bqeb0DdaQhAsOiuhFQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HdAfjaz6sKSaQAoW49Wc+v60CyyWBs4+fLilHmiiKgCYc4/0+clrFCk/kvDy?=
 =?us-ascii?Q?Hun9RfridVSz5ggHFhE9vjNrJLnmF8yWoJaCj8oQbm6FXpWcu/HGuHFzzBb/?=
 =?us-ascii?Q?9lb/hr3KgHPKXs+TcgYAFNfWRVRgN4iCmTeA3QOU/q0jyzApeEqWl8Klsct+?=
 =?us-ascii?Q?sFaBNn5HdxvMc7f9+AuysCr2Thl2GBWG1HDsYbXUiLL8V0w5nrGVXzZgo3dE?=
 =?us-ascii?Q?mH3kA6u3NjXmHQqf7KtPgeAjjMVUzeH2bMcnNNkBM1d0cVgdtTZwmgHhkKLm?=
 =?us-ascii?Q?fL/nZX6Ws0SIdJI7KSqoLIeq5lqVu/M+DvHCDGE4HGnsVhAKBzRVAJqm+Ybi?=
 =?us-ascii?Q?B9Sm0AlqXb4Ehb+PkV9FsUVsaPCabq4vDpopzqrs67K2pS6pYhqMakPZBkNy?=
 =?us-ascii?Q?HEzB1rXzhjYphw2Pk+XNtEJ5P8lCbQurKNfdbzDqUwyHbBK/fiJkpVpPYM02?=
 =?us-ascii?Q?2CJSS5sQJ6N73lXu8W5np261eUNch8vYGNzk3grrXwqwxWgnpjNfQJlpgY5r?=
 =?us-ascii?Q?DNSSzKK8aK0kEzB4TsUTibFF6Z8STxcESeRNejMyV04y+7oXEFRUXE9IbMxC?=
 =?us-ascii?Q?oimIEnjMx+aWGE7IcgNcOYgfGEUl17cbsFoK8xxGQqhFo3jJkJe8zaDTIb2b?=
 =?us-ascii?Q?NtTYMj0Hkg6HJqBHQTufcSnDj/tketGIIHNZdH1+CMCINCzgvku+HVEy5Qc+?=
 =?us-ascii?Q?cvGFWWK8wtTgYDfMs/K7Zg9zuJ1q146dk3i1hrNZ/TSO/hQPwMhmbuvaw6NA?=
 =?us-ascii?Q?+T2ACPd0tXobDpFNuUA/du0RYQRTPWqygIBqqajllpXH/ID9qwtZuFRmCrnT?=
 =?us-ascii?Q?L6KIp2XxML9I//cJqL80K1Pu++JAkAQQN/gqMR/oBSwTNIAFmdaQK4Q5iUMv?=
 =?us-ascii?Q?GDwQZCM9w/tMfnSxw26+dx29xeLCXzUKUh1kWNH7S3sJP1JtX0BOPI/nTakA?=
 =?us-ascii?Q?upukkB21gpLOdwhIGZF0gugg56Tc2G9VqpFAw0b4B/oz4r8ySw/SRCbDbEH0?=
 =?us-ascii?Q?XCsOOGhujfGIkcW1cciPdDb8K6aMI2kXAn7iIaVFlJcfabjqFcX6gcEm7XC+?=
 =?us-ascii?Q?6Et1qNYUdo5WM0SnzBHeGc8HBfCeR/rJ57h1g9E9iSETMwMIuPKm1eNIASuN?=
 =?us-ascii?Q?KFAKrVnra7WwdptIaemYVEXNXBcfnrxsfvp51k1keIFQcLZjweVfIbR2rGic?=
 =?us-ascii?Q?54DJ37YI7T53oZWhrUQLxpsnSaYsGTdzBmrhGQpj4s5VHnFB468EsD7+42o?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ea59be80-5db1-43f5-be97-08ddf70e8cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 23:53:21.9308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6733

From: Mukesh R <mrathor@linux.microsoft.com> Sent: Tuesday, September 16, 2=
025 6:16 PM
>=20
> On 9/15/25 10:56, Michael Kelley wrote:
> > From: Mukesh Rathor <mrathor@linux.microsoft.com> Sent: Tuesday, Septem=
ber 9, 2025 5:10 PM
> >>
> >> Enable build of the new files introduced in the earlier commits and ad=
d
> >> call to do the setup during boot.
> >>
> >> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> >> ---
> >>  arch/x86/hyperv/Makefile       | 6 ++++++
> >>  arch/x86/hyperv/hv_init.c      | 1 +
> >>  include/asm-generic/mshyperv.h | 9 +++++++++
> >>  3 files changed, 16 insertions(+)
> >>
> >> diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
> >> index d55f494f471d..6f5d97cddd80 100644
> >> --- a/arch/x86/hyperv/Makefile
> >> +++ b/arch/x86/hyperv/Makefile
> >> @@ -5,4 +5,10 @@ obj-$(CONFIG_HYPERV_VTL_MODE)	+=3D hv_vtl.o
> >>
> >>  ifdef CONFIG_X86_64
> >>  obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+=3D hv_spinlock.o
> >> +
> >> + ifdef CONFIG_MSHV_ROOT
> >> +  CFLAGS_REMOVE_hv_trampoline.o +=3D -pg
> >> +  CFLAGS_hv_trampoline.o        +=3D -fno-stack-protector
> >> +  obj-$(CONFIG_CRASH_DUMP)      +=3D hv_crash.o hv_trampoline.o
> >> + endif
> >>  endif
> >> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> >> index afdbda2dd7b7..577bbd143527 100644
> >> --- a/arch/x86/hyperv/hv_init.c
> >> +++ b/arch/x86/hyperv/hv_init.c
> >> @@ -510,6 +510,7 @@ void __init hyperv_init(void)
> >>  		memunmap(src);
> >>
> >>  		hv_remap_tsc_clocksource();
> >> +		hv_root_crash_init();
> >>  	} else {
> >>  		hypercall_msr.guest_physical_address =3D vmalloc_to_pfn(hv_hypercal=
l_pg);
> >>  		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> >> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshy=
perv.h
> >> index dbd4c2f3aee3..952c221765f5 100644
> >> --- a/include/asm-generic/mshyperv.h
> >> +++ b/include/asm-generic/mshyperv.h
> >> @@ -367,6 +367,15 @@ int hv_call_deposit_pages(int node, u64 partition=
_id, u32
> >> num_pages);
> >>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
> >>  int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 f=
lags);
> >>
> >> +#if CONFIG_CRASH_DUMP
> >> +void hv_root_crash_init(void);
> >> +void hv_crash_asm32(void);
> >> +void hv_crash_asm64_lbl(void);
> >> +void hv_crash_asm_end(void);
> >> +#else   /* CONFIG_CRASH_DUMP */
> >> +static inline void hv_root_crash_init(void) {}
> >> +#endif  /* CONFIG_CRASH_DUMP */
> >> +
> >
> > The hv_crash_asm* functions are x86 specific. Seems like their
> > declarations should go in arch/x86/include/asm/mshyperv.h, not in
> > the architecture-neutral include/asm-generic/mshyperv.h.
>=20
> well, arm port is going on. i suppose i could move it to x86 and
> they can move it back  here in their patch submissions. hopefully
> they will remember or someone will catch it.

I could see the ARM64 implementation implementing its own version
of hv_root_crash_init() since that's a generic name. But sharing the
"asm" function names across architectures seems more questionable.
I doubt there would be hv_crash_asm32() on ARM64. :-)

>=20
> >>  #else /* CONFIG_MSHV_ROOT */
> >>  static inline bool hv_root_partition(void) { return false; }
> >>  static inline bool hv_l1vh_partition(void) { return false; }
> >> --
> >> 2.36.1.vfs.0.0
> >>


