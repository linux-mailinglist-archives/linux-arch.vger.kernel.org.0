Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D1764A56A
	for <lists+linux-arch@lfdr.de>; Mon, 12 Dec 2022 18:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbiLLRC0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Dec 2022 12:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiLLRCZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Dec 2022 12:02:25 -0500
Received: from CY4PR02CU007-vft-obe.outbound.protection.outlook.com (mail-westcentralusazon11021019.outbound.protection.outlook.com [40.93.199.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE51E7B;
        Mon, 12 Dec 2022 09:02:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfPSw7e7yUNb2L+NPl2aS2v3Urm6M2rs1EYRfxH/jd/iddvZhTeH4eJsA/rMTofxBby7bZpeCdlllsuhevVLa3gAKckMuxNJdfpYLrJEDkKH+nptcu51vzJrChkzOKz/HM3r02BgXY90MtpuqzJeQNpcr/SzqzyXFCkAag9Eg6yuYvUqswt5IECJFUgQmArz8ZCaLwilUIVm+4ygz3k37CsBD/4rqsIrudF7aGnm0Pxb+WgZayjJqgq7gB1yFhQaRwQELEooXpC4Kwvq9hCDI8n+Y1FNsUehAcE1jxgV1vHHohXlWsW4+Q7ZYpi/e1XQu4BSkG2Dt2iQo/AAcac6QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7CGnFLCLth+cEluGsWHPV0h7T8VDbrE5sZXwn59tkk=;
 b=PG9E3hLxY5zzvMzNl3LRB2niGjyJiQliXoSMUh6oqurXFQc+CL+XVJI+p/yDTNUFKKwzIRl++VjzA6DrjfgQloaRlISbIOqnl2s+3KjBmSwmtKCo5E7Eg1RN29VqmO06XTUWKdUohsTVAgXL7mVHilcHOBrgoX6j3aLamjBsHlh+AWNJpxy/Qh6h1MkW8VSjMaFNqmG/X8U/PJxEjLg+QD+0B0EjmqQYnts1E9Rl1XIRmOLALR/M+ZocKZdyaNzi7dk5ftIMj/Rth5Ax0Z9ATA/uqqqpFsUkplZDbGUlGBbxfaE4SufWxW/bIJdbCEBqqX5Z5L9JvrnH+mH9TtAQ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7CGnFLCLth+cEluGsWHPV0h7T8VDbrE5sZXwn59tkk=;
 b=Rhcg2xrAziIStFxnCNLm+dnNRr9AQ6nnPzg8Xpfq3oKzXjU8TBXbv4QV5m7+pjlyuEVQAHRDIoJY2HUK+AqtAeYXW0olEUeklRvRmrtE9c7vT3TBF5Js0XWLmX7BnFSvClGN/X9ZVANqAUkcioQIQgn7qVDG+8s9YzQHR07hTgk=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MW4PR21MB1876.namprd21.prod.outlook.com (2603:10b6:303:64::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.2; Mon, 12 Dec
 2022 17:02:16 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%8]) with mapi id 15.20.5944.002; Mon, 12 Dec 2022
 17:02:16 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 6/6] Drivers: hv: vmbus: Support TDX guests
Thread-Topic: [PATCH v2 6/6] Drivers: hv: vmbus: Support TDX guests
Thread-Index: AQHZCdO7v/iQZOay70+ESepxHwMb165qgFMQ
Date:   Mon, 12 Dec 2022 17:02:16 +0000
Message-ID: <BYAPR21MB168823D0A03CC3DC3E2365A5D7E29@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221207003325.21503-1-decui@microsoft.com>
 <20221207003325.21503-7-decui@microsoft.com>
