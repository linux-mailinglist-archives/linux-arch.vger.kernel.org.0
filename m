Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E077876391A
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jul 2023 16:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjGZO3W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jul 2023 10:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjGZO3V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jul 2023 10:29:21 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A0F171E;
        Wed, 26 Jul 2023 07:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBPUgJChPGHJmWb5ZKzHmavD+PI9W7G5eFxxlI0e9ctmH+IkvwgjwWfNahfx8FifgDusxhCMMB58cKi5VZrnFsqQg7IxJn44oOpeW96mUmFEEcHeJbxsj8dTPj8Ju8txqyYLRTgt+kijHfWdl4Uxv64aFV/17aKbU8NBx/4Nzss7osWHqqhxpN5D5OKFyQN3mPpUj2Sjgo8rXop/6wYXS4BRsNayf2S4KNFveQJwO/+aFuGNhHp4x9bm3/rIbSVI8aBq4UEjjq6aCQyuZ1eswSp6HU+3P6slv6YDSq6GczmP8NGg2ODLr62qHRg6MZA6WrIYvA2blZkEiKv2d1wdbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zi8BlvUAb7CdiuCncdCkBPHMkbjXNrWmVdixzzheIGU=;
 b=XEa0JSvqRGVuP6xd7axqKzMR8+ZKf4Ba31xzLBYEymPBtF2LU5/Hhd/6vMFfVmj2bcXkX0pOMRL/Ur/fYxHvUY4+MiMEnVwoZcz5ZktN55ii18nIoI1S+jroyGQg7pi+RoTlYQbAq8UaEDcQQ1zr/Fwoaq4s1IihvLT+Z/Dkza0qNfGuTLZaBKVbX5C5wWT6DwxvW5NStCnE9IgUYeMTVftIJZFXrFw8kGV57Kfrajzl+lIK3ny8NMmjIXgBvejpYtKzV8w6gqfmfkaO+ia2QHkX96RTfPD9sHQOAQvyEbDRmV82qVdJI8CT78ZWG94ke/a+zhsJ3iC+rkPZ4KsTzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zi8BlvUAb7CdiuCncdCkBPHMkbjXNrWmVdixzzheIGU=;
 b=Jkr50QpAyFeKLcPrnsgT9bVq02wOrMrBQqDW961+Du/86P+sdtPqUCaYArvP0p1noO+1u2Xfru8mIu3+ynF7BqGq59+2CUSrMTIEgP4QcHarl90qxEN+Z3Ejk6DO3TrxHL2bwRaL3Gq5eKbXhyyMbOgNdKZXvt8ZDmETQjqKIiw=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3608.namprd21.prod.outlook.com (2603:10b6:8:a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3; Wed, 26 Jul
 2023 14:29:13 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f%3]) with mapi id 15.20.6652.004; Wed, 26 Jul 2023
 14:29:12 +0000
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
Subject: RE: [PATCH V3 5/9] x86/hyperv: Use vmmcall to implement Hyper-V
 hypercall in sev-snp enlightened guest
Thread-Topic: [PATCH V3 5/9] x86/hyperv: Use vmmcall to implement Hyper-V
 hypercall in sev-snp enlightened guest
Thread-Index: AQHZuSc0kUvvgTYmMkGptk368Lxyvq/LcQ4AgACr9ICAAAmOkA==
Date:   Wed, 26 Jul 2023 14:29:12 +0000
Message-ID: <BYAPR21MB16880B1657BA4C907D002730D700A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230718032304.136888-1-ltykernel@gmail.com>
 <20230718032304.136888-6-ltykernel@gmail.com>
 <BYAPR21MB16882FAEDEFAED59208ED9E0D700A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <89c9f27c-f539-ef75-dc67-bdb0a8480c4b@gmail.com>
