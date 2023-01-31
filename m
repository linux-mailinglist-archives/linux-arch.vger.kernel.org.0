Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BA168345E
	for <lists+linux-arch@lfdr.de>; Tue, 31 Jan 2023 18:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjAaRzq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Jan 2023 12:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjAaRzp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2023 12:55:45 -0500
Received: from DM6FTOPR00CU001-vft-obe.outbound.protection.outlook.com (mail-cusazon11020027.outbound.protection.outlook.com [52.101.61.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9D26A46;
        Tue, 31 Jan 2023 09:55:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpApO8bZlZTWDGJIJgCdgkaIPnHBGiobs65QLbU7kky+IPn0xTGv3eK7b4wHzxAHsTLYVUussmrMKh4PXyYXWZbVpWxURUAmQpYz5RB11OdA6ZPEKjfdetCX0Q7TWsPkcyeXnJkbwodruiqIobvQQ8vsuCheCaRYOOlKpBrv/ST9i1V9GPlYCVhys4QzDuD7B8gphWbWSIQ5pZyxO3h4CEJfR1Nl3FG9nyzP2r7K3EJnM0Kz61R9QD7TPTT9Z97Af3Y4FJ0CAATiENcLgaHbFgy3q3blWIdFc7ZjD7QyNpn4c1NnU/w6ec8fNPNRNiIEzwOAUwOz+c+iICjde8jUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xt5dftNv3daHsKyukvYpcJg6hNS9GkmH2SPazNdu/S0=;
 b=IE/SHK7r6Z0yLkc5Rn+ykrjzQvHAwy6AQjwWQofZ4KoWYL6uRbMt/NoitkeJH/aQ15eDalm07QqBWbjsCoJC7pUJQzFzaAxkhSP7WnFgluZlGGljE4mmyvXj2Gf81l1+9xHzy/Q1SpzbB5PvEja/LuwaFDaOCSXZE/fn20FFlQGgj9PbaYi0bZnSVKWwMq/lTwDud9LCTMHzij89Ob/c/MUuFHnfd+oFJ7MUi+2iazc+q40Vu1genNg3CZgBha/ZNWMejLahuvYjssD8zLltMlgGN+J0ot0XhKYXmQGCne2Xn5LgJ/PpuGfNtCEC+QKfkuis8epo7zVtZD8q0oiBrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xt5dftNv3daHsKyukvYpcJg6hNS9GkmH2SPazNdu/S0=;
 b=GjY/j5ufGVwtK7IkrBGxt/HU11by/NX3b/dM82uSZjXhYPIpGjVR2PN1Li5onn8eymgzzFJDWHxBxYIPR35M5JtzTFs14BD0DUtoWxeZEu05b49+DpZzliWpKRRfpEzIwWdtawVjhIpspV9Qfq7ZgfAoNWRCXT3GmPgr4XdEpJQ=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MW4PR21MB1954.namprd21.prod.outlook.com (2603:10b6:303:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.4; Tue, 31 Jan
 2023 17:55:19 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e%8]) with mapi id 15.20.6086.005; Tue, 31 Jan 2023
 17:55:19 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jgross@suse.com" <jgross@suse.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "jiangshan.ljs@antgroup.com" <jiangshan.ljs@antgroup.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "srutherford@google.com" <srutherford@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "venu.busireddy@oracle.com" <venu.busireddy@oracle.com>,
        "sterritt@google.com" <sterritt@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC PATCH V3 03/16] x86/hyperv: Set Virtual Trust Level in vmbus
 init message
Thread-Topic: [RFC PATCH V3 03/16] x86/hyperv: Set Virtual Trust Level in
 vmbus init message
