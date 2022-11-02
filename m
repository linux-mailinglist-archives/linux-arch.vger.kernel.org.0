Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49695616ECC
	for <lists+linux-arch@lfdr.de>; Wed,  2 Nov 2022 21:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiKBUdp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 16:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBUdo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 16:33:44 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11021023.outbound.protection.outlook.com [52.101.52.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A59F60C1;
        Wed,  2 Nov 2022 13:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzYQKKkgTglKSf5tNj4V35739bIz6x7PF+6rriulhxbn/4MmpEnn13S4W0tiUkNa2Ixadku7GzQUW1biK33xxp/nIkpgv6u5QqKu+ES4St7L3sLVl3I1UWYW+J13Ow0llUdpkw3x/NBpH4JJjHPWXJGj6+za6ucrlLxZyURmPkudjioDxcZnLh2lpOJVnSQcOoB0Zl8qEZj2amx8wg+V9UwUBxd5GQdTW50wHX8fhxUm+pJhjlPtayKlQyuN2pRnsiJ7SU/cqlRTbFRlnjYlAl5Bsl6TXVf+nxjhA+R+t1b26iAew4KjHkCIBsheqhfo7mWEB2DMflV3Tl45ocKbgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpQPoChDA3RPDlPWGhLZqdOuuvqNyZZtg8PrKvciL5Q=;
 b=kno0Z7GS1BNUuTX/XCRElbHKCDqXeTkob3GADUxAljIyQKfRsgJ+0U1ctcLchT4UJVAZu4THgTcmC3mnW5mFRq/0FtPpV+BfEXeOf+ZCWLB+cc4afM1h2Zf9OUbeKYb0ehfxfvVe6+C7q475Np5odBqIfxKURHCKu2swT6N76NkRyRh0xKtx0mK7E7fNtjyfrnkHe7GGW2TiUK2hJxipSuVLqQTKkWcPxS0ubWKSc2hODKvsLxAuvF/fPyGd6TLVcF2SUnb/61yK8QDD9H0Kr9ufj5biHWTYdJIl7EBLZ8XvY1bdk1Xr/GqepvJ6zfvAdb7+vn761n0ZrzwDmRrVNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpQPoChDA3RPDlPWGhLZqdOuuvqNyZZtg8PrKvciL5Q=;
 b=jtCJaFpTIW+Kk/Lv+RgBvuHv/Z2phbGXamMv4n39JXJjHgUhwVpUQW/Z792vRBAreo09x9kV0XQ6PCgGWC2N8Qe/x0+1Jni40jtgB0pGUFoVs4Ng528Ilz882luQCngihrAKSLYB0Rtd3+UG9vAyIxIm9gFWrU0yXjVOY28QESg=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SJ0PR21MB1919.namprd21.prod.outlook.com (2603:10b6:a03:2a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.5; Wed, 2 Nov
 2022 20:33:31 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.004; Wed, 2 Nov 2022
 20:33:31 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     "stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
        "kumarpraveen@linux.microsoft.com" <kumarpraveen@linux.microsoft.com>,
        "mail@anirudhrb.com" <mail@anirudhrb.com>
Subject: RE: [PATCH v2 1/2] clocksource/drivers/hyperv: add data structure for
 reference TSC MSR
Thread-Topic: [PATCH v2 1/2] clocksource/drivers/hyperv: add data structure
 for reference TSC MSR
Thread-Index: AQHY6erhWJkiLKLdokahKR7tbQL5tK4iP8/QgAngTwA=
Date:   Wed, 2 Nov 2022 20:33:31 +0000
Message-ID: <BYAPR21MB168844A39612131C920DA954D7399@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221027095729.1676394-1-anrayabh@linux.microsoft.com>
 <20221027095729.1676394-2-anrayabh@linux.microsoft.com>
 <BYAPR21MB1688E0040710DF040BB7FCCDD7339@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1688E0040710DF040BB7FCCDD7339@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7807c19b-bbc9-4867-b28c-415332ac85e7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-27T13:41:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SJ0PR21MB1919:EE_
x-ms-office365-filtering-correlation-id: 6b9aca1a-53f2-4de7-864c-08dabd118188
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jn3GZRIfyXQxgJX5ykTXQdYyxE4Fd2ar4Un1K0hP5ZWNRU802Q7N5NLIdv215XTYVvx2IX//M0HejtJgNIGuMxbz74TKHArthLviJH9BVQ7GvjFo0E1SRarYYr1s8z096/4UNRAIdySSCjhOgO2KPWb1ojw/p/JmkW92+8UosbasMKn2rlpUg17VTgYGyWf1maUyvMT6Aj+ptwvAZb4ZUIfuzhTDf+d2qOJD4esb053g7bBA4Z+bvuCuo89kXpE6AymOBwKCNfc4FEtrWnANpk84xBl2uWKCwA7tQowpfwWirxP+Fm7JBbeo1X82C6WjVCj4Qu7VML+fcMOHvo+oBuxJXnyTBgXRR5EZETfePvJCOIoi0LexdoWAsXWpTOAN9C6uYuXz9KedzNNkdLfT2PEX3mPVk+13chIIk+5u8wKZAprf2+4uinctlUibNFb46mFEHAt85G0wurTEgz+x1r3cKMcu+G0gDLlQOUCsJpY+72Tz+mlQmaOczHLr9k9VS7Ym45fdXC7POqeFmSyt+dIlLaaVEH+ObygTufKA/h4YZb795VH6P5E9/sNn0YdI06lEMiDX0suXMqsp4dIH4P2oA9OTU/2bbXQ+noF4NJ4TaArb9Ui4nJwogQ+p3DQoCgbsONPriK1On/woFWjBhbwP3ROmAw9j6v10b1S0dXjFVownLAgWt3K/U6ok5jNEuG+1oDs6P2plHLGj+b5u1Bl/XlgvPkozhSqqSZeDKkeYQrn5JXHlx82/HokSWVRWE7OYt6Ens8XiKYBQlvC1R8b9NHDD7oLahajEJVv+gM4Hh4a7T0JeOVXJ/ry4RPbEBLI36AlteCvU2vjGKi4ftQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199015)(8990500004)(64756008)(66556008)(54906003)(316002)(66476007)(8676002)(110136005)(38100700002)(38070700005)(921005)(122000001)(2906002)(66446008)(41300700001)(8936002)(5660300002)(7416002)(55016003)(52536014)(66946007)(4326008)(76116006)(10290500003)(71200400001)(33656002)(186003)(83380400001)(6506007)(82950400001)(9686003)(82960400001)(7696005)(86362001)(478600001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hE6PsVZw3VNNbRDc46O1bBpb1xGHtAo6yae4zgrjsGOoFfHJWCiYstHxxbyu?=
 =?us-ascii?Q?lb3ZUFAFGALpltC+L4yMINo3mwjOzbmdR6nSswzqLRouajG/lLUbc0WJePr6?=
 =?us-ascii?Q?bxrrDibC4xo6feAe/OWiwA3qc2cJ3tdlSTZoWLbuuoNi/qA2FXxAz3G5c5lI?=
 =?us-ascii?Q?jQITjcAiHqJL5HkU6f9LZNrOT3GDZl+UDOFVua02KRbZ6RR2YX3Eb0Qp0dvp?=
 =?us-ascii?Q?jOu5/WgdVZVtetal/QoRsgh0+vjkYSfHzEobvmrNW2QBM17La++HgGDk6X2e?=
 =?us-ascii?Q?yAg1KlCOY06K25n8vq5MzGUh34VH1sNg/2Zu+1PsaiTQ5FxfAi7gabb04K2g?=
 =?us-ascii?Q?P1aEkAnjDA20h2xS1xRlsAFFcIsWxbEg4SLCbrFLHBZJJfWBR2F+9J+phq7o?=
 =?us-ascii?Q?vWkjX2Rfc+tcUwwJ4ya45ct3Qo1J0KRwys74aGUM4aXT8uWsrLBOKaEOnP+6?=
 =?us-ascii?Q?9bHRJJ768gXzE49VPCptOLPi/TWjWA6R1hA/50d1tJdUWHYNdHNNEh48y4wL?=
 =?us-ascii?Q?R2sQGsWK8VZpRd2h6tCaIJd4jks6uX0BkmFezeNPDdfUWe/M/hMSujdDQiXB?=
 =?us-ascii?Q?DoN6ikpvDvxbq54eVxxxUpsClT4nWwANlPb4/71ezqZTRj11GM2Anr2jxbin?=
 =?us-ascii?Q?UmNOQBlJk5txfuSr6BHf4vyQov/iayoyKBhZRXZSi0BIrreOD2549WDjzQDr?=
 =?us-ascii?Q?yw/C41B/Jt02kHXHa3mzsZ07iQ9JrpgMwx5gj46uHSYm+b85DYKCTscAxHly?=
 =?us-ascii?Q?qrw2Frm4DDZB9bi8b+jZjKBY45EpaaFElpyzUw+cURQduWzXJxy585SOmcFB?=
 =?us-ascii?Q?ZCVwRYL6TdXjGfrBMev6zBGDs+NzMC94Cb+rzFoh21vMUbnqhLUVKVNulE22?=
 =?us-ascii?Q?UPqswBkzmFqCP0Jvj8JlXX1XMyIBDrTm8YP4TfsN9gdF/zzEJaeBKwT1Mtel?=
 =?us-ascii?Q?2vcCjJe86W1kPpQMDRsUt9xUgu0hFcgLSbd54ElnD8hToZ16hAicBME/ZwXi?=
 =?us-ascii?Q?ImQogmR5wgml/0BAprkB74h84nR0YRtkiZoyxWNd+EZMo8gwxPEAgBcEnQJb?=
 =?us-ascii?Q?xnMa3ZhNZWQFP3WshvFj0V+vc6aVr3b9YYiieuayyoY4as67yYiyRhpHnZNS?=
 =?us-ascii?Q?gQJvxJHU4ZyvekNPEERjSD1iJmlNsK/pNXG1u+x8BgOpbWnZXDTiZqgybJZs?=
 =?us-ascii?Q?7pwWbE0iplj4fvkT2d7j26rB0RL9iLZWWedFsW4vFGDVJ2vlIsgDB8Q2bqZ/?=
 =?us-ascii?Q?XXNBiel5FwwVlKBKY4McDtZ/CFStO1Zme3YyDBDFT7XVnG7EkzcQmr4qS/ft?=
 =?us-ascii?Q?3fyLVR1/2daHU9Nn8eKtiIkcYlNBJIgdw9PQEHy4/7XH+OCL2wXkKB12Ay6T?=
 =?us-ascii?Q?TnNC653W3NBp+P8vyx8ITV+Tw6rrd7TH0U/LrWcv7gZyleQAuZpX/7vJ9j3u?=
 =?us-ascii?Q?NPg+TEyX+uYA/fgQeZHq4LPg54Njit8Z9EG7Q2ZroQFMZ96WiWjym91jdqeB?=
 =?us-ascii?Q?6pLI8OT+pQ+fpbU8nPcineg0B0ZlIrZ9NLRtW5kp9UZeHpXEXWIHputIlgu7?=
 =?us-ascii?Q?WFowNKqmct3S2e0h6NvPbeIRFdCDbGGsAdvoW8BTrm1GVlIwOMTuBhO9ZB94?=
 =?us-ascii?Q?yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9aca1a-53f2-4de7-864c-08dabd118188
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 20:33:31.1335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d2rsNnLXo17Pj3YCDMtMQgwsNYiiInFtiNGtYDoGyewJcJX+TOk+jQ7B/U9t7XRp/B+J7bQMMSPaA6/+ogaIUyk8BEv+uFaiQY4pRtcQn48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1919
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Michael Kelley (LINUX) <mikelley@microsoft.com> Sent: Thursday, Octob=
er 27, 2022 6:43 AM
> From: Anirudh Rayabharam <anrayabh@linux.microsoft.com> Sent: Thursday,
> October 27, 2022 2:57 AM
> >
> > Add a data structure to represent the reference TSC MSR similar to
> > other MSRs. This simplifies the code for updating the MSR.
> >
> > Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
> > ---
> >  drivers/clocksource/hyperv_timer.c | 28 ++++++++++++++--------------
> >  include/asm-generic/hyperv-tlfs.h  |  9 +++++++++
> >  2 files changed, 23 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/clocksource/hyperv_timer.c
> b/drivers/clocksource/hyperv_timer.c
> > index bb47610bbd1c..11332c82d1af 100644
> > --- a/drivers/clocksource/hyperv_timer.c
> > +++ b/drivers/clocksource/hyperv_timer.c
> > @@ -395,25 +395,25 @@ static u64 notrace read_hv_sched_clock_tsc(void)
> >
> >  static void suspend_hv_clock_tsc(struct clocksource *arg)
> >  {
> > -	u64 tsc_msr;
> > +	union hv_reference_tsc_msr tsc_msr;
> >
> >  	/* Disable the TSC page */
> > -	tsc_msr =3D hv_get_register(HV_REGISTER_REFERENCE_TSC);
> > -	tsc_msr &=3D ~BIT_ULL(0);
> > -	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
> > +	tsc_msr.as_uint64 =3D hv_get_register(HV_REGISTER_REFERENCE_TSC);
> > +	tsc_msr.enable =3D 0;
> > +	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
> >  }
> >
> >
> >  static void resume_hv_clock_tsc(struct clocksource *arg)
> >  {
> >  	phys_addr_t phys_addr =3D virt_to_phys(&tsc_pg);
> > -	u64 tsc_msr;
> > +	union hv_reference_tsc_msr tsc_msr;
> >
> >  	/* Re-enable the TSC page */
> > -	tsc_msr =3D hv_get_register(HV_REGISTER_REFERENCE_TSC);
> > -	tsc_msr &=3D GENMASK_ULL(11, 0);
> > -	tsc_msr |=3D BIT_ULL(0) | (u64)phys_addr;
> > -	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
> > +	tsc_msr.as_uint64 =3D hv_get_register(HV_REGISTER_REFERENCE_TSC);
> > +	tsc_msr.enable =3D 1;
> > +	tsc_msr.pfn =3D __phys_to_pfn(phys_addr);

My previous review missed a problem here (and in the similar line below).
__phys_to_pfn() will return a PFN based on the guest page size, which might
be different from Hyper-V's page size that is always 4K.  This needs to be =
a
Hyper-V PFN, and we have virt_to_hvpfn() available to do just that, assumin=
g
that function is safe to use here and in the case below.=20

Michael

> > +	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
> >  }
> >
> >  #ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
> > @@ -495,7 +495,7 @@ static __always_inline void hv_setup_sched_clock(vo=
id
> > *sched_clock) {}
> >
> >  static bool __init hv_init_tsc_clocksource(void)
> >  {
> > -	u64		tsc_msr;
> > +	union hv_reference_tsc_msr tsc_msr;
> >  	phys_addr_t	phys_addr;
> >
> >  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
> > @@ -530,10 +530,10 @@ static bool __init hv_init_tsc_clocksource(void)
> >  	 * (which already has at least the low 12 bits set to zero since
> >  	 * it is page aligned). Also set the "enable" bit, which is bit 0.
> >  	 */
> > -	tsc_msr =3D hv_get_register(HV_REGISTER_REFERENCE_TSC);
> > -	tsc_msr &=3D GENMASK_ULL(11, 0);
> > -	tsc_msr =3D tsc_msr | 0x1 | (u64)phys_addr;
> > -	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
> > +	tsc_msr.as_uint64 =3D hv_get_register(HV_REGISTER_REFERENCE_TSC);
> > +	tsc_msr.enable =3D 1;
> > +	tsc_msr.pfn =3D __phys_to_pfn(phys_addr);
> > +	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
> >
> >  	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
> >
> > diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hy=
perv-tlfs.h
> > index fdce7a4cfc6f..b17c6eeb9afa 100644
> > --- a/include/asm-generic/hyperv-tlfs.h
> > +++ b/include/asm-generic/hyperv-tlfs.h
> > @@ -102,6 +102,15 @@ struct ms_hyperv_tsc_page {
> >  	volatile s64 tsc_offset;
> >  } __packed;
> >
> > +union hv_reference_tsc_msr {
> > +	u64 as_uint64;
> > +	struct {
> > +		u64 enable:1;
> > +		u64 reserved:11;
> > +		u64 pfn:52;
> > +	} __packed;
> > +};
> > +
> >  /*
> >   * The guest OS needs to register the guest ID with the hypervisor.
> >   * The guest ID is a 64 bit entity and the structure of this ID is
> > --
> > 2.34.1
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

