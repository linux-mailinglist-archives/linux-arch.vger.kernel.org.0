Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73272784F94
	for <lists+linux-arch@lfdr.de>; Wed, 23 Aug 2023 06:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjHWEX6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Aug 2023 00:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjHWEX5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Aug 2023 00:23:57 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020019.outbound.protection.outlook.com [52.101.61.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2AEE56;
        Tue, 22 Aug 2023 21:23:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Afcq/oHkkM7Kar+gap5QqHmYCrzGTYMzPw7o7E+bGeeUaaOIc+A03Nkg0gcoNIXpxPeFGYe+F0GGzNvNy+IZjt4S0wrGadjjeMSpoRLUMoU7IBSU6lQPjbKY0+SDte0GsYrh77IF2ftfmy3QF1heYR93jv2q2huFPUci0qXGc/aEfJSe+5y2+IDcKjowyOGVj03+85Mk4SQgPgdQltQnBeGzPFlQqOsWJspPXy6uj6cKRW3CiT3fBnOW0tUZD6/yjrcGba27LOv+5qicWU1jsc4APLUm+LlA85N+TOubnsNS/ST7yRRfgwrwgUpCq/cXr7SCH60rKyExhL+QNZixVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+HPXthsnDX/qhgwM0E+vocgwUbp/TXT6V9N9JNZ0qo=;
 b=Ca3C96ZZLOIKtTyeFah8WpQAzzsQ2QkiG49kGaL9AvwWDJlpsZ24/w8S2DRCUto0RLl9834gHIqBRmpNqEF+BSj1q5TOzM+CkY8HLpVQWfmsJQu+DP9mTZ/CKvD/C6XzsHHoqYrLi/6vlxbWbMkhoT2b7o24AgjgGfM/UQsr2HKPzfjbsbylJrLSrWOYRuw/lHjdUDXHQ2QAFRcOpvrLZH+QkqxCrCqYXvlhxSM8Jp5CL4RaFvVkng9Ai2l1Y9md3CjVupPIxT5F98q36ToohjO57GLnNlzjfqGWCSwAtGh2B9swKaBcpvl/EurGc5UiRfxXDKeAtxOya7oxZ8RVhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+HPXthsnDX/qhgwM0E+vocgwUbp/TXT6V9N9JNZ0qo=;
 b=hvtdevlGMwv1unN38jxS0CCn63DOh1/WjETMgUR2+aMPL4YYdeXD6OWiFRRFI53/b5cUMm4xGqefUVt5KiFDW6yWDAgt0TPE1aTzhSKnb/JBAg0hBLYGOqmJiiZWosVaK/ChF/N83VNw+GD8HuWoHnAKghR5fxJb+QQu0BQ65GM=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by IA1PR21MB3736.namprd21.prod.outlook.com (2603:10b6:208:3e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.4; Wed, 23 Aug
 2023 04:23:51 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%5]) with mapi id 15.20.6745.001; Wed, 23 Aug 2023
 04:23:50 +0000
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
Subject: RE: [PATCH v2 6/9] x86/hyperv: Introduce a global variable
 hyperv_paravisor_present
Thread-Topic: [PATCH v2 6/9] x86/hyperv: Introduce a global variable
 hyperv_paravisor_present
Thread-Index: AQHZ06TVJoWZTp5HxU++UB0kj/HGQ6/01qqQgAHUHnA=
Date:   Wed, 23 Aug 2023 04:23:50 +0000
Message-ID: <SA1PR21MB1335945301F8E8FBC2CA15B5BF1CA@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230820202715.29006-1-decui@microsoft.com>
 <20230820202715.29006-7-decui@microsoft.com>
 <BYAPR21MB1688ED81A8A54A25A7A10C44D71EA@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1688ED81A8A54A25A7A10C44D71EA@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cfb085e1-2e77-4201-87c1-f2506136f544;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-21T14:51:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|IA1PR21MB3736:EE_