In-Reply-To: <89c9f27c-f539-ef75-dc67-bdb0a8480c4b@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0f3fcdf0-fe00-4a11-9e58-221e4fd51a7f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-26T14:21:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3608:EE_
x-ms-office365-filtering-correlation-id: 6dd41810-5595-494e-7613-08db8de4aeb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UZxXqEPJnJ4UoN/11NMkyjTfXKYtwheyZVkyZv/6EdkQzhOZbxg0J31borkom3uU1haBxjUMgAeHb0FS6oI41adVZKPuhxR9pTJ8upJGWlFhEoMVX+rwQmpIDNwEO9eou0OaEbACQ23f80poqMilbeq2cg9u8yjiNM8D+tvn7oliWnfdgkIKrjXVPLzEzl1cdBjV5lxIJfutJHSmsSemC9u3hkFpQvvlDTJG0xd71f6rNouGEx38QuDcda8FHXZVN+nudeOzAajEWmYiQfmfuLpHQimlPMb3S1T0R3Z+DgsNPvusp4GJYfnuoFqoP+IEgSuaaWzLioedeN9Cq5B5TFxP3gyAMcIXs1X6fjsJlIlOe6NJSxT6PpfTMQtMTla+WMrjheF8gKYGXi8Hn3B6U/vhrV8ogl/EcsHZisJ/fjzSu2O5cU0ceMs1NKDgwKjRD8idHjzDbKxP3z+e5fWIicBuEFHAvHIjU85rzvPEwAjFcg36zNyBdcePxLVOaJW3Rf9TlUSuWidhPGmcKyqKoU2cBlaJtWgfO09WFmt7P32W9MBMqx2jijal8e3oc86YcLxv9PLRijG7qEutBil+y98i1JfP0xNtEHTql9VOnS9Y97g9zUXs+CvRdaclhoOmEIGKVxLRfvVZQYwIbmoPiu50JmJQf30Mk1KUmox8F+k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(110136005)(316002)(54906003)(478600001)(52536014)(8936002)(8676002)(38070700005)(10290500003)(7416002)(5660300002)(966005)(6506007)(71200400001)(38100700002)(122000001)(9686003)(76116006)(2906002)(4326008)(41300700001)(64756008)(66946007)(66476007)(921005)(7696005)(66446008)(82950400001)(82960400001)(66556008)(53546011)(86362001)(8990500004)(186003)(26005)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2lY2dbnl2EcSsJe82FtP57huoaWARumM2EOARctAmXGFQO+Z3NfdnpxM3gCG?=
 =?us-ascii?Q?WcIbI9FoaxnpEKUsABnwD4hC8gIgd3mCh5CzbdbJo5tNKOppCpbhOL/Djid9?=
 =?us-ascii?Q?NnSzY+XQ/RXIlEi+3JDSeFWQsUPQ5G7c4KFdGukxH4fezY1jfVpTkWvs3saW?=
 =?us-ascii?Q?h/PQMEbBCM5JVXkMWAfkKrS3ZCVtuLJWOuhIxcq+cPd/ZGKoSj9P2Nu7rz2R?=
 =?us-ascii?Q?McCFS2alhIq2sevDqTPpJriPTAcHwyF8WGzrZHXjbJaF5dFC7EEoormEtxHZ?=
 =?us-ascii?Q?0azt4HkzFMnOQKoWxatBVcus9EVAHKVSlz4TDOhf75rtIk20WB4681GMVAW5?=
 =?us-ascii?Q?jyKA0FMTVKcd6vqfex2LXaH9YFUh0U98sOma6T5tOgXhZm/Vlu7gQvY6wHys?=
 =?us-ascii?Q?0O3kvU5XrfaYmwVMBCyP9NufylmbMYvAcUyr9uZp08sXOQW5aNdp4j1Xu/nu?=
 =?us-ascii?Q?zjv9Dw21uh9z5BMlJDeLuhQRuy04ciPZzUxHisZh5T/M5unDapfGL1p/vOCE?=
 =?us-ascii?Q?VnToppWhwVuXWYfhUEBLcHCMlZhKdDn7KxL5A2kfEI6oO59/UwHkX5wwfWbU?=
 =?us-ascii?Q?sXTsVVvkl2FExI/HQZfe+d+tT8lvJVuKAfU7wYvwHuj/vHTGpBiSEYk1AaG3?=
 =?us-ascii?Q?mYm4sqprrMqQDDgmtTbBUSmtQ3rA3SlZAgZarVHtxhYrc+O8JhZ+ZTTJB9KJ?=
 =?us-ascii?Q?MYVHsPJuJ1SM9nHp1neHov7n+iMbmWZkv80hHRZaxTvUjPR6s8EYYLw0cq//?=
 =?us-ascii?Q?Z84n9E0RqhQnxjZ+0qZ1lGmhD0yNA0qMTRdFZhjbGmUVBcoNJS7yzqGM24en?=
 =?us-ascii?Q?P/rxf2paOX6EhHN39Dyk5vldomlFm80tIfOQ6BcMnG3xml5Lvr//kSAtaPco?=
 =?us-ascii?Q?h0gs5FiK1YvYh6gYc7c6TDp6X6ZFaGLDznfIuxat5KjVotivSzX+auGdALX7?=
 =?us-ascii?Q?oVCgQI0/6MDJ1wZSw3aCGtG3fiQL7KBduWEJrq2VkCX5LCha0IkDFhPAvKgQ?=
 =?us-ascii?Q?DtQeOr7Vr+iloJhZU7shNrODWLF7gx+N7mb+hvepWPnkBAOb2/lVvlUJTik0?=
 =?us-ascii?Q?gSxwWipSFGvaKiu0Lq5FfifrilVPsx68zA+toBrFfHdFmRf18SwTEH7e3tp1?=
 =?us-ascii?Q?2srEUMPt9Jbs5v+am1YTvO/yFpZaRo94tr8CBHa31XiAaGbop/2UTrH2Ozsr?=
 =?us-ascii?Q?BUHTlFXlfsxj5NZkPAC3YH1jW2q7tT2z1I6SNgiphRxT2cLrA4mu27SwCNuc?=
 =?us-ascii?Q?cUeDB8NftTZ7IE3UAN1VP/JSN7FdYggaMcY7tPRrhp5d6vd4iv27pGelpoxk?=
 =?us-ascii?Q?0S5MwkizPGEpy4RjjsOe98W9MDnDulY7YKsydtAWlz0NCSXAQvW4I/9DiM2w?=
 =?us-ascii?Q?w4m7HoiGWSpAtyQsmLGcMfbhPHzJLm1+wEoBz/0XXr4RMsQoZVJNOpC5Vrtx?=
 =?us-ascii?Q?/vgYUR0Bi2ZE4fOtTrlYafjOr2RGa5CTg59SEil9Q78dIfwQ4TaEr9z6zO3w?=
 =?us-ascii?Q?hOvqILyz8dAd+Q7emyw8vwAPVKP3eQyh8TldFKspGdVB/Z28/dLnoj5obRLI?=
 =?us-ascii?Q?m09rIOdwRX21wut4OIACtL63Ujzk2jtqisny+wEaEIJ4UJIKniL70EIP6FmF?=
 =?us-ascii?Q?dA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd41810-5595-494e-7613-08db8de4aeb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 14:29:12.5711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GyJwAN+7zabB+HKbmuzV5IFMOH3XYXBVNRM/sD67JAJ5nOffR4oaVPzmoJm7QZpPO1gKV+e/e0aYf2ftur3r9PqbNePoq60L+S3/ZX2N/vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3608
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Wednesday, July 26, 2023 6:47 =
AM
>=20
> On 7/26/2023 11:44 AM, Michael Kelley (LINUX) wrote:
> >> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/ms=
hyperv.h
> >> index 2fa38e9f6207..025eda129d99 100644
> >> --- a/arch/x86/include/asm/mshyperv.h
> >> +++ b/arch/x86/include/asm/mshyperv.h
> >> @@ -64,12 +64,12 @@ static inline u64 hv_do_hypercall(u64 control, voi=
d *input,
> void *output)
> >>   	if (!hv_hypercall_pg)
> >>   		return U64_MAX;
> >>
> >> -	__asm__ __volatile__("mov %4, %%r8\n"
> >> -			     CALL_NOSPEC
> >> +	__asm__ __volatile__("mov %[output], %%r8\n"
> >> +			     ALTERNATIVE("vmmcall", CALL_NOSPEC, X86_FEATURE_SEV_ES)
> > Since this code is for SEV-SNP, what's the thinking behind using
> > X86_FEATURE_SEV_ES in the ALTERNATIVE statements?   Don't you need
> > to use X86_FEATURE_SEV_SNP (which is being added in another patch set t=
hat
> > Boris Petkov pointed out).
>=20
> Hi Michael:
> 	Thanks for your review. The patch mentioned by Boris has not been
> merged and so still use X86_FEATURE_SEV_ES here. We may replace the
> feature flag with X86_FEATURE_SEV_SNP after it's upstreamed.
>=20

Just so I'm clear, is it true that in an SEV-SNP VM, the CPUID flags for
SEV-ES *and* SEV-SNP are set?  That would seem to be necessary for
your approach to work.

I wonder if it would be better to take the patch from Brijesh Singh
that adds X86_FEATURE_SEV_SNP and add it to your patch set (with
Brijesh's agreement, of course).  That patch is small and straightforward.

> >
> > Also, does this patch depend on Peter Zijlstra's patch to support neste=
d
> > ALTERNATIVE statements?  If so, that needs to be called out, probably i=
n
> > the cover letter.  Peter's patch doesn't yet appear in linux-next.
> >
>=20
> It may work without Peterz's patch. Please see
> https://lkml.org/lkml/2023/6/27/520
> Peterz's patch optimizes ALTERNATIVE_n implementation with nested
> expression.

OK, good.

Michael
