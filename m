Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC49784FA4
	for <lists+linux-arch@lfdr.de>; Wed, 23 Aug 2023 06:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjHWEbD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Aug 2023 00:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjHWEbD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Aug 2023 00:31:03 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020018.outbound.protection.outlook.com [52.101.61.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B695DCE8;
        Tue, 22 Aug 2023 21:31:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlPiONZr3pSfiY3h1ucLwj+/7L88H/GgVAi2IjcEYksCxFd7xqj2TAYEC6cT1Vxg7LDPRwPmG+f9NiBmt0196SrwYYqSr4aPd5ILwr+tB2c3sLl5Y2ac4/XxpC3r+yv602zZwUjode9V2fg4grrI3l9Ef7b4GchVkQNXAnIaORoont5K9ycfu+BI+ZenN9Duv2hgWx3wv1mwj7zwRKFL/RvwsuCdAFtbOIrMMvpspMQNfAK/MpqWIal1KasHb6S5rg0Qg2SJR4/amDCQiAe5X+5O1ByhZHkZ3r4Iur22fhkioZJeJprVNIh3da8CMHnBfZXClAxETGY5GTFKo8t9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGF0pf2WgCv0WNFniw9FZyijozfsmxP09znavnHROzU=;
 b=TNSFS8zsT9P2zKnFtlg3izyKmtL9cifvu4i63vBZ9D62aB6ofvjdhPFYpM/3taVjO8jzNTPPPMSc9gp+AzmVDjYOm3QycAXuUIKuxtl61A/MEX5XuChBo/OpWkcWGSl/wZ3yEuBnTxGpEKUxoM21gWGSvoymvZOVA04rPUrs8x8Fwn79B5VXGa3njNmAsiN6bZXEsOmFpIJJPLGgt3OjLaET9YCFFe37Ti+hPrdfDx2Uabo7HI0F1TaVzqZKCStS8Tct9bJsI5IWSlEkW+10YhumGNdCgv/HT5ii5QdwLxajMmuE0VizsZ77yQfQqZKzgNDwlnYg3istpur1ayQ+iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGF0pf2WgCv0WNFniw9FZyijozfsmxP09znavnHROzU=;
 b=e2fSKbppNh3r/IGW70E75/rw+KRYiqk4598UxdjfFjDFeh/g8bwwt8gBNgGxSb9uRiqXXcL8OW1Hy9gQOpRePF+PRw2pvyYn1tpOnuOZyXALZfZ1hmnD77uctcRMqgbmn6BYk6jCq+LUBjFfdOxQEemRqAekUw9reuxAwRolsQ4=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by IA1PR21MB3736.namprd21.prod.outlook.com (2603:10b6:208:3e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.4; Wed, 23 Aug
 2023 04:30:56 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%5]) with mapi id 15.20.6745.001; Wed, 23 Aug 2023
 04:30:55 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
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
        "wei.liu@kernel.org" <wei.liu@kernel.org>, jason <jason@zx2c4.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        Anthony Davis <andavis@redhat.com>,
        Mark Heslin <mheslin@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "xiaoyao.li@intel.com" <xiaoyao.li@intel.com>
Subject: RE: [PATCH v2 8/9] x86/hyperv: Use TDX GHCI to access some MSRs in a
 TDX VM with the paravisor
Thread-Topic: [PATCH v2 8/9] x86/hyperv: Use TDX GHCI to access some MSRs in a
 TDX VM with the paravisor
Thread-Index: AQHZ06TZ7YXLEavaqkmDqsXoOiDf4q/04rIggAIGf+A=
Date:   Wed, 23 Aug 2023 04:30:55 +0000
Message-ID: <SA1PR21MB13354314F55F178602183650BF1CA@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230820202715.29006-1-decui@microsoft.com>
 <20230820202715.29006-9-decui@microsoft.com>
 <BYAPR21MB168893DB3BC5D579281275E9D71EA@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB168893DB3BC5D579281275E9D71EA@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b9a46b56-4213-4bc0-9a19-b314d6479c17;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-21T15:34:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|IA1PR21MB3736:EE_
