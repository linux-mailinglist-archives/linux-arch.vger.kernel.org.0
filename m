Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F4473AEEC
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jun 2023 05:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjFWDJl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 23:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFWDJk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 23:09:40 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020016.outbound.protection.outlook.com [52.101.56.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C87DD;
        Thu, 22 Jun 2023 20:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNiNeX3mFgpWB66sZdsCZEO0bLovPzQqW0YrIVH0ujUMd47/Czr/orCQPmwEZc0YRZjARw4Lb8kwClaNmowSaoxmbcgAoslbfP3dadyEvfDMYTDyDk8Rdv0IdfRmm6pn/ayVc4XQ1Lfx9B3ZOOL4E9lCIJrx6ptw4kjIzFXCNb9y/pEGYL44WJxzbBwgp5gjpI+ZScP7nRepkM71ZA96jkTxwVqxlQVGYxfgEs+9YBdlVzv2E5xZtm8pHNHrZ1anmmAGw/FxiexEuyDjn7mUsNfj4Lq35tVagHn+ClcPXVdOvIJGkhHuvAwTPTLl0xN74i1pjprOL/x2PSuWZ/DBkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qEbFOTZU0PHzTv2fXpFgAjXXGC1kdT627K4mQnGP2o=;
 b=oICHQFEpVnF0dDLF80YhRIO8Gjsh4oHrMcWk4uJvLHIpGPvjE6CUcO0r1OPeuNU6tOoLdjzzLJeK5eLQe3434gyMNyP6G0lIOtbbSk0uBXw0ug7d2dNLp0P/H7T4/ORxmwUw/X+bssKK0rfgAbs587qMoM+qXC47gPPzWb6JGhFbzadGDfDfGEBjz8Tqz6V898jCVF6iCVbVrhkJhUnlAb5Elg856M04Phr1kbZQuY1Nd6a4NOgjH1QNSvlYsKv5COoqVTdfY40YH9h9TplZrsszTxip8HzJb6x7wchPjsL/WSec/xiV7neBCRg4ZSAOTAsQkVeNN+SNSsBrlQcz0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qEbFOTZU0PHzTv2fXpFgAjXXGC1kdT627K4mQnGP2o=;
 b=CSQRVWqRv6dmz02qjz9gY9l2VrR3QKO1FTGN/QT3707/51FzEf2Z+t3pm3uxQVduK88DUh9QUWBIYh8WYWd+uWENhZpyRMeDXPxWOmR3N5fGDKmwkQaKdqI4gmqBXPuytUG6s0jjLS2GhojMQQp8x+KLHHeuBUvwPx16qNf2Dwg=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by IA1PR21MB3568.namprd21.prod.outlook.com (2603:10b6:208:3e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.5; Fri, 23 Jun
 2023 03:09:36 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::bb03:96fc:3397:6022]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::bb03:96fc:3397:6022%4]) with mapi id 15.20.6544.008; Fri, 23 Jun 2023
 03:09:36 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Kameron Carr <kameroncarr@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: Change hv_free_hyperv_page() to take void *
 argument
Thread-Topic: [PATCH] Drivers: hv: Change hv_free_hyperv_page() to take void *
 argument
