Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED05A77EC15
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 23:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240096AbjHPVnP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 17:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346675AbjHPVnF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 17:43:05 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2107.outbound.protection.outlook.com [40.107.220.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735CA2D51;
        Wed, 16 Aug 2023 14:42:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tld7+Kprkv5mGU8/5CI0lvD9QU7B5iJEeflM/SyOj9IaBdVl7Bi/wjfOUENmyytgDXac8Aiwp0RHK85zhUEhD6te8n30kKmROQHyBmbdqj0VTWtu4P8B3ioK4W+9OgERc23VJs7b2g4sPC47O4gUjxNXed6ZfRpOQY3/8PFPbFUgZmMsUEt7IkP10udKyImCt4m7v+mekTz9RsUHzJHflqC8BNzj1WFD49IQfKco2Qus8T5YFXQxvAkeeKTPCWJ2u/CQHEkBXRE+TJ7pFsBzyLUaLWQOcUKlODwV3qXiWtOKXkhNu3x1OIwhW/yexskFSFIvO+Nh68n8YOtyR6L+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=188KSm1m/U/vx8ewbaTDBxLquEgbmnJOxn/tnqtxKtQ=;
 b=NG7+KzStbGkYU/rAJMKDHYiqo08fqkSwz7vUd/vGMjrrlPY0NKAW9P7+TEpUvglGwJZbA/kSNDZlEK/73Mi9i9TwE60hYKyyAtOfA4hlfKNT0aeQpKKkss1y/C0XxV60Z2spOJOL+Fi8WzcqNCBUfmH+XbtvL07DTFIyoLtIUf7qagoViwrIGAwyjuc9DExDwu9GAHZSRanCrKQl7XIsNeZryeiSKq3BTyPZBOqasZDtKPJtPvrBVqE0XIAwZkqK2ygYD90q0zg1pXQAUgcFKz2vOgMod2U+BxUtv8wC5KZlkPg1wdmblHWseJYNBtVyDVB7XIH6hth9cqulMZeLvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=188KSm1m/U/vx8ewbaTDBxLquEgbmnJOxn/tnqtxKtQ=;
 b=HL7wYRjrQV1tMXHhCbP8RhO/xPovEBCQFferH5a7UUr32S9KhhlqdRoi/pieQciiC5Cnw3sS1dTBlnKf9gVLDd50gwgo4egmoPAAXlh7aJTDx+mm3NcUQ12m+LIiHVeXlF7+CQwCQ97H/0oVBR4zpQR6AvPZN0LQXwxL+wtiaU8=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by BL1PR21MB3307.namprd21.prod.outlook.com (2603:10b6:208:39c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.3; Wed, 16 Aug
 2023 21:42:52 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%4]) with mapi id 15.20.6723.002; Wed, 16 Aug 2023
 21:42:52 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: RE: [PATCH v6 7/8] x86/hyperv: Add smp support for SEV-SNP guest
Thread-Topic: [PATCH v6 7/8] x86/hyperv: Add smp support for SEV-SNP guest
Thread-Index: AQHZ0FqX2flvsZmbjEGkAW9ysR5KtK/tcwIw
Date:   Wed, 16 Aug 2023 21:42:52 +0000
Message-ID: <SA1PR21MB1335F165EF353A24E4CCF6F0BF15A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230816155850.1216996-1-ltykernel@gmail.com>
 <20230816155850.1216996-8-ltykernel@gmail.com>
