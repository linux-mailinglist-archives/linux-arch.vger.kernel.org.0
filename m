Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C147783C3
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 00:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjHJWqm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Aug 2023 18:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjHJWqm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Aug 2023 18:46:42 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020019.outbound.protection.outlook.com [52.101.61.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEB7272E;
        Thu, 10 Aug 2023 15:46:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vz6HG0ffJQiO9PjpBP1Su6fQ1M73gwUWM1p9bZQnUZyaYilw6Q0DFc3pKEzVInK6YIn1rVfVwBmgsE+zwycMkXabBp6FLxQ/4kv0qRmoWrx7ZCjvGJ74QxkqX3fIcGvRXFmGNSJG0akG8wyaAqlJ4sPb6FVFEdhRGRfgHfv1DXrHcvSTkTuJP83+1lKSeJ8AaNljz+nsvW/adEBnLiyyyQXwsQJCVMvqhAw3XomDybPFNebJt6MCU97IvP7oQXgfrg3lAdHwHgJTh/cKSDFy7Gjl9j+pD8My8bRdOJ9fPQv9LZalFszQJG0unKl7oN7YVoOkCcqrYkcXDWju1zVIAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oh/L2NrBIV0YOj3axsZh4ppBCfROl9ee3XJUraLPgzM=;
 b=YZaVUZLGeU16KwPzSRSjhaQENfy0QGDFDiBkgbGjUvPWWOlVOMcHVaeul9QR8sOh2lB8a/aTIIHWwkuuRVBco6gTFwIRzbRb9JZxjaMOxajnrjGm7zRpMfvZXuJ3bPcrK2EHasFYWp581JiC0GJD9MgAZ6IUn0yQQVBcwGZDffnFd1Ge2LHFIa5/NhVLfz1f8EPo7BXSu518ffFPmYKHs/+ZVRNMH8dB1ZiAm9YgrNpdbGtDVCMYZ7YLHHC7VvWtn2hcowJp4Hkatr4y5y//kggLV1w/ivrrcRuiqA7JuxwjHml8zEK84kOHAJBJqmUbIHki8e4b5iYWSPFAev6pAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oh/L2NrBIV0YOj3axsZh4ppBCfROl9ee3XJUraLPgzM=;
 b=HGVsnAGKWe+ZaM+MBNuAKviUKC4KRa58DqXPh28bOUbTnUiDx9b4kJKdpwlUwwhReFhgruXBBfc5ovRdnWSyJ3y/Av023afDSKgd/MnOHeRSBGeePOVFLsm+XL/VrNcqe9JJQTnEswUKoRb1wVrVQFlEMjtmNKS+itumZ3yTNzc=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MN0PR21MB3312.namprd21.prod.outlook.com (2603:10b6:208:37d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.7; Thu, 10 Aug
 2023 22:46:36 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870%5]) with mapi id 15.20.6699.004; Thu, 10 Aug 2023
 22:46:35 +0000
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
Subject: RE: [PATCH V5 1/8] x86/hyperv: Add sev-snp enlightened guest static
 key
Thread-Topic: [PATCH V5 1/8] x86/hyperv: Add sev-snp enlightened guest static
 key
Thread-Index: AQHZy6RXtrZGCV9msEegI44i3G4i6q/kIZNQ
Date:   Thu, 10 Aug 2023 22:46:35 +0000
Message-ID: <SA1PR21MB1335B508B3749E571C29DA8CBF13A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230810160412.820246-1-ltykernel@gmail.com>
 <20230810160412.820246-2-ltykernel@gmail.com>
