Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7119D6F8703
	for <lists+linux-arch@lfdr.de>; Fri,  5 May 2023 18:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjEEQs7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 May 2023 12:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjEEQs5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 May 2023 12:48:57 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021023.outbound.protection.outlook.com [52.101.57.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8ED13843;
        Fri,  5 May 2023 09:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hc49RfYPp2pAr0JiS8WbOOx3yoGsa6ZnzTsLB8nN04Ol+MNOjQMIK8AUViB3Cb02v/MOeKhzN4C6DmLzx3DmT0ms7pn2xpxUJUPNV6+1ukP699+cmt0qKpOUZq2s1IdifWzlviguaQjHQq83aDwVpWwoVSt/fCWZGOYzTxeQ9UqyBkFBTPADErqHKrvsFmhUpGNGxMxkUASp0C0Ncy4EULNt+9BxAUzXCN2VXL45A0qiMrd4KoHENe+g0IImHDq1iLHCEZ1AFo3Eu6JBDCMffltH3GJFPcrFIUAoTykO4cUphnaJch1fWjmMKoiJGPQEfToLaum3xg2CcbB2ZsR3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huNVpoC7tuqMj0/IBw7ZoCAmfosz7ZhIRth1nHjTbIU=;
 b=abETiCMY/u8bXt2kMED3C94ScbM0c9VlZBk2VSpZwFCuweX5Xl/7vPc099A5FlmR8ASzvsW3lKA48TfY2SHuy+rwqBkPc7FQcV6nB/Enbalh0kls4npOfg8yhFWhF8CN+Z8hqjFTUF0yAZG/2g5PA7r2jb4Vp3dXms41iWTkeSwH5OhRrBuVnEkwrypn/opeNOdlnx2Pr2a0nrA+uEU+PKr6m6UTQNaEg/dIYEp3pCTcMnbo9FwIBjRcV0O16POAqEYOSNrvt+IMiPKoujXohxn4EpqABaH4q0eevEdmlOjZLwRX9mq7OMZbD/HCRtJYk69tDjJY15QkGR8F2HBP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huNVpoC7tuqMj0/IBw7ZoCAmfosz7ZhIRth1nHjTbIU=;
 b=OQhzlvUIlE8mUiWet4c5SpT4e3UDT0sgTnfUZ1yO8CG8XETfQ/zzKNxE4eO21YMFt2mF5j1uT3/vRvEWGn0yfh5XWFuV7IurNLKQ1jHz2FFq9hYENZTdDUvrv7Yy7IV47fEx1GKRXsbAIY2OXxzDy24kz9tqmyKiRRLlaDgj1Ac=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MW4PR21MB2074.namprd21.prod.outlook.com (2603:10b6:303:121::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.12; Fri, 5 May
 2023 16:48:49 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c454:256a:ce51:e983]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c454:256a:ce51:e983%4]) with mapi id 15.20.6387.012; Fri, 5 May 2023
 16:48:48 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
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
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: RE: [PATCH v6 5/6] Drivers: hv: vmbus: Support TDX guests
Thread-Topic: [PATCH v6 5/6] Drivers: hv: vmbus: Support TDX guests
Thread-Index: AQHZfttz9He9zHooa0q8pB8usY0kq69L3DoAgAAHi5A=
Date:   Fri, 5 May 2023 16:48:48 +0000
Message-ID: <SA1PR21MB13353EFB8027FC834F7E4348BF729@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230504225351.10765-1-decui@microsoft.com>
 <20230504225351.10765-6-decui@microsoft.com>
 <BYAPR21MB16888F04BF0761A44396FF90D7729@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB16888F04BF0761A44396FF90D7729@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ca619e06-5cc5-479d-93c2-cdb8176563ea;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-05T16:16:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MW4PR21MB2074:EE_