x-ms-office365-filtering-correlation-id: ac7284d6-3589-4879-8f06-08dba390c07a
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e+mw1reEFW70zQ2u1ZWgF2Yp9mjuphP9vAFxDE9CieHr3o+8l6k44Q54SI6Q5TexYc+PUuDrOZG7gV3KLyOfgMShg+Yyu0SvG+mkRkmx0thNndXCk6qTsjqyBykN7j8b/zENlu42ttMtx1qae+mFsl13w2X5R6FCSv9CFHWYBJsfA5YMvU1hthyQLe8gmtFXlj/iIC0nJ0vq7UKTqOnzGAzDG9SXTGAx3T/Da1zDIPMj73zBRTR5J7gQ9gBEJyb0k21s2gQWxxUekrUp5pB2NZ/oSjMNrmE6hnxrgyzWn/NixAnugk1ftwkyEOMueRRffZ+3JDPcUHTTBvFPz1ZZ4cM4zNKLrNzWsxlMUzampMc8lScreZaqAjdkZhHlrJlQlq9UuPIc67w1L1gC66zSVC+Pgjd0QAfmY/l9vwa+2Srj98kXm3RWX8aJDOM7zad1TypaidcfzGcSh+5k/OFZtzF3C3+pdzMpXTzoOvTOc5j2l6tGieuDGJv63dyeE3VDAuMNpW48cR8zLdgf3TPbVWCx6mP0v1exn9Z+NsPcJGD9hD+GYsyCA1EWva/eRzn3ywPKw0a+wgicxVdkE5s5ABajZI9XOMGTvSk3f08JuDhp2wn5CFQHMGqXCvqaCtcSXbRPdGqruKXfpUGI7XSjaqmvtr9JFbzDVPWaLZcLpGJtSUzs82OT7dNQxBJzqo8yGuXaAQ1IDv2q5+1Af17h+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(186009)(1800799009)(451199024)(12101799020)(71200400001)(7696005)(4326008)(6506007)(33656002)(82950400001)(55016003)(86362001)(38100700002)(82960400001)(38070700005)(9686003)(122000001)(921005)(83380400001)(2906002)(26005)(10290500003)(478600001)(76116006)(5660300002)(66946007)(66446008)(52536014)(8676002)(66476007)(66556008)(41300700001)(8936002)(7416002)(7406005)(64756008)(110136005)(316002)(54906003)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R5+e7SupFUnzZyfiwfKl1M3MNvJpeUu9Do7IPqLLrt0pv29aEg/j4iNepKLi?=
 =?us-ascii?Q?MrpTdagWvtCZ85Dl8itOCk+kFTKInx4itYoIwdKx6IY2ds5uiKECwDkHRawk?=
 =?us-ascii?Q?0jKHaSYp+RwYujF1npfFlsPgw5leC7RIOyIUGhh7i+uEdcXpk+4TsoFM+tFf?=
 =?us-ascii?Q?yFWpgyBjE1/jKY9Ts6H2MqfyeV5/V490CLoM+QeQoXS0w6G36R8Vutx486yQ?=
 =?us-ascii?Q?JqIdpWX4B4CWr3Nw3BSmtJfIdRFfjbh3JPNmUsWHAMJok5lWidc8uNhQqe6H?=
 =?us-ascii?Q?l3RkcHU/H2UDPWRu+YyYGhfmfRI0wNZNFbm8gfV6CQW8+0FXlTguReXZjTVF?=
 =?us-ascii?Q?2XJxXYyIO6SypI/f+g+/y3GGb7IwspRPAivCDYlKKh4eT8SBm9TGMXFRMRJC?=
 =?us-ascii?Q?cHUjCoSBJbSNE6++PVovIzQvRSOOkM//TJyG3pA7vOoj78HMBM8gjYloDwPd?=
 =?us-ascii?Q?wELfskLsTRCDK+qEcIijD+RfxQqZqblbRvFXUQNR7mBBbzxaHcVAy028vscq?=
 =?us-ascii?Q?rcWqHEVj38cFZETVx5u70acWNHH6Wty0tedNvgQ4l7EXhLw3y5ZxKkTXVRum?=
 =?us-ascii?Q?O3Ipov3xKu9MmcDcZWQKDSixvWjmbim6XEq/tEII1DotcTMvA9Ps+fiKkWH0?=
 =?us-ascii?Q?989GhpCm+GVPYj9Vy1DTDR9mJvH4IQNTkB7CXCscXPIhEumxCchCTmMpY3qm?=
 =?us-ascii?Q?WG6DaeFCc7KCHWvQMXrx7im4m9gwOlZKqXodsBzHp49FOjODygCjPDdURiL4?=
 =?us-ascii?Q?nVhg3BVLVpy6SlxtNY1ZcajlOosXHrzF+Mnh3TrIdvkkXUDtoyY5dVSzIysq?=
 =?us-ascii?Q?3gF31hYIEjT7d1l3R3F2I8Z/ZHgqXBJBvKpxa08XyxzEj9roefdFDAvJM+6p?=
 =?us-ascii?Q?t4NiqCwhSAnAJrwAhEabM/2vdFPDcl7xnMfrskowIpHPLT0LgWAKhQxthUSv?=
 =?us-ascii?Q?74OgxMeE3m3KO5kaq+UZh8+BOqxvYoZPu0wzai5Sq9jSVoQkfngKwRimZUF9?=
 =?us-ascii?Q?JWuvOia90Gs63GIvVX3oQdZ7Mpr7wpLHxo+iuqsn9V3aEucKsnUU1Q+eFOrA?=
 =?us-ascii?Q?Hb0lZ6KUsNFmFUIesPIJBbBEPk6V7cVyTqulJGGHy8kFuE/wAF05oCoUNgVL?=
 =?us-ascii?Q?vOfhed+/OaAKs7luUrhaoUjDv0/op7RZgVUkhE4kNR6xI5i4IpXBSrHNXUaz?=
 =?us-ascii?Q?QMqPCESNTR4mkfFUKjS8ljj6PW94NM/gfyudU6EsEgKinkCIb0PPvAdS/uVD?=
 =?us-ascii?Q?cZ5GBMWhth4zPDe1eS3Qd1Za2mn1WEN/eXN0SJQgUZ13aoO7HjcujieJWZN1?=
 =?us-ascii?Q?j63YKvwLyb4ILyxX92PfKDI72aV9rfB+p0EDzjYU6N0ZciGmbdnC7fzwIv0b?=
 =?us-ascii?Q?xehqstb7QKHXhbgWpoHUvOm/fRbDjbo8NHOiwNRSo4R3wpTWIhAC0oEZCxyX?=
 =?us-ascii?Q?wADWHWmvSiUfwiTv2I/DmiQKbvNM0cKtOLv/mxXaAQM79Sye1woOsHnPQAuH?=
 =?us-ascii?Q?JSGHuIuE1bE8zSo4bk5L/F+sMoM9D17Kv+bW6UTRv7v4rAnAjp97wAlq5tZo?=
 =?us-ascii?Q?ob1+EBSa6nFX2UU8jSXdgY7U6/DqU6757jU103d6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7284d6-3589-4879-8f06-08dba390c07a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 04:23:50.2600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nC9dx5OfHpnZmmPOCG3Pf8v4e1YSL57xpusZOmrxru4wUM2Yo8T6630xYnkxMgtGf3Os3a+h1dcjqwAdfltHAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3736
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Monday, August 21, 2023 12:33 PM
>  [...]
> From: Dexuan Cui <decui@microsoft.com> Sent: Sunday, August 20, 2023
> >
> > The new variable hyperv_paravisor_present is set only when the VM
> > is a SNP/TDX with the paravisor running: see ms_hyperv_init_platform().
> >
> > In many places, hyperv_paravisor_present can replace
>=20
> You said "In many places".  Are there places where it can't replace
> ms_hyperv.paravisor_present?  It looks like all the uses are gone
> after this patch.

