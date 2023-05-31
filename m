Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6F1718553
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 16:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjEaOu6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 10:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjEaOu4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 10:50:56 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020016.outbound.protection.outlook.com [52.101.61.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3E298;
        Wed, 31 May 2023 07:50:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFkjuq3fSWhRKrysGhZK5OBMhwYPLTaZ5BLajU9gHCqrkVnprPm/h4nTUhcYnhNAwwIuWnLzc4XmRKZGZoIKMPQNzfaVoKvSW3DAvLcjDZUQ/ko9Itl41MsNksQHOH4UxMb7xd+H0KP8X7uY0YsIHnedBsQ8GJOSO5bur5z+xnKE2lk03wa1V1zVdaMIzlepOavfCve+X1KXtZtRv0+65JNSRVa5HRxREdCB0rTQxbm1xZPltMD413UWDfOCyOJQ/DrIBaTHSWx7dFNzKi1Q3uJpLpYUPDawnoME5DBYIJI4vljR2e3jupSvI4pPoZtcwWUvpe8G4LAb66mZ7e8FIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZvrl34tbNuQPhTF1vk5t5MTt4/Eru8O2rYl6ialTnQ=;
 b=W/XhxMUQ/FnikZYxXrT6mu6DeqWkB29RtLl2f+Eak/MddmOS4Hs1PFNngDFEgFqrKHYwe1x4Uq2T2tocQTbc+rRVeJeX/tPsG+IeZiDPAu7GzQJfeavEp26+3tvcqdrt89iiqIMmXfiGXJb4iKYPd+EhSH8RBB0UcRQdUfxD4Kf4kEoCk9bC2AnKy0sMhAMxYQejjgfVcCfkMU49hslhC3LDxr11CyyybY0MEjbx6nAZ1Ed2utNF8pC0BQRu/XvuENcA2lGlYom4PNZsZeZQUrU+RFLCjBWy+wo5htQr1zsMB2jaenkDrL2Dt/C7cFE9eTRLXCGVT7m47fTfy65q8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZvrl34tbNuQPhTF1vk5t5MTt4/Eru8O2rYl6ialTnQ=;
 b=RTE3Ko5X2cEfW20MEWB4gJXNEXnEQ1sJxYy8YXI/2AWgU1vuw/3B5O0VOB10Kb+/NtPZ2Kw96t6b37qTZDjGrieNN+k60OwyFSTWULZPC0hmHvVJq2i5c3sF3Ty93Ib8d7AfP/VK1VuoX2voCdkHf5R0t+4b/TO/ckRO516/GWg=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BL1PR21MB3232.namprd21.prod.outlook.com (2603:10b6:208:398::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.4; Wed, 31 May
 2023 14:50:51 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::5fb5:15a9:511d:21c9]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::5fb5:15a9:511d:21c9%4]) with mapi id 15.20.6477.004; Wed, 31 May 2023
 14:50:51 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Tianyu Lan <ltykernel@gmail.com>
CC:     "luto@kernel.org" <luto@kernel.org>,
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
Thread-Index: AQHZh06i+lag61PbVEa3Lx5CXtmZu69cpAiAgAGY2YCAADYygIAWGHuQ
Date:   Wed, 31 May 2023 14:50:50 +0000
Message-ID: <BYAPR21MB16887196D3DFFCB52EAC546AD748A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230515165917.1306922-1-ltykernel@gmail.com>
 <20230515165917.1306922-3-ltykernel@gmail.com>
 <20230516093225.GD2587705@hirez.programming.kicks-ass.net>
 <851f6305-2145-d756-91e3-55ab89bfcd42@gmail.com>
 <20230517130943.GE2665450@hirez.programming.kicks-ass.net>