x-ms-office365-filtering-correlation-id: 39714c0f-2d2a-4be6-b799-08dba391bdd5
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PC0ZBZZ2ZXOY77uHmqrtGdpAxTU/0/8GTT2PeHQZVXLFXeYdgcTQr69O+7C2lIgwQR+4WRdzn7jtXZpZO2bDTQoBteAhNkxLb5D+CgZiUfJfjFMmHt8bkhpS1L3sKrkOkuV14mJqLPzlVznQnabd30IYRzC2yJ/yK48NiGHghp1s+580dKEecu2PFq6xaXbfVbWFBD9I9drAXgDgpkAPx89XuAPYakqClBcTmEPJFgX60sw5OKMu1+ki5H9+PS+YIrQVHkMsIlER00SsAmIIDNg2qFk5o5rM6EjZLWAM0LTuOTRM7+/1dQ6NAoW0fJC4atJBbfTCnaHhMEfBXs5Slmd2hr/n152SdFrZKeytj8Hj8GnAneSnqExSobgfIkgvdSONee1zOX5f+OQTt1S1a7G4IvJwO8UCnXmymTaTQPHKmcmMS2JnU+2YZ8iGsw+5G+HlPwF01HNXnWfIqCDqCwdME/FmXhl4P/WkUVF/8TeZiV/vhv9/09PKTZs4iGyIZ3BEn3hIeNNzF+DjzQUoRfnsW+Lsiz34UCqtMdoQSpqYRSjBc1oNfSIz+NX3t1XvmjPjXRlsA37AY6sk/zXgmsK3175MoqprASqVeQMrHy74ESkVLu5tOYfvk1ttKOST2WTlYSNOb6+XGRQE/unH+k21ZpkE3ru9kzEaMtF6jEAEn81FrX5/yjbDlJuZCUu6IB5O54YXVpMskhDMDk1ljQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(186009)(1800799009)(451199024)(12101799020)(71200400001)(7696005)(4326008)(6506007)(33656002)(82950400001)(55016003)(86362001)(38100700002)(82960400001)(38070700005)(9686003)(122000001)(921005)(83380400001)(2906002)(26005)(10290500003)(478600001)(76116006)(5660300002)(66946007)(66446008)(52536014)(8676002)(66476007)(966005)(66556008)(41300700001)(8936002)(7416002)(7406005)(64756008)(110136005)(316002)(54906003)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lbNKLMC5bXzE16BBV99U5V6D0APoVGAYc6QUmaIthSu4HpyysEtTU/24cW+T?=
 =?us-ascii?Q?CyTxWb7V/ct5Kgns1smq+t+Gnn9OtlAtjcFTb/RZE1e7pA+amvDZBXh7yh2r?=
 =?us-ascii?Q?7J+UyJpc37LVOYD2lNeMi6cpXS+L+8JviImsaYzRB/MobMmSLzOo6NFqf31h?=
 =?us-ascii?Q?qOgLIsrNIlLxuMmjqfky9xHjt9jjYuSlglVJwUPFMYsigFOtquJyBzwT32kV?=
 =?us-ascii?Q?kKA5l30s8ZkiZwDf9TtA9GDWd5LsXpouItmd+rWrQEAY9n9Gn9DS0PTILNDR?=
 =?us-ascii?Q?xclCYeV5W3lPpDGcL5v9cde8e/l0m+PwtgjsueFDnbK8aR/mY40nMF0JlFz+?=
 =?us-ascii?Q?SzyE0XwcQbd0RfGtv6bXNDZhIymop6WKHXgh5sw1m2tS2MeiRm9LFTWa7EKh?=
 =?us-ascii?Q?t7tLw0S7bLp3tCkgss2ry6Q4Xe0TMzAbsOeg+7Xngso0c2+vtpxSGKu5UV/R?=
 =?us-ascii?Q?m3XoOx1JlHT1F78UK6wRPq6HLHyAvGMmSBmpW5kaVqWcm1EfvpDddF8hW8rX?=
 =?us-ascii?Q?N1Lg/b11ocyZ/32rKqawUqEshl8U6SJVgR7v0Y3xS2FBQOYnYfa5ZJnk5yTt?=
 =?us-ascii?Q?W1LJBuoSrRyQVq1FlirHTwgU6tE8mjvAXAfOu9BHaWQ6R8asF4tI3r1BOyMs?=
 =?us-ascii?Q?IqI81R2Qz0rMqyGyBbAX2w7Xcapm7l5KyJODTEh/LbLcrm6wcFbEUQuV2z6x?=
 =?us-ascii?Q?aSKG9JB7K7OGcHDYjcRPKJvdDD30pZtwSVTx07VKBw48uYaSIeR20yUwXJSl?=
 =?us-ascii?Q?Ox1w+Ng0xLG6A2sc4Q+I3LHHV7Fqs5glHmO6jL/V4SIpHR6j1wk68Z5Chqf7?=
 =?us-ascii?Q?hiXHlgAhDHi36liS38Ba2O6QSp5mtPkFW+DY8qhiIek/nmiDSue0Rvixyuig?=
 =?us-ascii?Q?3Gxg+23gbhnNrPZ05gMEbMJ63RhTmQMdiSQzdVEm3vXBGeT8VwUySzxXiU1J?=
 =?us-ascii?Q?09N7WY5BHm+Fd2uu6g5GujCj+iBo3xeLH4Tv2UMDq7u5QcM6r6r4BHm7cweL?=
 =?us-ascii?Q?bUjYaiCMuroVA70SsYc6sXH0b6971HTPoH8iLLHUGVp4rdkKQcaiffoQ8OXZ?=
 =?us-ascii?Q?B2SoTF+RskAw6CIftRI2OwP9fFXhWkCUgCGJFicyvpdoofuZOtEgU7878qho?=
 =?us-ascii?Q?4V6OGRUXtKoyebNW4X5pd3dZVxGUUpSht5MPmJrGrs5R+6vwPmITAn19MYLR?=
 =?us-ascii?Q?M552S2iiJANDOpdwCAv4LIBAN+K2kUukl5TgAFRnH6eWOctN/Cig/bXgp0Qh?=
 =?us-ascii?Q?UbBmDQ7TZgIgaMuFe1KfzZU5MYfdws2qxb3LL2keobfFl2PhPEalwXYxybdO?=
 =?us-ascii?Q?Y78+d6yUCWmNKrkXq7AEFWUmNN9XAdnoXrTAuVOE268tPQBk2cZ1dZzwKQMl?=
 =?us-ascii?Q?H5h+Nr/NulBKFKmSKbOttWub5HJ4IMamiYPSpRwGNZ6LI1FGkmVeNyQx/8VS?=
 =?us-ascii?Q?e6N8QDsNux1YtoKriqtyXkGN8+Y+Ov+p5ywdLwDgBBpuru+XUtnIoVxzh4rb?=
 =?us-ascii?Q?fB1drWcXY+nXOyWhN00SCXHBlPG0PKGnmO7U9WnGxf73RUaKeOfliPgTBouj?=
 =?us-ascii?Q?s9tTeZxdxod3ezISwTWjtrj0lcA8uNMtDYMSY55E?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39714c0f-2d2a-4be6-b799-08dba391bdd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 04:30:55.3484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cadTReuTi/qNMPt0mfWMKbf6IdmLMtvX0u5O1JGdgg7wRVN+vWovgrrAvWW5nd1ZEA9+ekjXsi5NpvHSGYoeHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3736
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Monday, August 21, 2023 12:33 PM
> > [...]
> > @@ -186,7 +186,49 @@ bool hv_ghcb_negotiate_protocol(void)
> >  	return true;
> >  }
> >
> > -void hv_ghcb_msr_write(u64 msr, u64 value)
> > +#define EXIT_REASON_MSR_READ		31
> > +#define EXIT_REASON_MSR_WRITE		32
>=20
> These exit reasons are defined in arch/x86/include/uapi/asm/vmx.h.
> Are they conceptually the same thing and should be reused?