Sorry for the inaccuracy. I meant to say "everywhere" rather than
"In many places".  I think hyperv_paravisor_present and
ms_hyperv.paravisor_present can be used interchangeably except that
I need to use hyperv_paravisor_present in arch/x86/include/asm/mshyperv.h
to avoid the header file dependency issue.

As we discussed offline, we'll add some hypercall function structure in fut=
ure
for different VM types, and then hyperv_paravisor_present and
ms_hyperv.paravisor_present would go away when we make hypercalls.

So let me use hyperv_paravisor_present only in
arch/x86/include/asm/mshyperv.h to make the patch smaller.

> > ms_hyperv.paravisor_present, and it's also used to replace
> > hv_isolation_type_snp() in drivers/hv/hv.c.
> >
> > Call hv_vtom_init() when it's a VBS VM or when hyperv_paravisor_present
> > is true (i.e. the VM is a SNP/TDX VM with the paravisor).
> >
> > Enhance hv_vtom_init() for a TDX VM with the paravisor.
> >
> > The biggest motive to introduce hyperv_paravisor_present is that we
> > can not use ms_hyperv.paravisor_present in
> arch/x86/include/asm/mshyperv.h:
> > that would introduce a complicated header file dependency issue.
>=20
> The discussion in this commit messages about hyperv_paravisor_present
> is a bit scattered and confusing.  I think you are introducing the global
> variable
> to solve the header file dependency issue.  Otherwise, the ms_hyperv fiel=
d
> would be equivalent.  Then you are using hyperv_paravisor_present for
> several purposes, including to decide whether to call hv_vtom_init() and
> to simplify the logic in drivers/hv/hv.c.  Maybe you could reorganize
> the commit message a bit to be more direct regarding the purpose.

