Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0467A59DA
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 08:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjISGTH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 02:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjISGTC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 02:19:02 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020022.outbound.protection.outlook.com [52.101.61.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407F6100;
        Mon, 18 Sep 2023 23:18:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GituE2aonioB7MXa1T/pxt6uq0MTWXbLuHChgFEt08XCxLhlFfZHTaNVAp86iXxDFh7uHKjXCd2Lkbvy8BI0c9eREWzUSR2JvoqqFw2p0w/NHdnjoOyj3MsZfK147pPCqdtiGcW/UaQSHVMJc5OkeRILwLaet38brryp+5qRu6ax9Ee+uRj9JMtwmYv/GMBJxiZfWIutqRHJg8IQskpKl4TW5IVIgplwoimueldMUJMpEYD4EaVxdzomO/UO32Tyf70Wv2CN5SaDzOTsVbm4co3Vp79r1vxfNQdHVByten2H/51r8eDNqEBgKe0/iHNypyEZxymAzAR0295Ufo6gVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siN2DK8amF/a8yWiMreDEb6A/qUBw5Oq5J1wlS2BI5M=;
 b=F8/0qrniDOJfjA9qgnaBS5xeL3kLDGF/Flw49pMlMI3zRlJtZWYb72DkoCSDTRZkNYTeWKGW1K3eE5rhNJESLKE5IxfzzVU1CzfG5ky1rEkSpPYX+y0trpvGiZrciHpi/osHKSYOOO4BqWtRjvRfrknEO7h4IVeY5J0GX52BTftwq8ViS55jdjgXQD/GeNVx0vIpvJkSeoUWIThj3QDsnIF53XgoWovmY9KuKcRTYFReSK0VjKgTST5qOH6M21NMVWO0i0JTt3zrbJat34QsiMkaFxEApWKnMi4IBmuh8Hp5cSZ72g8HtZBg21r8MuwiRLufJq/hbkS53J9fGZ/6Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siN2DK8amF/a8yWiMreDEb6A/qUBw5Oq5J1wlS2BI5M=;
 b=Gq1bZYeHleW/KtSOcUhqawaS0ig3ctx3BenqLg8UovVI8cg4a+gcLkRm4EZdn9Y5zHkP0iTeTBmEuEUcw5/Qi78Sce/ts8z/UbbDfSSLTo0+AT2cfGy1KAIg9QR6zx/EEa+1YPQYgzgI/99dte2/WOXZbpyZPl3Ie4+iTwUA268=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MW4PR21MB2057.namprd21.prod.outlook.com (2603:10b6:303:11c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.1; Tue, 19 Sep
 2023 06:18:54 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%5]) with mapi id 15.20.6838.003; Tue, 19 Sep 2023
 06:18:54 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Olaf Hering <olaf@aepfle.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v1] hyperv: reduce size of ms_hyperv_info
