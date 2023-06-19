Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A017F735C23
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jun 2023 18:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjFSQX0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Jun 2023 12:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjFSQXU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Jun 2023 12:23:20 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020027.outbound.protection.outlook.com [52.101.56.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D56710D7;
        Mon, 19 Jun 2023 09:23:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSHiVpnPofYbFsTbzhUVe86XD1vKjg+r3se7Er8s3APKo9yRUqUoY2NTgUjIWrnS7IjdrZE3CZFeWYEYiZfjxt5eVSZqOSozBViUmS2SWBuigM5Kvy+F+sDI2mhD9MJlsW+lw0BBfkoqvZRQwl0s6AY11bxxq+2Bqz8Hq1zgPbYGZ03g970YyMALEK8J/0PCk8gHqaiPl+yK6OuYKiaorz6xhWn86I6Fx283kf1J8mX0aTfesPa1IH5la6QIyaok2syU8PPJ0mW1Jk/jA7yjHwZiie3U481qVPoWL1OB3dEOfa/UgsW/L5aDDqAfH2aO8t1XLozz0XfEoaxyf2Kknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuGu8UOnvaOKRTfEmi8OZ5Wq/r2VAvfy4AIX/TenCpk=;
 b=dfpoHLmtNrg9HmSpLMGdYfBHX08T6/N9PGv20hY0GuHD+i7+GFvA6GF3OSZxuoJ9IDXbw55Umuv1O9obrLY7a6jTbZPDp36wzLkkfZwyeHyglUVsa2E7GuPm4zy18r1g51UmmnBPATaljPAGJ8+4Qy+ftMyUHMIuMYnkDiezPdCDGtGT/b9yUX7NMG5mSK8eVgj4kC101mZxCMuS0DI4TskOtrAmls5wnBaxsVqQxkl+m8mPP8r7OO8tJXWzhhZGfFq3cL9NQxqsgd6/rdEZuJfNYLmJY+UNkdgMz0ChnbebgaBSR95oHICXHyN2COdz9Aa5PUCIk8Gzyli0OoiU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuGu8UOnvaOKRTfEmi8OZ5Wq/r2VAvfy4AIX/TenCpk=;
 b=Y8q0v63ZMa6ZpQTaHiPR6WrccADtIROvsconQde+3ksseJohDKL8SKj4UP2z0ZsX6hPU+/m7MIDA7bbvQpIjE+/kzufqC/ff+Wok4BW83LZvwK8mBbncaX8Awg4kO1McyOlGqSwOdasIGXJUf/nqUU1BfTBCWeqEeSdQmBzbzNk=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MN0PR21MB3461.namprd21.prod.outlook.com (2603:10b6:208:3d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.17; Mon, 19 Jun
 2023 16:23:08 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::bb03:96fc:3397:6022]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::bb03:96fc:3397:6022%4]) with mapi id 15.20.6544.002; Mon, 19 Jun 2023
 16:23:08 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
Subject: RE: [PATCH v7 0/2] Support TDX guests on Hyper-V (the x86/tdx part)
Thread-Topic: [PATCH v7 0/2] Support TDX guests on Hyper-V (the x86/tdx part)
Thread-Index: AQHZorSU2GP9/xu+t0uTiZxQudDm86+STukQ
Date:   Mon, 19 Jun 2023 16:23:08 +0000
Message-ID: <SA1PR21MB133580B3E69A91C7ED282144BF5FA@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230616044701.15888-1-decui@microsoft.com>
 <20230619134709.6c4sgargh67xwc5g@box.shutemov.name>
