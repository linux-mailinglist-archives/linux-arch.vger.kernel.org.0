Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416AE6F3BD8
	for <lists+linux-arch@lfdr.de>; Tue,  2 May 2023 03:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjEBBeY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 21:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjEBBeX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 21:34:23 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020015.outbound.protection.outlook.com [52.101.61.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23ADE6A;
        Mon,  1 May 2023 18:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+AdbNuu1sQLnBPirTOWGM7M6Vb5Mjed0hczmI6iX1My0Bre6YPIgVFPpN/876Fz1wbX3FIFZOfGvT9QBK4+cYLDzFMbRtk9baOu4SNIkmxAQe/uOIPapOMhpSJuY4jiR11JRAnPcidBWrAENbOm7+q03J8f0Lh5FhenZUOiLeljw1v67TniitBMGx4ln/tQyhU9+0d6oDSU+Gu+Z5dVKMReftOBItDuEVw354fE3IUXyy3l6AVpCL2r116TaTAA7p/5sKUaJSf8TDs90gaJc9AxQzYDHtH7t9IR7lM28AYrbwLzST+TIOj3c7IF7Jin9bDofl2+lbx50wEOdhTYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pYqdPJI0R9DSHqWkrtXQAwhs3ubeyMZJS1kE9nX+PY=;
 b=mtWXFtDZE0aXH5uEt6lWogK2voL3DRYM2YCd+FMPigf7Wv1iLZtm5ROs6iXtfDnOFXYzAIIBL6XkMaefd9kMUTLcBqBc45W//9ROM/8crfiPuFD2o2F9IcAjhNE6UgjeZlgFKrZcC2WqAT1DC2BUL+aNw/+c+lIjgg4SdMjI175Lsy4OSkb58z/aBEHpI2lycHK38T7AtDAPCsS6aQKgXd5ioACfUalgrMa/cx/kwVFRh2nLqj6QGHfH3i3KEWvw3i6Be/UCXzK2OMb0smfeIUXdMIHaAt3hLDQwkH6pCgMHwVm241SqxoR0+Jpk4cVxoN77audmdKfmtrmEqkFyvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pYqdPJI0R9DSHqWkrtXQAwhs3ubeyMZJS1kE9nX+PY=;
 b=JXyefBYfF+kfmhjEyOMzWrT6C2/utlSD4Muvk9Xk2qgvSAavUBOabBp6fK0//HOlMb/5lMd/m21CUvnhPYBWT92PRgMkJNA00nUNXzbPmvIJoHVNKKc16JiQ4WWg9LO71AhEXA46WdfzlZdz3SWbdATbFUGz03EvsNY5sUmpMQY=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DM6PR21MB1531.namprd21.prod.outlook.com (2603:10b6:5:25f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.19; Tue, 2 May
 2023 01:34:18 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::eeed:da40:85cb:503]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::eeed:da40:85cb:503%7]) with mapi id 15.20.6363.018; Tue, 2 May 2023
 01:34:18 +0000
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
Subject: RE: [PATCH v5 5/6] Drivers: hv: vmbus: Support TDX guests
Thread-Topic: [PATCH v5 5/6] Drivers: hv: vmbus: Support TDX guests
Thread-Index: AQHZdMDlgRiCry573UqDSIN3qcYRLa9FtKkggAB7cdA=
Date:   Tue, 2 May 2023 01:34:18 +0000
Message-ID: <SA1PR21MB1335046F4BA2B407C9026130BF6F9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230422021735.27698-1-decui@microsoft.com>
 <20230422021735.27698-6-decui@microsoft.com>
 <BYAPR21MB16888DA20245DDBC572A2240D76E9@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB16888DA20245DDBC572A2240D76E9@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fe447994-baa8-4b2f-a2ae-c9a8aadd7e33;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-01T17:05:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DM6PR21MB1531:EE_
