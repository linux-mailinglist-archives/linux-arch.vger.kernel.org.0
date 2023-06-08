Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD88728152
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jun 2023 15:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbjFHN0A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jun 2023 09:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbjFHNZ7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2023 09:25:59 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021021.outbound.protection.outlook.com [52.101.57.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47A8E59;
        Thu,  8 Jun 2023 06:25:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6jY6ivjCyNMCwoWsHiAo5qzwTKMoPO+fltV/qBPmynkNXQEZ2PHxDzZYwjSaxh5uU7eTURAjrKAnyrlFBFxoRBgVc4Abo9LNCWvXJEvImxZqw1v6e5RkGE/FeDqka25R+17hKXoq3gD9J6BpsRWtURGVZISDauUoyJqyytJscUCfqC8wQecP78ogfPOFVTHUnILy74CfL+OvTwYHjkSL9AfIcZgGxoqYwy8RtwdGQhqsDyJyOCzIKRqZMazso5FFjQxOHoSUrDwhb3c2icU3X8LLnIpK7Hb680d5mi7lb/GbE6Zt/+z1E6goZSwYPnFdHt2JEaLP214snyHjOjpCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dnaw8tO8KQnhijFYIPvuSpkltcFXVI5Fg5X4RdxNs44=;
 b=jDwhUkkBLnpLS+gmkdzLwD0/r63BMJZdR07lGFbYQTyjwaVssNVgqSgveV5c7ic6ZFlatzyvhyulZ1luiUphhltyv3gN4hVlm7SrY7unE31/ksR2GqMfHuPSFTQpDK0B6HPrHxyIKGGVKtzfv2flmjOJA2LqojNsgcMy1U7SVbzE+KeaZ9MLkgunLhB69Cqiah9KPxXoVXg/UDo1VFU9z2zcmNWKFUwNyuGTJCLPP+T2sJ6GQhofmLJMiLtB9zmep4tKPXtHiCrEHaek2Vp8mlxRFU1hnGyK8HQ0Db6hL+OZWOiRrkd0CM4IZy/E0MZhaMDlYxPIGJgZ5eQ1QPTwLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dnaw8tO8KQnhijFYIPvuSpkltcFXVI5Fg5X4RdxNs44=;
 b=S37PkZduwooxywb2qvM6PMbpxG6vymuyv8K75Cen3C7hqI9KKT7xLmg3AFll/24UaCq49jO66Sy40txh0Kvxm7Als7OypnUzy3Gq0FclTKUGHwkQjeNL/2nzsbFPw457LqM0gt1hQBUWxGCAmczgtg0CcEhJ0ajiAv7oQRS7Y7A=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM6PR21MB1484.namprd21.prod.outlook.com (2603:10b6:5:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.14; Thu, 8 Jun
 2023 13:25:53 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b%3]) with mapi id 15.20.6500.004; Thu, 8 Jun 2023
 13:25:53 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Tianyu Lan <ltykernel@gmail.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/9] x86/hyperv: Mark Hyper-V vp assist page unencrypted
 in SEV-SNP enlightened guest
Thread-Topic: [PATCH 3/9] x86/hyperv: Mark Hyper-V vp assist page unencrypted
 in SEV-SNP enlightened guest
Thread-Index: AQHZlJwOHk9wDUuOYkG2m1pIumuPhq98JQ6AgAHHLgCAAAdvgIAC+acA
Date:   Thu, 8 Jun 2023 13:25:53 +0000
Message-ID: <BYAPR21MB16883BF49ED337A6EF063461D750A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-4-ltykernel@gmail.com> <873536ksye.fsf@redhat.com>
 <4103a70f-cc09-a966-3efa-5ab9273f5c55@gmail.com> <87o7lsk2v8.fsf@redhat.com>