There is no VM Exit here, but I think we can use the header file.

I'll add
#include <uapi/asm/vmx.h>
and remove the 2 defines I added in this file.

> > +static void hv_tdx_read_msr(u64 msr, u64 *val)
>=20
> Could you make the function name be
> hv_tdx_msr_read() so it matches hv_ghcb_msr_read()
> and hv_ivm_msr_read()?  :-)

Will do.
I'll also move the new functions around so that the new functions
won't get interleaved among the hv_ghcb_* functions.

I'll remove
EXPORT_SYMBOL_GPL(hv_ivm_msr_write);
EXPORT_SYMBOL_GPL(hv_ivm_msr_read);
because we never really used hv_ghcb_msr_write() and
hv_ghcb_msr_read() in any module.

The changelog is updated accordingly.

> > +{
> > +	struct tdx_hypercall_args args =3D {
> > +		.r10 =3D TDX_HYPERCALL_STANDARD,
> > +		.r11 =3D EXIT_REASON_MSR_READ,
> > +		.r12 =3D msr,
> > +	};
> > +
> > +#ifdef CONFIG_INTEL_TDX_GUEST
> > +	u64 ret =3D __tdx_hypercall_ret(&args);
> > +#else
> > +	u64 ret =3D HV_STATUS_INVALID_PARAMETER;
> > +#endif
> > +
> > +	if (WARN_ONCE(ret, "Failed to emulate MSR read: %lld\n", ret))
> > +		*val =3D 0;
> > +	else
> > +		*val =3D args.r11;
> > +}
> > +
> > +static void hv_tdx_write_msr(u64 msr, u64 val)
>=20
> Same here on the function name.

Will fix.

> >  #ifdef CONFIG_AMD_MEM_ENCRYPT
> > -void hv_ghcb_msr_write(u64 msr, u64 value);
> > -void hv_ghcb_msr_read(u64 msr, u64 *value);
> > +void hv_ivm_msr_write(u64 msr, u64 value);
> > +void hv_ivm_msr_read(u64 msr, u64 *value);
>=20
> These declarations are under CONFIG_AMD_MEM_ENCRYPT, which
> is problematic for TDX if the kernel is built with CONFIG_INTEL_TDX_GUEST
> but not CONFIG_AMD_MEM_ENCRYPT.  Presumably we want to make
> sure that combination builds and works correctly.
>=20
> I think there's a bigger problem in that arch/x86/hyperv/ivm.c has
> a big #ifdef CONFIG_AMD_MEM_ENCRYPT in it, and TDX with paravisor
> wants to use the "vtom" functions that are under that #ifdef.

I worked out a new version of this patch:
https://github.com/dcui/tdx/commit/17b065e175082497907563297083b13dc86d84a9

I updated arch/x86/include/asm/mshyperv.h and arch/x86/hyperv/ivm.c
so that the kernel can still buid if CONFIG_AMD_MEM_ENCRYPT or
CONFIG_INTEL_TDX_GUEST is not set, or neither is set.
