Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEDC7186DE
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 17:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjEaP67 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 11:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjEaP66 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 11:58:58 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57368B2;
        Wed, 31 May 2023 08:58:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dp7Xwlgs1Dxq4yQmi2x4wrLHNRpbNCSZ7P0Avy+xKwHjguxTSkGeVRgKlvc/yDiJUV3o2f6y5yQWF6VJRnn20PAFYPw1UzApsK7j74YYJylBi6t2W9pkOkHuWONoghh51f2juUGOLrSDnJxLtD8U+bQ0+ieO9dH6MuSp752rAqM8KqXpMneW+I8hPnxDQk6PgShAcnKZJ5j/UHUjJ8okkZ5WdVKWviso0uuYs0dVlZ6wUxXAuM1enmohcu3gC4IJ1MdcfYGldMSs3CRXR5fc/ndvgPuq7+ugmZRG0HvRsqx9R8d49y3IBFg9CKKL1oBIqHEI35OmSUi9c52BughdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHy2eCy4Qmv5zKosQaudi7hy4oDC8VICrMxfpSMpnxM=;
 b=P++E47GuwPTmYkS395csiqzrHslxHZw6b98hQktjFNuTy2du8xd4tQ6EJ9BtvrVRshzRr9WY1NDl+/xXtbGxinZFjxk0ATTZHLhAtbMicZvJnWLFdQAtKW3Msq+H0z9tHGOxMfZ8Ru9cnNVOfXNauM2RmPr7Hv3lkPPih0qeOzdD1DF+QgM8nKEOjIuXjuiONpdMvJnyP+ndEc2TZ/hHQLPZln+YHFB8SVGrzJuBUW+PwLnykUuQSCImevvwuJhoJPPWjnwa1j8FjdXliOG0c8gsyPNdlPuH/ZdYWSw7qV48tRzwxDlsmGiHMHFwCEr4wWiR0eZxYF46GiqCwElIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHy2eCy4Qmv5zKosQaudi7hy4oDC8VICrMxfpSMpnxM=;
 b=HfAEKGAZeLhyjhwSqPcrDEPGUPe7/ImQc3/MrGpdKzMPvZip9H6SoB12HBU2TtCoVczBPRZTGk1yPR7b4hmp2HAuyX4uXQpVlAnPd8UBTfqYTeBULdqtUM3am659CGVzW4tnjRahPjaJzJzD/gpw8RQe3Qy3HtELbNchgcxq5xM=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3444.namprd21.prod.outlook.com (2603:10b6:930:f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.3; Wed, 31 May
 2023 15:58:53 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::5fb5:15a9:511d:21c9]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::5fb5:15a9:511d:21c9%4]) with mapi id 15.20.6477.004; Wed, 31 May 2023
 15:58:53 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Tianyu Lan <ltykernel@gmail.com>,
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
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "pangupta@amd.com" <pangupta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC PATCH V6 02/14] x86/sev: Add Check of #HV event in path
Thread-Topic: [RFC PATCH V6 02/14] x86/sev: Add Check of #HV event in path
Thread-Index: AQHZh06i+lag61PbVEa3Lx5CXtmZu69cpAiAgAGY2YCAADYygIAWGHuQgAAUiACAAAI4AA==
Date:   Wed, 31 May 2023 15:58:53 +0000
Message-ID: <BYAPR21MB16882587522915C96A72413ED748A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230515165917.1306922-1-ltykernel@gmail.com>
 <20230515165917.1306922-3-ltykernel@gmail.com>
 <20230516093225.GD2587705@hirez.programming.kicks-ass.net>
 <851f6305-2145-d756-91e3-55ab89bfcd42@gmail.com>
 <20230517130943.GE2665450@hirez.programming.kicks-ass.net>
 <BYAPR21MB16887196D3DFFCB52EAC546AD748A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230531154832.GA428966@hirez.programming.kicks-ass.net>