Thread-Topic: [PATCH v1] hyperv: reduce size of ms_hyperv_info
Thread-Index: AQHZ6kl9meKzfjp4TkqOb2QZ4H54prAhq5JA
Date:   Tue, 19 Sep 2023 06:18:53 +0000
Message-ID: <SA1PR21MB133593AABC414CB427B84FABBFFAA@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230918160141.23465-1-olaf@aepfle.de>
In-Reply-To: <20230918160141.23465-1-olaf@aepfle.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0b63f011-6edd-4c96-94b1-79b73334dd1b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-09-19T06:11:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MW4PR21MB2057:EE_
x-ms-office365-filtering-correlation-id: 2aa573e6-a817-4946-a8cc-08dbb8d84c7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E5/MEnArZXzseQvkv2BmPA6xeZBJK/XU0m706XR/Z8BMJ85RR1bgOlUxZx9lk8iOsqQwCA5oBf5H1qScG3YxMOz+5Rawyp7oYKW8T0IW23loGIDQhSrL8MiZ38rdyNT/LrjUx/+80Wnrst4CJQF6PFAu9Nkg0y61zj5GFK06Y2HBKenjwy0n7jql1yyrKyS6pEJDkp41cHqWSDw6RaMievP+KP9c30tPH58VGheBl2finlWytYChVvB1N5AKrs17wmpePB3cT9+5p6eJ06/lzparpYy/7218LZ/reF3mFEVkS3NKiCGN6cq50I41Pzhw0+skPzGgzDojrRfCV7JU3lzbV04T/xbZjndU0WH//m6Qzm3nRR+OAorcZL0T5JduyVixN9jMkCBqQFxQwSEAF7kenHlRN1RHmcscQyUrz5xIQDbjZUXGR4/aJnC5kKcjTVHhCw4L5MHHpI848+69ECFg/+OxJLA8jsVadvuTYXMh6fI++dhHH2E3ush7LIouJasOxv9ewukNw6fmifPiMWXnG/tP7XzOZsZ7mxzZM9GZAFndd6MUho7MwLXhMi4I31GBU7J9uLqx7gp7qWp0DtQ2/IqxwKjlgX+Rf5JwKGFBMP1RtQq43kUlDOhnAsVi25hT49h0Gahn8sEZvnefvKf1xX/eKd904Nr6yMEfdiw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39860400002)(186009)(1800799009)(451199024)(6506007)(7696005)(9686003)(71200400001)(10290500003)(478600001)(2906002)(54906003)(110136005)(8990500004)(64756008)(76116006)(66556008)(66476007)(66946007)(66446008)(52536014)(4326008)(8676002)(316002)(8936002)(41300700001)(5660300002)(38070700005)(86362001)(33656002)(82950400001)(122000001)(82960400001)(38100700002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x5D24fmGmawr639HGDpfl7RT1J12Nh533WaNrHVUdZ7TnqwXjzIXagIUWgho?=
 =?us-ascii?Q?RSRwVs6zDbZUsK72YA0f7iFx0PfBsm5silZREwPXa8H8Tvt1XWv+eHuhIf9Y?=
 =?us-ascii?Q?F2Mak/E1quM5sZDlPlZHAUbvtbwspotg7CtweholFHj9ZGu0DP91lKqEO3g2?=
 =?us-ascii?Q?t9r9Ooi6zJzC8uTT6at1ZnQqLHmCWmRZcuxLzfwjwD7bKkEBA9Ovc4XkTzTU?=
 =?us-ascii?Q?YS3hgzBOEz3MdFImQesOzkMwXZYYzSpVfNlh2Nixkp/XNj1udHM5VggukPCX?=
 =?us-ascii?Q?712zJRxnOVHYZdOSS95ZoTl0oeSQtDIbZkM+D5yz3Ka49TebO2wuRKqJsaLO?=
 =?us-ascii?Q?1TBZqUWDkqa9CMx6GqufBleB/zUV13mk08d/bCmw4Cht3YFz9EKjSp1i9QUf?=
 =?us-ascii?Q?G5GhrUPNMPD8JdViPwG7VkRTANCnU9wnS+1+JiBnvZT5ZjbJi+M4Dn434Egj?=
 =?us-ascii?Q?HaAFN7pIjNOmdW5vs8nPrlEeIBjhDMCbdClBeM0QJ5t1VgtOgUe4B7ezgtfG?=
 =?us-ascii?Q?9W3WM8EHOefkKDhlxh23l53+D4aHHNG5RD8pSl5o8x0QV9tJPpYUPtV3hRss?=
 =?us-ascii?Q?naCSkcQCvfbRhmbHj3fWWY3KYSHgDF8IYEFnCZs0nhqT/7LDMRJENgdgYC05?=
 =?us-ascii?Q?gKohrefKcRMFAAs6WEISjFniUaHZZClnYamutkHXbElDM5sDeTGTOglKiavh?=
 =?us-ascii?Q?aEpB9ftiBqM30VAnRtQKMqLojTJvoOUBzHsw2msHrzZ6u5lEKl8uxBxLoAl0?=
 =?us-ascii?Q?CeuOXtGaGGh0CUMWaPxJrQfFVCWN/5fcq59RmGMZuKruiqdkK9xyKTA0YSgw?=
 =?us-ascii?Q?b0xm4IdT9pIFN2/rH1eKAo3J36adcdZyysPXLcBgMLPofYQz5F3KaLcNldEz?=
 =?us-ascii?Q?Y42HUl495MHn/pG61vbTo6g6H4yaUprthmgaFKxcQC59AxdSw361LxJyVib0?=
 =?us-ascii?Q?CBpxpwc9tPPwx+Jt/4dteN9aXXZnxOdC9TpGLMKVzW8mSrNcbk+DnQk2E007?=
 =?us-ascii?Q?7M9V9uPsedj62Do7mTu/1d+X63Nmv8sYuKqZBgwAA9xUObGX3S02jcTGN0Ev?=
 =?us-ascii?Q?k5L8hdz0pVF3PH5KLhJMi2ja5EQG0cP/4IqcJFnAFjTNmhZNeM4AOSsou4mJ?=
 =?us-ascii?Q?DShEmQO8wI14p82EWvEbY5c0O9gilAC2triaoIFsgjXvFHiLsIKoopzyWjEQ?=
 =?us-ascii?Q?+BKbgWHFMTdF3QF8cYbVpMLSO3gZ5Vp64iMOoG5Wqq/g08iNzVelgBs0gKas?=
 =?us-ascii?Q?M8sAYfqVbzFeeZiNeuMK3t28AMF0aC7CmHm2ovS/HzPGpH4PwqALZNHP8BzL?=
 =?us-ascii?Q?+0vQpyvjZDU/sa2BWowRVzlZWdwQaIXNOOOBkzaVyD7SFVzP0VFyyHHRlJK1?=
 =?us-ascii?Q?BB0kDDPlwgnX+yn7gRoJQEclv/NPF7tjRpbrNDHmVlQu1Ti6Fz0lZGAxwcuI?=
 =?us-ascii?Q?3MpP3VfN61fPdKE1kva6vWUzqS9UfHJdOCRTevg1OChUN9fGvqaQoxm34KQD?=
 =?us-ascii?Q?u4ohzA6aWcTt2rK+vYEw3hy2cjzJ4cyK7hA22qw0W/abRAO/bFkFAjEM9zaN?=
 =?us-ascii?Q?UqnlRM+tk22njJbDI9iJ6Hbbxjm3tOYgLEkjY5iw6XcnCSb2X5/+mTFUNuoB?=
 =?us-ascii?Q?41Qrcwp7UdskU3LvtGOHwId54Fs7mpJLhRq75qOp+kUL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa573e6-a817-4946-a8cc-08dbb8d84c7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 06:18:53.8529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RDCR3yd4USFkH1vxXq3rFxeb2nbunxRBrAH1wxZhrHO13w/ZFosSSU9gnucdTD1Pj0zLSHUnve4duDsrL83oWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2057
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Olaf Hering <olaf@aepfle.de>
> Sent: Monday, September 18, 2023 9:02 AM
> [...]
> Use the hole prior shared_gpa_boundary to store the result of get_vtl.
> This reduces the size by 8 bytes.
>  [...]
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -53,8 +53,8 @@ struct ms_hyperv_info {
>  			u32 reserved_b2 : 20;
>  		};
>  	};
> -	u64 shared_gpa_boundary;
>  	u8 vtl;
> +	u64 shared_gpa_boundary;
>  };
>  extern struct ms_hyperv_info ms_hyperv;
>  extern bool hv_nested;

How about moving the 'vtl' field to an even earlier place:

--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -36,6 +36,9 @@ struct ms_hyperv_info {
        u32 nested_features;
        u32 max_vp_index;
        u32 max_lp_index;
+
+       u8 vtl;
+
        union {
                u32 isolation_config_a;
                struct {
@@ -54,7 +57,6 @@ struct ms_hyperv_info {
                };
        };
        u64 shared_gpa_boundary;
-       u8 vtl;
 };
 extern struct ms_hyperv_info ms_hyperv;
 extern bool hv_nested;

This also reduces the size by 8 bytes, and keeps
the isolation_config_a/ isolation_config_b/ shared_gpa_boundary
together, which are related.