Thread-Index: AQHZLgu8lqz2FE3fb0++ejSST0BxLK642JwA
Date:   Tue, 31 Jan 2023 17:55:18 +0000
Message-ID: <BYAPR21MB16885D6652BEEA882D96C97CD7D09@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-4-ltykernel@gmail.com>
In-Reply-To: <20230122024607.788454-4-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c8aee6fb-9b2a-4e50-9695-0cbe45cb09fb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-31T17:35:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MW4PR21MB1954:EE_
x-ms-office365-filtering-correlation-id: 3b7efb48-3582-4b39-8939-08db03b450ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5bYN3XYpEwibAtWalH5JE5GHF0TIOMUGrb1LApA3iO28qVuqGUkqgm9/DUng0T5lBfWlD835YZLstTY+p/QF6tTg8KEUDy88PhuHeCrtRoaLDhDClJ4yUQTEUc83inuD39eITRgjmvZfjkbSTIFzE/Av6MgtIXEGdUj5KDyOkvp3a0wm2jWPtyzDhPNPdXMkjjPDWptOWDKm+WhzJEHKMhnlgoruGndfDByqD0FqHA1EX9oMHJTVvmKgCv2A28KoG3jfbxeINImivKClL+umLtiv1R0DNPxpOJ7VWzAx0vIr5wEWn2YYp3MF2RccTs9vhiq0BGXwRAfOhlYbGbq91B7wOvJm3rrXB+NNLHGmYc/k/fXrs2y2/cNzM4ewyweMR0K+/p4oxIS1z6zuxH0WDCBuFvjWP9/PvYHZWq9WWaldgAloJfTH5chfKTTl+LpvaNn5nSasw69I20REVbH7ZhOx8QlfplV6P4NtBd+q9Ebihm5K7Wn4pHTdIfQr+UenD2/wx+17ydCjYCLchgHr03/rf6cQa3raR/EUed1ENXutPekvJ8nXqby2/3sfr8mzLoHWVmFPEJRzPjUSecyyjyVURLbivsKgfQZ1C3ypwboxOIwsd624yLyVg+QgFuCb7XO1W1HXLRrKEdpgFASUjJNFCO+EH0lZ0jFWFi8wFINJ3zya/dRg+ugKskTTJrXu+2ISf354OH+h5zPDatF699pOr3pzZthu6E60NKXaKrfZzLJmj4B5DJAm+sOdkFKWNsnlKJXWYtFCS58lQ6VW6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199018)(8990500004)(83380400001)(38070700005)(2906002)(15650500001)(7416002)(7406005)(5660300002)(64756008)(7696005)(26005)(71200400001)(66446008)(76116006)(86362001)(8936002)(6506007)(4326008)(52536014)(66946007)(66476007)(8676002)(66556008)(478600001)(9686003)(10290500003)(38100700002)(82960400001)(186003)(921005)(55016003)(122000001)(316002)(41300700001)(110136005)(54906003)(82950400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P2sJqoLM8J7KIktya9EU0IpBdR4vNWXvZs0p60Iqcal5fO6Z6oSkzhXeZYXD?=
 =?us-ascii?Q?m9EtcCe/rva5kwdteUB8iEQ2YQ1auyX82Fc4RCV3Ea8f0FO4vxa3P+pCHCBU?=
 =?us-ascii?Q?tNbolUc0sJ21Eg35mcPehZk/Ty4LjNDvxApS7ucgOxormk5fmhU1U4g3Tgkw?=
 =?us-ascii?Q?voqqfVTdKJXg7t1RK7ZxIETMTCY3qGO/ZMblL/YKmt11tu3pQnr/biD/VREm?=
 =?us-ascii?Q?pk57swuxv7QUzlRYUXm4Rgx7Slf5MS5sqWtcZ7nZp1M89AWkSv2uJULEcZ/i?=
 =?us-ascii?Q?7mJ+E6LR6zE5iTpz0nTCdWHawnHG8095UYeGR0Cf0PtY/i5MMJSn8ikSCxwM?=
 =?us-ascii?Q?7sXHLf+SEvg1ovlpAIm69UL+BxYTWrBY6Q5YbtQO9BOcf8oHZjGtFAH82smJ?=
 =?us-ascii?Q?b999ZXHTd2uRUfTHkLGl5mV/3ZfWqipnGuN7wY1KzA4wMP/+qAOYiHsEh85a?=
 =?us-ascii?Q?/DQ5Xf0NgzAyWeLVCzUjhmHKf2ymlJz+Fcp5gaGh8WRrp7KsqXaarXsYTQSG?=
 =?us-ascii?Q?UPNpWCizU8FFvZFrt74Mq2G3BuPu3Ywrzgon12GFwoWpkvFwcEcs5DVFn46j?=
 =?us-ascii?Q?ga/MKe7WetpBJ0iephTDRscMF0FW8gQIWkapDh4rrswCTVEs3/kxRGszRAsX?=
 =?us-ascii?Q?HTkdh19Cab14p10U4HsFpHj1rdOu4YFh00Kphl+TXsV7vc1ZSCEXoeN/UNUj?=
 =?us-ascii?Q?WJK7asTYqxclcZ7jxFkfT0fKue89saf5amB9nmIU6yIx/Hae0RD8afsZfIc5?=
 =?us-ascii?Q?AWr2rY9WpoW/r3di8de9SzPxoRhGhoVhoYHUqJOPa8wpSbCzopQftLaSgzkP?=
 =?us-ascii?Q?9qqG5XcoaeGXWgSnFadVOS760ootuAJb8B7+4ZTqtF+sgwID4dawqZYGh66N?=
 =?us-ascii?Q?yPR+ZtHqam0a4J9iuvjKqZO5pjiPBu1GBit4J1EmIpGnqyasyc8wWDVkhgtc?=
 =?us-ascii?Q?Bwqksam6IMH58tagmUPiN0jjHo4nijjN2mwHK6/c+BPUih0jtgohJV96brnk?=
 =?us-ascii?Q?zXsHyRpTJmYMJw1Q//5JhMtoKxkY1cm/U/Mt9lTIw5zgX4TN6aRj/78sX02T?=
 =?us-ascii?Q?Dyn4TTs6GVzI4jeDYR7Z2+bMW8d0MY5diaAqEOIaOlJ/lsp2RHg6tPWsRh7T?=
 =?us-ascii?Q?2PyZHDpwmg58ONPGsF0qTjkrREM2bbyI2XlZN+NuGAGIu9FbGAPni1pyaa5x?=
 =?us-ascii?Q?hdfzsHwptAsDBP4NlOR58FKpmwbmJi2K0GuW7/aBQATkSUvpwjWLlq69ZINO?=
 =?us-ascii?Q?V2allA+0vuyYgAqMHZN96tQy05W8XUbtYnYaXSytKNGc0vL4D3Ug9u9xf6/L?=
 =?us-ascii?Q?ZdceyA/M2/W7z49CL7cM87HL1RTVAWQQAal6HQTiouBEWVEiNNbLcy88Ns9s?=
 =?us-ascii?Q?yN7pN+Zu/5d4wzLRCoDiof+/IhNYq6E/WcK/FSg0WJZDGSYtCNH5Tw/c87BK?=
 =?us-ascii?Q?bBEeaBasaqPPaR9bgGxoCtE6KCRwWaBiDUcVIirLOeNxUnJj1PwyWlQBZ7/C?=
 =?us-ascii?Q?z9y4c/E+rc9dNUSkGNPW9NfeLrt1Q4P/wrNX4X2V42sEUcQardxHCn0grslv?=
 =?us-ascii?Q?r+1BuzGXOH1ZBP/SbG0jd03roey2vNjY6AJhx9V/MJQxR/yPl3cML+UZ9Fo9?=
 =?us-ascii?Q?wQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7efb48-3582-4b39-8939-08db03b450ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 17:55:18.9395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ggz767E9KFCpVGfWNbevDlxf89nnBRNKlmZe/bEBa9lmDo+TfshzOMuQBQEYUUZ/HU4XUMpcq3+SmFMBoJAMs+U9Tn219jEM5U8K8ZJv3UY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1954
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Saturday, January 21, 2023 6:4=
6 PM
>=20
> sev-snp guest provides vtl(Virtual Trust Level) and
> get it from hyperv hvcall via HVCALL_GET_VP_REGISTERS.
> Set target vtl in the vmbus init message.

I'm still wondering why this is necessary in an SNP VM, vs.
just assuming VTL 0.

Also, I had several comments on v2 of this patch that don't appear
to have been taken into account.  I strongly think the code should
use the standard helper functions for checking hypercall results.
Some of my other code comments are more nit-picky and could
perhaps be ignored. :-)