In-Reply-To: <20230517130943.GE2665450@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7af44323-f158-497c-9e56-8b2e8b686b3e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-31T14:35:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BL1PR21MB3232:EE_
x-ms-office365-filtering-correlation-id: 394999eb-2383-48b6-0ed4-08db61e66d68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x/7NGye/BsjAT34Wga6ih4FF18OpxkUszpv2eGsF2jmfK79Gq26qB5913ZW8esW8PHLAK/+uctaRn6JUvFBEz1vBDxK8CCcCUxdRq7/dFSrvFQ1GMICR+LMxBfsDGCamU0+SQW4tQ6x00XgHQuyhC3HazLK1RPNBfjF1/ip52XS/Md/4nVKhbeFPdtr6YZqO7c2osV5VVF75uIGLbYfnGos8CFd1jaNC4kfBOri4kMKW2fODCdeFwk+z0K8Ew4mw0FCaspz5dCUucNrkUs/Vr6ixKtlIHcS0w4Ja3vMydMcKZz4GGz3PkaS6y/8AoiDK0uJ6IrgmLzDMD0V+s+AKJQdh7b7xwGEVz23W8NlV9wD7NNacwQpQMZ5bfC1yWUDTF/2GqRK4OM07kkJzfgNRXhCZiWJUQhtEM2n7tb3CbDp0KMakh+PYA8+gkJqwWZB90dMIldfmymqTR70MPMSjXI1jSVaS199fw52pyXA9ug26XkELfLO+/DKLPcZNorOkBVnYKui96ILGhkmujYXcFp9lqNXMIUXWzZwHcut22s5ErcLqCRB1v2KgeUa1srt3XuREkvtHcYso0tnVMaNFUeztoR9wpiTEN9E93rbEuVQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(186003)(26005)(7696005)(33656002)(53546011)(6506007)(9686003)(786003)(316002)(71200400001)(2906002)(55016003)(7406005)(5660300002)(52536014)(41300700001)(8936002)(7416002)(8676002)(966005)(10290500003)(82950400001)(86362001)(82960400001)(122000001)(38100700002)(110136005)(8990500004)(4326008)(478600001)(54906003)(38070700005)(64756008)(76116006)(66946007)(66556008)(83380400001)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qvzKxuST0NCe/SeLbkI5uSMzKDr91jAB9wt0v+2ZN2u4nfs1h8GyHniNq+xT?=
 =?us-ascii?Q?iTuv5cKJttDtXLO/sIQwadmlNu6EE3/U9Q++4XuW3NSHw4c7JEvmWbhLmHFo?=
 =?us-ascii?Q?bOP3tjZwD9BdDT4irV2Edneg3BIpWIifuFmBSgrO0sXsDKzExicCmmN3cuHA?=
 =?us-ascii?Q?d5D0pmH2J8N4bdMd0TaUUcz92ToZqR6oXPkDDt5ZPQJO91MIJaOHfcOMLMFP?=
 =?us-ascii?Q?3iGjbYJIUsvTNB2jPTqF22fl6NAXPuLUePuU1O7ljanZAZL1Xvu4P8P2n9hy?=
 =?us-ascii?Q?vjkSdRJP8FgROHZBNRVa/xhzrOzvokuKSzw5IhMQrA/tshoW8ESSjOthSXFG?=
 =?us-ascii?Q?Vii2CBtwOx3wurQpqSASR4sRsfVsVFANWmCJ/eCHcUzZgNQHXct7fn3M9b5p?=
 =?us-ascii?Q?mgQRb9yZZdHelHtx0wBsKFABEcSKTM29NH3/uOPDm5QRrt3H+1ZWccZ5BvI/?=
 =?us-ascii?Q?Mqha37e7KnFhUnoAmB0ZoXn10w3DBQopRe1RslzhcZijs3N5bgxL8cNbM8fH?=
 =?us-ascii?Q?hAcAVtB4F7Ua03qg3X3HPpKnKEGbxTlr5kiLkrqcIkfhk4uqCuqJAifNLPQY?=
 =?us-ascii?Q?gvt7uedOKVnR0gJO9H/n4z5fsOL2uCe1rgXjCA0xtMBYM3vLZf5/v/FRk633?=
 =?us-ascii?Q?6R0289Eb5FF7ywRdBrYnM1Vtp7LfvzhEdX4pAH4p3aPw3PprEQHvrQp5SEwH?=
 =?us-ascii?Q?GOxDmKUZD1bj3LULl5bDuPz9UGWXGSNU02xrsZyeHPnNuml7BxKI37HU0kjN?=
 =?us-ascii?Q?jVkkQb0dtEvoVNwJyO+LIqCxx2Np3cC1Dxj+Sdpb4biLiEv4RksLHUQpsOA/?=
 =?us-ascii?Q?1Se81JcnlEO5VMR1Qj9pq1KFjd+xL1nN9FIl79CEYJT45XZMH7F+9fYOoeI5?=
 =?us-ascii?Q?FgLUQPqrZZqKiG41AK/COQdCikaSeASt/rDICdmJbm4zQ2tDhqWDcnhGnazs?=
 =?us-ascii?Q?f00ufazxITwpvdQEJTA3Lfgch0uqnhtquDQBmv+Wv9nSGiHQ4mo4rK06HOCm?=
 =?us-ascii?Q?q2u2M8Ha9mVkdbBrwL6wRo3W75jGObiO3f46s2leW6TZxTxXV4Y2KWUrozqo?=
 =?us-ascii?Q?SCzZVzZMhHlOV+fjPCNy2GsDr9o4xciz/xkx50ULHdBSw0Ma5Vec2c6YeYe2?=
 =?us-ascii?Q?IwSVDl6X/IuOoJNiFOMUt63/oGO10mBQpYNOWMvpqEvvri3xaWslWjaYa8aK?=
 =?us-ascii?Q?lDMjqcGFMpFbjWHEv03jxoxlTejGzVa+fVSFJgVnpivskmTPTJQ9OMKXvt5b?=
 =?us-ascii?Q?qf6T0ZXowntKSXumHpnHSeSELGOQ4eBE0NiUFKdMuCohJE4tPanIrxHEzqwE?=
 =?us-ascii?Q?iff/oHcsIPh/uWNK2TrVBbjqvYqohm7sHUANmv6l1LzYc08KMQl1TpcAnc/O?=
 =?us-ascii?Q?xhIgd/mDaWsIQE4qRzNjh3aRXdyzdSzRlV1bpLQghCWXcSu8aTPgMknTmFAd?=
 =?us-ascii?Q?p0x3FDPxYsSlRu4naeDn2qV7Ifp5Knn4t4RPH31Q9joSzpDJ6a0cYC3GmUne?=
 =?us-ascii?Q?ojDYV+iBCCq0kROTmEjgwLIG1ErKCepXvboP2vEYb2u5nBktE09y9v+NjWuM?=
 =?us-ascii?Q?TL9b7B+qq0EcIdHHsCOfEQsZMT5IEd1siM2u1KUuvEAZSSkh238jPevsqiCH?=
 =?us-ascii?Q?fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394999eb-2383-48b6-0ed4-08db61e66d68
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 14:50:50.8694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w78x4JIrkQ0gw2X8SFAMQHDs9/u9iif9dMx86VbFW3hACsY1wjFu3ZJ2u+5qIvseM6DZvQRlU3grpTqD0ZbtW09X/rRAP2eu7WBvXdv/Hjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3232
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org> Sent: Wednesday, May 17, 2023 6=
:10 AM
>=20
> On Wed, May 17, 2023 at 05:55:45PM +0800, Tianyu Lan wrote:
> > On 5/16/2023 5:32 PM, Peter Zijlstra wrote:
> > > > --- a/arch/x86/entry/entry_64.S
> > > > +++ b/arch/x86/entry/entry_64.S
> > > > @@ -1019,6 +1019,15 @@ SYM_CODE_END(paranoid_entry)
> > > >    * R15 - old SPEC_CTRL
> > > >    */
> > > >   SYM_CODE_START_LOCAL(paranoid_exit)
> > > > +#ifdef CONFIG_AMD_MEM_ENCRYPT
> > > > +	/*
> > > > +	 * If a #HV was delivered during execution and interrupts were
> > > > +	 * disabled, then check if it can be handled before the iret
> > > > +	 * (which may re-enable interrupts).
> > > > +	 */
> > > > +	mov     %rsp, %rdi
> > > > +	call    check_hv_pending
> > > > +#endif
> > > >   	UNWIND_HINT_REGS
> > > >   	/*
> > > > @@ -1143,6 +1152,15 @@ SYM_CODE_START(error_entry)
> > > >   SYM_CODE_END(error_entry)
> > > >   SYM_CODE_START_LOCAL(error_return)
> > > > +#ifdef CONFIG_AMD_MEM_ENCRYPT
> > > > +	/*
> > > > +	 * If a #HV was delivered during execution and interrupts were
> > > > +	 * disabled, then check if it can be handled before the iret
> > > > +	 * (which may re-enable interrupts).
> > > > +	 */
> > > > +	mov     %rsp, %rdi
> > > > +	call    check_hv_pending
> > > > +#endif
> > > >   	UNWIND_HINT_REGS
> > > >   	DEBUG_ENTRY_ASSERT_IRQS_OFF
> > > >   	testb	$3, CS(%rsp)
> > > Oh hell no... do now you're adding unconditional calls to every singl=
e
> > > interrupt and nmi exit path, with the grand total of 0 justification.
> > >
> >
> > Sorry to Add check inside of check_hv_pending(). Will move the check be=
fore
> > calling check_hv_pending() in the next version. Thanks.
>=20
> You will also explain, in the Changelog, in excruciating detail, *WHY*
> any of this is required.
>=20
> Any additional code in these paths that are only required for some
> random hypervisor had better proof that they are absolutely required and
> no alternative solution exists and have no performance impact on normal
> users.
>=20
> If this is due to Hyper-V design idiocies over something fundamentally
> required by the hardware design you'll get a NAK.