In-Reply-To: <20230531154832.GA428966@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a4611435-85c8-4007-83aa-fcb0263ab379;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-31T15:56:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3444:EE_
x-ms-office365-filtering-correlation-id: 059f28fa-4715-4802-fd31-08db61efee9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jTIEi8mSmjiIEqpiXuseWgbgzbx9JoNApsesicujwvYKzhhb0B/0cAHg46OOx7VGT5ievbMIUAG0wIuyprJHF4vnvaYGiZb4wQBzIv+ce6rYkhB5Q19vHu04OOY8Q+qoD38j0kld+6ut/xsshVPuYqxukq1/jkg4aTOhc616XIg6CXrzAFE6AT++xV/0PXJM2QffEcC/CEctB5mGpyX6MqXVhCMEuRC0Qsv/ez36ljBKLyvFP2ertwQfE+nX3GDYkJqz4mEIBFa7SHHmKKTr80V8TJLsXjC/GWPmfVpvyYPT4AnMhEzOBBbKY03MAdHo08laucuzuafaxKoio6A4t1bu/1gijZi+/fTi5gU4roZnkJLbf8bsZrytq/2wkD+dwZeWx5wvyCMk8Nnrvg37q3vya3pwsbnGQy7kXhRV99KMFoO/+tgpBXl8RAlT7E6jSEzhHRSrHHltjhoOAPIlu68NE5zgmqKOgAnUvEaxCybcLN4FlvpU8szhzmeMHjmhHY3xw72vyD8U4jcrKb8qkyYITGLiiPI1lJ9N4W6oD03ZSLqPSLZS06l3s4NNb1BwIcrQ+5OZ8amqyf/J3bgHM2W/hxqrHSqDcppiK2Nn34h2UaU7tAD6SPDgaZO/qAFg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199021)(2906002)(186003)(6506007)(9686003)(5660300002)(52536014)(54906003)(122000001)(478600001)(8676002)(82960400001)(82950400001)(8936002)(38100700002)(26005)(8990500004)(83380400001)(7696005)(33656002)(41300700001)(86362001)(38070700005)(64756008)(71200400001)(786003)(76116006)(316002)(7416002)(10290500003)(66446008)(66556008)(66946007)(66476007)(7406005)(6916009)(4326008)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vSun28C7nvrpOEZzZwCeHwuEl1gEnhnwNZW61nXJTCNEVr3n/fdYkvijMD0R?=
 =?us-ascii?Q?GXMOrVtr4evqbDRbT2kyyG12rAtuT5U/H6M8rAw9h85FFUVDKmPIBmUlgLD+?=
 =?us-ascii?Q?SNYGpVKjV3RZl3w6mVP16S3fbIxRIAaTk24zIRyGaFBEUZMVqIhPJTosSWtV?=
 =?us-ascii?Q?x25ucBBbV9xnuIcEJvJn7+EOr63se74odmiKQ43VFaiO6/WfyzqZ3dH32g3J?=
 =?us-ascii?Q?aHXCu+wQi748Ghzwj4og+zXS+Lawx7ZgYBs3BNj9c0eTazH1mE3wMg4H1xS8?=
 =?us-ascii?Q?szhWtNy6SoRB4H329JKrzJ2GKnvyxRpLpcE5sXj1q+pPTwPuZKMn4n/lUq3P?=
 =?us-ascii?Q?ybxjowVedAAcEzgjQqhMra4JkQ1eSMdrVIIFlQILCfRe4wF+tjxw5RP8D7zz?=
 =?us-ascii?Q?ZCNPS2a4v/X45FhBYzfy94CQobc2ZbWCEZR/46zzypFL2YIXp+UL5QN84Mg2?=
 =?us-ascii?Q?HsPJvKENCJy1i4F0ss1onOQKDgbKsd5Dx81icANJ/WhgaN0GZcORcCLAO36L?=
 =?us-ascii?Q?A0mJ3e5BQqi1mwLek81WsiBjtsmSdkO+gYAsX17IoD0+g/13xhoayxTcxBVG?=
 =?us-ascii?Q?0YhH4rLrtrLOn0zGOkyyAFHKW0BKGxhsMSDoTjPlEGiCmmHkO2t30wNFuwcv?=
 =?us-ascii?Q?8LYIQX/1eQb6KCPQ/KOWoYUTy4Ml6Zt+nrT6kH5R/ZKxpNlhav+imoYpLiwz?=
 =?us-ascii?Q?/j59rfPxmLPT9NyJ88CkVfM3Xt2+r/AJK8BMuB8k7ulCK4Lxvly1JgebkiNX?=
 =?us-ascii?Q?1Wg9T11gFkQA+OTnloQiPXXZnMbrgAnTli8llegNPPg3q+bsGvaiUVRCM094?=
 =?us-ascii?Q?6OPrmt8b1fQZdO8Y21jpG1lrQotdqVOTEjpOMbev4QQO2igRD7cuWYPYVQvF?=
 =?us-ascii?Q?tvFtunhu/wFIaOuI5ZPGWDh60CCe2Gqm1JYRPZ8ICzHRAZUaHz+HgL3R6c13?=
 =?us-ascii?Q?vfMuL/B7WqjziMnFGO2uFm6ve4ZfB8TU7aKF0q6nuHH39rbHvW74taO9U0rw?=
 =?us-ascii?Q?H0KH5b7h8PDZHsHzPwhScHqHUohEWLnoXeyMzla//EohQBrAdbHbNsSRjnQ/?=
 =?us-ascii?Q?IqaK5A9r7M+lmNpiO0LgW0krWjtz81EpY+EfQmAYsZffYtudTcnC2kp1y3DE?=
 =?us-ascii?Q?NTBr7GuiTZeixBBoZ00O1hXxdAJemSuF4pDsP1PfY/ATF4Sf3y4JC+9JYHwB?=
 =?us-ascii?Q?zk9k5Ak3GDf10kpsoeQP7YsSyWYejb/Ydxqx3LUDxIBOm8ALqUnfwseamPUh?=
 =?us-ascii?Q?mpeKmQTkWMYaRrDh1HmsnRAEM444J16vZHsDV7a+JSK25e0ANcZeSIRMIHw7?=
 =?us-ascii?Q?73LD/4gd6bvpk+Bie/T0qqgUX1y27M3kym1d65KS5z4Z0Kqf2kODv5GgbAmg?=
 =?us-ascii?Q?5PbFiCtFvvlJuSEzR9/wPmfKqfrq1E+QZiC7axKYm00u4eLYerPYlYh53hHb?=
 =?us-ascii?Q?H7oO4WIaPySPfuAsrTqbSC/HkuXvK15+vd2RO6UjMtUx48nZUKpbeSPNdULn?=
 =?us-ascii?Q?ltGgFxZAPbDFcfaJhw89JpQ6ZcTla+OdAwPmJsAsaE5rRlMw3WAmRO9L/Ez3?=
 =?us-ascii?Q?Iq2GQKednFrDlKXsEDR9cigzM8IkvBNaIjLszeyhYEdJk1ls0mDY7JY4hT+K?=
 =?us-ascii?Q?4Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059f28fa-4715-4802-fd31-08db61efee9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 15:58:53.0959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x9JkQKbGVloxN+0k3eXu821M9TM/bWhN2hu6Sb+RQMw9Z2i85J3hX8KV3/bDrU1hZ//23WRs7s+0oX9pBIXCEdtvLUUnyE2k+DhGctkHujQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3444
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org> Sent: Wednesday, May 31, 2023 8=
:49 AM
>=20
> On Wed, May 31, 2023 at 02:50:50PM +0000, Michael Kelley (LINUX) wrote:
>=20
> > I'm jumping in to answer some of the basic questions here.  Yesterday,
> > there was a discussion about nested #HV exceptions, so maybe some of
> > this is already understood, but let me recap at a higher level, provide=
 some
