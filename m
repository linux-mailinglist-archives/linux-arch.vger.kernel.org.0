Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB23512146
	for <lists+linux-arch@lfdr.de>; Wed, 27 Apr 2022 20:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242253AbiD0Qec (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Apr 2022 12:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243206AbiD0Qd4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2022 12:33:56 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azlp170100002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F9753720;
        Wed, 27 Apr 2022 09:30:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmmkVRNdOSSm5AOD5QYVeAyICpIFHRJYJmdBmciwNNwLDPoHUfH+U+HwbZX2EBHV5ZWzI+iW5S+rXDkdCHuG2gy1TsgsH/22oU8pGjh4mg2UQg+/7op99FX5lQU9khGzegLrLB7tNGDQspc/1+StIqf2YjnMdZPUsngrBqEZtfWLhWaunNVxNInPkop81QehJFn8iZiPqHJuHnqZqalxangGncnv1p0BlZ/P89aiW5zXUSiJkzMAFbiOyrY3LUEBmNY0jPpJjV5Zr6A+kK61NL9uHzMRz66FAX6YcTynR0Y6OZA4ah4iWjm9dZjB6vaxFFFT9dEuXmx/sKshi4nq1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyxF0V8DrtqWgS9G8bAWxvF2B2hDdvm+0n5wtlVjUAw=;
 b=OEBLqdQdjoa9jjuiUQkqRytXCAMHr1yYM5JBruevKPrxBlGqtN6o1bkWpdgQTTWYLMU2KH5ZiFeII2v0vyH0QRgcTrq0/0xvQSwl09pISdzIPmz2qJv/Vq2u9xvWreQkzw9VYazmjVXAavgH3oCiHm+/ri0X4QEsdtbJdd7/9CPK5lsxgw2/j862YySn/ywCUlWrvl4bkfO+Ry1fILHRIW7unSfTbi4AeHxXK7rgLeYTZ6CkwQT/WmOl4fde0HuHOfEx9I3iBCW6Q6EGB3qgI3EyziB61PHgLpbIwMHvU4/TpqQneeyBJJyavhkJG5qoaXO3Qk/kW0lGMKZRssH/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyxF0V8DrtqWgS9G8bAWxvF2B2hDdvm+0n5wtlVjUAw=;
 b=ClMyMp4nbIOY7I2vT6TnCmtUYOYw28Zeze+epnzrhObLTs9qejVPRb055xqdeBsyq+BA0FRbXV2fHvXx2dTBXuZvlnu8HhPTDJ8K9jp9mIQH7f1De5fEEN2fE8xsIOcRTlgxvVhuFONGfFYfKTCdK96KzPLl17SQKVc8YAoGB4A=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by BL1PR21MB3211.namprd21.prod.outlook.com (2603:10b6:208:398::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.4; Wed, 27 Apr
 2022 16:30:17 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df%6]) with mapi id 15.20.5227.006; Wed, 27 Apr 2022
 16:30:17 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
