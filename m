Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C26647399
	for <lists+linux-arch@lfdr.de>; Thu,  8 Dec 2022 16:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiLHPyi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 10:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLHPyg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 10:54:36 -0500
Received: from CY4PR02CU008-vft-obe.outbound.protection.outlook.com (mail-westcentralusazon11022026.outbound.protection.outlook.com [40.93.200.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9769D528B3;
        Thu,  8 Dec 2022 07:54:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aibEZ04uU0tipbZlx0Vg7TGm5+hXUECoyk+ElgE9CaDWVMukKGvl7s4GonAGYoxdoVC3UhLmpd4a37ZmqaJjT/55iT7BEiYTIVqqAoDAgniPx8r1zOQzgjkXbPdVeYhhFB/+wFcOMZeAd3lJnSl5U42co7/6tH4VGyhZSDbz5g+zxyEx2ugcWLjJyfwPqTbN81In2Wk9Fwb12SUGu0SfXuzve7mtHKDH/dS06aS45RRmVh97907mtu47OdleqU14M0wVAQEBi6Wk9STkIVg2oooMBkfYhf/F7j5iuuoJcXRPmj0Q+PdWcF+v3xMsP9N13aEVrx/SPzbSxMgZY/J5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3A2njNS77bW9kOtlE5WA7jBDU/BHmMQnauHGldY6qU=;
 b=JZO3xOF1Aa+Qlj9cwb+pCrQBMd1ZLJAGTbsetanUzztw3SaKjMe/+Fnb4OTaulB8ZUyQnhx/en/HNytt5fk48ztBr/1ndrbv62tel8TMjS6n4Eo2OkPewApihms758RYaMoAXsbplF0EyJQ7J9jXUAamdKPOxOnX3ewyhk3aHGbtp+u5C3j28PvLqfN4hMAw6L1IJoFkKtJR/nNIcy9JI4wedPupwWFw0uXn8wPxldKhTEGLpXZ3mQycyrKCO8jhoLOjmY70H4Pk3eTiIHMGi+yzHTWNGUocbSpmvOtC8CmXoCkT/c1lbH6koZowzheK6OqaAhEHMDlCfUUNuexnyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3A2njNS77bW9kOtlE5WA7jBDU/BHmMQnauHGldY6qU=;
 b=b+5h+Br9yoDjohEvWENiXyzGATiP1f5M929lBXUIsotBrz6BNIU116kX4TxWxeq7YeYQO4Y0oJNElKk+A8POGjTqExRUaXTmkCVT4P+GbmkKHvxAFD9pq3oIEpOo+/b3qMhoGUlf+mAFus9+yMo+vJ44E44m57ox01jtpB0S+EA=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SN7PR21MB3839.namprd21.prod.outlook.com (2603:10b6:806:29b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.6; Thu, 8 Dec
 2022 15:54:33 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%4]) with mapi id 15.20.5924.004; Thu, 8 Dec 2022
 15:54:33 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
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
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/6] x86/tdx: Expand __tdx_hypercall() to handle more
 arguments
Thread-Topic: [PATCH v2 4/6] x86/tdx: Expand __tdx_hypercall() to handle more
 arguments
Thread-Index: AQHZCdPpXH6AK9q30U+Ekg4k2yGxvq5i/taAgAEnu7A=
Date:   Thu, 8 Dec 2022 15:54:32 +0000
Message-ID: <SA1PR21MB133568F9F4C70C9F6412BC49BF1D9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221207003325.21503-1-decui@microsoft.com>
 <20221207003325.21503-5-decui@microsoft.com>
 <e6a4aeeb-382f-18cc-64da-7730101282c6@linux.intel.com>
