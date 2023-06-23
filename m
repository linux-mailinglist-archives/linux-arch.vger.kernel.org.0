Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB09573C3F3
	for <lists+linux-arch@lfdr.de>; Sat, 24 Jun 2023 00:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjFWWTr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Jun 2023 18:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjFWWTp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Jun 2023 18:19:45 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020018.outbound.protection.outlook.com [52.101.61.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E520B2709;
        Fri, 23 Jun 2023 15:19:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmIG8F/EQKJVqFUx81WgPz+fr5NwUcXxR6DHAqrKzejk9qzBi61svzRNXggv84WgYielarkBmW3d6xSzI6syH9Mb/+lbOA/VsQF8mQVWffEozap3j3Vdbfo8lXjVsVt54HZ3RJq4rMTzFTG4dVhxhCrxLjXJ0be5wsaRMOt/fDvZXE0v6qArJb2fkJBv53hMtZ0eVRb5gRzSW4tB/zhySvJMecn0O4BS7fOHe6sjIxOL0GA6MJjRdyBr2ZOxYHraDDM7WyeYegDge8NQW4HO6cDjmyTJtzxGNApQXiRXeWqaDIsBKxPuDXQOBCxitsKJkuHMwZWu4LClei98AAy7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcyDn80BMhs6+thBoZzHWGftE8HG9mGg6HRFsHvm+nc=;
 b=Iel4EZhO04qjkg5y+WhM0J9/V4BbfS4h3KQpSABmV+5lnKz0HS8uCBzKplThkT1Y4s+4qk5/qXjp2pHecU/w8eQWzp0Cp4QC/g3wbp52ba4YmoHg25b/mf+UPqfg4mB1OvIbP4Y55ovD8+UGyrj2230ve1/AZ4sUfVRgLdptNISMJ0fD2eXCf7/Evv8ivElRTgHfL5HxgKvwLGZcdlVf03ZHCC1ezK39iJF/OTa3qFnvO1JzwQ9ALI7aniKOrDkTO40gocWK1rcbzOVfEXIywE5y0ghdxlDoQxQJkAd/+HcURWoC9drn9kXcz4QGo3TcWMA/JxIgPY9Dtj33KRqykw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcyDn80BMhs6+thBoZzHWGftE8HG9mGg6HRFsHvm+nc=;
 b=WPFOVGNv0yvgGNc+eEBLDzmFSepXkjpuRjFJa4x4w1KeCmyOuOmCSHGCC0LTeYh1P7EAp7o88PDOuIr6gtXxm67yFdQfMU91l5qz7FMhtlDW5sW75jlrBwDmg7gy+mjgA8OGzFcCveAb9LMS5ch3Bf1KQxX82DIt9gpcMISofxk=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DS7PR21MB3428.namprd21.prod.outlook.com (2603:10b6:8:93::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.5; Fri, 23 Jun 2023 22:19:31 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::bb03:96fc:3397:6022]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::bb03:96fc:3397:6022%4]) with mapi id 15.20.6544.010; Fri, 23 Jun 2023
 22:19:31 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Kameron Carr <kameroncarr@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: RE: [PATCH v2] Drivers: hv: Change hv_free_hyperv_page() to take void
 * argument
Thread-Topic: [PATCH v2] Drivers: hv: Change hv_free_hyperv_page() to take
 void * argument
