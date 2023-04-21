Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3076EA27E
	for <lists+linux-arch@lfdr.de>; Fri, 21 Apr 2023 05:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjDUDyN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Apr 2023 23:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDUDyK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Apr 2023 23:54:10 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020026.outbound.protection.outlook.com [52.101.61.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21982271C;
        Thu, 20 Apr 2023 20:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GC17p1O2as+vQtc8r4w2kBU7Q9rJdir1rpRL/rbImnbbQfYbgg4X0URndvcTNuBwlWJZZH5heBhNA5lyusgjZ0Ar8PL0xDYhsJzl02JrOsqF9iKQiQyhPpKnqmE3uErYqGmGM2wK5AWPS8mNodXIg8R7azfRtxfuUmAJH5b7AUyh033olMG8/vh0heXJv0MOPysxDZ8HmlHjl4WWY3Tey5FI36HK/2Rrzrfl6rbBRzNEBtarxYo8HzhWyzfybh3cCa9aZ+1/FbjyAWeh+z49VusubCH5dVZbuWpIQwULSTLT4xT5Hdk5a9tfEK1kp8xzA4PP9F8W2DhDN8zhqsilrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNwFRtf7YODf9RbVOxWLG0WU7xWujnUw3L0Xgt+DwLw=;
 b=TXHH6cM1ZHELaqXdHjA1GgMyqgNrsGcSMD9tDgLjc6j/hdVVRjsqdPu7QDnd71Qumnxp0Kgb6NltA2BTzEL9IFSwCfUH5wi7ppCqHjPGHY1+ocvRlwyOvEI2r9HMeJdFoaEJnoAdCnwq8Dw4c+uKCfIkr++ylkoWOKvY9JKOt+0TYQA6MLVFiGat9w9f251KaZXxGByByqTtC1G/xWR1Er58kUDwbJiosoMTzdn/IpswVsYGJImw7+Ffn4uK1VgCZPnV3gUwolfky16IxuhlZMcN/9I332VjLZ/N6qF4hS7cazagwPwVgmZeRG6mYpp9Y7T9hxkS2mU78LQjzVUGSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNwFRtf7YODf9RbVOxWLG0WU7xWujnUw3L0Xgt+DwLw=;
 b=SbpIarU7pUKv8129rqIvh0tux35ek8Y8ngHeDK/+jQzvPDMzUzLm5exc5FqvqyERCzH1sKOnuISPjPh3nwky0utkLdHBjmjSB/8Uqsd/Ptl0mq/Q2nEv3SpgPiXaeg/GUlEeyl/hbXuViIiZiI43JfvXtQDL+PL0NL/MATQRNT8=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by BL1PR21MB3331.namprd21.prod.outlook.com (2603:10b6:208:39c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.9; Fri, 21 Apr
 2023 03:54:06 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::eeec:fa96:3e20:d13]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::eeec:fa96:3e20:d13%6]) with mapi id 15.20.6340.009; Fri, 21 Apr 2023
 03:54:06 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
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
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: RE: [PATCH v4 6/6] x86/hyperv: Fix serial console interrupts for TDX
 guests
Thread-Topic: [PATCH v4 6/6] x86/hyperv: Fix serial console interrupts for TDX
 guests
Thread-Index: AQHZalujP8O9vIzAEkmR/lI5q4nag68mWtKAgA7Z2SA=
Date:   Fri, 21 Apr 2023 03:54:05 +0000
Message-ID: <SA1PR21MB13353FEE46EEC4FE816A00EBBF609@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230408204759.14902-1-decui@microsoft.com>
 <20230408204759.14902-7-decui@microsoft.com>
 <BYAPR21MB1688798EA7DD5ED309BAE0F6D79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1688798EA7DD5ED309BAE0F6D79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=213958c4-6372-417c-8b38-15aee46f618c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-11T17:05:08Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|BL1PR21MB3331:EE_
