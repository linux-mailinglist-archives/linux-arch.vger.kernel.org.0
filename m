Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F526EB68F
	for <lists+linux-arch@lfdr.de>; Sat, 22 Apr 2023 03:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjDVBFv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Apr 2023 21:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbjDVBFu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Apr 2023 21:05:50 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020023.outbound.protection.outlook.com [52.101.61.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CAF210A;
        Fri, 21 Apr 2023 18:05:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMBHeHgDuodniKwIsdjOr9hmx7/LQcUVcBk6Q76yutKvm9EC5xnevld9me2LNnxgGTuQLJNDFXpMp8Y3S8bykUahop3hiQfXhISCeUXApiOLcxwHZo+9DDuUKtcwTl40YewCHktyHnSqoOV1o8sFMXbPfZgrN+gtuuCqN1LvNfSwGWAOWJ67pW2u2+LfadPtJXNsK1rtb90t3ZpwXXmG1s0IsYm0k8d7Dq9afLbfMYXt5sMkoJyO9AEG5lyFnChpBuS2SA6Kv5jHahusWPd+wGGvrN/PVzeE491szGCrNLQ+J4H2xeRvW1it4g9azHqehVBfAZk1Yoknjuyimbw2lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlUeIwh7d4PLOrcPzvX8VJ3Gt3gsTp9lqnHf4Tf9mUM=;
 b=CSns0XP4po4fdzWodOSrx8MnwJRFHjOa5zs9aXLAaEvkI+C67uV29K2LvM/RwQTh+kA2X9kFITCDm/S+mSX0paNvnz2v/tJEGA+r514lOuWjC2ZBpWb3pfHLzr0SDXZBrzTuKSysb0jWt4hdqWdoTabtd3SR/5qMNv6vuvq0D6O4kzQW6smRuYa9KFCGtsqJ3rHztNCckGtsyV3zDXRrlnV484EKCW3Ht3GrCj/0ib/2CLOG1wL+ugqG645IVOVOfcbhRL0BrOUFk5iQfgFHZcfbdjEfLaOePs9gmzU0R+SWbNrqqC+HgLW5w8D2WNvK8rkftAu4kQyT+XFQKn83Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlUeIwh7d4PLOrcPzvX8VJ3Gt3gsTp9lqnHf4Tf9mUM=;
 b=gE+WH/PMGyQRF4FsQ5s785Pn3rtNYZ1xyT0suUfbd3r3OOQI/Oo/JaqIiUZtJ+SNN2G1x6hZ1PMoyu3WsIOte51VeL1+HpjUgYjsKaTstlGB/py0v0WUNl/Lpk98R629DMqYNlv42V3KwZQxLCdVWpDvwhfcwyRbXEd7nJY2oww=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SJ1PR21MB3762.namprd21.prod.outlook.com (2603:10b6:a03:451::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.14; Sat, 22 Apr
 2023 01:05:45 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::eeec:fa96:3e20:d13]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::eeec:fa96:3e20:d13%6]) with mapi id 15.20.6340.009; Sat, 22 Apr 2023
 01:05:44 +0000
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
Subject: RE: [PATCH v4 5/6] Drivers: hv: vmbus: Support TDX guests
Thread-Topic: [PATCH v4 5/6] Drivers: hv: vmbus: Support TDX guests
Thread-Index: AQHZaluiU1mCuu/uekyGswn5O4Hjua8mUv6QgBAyMuA=
Date:   Sat, 22 Apr 2023 01:05:44 +0000
Message-ID: <SA1PR21MB133529585349DB04AEB42E22BF619@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230408204759.14902-1-decui@microsoft.com>
 <20230408204759.14902-6-decui@microsoft.com>
 <BYAPR21MB16889D8C10AC1FC94BA6BC3BD79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB16889D8C10AC1FC94BA6BC3BD79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=06d623f3-0b1f-4f70-9600-5a205fdc39fd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-11T16:37:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SJ1PR21MB3762:EE_