x-ms-office365-filtering-correlation-id: 62e759b0-171e-4484-abe4-08db4aad58b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RrPIDqZ8QgzNGKm65OZnekpaBeyK2BVSWkYS5+O+k0r/2Xty3SSpzjCnGj0i47874jaqS37M0oaLzN66Zsfnxm1SFYmfpKFvSIbyBvPPPRsCGyCYCPx4LJFB6CFIjB0V8/R04FCbjPZx/y7p1zzFvlwu0syBQGCFWqeB/rp72uulbhWU9wIzLJucO8Q0a1I7rd8MCyio8EUroPJ+OyH3rYmYndFoiHwiSBIEWb0zphhJ7bDPuAVqXWMh+003KlmcjMMcLGmDuIerwvrO93y8NsmYcFXMCxewDpNWXvdMaYkFGRy4H6o6fIwQZm0DETUwCdZrcwCrAZ+SbZCByTaqHO8uudikGJJ/aae+MtLl4WqVLlLncas56O55g+loTQfmXqOvtZJq9Eurre9mB9vEiMLLdCEV5NKQrG11tRdy9vfdhonl+8WcAODsQd110h2Ua5c73LYNYFTnXIcUeQTBoRrfFVBVRGFSX1pDtaGSlOm88SPlT4Lls7Xu1ZdyykxRm220j0IZIKLHZm+mPn+HEZLYh7XvvTPLt9xdKppfGKmsy01csaEIum0uJghnPC+Rbq1Q8dsXSIEmAL7GxBQQwS+MNvDp81I0Q+33faW4x5Sj8GpBZFKdg46iebvMj+7hpMGkbStIFPPKwqsoiLw6qyjH6V+jBkSISWr7RLCwNBmkM6gfh4aEreaDPrAzZ61D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(478600001)(107886003)(83380400001)(8990500004)(186003)(10290500003)(4326008)(64756008)(66556008)(110136005)(66476007)(76116006)(66446008)(54906003)(9686003)(71200400001)(7696005)(6506007)(786003)(316002)(66899021)(8676002)(52536014)(5660300002)(66946007)(921005)(41300700001)(82960400001)(82950400001)(7416002)(8936002)(2906002)(38100700002)(55016003)(122000001)(38070700005)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aJF+h61VYjJjqsJRkbhCr7+j6Qlsg5/9+YvfTRBEOvlBNEh2ETa8SlPyx11j?=
 =?us-ascii?Q?nZB9Dh08SsOGAhzULr0hGuJ2/hIgYtmIf6JaMQTKjhhnCdqkccJeEWEqvNCj?=
 =?us-ascii?Q?2TuqV3ikbzUfrDaA+Z7dT5GHpKdcN8EtFzQ/3h71gDl4igWH1Sl++5y38ZZ7?=
 =?us-ascii?Q?yd5KG4YnbDPq+/gswpZKefqp3tOprobxmrRBo7PiI5+A4Ql8UGCgQ2ICkyPt?=
 =?us-ascii?Q?9pqAZT3X4LZ25O0rd7XT+axlToD3fv+4N0ynyIY+HMaabQCrJaLH7gOOsCKm?=
 =?us-ascii?Q?tFciO6pacuCkd9pb/eoJFJHhpQUyIjPZVBj/kJVoX2RRjBSARqn+ZceepcXs?=
 =?us-ascii?Q?pyV0fYDm4PwlpcXNsrWDhcszil47EjqxReUWVYKJ3MzTpp4uLmiUojno7eCK?=
 =?us-ascii?Q?aZzEZINfHhqc+B+IzWvGAqllTj+xZuTYmKCOAXePAi6r4FLW8X5rN/DQImak?=
 =?us-ascii?Q?lyJJzXFnqj9UScSara+C6SiZIwvbLjsv0mtov6w25WAWZlB03WXi9UFZKq/D?=
 =?us-ascii?Q?5BMv5FoA4TTcrt67h2beLCVkio6vUljG2+vo17BN9ZiBYXDoTvViKV3lbzOL?=
 =?us-ascii?Q?HdaaXpkMoQcJxu4I+USRgwC8D88YZ4cyR5gqPmkVS3Dr5r3mgTK0kU5e1x43?=
 =?us-ascii?Q?7ic/Lc+eEKHq63aOmpubKLtC0j/ET+5p9SixdE1oYHZqZvlR8jxKVfQAJP7G?=
 =?us-ascii?Q?Zy7V9on5sIRoeYXcerKPmUi+rEsd2TwwDursLjqGmDelx84UQfuVNdsKxcus?=
 =?us-ascii?Q?56eJAHxhX2tyJm1WEY5tKQcE88KJscmkk444giOIUHOTpUA6dKKh20yYJXaZ?=
 =?us-ascii?Q?mQWdGGdqu60NTn/DACcWuVhG0encze7UnixXgEazUd0f5BqHon13VJsQDAtH?=
 =?us-ascii?Q?5hpH2wJPIhuvGRKJxRRo0eAZ9Az/cL3nj0hKKQRWVbwBgQpDOPo9R0g6OGB/?=
 =?us-ascii?Q?wtpuUZMi63efUgkAX7vn5ZZQi34WxmxB2/ec6gFkSa9HZIhk/GLeEsbgc5+3?=
 =?us-ascii?Q?iSIeVZPQF1X1mqCu0oGhMJSSSqSCekNmmLUUIG04424HZEB2HDBFgiHa30co?=
 =?us-ascii?Q?POhFqmkpakzZxue5Tsr4NzCfKU3P8BBn0SF2cf5LdjU4hsLxElMjIjnE0EiE?=
 =?us-ascii?Q?qR7GgXQt/ldeAjHUgM+LIfjTKTJCCHIFNnnZYiZRPuqFqBWdEZ+ulRGl9waG?=
 =?us-ascii?Q?ou9cox89uWH2DMHddrBZvsCD5s2gfPusUZVw8m2GiGLhoYYVW822eNZPIVVd?=
 =?us-ascii?Q?aFH1mhQ6XKL5YYVhR6eL9ujZVM+gw9/DYfK4ameawVcZ2gPQwh5Wt/atl+Rq?=
 =?us-ascii?Q?vXXqV1VStm9d2FSrMWqWWj6rHsLT5sLBD4Z0N3Ou85Sw0G5RKDUxvlUIPrjF?=
 =?us-ascii?Q?ct3+mKJUXFsZ/GmPh1xwfgk8It5oIn7AdIJXdPDlnJnI2RC90EizviHOj99r?=
 =?us-ascii?Q?Dqjaw4RC+k0z3Tb8pOJ9HMMzYheCblD5u/l6A3eTLXhML8txR8d2ciN3xGbT?=
 =?us-ascii?Q?5BJw9/k20SqypMw8U7pHjilYfn6yJBvb1YFJEomsA/NfFZvGct+YBwGxJhSF?=
 =?us-ascii?Q?V1wktI1ImJ49vPMMtbxjJd5yCLMGF0zTZZIx1B4x9I69LXwiRz60COZxKlFn?=
 =?us-ascii?Q?bpGDZxdIY6Rvrbl2sHz8myE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e759b0-171e-4484-abe4-08db4aad58b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 01:34:18.0836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rsbBEh9Snq9gAk2fd/JgNL6+u1+5eX/FfFPatcChcRAeFHwhes1FxBNwvLJtevI06zgtED6iiTlBZUoPhbMuVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1531
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Monday, May 1, 2023 10:33 AM
> ...
> From: Dexuan Cui
> >
> > Add Hyper-V specific code so that a TDX guest can run on Hyper-V:
> >   No need to use hv_vp_assist_page.
> >   Don't use the unsafe Hyper-V TSC page.
> >   Don't try to use HV_REGISTER_CRASH_CTL.
> >   Don't trust Hyper-V's TLB-flushing hypercalls.
> >   Don't use lazy EOI.
> >   Share SynIC Event/Message pages and VMBus Monitor pages with the
> >  host.
>=20
> This patch no longer does anything with the VMBus monitor pages.
Sorry, I forgot to update the commit log. Will drop this from the log.

