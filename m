Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2185472825A
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jun 2023 16:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbjFHOKA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jun 2023 10:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbjFHOJy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2023 10:09:54 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021017.outbound.protection.outlook.com [52.101.57.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9E92726;
        Thu,  8 Jun 2023 07:09:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRdhCKXaFVKMguP0or5FZWFPqsf4a3jxEad3z19IilRohfIZF2ft2+DsKWpXe1I0cRms8wRG1VyLFOyrJBNFosrHpYrfMXqQtKhZsvujk+NNeynK5+2xqGrKVmrxz2A8M+2gvjlm4vcCjVjJZv1398/tnklMOZwyjV/Hs59mkBhETe5I6kMZvR9ixdvPtiM+Wt3sndAwn0N3yKnl1qn7SMOcXI8rXJkOXd+hUEo2XnLfHPyyLv9YKGWsagD+mcdmKCTGQIf1GfCp6kI2qkwnwpdi5+TT/wQJSPlgFNjNhjeo3OVblyDG1Cx+hknKq/U+sDrJfSPnaBAh8dMLnBZqsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYdwWsLU3AUS88dXh97GXQRrrUdawRzJIuuX+m5c/nY=;
 b=a3Ufa11zsnebX4QGc9lj/6mg7yPl+697aO6u/UnkjajcAT/8mscZYxJekr8DdrffuoOHHdGL/nPVUuKoncmckKIa9D11MoMX6kJ5WQuv46tZqw+e8IJPeOZrF/V+wCCk0tTDykUlqRqAyyPujDfoKL7KYkKe9klpfrzYUzRUjcR6oS74enpTxSWSKkgfaEljbUCfbkLovfanzSH2OFd11vb0KiQ3mROr2/G1/eXOCyLRPLJuWvastI+g9Is78OnzsWYkezjzVHdTUjiwKEogUWVi9KU3Ek/9wNn7h89QK7ANnQCu8FXq9GGroYxAoBoSAxIuAsFr7OzbPo3RCHwxWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYdwWsLU3AUS88dXh97GXQRrrUdawRzJIuuX+m5c/nY=;
 b=F24vHGTEcGMKkk9Qxnj0Mwfh3hl/voo0RShvLpeKzzON7tLESdAOZZkMRdd2IOfcVO4dklJcZECEBGUEDMY1T0NPP5ucVYFSLe/i8jJGrfgCKLgkq2dNDm0wjKzauig119t+Fq5Sak2WMDjgPRHoZquIUNFihY2a/fUhlIXaLEU=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SJ0PR21MB1323.namprd21.prod.outlook.com (2603:10b6:a03:3e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.14; Thu, 8 Jun
 2023 14:09:48 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b%3]) with mapi id 15.20.6500.004; Thu, 8 Jun 2023
 14:09:48 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH 7/9] x86/hyperv: Initialize cpu and memory for SEV-SNP
 enlightened guest
Thread-Topic: [PATCH 7/9] x86/hyperv: Initialize cpu and memory for SEV-SNP
 enlightened guest