In-Reply-To: <20230619134709.6c4sgargh67xwc5g@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9dceed54-8d62-46ab-a4d5-6e79564f58dc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-19T16:21:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MN0PR21MB3461:EE_
x-ms-office365-filtering-correlation-id: f7488df1-feda-47c0-e537-08db70e177e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iv5+7Ex1HpgebFZMnhQ4eSxy3uCN5LA4dfz3Jldzoy4NZXDiR3Sv0Rx1o8f8/Wa9Fb1K3c/m90DLrbvPZMfWTKRTq6YiE+nrpNnCj98WTc3Fcgwmxx4HhNgN8nAbFpvqDRyyqvrDOc3rQ61kgDWbXbI8ghNuKfDv+1lWcyFso8zhcUZN9HCNiuuwmX/B6DbsHlTkc8s+mJO2TcyLGhqFHAbhBc6SAoDBESeM0Qr+GojIb6nnV1Es6DgcixastGN5d+wp98+m7hIcVlypKgUy2Dh7RxSZVGzO3T3B/cLimUakdCMJNrUlDRIcofL4WlPM9k0uHOeY+dQCfyOJqvGDlv8HdVXGyR0j8dBAr+en/OUBvElbBTIzU2D5198zO4Zqp7QzlEBuv5n5Rwc3gieTesb/fow8merY/bNw2zjAPkC4SwDAencUFM/wTsXeuO+op+TfJB62xrjs7wLdY2EWBs5wUh+WEWN7GhHu4dZrEtwauLhQRD7V7cTY7AqEQ+obrxO+cgBHgtWovRMPTAqmXIEHv66GvPSeEA0Jk8at14Iy51S0gRhNJS4E9a7CmREcFdb3jTNlcCXNa/w3bKr+SIkuXJUlxFo/TF5Htq1e+eu+mbfygt7KDmFnAYuat1Y8Zc4sIQ0Q7NSkG3K3KYGisw92lm19QohPIebFFXADhas=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199021)(5660300002)(33656002)(86362001)(52536014)(38070700005)(558084003)(7416002)(2906002)(8990500004)(55016003)(7696005)(26005)(186003)(9686003)(6506007)(76116006)(82950400001)(122000001)(71200400001)(54906003)(66946007)(82960400001)(66476007)(10290500003)(38100700002)(66556008)(4326008)(478600001)(316002)(8936002)(8676002)(41300700001)(66446008)(64756008)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tW9OA8kDMo7WADAJJB8f15zt89XVSyDYG5JBrNWutsEU6/sqtaYXTg62mkL5?=
 =?us-ascii?Q?ppfX9YyUZR/j25yup5PG/OBa09OEy3GmlUWiPWCA78lgMnh2M0H5GLCg13NW?=
 =?us-ascii?Q?Gkkac4Sp+Ye0Hg3rzu0VmnwDcJ5Q3fSIFhr/dU818vU97WsEdLuG1p3MAVo3?=
 =?us-ascii?Q?woE8qlPb18LyXJKE9552TMH6JlGEzP3mXF4KGCtOX2Gqvv6XYI38tBtLI5E8?=
 =?us-ascii?Q?hjedZGoqwG4EUlqILmSuF4FhO5bRfPdnRnCQNJjotJlw+oMNpG4F/6+XmsxE?=
 =?us-ascii?Q?j1KJz9aTc6ctQrWIXm92FK8Q71EsLXXH09Wn5cbVb7KQmjW9poDNp4yxy6ur?=
 =?us-ascii?Q?NRBQxCV9W7cs++yr0B2CcXXM8c/YqAqWtHn6gvUjViQ+iloQhkNEDuQi3ZL9?=
 =?us-ascii?Q?f1azxnrpI1QqcZ4YDY+yzLE4Ywf1WASleuBpiMrwjUkRIk4HGZGGB9GaKZdz?=
 =?us-ascii?Q?QIu02di//x4nAr33gz0wVKuQqnvfimERjjBhoYYzqiiRewt2m/8v0PinvS3E?=
 =?us-ascii?Q?BSCrdtSO0SYOaOYKraq5Q8HBQHjAtsj80AM5y+pv0Ywcyl72avCZ9fIOznY0?=
 =?us-ascii?Q?2TjGVHtdvD+5dmlcNPghPxhMxzrmc8mjfe+tCjj+ILWOm6T+PO7meIQ+jb24?=
 =?us-ascii?Q?2CUk/4+tI0CJiulxByXVhGNxnqitTbJVPNOHL/MGQAOCYWs/LHpVhToE5/fD?=
 =?us-ascii?Q?p6o5yNpYhrJKiGWcKjosF6v5InvhsjYZGi9CBOGEdRoGthnRi8LhgMfD3GDz?=
 =?us-ascii?Q?sWiH61KNL+ong4+nxK6qs8P6zsIlD2oMihOVbAmRf5H13xh1Od19G26RdnOa?=
 =?us-ascii?Q?su2fJtWkFOUK5ZKv6IaftTkfl9Db6LOBdvxgN4mgxEA9o6e5+lymgqncOjbB?=
 =?us-ascii?Q?sfXxpsSb/b3/lSZIIu3S9XviLwrI8i1Yq+XDoiAq+l5DuIOZ11FpILGP718v?=
 =?us-ascii?Q?d7PCSa7OqAFVWp11HN8QYCGqqYf01/kcPvjE2eGcu7NZ13XHAeP2yGKDutlU?=
 =?us-ascii?Q?6VVleSIrxG8HqlpUTif+7qyxO7kXfxk2z31TeXpDERFRKta6kLYeIxS5tqf/?=
 =?us-ascii?Q?L/7mFTe2dB+f9A6eCww2bMP6Z/QGNJS03zp2zVrPMqd/36AhwXbFTK62/43E?=
 =?us-ascii?Q?5Jpc4wgbRl6HtwoXHZiO6SlQfZvDup6+F3ojAm7gtQd1sLc4LnzvXGU8iqEY?=
 =?us-ascii?Q?Q/LIJP4AXaV6+BCGZuDYNDFNFdEQueyAh/QbuujGMHhS2G6qNI/I324ADvIw?=
 =?us-ascii?Q?NjrxCfdtQL+KdkUQD2jlpG2zuOz+NGM3UHVjbY6vqLu2CPcEO9IOL0rscrYf?=
 =?us-ascii?Q?pgCLBlX/qFtMIx0nXXaDRRryRTpRVpTevdOmkcJHTQrcE5ZFxrknLTqqwypY?=
 =?us-ascii?Q?Qa/YHupg8Nls+bDt7RERuRAp0S4J6Qi1lQJu+EN3gk6BZkjyPSpdonbaEHEg?=
 =?us-ascii?Q?QlAH6Iz25+O4qMtp1gX6xn79C3Qb/hwaGs+Xyo6qDJZ1NOn5eOOYq4QcvBZU?=
 =?us-ascii?Q?+amKb3Yq9iiUqR9RG4XUdRtDJct/+B6UKxgkHbBE1HJJxtzxOf5xq6ffQLGH?=
 =?us-ascii?Q?hM8dHNdCG2qR3ldfacKZyDE+mQ1oukLyfbgd/RQ1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7488df1-feda-47c0-e537-08db70e177e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 16:23:08.4559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VrnM8n609yEaOKFhY5rT5Iur8BSeInKDDF3HTZ9QUT2o9Wu5LmirfQv3bR1sG+7w+zOGEt7kf7Q1SEYo0qmzZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3461
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Kirill A. Shutemov <kirill@shutemov.name>
> Sent: Monday, June 19, 2023 6:47 AM
> ...
> JFYI, it won't apply to tip/master. Unaccepted memory changed the code yo=
u
> patching.
Thanks for letting me know! I'll rebase to tip/master and repost shortly.