In-Reply-To: <87o7lsk2v8.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3ca3302a-c1d1-4718-b498-c830ff694038;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-08T13:15:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM6PR21MB1484:EE_
x-ms-office365-filtering-correlation-id: 64bd34a1-2a71-4431-10de-08db6823e260
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2hi2r19vxKKW9icIEltddPQ3rI39ZoBZVlGQ2iNwVvZMh+jR2mThYLIZXVD+f0ACh2SsEecrlySs06VtkfJM/ifVK2FffUBdh6jnOjLVJ+xaGf6+uMhx6kWT/Sm54fOArpsWtrEyrhoKiLbocbE545RfUCDCq5WU0atc+qJP0nE0vFdvZhMpa++0jm8CibXa121+RFsHD6U4ODXGAYww9oDvMYWq965v307zdzMB5r8S9Mn142ZpwwHAbzL6wV5Cyap8gqbTnaOMcCnDyvGLAMVhBFO0YrFR0D/hixA770QHAg4jSQwcnyzfWIxb1XgWKCuMo2h3h++T82yREMfM19EHYE6ZR+1LH/P3DLGMmJzUsD8XXnI5XKR1Dz07gtuUpVq6S/o5B8JtmKg0DHKCzfUeGNWp9UfndwsIl5FwS0D8tz7IafJg9OylZsRh1xRbEWXgUsjHIPiQo24zbJ4CJPD8xPE+YvP9mh/Hf60a99J0JXnUOkUBFuTu4fRTh9rR3qg9E3/bHW4v4M11FHT3z1L5yWuVj01eVE+cBRCcvx2Pu1gSHLXZ5wWROrQsSTSzR6khEo5ZmwCYLwvrI2GQsvVx+bBGO6DFGyWK1LEyMiiapV9Y3SvOsmsZ3f6T5tzSK+51CWPYaH6gaQpK1WnTFlqrMVS/ZquXpKlk/MN0MxL/yqFhqNDMHM+HPh9xTKmq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199021)(55016003)(110136005)(54906003)(921005)(122000001)(82950400001)(82960400001)(478600001)(10290500003)(8936002)(8676002)(4326008)(76116006)(66946007)(66476007)(66446008)(64756008)(316002)(66556008)(41300700001)(38100700002)(186003)(83380400001)(71200400001)(7696005)(9686003)(6506007)(26005)(53546011)(8990500004)(33656002)(86362001)(5660300002)(52536014)(7416002)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kfdvaz8fKu/tM1NTi/I47mSH/xD/WWMjK2v4aUMn7sl2uVPScdiXGDUkujPy?=
 =?us-ascii?Q?CB5fyi/8s1RDT1/RVmf2EJ/bSzQsRBJFeB+94Cu4pXZUd/vahUNfoB3Kr+tw?=
 =?us-ascii?Q?CoPI4v+KrjLe9CgtWMgBzbDY1ig250bh/zBsk6LyCntXB6kFvxaACxJT9HHz?=
 =?us-ascii?Q?0nOYhl7JLHIBR9KnHtib/8GEcRzEEBtvAI7VUYz4xqFHN6aHgylQlpyNRhdx?=
 =?us-ascii?Q?Qc3JM/GG7yZW7JwmixazQHUeXosSUHPzzEr3nIa7Y5S8YlTUsS/QCEjHS6qv?=
 =?us-ascii?Q?2YohpT2QYfEgGkwt5nyWc+qfUGBduOhhGtUX5v6jW6/tFQyXm3JFvOgz7NJE?=
 =?us-ascii?Q?bIP0rXsWPpcv87sDisGiz66VWSUi2CnL/WGHASKvMvTirmnlKFjPxTlmODaV?=
 =?us-ascii?Q?RhTH3ZJhFRPjF1ROSaPYgscmBTyZOz7sWzLXJfuM6xHlmKQ42E4M2wKYJ8IY?=
 =?us-ascii?Q?vlfbdk88noK9mPIRJDfcY0gaZeLjafNuw96ZNjIP9c8IZiOBvssx35TqG/qB?=
 =?us-ascii?Q?LRY0+OQlz3qDp5RKNTNYH01XqWh4kbaceQoPuWpZk6sdiGwthCqdoElg1gdl?=
 =?us-ascii?Q?m/fqlnVyFJj+YxvMPkro2iUC2H1F7AJAE18QX4GqPy36VecHfHyOQt+Z1YE4?=
 =?us-ascii?Q?9ffi/ILI+rP5Bbrqs82S1581G4if8wuRxJBJXgMVlJ0HTR/pd5juoeywmrsr?=
 =?us-ascii?Q?6AJTtU7CVdqWl4zk13wzSgbYn+tVr3G+KaijMXHVioFC6Vl5Fy4zlREf/f1U?=
 =?us-ascii?Q?pFW3e8GbappzTHUZEPRmaImap87UupBIcwGIuua0EnB2yRoE618c39WWLgCw?=
 =?us-ascii?Q?GJaIvZ5F1lE34uMVHZt2Dh50Q19dENhOEj8i5X2F68ynDjp/UIR1O4Sa0sER?=
 =?us-ascii?Q?N4WQpCfdqBe+0xMQDtDwc6v5CIc0/02PSBVtWSO7XO2nCDwhYxk5X+0RPCC8?=
 =?us-ascii?Q?mk+WdP4nyjkfJEyxdKx/zi3yVCi6nFOQgRLV4i1rl8G+FGYX9kFhwLOerDRW?=
 =?us-ascii?Q?VofptMhFRyqLVJERy91JmfQRdZQQphfqr65WM7kk0JcNV6djsN1xPVlxqs0A?=
 =?us-ascii?Q?hn0VD+IdCsdIJiFmiyrMrwiHtjLVcOdK9TDqga/hYxWC2rMbVKPuIKIBOl/T?=
 =?us-ascii?Q?bWmqHknkvITrCYiqcebARIRwB4ipEshYFu5k1nqDmXPOHNGYh80K7cGoPaNP?=
 =?us-ascii?Q?dBzJYhX61K3nB/ReEfugZfQTJj0qKiAkPGo9VGboJXAls4r+iZmG5mKcAhX6?=
 =?us-ascii?Q?CX1n8KlQRJzIB3BD9pRaL1SMr6NnWm4ESuXftw4+d21C5NI0QGMuA2Psf9z3?=
 =?us-ascii?Q?F3OdGF400htvwZOS/UbcTDkQ8bUfWtrnr/9lPX5upC1OlC3bsHGFrHxeVajv?=
 =?us-ascii?Q?jYqzJBk6Yg4OkbwHerjxBqVcoBsmNuYoJz6yMo6vNCgpJH/v9BkL6LguAgvW?=
 =?us-ascii?Q?ZQIFChn6ht4NXCFGBx4CKiLd6j2XZ3M280OkGJLGeLws6JCvpEdFgDZmytDY?=
 =?us-ascii?Q?6W6B5XY7eEVi2ppL9kwVE+88aQ6Sq470XUAwlmoRD7nTVjp+QfPyfc6yPVyL?=
 =?us-ascii?Q?ym02yG1oSfQObJqye6OaKpcenlX928Tg1aP5m6RFeLi56ljfMDD29vU7qnyq?=
 =?us-ascii?Q?Lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64bd34a1-2a71-4431-10de-08db6823e260
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 13:25:53.3844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t87zo+LBb+fguYlibies9MAlZ5vW42XGuTspOSteZhnNXzSJcpLMNSc8GzEhUVXKS9M2C3qK4407OzFQ0z4jYTiZyAdEAjZb7u2c2idDzi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1484
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Tuesday, June 6, 2023 8:=
49 AM
>=20
> Tianyu Lan <ltykernel@gmail.com> writes:
>=20
> > On 6/5/2023 8:13 PM, Vitaly Kuznetsov wrote:
> >>> @@ -113,6 +114,11 @@ static int hv_cpu_init(unsigned int cpu)
> >>>
> >>>   	}
> >>>   	if (!WARN_ON(!(*hvp))) {
> >>> +		if (hv_isolation_type_en_snp()) {
> >>> +			WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
> >>> +			memset(*hvp, 0, PAGE_SIZE);
> >>> +		}
> >> Why do we need to set the page as decrypted here and not when we
> >> allocate the page (a few lines above)?
> >
> > If Linux root partition boots in the SEV-SNP guest, the page still need=
s
> > to be decrypted.

We have code in place that prevents this scenario.  We don't allow Linux
in the root partition to run in SEV-SNP mode.  See commit f8acb24aaf89.

> >
>=20
> I'd suggest we add a flag to indicate that VP assist page was actually
> set (on the first invocation of hv_cpu_init() for guest partitions and
> all invocations for root partition) and only call
> set_memory_decrypted()/memset() then: that would both help with the
> potential issue with KVM using enlightened vmcs and avoid the unneeded
> hypercall.
>=20

I think there's actually a more immediate problem with the code as
written.  The VP assist page for a CPU is not re-encrypted or freed when
a CPU goes offline (for reasons that have been discussed elsewhere).  So
if a CPU in an SEV-SNP VM goes offline and then comes back online, the
originally allocated and already decrypted VP assist page will be reused.
But bad things will happen if we try to decrypt the page again.

Given that we disallow the root partition running in SEV-SNP mode,
can we avoid the complexity of a flag, and just do the decryption and
zero'ing when the page is allocated?

Michael
