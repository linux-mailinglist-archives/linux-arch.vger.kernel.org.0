Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDAF64A7F4
	for <lists+linux-arch@lfdr.de>; Mon, 12 Dec 2022 20:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbiLLTKy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Dec 2022 14:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLLTKx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Dec 2022 14:10:53 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2138.outbound.protection.outlook.com [40.107.94.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F356D4E;
        Mon, 12 Dec 2022 11:10:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9OdGgETwceeGFjPeH3BIKg6WWxuZg/Qd5mXI/tRfu8jKRiFTnJzLBWkHIsrQfPFAWsshTkSR2AXf8iB/LU3dWx1I7JidbnidyvOhowl59VnKT+Qe8MEdJYcD97JRZhsAcTp58QNfBS9B5Xt4687Kk8BJ17NAq4TVw+TwvyqRjAVJyQjnTIo9YyyU+8KPHHcqylOC1Ze5Nd5O4H0HTerlA31fhwKI1F4FuTC+4xfL2RA9MX/+KYylmAgyEz2Pd/UFoQWZe2rMzunokaMlObU0AUrOXXFeMHSvjMcQZBVYwvLgT6ulOY5NBeC/dItijaamBj/vqmwVVoubQPzKP8qsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laoqCG3NzLU7+g81j/0p8ZiJzc3CKqCasu0h4qKRH08=;
 b=kGeDhV2aLeEn6pydHJvW+P+SBdBaD38+ic0vDyNj9SKB0IIjAK4oD8UjP9TtK/mvZPMUz4+jBM7gtQazqvaXKIKiMANo5uoMt6MQdk1X53NazczT4k6kB0HMGWZXnWY+8c5cNXadl3fMR5k25qvRs3T3wKe3TQWYmFyQVCrDP7PdIfUGnaBv3GQDfaz+dodpEAsWeEva3BPbUaP186EBKg3YzJ4KrZInPiYP3FjNqPomsTLYqFjaWl7kptTPoC+Pv5D6Ns3qJAUuTFhUwHME3utDYu4qZwJZA7iGA8BIdG7v6S/eFySX1q/xFvg0UW2+nhGb69Cy+MYw4KRwbNIjYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laoqCG3NzLU7+g81j/0p8ZiJzc3CKqCasu0h4qKRH08=;
 b=d7Nks47JwSS+ys1jyQYcs0XHHzdrJb1mR2lrDHBfdk6wfJJ6wE82AiS1Egx7FtWRlbQFOPJYkC03Fb6FD5p1vphJbpWAWlhYuGtMwqI5mOmna672SGZ5g8wZTbMs1/baZUU8f9qiHNZ1qkCg3C9d+rywY+LYzFIUQhyLML1ToVM=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SJ0PR21MB1293.namprd21.prod.outlook.com (2603:10b6:a03:3e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.1; Mon, 12 Dec
 2022 19:10:49 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%7]) with mapi id 15.20.5944.001; Mon, 12 Dec 2022
 19:10:49 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
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
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Topic: [PATCH v2 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Index: AQHZCdO5oF6MXqWJVEq1rq5J7Jhdia5qe3MggAAotfA=
Date:   Mon, 12 Dec 2022 19:10:49 +0000
Message-ID: <SA1PR21MB1335DAC0BCE28CC5306D8019BFE29@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221207003325.21503-1-decui@microsoft.com>
 <20221207003325.21503-6-decui@microsoft.com>
 <BYAPR21MB16880DC440AF1E9FF8DD6FBAD7E29@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB16880DC440AF1E9FF8DD6FBAD7E29@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8dbf0f0c-bea9-4e95-9714-924839bc110d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-12T16:34:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SJ0PR21MB1293:EE_
x-ms-office365-filtering-correlation-id: 4711bd37-1631-4fc4-ae4e-08dadc749479
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SGck/d/AdyoyKlV6lYzk9Si41dkuJmZdMz/C7m5Un6+lZt59F84VehveZdUbCnWwuMXI69TP9C+IXKNigAYP+BXpryQms0xkHHWfHay0gTiWj5goLBIC+Z4E9dfOKipYgFwUhlcH9xTuFxotqUODBjnpKqmW4QF1+NoUUvExQ3wCF6rV9heBIHKtfcCLDa0Nc+FjsvQJPlS6LFOreZJEVm586fGzeWCcV967p3vtSJK6rgiGKnD7FF45ZO+NfyRPtCD902uSJrhgGG/CaNpZXhrGel5zTOk3k0FKRozq2Rt6BAd3TvLExrPtXAzw78DU/GLuI5645E7WMw1ErUMWMedj+SfJcwvTOeHaNw1S2bDBlkiAFiQxgnAT3rLac/EQsedpFcplnEevxaTY35LEYBxexQFvI1NX55r6vUWM4hADmCSdUuU1LM6NKy+xlLWRFS11KmYx3I0Tn0LZamwW2oq+Xv1O5Q+r5uBYZWo5d00FMJPO8L1k9BaaWdY7tCmo0rxz+ovRcn/BpOc2cy4gtMoZnqMlwDeLAfwWN/MHaXFChb6EVFbBQDegvEbmSMn18wqxQotQPnQOPdCYkfU3ixTfK9Rfv8Amcm+BpUigfYs5KLCHoHiSkuCjOjx7m8/f9guIY9FNrflW81FuDZZ0wXPm5NBOYwLG9AlS6O7YREnmlY6uX+oowp31w6BjKPB2+YZnZGLrQTcXNKtTqCcouvOTCX1izqM1ujSJpSCAZ1PqHn6cPuOZGE3tQlF2Jbd0zP+U8FEurOKLwPcoGkgOlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199015)(7416002)(4744005)(2906002)(8990500004)(66476007)(4326008)(66556008)(64756008)(66446008)(8676002)(41300700001)(316002)(71200400001)(66946007)(8936002)(76116006)(10290500003)(110136005)(6506007)(7696005)(186003)(33656002)(55016003)(38100700002)(83380400001)(478600001)(9686003)(26005)(82950400001)(82960400001)(122000001)(38070700005)(921005)(52536014)(5660300002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W5XVfO6UYHlXh6ear9FxrzqF6gDixAHw1VxhTVyrc+j5NeIFcVRJ5lhdKev7?=
 =?us-ascii?Q?85uj9eBMjgL5Sc7LLU3ExK7u3VhqXYOh5EbhpkFCB9tbWJxEV/VG057t/gKb?=
 =?us-ascii?Q?5VT5eL43Z6vEllIt7FXOK2jJxpvxHJf6zHPSOQvqCOCXzEc2G8JwMgB1+ViD?=
 =?us-ascii?Q?P0WQOpR5GEvyeA5Ihi3fd9h3cy/YTBwNDosfMcCyNu83rZPgudaFACE1gCk0?=
 =?us-ascii?Q?DKKuhw4udDpzGeO7eiD4+YwgTJ7G097f33cMssNtFKfDdSOcnqJcqiMaJLnr?=
 =?us-ascii?Q?/FfhZuuTI/eXkXFKwW2lTjxu7fZ5U517DEOIdGzzS6r69k67Um1Q5RxBfD4Z?=
 =?us-ascii?Q?fxgdnekypFDjmCLzNX+F/CKAmGgjrrS7efqQOXi6yZkgEESK53PvwahNBKHT?=
 =?us-ascii?Q?pR+Ojow3dsEr98yKmH3dgXWq2eF7xWp2Ze/V8A5XFz9zMSFBaGdxuEpUj0z1?=
 =?us-ascii?Q?3yyqc6qYO9gXGqAQP975N0YSSH4O1xq4yFDUDDGk2PeUUc3cufDhoSz9804S?=
 =?us-ascii?Q?8WV4/5HexUtQOnrrxh9eG5izM/Gf2aD7OKszAeFdeYPQPNdf//EZII+2JsDl?=
 =?us-ascii?Q?Ho8cFY6hMNP8vs5JHzrDCarR6Nx8KS4bL0kviqDvCBjkArI3noJPGMd9K1Ac?=
 =?us-ascii?Q?sNLxBQ0jqmKySXI+aNLGqJBSDN5zxboOMWMDXq/YJ0s2VFPQEktDeFe51/l1?=
 =?us-ascii?Q?6kgAs70ZhTkhrkkwp0dVQxAKTEjcdQmCuFaTIf/MnRZFbcvrMOydoCzgPeVo?=
 =?us-ascii?Q?X6Sso+LK2myM6yZyPgw/K6kB7El82W+Mw8H15SL9iivtu7z8lg5sTefZzun2?=
 =?us-ascii?Q?xI+DjLsuXRRY7a/jTwltx97vc0RJnA0C6WTtauFqWXNHjAY+knla/iNc5mmE?=
 =?us-ascii?Q?PbfzCO+S/Q0nr7m2i1kKiXeS5lCPv0nbQdLzAK6k+s+B3pCF+04n2hXgspG+?=
 =?us-ascii?Q?1JSEaQDIGQpm/G2P1n6gbUsVtUe+dpRYFLWxRsQRBkWWgTgUsxSzraLOt7kG?=
 =?us-ascii?Q?ymS4MqLN7o2fBsh6oHV3nVcKyJtw2bRHNOL29DQfREqFJBaV/QIjgzOfGK1S?=
 =?us-ascii?Q?6Mna2ocOvl+vSKkpZXjI6tvrjn5xmAmCwTBXFi4IIk7UDqY4B/s0XI1gp03z?=
 =?us-ascii?Q?9c6KgaTBSKQ081pQzxIwd5CJQ2tg8t7sKRferRX4Yd79Cpna2CBScwD7Nudn?=
 =?us-ascii?Q?CAjN1+gmZGhGzLm3W6Vo5obwUie+q7XpaeZWqANfa6GQ3vsj6uoMqweOszkm?=
 =?us-ascii?Q?52YtxfGzoRDlWTI87r8r0BtIhXmia3CSCCoDVXdJSJeWnOtqKqb3cON/udW1?=
 =?us-ascii?Q?azbAimD7nkq0d58yTxT4AKHlvnLVhR5Ugnn8EXJ3ZpAUZguHauE4C02z6I8e?=
 =?us-ascii?Q?AZM89sr/zmhgxwBSiban2mxw7AT0pnwI2+95ykP5Sy4sJ2uQ7PPDy4JZRx4W?=
 =?us-ascii?Q?si3+bm+MQUzb55u2CNab85fL3OsQXLPzQpQx1SOxtz7qq1tSH2CNsatyKi6y?=
 =?us-ascii?Q?sterJ7vgd7tsBN50Yu5qmhTTjjayCscLeMLwcXK1JI2UkSb6emHGYTeNc24S?=
 =?us-ascii?Q?gTugZq2E4mybgkIPyJuw7Lo16n2bcUmel3J1ZQXI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4711bd37-1631-4fc4-ae4e-08dadc749479
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 19:10:49.1509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GVX08TmKzFKTuMdpXhPLumGrcvSvrNsNls9mu48gVVMyNXjJpAEktajb6E+hyZvyH4svJPkXi+7fNXs+DXAcfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1293
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
> Sent: Monday, December 12, 2022 8:39 AM
> > [...]
> > A TDX guest uses the GHCI call rather than hv_hypercall_pg.
> >
> > In hv_do_hypercall(), Hyper-V requires that the input/output addresses
> > must have the cc_mask.
>=20
> Is it a requirement that the input/output addresses refer to guest memory
> pages that have marked as shared/decrypted?  For example, I don't see

Yes.=20

> any code to mark the hyperv_pcpu_input_arg page as shared/decrypted.
> Do the use cases for the hyperv_pcpu_input_arg page just not occur in a
> TDX VM?

I missed this when sending v2, and I realized this when testing DDA.
Will get this fixed in v3.

BTW, I noticed Tianyu posted a similar patch:
[RFC PATCH V2 10/18] drivers: hv: Decrypt percpu hvcall input arg page in s=
ev-snp enlightened guest