>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC v2:
>        * Rename get_current_vtl() to get_vtl()
>        * Fix some coding style issues
> ---
>  arch/x86/hyperv/hv_init.c          | 37 ++++++++++++++++++++++++++++++
>  arch/x86/include/asm/hyperv-tlfs.h |  4 ++++
>  drivers/hv/connection.c            |  1 +
>  include/asm-generic/mshyperv.h     |  2 ++
>  include/linux/hyperv.h             |  4 ++--
>  5 files changed, 46 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 24154c1ee12b..9e9757049915 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -384,6 +384,40 @@ static void __init hv_get_partition_id(void)
>  	local_irq_restore(flags);
>  }
>=20
> +static u8 __init get_vtl(void)
> +{
> +	u64 control =3D HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
> +	struct hv_get_vp_registers_input *input =3D NULL;
> +	struct hv_get_vp_registers_output *output =3D NULL;
> +	u64 vtl =3D 0;
> +	int ret;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	input =3D *(struct hv_get_vp_registers_input **)this_cpu_ptr(hyperv_pcp=
u_input_arg);
> +	output =3D (struct hv_get_vp_registers_output *)input;
> +	if (!input || !output) {
> +		local_irq_restore(flags);
> +		goto done;
> +	}
> +
> +	memset(input, 0, sizeof(*input) + sizeof(input->element[0]));
> +	input->header.partitionid =3D HV_PARTITION_ID_SELF;
> +	input->header.vpindex =3D HV_VP_INDEX_SELF;
> +	input->header.inputvtl =3D 0;
> +	input->element[0].name0 =3D HV_X64_REGISTER_VSM_VP_STATUS;
> +
> +	ret =3D hv_do_hypercall(control, input, output);
> +	if (ret =3D=3D 0)
> +		vtl =3D output->as64.low & HV_X64_VTL_MASK;
> +	else
> +		pr_err("Hyper-V: failed to get VTL!");
> +	local_irq_restore(flags);
> +
> +done:
> +	return vtl;
> +}
> +
>  /*
>   * This function is to be invoked early in the boot sequence after the
>   * hypervisor has been detected.
> @@ -512,6 +546,9 @@ void __init hyperv_init(void)
>  	/* Query the VMs extended capability once, so that it can be cached. */
>  	hv_query_ext_cap(0);
>=20
> +	/* Find the VTL */
> +	ms_hyperv.vtl =3D get_vtl();
> +
>  	return;
>=20
>  clean_guest_os_id:
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index db2202d985bd..6dcbb21aac2b 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -36,6 +36,10 @@
>  #define HYPERV_CPUID_MIN			0x40000005
>  #define HYPERV_CPUID_MAX			0x4000ffff
>=20
> +/* Support for HVCALL_GET_VP_REGISTERS hvcall */