In-Reply-To: <20230810160412.820246-2-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4d14a388-101d-4588-a261-f28e7828bba9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-10T22:45:58Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MN0PR21MB3312:EE_
x-ms-office365-filtering-correlation-id: 3de91794-e349-48fd-0180-08db99f3a6dd
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zmKN7N/ssyfsbBJTxigT73xGuH/xAzNfyEjkT2hm4Zuuy6V/d/65YQYVoH8cfF48ucO7OUHPBW1vbWeGrATU/ibyZkyKvOfpJLsj5+hgchSjPKiqVdKDuTBMvyou9kNJH/1XeEQRl53kMjGr9Axi/3lxchVq8lyCV5DEI2P7aactZr96Gdz8C7/qRvcbVWJvO33+mZ0Mot2zxCiwMn3vIFh94k0ZjEROEINEn57IEfa986okcBEHSx2TZwCxTDHZZsPxmy/j6g1mhT3+QB/eAyyu5eU2RMZx1M2O9ScOIteFiVxwIjN3sjq6UJNCZugn0dWXl9YLi/wYW3Jc3q2xBQy2jAXPtXSLk+wDPnCL52UhW6UtDYFGtghsCCRoyLkFB5X32fz+1gMQI068p+3n3eMAaC4z3KvY7/I8dOgeIZw6vA8xRhoz/igdUNDKoLXP6oYvHyJpgMvcQza7dE0NqJFlq03ESxUMjYCu0qorUpBlJuoExHQycAHRW9vabf1UqwO0mYsk1J5ue6SIFUHaAtlAIwNmaQz158bU9it0Cs5y6t7pFQFTKdeicrLF5JXNELplzWzA/e70RZbiO2mnz3l+8hHlhWpRTRu6w6CVEHlbgNvJ0Tl73jFO2vrfdsHpXRviUEXPcvNsU79YDAyNXbmextrgs3P8X6K621mC9yNQeSnlF3kQWT8+WPzx1nsKxtO3E5yCCwCATuvoh63lKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(376002)(346002)(1800799006)(186006)(451199021)(478600001)(558084003)(33656002)(10290500003)(7416002)(9686003)(6506007)(86362001)(7696005)(2906002)(55016003)(71200400001)(8990500004)(26005)(107886003)(52536014)(38100700002)(41300700001)(38070700005)(64756008)(82960400001)(316002)(921005)(82950400001)(122000001)(76116006)(12101799016)(6636002)(4326008)(66446008)(66946007)(66556008)(66476007)(8936002)(54906003)(8676002)(110136005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e6UKvx1PwHLo0EwgSzafxU58p63Q2UYjy6pKOEPoOFw9IU1T9ve08G0Wv48e?=
 =?us-ascii?Q?beY1i42maBixqQStc4BFZgrtIh7N3bTX1fvUPcqXgA0VM9807bZWRNPxN7rM?=
 =?us-ascii?Q?x2bTV2mC7CTdj1u+u720hNKOOObAjEupLoB4DaThiOAZ4WoM/QcejgWnvMDn?=
 =?us-ascii?Q?XEZXz4zChw9ECiqsmDe1PTEgAaQQOHQtzHMWS8ajuX9z0TWBgWN7zkUZupq+?=
 =?us-ascii?Q?E0NBd6RUCTYMf1KRMV8yrsoazgH+o9taMW8rtkidn8HF/FGCJxJOqFUvFIm/?=
 =?us-ascii?Q?NGgiRxTlQ28N1xYEuohKTl/8IOyAwqy3CH3hAV41NLSTofS9b8koNIwu8I+v?=
 =?us-ascii?Q?3dyTErHPQR3NmqUO2r4ukhCdgtN0ll9A+ZlT0Q5+3iHI3gJqqq718ZZrzy6W?=
 =?us-ascii?Q?8DZ7mqH6ok/LLnotTgWrmBya/j+VAoLbyLoERNhREGma8HVwmyswbPi1wekB?=
 =?us-ascii?Q?xl+SNk+FF2KT6g77uHAKMnvj8XHHeQLAimzuxX8qyjZeXzpRVQ4T/evwrkES?=
 =?us-ascii?Q?dpG8/oZysvCnCOZLqrww4/nQRnUGx2Dcb9xH7idl565EfrOTf1bzbRKLywF7?=
 =?us-ascii?Q?6YQH9R83oaSiJdujijFl2xH7erO+tVjEWHszYOxkCC7XB0ROVtYrCsjebN3B?=
 =?us-ascii?Q?pBMYBvH++vLl2Xin2oIA4HaN4g//x0kfsQV9H/ZLo0gMRO2xFArEua3idrj4?=
 =?us-ascii?Q?p9BJpAhl9tvfe4/2BpARbn9iFFKAbQcBS57AFpKnVEwCRxFaQ7y6CrZOlmkb?=
 =?us-ascii?Q?Ywsj7NIadXT+lEloiwjNEImnIvQeDzrVkt9EbT8aGyVa2gQRvxdpIQoazAmk?=
 =?us-ascii?Q?gB225iI18hA8IvbTUAtaxWZ8gcnqt7sV5z4ZIWLTR/+E6rrT8yYiEuOBCvR2?=
 =?us-ascii?Q?RsbbsjsIJIyFyqb8tiHpfBmscVqlavJPFZZ11+WJnjNVEKV8ZJq11ZLuZG6/?=
 =?us-ascii?Q?rIUAzQf+kRRdI04mmoF74Is6hhUiYF0LfWTRsEJQzlREuNhmw+Sdi1afo58B?=
 =?us-ascii?Q?Ytv2qReVRKLeD38slcClxMM9rqW+h6dWG/r0znfSVT0uS349UD91BOJPOCjP?=
 =?us-ascii?Q?R0va6vpCNs8TsJJppvFB0j0pmvjInVruE2Zp/xfADP+zSCKprXttSOrkCnXK?=
 =?us-ascii?Q?UMr9L4WWSO+vINJQl4N66OfDk9oU96HhkRUaTHSdVlrY77b9VKKmc8Qt9o0b?=
 =?us-ascii?Q?MNeKSpogooB/Zx/2zWiMVA8kiYgPXl9qDZeghZX2xcRI7rilXsrsw6mgKeUL?=
 =?us-ascii?Q?yH5PmgdyWKpNEnwtVP/8+AERdkJiyaxnWhGEgz+/IJGpkBZ0QEaRJXZmO9Sp?=
 =?us-ascii?Q?CtLvl3UaYmlUguONwjb1tFjDdKrJLXVleNzoQ/nq0wL1/KWPeeKHoIOUCchQ?=
 =?us-ascii?Q?joUJVuwhKfMpxMPIC+RfiGEkINAoQJhhK60QsRTTWV/rfQOEggm+shviPCS8?=
 =?us-ascii?Q?Gwo3BJZgZmlWatxluJSpTmCsxZBOOLSPBJmWDuQf1AGwX4L+le70O2xYalCo?=
 =?us-ascii?Q?kEKhI66PB7K4uFt3Sk/yqxvBOqJ1ae/3xhAVWq8fp8q6nYmxoQAR24ajkMmx?=
 =?us-ascii?Q?Ywcrbr0seFFt/EmQoePFnTClDiUO5d9ZSU6Rn1eh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de91794-e349-48fd-0180-08db99f3a6dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 22:46:35.8631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +oIe0JZL5QHxV1glKsKMlRIYpeMeEryZFJ/dqPKAYhEViIvgCyg5PpN0ybr6aW13e6KhptmhQQnnT661Di5Xxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3312
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Thursday, August 10, 2023 9:04 AM
> [...]
> Introduce static key isolation_type_en_snp for enlightened
> sev-snp guest check.
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>

Reviewed-by: Dexuan Cui <decui@microsoft.com>