Subject: RE: [PATCH v2 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
Thread-Topic: [PATCH v2 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
Thread-Index: AQHYWk1L6u2ZguXWMUuZ5SdYA2PhO60D8QjA
Date:   Wed, 27 Apr 2022 16:30:16 +0000
Message-ID: <PH0PR21MB3025FAA99B4E2C8155A1AE12D7FA9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220427153336.11091-1-jgross@suse.com>
 <20220427153336.11091-3-jgross@suse.com>
In-Reply-To: <20220427153336.11091-3-jgross@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4b2cee31-6511-4747-8051-dfac355218a2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-27T16:21:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86bb8319-2293-4174-dd85-08da286b36a4
x-ms-traffictypediagnostic: BL1PR21MB3211:EE_
x-microsoft-antispam-prvs: <BL1PR21MB32117170E8E040DFEA8AA887D7FA9@BL1PR21MB3211.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vzWUaoCQCoVGQ/O0CrIKRybSC/QwAIbUKdPhDjcJHCwJ98Z1IIenMCqnPuloNozM7rUJhAq0aRS0rN6kAdyKilc1Fup9Ji8R5nNs6aQg3dGvqImCpXm8hCsYHbi6JUYF+TexlFswaIw4ELQ7YrUNFWeTsFjKseuZeTxBVn9AgaoqW1k9ylAwcF4MPtWqCba8b4Kpcvuu5pSl6tOuUhyXvLiK4EY2ovx2Rrv8t3NoFtQp3K0XylZa1W3lIpabIJ3SX1pwvZxRUotcWL+tF2L7/qPeZ6e7mq5eUY2pu1dwugKePGTJzQcjb6blKKq018RMl5jFH3b3hL+URQbRJduqMPq2qvVWeNwefQ/11eNxDPLaDrriVGzsmTrJnU9V5GPCayP+WzcVBQrasoAzWBA5A3lpByFKc9VnGEnsVj29UJZUe1ix30mfe6K1tSvYOehfRZorBwrWZbR3zdQrMyncuIIO+x6/ZANhgi0Y0179BIIKFm8dbwAKAT/o17RwUPJFEg+MgRAJ3DPGuQM+GhLZJEZ5XTFja46ddkca/dXKNKAxJFTjKl+pF/To/0AshpThrj7Hr5WOnzDL8latz0BfXrwNCd+Zd2sAuwuYoURQ10jIjfgMDPnREKgwkZn3cvQ/uX8LZE5fdXD1Eb8vdizhLs+K1eJIDcricR5gso9y+4naQSw0FGBIIWQloJHZWlC87i4yjhrdUAdBGcauvlDUuPzjMAj3j4jgwOOnMrzhL2WbYXEFQ/AZy8RVZfYAIolY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(71200400001)(64756008)(66946007)(8676002)(4326008)(76116006)(54906003)(186003)(83380400001)(7416002)(55016003)(508600001)(33656002)(5660300002)(38100700002)(38070700005)(82960400001)(86362001)(82950400001)(8936002)(9686003)(8990500004)(122000001)(2906002)(66556008)(66446008)(66476007)(7696005)(52536014)(110136005)(316002)(10290500003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EkwWk3Wi2otkyTBGivfev0U9/HQvE5AQ427sO0jJ7fXyzi785QF4veYCz/Uv?=
 =?us-ascii?Q?yAMirPkru7iMujKC2zZrKN0D20ymD0lR1ThUyHkGuCU6fYWzVgBzlvv4wxaz?=
 =?us-ascii?Q?ahlUJEvX+RGqavCFWF0sa4baOjePcegF/O7BIfJz4lPG13nBtbM8ZUz/EWkE?=
 =?us-ascii?Q?2W5VpAIS6FiPBfmXSy7tpIQXRJ8USDEguvK2YjtzWH+IEey2UxbvSwrs0nYh?=
 =?us-ascii?Q?0vpq10TS1UObbLgUHfc2uuJOswCqcuezT2a42aAqfXOhqIHn8DslA5B6ORUG?=
 =?us-ascii?Q?jT81FDO9wMZFSmQ+JtIVloLdceBUgILMEME2R3Qpad9pQrjRuWRR6egO1o1O?=
 =?us-ascii?Q?sat9nyKtvPXHKhRJEgwei0QI2s2HFOFs6BLFAyfSEYiMPGJUMEYmjGAqMqjY?=
 =?us-ascii?Q?13AwGpoGIO3p+iZ07dDKvxXy0slxIpXCTTlokUwI+nUAnWvyAaES7sm55ED7?=
 =?us-ascii?Q?T3e9AasgMl30vnFjJJWwU7XUQ/dpBfLWZTXuCxN2WVJkezBQ7hIvM8hYulqv?=
 =?us-ascii?Q?R1g6JwdotFEh7YBPgvY+dNDPrdFx1xDQ/Adtyv2uK+2oPc9RfxbSevK599uu?=
 =?us-ascii?Q?OBbr3qaiHIBvpPLZFUO3jDnpji2OSto3raI0NUPD2c7InimUWzi6VxtMfnSN?=
 =?us-ascii?Q?3f+OSlRfwD3w13ZPKACYYnNgfaM6zFkGrPecjDVaI1H4iY4dxjQETwM1ZFcf?=
 =?us-ascii?Q?nRnU20G2DvOB6FM+Z/S7mS/1HxLfq0LPiVbazON7ZmqG/ahupohMBcuyYxa8?=
 =?us-ascii?Q?s/AAekd9EEwwln2tEpy4VkFZoURObLIRRWsynrapt3//7/pfqWCzzaLymKEa?=
 =?us-ascii?Q?jnguRcuE2fUz1eqB44EjWHQXLfYBcjqqzG3eURS1ADC/+cNhM59XGxAMXAwf?=
 =?us-ascii?Q?Krhjr+105sSRUnl3aWfSmPUr4A04cpb2Yhe0K29aYjEXJvTkML4ujwJpAj5L?=
 =?us-ascii?Q?PjHppHoUgEvlxQxtGQMJBlpbCdWbzV1p8tsopSpb5FfPsvw4GsRJ0t4PdHjn?=
 =?us-ascii?Q?SmUwKWlyMAZojTkVh96CzjlO7KprH3z9w7JwYKYsOeg2sH0vMMFKNBW2RI8m?=
 =?us-ascii?Q?quMmY9Jptnhu1EDSNb/stJQDWOhsMfrP5EbmH6pvu8sZgAQfiHRzzPwLvCyz?=
 =?us-ascii?Q?c7j+/L9gTLUTofdmOj0j6xd/lvS1ZFvuICu5sDxBrZssMOOXeXtNGYYbyT5K?=
 =?us-ascii?Q?fv/gV/7q6UIIdQmgBXzubmJpM4MmzOAMDvxSUTiwwqEkhUoIysPHUL8qMnRC?=
 =?us-ascii?Q?O3AzQEwymyb//atlXYw5SMbTzq7PfNDCswyn3LuIrJrEKiBLIFHirYDCH6oS?=
 =?us-ascii?Q?fZzClJUtVXpa0tZ56blQ9W2eyEGj3CLsu3uzdpiyZXlffWA7pcGkEUheZTmr?=
 =?us-ascii?Q?rnNOTK1flWj9oOGu8GOX4sXaJSOnhxfreTfMPZBicxJEFHxyVay9tD9CDDHj?=
 =?us-ascii?Q?lwWeqZ1DwTZfYcU7tNXQZOpCEDJkWsJE2EclnUwfeUMGHOq/qemd6W/IfgKT?=
 =?us-ascii?Q?dfkvroxFDtN96fRhJ6COdMD+PByWnuwD6NPz2T2ac+UZTHuGnH3kDkmZoJwx?=
 =?us-ascii?Q?HW47MTtX/ahrFXWtu3e3csrQs+qNwuGfKPcuBCgwnDTdVQ7DF4PVJM54hf2u?=
 =?us-ascii?Q?ya/LykFQcctl14MG58H8wcKiwDcrYlPjDBc9QSG1kfzghzki28pyN1MqitxO?=
 =?us-ascii?Q?9V080I0s8vcLo8jfKjYo1YRcv1Qnw0wMuFU/wURjacjokJgnB73rJIyxLn2Q?=
 =?us-ascii?Q?pHAnSLHKTu9uy0ZFsCN2FsSXsnBzhmgzK2ESDNyxBOIfGMpZcYbnrHkgo6og?=
x-ms-exchange-antispam-messagedata-1: NUcjYDlw87lvwQAF+KWffcA4LFWICzBsR4w=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bb8319-2293-4174-dd85-08da286b36a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 16:30:16.9282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nXpRYtbVN4Q3BnANyskWxmw47xiFeTUHiQyNHpbK63cqhZo+3NJL/ozz0u68+4h7cLAxWwyYOuQIat8MRc+VLR1GWNnX1fkK8tFD1XwEFBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3211
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Juergen Gross <jgross@suse.com> Sent: Wednesday, April 27, 2022 8:34 =
AM
>=20
> Instead of using arch_has_restricted_virtio_memory_access() together
> with CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS, replace those
> with platform_has() and a new platform feature
> PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2:
> - move setting of PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS in SEV case
>   to sev_setup_arch().
> ---
>  arch/s390/Kconfig                |  1 -
>  arch/s390/mm/init.c              | 13 +++----------
>  arch/x86/Kconfig                 |  1 -
>  arch/x86/kernel/cpu/mshyperv.c   |  5 ++++-
>  arch/x86/mm/mem_encrypt.c        |  6 ------
>  arch/x86/mm/mem_encrypt_amd.c    |  4 ++++
>  drivers/virtio/Kconfig           |  6 ------
>  drivers/virtio/virtio.c          |  5 ++---
>  include/linux/platform-feature.h |  3 ++-
>  include/linux/virtio_config.h    |  9 ---------
>  10 files changed, 15 insertions(+), 38 deletions(-)
>=20
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index e084c72104f8..f97a22ae69a8 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -772,7 +772,6 @@ menu "Virtualization"
>  config PROTECTED_VIRTUALIZATION_GUEST
>  	def_bool n
>  	prompt "Protected virtualization guest support"
> -	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>  	help
>  	  Select this option, if you want to be able to run this
>  	  kernel as a protected virtualization KVM guest.
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 86ffd0d51fd5..2c3b451813ed 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -31,6 +31,7 @@
>  #include <linux/cma.h>
>  #include <linux/gfp.h>
>  #include <linux/dma-direct.h>
> +#include <linux/platform-feature.h>
>  #include <asm/processor.h>
>  #include <linux/uaccess.h>
>  #include <asm/pgalloc.h>
> @@ -168,22 +169,14 @@ bool force_dma_unencrypted(struct device *dev)
>  	return is_prot_virt_guest();
>  }
>=20
> -#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> -
> -int arch_has_restricted_virtio_memory_access(void)
> -{
> -	return is_prot_virt_guest();
> -}
> -EXPORT_SYMBOL(arch_has_restricted_virtio_memory_access);
> -
> -#endif
> -
>  /* protected virtualization */
>  static void pv_init(void)
>  {
>  	if (!is_prot_virt_guest())
>  		return;
>=20
> +	platform_set(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
> +
>  	/* make sure bounce buffers are shared */
>  	swiotlb_force =3D SWIOTLB_FORCE;
>  	swiotlb_init(1);
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index b0142e01002e..20ac72546ae4 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1515,7 +1515,6 @@ config X86_CPA_STATISTICS
>  config X86_MEM_ENCRYPT
>  	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
>  	select DYNAMIC_PHYSICAL_MASK
> -	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>  	def_bool n
>=20
>  config AMD_MEM_ENCRYPT
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 4b67094215bb..965518b9d14b 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -19,6 +19,7 @@
>  #include <linux/i8253.h>
>  #include <linux/random.h>
>  #include <linux/swiotlb.h>
> +#include <linux/platform-feature.h>
>  #include <asm/processor.h>
>  #include <asm/hypervisor.h>
>  #include <asm/hyperv-tlfs.h>
> @@ -347,8 +348,10 @@ static void __init ms_hyperv_init_platform(void)
>  #endif
>  		/* Isolation VMs are unenlightened SEV-based VMs, thus this check: */
>  		if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
> -			if (hv_get_isolation_type() !=3D HV_ISOLATION_TYPE_NONE)
> +			if (hv_get_isolation_type() !=3D HV_ISOLATION_TYPE_NONE) {
>  				cc_set_vendor(CC_VENDOR_HYPERV);
> +
> 	platform_set(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
> +			}
>  		}
>  	}
>=20

Unless I'm misunderstanding something, the Hyper-V specific change isn't
needed.   Hyper-V doesn't support virtio in the first place, so it's a bit
unexpected be setting a virtio-related flag in Hyper-V code.   Also, Hyper-=
V
guests call sev_setup_arch() with CC_ATTR_GUEST_MEM_ENCRYPT set,
so this virtio-related flag will get set anyway via that path.

Michael

> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 50d209939c66..9b6a7c98b2b1 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -76,9 +76,3 @@ void __init mem_encrypt_init(void)
>=20
>  	print_mem_encrypt_feature_info();
>  }
> -
> -int arch_has_restricted_virtio_memory_access(void)
> -{
> -	return cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
> -}
> -EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
> diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.=
c
> index 6169053c2854..39b71084d36b 100644
> --- a/arch/x86/mm/mem_encrypt_amd.c
> +++ b/arch/x86/mm/mem_encrypt_amd.c
> @@ -21,6 +21,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/virtio_config.h>
>  #include <linux/cc_platform.h>
> +#include <linux/platform-feature.h>
>=20
>  #include <asm/tlbflush.h>
>  #include <asm/fixmap.h>
> @@ -206,6 +207,9 @@ void __init sev_setup_arch(void)
>  	size =3D total_mem * 6 / 100;
>  	size =3D clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
>  	swiotlb_adjust_size(size);
> +
> +	/* Set restricted memory access for virtio. */
> +	platform_set(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
>  }
>=20
>  static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *r=
et_prot)
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index b5adf6abd241..a6dc8b5846fe 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -6,12 +6,6 @@ config VIRTIO
>  	  bus, such as CONFIG_VIRTIO_PCI, CONFIG_VIRTIO_MMIO, CONFIG_RPMSG
>  	  or CONFIG_S390_GUEST.
>=20
> -config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> -	bool
> -	help
> -	  This option is selected if the architecture may need to enforce
> -	  VIRTIO_F_ACCESS_PLATFORM
> -
>  config VIRTIO_PCI_LIB
>  	tristate
>  	help
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 22f15f444f75..371e16b18381 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -5,6 +5,7 @@
>  #include <linux/module.h>
>  #include <linux/idr.h>
>  #include <linux/of.h>
> +#include <linux/platform-feature.h>
>  #include <uapi/linux/virtio_ids.h>
>=20
>  /* Unique numbering for virtio devices. */
> @@ -170,12 +171,10 @@ EXPORT_SYMBOL_GPL(virtio_add_status);
>  static int virtio_features_ok(struct virtio_device *dev)
>  {
>  	unsigned status;
> -	int ret;
>=20
>  	might_sleep();
>=20
> -	ret =3D arch_has_restricted_virtio_memory_access();
> -	if (ret) {
> +	if (platform_has(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS)) {
>  		if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
>  			dev_warn(&dev->dev,
>  				 "device must provide VIRTIO_F_VERSION_1\n");
> diff --git a/include/linux/platform-feature.h b/include/linux/platform-fe=
ature.h
> index 6ed859928b97..5e2f08554b38 100644
> --- a/include/linux/platform-feature.h
> +++ b/include/linux/platform-feature.h
> @@ -6,7 +6,8 @@
>  #include <asm/platform-feature.h>
>=20
>  /* The platform features are starting with the architecture specific one=
s. */
> -#define PLATFORM_FEAT_N				(0 +
> PLATFORM_ARCH_FEAT_N)
> +#define PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS	(0 +
> PLATFORM_ARCH_FEAT_N)
> +#define PLATFORM_FEAT_N				(1 +
> PLATFORM_ARCH_FEAT_N)
>=20
>  void platform_set(unsigned int feature);
>  void platform_clear(unsigned int feature);
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.=
h
> index b341dd62aa4d..79498298519d 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -559,13 +559,4 @@ static inline void virtio_cwrite64(struct virtio_dev=
ice *vdev,
>  		_r;							\
>  	})
>=20
> -#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> -int arch_has_restricted_virtio_memory_access(void);
> -#else
> -static inline int arch_has_restricted_virtio_memory_access(void)
> -{
> -	return 0;
> -}
> -#endif /* CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS */
> -
>  #endif /* _LINUX_VIRTIO_CONFIG_H */
> --
> 2.34.1

