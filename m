Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9AC661F33
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jan 2023 08:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbjAIH17 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Jan 2023 02:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbjAIH16 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2023 02:27:58 -0500
Received: from MW2PR02CU002-vft-obe.outbound.protection.outlook.com (mail-westus2azon11023019.outbound.protection.outlook.com [52.101.49.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DAF398;
        Sun,  8 Jan 2023 23:27:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7OBPIG2C+AAzwj4sN/knZ2ip16nUxlt6S1xjN0JhAPwkgMCEcyvEn2mDc6IanjxTsYAN/7KXW5Y/yPb+m75jKZK7Iosv9QspoaIVSpMzY2KDyPCAxtv33gW02yq+qpGLF+D+QXs5JUDSaebQ4mX9z3B9Igfsie8vlV3O0sighXM0msIHApoCNmelMqvR2f3sZXHx9291TqT6+oWopNVe59UrGJv3qooH7QQtaVisntXM7Zv1Phou/jhrCkEJXuZTP3y8/l/VLaLOMj1ApYGg5xEy5FL6RDDIQk1ZTOjiqap+E61n5ESyBGXDZgfFNVU8jE1wH4ZsgDftplm0hub+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UN8OwAd60ZR0dxTimrCkda9HyeFr7ckV9/LfCK5NhrA=;
 b=UvsMCmzpUgDH+YyhNtq0W2EgVJaVzRgiDUaY/zsH1X7UW9oZTpO+MZL3lePrH57c7StQYPuayfwTNTNFykGH5/MJZ0qErZnaBlMQy7MNDxGEK2Cv31spKnjnvh6JiWXKXox0ix4j5fz39BrlRjdG4rzeRSY06ofWcYq6qjS+PIJtFPZkVCfGQafmmA1uI3utopwWN5eOHaqEpYNuWgwi3jpeW/Ba8sYMP5xhYBMjn/5xT3pRzDEsTqGDw8j7vCwOlGcrcB1N5ZIG2Nv66InA/KfPM5dZGjLs6nVF5BumU5+kx6Y99g11V3uB9Fr+YtezlXAiHfxlMpdBr1vqLxzJsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UN8OwAd60ZR0dxTimrCkda9HyeFr7ckV9/LfCK5NhrA=;
 b=YMBFRKJf4XdE4L7tyvtrpbfTFaAFPxmVYW1i9uUARh4Cos50/1hy8Ln/wOTrX6QdD/aEVZyTbLSAKjZnPXrZaP81yikBGHz0mU79ywudCLBLNpFVvSjGLGKDh/bx0naxxteTlwvDlPGguakhLK94Uj6C4cWAD4HShsbQDr3BnFs=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DM4PR21MB3107.namprd21.prod.outlook.com (2603:10b6:8:63::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.2; Mon, 9 Jan 2023 07:27:54 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c14e:c8f3:c27a:af3d]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c14e:c8f3:c27a:af3d%5]) with mapi id 15.20.6023.003; Mon, 9 Jan 2023
 07:27:54 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Zhi Wang <zhi.wang.linux@gmail.com>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>,
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
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Topic: [PATCH v2 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Index: AQHZIcFboF6MXqWJVEq1rq5J7Jhdia6VrgHA
Date:   Mon, 9 Jan 2023 07:27:54 +0000
Message-ID: <SA1PR21MB133549756FCE0834498000CCBFFE9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221207003325.21503-1-decui@microsoft.com>
        <20221207003325.21503-6-decui@microsoft.com>
 <20230106132354.00007af3@gmail.com>
In-Reply-To: <20230106132354.00007af3@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=076c7075-2f26-4262-be97-acebee8566c4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-09T07:05:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DM4PR21MB3107:EE_
x-ms-office365-filtering-correlation-id: 195551db-477c-4bac-fa0b-08daf21305f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qzRPvpElR3sVISD1/UQHjw4MNMrn/bUBGyya4z8Ki7QP5L7E+OqqdkvUz/5vR9sGQ6as1yc7Z/rgz2P6tEiTawY2bqDuITPBt0lAhZ4C9eymc38VocYxtH6nUtQ1BzmGSIZAYTd9AU9rcPiziLNFxoTXRtXohLVNaiBKFV5z231lGosmV0TW4wBjykRalk5uHdrfQpwtaOOM7tsHWJN6tNltc2kBdnYWASzDMVFKkHZJfG/WqpuyRHE099EGEDr17CjK3HCeb1LqNbezH+xbQt3DwXGGC2B3XyxPe4+LqQ1ugNQ1bTalG8i8gqvqwCOB6e1NZPfFpsUGRDeuxtickUcWnEioR4TyIUg/+Wqn+V8mCz+UZ5hLyiNi1VSEVkzRvUyzqeTKoZa6Axy3BLmh0Fw4i8v0LokhR+lVwAHD7oO8cgye7OsFffo9GlhGA6MBmU4e06JHdGP95lJuC7ipEh2qw/WP1LNuTaxFwObhHjtjLrS7He6PLOsSryC7f+srJsdPVngajmU1LtbRTkBzIGdh/IGV+AAyKYGiTQiKeu0t0n+QApJTA/R30vw6sQprBQ8kYZ6wcHfCTW4NmvZn+3VIWMtFmcJElDK+J8sGLp9nvQzeRrEwe50IfbMAu6UZOarz6hFz2GaTJdwgJdbKz4qWmLty8yQGnH4rha0K7pi0vN2mqvvjxT995PjU63NPQtbpe3httEZ+/PqbChC999PCqIwaOOB6GlNO3LaVZYksL1U4siZJQJr1Ei9cP1Ul
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199015)(10290500003)(82960400001)(38100700002)(82950400001)(66556008)(54906003)(66946007)(38070700005)(64756008)(33656002)(41300700001)(122000001)(8676002)(4326008)(478600001)(66446008)(186003)(76116006)(6916009)(66476007)(52536014)(9686003)(316002)(83380400001)(5660300002)(8990500004)(7416002)(6506007)(2906002)(71200400001)(7696005)(26005)(86362001)(8936002)(55016003)(66899015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lCEg7yW6EfEl3bteIXG/pBnRMb/awaOGQHVMNXhRS+q8WKbjLE75X19MQOKc?=
 =?us-ascii?Q?ZPv7+jtFMHGWA0dQBbczNMIKxp+7nvbgyN1deOru1mvzGdEVcqc5q4fdllBV?=
 =?us-ascii?Q?knKlBkYEUDsKOaZ2YYHWSGaU544uJhZziRHag6aMuoCVPNyNAvSWWQs4O9VW?=
 =?us-ascii?Q?BGCBNNIlFAuiYjpvRtZkXGNlpVgQL4Y1ConQKXAIZF21/bXwtBRSrgLHJ0Wb?=
 =?us-ascii?Q?Lx7sTN+tTfffEgXbCs6QoNG2S1qRnISnxkth8o26/xMCjwTqb/86x8uaPxJd?=
 =?us-ascii?Q?Car5pT4aLsEMr5mBzoyNdT+MlYIlHQTWUeMJKhQTLQ5t0Kb/36uWdErJzplR?=
 =?us-ascii?Q?qXDLRnRDFlkPALRFZGt1kH/cH3JR3TEky3ORjlhi9TeYSxvnRLMM8k157kRS?=
 =?us-ascii?Q?yAcIhGR6Kmqd4PiykiQHC+SfFEbf9c81rwC8q5rrCq8psLEEzrm7XriwnOyR?=
 =?us-ascii?Q?Uq3MVJUl0H/lujzzXnOfvRZltOBZzwjYFAdA3LFfrg6ym5q5niZw1VWdTtwn?=
 =?us-ascii?Q?chtIzTfLNFPwG9nY5/66VHsypGw42TIRgh4FGqeCb+8gj+TVUXvCV6fXDCWZ?=
 =?us-ascii?Q?FsWag6VqgAMTadH19tbXvkyNc72TQSbj2g80XxZn6y/8SfsQwKO1dO2vZGfG?=
 =?us-ascii?Q?6IGTrA/pybaBpUnT3BK2D7KyWYeBOsI4y04GKLxeheh5P/JI47lUiCwvXs/R?=
 =?us-ascii?Q?ZExWNxLbLFs6A0WfNT2PBAuJnCH48i9D+LQLdAUVGalaCK3prPVztVFsTxeU?=
 =?us-ascii?Q?QUiJWXpwdlBuTvGjC/7uxsGauURYV6JbzthgiFulhFsfGMnSh8+k1w/Hsyso?=
 =?us-ascii?Q?DJl373NaSpGPZto5Q2W3KfA43tLbgBwOJKt33H3PAEL2+NxfZt4VqgwO+0UA?=
 =?us-ascii?Q?TBvcSNWzQfLwIjlahlrb5HJ9EvXnB4aQ6FrLNHII0S/6+MA5qGOIGGqs9v75?=
 =?us-ascii?Q?ohf/7Ti+lC9ojwzfgIg6CJ2j6hlL9zKIeKtvv2objn1dnok7UPLP5oSBChzS?=
 =?us-ascii?Q?fAbByW3XJV7QiQyKJTVzxflVKVHFNn0HGiXqmJbO+lf4+YzwN2ojpQfaTxNg?=
 =?us-ascii?Q?6z7/zmoeGnvlZQlR0xVJGK+ugtsDApbMfoz9gf4YijqR9MMlHrW4l5JOKFcl?=
 =?us-ascii?Q?dBrpBgPA4LPJiivm4ahnYEwx59CCOct0s8N23J4VCpmu6Py7KtE8KQ8d+tBf?=
 =?us-ascii?Q?raSvT4akjnTp9Vnlr9fDIdIyO+ShWvO8BoEPkbjNCooyyC3ivB8wTAYhaKSl?=
 =?us-ascii?Q?t6GpWN6EzoZ7EI7OFSTXDzphxD0gXULqNyCciJsuH+CQoOGKtXYDwrZy7LWo?=
 =?us-ascii?Q?XkYPGCzMq1gaqTX27X9DYkcRdxDKfUqSxgXtYG18aNGAvAirFv0q7AMz6al+?=
 =?us-ascii?Q?dWL5PwS5Fe8scJE3EDG2EsE0skOqoPjHk+y/TSUJjO0uBlIbqJI/u8psVTcL?=
 =?us-ascii?Q?JsTumDk/tkZrjCuXF4KmOctXSvYKI7L698Oows6UijH7YdqX77482+tbr+WG?=
 =?us-ascii?Q?efEkTvBs7DGeEjOuzDaFSJSW4VPkJU3mK6AX/Aj8+hvZ/xDO9Zo6SlkVHa6C?=
 =?us-ascii?Q?a3lDxZEq+TFQcKfILhZJ7uI5x7olnhd7iMKL1La5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195551db-477c-4bac-fa0b-08daf21305f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 07:27:54.4446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zgb3WNOeprGxTXVruwLufg/TSQjoO2y7/Fwj5cZ2bXuWGCUFSG3FDIEuU33pksax0vn8QLgeRrSnnv/El4z1CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3107
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Zhi Wang <zhi.wang.linux@gmail.com>
> Sent: Friday, January 6, 2023 3:24 AM
> > @@ -83,6 +94,9 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u64
> > input1) u64 hv_status, control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
> >
> >  #ifdef CONFIG_X86_64
> > +	if (hv_isolation_type_tdx())
> > +		return hv_tdx_hypercall(control, input1, 0);
> > +
> >  	{
> >  		__asm__ __volatile__(CALL_NOSPEC
> >  				     : "=3Da" (hv_status),
> > ASM_CALL_CONSTRAINT, @@ -114,6 +128,9 @@ static inline u64
> > hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2) u64 hv_status,
> > control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
> >  #ifdef CONFIG_X86_64
> > +	if (hv_isolation_type_tdx())
> > +		return hv_tdx_hypercall(control, input1, input2);
> > +
> In some paths, for example vmbus_set_event(), choosing the SNP-based or

In a SNP guest with pavavisor on Hyper-V, hv_ghcb_hypercall() is called in
only two places: vmbus_set_event() and hv_post_message(), where the
hypercalls, which are done via GHCB, need to be handled by the Hyper-V
hypervisor directly; in other places, the hypercalls, which are done via th=
e
hypercall page, need to be handled by the pavavisor. That's to say, there
are 2 different kinds of hypercalls for a SNP guest with pavavisor on Hyper=
-V,
and hence we have to use 2 styles.

> generic hypercall happens in the caller, while now TDX-based hypercall is
> embraced in the generic hypercall path, e.g. hv_do_fast_hypercall8(). Whi=
ch
> style will be chosen in the future? Seems the coding structure needs to b=
e
> aligned.

For a TDX guest without pavavisor on Hyper-V, there is only one style of
hypercalls, so I make the change in hv_do_hypercall() and
hv_do_fast_hypercall*() directly.=20

I don't think we can make any clean-up changes right now. When we
support the TDX guest with pavavisor on Hyper-V, we'll figure out if we
can make any improvement.

> void vmbus_set_event(struct vmbus_channel *channel)
> {
>         u32 child_relid =3D channel->offermsg.child_relid;
>=20
>         if (!channel->is_dedicated_interrupt)
>                 vmbus_send_interrupt(child_relid);
>=20
>         ++channel->sig_events;
>=20
>         if (hv_isolation_type_snp())
>                 hv_ghcb_hypercall(HVCALL_SIGNAL_EVENT,
> &channel->sig_event,
>                                 NULL, sizeof(channel->sig_event));
>         else
>                 hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT,
>         channel->sig_event);
> }
>=20
>=20
> >  	{
> >  		__asm__ __volatile__("mov %4, %%r8\n"
> >  				     CALL_NOSPEC