In-Reply-To: <20230816155850.1216996-8-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b6a21c53-9bd2-49f2-8a98-15b655f09bf5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-16T21:37:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|BL1PR21MB3307:EE_
x-ms-office365-filtering-correlation-id: 4654d696-5911-4350-fc44-08db9ea1be87
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wk34XNBgSV5m7s6BF+hYxXd45cbCEg6ooXiYvzsk3O4QUo9Bd0/43BwvqSQ7soFZsqIX0tXZo0/UyVZnRvDJz2kpim9FcWh0vf9QpFi1M9rpWjCkJRhuD36ayw9cy/xnq0x3jO6iBAnomDOis1WQEUywiKCaOV+jhefg/TUW5ecFeGJoXX+vM1m/RZ0BSmEfUCRGkImGCPR6fSjaT5B4Ty7M6VJJ7Bb4GAwThuBzrpVRfFjajAzbOTxJDmhPsJId6VnmldJKd9EmTfmMWKS40oeXjKIkUyv7JyztwA5YwT7lfuFcj/hgvlrt9A6ZGI/NyLuxV7ogCa4mQqpE1zGagGZ/3oaq4PO7inCVk0rdSUBVWrvvSO4Ucmi0y5nrmHgDrV3O5vcYvYFXF7b0+yieSgF0Aja0mN+uhGpODKxV4LHVmier6yOxXn9TIDBEDNKVa8Fexi1SWW4PVOWJ2s5zUi6JBlF/CVyjWC9CRMkfLVRVrGOpv+0RuWVlTMcTd8Q40DgcnqwuLdLtXnrPRqAS3k9vhbC1UGSBTMKZ8w46qpfmtUX+MhOc0SlVsi2dGpF4Fw9s5YKZRerrvgrZxHXa/FD3kg5j9gMrdmyc9XSZgoL5eorltJHX+tt5idhoZkFzSL0l17wi+1B1F0qaLgA32rKGvh6DAgL0hPiOFOQpyaj69Te/YtQsCDJMiYCcJaXQpCPffA0o3+mNZX4nHRUtgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199024)(186009)(1800799009)(9686003)(8676002)(38100700002)(5660300002)(122000001)(52536014)(82950400001)(921005)(316002)(38070700005)(66946007)(66446008)(66556008)(41300700001)(7416002)(82960400001)(8936002)(76116006)(64756008)(4326008)(55016003)(6636002)(66476007)(33656002)(86362001)(8990500004)(2906002)(54906003)(71200400001)(6506007)(10290500003)(12101799020)(110136005)(7696005)(478600001)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B4rOfIMomSBJs71AAjKwLzkuceCeXhmNvsY0tfbWW9+KK1x3E5eh5JK7L2tv?=
 =?us-ascii?Q?KI4ws3odNYTvHgoI+1vUNfkrUpUeC4q9WJ4WvsKq7B/2uT1Iy08RmrcQx3Sj?=
 =?us-ascii?Q?6Qx7N2H/GGBLHqQ41IqBx195Wo+oaJkHPnPBvOJa697y6vGT1Vol/cB1QLOu?=
 =?us-ascii?Q?pGzWJBJyqHslahsUH4jVFKlLlJn70ydMDZrDCEpWhnscAxnpTpbzjseGx+yG?=
 =?us-ascii?Q?KmTv1IxFD5vLi/wm4lalLsTKYWFjPdw9pCoXE/urQX8bCYThcGhY13IF7kvE?=
 =?us-ascii?Q?0j3sohUWBjUdJWqeFGUPAQwGplO2cbHe94BIOE4/PwkkIo1UYHEn6DVxwCuX?=
 =?us-ascii?Q?OIc0OP9ScR5gZePfBfyol2Dx5ITXsGrCpxCNkd/552vt7PwQUP7fzIWcemSo?=
 =?us-ascii?Q?7/wbYY/P3ZpPBHpKUdvQ5SZRsTIFLbe1Xe1faLLXl/FyJg0SHFPIiNG/MEkG?=
 =?us-ascii?Q?U5HuurB2rxz0hH0ofI45CRoITDvsy4hx/29SdN+yPXH97a1/zTscnxvH50yz?=
 =?us-ascii?Q?o3YZqS+9rQ4heqYxjM3bNcCJYSBwp/sK7yIGWSiwjlKZ9rlLKiyjaVf4E79L?=
 =?us-ascii?Q?vyxRZ81zrsIMLkr6tZ2dx+Vlt3Y0UD6bHruRFOS4nRYhlTYDbF9Bp7yqL9re?=
 =?us-ascii?Q?eXxyuatBL2MlZq1xSEOC6f0Q9mQNTqcMmN1ZQgHkNgkNPenZPFiCrO38LAJN?=
 =?us-ascii?Q?hVRuQQZ8UE8FMfUxLx2cYvBeEPkeDEMHj4v2oXf28YdiZYzYT5+zZNYGDl1D?=
 =?us-ascii?Q?0AsrI1TNgg0/tRL8ucAURB91/TuLs66D6cj/MAwYhsy3Kg/qYf429sEDte7k?=
 =?us-ascii?Q?YBj5OgQUZjyYk6EB3Pi+KV0MduauQE3ku3P+qW4utMRffVPyRKI61IumQTw6?=
 =?us-ascii?Q?/8V3VcGV8e14u1n0c1JfVKER45cwtIFlVGst5gQG2HvyxmOqsEjqi4h9ztdp?=
 =?us-ascii?Q?e1GTYoKEwc2ZxiZXeG9Ma5P+xal09WupgqEOxTqytKc3Y4Z7M7hDlkO+qc2l?=
 =?us-ascii?Q?muY6Co5LGn9E32KVkLPW/CxiXbMfobRP1SUsds2orMLMGlaGQtYsZC0tgT3z?=
 =?us-ascii?Q?uiOZMczi+twqwnPgWZChHXL9C/b2Eh434pYN5/ZxPz2p3QabHfLpOh7UBN8D?=
 =?us-ascii?Q?KQ5T9bC3tKagNZuOy/l/TLR9SZtnF3modyoVYrWEPIWXnUY5lmAKjSeNIzod?=
 =?us-ascii?Q?Eau9abA+sfgw9EdtZrYBiludk+KQ7ILV/syDdt1N5fLINYndiBvMwRudLMlS?=
 =?us-ascii?Q?q76xmOBuSmaxnNJYOv//doF2Sv88suwQjZJFW6NoRZLANRjanzmGdRrk+oHD?=
 =?us-ascii?Q?HLPFiXZCH0P9zepbkSHLtmFCgW6ZBJ1R7BUZUCNiao5FQg+BvYfo7w7gFVlZ?=
 =?us-ascii?Q?5P9KYPAXnfjN/Rxyjm6FMqxPgXrLHkiQ59p/xbH/YsQgmniSdog7A4nKYaiy?=
 =?us-ascii?Q?FhLoudxB8beJ9V2okR0cVqKmkM1iQmyWOlWr6g/dkm9peIQMmznIiB5xvBCx?=
 =?us-ascii?Q?5f0/T8Euii1KXBI8x34GFe/UzucGsUllkUsuP+SjL6JhVdQSrtEXH4kUIIqm?=
 =?us-ascii?Q?aJuL2i67ApuJ+F0FPnkFxXII+MVSzU0vO4SP+r6reF6c+tnpmkkcWM+E6KXF?=
 =?us-ascii?Q?ey0ZW08vmY8VdasbRkQUVNs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4654d696-5911-4350-fc44-08db9ea1be87
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 21:42:52.6480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wecH1QCJoUfQckmLu52x3F8ZIHYPAPqMCZkn/Pu51Oz217gddUR1J6qXSOg/N1dAVpo3V4DhBiJczVpzwGLywA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3307
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Wednesday, August 16, 2023 8:59 AM
> [...]
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -295,6 +295,16 @@ static void __init hv_smp_prepare_cpus(unsigned
> int max_cpus)
>=20
>  	native_smp_prepare_cpus(max_cpus);
>  [...]
> +	if (hv_isolation_type_en_snp())
> +		apic->wakeup_secondary_cpu_64 =3D hv_snp_boot_ap;
> +
> +	if (!hv_root_partition)
> +		return;

Can the above be changed to:

	if (hv_isolation_type_en_snp()) {
		apic->wakeup_secondary_cpu_64 =3D hv_snp_boot_ap;
		return;
	}

(please also see the below)

> +
>  #ifdef CONFIG_X86_64
>  	for_each_present_cpu(i) {
>  		if (i =3D=3D 0)
> @@ -502,8 +512,7 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  # ifdef CONFIG_SMP
>  	smp_ops.smp_prepare_boot_cpu =3D hv_smp_prepare_boot_cpu;
> -	if (hv_root_partition)
> -		smp_ops.smp_prepare_cpus =3D hv_smp_prepare_cpus;
> +	smp_ops.smp_prepare_cpus =3D hv_smp_prepare_cpus;

IMO it's better if we don't unconditionally change smp_ops.smp_prepare_cpus=
.

How about this:
	if (hv_root_partition || hv_isolation_type_en_snp())
		smp_ops.smp_prepare_cpus =3D hv_smp_prepare_cpus;