Thread-Index: AQHZph9v3w9wetbBqUGkY0WYrwzN3a+Y9TFQ
Date:   Fri, 23 Jun 2023 22:19:31 +0000
Message-ID: <SA1PR21MB133552178E6E9F045C4FB0F5BF23A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <1687558189-19734-1-git-send-email-kameroncarr@linux.microsoft.com>
In-Reply-To: <1687558189-19734-1-git-send-email-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2cf68330-9d7a-42ca-a2e2-131edc5a3ce1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-23T22:19:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DS7PR21MB3428:EE_
x-ms-office365-filtering-correlation-id: 1baaa661-a5b5-4d2a-12c8-08db7437eb07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xlH48/8QqT9B8Wgbqedp7jeJyd2aLYY/0YM1MJGFAqTBTnZzVX0cLe+rB/GeNNbHii5Y98Yu7dRAvyCqcc45xSiXTaNRNMrAC+2E8dVJvZfGyJCrDTV/NezCG79E2ZlPliExoUagmpuAu28F/29xOAEjdrKv0U6b2QLIWgjousgqTsSlaTAZermaCnzcIPxUIa1F14yHdXh62B5YwRh523b/d4LqbtF9csfV6xzE+SqAUNZEmCbxdikzNfoBzcDyHznAiV7aAfIcfNXn/J/zLyXJr0gbQukqfmeOwM+RY4YtnOoDjIq/fil5A+qxBHvOrqCKm16q7SQFtL5CFyotYCQIRDSIKXwND6hjBKcjChUUIu4aWpcpuayb5unfHfn5kJh5yTuMq2Pof+kTQ8e7ImuoFROO+mBcLpV6N3qPBKfNPzbyHZ/dmusg63mDQuTj1qSY8xMexhcK4Fr4mallFIfod4y7QYGmbfhdCWhlHf00l8UmugCThJcyBegqlSz2+k04b5ip8FJFJTssqVHpzin68yIri/h2TfTqLsCASl3/RmCYZcAx5W2FAZAYn/j1srESx5QKPuSCW18OoByzR2qCrHAkYDBH9ajTjwWzGpiQhBl81KonEvd8vl53rbrKaN10Gty3chvAN7f6hLLpMl+TY5PMqot/lZuGJEGGpzs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(4744005)(66476007)(76116006)(8990500004)(64756008)(33656002)(316002)(66556008)(66446008)(66946007)(5660300002)(52536014)(2906002)(8676002)(8936002)(41300700001)(110136005)(55016003)(7696005)(38070700005)(86362001)(38100700002)(10290500003)(478600001)(122000001)(6506007)(186003)(9686003)(26005)(82950400001)(82960400001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?phCgQGFsvd+rbXK3vDUy8tPYglJbl94LVpi5D3we0E2Eju1K6/P18Wn/T28n?=
 =?us-ascii?Q?ZIZAde0VNO9UHxfhiv+tMXZSG4hZbm14nco83pIsTDmnes5iFwbxmtnwAjdU?=
 =?us-ascii?Q?HZmNvrZMSd81ND7F/qFY0gfnNOcjDtzxJgoDEVVbDNk0UophMqgnoSLrXqLY?=
 =?us-ascii?Q?o85aghxBRKcRIrN9m84wZa0z+W5/23a2vXNP13ZfeGF63troqj+2DZRUkllr?=
 =?us-ascii?Q?pbngS/f6sGwhCpWCJhwzDSS+qTkpTB/ZilQDe1ommeqNQGSFZ2rBF6ui6ZcP?=
 =?us-ascii?Q?fApRcvaRTJGVgPWYod4JzlG1/xZEaewet6WklhlmzyOoGmCSYopyTnu6gAjt?=
 =?us-ascii?Q?pOK6KO/1Nof6j25BWW/PboYqCNzNPnQNSJaDwAtpnIJ6xRaU1pUmfEPzeItO?=
 =?us-ascii?Q?7foiBqQXpLm8CwSr0kbM8cUHq3mUwZEG9q08Z+yiulEvNXmOls94TpML8J1c?=
 =?us-ascii?Q?rkWE1rIwhaERSwQEeo8L75PPKQzSz0XRTrC4sUN/yA1bJ38Q+cisBj9SeQyv?=
 =?us-ascii?Q?8su68Mhtpx3j19sRwiRo3/g7vU3pGZUjd6u9z78D6KhyWwkePBLjgBvXEkcl?=
 =?us-ascii?Q?taftbRjEAdafpqXr2fP8bHDXOzagm+l5K4ANWIvngoHq+f5tTOxVhDTA6rvR?=
 =?us-ascii?Q?IlK9snGsXxcBSmX9cCclZa604wPNIR5cd4+iI/UO1jaQwOekjd5sFpnhKVil?=
 =?us-ascii?Q?eFrWdBUUYuSrTrIYl22FCytPaOAb9P1Dv6gunBYvazUopFQLejTOlue8OgxW?=
 =?us-ascii?Q?IEdSAceCa2wsu5QEe/ywUmfAilwveDIGxFutMmhBqjkFjLwyBCFxhux43Qzh?=
 =?us-ascii?Q?v2j7cn6U2zHStkY1XoEUDuBlMoMzkXLqnm4vo7ku8gLwHZtvdFNMlpARcgkt?=
 =?us-ascii?Q?8NhnHg3yh5zfZ40vaDHvMvrWnm3HpgaYTTyDC+WzLlUSEMgj9vha7/HOvrQ1?=
 =?us-ascii?Q?y+IfngwUL41MpBcraHjpEtBxknI0YC5r0r4IB7EW1PD8PmTePgVwbr5fT0ZT?=
 =?us-ascii?Q?AOz3Ent2Q8lUPyX25TA1RSMWVRuhgUUwaHjvtJVhv7wAS/sSGWGdmlCZcpKY?=
 =?us-ascii?Q?m/Zpunl5vy4aPCsF3AeUNxoO+XZLPw/NOpjO+YygmI0lmnWLmXiIYUigegKs?=
 =?us-ascii?Q?k2ZLSzrPHYqJTM1lUmurupsQfByR4P84mtjlh6fPgW7RciAF5EgmArjkYPMy?=
 =?us-ascii?Q?8ak7oEvBgyFPbXI3dS3K2VnbAikIqZzeLRqguHXs8QTot8cVR60oh7ckzyG9?=
 =?us-ascii?Q?dlfvagYsrCVRKUeGtG5pTL+oo1yw3/Tac0buHCJhl3TXVYLd4gsAND6B2WNt?=
 =?us-ascii?Q?+uRIT+nVBdVVmK5va9EGnF3Egp2k0H1esMQn1xcVPxx+TsU6TmCOLaeHRxn1?=
 =?us-ascii?Q?iQ8iIuwwZYRRhMOGqO61UvUf6woPspwPozCnFtlzAhKkRABsLImUsvvMSgP6?=
 =?us-ascii?Q?mzF8d+Rdpw06KnF0rVCQy/vj61mmqnCGf68Ch0qs6PGfNt99feqVCX2aq4Aj?=
 =?us-ascii?Q?EMhZPWipp5zb7cu7ab2r5YEFcHhbioq3zI5Ct43ryt2ud63yKVISZg+ELlO4?=
 =?us-ascii?Q?F4k4xOtT5MvVQnlpp5mKLrpk6zsHh8RiKYikGcfy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1baaa661-a5b5-4d2a-12c8-08db7437eb07
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 22:19:31.8093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mtnzftINYVeA27VeQQMSTeOHRfgxxq8D26Hy3fnsMts1V3y/29BuWfyPjwhvNktS3xKZQHHH++ccuqLZp5zaMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3428
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Kameron Carr <kameroncarr@linux.microsoft.com>
> Sent: Friday, June 23, 2023 3:10 PM
>  ...
> Currently hv_free_hyperv_page() takes an unsigned long argument, which
> is inconsistent with the void * return value from the corresponding
> hv_alloc_hyperv_page() function and variants. This creates unnecessary
> extra casting.
>=20
> Change the hv_free_hyperv_page() argument type to void *.
> Also remove redundant casts from invocations of
> hv_alloc_hyperv_page() and variants.
>=20
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> ---
> V1 -> V2: Added Signed-off-by

Reviewed-by: Dexuan Cui <decui@microsoft.com>