I'm jumping in to answer some of the basic questions here.  Yesterday,
there was a discussion about nested #HV exceptions, so maybe some of
this is already understood, but let me recap at a higher level, provide som=
e
references, and suggest the path forward.

This code and some of the other patches in this series are for handling the
#HV exception that is introduced by the Restricted Interrupt Injection
feature of the SEV-SNP architecture.  See Section 15.36.16 of [1], and
Section 5 of [2].   There's also an AMD presentation from LPC last fall [3]=
.

Hyper-V requires that the guest implement Restricted Interrupt Injection
to handle the case of a compromised hypervisor injecting an exception
(and forcing the running of that exception handler), even when it should
be disallowed by guest state. For example, the hypervisor could inject an
interrupt while the guest has interrupts disabled.  In time, presumably oth=
er
hypervisors like KVM will at least have an option where they expect SEV-SNP
guests to implement Restricted Interrupt Injection functionality, so it's
not Hyper-V specific.

Naming the new exception as #HV and use of "hv" as the Linux prefix
for related functions and variable names is a bit unfortunate.  It
conflicts with the existing use of the "hv" prefix to denote Hyper-V
specific code in the Linux kernel, and at first glance makes this code
look like it is Hyper-V specific code. Maybe we can choose a different
prefix ("hvex"?) for this #HV exception related code to avoid that
"first glance" confusion.

I've talked with Tianyu offline, and he will do the following:

1) Split this patch set into two patch sets.  The first patch set is Hyper-=
V
specific code for managing communication pages that must be shared
between the guest and Hyper-V, for starting APs, etc.  The second patch
set will be only the Restricted Interrupt Injection and #HV code.

2) For the Restricted Interrupt Injection code, Tianyu will look at
how to absolutely minimize the impact in the hot code paths,
particularly when SEV-SNP is not active.  Hopefully the impact can
be a couple of instructions at most, or even less with the use of
other existing kernel techniques.  He'll look at the other things you've
commented on and get the code into a better state.  I'll work with
him on writing commit messages and comments that explain what's
going on.

Michael

[1] https://www.amd.com/system/files/TechDocs/24593.pdf=20
[2] https://www.amd.com/system/files/TechDocs/56421-guest-hypervisor-commun=
ication-block-standardization.pdf
[3] https://lpc.events/event/16/contributions/1321/attachments/965/1886/SNP=
_Interrupt_Security.pptx=20