x-ms-office365-filtering-correlation-id: 86cc09eb-403e-43da-356c-08db421c0dab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NTwN7KL333yh3m5kp56q6wR6xEYzCoeXQk4yUrPuNlPFWWkDmAXnisUkR9HRVK77pJO96dLzoplRaGVbc1XkNbqtHJqZOi0qwbkximzOXSw96/wlkEsWxMh8VCo6HzkO83hILxgXLTpa+AImmeKnPSPeXbmifIHlBXdjgqQrdhlpZpSwoaGN9osLqbhU7+256jWkUQbFvTeWDboZn/MDY7KqVCfCgLvVSwuTrib76QljY+Ltx7NF8zqcke9kGqXYau5jB2c9uAvbu1S1TjvDdPRI7+0Ww4JdlA1UufZBCEhbc2zylgSJvOx+SpYp/dNAMrjcCHG2ppagVbTyxDkf6TCaO3HjY6yDH61SFy7FDjKnJ8XZNk3VCySvDJ8DISgVWVUNZV048fod3DC3nYzKrVKyNiuO17THngsxyuu6Nqfw9hGUXAuHLovvGcnqX9USDv3PE3FcLYs9x7g9nhV4zNBD0+a9hFA/rywPZd3b9Qwn9kFixefRtH96sSwyH2la2SO1Urb/5wOiZ131S5CDJuwGVlccFWYxlFOjPTIfRv0si6U9OOc5qk7dyYmcQ127N/DS0f6rtsCbn9wJ/FzMGzeiQhVfYwke3Ctc1B0QEgn507Z4TwlSDjMa+gKYgdRYo8oiAGW2s4kIfUgXz4RP6jqxaIeR5dm7aI+WtSNKK0YqtZzyjPkfxjUbpp5QhILc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(7416002)(122000001)(55016003)(921005)(26005)(82950400001)(6506007)(82960400001)(38100700002)(478600001)(66556008)(10290500003)(7696005)(76116006)(64756008)(66476007)(66446008)(4326008)(8990500004)(86362001)(54906003)(41300700001)(71200400001)(66946007)(786003)(110136005)(316002)(9686003)(107886003)(186003)(38070700005)(8676002)(33656002)(4744005)(2906002)(5660300002)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eHhtcyyVt/4v/q00C4b+JMklACWimB9t5k6LpO6CrfN7pZ3VLgHM2Pp6X5+N?=
 =?us-ascii?Q?dMLOq2Ycz5iTxWQKG2bqZk6EglyYKrDiv9LQUFhm13J7PD970Ft0O63J9uIn?=
 =?us-ascii?Q?Nc1wYRXwmczzxOLSzSwsHX1Ff0u2IqC0u9FHY2zCpWWxg5rmnQTZPv07e5Vh?=
 =?us-ascii?Q?uFMHOLKWgmLBKxtjAbJkO0PWksoYAtRpBb686yAfmgs6s9B+h5AjgmYtc3Vi?=
 =?us-ascii?Q?pj0W0SBtbOrRpCHNgpBq09TP5Jmz0aYR94MkBw/RlZWgkM+AZ99FOKP/DUgM?=
 =?us-ascii?Q?+joYDu3sL7i0WQiSQ26q1uXkkYCLJ4flX20t2ejmr1MpE9Mukgnp1V2pLcHS?=
 =?us-ascii?Q?m2aFrMNAndRbgcA0hOZ4ulhJy4bjwPCl7G5tstRkrSZ1Kja0f5t8k6+yjTtu?=
 =?us-ascii?Q?fJEGY4zxzEInGKf7WjQ7QhWuWlxzKZRVhHoOa3jK2dAreoXLq0poA6Br0x9a?=
 =?us-ascii?Q?wpWMkZC/MqZAPxjTqV6hkF/Sc1GT+hxOPpimuxCNz+4Nv2Txloh4gmaF6rgY?=
 =?us-ascii?Q?Q+MSWAWz3ti0eYUfo7x5CsZINgv7Ti5gbKWInTgg0NkwYRi6IAqQwujGf/Sb?=
 =?us-ascii?Q?bFPO5UJlq7jiu0oVcHG4xL2HdTcnylir9AncGcWAFIXm8iJnTXN2G9hhTz2/?=
 =?us-ascii?Q?NpffaSYiJrEtHphHYNCUA+4pgasONp6Am8vOtxeFIbTNDkuIHtZSYQ41ywbn?=
 =?us-ascii?Q?rpJE6iMLVSMuH/ml1cmHqNN+H7D0d6IT/54xvK5JmBgREMyP21ybq6ZQN4iW?=
 =?us-ascii?Q?05NQBnn7EArUk/RSPvaNM+fcoZOyNZNgLkyWOxu0vQ3Q0wi2uuU7FelOzzlA?=
 =?us-ascii?Q?G00NX62m+SBt8z0tDY18VBrySz/mj92S9J3pogTDv0QUXrjUNvAbIr/iMJcd?=
 =?us-ascii?Q?cfR73QmcK13QCQpjQt1Db7ZhNR790jXF4pvb4iX3Sy/yaGSj8o5oEPZ8n1AH?=
 =?us-ascii?Q?f++5yNU0ZHzjLmdCw5oajc+yGbYrD32iadM4QvliTiT6Y/W/PQDxOWb7Uhm+?=
 =?us-ascii?Q?k6Dzkz+TVjPCucpCuvBk9FTNin50C4PPX1LLzBj5ouiJ/9xfSZlgEk7to+Qp?=
 =?us-ascii?Q?dmgZlsiP22EVY0oXjuKU9rO2bKGHiqO9jzdsDkJsuKaq3HpQjNSkwWb6rpkT?=
 =?us-ascii?Q?Wyw7FVaEu3arq9NYtJ20pKlWwNKBvf+ZimTsDUMO5PnJHh0XfUOQoXXze3+T?=
 =?us-ascii?Q?/xcoybRL1IZTb3pIYSdSZbaiwyYDZZnPBdd7U6mpoqv1ydZjijueVBKDctwb?=
 =?us-ascii?Q?ghvL2UdNy2fNHZ3MV1vBiqPXbwqmOWCuaxhhfSIUYSjblLksQPrCw1LA2NGv?=
 =?us-ascii?Q?5b/kdgFBfK/hamu972CP9A4QoFAlzzCNpMmWvuSmkuOKD9izNQXUwg7dA456?=
 =?us-ascii?Q?5ydeKik3nwQrfkD/M5LvtWV1DUdSFd0e2zRqr3oksIZ6eJlJBG86h1jcg0dR?=
 =?us-ascii?Q?BZsDBHT8rV/3RyzX+s5kADofQPp83fS5/bOmjQ5r1lN7xzGRO3jtqhycoLMp?=
 =?us-ascii?Q?Gvg57EGh62ay+qNK78lMylq9UrnYPogtuYe7/VItfkNGmpWPSbSL0h0Q44Yv?=
 =?us-ascii?Q?OQA6X9iWWf7DzHkCVLLevMn7yExXmvHZvdprUygm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cc09eb-403e-43da-356c-08db421c0dab
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 03:54:05.8749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hjISDWfeX77/TmJxWwEBBioP1Nv8VKu75rZovt1h+JTB9A14dhmU6tF4Hl6fwHel0Ccwc/lI+s7sT25KKrNCPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3331
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Tuesday, April 11, 2023 10:14 AM
> >  ...
> > + * Copy arch/x86/kernel/acpi/boot.c: acpi_generic_reduced_hw_init() bu=
t
> > doesn't change 'legacy_pic', so it keeps its default value 'default_leg=
acy_pic' in
> > + * mp_config_acpi_legacy_irqs(), which sees a non-zero nr_legacy_irqs(=
),
> > and eventually serial console interrupts can work properly.
>=20
> I had a little trouble parsing this comment.  Slightly better wording is:
>=20
>  * Clone arch/x86/kernel/acpi/boot.c: acpi_generic_reduced_hw_init()
> here,
>     * except don't change 'legacy_pic'.  It keeps its default value
> 'default_legacy_pic'.
>     * mp_config_acpi_legacy_irqs() sees a non-zero nr_legacy_irqs(), and
>     * eventually serial console interrupts can work properly.
>=20
> Otherwise,
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Thanks! Will use this in v5.