In-Reply-To: <e6a4aeeb-382f-18cc-64da-7730101282c6@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0cb14b39-2ff5-44ef-9521-0dafbd7e66d1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-08T15:52:44Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SN7PR21MB3839:EE_
x-ms-office365-filtering-correlation-id: 7b756188-71d4-4847-fce6-08dad9347fac
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3dMannM9SWYesFRltzkYiHPX9DYfDNSeMfB1M+lm6gg+Bzda9rCG9MI5RCdV3Q+DsiF+hs3w+OikaQhOIESJlst4vT46wM93flV+pZhQJrwiO0gz5PVAAnDf+Z/gDAl9SsEXo91N21G8p3OdaLbriJnkGPTano+Q5QwDPpLdIEvmGFN3iFskX8c3OVAVEZgJbMDK28IusdB8lwDPZvT7CE39kl2/Etn4e8RO78glVkmh6GXwMllCbtmFlVAzrnQK/WiSzDBxx9NrMmbZlXZW8MRL8gHMdCTvdgQok4QRGilwwU/vPhcEfW6POrF4BxztXhc+/3kuzQbahplkIWJw+lz5s6eZPawoLJgvxc3qWnQpPVoHJEWHoXKwl21LY9dzL2u43Fd+cQd7ii0Nqc1Kpd/GpWrFYdv29vqIKnzuRPZFQyKm9v0lZNs/NrBeLR4Hjm01xpfV+8ftDiA7FksP7uLg5maJK8n9xbrZvKWbMXZRsYvUgimeapgBQqCAd7rgJgMX+Luiu3gwm7cb2xKFWni1w3Ba85dVAS6V98fT4PkKfv/33Z+TEZwjUuzB15CshedEwdWPm+fbAtkqgWHqCG9wQCxKrHoE6TtJKkWlVB15HZqHwRekUnZ3Ay/vXDx7JsLsYckgOi3Gtjj09jy87h9WzVivgpFNi/4xY98j2W+DC/8ku11YTQLrAm3DFLKZ2uVapjEEp67dUm+LbnFBj9g8MXVIZp7beEZBC+BZmxeJXmx/ahAr1Jn2cGWyo4X4TJcqfAnjRSxCjGFxF7+iUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199015)(478600001)(8990500004)(122000001)(6506007)(7696005)(66556008)(66476007)(64756008)(66446008)(82960400001)(82950400001)(2906002)(921005)(26005)(9686003)(10290500003)(38100700002)(6636002)(38070700005)(316002)(110136005)(33656002)(55016003)(7416002)(71200400001)(66946007)(76116006)(5660300002)(8676002)(4326008)(52536014)(8936002)(86362001)(41300700001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qMizQubmaWBBw+Q883WFDOKcD6TJ2ko5gL61lzFkmAhy9rHwG9n1FXZ8jERf?=
 =?us-ascii?Q?wnab/58p2JPNNPXfkQUv4Nm/hsBB+KpuhOhvRBdQGItedEZH+gCK2yoQoUdX?=
 =?us-ascii?Q?Qfx4DhIsjirKgy2GIYPmOhJZ7HeD0AibGvhPELgU84fPZoU+2c40sFIzqi47?=
 =?us-ascii?Q?xzpHIxOF+4QiIBVoRbtq4FyLdjJVrjSSWCag0EGIZWBLvSWXc96NZpFrAVyw?=
 =?us-ascii?Q?V1GVvX3LQVBTec+yE+XQ4yRUzSniiO6LcgHXj+iwNaFP4FHsI3HxFH3lS1n7?=
 =?us-ascii?Q?fn2HmmT2eCo4HUj1KFvrVJj02iQOgTamWyiLcc5g3XxVWwR8278G36GgL2kt?=
 =?us-ascii?Q?1Oh/PBSGEPemuA2rlTIZs3sUSO3yp5a5wk05E/nSuuruAmam/nXr+1shyAKw?=
 =?us-ascii?Q?yy/Vl7rB0uHta0b/1Sl9LGpcWDgmHBWWF97e1RtRhJs6sRhq7nD62Kxf/FKs?=
 =?us-ascii?Q?RRfwZjPu8asGXD9nLSBeCkIDkpj6SrO1NFM2ngANgjDVUeyBJ7ZaS33MMqtu?=
 =?us-ascii?Q?kdNM/13fBpsLt1d02F7Evce3/Pg3WJOeRLkM2vpzGBEGNcjv55rsM9JbP9hK?=
 =?us-ascii?Q?4IVE9ifvflXUxdR411ScLhR0VyESe0HKPI/qdPkk5WztKjdOJz3s8qLtOeWf?=
 =?us-ascii?Q?V78bj7ayY8GKZ/V3h79VBInOEdlIj0y23jsUJkZGOJPoCU3MYqIHfOnE/CMs?=
 =?us-ascii?Q?4E4RQD9tj6wZkT9Xtx/D2EY4UE0DjnwhxCrbnMS3O4REIbbWpgu0GR5jCcbX?=
 =?us-ascii?Q?SUYAb/x9KMJfJE02hLecB5TSPGKT4ADXAR8NbcqiuXYVXlkWpZFJT7Zrw6RA?=
 =?us-ascii?Q?lKmgI8bGo9/+WfYdGTragAycprLzDk9H5f1dGUaepXcmMj7dtdYMRo0F+kQh?=
 =?us-ascii?Q?Bdvnu3WXMX4OXDBdngre2oIxcVh9iq8Za+AuNwVP8l2cMtJ8ziMI6S9/Woe/?=
 =?us-ascii?Q?+oVGbpfqR9bXrwl/XUj3vWH5H+sXk7GW/s+i6NqU9q92aW21zbB/fzSIf35S?=
 =?us-ascii?Q?aSovpDtMA30BSl1rOWhRrkye0qHo+1efdQuTKYIR1XS37Vq5HACgo+8qe3as?=
 =?us-ascii?Q?+0OJgvbY5l7BmTeiLoeMIfVhqk36DeDRsiLsDf6rHzok3yc4dz3HN+EzIpVZ?=
 =?us-ascii?Q?PI6FtzqMpD2k2RU6YBAvjLeCZ8ueJhB65yPXiNRmAksgTwIF3CrDU0g2FUfL?=
 =?us-ascii?Q?k+oim21QgqOjNs3hXppQKVuMWg31cxy/B1n97Z7pv3d+CclGfDngkPQluQJF?=
 =?us-ascii?Q?0OxerIGgK20nIRE4MJ/2w+EWchElVHbwHlCksWapOcCvGxHIlLB35t6OxMus?=
 =?us-ascii?Q?9AUV5NXDtYWJUIgrcP5WjF8N42oxShLeq3V1E6lsblLmQgOIgIEAX0yiPV4J?=
 =?us-ascii?Q?NDQt7spLcdQ7bmTAcgKHaRXwMkg2I3Zz/yWQ8XZzb6ckXA5En/OP0B0vcVAT?=
 =?us-ascii?Q?iyeRqLRmC4+w0fFT8rfRETNAVGJXiRJmH0vyyfjxCRU6630Pt9yJhM2TSb0o?=
 =?us-ascii?Q?HTgfWNvOFXAj8jo3DAKzfxNTdzp/zceChOLmVHcUU5UuSF8VXPVg+Em8zUU3?=
 =?us-ascii?Q?oaAtDNTkQd7OkC1Xn7HFCcZX9cKuCm7+aqUO05Op?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b756188-71d4-4847-fce6-08dad9347fac
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 15:54:32.9603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qj9lQ1kkXJ1h9siHJKafeXMYV0RffI09H/NfebVwdUXoLXoOltRzK3yK2XBe4WZb7nOwkmfjZ3PawimdUzutSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR21MB3839
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Sathyanarayanan Kuppuswamy
> Sent: Wednesday, December 7, 2022 2:14 PM
>  [...]
> > --- a/arch/x86/coco/tdx/tdcall.S
> > +++ b/arch/x86/coco/tdx/tdcall.S
> > @@ -13,6 +13,12 @@
> >  /*
> >   * Bitmasks of exposed registers (with VMM).
> >   */
> > +#define TDX_RDX		BIT(2)
> > +#define TDX_RBX		BIT(3)
> > +#define TDX_RSI		BIT(6)
> > +#define TDX_RDI		BIT(7)
> > +#define TDX_R8		BIT(8)
> > +#define TDX_R9		BIT(9)
> >  #define TDX_R10		BIT(10)
> >  #define TDX_R11		BIT(11)
> >  #define TDX_R12		BIT(12)
> > @@ -27,9 +33,9 @@
> >   * details can be found in TDX GHCI specification, section
> >   * titled "TDCALL [TDG.VP.VMCALL] leaf".
> >   */
> > -#define TDVMCALL_EXPOSE_REGS_MASK	( TDX_R10 | TDX_R11 | \
> > -					  TDX_R12 | TDX_R13 | \
> > -					  TDX_R14 | TDX_R15 )
> > +#define TDVMCALL_EXPOSE_REGS_MASK	\
> > +	( TDX_RDX | TDX_RBX | TDX_RSI | TDX_RDI | TDX_R8  | TDX_R9  | \
> > +	  TDX_R10 | TDX_R11 | TDX_R12 | TDX_R13 | TDX_R14 | TDX_R15 )
> >
>=20
> You seem to have expanded the list to include all VMCALL supported
> registers except RBP. Why not include it as well? That way, it will be
> a complete support.

Hi Kirill, can you please share your thoughts?