Thread-Index: AQHZpUUszoID3MmaN0KNSemCrLlP5q+XtSww
Date:   Fri, 23 Jun 2023 03:09:35 +0000
Message-ID: <SA1PR21MB1335DE4D9B0F9A4532363DF2BF23A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <1687464427-4722-1-git-send-email-kameroncarr@linux.microsoft.com>
In-Reply-To: <1687464427-4722-1-git-send-email-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ddaf82f9-f27b-458d-8286-d2f94d655212;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-23T03:07:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|IA1PR21MB3568:EE_
x-ms-office365-filtering-correlation-id: 8b6c6284-6055-416c-73d8-08db7397464f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uFlQ5/nkV7Zx4gS3IzqnPUwcugPD4A27j0AugMmcrmJgIV9lsnNIw7+hjEGFolYlTcSjsun1JPx4nlK5M9iPsrUOI9ppRy4YGXaa1U32j6uFHetXvaCZad8/+Bdc9MoCsmYzXrLfsllS0LGSkeBUQYccWli5B2pJVbXwRiI73E+Y32OtYIYPoXaZlt+K/1PW1bjy8pZzXfTjkF/66xEFV1RyY6HFxFpP5NOoUyN9wCfGqZ5G5BkXzLXqEZGfXN3yp/exmsnnGR5NYr//rWobhpTCerNsAe6BVm/H3WWtmaGxlpGkMTRSQFDHa46bF73Bs3LWZBjpnd/8gmZbPuzBzaM3QhBdSIhzlwUer1Zxgg2REQdMeMNWRy3M2upywMecnmSTzViPqC9NEYDswz+XhzOT5S+liQs3xql8cPsW3V+wjDr91wps9azkiPRHw0I1LG+O7Q1vaY/kPs+WTdhVnSabEFYzNh82x1FYZRqPNhIFXONxoe/RaP0Rsg1LGDIEk7EL9DY7a6ELw90YIukPyfQr+CH+UEpBmiaYUkUB8cFT/BWZ013kDLQhP9CfxsIilifS6sBb5/iM3bRjr6MpMCpxokbn3m5Smv0K86XXK+uxJCO3m9EKwJA0Rz5AFGHZlExrngIDIIiz/UEoS+pRYnHJ+FnZFNdTkFf+bcO98TU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199021)(6506007)(7696005)(2906002)(4744005)(9686003)(8990500004)(66446008)(55016003)(86362001)(38070700005)(66476007)(66556008)(64756008)(66946007)(76116006)(316002)(10290500003)(41300700001)(186003)(122000001)(8936002)(38100700002)(71200400001)(33656002)(82960400001)(82950400001)(478600001)(110136005)(5660300002)(8676002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c2fcjbr+6R+cuJEyCbnoXXdfBtihjwQcOmvUHh3UOeRJ9mK4HaR/29KJaVTz?=
 =?us-ascii?Q?VuwVogfvz8ZYXoKFwCwGxwEGM7LZGUpW+61s2O1ojq63L+aFC2xjzG+aTyGD?=
 =?us-ascii?Q?7zDfliwqDCEU7usLw3YfhLbCgm9RdVa5tZGyKe/nSNQwwwHeX5Wx0/epRtR/?=
 =?us-ascii?Q?Op0pyvWeuDweuSOgFJij7UwgvJiU6vJ552KgraO9qkjydpExan/GERjWzn5E?=
 =?us-ascii?Q?DWodl198plXl0ULr1zKzj+Y4ur6UoURZTgQxvIaKBqVRaeaER9WoQ1e9zv9f?=
 =?us-ascii?Q?JUQDjtHm8DWKokjcm0pWsHmxZ1A1R6J/+W/jJ7721jPptVSRIcxSsqz8MawX?=
 =?us-ascii?Q?zR34ivEMtGkevMw4S0+BEwK+bvN4ziCMwIpIlA5G6tLs1LrPwp9UX1A5ZA0S?=
 =?us-ascii?Q?FgxJd4KrXipYSXYemkZID+h/rCfZZhHCxSqThCB1/Yz1znMKxLhg1Hy/Cw43?=
 =?us-ascii?Q?THvzyhE3jjQFoLKQtSxxpk4TgcJimuAnWuLFEXZU+7boyVreVu+nq8epsL70?=
 =?us-ascii?Q?6oQnC+0Tdl2TBEKIVEEf1sPv1teJ6lGWEC6pGmI/JojbZ2FWnb840ZS8UuOt?=
 =?us-ascii?Q?Y8YgzYMT8XAT8xfQ6u7KFZb2KQuqgsuNdB/UbTo84NyQOAzTlPJEDxe5cOlB?=
 =?us-ascii?Q?eoTiezR6Jh0NQTQK/wEWfgyfBM7bdcyfbrk57sSTXx5J6Ng/NWmVFykKmfQY?=
 =?us-ascii?Q?I08UP6ZqnYbh1zdNU5HwPrsSsYckrBVFFwtEPFzLISr75m7HmW/LJjSq7PIP?=
 =?us-ascii?Q?6vbExyE3FlFZ0TUUv0idwrHbKlDm2hV2CQdj3u7U7aNiTFnOO65iQo8uG/Pj?=
 =?us-ascii?Q?JQXh6wshNsg8llj1c7ESYFukyL7Kpoze/as69i220fZOzmd6CVkItaDsFX1v?=
 =?us-ascii?Q?qRuSNgG/Lw8YQfNuJRBAyfw9LwLASH5BHtoMdoUKkjrmuSndO64oGDGAGFsB?=
 =?us-ascii?Q?0n2JVE6bQn9OzOf1CeEK04LguBdMKjJo3rkcZmItOzprxzm5+GqMe/DyjgRF?=
 =?us-ascii?Q?4npm+rkljXlXcJVD2d3Op3ljSfGdKp3N81/TCYob60W20iWkxb+yMNSMd543?=
 =?us-ascii?Q?5DpcYeFJI7ecIIBVR7nlo+Ohl7I4EDn7f9nkkk+2L8DXbjh8NJQ1ymOFV5VH?=
 =?us-ascii?Q?y9uPY3SZKkGiZN29EvbfeOFgPG6abw0EDSU0afKRB61CNryl/FiqfXVOs+Om?=
 =?us-ascii?Q?Me4s2ptjG+HzHhPVQAep+iPgSUHl2IxrqylHVzz3oSvyNC3dSAA2Kf6xxMsD?=
 =?us-ascii?Q?hT6I/ClSpjumR2LjO00+nTV9J4hgUhgAirCVunV9wu9RD331av8Jjhu9CbxP?=
 =?us-ascii?Q?zw+NJSewQwLT6cO25o2EBU3h83aoLqrWRH36tEOREw65uVbjNTKxDwS7hRRy?=
 =?us-ascii?Q?yvIedRMuX4A6yILF8UvK9thDtvTH4qZADj6Ntp8xHJYTXUlH63qK9Y+n4Hmh?=
 =?us-ascii?Q?O3lr036IqFLy0hq63dQ+P1dNNlq42WU6D5KaBLvQL3HOsytZVHMkddzC2ZDa?=
 =?us-ascii?Q?JJgn8KNLNPDK4HWP5pVJ0P6kj9+VnE4o1NJBdV8JEVnWQADAzNgm+PLrSc05?=
 =?us-ascii?Q?qdQ2iU+UnCBMQD6Kt65+OJsfJ3HMH1xnX2UHvq3+5tIWa8NGx9qNFryeseGO?=
 =?us-ascii?Q?rH3sCMEpRG1y1TVXXz23lng=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6c6284-6055-416c-73d8-08db7397464f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 03:09:35.9626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Tyg+1Lp5kkOTMBuScLGPOfVkaotXQYFyWu/zdhiyv5IjcrBSG3dZoGKcu4T0nSL4Nz1QxO5zk/0NSq9egthig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3568
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Kameron Carr <kameroncarr@linux.microsoft.com>
> Sent: Thursday, June 22, 2023 1:07 PM
> ...
> Currently hv_free_hyperv_page() takes an unsigned long argument, which
> is inconsistent with the void * return value from the corresponding
> hv_alloc_hyperv_page() function and variants. This creates unnecessary
> extra casting.
>=20
> Change the hv_free_hyperv_page() argument type to void *.
> Also remove redundant casts from invocations of
> hv_alloc_hyperv_page() and variants.
> ---

Hi Kameron, you forgot to add your Signed-off-by :-)
Otherwise, it looks good to me.

Reviewed-by: Dexuan Cui <decui@microsoft.com>