x-ms-office365-filtering-correlation-id: 3576a383-b420-4681-777a-08db42cdb357
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 85whM476cq2D0gR1kq5h63ao6IW9fZoDUpKNeCUTmxZ/Snxav05jWOsS0SwHONsaWbWVLqj4MGQyF3QnxgCG7JVOqilqB0Px+RIGbQR+e092Oq9eJrRsdvQ15hFmr19k3nyI+jwhFYX+ImJmDCORG8fBN+jBP+IL5ewHvIQM1o1xPT8giW4uF268r3p/Ox2N78jZvXplz7IeLRya6BrmRKXr/pxFXUwUf5l+zJXLg3p9SXeLOZUQWPED7L12wvHNLb6cgUNNVJ1xYP9HGjj22dyy1mb7Clq0o3nVG1Vz9MBioBI8GA2o/kr2gNxcTuWb1i+7haJzhcuC3y+/H/bwKN/OwJzW2Cixsd0dNm6wiZ3IPJPlwoEGTsR44B30jKVHURsBjYdDR6SPXQ+7KuaVFgUwzEC13PoX4GMZhqRewNYSRbV77x4sD56MTiJRS0YPJOuvr2oDRNnms1/Fofq2N44gx/yl1MpVAwP6ent2bI4n6Nz8lULPl5gOq5Gwr7AYUqpz13OfgiAWU9sXwej4Lsi/fnkjLtsQZzewcQsnFuTjxqcbZu6OKZgfB5/YIM1vIY7Y08yJrsCaxpZo1ZxxxruUcFikWOKvhp8WSvjVhX5FgIkh+Rs9Zpd07CSNPjLhlWEXQ+sAsg45k6uWAz55IIwdWwzIbQQCAsDAuQI1dLVUEGjdXZL3t8kYcQra5qON
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(8990500004)(55016003)(66899021)(186003)(107886003)(9686003)(6506007)(8676002)(8936002)(54906003)(7416002)(52536014)(316002)(5660300002)(110136005)(86362001)(41300700001)(4326008)(786003)(38100700002)(33656002)(122000001)(38070700005)(66476007)(64756008)(66446008)(82950400001)(82960400001)(66946007)(66556008)(76116006)(921005)(7696005)(71200400001)(10290500003)(478600001)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZxRSN/0u+0GHfci7ruIVYIru2cXxu498IgziK3DuT5XCIRmKK4ro1QA49j+S?=
 =?us-ascii?Q?w0S7RVhE1PFVJ5GPW397X/wUFYCBCBrXTyfmz3ZmnGrn2HhoxCmVPI+Bx7nO?=
 =?us-ascii?Q?v017hTTd/KV4dBG/Mmt+m6leT/SAacymog4N/qviE4qwwwEkJhi20xdJKoEe?=
 =?us-ascii?Q?2pN47Ju8wTRiUd4q6pDtG5vPFiUMtTpWnzcLv/hsgSgSFBFoiT0O3FI/uckk?=
 =?us-ascii?Q?RSE1kAN84DW7WuJa6cAAUfiTJemI39lmQrmhDwbcgUy0S6JLfvCK1Zmy01qB?=
 =?us-ascii?Q?1H+o4kgB7zNWN4BKQBgan9dG2DiVoHpP0w36tnuM9PGfb1XNTrTRLoLyrUas?=
 =?us-ascii?Q?JnrUowVgHh10sjZJk8X5P7dVPPjZQBxCNnlD6kfnhAUq04x+1aim/ijgwu3X?=
 =?us-ascii?Q?5w+3Hjw4dGmxZIFqI0iOZxSNssv3JjLtkMLD78Q+WO0rDoJ16+jQuw+CpSET?=
 =?us-ascii?Q?Ln4JCMPmpQxwFYiJwsExDuANiR7yTUV4J1HxdBpNAs28IG0OxgjJUOGbd2HG?=
 =?us-ascii?Q?RxsrFEu4Eqrab2r1BB8OW813nTBxwscp+l6bJZYsghXVs7cPHLYTO4VCAjf3?=
 =?us-ascii?Q?P9EVuuD818VWIvckD9wJPUtOxlZNCPhFETeUU45izvV4gWGP6uiJao1covVk?=
 =?us-ascii?Q?yViwtjybTcKB/D0QQgRnZB91zPoDH8/58hTDcx3bnCDCfWGmgqj1ZQb8YOD2?=
 =?us-ascii?Q?RkluRSIwAeY5x8XPUtPz2eyg2E2eYLhKKm4LI8nSAhE3A4aHzclCVhFIGF1C?=
 =?us-ascii?Q?ZQcUwOGPMEtjOKXwSwrgSKGuRmBEULBXGvjH9cLbsqWz7H3FENiK3IXhyap1?=
 =?us-ascii?Q?h26bHxue5P0zRYKjN0EP7Tb1AepoddiI6MLnZfPMVI7aZiPLRLKYbaMjan88?=
 =?us-ascii?Q?sJg0ZRr05CwY2YzkCq94gPrdycevMpdIl5s/YQyPbJrWgWbrSr5cNFFgim4y?=
 =?us-ascii?Q?r36GUHkPAgvbhgJqgiMJdnGqYxRULgk5ou+IOKurbsUY1tTzTzN31G5ZR04G?=
 =?us-ascii?Q?1QUDwcEawwmToyeHn/Cl3Jhe+YTZ6+TwA8gClMfrWmdoOfXE2DKcv4prjDS0?=
 =?us-ascii?Q?ln48s5o+OEBbDBrbkeGtFO8s+49MzeWaOiUDT8bk3/O4Th0DMEUSPnlYLpzm?=
 =?us-ascii?Q?JZluy4i0fynCW16z+8+X8hWcWy8DphUjX/xlK7OM0Dy0b+1QeNw7oP73KSYU?=
 =?us-ascii?Q?ELP3INPG9yVpJBd/f4I2sY2IcLJV2y2TV6EUTBYmTBBpYyPc1PVzoodM8FnU?=
 =?us-ascii?Q?PWOTpSb3r+D8tG9RFuI92h7maWo49kKMa6nGkZZIBRXsp3/meU2RZlKwvNip?=
 =?us-ascii?Q?BKPc6Z2GjuIyW3hmcif5A45dHqjfRd7ipHdPF12h4ITzXM6BVt46hW+m7G1s?=
 =?us-ascii?Q?t1kCmiG7YsZsm7DC13tvF/XafVm5WNIYsOZ08Kv1cmvxVdH8dSucHnSJkwsK?=
 =?us-ascii?Q?xoMdE/UwYPJed0vd06IhOvefggB+3JIiaPt7mNxSWcjZ/fA1sdkqrcSNeVgn?=
 =?us-ascii?Q?tWNdsMgpYfA8dnjkuTIwd0CZ+mgVmVcUMmbA15jHHOAivYdWUc4f4YjQA0y5?=
 =?us-ascii?Q?4EKAzPPXYZP0GBx/QgHUCjG3+Qo6j16VUf8Z/tPrxEUgvwA/yKIWapDRGLel?=
 =?us-ascii?Q?S/RLk/Oe/r1HEpKTVnn93wUQT7/1oiO7tY7lUPOEVnSO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3576a383-b420-4681-777a-08db42cdb357
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2023 01:05:44.7034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yPdLVy3qc6xDbIAm17eXaOc04DpPN+R3tRXQwbQTceeQSS6DvSDoBmhb0KlGoaatl7swGzRFkHKqs8dP7wCSjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3762
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Tuesday, April 11, 2023 9:53 AM
> ...
> > @@ -168,6 +170,30 @@ int hv_synic_alloc(void)
> >  			pr_err("Unable to allocate post msg page\n");
> >  			goto err;
> > ...
> The error path here doesn't always work correctly.  If one or more of the
> three pages is decrypted, and then one of the decryptions fails, we're le=
ft
> in a state where all three pages are allocated, but some are decrypted
> and some are not.  hv_synic_free() won't know which pages are allocated
> but still encrypted, and will try to re-encrypt a page that wasn't
> successfully decrypted.
>=20
> The code to clean up from an error is messy because there are three pages
> involved. You've posted a separate patch to eliminate the need for the
> post_msg_page.  If that patch came before this patch series (or maybe
> incorporated into this series), the code here only has to deal with two
> pages instead of three, making the cleanup of decryption errors easier.
>=20
> >  	}
> >. ..
> >  void hv_synic_free(void)
> >  {
> >  	int cpu;
> > +	int ret;
> >...=20
> If any of the three re-encryptions fails, we'll leak all three pages. Tha=
t's
> probably OK.  Eliminating the post_msg_page will help.

The post_msg_page has been removed in the hyperv-next branch.
I'm rebasing this patch and is going to post v5.=20
I think I can use the below changes:

@@ -159,6 +161,28 @@ int hv_synic_alloc(void)
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
...=20
 void hv_synic_free(void)
 {
        int cpu;
+       int ret;
=20
        for_each_present_cpu(cpu) {
                struct hv_per_cpu_context *hv_cpu
                        =3D per_cpu_ptr(hv_context.cpu_context, cpu);
=20
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

BTW, at the end of hv_synic_alloc() there is a comment saying:
        /*
         * Any memory allocations that succeeded will be freed when
         * the caller cleans up by calling hv_synic_free()
         */

If hv_synic_alloc() -> get_zeroed_page() fails, hv_context.hv_numa_map() is
not freed() and hv_synic_alloc() returns -ENOMEM to vmbus_bus_init(); next,
we do "goto err_alloc;", i.e. hv_synic_free() is not called. We can post a
separate patch for this.

Thanks,
Dexuan