In-Reply-To: <20221207003325.21503-7-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=040aec30-5c5e-4632-b625-7fe1c0d87b7d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-12T16:51:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MW4PR21MB1876:EE_
x-ms-office365-filtering-correlation-id: 8c52ff24-a897-4c56-795f-08dadc629f79
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZaTw/PKLJVa5fdfME0AEc8VCtWcfyCCT98HXe99XIQ9ckwKP/EUk8yRKTfYAuyCHpr/hNE8sc1M7zNkwu+hrN6Dws/wn3kukmJoiD2U1u9+YhPB4WOMcFZjSUvgKCBFKzYxUyx5ETGiaWMktSXoh2DB+Wqpghyu24gQT+5gKStp7btL6dv09aCrF3kaHg5Vwtk6fJLgXgy6jbk7W20sNqMHoYXgfchnci2OjqhBxTy26/rOT7RQpI+MaATGYpZe7/elOp1TuE0ffKyxYSKYURKA5BEK0ehLkAZZuil4esfQdrV3GwuWtanErKmbsMeUKziGjG7XU/cK4qyVrb9UNgsJSm2qNJgX0CNk/M/CDlp0dKY7q7j7ctKi/dX1Nr2zY1K93yqjUshqgyrqolGP7H+kZABQrEyofuYY1oPYiI2PjVYf4Rho8629B4vTBZEwGDySjkzgWP3ZcPrToLOjZqD32fpfprsNnDrfM4u4luz4J6Ypb5shASb4mFF2xUfqpEEYE+pw7sjiiaogyrTqDg9iNxxB67Rk7U/85VqRVdL1byDahJCbF34i5FuuEE/Jd4HXy66Bdz/DQS+ntSNj+JO3VNlxq4kQUoSzrK80nezmjeOQp7n/cKLUrFBOEDAlD+SdWNde3Zlqen8dsSY27DBm1k9HmvwK8cBRV4ubIDGMAOh+vOl5kzcHxTwvc634aJZWsTDX6gtue/BOGg68GVwrgiOB1YzwFlXoV/70jm8Z3x2qROk7VWGB92Il17g3n8IoddGZxS7NSSW42EJ3xpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199015)(41300700001)(52536014)(2906002)(8936002)(30864003)(33656002)(8990500004)(7416002)(5660300002)(921005)(6506007)(186003)(9686003)(38070700005)(26005)(7696005)(82950400001)(83380400001)(82960400001)(38100700002)(316002)(76116006)(66476007)(66556008)(66946007)(8676002)(64756008)(55016003)(66446008)(4326008)(478600001)(122000001)(86362001)(10290500003)(71200400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vMrZ2h5L7vOEa7lOS8WgsudGya1Uw3ofQVxTRbugnhRARZslBqo1k8ETSWxp?=
 =?us-ascii?Q?Ckc1HlvtUb94KfDzDO2AjdzTw12tJLTmPt5tIaYNQUdYryjDrBu4z8EQocqN?=
 =?us-ascii?Q?Z0bFZ15O1KMQzKzKPUUhPr35pdebeAIYJL2YqU2jCvYOvodq2lJ8IsBFxiGj?=
 =?us-ascii?Q?w3bLUJI9ReVesRynoO5dRrWcRcUWvraEOujDwdzwgs65g8u2rn5TBxoNkbsD?=
 =?us-ascii?Q?4BHax10sIFbBkZcFVf4l9b/BMSbwpKIsYXKGQnn+mR88X+oxJ6cJr4nCgq+N?=
 =?us-ascii?Q?t/PkZg4pq/GagJVt+lO4l1FkXM/LXpmYRGzxSeAx+Ygi6/gpX/TicPKVjkuI?=
 =?us-ascii?Q?pnxxzZIG3eeYlGD6F5XGD9c4a/L5+C43E5JGJsunx/yFPy61K0I5eah6cwU0?=
 =?us-ascii?Q?WbK2BWhJmJOXJ0G/+Gaci18gdokXRVlLKeMQYaLrJlD1pfGGN7F+oP0u45gp?=
 =?us-ascii?Q?ag8XZRrrZcPVkJ4yfPp+v/VrvpzbvcUSUS3slHw9CgMfRfoVIqwaKKaS+FY6?=
 =?us-ascii?Q?THadRGCg4c1sj5WucLoQTG6XdmTZVRXsXd4ueWobapnKdAsY43owqMRbQk4I?=
 =?us-ascii?Q?g6BC0IviJxnmWi7qQWpYR0tf0jy/NfdPL5ro8Jybt0vDkI9l2Ltx7rzB0o7L?=
 =?us-ascii?Q?V/ZSnDn4VJjdvjDlXM5jSfTdiPReCX9T8q/kd/pd1oV4ciROumF1nzTEjdxL?=
 =?us-ascii?Q?TMM8IUd7USRU+grTpPXJM7fFoS6VaAvRY0Ec/7juWjEJoghmX+pvrh/PJVGJ?=
 =?us-ascii?Q?wnRkM6amW//wjAv2aZX0lPdFeJGK1aJJTKxmq8/amxpt5w8nPOL+tffouDn3?=
 =?us-ascii?Q?34NnkTW58Hsu3APWGuocsVDu38sNax04mOZW9mxgCKSLQxvSYqsHtiRbTM1V?=
 =?us-ascii?Q?DjBsBDzxHm9vLSWLwZ2wH/1tWjLWkD98IHPmudAtwPTnxfmOanTydcqFUMeC?=
 =?us-ascii?Q?TuiYKmEtJjGgW8PAnqOhoVD+HKy74GBMnI2tiMwS6132EW4Uin7eCTuecFAa?=
 =?us-ascii?Q?sdpu5+wxyYXIeo/sQfNS83HLZzPWgEASCRaqFFk/CAGbc6p7jZeRZGrouVpe?=
 =?us-ascii?Q?xlBQSZ4brp8CtCiuRK1anDoKlaMG400ugY2NzrIPrF4hobUgANkXwEJorcaH?=
 =?us-ascii?Q?gcZnOvfAjqLbfo6nTRv/XDIGq3Q+fZY8Ljp39fyYvTIft2PHgEmFCgOf/nxs?=
 =?us-ascii?Q?74kLA/qkQXueJxKg6uExjK04R84gZnbZNcdMuQrHNSJg8FAkadELlZ2iivWK?=
 =?us-ascii?Q?n2HH1QU/pc2vXDFfvCMH3R5kbDl4KLzYVH62uccn965wK8xVym22Og6qDip2?=
 =?us-ascii?Q?3Tlf3v9QVRHj9bi1uC1OapA3uOANPFeD06JhjFDRtEdFZF0PJJ35/xmGZ48p?=
 =?us-ascii?Q?SwM+gc2sJJWkJaQogEHShAVk5AvSNsZ/BV2t4bdYK1WQayV5grFbs615xE8g?=
 =?us-ascii?Q?MwUjesC8vWT+0qmzP9li3CTxgKzZ4tOhqBjOksHUQIuyijPD/CttWTY0oJlh?=
 =?us-ascii?Q?tTBRDKe7AOgUjrRT8fDqem+IEkrCp87D5LIYeWF4PyohpKg5aHl8alOX69h/?=
 =?us-ascii?Q?rxLFkJH0p0dRfzt/CKq/fdpdbTvkWerTtVf1mGYa+8xrsS0N1QVdlzTMVJYb?=
 =?us-ascii?Q?Lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c52ff24-a897-4c56-795f-08dadc629f79
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 17:02:16.6478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xf57PogMW/vPSz2W0m5oSYEp20Nn+so0Pzgew/2JHNqX2Tqua1r8B0PlvPMp34wX4o8VEJArcvYwyY+x8B4OfFN1cjtwgCFCQifCKqNHSu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1876
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Tuesday, December 6, 2022 4:33=
 PM
>=20
> Add Hyper-V specific code so that a TDX guest can run on Hyper-V:
>   No need to use hv_vp_assist_page.
>   Don't use the unsafe Hyper-V TSC page.
>   Don't try to use HV_REGISTER_CRASH_CTL.
>   Share SynIC Event/Message pages and VMBus Monitor pages with the host.
>   Use pgprot_decrypted(PAGE_KERNEL_NOENC))in hv_ringbuffer_init().
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>=20
> Changes in v2:
>   Used a new function hv_set_memory_enc_dec_needed() in
>     __set_memory_enc_pgtable().
>   Added the missing set_memory_encrypted() in hv_synic_free().
>=20
> ---
>=20
>  arch/x86/hyperv/hv_init.c      | 19 ++++++++---
>  arch/x86/hyperv/ivm.c          |  5 +++
>  arch/x86/kernel/cpu/mshyperv.c | 17 +++++++++-
>  arch/x86/mm/pat/set_memory.c   |  2 +-
>  drivers/hv/connection.c        |  4 ++-
>  drivers/hv/hv.c                | 60 +++++++++++++++++++++++++++++++++-
>  drivers/hv/hv_common.c         |  6 ++++
>  drivers/hv/ring_buffer.c       |  2 +-
>  include/asm-generic/mshyperv.h |  2 ++
>  9 files changed, 108 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index c0ba53ad8b8e..8d7b63346194 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -77,7 +77,7 @@ static int hyperv_init_ghcb(void)
>  static int hv_cpu_init(unsigned int cpu)
>  {
>  	union hv_vp_assist_msr_contents msr =3D { 0 };
> -	struct hv_vp_assist_page **hvp =3D &hv_vp_assist_page[cpu];
> +	struct hv_vp_assist_page **hvp;
>  	int ret;
>=20
>  	ret =3D hv_common_cpu_init(cpu);
> @@ -87,6 +87,7 @@ static int hv_cpu_init(unsigned int cpu)
>  	if (!hv_vp_assist_page)
>  		return 0;
>=20
> +	hvp =3D &hv_vp_assist_page[cpu];
>  	if (hv_root_partition) {
>  		/*
>  		 * For root partition we get the hypervisor provided VP assist
> @@ -396,11 +397,21 @@ void __init hyperv_init(void)
>  	if (hv_common_init())
>  		return;
>=20
> -	hv_vp_assist_page =3D kcalloc(num_possible_cpus(),
> -				    sizeof(*hv_vp_assist_page), GFP_KERNEL);
> +	/*
> +	 * The VP assist page is useless to a TDX guest: the only use we
> +	 * would have for it is lazy EOI, which can not be used with TDX.
> +	 */
> +	if (hv_isolation_type_tdx())
> +		hv_vp_assist_page =3D NULL;
> +	else
> +		hv_vp_assist_page =3D kcalloc(num_possible_cpus(),
> +					    sizeof(*hv_vp_assist_page),
> +					    GFP_KERNEL);
>  	if (!hv_vp_assist_page) {
>  		ms_hyperv.hints &=3D
> ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
> -		goto common_free;
> +
> +		if (!hv_isolation_type_tdx())
> +			goto common_free;
>  	}
>=20
>  	if (hv_isolation_type_snp()) {
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 07e4253b5809..4398042f10d5 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -258,6 +258,11 @@ bool hv_is_isolation_supported(void)
>  	return hv_get_isolation_type() !=3D HV_ISOLATION_TYPE_NONE;
>  }
>=20
> +bool hv_set_memory_enc_dec_needed(void)
> +{
> +	return hv_is_isolation_supported() && !hv_isolation_type_tdx();
> +}
> +
>  DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
>=20
>  /*
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 941372449ff2..24569da3c1f8 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -345,8 +345,23 @@ static void __init ms_hyperv_init_platform(void)
>  		}
>=20
>  		if (IS_ENABLED(CONFIG_INTEL_TDX_GUEST) &&
> -		    hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_TDX)
> +		    hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_TDX) {
>  			static_branch_enable(&isolation_type_tdx);
> +
> +			/*
> +			 * The GPAs of SynIC Event/Message pages and VMBus
> +			 * Moniter pages need to be added by this offset.
> +			 */
> +			ms_hyperv.shared_gpa_boundary =3D cc_mkdec(0);
> +
> +			/* Don't use the unsafe Hyper-V TSC page */
> +			ms_hyperv.features &=3D
> +				~HV_MSR_REFERENCE_TSC_AVAILABLE;
> +
> +			/* HV_REGISTER_CRASH_CTL is unsupported */
> +			ms_hyperv.misc_features &=3D
> +				 ~HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
> +		}
>  	}
>=20
>  	if (hv_max_functions_eax >=3D HYPERV_CPUID_NESTED_FEATURES) {
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 2e5a045731de..5892196f8ade 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2120,7 +2120,7 @@ static int __set_memory_enc_pgtable(unsigned long a=
ddr,
> int numpages, bool enc)
>=20
>  static int __set_memory_enc_dec(unsigned long addr, int numpages, bool e=
nc)
>  {
> -	if (hv_is_isolation_supported())
> +	if (hv_set_memory_enc_dec_needed())
>  		return hv_set_mem_host_visibility(addr, numpages, !enc);
>=20
>  	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 9dc27e5d367a..1ecc3c29e3f7 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -250,12 +250,14 @@ int vmbus_connect(void)
>  		 * Isolation VM with AMD SNP needs to access monitor page via
>  		 * address space above shared gpa boundary.
>  		 */
> -		if (hv_isolation_type_snp()) {
> +		if (hv_isolation_type_snp() || hv_isolation_type_tdx()) {
>  			vmbus_connection.monitor_pages_pa[0] +=3D
>  				ms_hyperv.shared_gpa_boundary;
>  			vmbus_connection.monitor_pages_pa[1] +=3D
>  				ms_hyperv.shared_gpa_boundary;
> +		}
>=20
> +		if (hv_isolation_type_snp()) {
>  			vmbus_connection.monitor_pages[0]
>  				=3D
> memremap(vmbus_connection.monitor_pages_pa[0],
>  					   HV_HYP_PAGE_SIZE,
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 4d6480d57546..78aca415985c 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -18,6 +18,7 @@
>  #include <linux/clockchips.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> +#include <linux/set_memory.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/mshyperv.h>
>  #include "hyperv_vmbus.h"
> @@ -119,6 +120,7 @@ int hv_synic_alloc(void)
>  {
>  	int cpu;
>  	struct hv_per_cpu_context *hv_cpu;
> +	int ret =3D -ENOMEM;
>=20
>  	/*
>  	 * First, zero all per-cpu memory areas so hv_synic_free() can
> @@ -168,6 +170,30 @@ int hv_synic_alloc(void)
>  			pr_err("Unable to allocate post msg page\n");
>  			goto err;
>  		}
> +
> +
> +		if (hv_isolation_type_tdx()) {
> +			ret =3D set_memory_decrypted(
> +				(unsigned long)hv_cpu->synic_message_page, 1);
> +			if (ret) {
> +				pr_err("Failed to decrypt SYNIC msg page\n");
> +				goto err;
> +			}
> +
> +			ret =3D set_memory_decrypted(
> +				(unsigned long)hv_cpu->synic_event_page, 1);
> +			if (ret) {
> +				pr_err("Failed to decrypt SYNIC event page\n");
> +				goto err;
> +			}
> +
> +			ret =3D set_memory_decrypted(
> +				(unsigned long)hv_cpu->post_msg_page, 1);
> +			if (ret) {
> +				pr_err("Failed to decrypt post msg page\n");
> +				goto err;
> +			}
> +		}
>  	}
>=20
>  	return 0;
> @@ -176,18 +202,42 @@ int hv_synic_alloc(void)
>  	 * Any memory allocations that succeeded will be freed when
>  	 * the caller cleans up by calling hv_synic_free()
>  	 */
> -	return -ENOMEM;
> +	return ret;
>  }
>=20
>=20
>  void hv_synic_free(void)
>  {
>  	int cpu;
> +	int ret;
>=20
>  	for_each_present_cpu(cpu) {
>  		struct hv_per_cpu_context *hv_cpu
>  			=3D per_cpu_ptr(hv_context.cpu_context, cpu);
>=20
> +		if (hv_isolation_type_tdx()) {
> +			ret =3D set_memory_encrypted(
> +				(unsigned long)hv_cpu->synic_message_page, 1);
> +			if (ret) {
> +				pr_err("Failed to encrypt SYNIC msg page\n");
> +				continue;
> +			}
> +
> +			ret =3D set_memory_encrypted(
> +				(unsigned long)hv_cpu->synic_event_page, 1);
> +			if (ret) {
> +				pr_err("Failed to encrypt SYNIC event page\n");
> +				continue;
> +			}
> +
> +			ret =3D set_memory_encrypted(
> +				(unsigned long)hv_cpu->post_msg_page, 1);
> +			if (ret) {
> +				pr_err("Failed to encrypt post msg page\n");
> +				continue;
> +			}
> +		}
> +
>  		free_page((unsigned long)hv_cpu->synic_event_page);
>  		free_page((unsigned long)hv_cpu->synic_message_page);
>  		free_page((unsigned long)hv_cpu->post_msg_page);
> @@ -225,6 +275,10 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	} else {
>  		simp.base_simp_gpa =3D virt_to_phys(hv_cpu->synic_message_page)
>  			>> HV_HYP_PAGE_SHIFT;
> +
> +		if (hv_isolation_type_tdx())
> +			simp.base_simp_gpa |=3D ms_hyperv.shared_gpa_boundary
> +				>> HV_HYP_PAGE_SHIFT;

Since we're using cc_mkdec() in hv_do_hypercall() to set the SHARED bit,
perhaps the same could be done here to simplify the code and avoid the
explicit call to hv_isolation_type_tdx():

		simp.base_simp_gpa =3D cc_mkdec(virt_to_phys(hv_cpu->synic_message))
			>> HV_HYP_PAGE_SHIFT;

cc_mkdec() does nothing in a normal VM, and vTOM VMs are already
special-cased.

>  	}
>=20
>  	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
> @@ -243,6 +297,10 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	} else {
>  		siefp.base_siefp_gpa =3D virt_to_phys(hv_cpu->synic_event_page)
>  			>> HV_HYP_PAGE_SHIFT;
> +
> +		if (hv_isolation_type_tdx())
> +			siefp.base_siefp_gpa |=3D ms_hyperv.shared_gpa_boundary
> +				>> HV_HYP_PAGE_SHIFT;

Same here.


>  	}
>=20
>  	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index a9a03ab04b97..192dcf295dfc 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -262,6 +262,12 @@ bool __weak hv_is_isolation_supported(void)
>  }
>  EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
>=20
> +bool __weak hv_set_memory_enc_dec_needed(void)
> +{
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(hv_set_memory_enc_dec_needed);
> +
>  bool __weak hv_isolation_type_snp(void)
>  {
>  	return false;
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index c6692fd5ab15..a51da82316ce 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -233,7 +233,7 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ri=
ng_info,
>=20
>  		ring_info->ring_buffer =3D (struct hv_ring_buffer *)
>  			vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP,
> -				PAGE_KERNEL);
> +				pgprot_decrypted(PAGE_KERNEL_NOENC));
>=20
>  		kfree(pages_wraparound);
>  		if (!ring_info->ring_buffer)
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index bfb9eb9d7215..b7b1b18c9854 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -262,6 +262,7 @@ bool hv_is_hyperv_initialized(void);
>  bool hv_is_hibernation_supported(void);
>  enum hv_isolation_type hv_get_isolation_type(void);
>  bool hv_is_isolation_supported(void);
> +bool hv_set_memory_enc_dec_needed(void);
>  bool hv_isolation_type_snp(void);
>  u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_=
size);
>  void hyperv_cleanup(void);
> @@ -274,6 +275,7 @@ static inline bool hv_is_hyperv_initialized(void) { r=
eturn false; }
>  static inline bool hv_is_hibernation_supported(void) { return false; }
>  static inline void hyperv_cleanup(void) {}
>  static inline bool hv_is_isolation_supported(void) { return false; }
> +static inline bool hv_set_memory_enc_dec_needed(void) { return false; }
>  static inline enum hv_isolation_type hv_get_isolation_type(void)
>  {
>  	return HV_ISOLATION_TYPE_NONE;
> --
> 2.25.1