The above comment isn't really right, in that these definitions
aren't for the hypercall.  They are for the specific synthetic register.

> +#define	HV_X64_REGISTER_VSM_VP_STATUS	0x000D0003
> +#define HV_X64_VTL_MASK			GENMASK(3, 0)

Hyper-V synthetic registers have two different numbering schemes.
For registers that have synthetic MSR equivalents, there's a full list
starting with HV_X64_MSR_GUEST_OS_ID, which defines the MSR
address.  But these registers also have register numbers that are
not the same as the MSR address.  These register numbers
aren't defined anywhere in x86 Linux code because we don't access
them using the register number.   (The register numbers *are*
defined in ARM64 code since ARM64 doesn't have MSRs.)  But this
register is an exception on x86.  There's no MSR equivalent so we
must use a hypercall to fetch the value.

I'd suggest starting a separate list after the definition of
HV_X64_MSR_REFERENCE_TSC and make clear in a comment
about the list that this is a list of register numbers, not MSR addresses.

> +
>  /*
>   * Group D Features.  The bit assignments are custom to each architectur=
e.
>   * On x86/x64 these are HYPERV_CPUID_FEATURES.EDX bits.
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index f670cfd2e056..e4c39f4016ad 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -98,6 +98,7 @@ int vmbus_negotiate_version(struct vmbus_channel_msginf=
o
> *msginfo, u32 version)
>  	 */
>  	if (version >=3D VERSION_WIN10_V5) {
>  		msg->msg_sint =3D VMBUS_MESSAGE_SINT;
> +		msg->msg_vtl =3D ms_hyperv.vtl;
>  		vmbus_connection.msg_conn_id =3D VMBUS_MESSAGE_CONNECTION_ID_4;
>  	} else {
>  		msg->interrupt_page =3D virt_to_phys(vmbus_connection.int_page);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index f2c0856f1797..44e56777fea7 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -48,6 +48,7 @@ struct ms_hyperv_info {
>  		};
>  	};
>  	u64 shared_gpa_boundary;
> +	u8 vtl;
>  };
>  extern struct ms_hyperv_info ms_hyperv;
>=20
> @@ -57,6 +58,7 @@ extern void * __percpu *hyperv_pcpu_output_arg;
>  extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputadd=
r);
>  extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
>  extern bool hv_isolation_type_snp(void);
> +extern bool hv_isolation_type_en_snp(void);
>=20
>  /* Helper functions that provide a consistent pattern for checking Hyper=
-V hypercall
> status. */
>  static inline int hv_result(u64 status)
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 85f7c5a63aa6..65121b21b0af 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -665,8 +665,8 @@ struct vmbus_channel_initiate_contact {
>  		u64 interrupt_page;
>  		struct {
>  			u8	msg_sint;
> -			u8	padding1[3];
> -			u32	padding2;
> +			u8	msg_vtl;
> +			u8	reserved[6];
>  		};
>  	};
>  	u64 monitor_page1;
> --
> 2.25.1