x-ms-office365-filtering-correlation-id: ec4ab1c3-1f80-44f4-f137-08db4d88993d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c55UF+I7pSk1nApYoMgTk0kfUA7PFCdVqRNop7+1EFjURj54t+HvM4N9pTSymEuQN5c8LSE80xj343Iv5UlIRLhi3l3Rwm/gMOpmTCTVOX5M8IfQ/NnxhfqZG1KqiDQVKklW0h5aB+BZlJQ0hJx0P1syHHOSkud/R/G3mXSUo3ElywctNarl8OVx4GIfCx7sKsvCNeveuLglH5VFF9KuJjSfFOGumhFkRHyrL4bWen114ulm9Vdxwc/4DnJ+9h/5r28SwbrsM1dlfT0eoqxU8U9gGySbaByf6UbufmU6u1nDknzbthHFRMKFjKaH2LauJLAhyXveernFf9ItM0jPjvPg9v6Qt1r82D17nOgwljhQXEw+00fcBVm62sSZwgFXXx0fQTDTiiWt3HrtkKhOvnMx4iQG4390l9iuOPAsyquds62tXUnSbVsQtmivfrpNH+u6qoQSyG4B2QWdyYAtgxEr9pzEHXTGlPCnzygwHwS7N0ftpxYWCfGy2JWTE6E/nBoROwmTD29s+pc98uCg7CCvaf/GZR9ogtAymiBa96k3zTnNtHXueNS1lRsF6J2FQ+1xJlp01Da/auYscRTTUXChwabN8zguR2bvGffYBFGxubfxhnCWmLMj41XC+3xn9kE+hd/FfBMMjMbX0mdPCX4Da03sji80MdXUibnZk/0M2ADB6v6KAAPe63crXhys
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199021)(55016003)(8936002)(6506007)(9686003)(26005)(8676002)(7416002)(107886003)(4744005)(2906002)(83380400001)(186003)(4326008)(76116006)(478600001)(10290500003)(71200400001)(786003)(66476007)(52536014)(5660300002)(54906003)(110136005)(64756008)(66446008)(316002)(33656002)(41300700001)(66946007)(66556008)(82960400001)(86362001)(8990500004)(7696005)(38070700005)(38100700002)(82950400001)(122000001)(921005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Th23v1QIZdu2KcoRlDYCZV0PeKd9ygbAN8nqzl5UAt4tRcN+S1rLbtLS8dxG?=
 =?us-ascii?Q?PEG1q1zsiJO+zr9bfnLVwGVJoCvx4Xo1PWbQRJKoE70Yu7f2OiWVBTWgUN/J?=
 =?us-ascii?Q?XfA507mLeqai9lCrB2nGMsZAJIpGcATrHWEJo0vq17LS34Qq+rUdLXBA47xj?=
 =?us-ascii?Q?gV+ZZJUxiia+ccpqxeiPvHSnStbuGiGJKCNbs5Gdd+qjxEK+OSGTGxy9wjBg?=
 =?us-ascii?Q?6XbfF6K6Houaql8UR4ovv+meYuLdFhMKfgmhdJhRhCrvJKdNF+dRQRgB0dff?=
 =?us-ascii?Q?WZXyro6BES5bVDuutLcrwauK+aoSiXNHgQ1tKK75BA6BKizGN1nf7B6+jqmT?=
 =?us-ascii?Q?LHAx4AMg6zlFk14fOJ8qhiBQcgeRAfrOG+OqlnqJnzYZZbPlOekG4DbOcLFE?=
 =?us-ascii?Q?i6yn+GvYJACFljA18GtNwE/rPbCh171yYwRjVUYlk2k9Rrj9LSeFzGhPLZF1?=
 =?us-ascii?Q?WoNcwElYQJw8QyQvansCPLWiq2JbmsfLOo96FDvX7+r66s1r4qLuKZXa4paJ?=
 =?us-ascii?Q?tECDfI44E+oAUhiJJig46mJ5nNT4vRDGzn/g12taa6UzyT8W+8elWOmuW22Q?=
 =?us-ascii?Q?fD/xdVOJeZRK0qQF8AUqwBKM1cc92p+auy6o4WfHfPeYBR+FRiZbFl7MrD8K?=
 =?us-ascii?Q?vuThpaVKcDMPy+zU1MNFqap/TpdA+nz8wzd9sSC6XOz67mUmXvEYOdxBp+jV?=
 =?us-ascii?Q?vKSMvcUnc9Y1ECfJ+KFOaxceCsEb2jKvNPk1QQFaTyFdUW+IdWojEDciSjA/?=
 =?us-ascii?Q?SDBT/EgNPAQO8yr218rRdhT990fWV2Sj5KBfdtVB154yPqgG1fXO5qYqWDRe?=
 =?us-ascii?Q?hPtshXc6N9du4wf389JNkOpZHtE1zCm+ehffTaP+KJXLnbrMD2B3ANhCtJ+z?=
 =?us-ascii?Q?vYCprSGRGvMGI0u038bAmAuYmVXZosMsv3xG2PhcfvO5We2O+iwXwyCzYuI0?=
 =?us-ascii?Q?P451bPre0Qq7qeM53IpxZlRBjzkVkGPg0iREQaRr8m4k6V3BxKxUebxgdZRS?=
 =?us-ascii?Q?NjZ/sTX35/OX4UvcgoABl91SAdpjAjWTf7HIJk8UB3zrQf5ECBcc5Q2lzS2m?=
 =?us-ascii?Q?B2pbwb+dZxcESRRedFdbi+hZrD4S0bcn2fBJZ+DuWKu/sl0KyTkEn7CzPELC?=
 =?us-ascii?Q?wMVABAGaJ8jPvVL96uZmYTAWubDUflzbf0kQ1leo9nOuhu0ybbBVWHsczYZE?=
 =?us-ascii?Q?Ret5x5SII2Cj7g2R+YhChxCnq2xjqKlqyqi82FPogihWa29pxXP/6oOyFi83?=
 =?us-ascii?Q?uMmtZQsrzGEjAWjdSnc2V8snLsoPpvZA9l9hgzpMw6cQfp2P+Z5OwP2FTDZe?=
 =?us-ascii?Q?ZE30CyWh0YSOTY+RbxhHnvMgp7kMGgv44MO6IbN2zg8l/lg3wfZYKKZfaRH8?=
 =?us-ascii?Q?2MrA/yzSw1sEEcy+j42/zH/44XWffKPLuK0rG4IOnrZiED5FFlF7CZ4uZfTy?=
 =?us-ascii?Q?eQeOoeL+qin9jUbmSObgf2CeA9Q6FBvDpK0CdGDeAjJnbazkhobumnBN1DhA?=
 =?us-ascii?Q?TCxDkeIgamMxTfBgylwdVu4Wv1eizGM90u7c8/b7lohEkRRutvrrdIAPH8GG?=
 =?us-ascii?Q?1GRJ13a1VHhX6pUEgNiPzsfe1JrQGOoGNeUZo/3G?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4ab1c3-1f80-44f4-f137-08db4d88993d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 16:48:48.4431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7fYxHOJ5CDDxHoGAMuwiObtk2QUCRE4RwozPPPZVlulatgT98krpxOjSnuR2g2OH1dXiT1tg3R/C8LsGH9vWcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2074
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Friday, May 5, 2023 9:23 AM
> ...
> From: Dexuan Cui <decui@microsoft.com>
> >
> > Add Hyper-V specific code so that a TDX guest can run on Hyper-V:
> >   No need to use hv_vp_assist_page.
> >   Don't use the unsafe Hyper-V TSC page.
> >   Don't try to use HV_REGISTER_CRASH_CTL.
> >   Don't trust Hyper-V's TLB-flushing hypercalls.
> >   Don't use lazy EOI.
>=20
> Nit:  Actually, you overdid the cleanup. :-(  The line in v5 about
> "Share SynIC Event/Message pages" was correct.  It was only the
> part about VMBus Monitor pages that no longer applied.

Sorry, so here we need to add a line after the line "Don't use lazy EOI":
     Share SynIC Event/Message pages with the host.

I suppose the maintainer(s) can help add this line, if possible.

> >
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > ---
> > ...
> ...
> Commit message nit notwithstanding --
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Thanks!=20