> >   Use pgprot_decrypted(PAGE_KERNEL)in hv_ringbuffer_init().
>=20
> The above line in the commit message is stale and can be dropped.
Will drop this from the commit log.

> > @@ -116,6 +117,7 @@ int hv_synic_alloc(void)
> >  {
> >  	int cpu;
> >  	struct hv_per_cpu_context *hv_cpu;
> > +	int ret =3D -ENOMEM;
> >
> >  	/*
> >  	 * First, zero all per-cpu memory areas so hv_synic_free() can
> > @@ -159,6 +161,28 @@ int hv_synic_alloc(void)
> >  				goto err;
> >  			}
> >  		}
> > +
> > +		/* It's better to leak the page if the decryption fails. */
> > +		if (hv_isolation_type_tdx()) {
> > +			ret =3D set_memory_decrypted(
> > +				(unsigned long)hv_cpu->synic_message_page, 1);
> > +			if (ret) {
> > +				pr_err("Failed to decrypt SYNIC msg page\n");
> > +				hv_cpu->synic_message_page =3D NULL;
> > +				goto err;
> > +			}
> > +
> > +			ret =3D set_memory_decrypted(
> > +				(unsigned long)hv_cpu->synic_event_page, 1);
> > +			if (ret) {
> > +				pr_err("Failed to decrypt SYNIC event page\n");
> > +				hv_cpu->synic_event_page =3D NULL;
> > +				goto err;
> > +			}
>=20
> The error handling still doesn't work quite correctly.   In the TDX case,=
 upon
> exiting this function, the synic_message_page and the synic_event_page
> must
> each either be mapped decrypted or be NULL.  This requirement is so
> that hv_synic_free() will do the right thing in changing the mapping back=
 to
> encrypted.  hv_synic_free() can't handle a non-NULL page being encrypted.
>=20
> In the above code, if we fail to decrypt the synic_message_page, then set=
ting
> it to NULL will leak the page (which we'll live with) and ensures that
> hv_synic_free()
> will handle it correctly.  But at that point we'll exit with synic_event_=
page
> non-NULL and in the encrypted state, which hv_synic_free() can't handle.
>=20
> Michael

Thanks for spotting the issue!=20
I think the below extra changes should do the job:

@@ -121,91 +121,102 @@ int hv_synic_alloc(void)

        /*
         * First, zero all per-cpu memory areas so hv_synic_free() can
         * detect what memory has been allocated and cleanup properly
         * after any failures.
         */
        for_each_present_cpu(cpu) {
                hv_cpu =3D per_cpu_ptr(hv_context.cpu_context, cpu);
                memset(hv_cpu, 0, sizeof(*hv_cpu));
        }

        hv_context.hv_numa_map =3D kcalloc(nr_node_ids, sizeof(struct cpuma=
sk),
                                         GFP_KERNEL);
        if (hv_context.hv_numa_map =3D=3D NULL) {
                pr_err("Unable to allocate NUMA map\n");
                goto err;
        }

        for_each_present_cpu(cpu) {
                hv_cpu =3D per_cpu_ptr(hv_context.cpu_context, cpu);

                tasklet_init(&hv_cpu->msg_dpc,
                             vmbus_on_msg_dpc, (unsigned long) hv_cpu);

                /*
                 * Synic message and event pages are allocated by paravisor=
.
                 * Skip these pages allocation here.
                 */
                if (!hv_isolation_type_snp() && !hv_root_partition) {
                        hv_cpu->synic_message_page =3D
                                (void *)get_zeroed_page(GFP_ATOMIC);
                        if (hv_cpu->synic_message_page =3D=3D NULL) {
                                pr_err("Unable to allocate SYNIC message pa=
ge\n");
                                goto err;
                        }

                        hv_cpu->synic_event_page =3D
                                (void *)get_zeroed_page(GFP_ATOMIC);
                        if (hv_cpu->synic_event_page =3D=3D NULL) {
                                pr_err("Unable to allocate SYNIC event page=
\n");
+
+                               free_page((unsigned long)hv_cpu->synic_mess=
age_page);
+                               hv_cpu->synic_message_page =3D NULL;
+
                                goto err;
                        }
                }

                /* It's better to leak the page if the decryption fails. */
                if (hv_isolation_type_tdx()) {
                        ret =3D set_memory_decrypted(
                                (unsigned long)hv_cpu->synic_message_page, =
1);
                        if (ret) {
                                pr_err("Failed to decrypt SYNIC msg page\n"=
);
                                hv_cpu->synic_message_page =3D NULL;
+
+                               /*
+                                * Free the event page so that a TDX VM won=
't
+                                * try to encrypt the page in hv_synic_free=
().
+                                */
+                               free_page((unsigned long)hv_cpu->synic_even=
t_page);
+                               hv_cpu->synic_event_page =3D NULL;
                                goto err;
                        }

                        ret =3D set_memory_decrypted(
                                (unsigned long)hv_cpu->synic_event_page, 1)=
;
                        if (ret) {
                                pr_err("Failed to decrypt SYNIC event page\=
n");
                                hv_cpu->synic_event_page =3D NULL;
                                goto err;
                        }

                        memset(hv_cpu->synic_message_page, 0, PAGE_SIZE);
                        memset(hv_cpu->synic_event_page, 0, PAGE_SIZE);
                }
        }

        return 0;
 err:
        /*
         * Any memory allocations that succeeded will be freed when
         * the caller cleans up by calling hv_synic_free()
         */
        return ret;
 }

I'm going to use the below (i.e. v5 + the above extra changes) in v6.
Please let me know if there is still any bug.

@@ -116,6 +117,7 @@ int hv_synic_alloc(void)
 {
        int cpu;
        struct hv_per_cpu_context *hv_cpu;
+       int ret =3D -ENOMEM;

        /*
         * First, zero all per-cpu memory areas so hv_synic_free() can
@@ -156,9 +158,42 @@ int hv_synic_alloc(void)
                                (void *)get_zeroed_page(GFP_ATOMIC);
                        if (hv_cpu->synic_event_page =3D=3D NULL) {
                                pr_err("Unable to allocate SYNIC event page=
\n");
+
+                               free_page((unsigned long)hv_cpu->synic_mess=
age_page);
+                               hv_cpu->synic_message_page =3D NULL;
+
                                goto err;
                        }
                }
+
+               /* It's better to leak the page if the decryption fails. */
+               if (hv_isolation_type_tdx()) {
+                       ret =3D set_memory_decrypted(
+                               (unsigned long)hv_cpu->synic_message_page, =
1);
+                       if (ret) {
+                               pr_err("Failed to decrypt SYNIC msg page\n"=
);
+                               hv_cpu->synic_message_page =3D NULL;
+
+                               /*
+                                * Free the event page so that a TDX VM won=
't
+                                * try to encrypt the page in hv_synic_free=
().
+                                */
+                               free_page((unsigned long)hv_cpu->synic_even=
t_page);
+                               hv_cpu->synic_event_page =3D NULL;
+                               goto err;
+                       }
+
+                       ret =3D set_memory_decrypted(
+                               (unsigned long)hv_cpu->synic_event_page, 1)=
;
+                       if (ret) {
+                               pr_err("Failed to decrypt SYNIC event page\=
n");
+                               hv_cpu->synic_event_page =3D NULL;
+                               goto err;
+                       }
+
+                       memset(hv_cpu->synic_message_page, 0, PAGE_SIZE);
+                       memset(hv_cpu->synic_event_page, 0, PAGE_SIZE);
+               }
        }

        return 0;
@@ -167,18 +202,40 @@ int hv_synic_alloc(void)
         * Any memory allocations that succeeded will be freed when
         * the caller cleans up by calling hv_synic_free()
         */
-       return -ENOMEM;
+       return ret;
 }


 void hv_synic_free(void)
 {
        int cpu;
+       int ret;

        for_each_present_cpu(cpu) {
                struct hv_per_cpu_context *hv_cpu
                        =3D per_cpu_ptr(hv_context.cpu_context, cpu);

+               /* It's better to leak the page if the encryption fails. */
+               if (hv_isolation_type_tdx()) {
+                       if (hv_cpu->synic_message_page) {
+                               ret =3D set_memory_encrypted((unsigned long=
)
+                                       hv_cpu->synic_message_page, 1);
+                               if (ret) {
+                                       pr_err("Failed to encrypt SYNIC msg=
 page\n");
+                                       hv_cpu->synic_message_page =3D NULL=
;
+                               }
+                       }
+
+                       if (hv_cpu->synic_event_page) {
+                               ret =3D set_memory_encrypted((unsigned long=
)
+                                       hv_cpu->synic_event_page, 1);
+                               if (ret) {
+                                       pr_err("Failed to encrypt SYNIC eve=
nt page\n");
+                                       hv_cpu->synic_event_page =3D NULL;
+                               }
+                       }
+               }
+
                free_page((unsigned long)hv_cpu->synic_event_page);
                free_page((unsigned long)hv_cpu->synic_message_page);
        }


I'll post a separate patch (currently if hv_synic_alloc() --> get_zeroed_pa=
ge() fails,
hv_context.hv_numa_map is leaked):


--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1515,27 +1515,27 @@ static int vmbus_bus_init(void)
        }

        ret =3D hv_synic_alloc();
        if (ret)
                goto err_alloc;

        /*
         * Initialize the per-cpu interrupt state and stimer state.
         * Then connect to the host.
         */
        ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online=
",
                                hv_synic_init, hv_synic_cleanup);
        if (ret < 0)
-               goto err_cpuhp;
+               goto err_alloc;
        hyperv_cpuhp_online =3D ret;

        ret =3D vmbus_connect();
        if (ret)
                goto err_connect;

        if (hv_is_isolation_supported())
                sysctl_record_panic_msg =3D 0;

        /*
         * Only register if the crash MSRs are available
         */
        if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)=
 {
@@ -1567,29 +1567,28 @@ static int vmbus_bus_init(void)
        /*
         * Always register the vmbus unload panic notifier because we
         * need to shut the VMbus channel connection on panic.
         */
        atomic_notifier_chain_register(&panic_notifier_list,
                               &hyperv_panic_vmbus_unload_block);

        vmbus_request_offers();

        return 0;

 err_connect:
        cpuhp_remove_state(hyperv_cpuhp_online);
-err_cpuhp:
-       hv_synic_free();
 err_alloc:
+       hv_synic_free();
        if (vmbus_irq =3D=3D -1) {
                hv_remove_vmbus_handler();
        } else {
                free_percpu_irq(vmbus_irq, vmbus_evt);
                free_percpu(vmbus_evt);
        }
 err_setup:
        bus_unregister(&hv_bus);
        unregister_sysctl_table(hv_ctl_table_hdr);
        hv_ctl_table_hdr =3D NULL;
        return ret;
 }