The new changelog will be:

    x86/hyperv: Introduce a global variable hyperv_paravisor_present

    The new variable hyperv_paravisor_present is set only when the VM
    is a SNP/TDX VM with the paravisor running: see ms_hyperv_init_platform=
().

    We introduce hyperv_paravisor_present because we can not use
    ms_hyperv.paravisor_present in arch/x86/include/asm/mshyperv.h:

    struct ms_hyperv_info is defined in include/asm-generic/mshyperv.h, whi=
ch
    is included at the end of arch/x86/include/asm/mshyperv.h, but at the
    beginning of arch/x86/include/asm/mshyperv.h, we would already need to =
use
    struct ms_hyperv_info in hv_do_hypercall().

    We use hyperv_paravisor_present only in include/asm-generic/mshyperv.h,
    and use ms_hyperv.paravisor_present elsewhere. In the future, we'll
    introduce a hypercall function structure for different VM types, and
    at boot time, the right function pointers would be written into the
    structure so that runtime testing of TDX vs. SNP vs. normal will be
    avoided and hyperv_paravisor_present will no longer be needed.

    Call hv_vtom_init() when it's a VBS VM or when ms_hyperv.paravisor_pres=
ent
    is true, i.e. the VM is a SNP VM or TDX VM with the paravisor.

    Enhance hv_vtom_init() for a TDX VM with the paravisor.

    In hv_common_cpu_init(), don't decrypt the hyperv_pcpu_input_arg
    for a TDX VM with the paravisor, just like we don't decrypt the page
    for a SNP VM with the paravisor.

BTW, please refer to the link for the v3 version of this patch (WIP):

> > In arch/x86/include/asm/mshyperv.h, _hv_do_fast_hypercall8()
> > is changed to specially handle HVCALL_SIGNAL_EVENT for a TDX VM with
> the
> > paravisor, because such a VM must use TDX GHCI (see hv_tdx_hypercall())
> > for this hypercall. See vmbus_set_event() -> hv_do_fast_hypercall8() ->
> > _hv_do_fast_hypercall8() -> hv_tdx_hypercall().
>=20
> Embedding the special case for HVCALL_SIGNAL_EVENT within
> hv_do_fast_hypercall8() is not consistent with how this special case
> is handled for SNP.  For SNP, the special case is coded directly into
> vmbus_set_event().  Any reason not to do the same for TDX + paravisor?

Ok, will handle it directly in vmbus_set_event().

> > @@ -497,13 +497,29 @@ int hv_snp_boot_ap(int cpu, unsigned long
> start_ip)
> >
> >  void __init hv_vtom_init(void)
> >  {
> > +	enum hv_isolation_type type =3D hv_get_isolation_type();
> >  	/*
> >  	 * By design, a VM using vTOM doesn't see the SEV setting,
> >  	 * so SEV initialization is bypassed and sev_status isn't set.
> >  	 * Set it here to indicate a vTOM VM.
> >  	 */
>=20
> The above comment applies just to the case HV_ISOLATION_TYPE_SNP,
> not to the entire switch statement, so it should be moved under the
> case.

Will fix.

> > [...]
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
[...]
> > @@ -134,7 +135,9 @@ static inline u64 _hv_do_fast_hypercall8(u64
> control, u64 input1)
> >  	u64 hv_status;
> >
> >  #ifdef CONFIG_X86_64
> > -	if (hv_isolation_type_tdx())
> > +	if (hv_isolation_type_tdx() &&
> > +		(!hyperv_paravisor_present ||
> > +		 control =3D=3D (HVCALL_SIGNAL_EVENT |
> HV_HYPERCALL_FAST_BIT)))
>=20
> See comment above.  This would be more consistent with SNP if it were
> handled directly in vmbus_set_event().

Will fix.

> > --- a/drivers/hv/connection.c
> > +++ b/drivers/hv/connection.c
> > @@ -484,7 +484,7 @@ void vmbus_set_event(struct vmbus_channel
> *channel)
> >
> >  	++channel->sig_events;
> >
> > -	if (hv_isolation_type_snp())
> > +	if (hv_isolation_type_snp() && hyperv_paravisor_present)
>=20
> This code change seems to be more properly part of Patch 9 in the
> series when hv_isolation_type_en_snp() goes away.

The change here is part of the efforts to correctly support hypercalls for
a TDX VM with the paravisor. Patch 9 is just a clean-up patch, which is
not really required for a TDX VM (with or with the paravisor) to run on
Hyper-V, so IMO it's better to keep the change here in this patch.

BTW, please refer to the link for the v3 version of this patch (WIP):