> > references, and suggest the path forward.
>=20
> > 2) For the Restricted Interrupt Injection code, Tianyu will look at
> > how to absolutely minimize the impact in the hot code paths,
> > particularly when SEV-SNP is not active.  Hopefully the impact can
> > be a couple of instructions at most, or even less with the use of
> > other existing kernel techniques.  He'll look at the other things you'v=
e
> > commented on and get the code into a better state.  I'll work with
> > him on writing commit messages and comments that explain what's
> > going on.
>=20
> So from what I understand of all this SEV-SNP/#HV muck is that it is
> near impossible to get right without ucode/hw changes. Hence my request
> to Tom to look into that.
>=20
> The feature as specified in the AMD documentation seems fundamentally
> buggered.
>=20
> Specifically #HV needs to be IST because hypervisor can inject at any
> moment, irrespective of IF or anything else -- even #HV itself. This
> means also in the syscall gap.
>=20
> Since it is IST, a nested #HV is instant stack corruption -- #HV can
> attempt to play stack games as per the copied #VC crap (which I'm not at
> all convinced about being correct itself), but this doesn't actually fix
> anything, all you need is a single instruction window to wreck things.
>=20
> Because as stated, the whole premise is that the hypervisor is out to
> get you, you must not leave it room to wiggle. As is, this is security
> through prayer, and we don't do that.
>=20
> In short; I really want a solid proof that what you propose to implement
> is correct and not wishful thinking.

Fair enough.  We will be sync'ing with the AMD folks to make sure that
one way or another this really will work.

Michael