Thread-Index: AQHZlJwRTLggXtz6DUO8yFY8YfLVFK+A+8Mg
Date:   Thu, 8 Jun 2023 14:09:48 +0000
Message-ID: <BYAPR21MB16882DC67EAF87B518D5D72ED750A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-8-ltykernel@gmail.com>
In-Reply-To: <20230601151624.1757616-8-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=48a8e9e5-c10f-4956-8ad0-9aeb5fb3f1a3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-08T14:06:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SJ0PR21MB1323:EE_
x-ms-office365-filtering-correlation-id: 3bce8d31-ff3d-4ba5-f7e1-08db682a04cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eal/wAFJCD1HbMnFaK2I2/1VYCSdb3R/SAA5LTyo5X+y9plRdURJzyu8ABx5edlokJO9I5hD2Pwz5TfIxOK52sm25CyQRuMak4gfvJX74x0zNTwSShGA7L+DvXvpcyshiGOe6h2HsrELCkQlLmG3c5MGR/p+izfbd+VSxBC2oPrs7dxko9jZEcuL3a2zJ6+N9ZjnOrFJwHvqmg6fPbRQA2aN3ayHp0qSLzePZfkl/W4aAHjM3oYeyVAB663ddHmFRlLpU6VOA4sHHdEVXso6TXF4VbEFwtPLsqK64M0bhOGGvyvhuHZ0KccjlnXBM6Br/LxJ1K8Y0rejXvGF6739FMMfrRi2Osj+l43UpKYhgQQGDKFZtYJshMkmi5uC2JWi5piogr3vMr3OqRPwSoGDiNPCJ1QHgAMkuJM+rJ4aXT8aWVLRiIO1KD+gQRmMvr9/arWDmeSsIRf9cPEHYDj3dfU/ZImlO82/CcojARc3+knXLDOFcsjW1+1+1FfY3bjsSfZBYCQh3BeYB2TWBri7kx/3zKouHp6bKJjNkxDiJi9A6E3d915lL02PoNlsGiR8iAxZKoQMx9uUn0xwC/LBE33K1TTVR7GIJcOmuOemseiJWkJahth8uA70x3szoRy7TJ/8iwuyQW4mbotc0dTjDlbwim9p3IM77l1JBUppaO0q3ex8mG4nA8E76jwFKXlb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199021)(55016003)(110136005)(54906003)(921005)(122000001)(82950400001)(82960400001)(478600001)(10290500003)(8936002)(8676002)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(316002)(41300700001)(38100700002)(186003)(83380400001)(7696005)(71200400001)(9686003)(6506007)(26005)(8990500004)(33656002)(86362001)(5660300002)(52536014)(7416002)(38070700005)(4744005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EBd5HyJSe3NAlmqleWeFe9j88yuGk4NcC0e1B5C6l67FIhBelqlW3946zTJ8?=
 =?us-ascii?Q?dd+LqIdmyaOto37/14UekOswBKR5zwr9BElb47LwrlYAYqIA8BLzdPheCj85?=
 =?us-ascii?Q?08BDMb903dW/61VUa12KHD4W4sxhINWM6e+4tc0FYF6xT1vACvo16t9OWqoG?=
 =?us-ascii?Q?qBIrwBU5p2wogPjvqJ5T0BDn0xhmIVg/ZcRnlfJ0M/QoZbCRBP2eKJgMpQmP?=
 =?us-ascii?Q?A7pK9C+PP2Iq4f/NL/zCGmzG1SPZ8NnKR9nzhQDVdzcWodLAdziDyRPPgo6N?=
 =?us-ascii?Q?mXHZRXVPnPcm0/wORMd6kBXyvz/x1YDQIYLsVNkrg1/2Sro/Yq76UcTuWfLC?=
 =?us-ascii?Q?ACFkMJEM6xzMFKFPqHqxgHzYuQcIA6l05nPMcPDq/j+RZXXvBb7CDhXe1p8O?=
 =?us-ascii?Q?sGF6i6GKo4z+Dmnwsk26/b/Cnme6sSAZug+WLsLBVOomoBwDp2D/28s3gWSy?=
 =?us-ascii?Q?EyV0xjW5ODV0e9eOI+fnuHQhehPkj4eNTYBRQrrtbSHGR/p9S4RsredEtFTL?=
 =?us-ascii?Q?5MbqgI42RXtzSirANyDa5g05MUnUDQOWHrdcCqjgRLwwXJIbhEzEYpCaC/go?=
 =?us-ascii?Q?YIlpNCqorinPXx/MSxLaz5W8OWheFPcXVpyT9dPndH4LLbPDxpyfbhIJ236O?=
 =?us-ascii?Q?0MfdeZZt9cwv/c8j6u+OVfQ5gmRNsY2jPsku1hizjrvahmFvog4vboyRGZhU?=
 =?us-ascii?Q?mNgsOw91YtG/fdPDuyMapJ6ssYjJ7B6VjjNqAqK2+hRSv1oMBO10P9xvpUIu?=
 =?us-ascii?Q?AHyhYA6UwuF0wajUaEBxOY6vzTKLUns7dJT/6VSz/Dh5pKfBkWAN1VWtcBW1?=
 =?us-ascii?Q?2xktvvqkfLxcSizJTUcV7pjeOw+kfhF+48YFybTfpLBYezY7iXF7blAMZz/a?=
 =?us-ascii?Q?ysXb89C3lsYZYf7J984RjBrKwimahjMvrNCn8janJlVIGDJcLb+zkTVYb5DR?=
 =?us-ascii?Q?ZNeNrHcBFCBuV4uwGabdwurMEkpMlKgnn6rujeywDFIqQPf3k1BUrkFO7oti?=
 =?us-ascii?Q?mAIrkALNhCnw1+BVh2BDDQqb4XlgyMcCCrfTlgXAnsluQyeiXVUCPV4OMNsV?=
 =?us-ascii?Q?TqtY6oy2zBNVvIUd3MHuODs58NR/LOFMJMV6DaZ/OPBgRran1xdM5Nhib82P?=
 =?us-ascii?Q?6eymB4YNQmjcOnJPGhlFhBJsFPpgjXuIf0+M1gn3IQh6EuG4WErLd4XpfizU?=
 =?us-ascii?Q?wIUiWEZ4Nr54FHzgQzaXMgIJiqlaNyOqS46SDdE2vPh0OTJMlFj9SX6LCpf4?=
 =?us-ascii?Q?yL8pUpntymLzmQ9BQEtZSGC3zqWwTOPTHjBA1nlUACekIaGG+tGQNHLpUD4l?=
 =?us-ascii?Q?0IL4rvg651ZI6PgH38UHJVI7RJimxIYdBhy7Ylu3DKzalVSS3vfog3WvKEbv?=
 =?us-ascii?Q?2M8odfJS7X3eUo+GMJ0iRJw9ZrSzvrm9vLHAyTqs3eGSQUTkakHoHadXkfJI?=
 =?us-ascii?Q?3cW9Jq62CyoVI6BvoGq5DO4b931n4OYhCvKN0zzDCSClA+E467KEtIxf5YJ+?=
 =?us-ascii?Q?lJLVdZoCgeJQ9SdmC9mHXgg1WHjnMHX2XBA0n6jy4eTdY9LzAy21MMLi9fU9?=
 =?us-ascii?Q?5ocRsI0SXRyw7fcLxWf3VE622u286E3/bTZJ54weItT4ZWU94pT5MRdNOkYf?=
 =?us-ascii?Q?9w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bce8d31-ff3d-4ba5-f7e1-08db682a04cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 14:09:48.1344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SIaYWFRdSCYkp4evlxsfUBcMzo1cbLn8V1/Hq8BdLUoSn87RJoBTaGk2LC8zYbi0OMy01WjDxQswls7ZO5jysmCzakZjSrpgHJjqdSJikqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1323
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Thursday, June 1, 2023 8:16 AM
>=20

[snip]

>=20
> +static __init void hv_snp_get_smp_config(unsigned int early)
> +{
> +	/*
> +	 * The "early" is only to be true when there is AMD
> +	 * numa support. Hyper-V AMD SEV-SNP guest may not
> +	 * have numa support. To make sure smp config is
> +	 * always initialized, do that when early is false.
> +	 */

I didn't really understand this comment.  After doing a little research, le=
t
me suggest this wording:

	/*
	 * The "early" parameter can be true only if old-style AMD
	 * Opteron NUMA detection is enabled, which should never be
	 * the case for an SEV-SNP guest.  See CONFIG_AMD_NUMA.
	 * For safety, just do nothing if "early" is true.
	 */

Let me know if this new wording makes sense based on your understanding.

Michael

> +	if (early)
> +		return;
> +
