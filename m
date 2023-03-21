Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3AA6C38D0
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 19:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjCUSBq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 14:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjCUSB3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 14:01:29 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020021.outbound.protection.outlook.com [52.101.61.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21779244BB;
        Tue, 21 Mar 2023 11:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoPnXBGxF8YlCsG38zwq7mXgD4AqmCI/u967KLbzAGAm9hCJr4O1JWbpCD07XoTTzTn/J9TxeDCB5w1nVNYrW49HJe43tvuV8Bw21jB91PcCQCoPVY9di68KNInIxgbg8JpJQdlFSzU70piTy7wzXxOerbjdNXRFsdeTwGRN+4D9p/VIaETgPZa6eaQNpSQYqpjYDafy+2GdQsNj5zsI7Cvs/YRbOowe0JiYxY3F+Z4Q7HZefs9N0lDAGH13+iha3V4YQjnSUJr2vuQ+T1GQK6l/rVq0tNuVuRMTvQeIxxtO87TEQznwx4qF7HREJhUOp3S7Wajp8BIpZui2FE7GlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLYlvb3tpdPBXs7zQJMlujmD25fUktAsHFiCiTGT+Ow=;
 b=dTbtsMfNQHYzwB7tZj0Pc2k+T0biAdYmTToyg4Gpc8luNB8x837dWxOb38FU5MmTc9/O8OUD1q3yA3wyXjCQOJ9GTWkv/NaQadytoVNkvht0lW5BVoxkVpV9M4b7FPq11Z3mTddnc8DdDsOLC7RaJfpV6nsQEEmd5YEkwlp27xiHeAt175/hTlMby/1bQZa5jRIsfzpHxY/xY76SqfOOIppzcKxZvlXywFEAHjPJJXoD07dWmbnnXriiSpSkT2laZU0FRTc9q7OXeb7dFfVSqZbaBCI7fouwyB+Jvvb6bk8skSMIipRQSEhXP4KkXT3sr/M4lXVUyY158qC09qR2oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLYlvb3tpdPBXs7zQJMlujmD25fUktAsHFiCiTGT+Ow=;
 b=XCNtm9+u5V8HVICxDNgmKLMR7NlQmcm7/YI5IftFGjdOHfOD0Sfjx3rE/OitJ7FJu35xukc31a1/QZa+TIb4ekzygK4x8oYBLBCNrwu90guXRtVOUvrL8Os4hfS9EVhC4EOdszE10gu+SnR3FeJ23i3j9onpyJkTWKjudrXOslE=
Received: from DS7PR21MB3127.namprd21.prod.outlook.com (2603:10b6:8:77::16) by
 IA0PR21MB4004.namprd21.prod.outlook.com (2603:10b6:208:483::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.3; Tue, 21 Mar 2023 18:01:25 +0000
Received: from DS7PR21MB3127.namprd21.prod.outlook.com
 ([fe80::e9c6:93c6:abb9:c2a4]) by DS7PR21MB3127.namprd21.prod.outlook.com
 ([fe80::e9c6:93c6:abb9:c2a4%6]) with mapi id 15.20.6254.001; Tue, 21 Mar 2023
 18:01:25 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Saurabh Singh Sengar <ssengar@linux.microsoft.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [EXTERNAL] RE: [PATCH v2 2/2] x86/hyperv: VTL support for Hyper-V
Thread-Topic: [EXTERNAL] RE: [PATCH v2 2/2] x86/hyperv: VTL support for
 Hyper-V
Thread-Index: AQHZVc2QXZ33ZRlfGU2JPNSvGGsDh675Al3wgAxcG4CAAC5+AA==
Date:   Tue, 21 Mar 2023 18:01:25 +0000
Message-ID: <DS7PR21MB312782CFB728409A243EA8DFA0819@DS7PR21MB3127.namprd21.prod.outlook.com>
References: <1678386957-18016-1-git-send-email-ssengar@linux.microsoft.com>
 <1678386957-18016-3-git-send-email-ssengar@linux.microsoft.com>
 <87a60gww0h.fsf@redhat.com>
 <20230313170210.GA4354@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <DS7PR21MB3127E3FBE1ABB368C6CBC097A0B99@DS7PR21MB3127.namprd21.prod.outlook.com>
 <87bkkmupcq.fsf@redhat.com>
In-Reply-To: <87bkkmupcq.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=71449230-85c6-4b2f-9147-0ccdf9c59486;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-21T17:40:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR21MB3127:EE_|IA0PR21MB4004:EE_
x-ms-office365-filtering-correlation-id: f98b6e97-83b3-4bdd-e124-08db2a364963
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9dJg7/v95SrG0U1LfPaiD1l58iOfKGuwa0YrPGC3O1ClkG4KmJBTcgMG27+uaFH2Kw6j6usmMk6ee829kbf/OKIZ/U9WtDrRN4iktYnoz2mKANc4waRLACtk5nCGGUVuyRRqI3eZeCe8pmXPfbi7zbvSIw+zgJ/u5+og666Asts1fjGXIDCRADWBA7dgjwfQX1V4DJDM5IYjQoXY+hwOzpk1YzxboSpfdD7ZSnwNvIMwoShUe+A+xzPYPC2KstoLca/RwBtIKb1gOGtDWR8bi7b16nzHORTGHr0o7p8MOkUfqUbekpDyGXO5+l+/AOFo/03DL6seVJSjkEARbeQspUphPpJq+RDSFDPLxsCm3PqgGXiIZvrDeQ/Gg01/13KNibRZvVsRt6ShQS6Smu1ILabhFK8OVV04gXly2/Q4Es3TpHJV1ikREYYj2wIVki6MjtClEaOCfEqjGbC9rztTqPp9nlWTp9lAyTW6Dq1LiGUKQDRygT92WxblsAjLjw7ISQHA04O83J+KtGe/N+Ie9lh/j3kvfKXoZhH0yL3QM7yfAnPojj43s3Vbp2LdkY5L48Xc3z80B+8Wx9kbRV1g4faysVtXRIa+El3/if4WTbPBoRUVSinFHa5X9YW2CuiJ+KCzPIHNSBH+a6PZ2EF6azpr4RK2/BUi47QyJoclWnXIa88CIArCNPId/vpRj/e4TdF35G1PHi6E4g9oKQLwKHhS7GsGNh3dIbYVRKbtTV5rE5x6nfZxjHW9aQ0M/QsL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR21MB3127.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199018)(83380400001)(71200400001)(8990500004)(186003)(53546011)(38070700005)(9686003)(122000001)(82950400001)(64756008)(82960400001)(6506007)(38100700002)(41300700001)(66446008)(8676002)(76116006)(66946007)(33656002)(66476007)(66556008)(4326008)(52536014)(5660300002)(8936002)(7416002)(316002)(7696005)(2906002)(55016003)(110136005)(86362001)(478600001)(10290500003)(54906003)(66899018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?znaJOySAQSoJyLHkcEM98ZETIsHXNF6rAfgNjVh4jKgU3lNBs6bypKqA8HrE?=
 =?us-ascii?Q?OZOqk4bfMO9mCnsgOotPN/hdn1MUCWBL3LIj0h5Nwa9OJJR2RuCM97LV6tUA?=
 =?us-ascii?Q?QCEI2SR3FuENb3cZisJ1Dt3w9N/AAdlDyELTOXGHfLfZ5f6dN381vc7ozK1v?=
 =?us-ascii?Q?djiXT2MsOM2z6iUec0ieaHW3+24At4Z2//VPnAfmbTg4iVZYncqYl9soNqMP?=
 =?us-ascii?Q?YDFLybuOvo9a7d9nLwCYxP9O2LTUrd89EV5mDverwFnZWd2GU+SEnaYSL5Cg?=
 =?us-ascii?Q?lS7r5OcQTV8rUI3Z81nrGeQhyI21b2LdIFyNBPSkWiuZ4t/mwqTcJMedPV0x?=
 =?us-ascii?Q?FTaOzp1Xr4A8wr5zcYI+X/0a+sllVunXcPluiIhHGiN0CKsyN44rxjIeWmk8?=
 =?us-ascii?Q?Sko+2fDu5CQxTEB2c9dqN3XjIKMt1sQPRzap5q4M+X5RWIUxYqqgCagefYws?=
 =?us-ascii?Q?F5aBdNHT4nSCMPDika/mTQq27H9sVGQKy6g+d6dmIItr4aln33YkFLAq8AmN?=
 =?us-ascii?Q?HsOmdResamnnfS4aAeSV86l4yPnBvJ88HGaV0Ow9GWvBF9m+nIjXrT700BQ6?=
 =?us-ascii?Q?9wrQWDvq7wu+Ik0UZrqaF5BK6yjqyqy/NPFQpRbTWwmryehgbyK0jpzEdHw3?=
 =?us-ascii?Q?HuiwNP00X6HmCpVYteONEb7pwP8fWGP7th6cGthEunZ3lc/eWxLnYw81ykIC?=
 =?us-ascii?Q?jsNaP4FloUdbV2fFJE+ko28IKIZ6Uczvp8DfMFIHx+7pgGKZJhB0yXM6dZ7/?=
 =?us-ascii?Q?If1bd8wRnEYKFbdtrYMenqM5XBEMREi0kKsT+3JKczClVISrJmTqM8dzbeUG?=
 =?us-ascii?Q?Sa+Z2RpMu7A/9H20NqIeihBxGwUgGOu4mgfGEGFF2YltmEQMYpPsgEm5Dwug?=
 =?us-ascii?Q?Wcotq2dJZIyifx1fzsjhQdDhu+wF6TR+HIWEd4sfRJ7I/S1LKFWRqzzAuSv3?=
 =?us-ascii?Q?bapgEvsJcrxNhrCqUGvkQXyQyie3eVnrpkRYfBuWoEEsPUxPOVnaHXG7m39/?=
 =?us-ascii?Q?djwaCiU5dPGXUNVLc5lb2/4cTTiFLrUNy9/+ewTX08s76D5y5GU8F4qXX8sc?=
 =?us-ascii?Q?8GRA2++hzlNrcpqhXZSoE0AhVD/kXFfBqfRm/vLTSqFCXctPi/QJvYlHr+Pe?=
 =?us-ascii?Q?FDBg/tn/fDS2m23H5yrBgy42yk+1C3gUkzawTqdUWbqIYRLDcEOqIcd8YlA0?=
 =?us-ascii?Q?40cCKaQFwnqeqz7UbWpTKl1k51WdvwHekXnqHPAd36/6uyV5bUoJw+coteGW?=
 =?us-ascii?Q?6iSEaVDxJAJpUXh2mEUWPGdvvOW7FUnVD9jXeAkbOi8VS9RfqcAJPudSlsND?=
 =?us-ascii?Q?SlpnYKSuWOktyxhqfbdwWwjHyHAKm3wuoiZtwjcRO4yn3LsTKlcx+Khd2okx?=
 =?us-ascii?Q?ccp2fNXsNvg/WSI2/FTsLnArBK0lxCO3C3rEI0RPiDaqrCK0mAjg2q8+odJp?=
 =?us-ascii?Q?F/COWUIL/kHw74mVSeOaLEDOKfaAOkdUP1cc8VNyQYiCfxJQ01d7UBxg7BjP?=
 =?us-ascii?Q?v8Ec5ko4glgnz1I9SGpBSO8gtP8uU0Ifj+yCd0tza+uheN/O3deo8h39niwt?=
 =?us-ascii?Q?5sy9KPgJl/Dar7DRZfFQdLKfsOJsMnqInlHYydMZ3EavnhwL55IRGT5elSHm?=
 =?us-ascii?Q?TvZZYwgraeOxp/hD/D5Z9dilNdCrcdU58oLhmfVadmoo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR21MB3127.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98b6e97-83b3-4bdd-e124-08db2a364963
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 18:01:25.0893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 81hxeoXUhL0j/uTisUusIMpRQJKY6Sv5NSkoxaFE3gQcvg92WXU9J6IITDzPV3I8yafRZNxDu/mjIzkR2mp2ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR21MB4004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org




> -----Original Message-----
> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Tuesday, March 21, 2023 7:54 AM
> To: KY Srinivasan <kys@microsoft.com>; Saurabh Singh Sengar
> <ssengar@linux.microsoft.com>
> Cc: tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
> dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; arnd@arndb.de; Tianyu Lan
> <Tianyu.Lan@microsoft.com>; Michael Kelley (LINUX)
> <mikelley@microsoft.com>; linux-kernel@vger.kernel.org; linux-
> hyperv@vger.kernel.org; linux-arch@vger.kernel.org
> Subject: [EXTERNAL] RE: [PATCH v2 2/2] x86/hyperv: VTL support for Hyper-=
V
>=20
> KY Srinivasan <kys@microsoft.com> writes:
>=20
> >> -----Original Message-----
> >> From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
> >> Sent: Monday, March 13, 2023 10:02 AM
> >> To: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> Cc: tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
> >> dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com; KY
> >> Srinivasan <kys@microsoft.com>; Haiyang Zhang
> >> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> >> <decui@microsoft.com>; arnd@arndb.de; Tianyu Lan
> >> <Tianyu.Lan@microsoft.com>; Michael Kelley (LINUX)
> >> <mikelley@microsoft.com>; linux-kernel@vger.kernel.org; linux-
> >> hyperv@vger.kernel.org; linux-arch@vger.kernel.org
> >> Subject: Re: [PATCH v2 2/2] x86/hyperv: VTL support for Hyper-V
> >>
> >> On Mon, Mar 13, 2023 at 03:45:02PM +0100, Vitaly Kuznetsov wrote:
> >> > Saurabh Sengar <ssengar@linux.microsoft.com> writes:
> >> >
>=20
> ...
>=20
> >> > > +config HYPERV_VTL
> >> > > +	bool "Enable VTL"
> >> > > +	depends on X86_64 && HYPERV
> >> > > +	default n
> >> > > +	help
> >> > > +	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities =
and
> >> > > +	  enlightenments offered to host and guest partitions which enab=
les
> >> > > +	  the creation and management of new security boundaries within
> >> > > +	  operating system software.
> >> > > +
> >> > > +	  VSM achieves and maintains isolation through Virtual Trust Lev=
els
> >> > > +	  (VTLs). Virtual Trust Levels are hierarchical, with higher lev=
els
> >> > > +	  being more privileged than lower levels. VTL0 is the least pri=
vileged
> >> > > +	  level, and currently only other level supported is VTL2.
> >> > > +
> >> > > +	  Select this option to build a Linux kernel to run at a VTL oth=
er than
> >> > > +	  the normal VTL 0, which currently is only VTL 2.  This option
> >> > > +	  initializes the x86 platform for VTL 2, and adds the ability t=
o boot
> >> > > +	  secondary CPUs directly into 64-bit context as required for VT=
Ls other
> >> > > +	  than 0.  A kernel built with this option must run at VTL 2, an=
d will
> >> > > +	  not run as a normal guest.
> >> >
> >> > This is quite unfortunate, is there a way to detect which VTL the
> >> > guest is running at and change the behavior dynamically?
> >>
> >> Only way to detect VTL is via hypercall. However hypercalls are not
> >> available this early in boot sequence.
> >
> > Vitaly, we looked at all the options and we felt this detection did
> > not have to be dynamic and could well be a compile time option. Think
> > of this kernel as a Linux based Trusted Execution Environment that only=
 runs
> in the Virtual Trust Level surfaced by Hyper-V with limited hardware expo=
sed to
> this environment.
>=20
> I understand kernels placed in other VTLs serve very specific purposes so=
 likely
> there is no need to run standard kernels shipped with various Linux
> distributions there in production. It may still come handy to have such o=
ption if
> only for debugging/testing purposes. The way it is designed now,
> CONFIG_HYPERV_VTL will always end up disabled in anything but your custom
> builds for VTLs (as such builds won't boot anywhere else).
>=20
> Doing a hypercall in early boot may not be trivial now but should be poss=
ible. It
> would be even better if current VTL would be exposed somewhere in CPUID b=
y
> the hypervisor.
>=20
> Just a suggestion.

Thanks Vitaly and I hear your concern. The VTL environment is so different =
and so constrained,
that paying the cost of a run-time detection we felt did not buy us anythin=
g. We did discuss the CPUID option as the most
efficient form of run-time detection and the hypervisor team had some issue=
s with this option and so we went with the
compile time option.

Regards,

K. Y

