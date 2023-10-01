Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280257B455B
	for <lists+linux-arch@lfdr.de>; Sun,  1 Oct 2023 07:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjJAFev (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 Oct 2023 01:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJAFeu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 Oct 2023 01:34:50 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A817C5;
        Sat, 30 Sep 2023 22:34:47 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3915YXtm022264;
        Sat, 30 Sep 2023 22:34:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=date:from:to:cc:subject:message-id:references:content-type
        :in-reply-to:mime-version; s=PPS06212021; bh=oKGvCI5p9jLiXoUv+w9
        gxe02IgOT6Tgt6FyBQSKGmBU=; b=j0rRp2HNOKFvkvY87hPHRV+DL4i4GcPxcY7
        iiHiHEP/xcupocEHwK/moe7Eh/yrh4SsIQZg1/BloXqmW/EFmA3JnnKaKIu7qcFu
        mOhMlxTfq4s9mukqQoAb1K6n+XX97RKv88sbHmnwTNMQT4dYamhlENaeSI9p4EtD
        hTR00+8rLCRgHVR8wLH28OYChu61GHSfXHQf4hGMarYW/e+e7bB6UwrfvB+ZvMAb
        8XWtG5B81Vh3VxNVaDu9w2ZZP83H/bmO7eyKZ2OKC4l7QjWxS4KH65ZPwWa093hy
        RUESMIZZgpnDZQkvOtkETvLqav7g8H23j5xbLohgorRHEykGbJA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3teey0gm93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 30 Sep 2023 22:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbd8jsk6vfdLAVlkFfRo+yTbRn7G0L9vaq5T4Ap/HAoa9d01wx0GfHp1lurG73OXWeuoQ00Y7v0Ztw0+Aea+SJDrVIJtxTWEPVGB8o7KFhztoybOSjpGfKsVKn6nLbRi/YrjF56unO8olAUNNBU0WtHneGywTvmvpuoLwK8g291A72gHpVBNotpnxh/Vf9Jyo0gkGbxA0tv5gbz5GzqErPxNY+XuQd19JxFTfbqanOWRSUsQ5lqiTB80On+MEwGCjOziP8Dbo/r+JIINyMpQeDG3xxjI/lvVsHXGu/RI7srf8XU8hh52NObxm5+vTg/PfYsRuskOf+XxtLuwHYkhew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKGvCI5p9jLiXoUv+w9gxe02IgOT6Tgt6FyBQSKGmBU=;
 b=X6Gh/FrWcZmQQ6AuInAqkTpj5s/w3AXUOrZSNaLPLZUPiomSXzizMEVVl26Pxjf1ycJJMs3W020b20YXafWwYuzyLuY5QW+ILD4T0ftq13Mn6PZVRBFKyIv07LiX0jab5uNN0cgxOuoK4JZn8VOKsplLojEulQPyo3wYdauiWpMiwSAj6SOo8RVAQDSlemEiQ2UMNx/BoIw8n+XNr6IpnYmwX58xnOpWqNXd9FEngxDW/k6DKn6WfZDHE59dA2z+061VTxmi3/eoo28BOlPwndQQyLhjngz6/YxlIxRVraanQTm3IurqhdH+RoEzshTO1MPRUT3h2Co04Da42EK9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8)
 by MW4PR11MB6983.namprd11.prod.outlook.com (2603:10b6:303:226::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Sun, 1 Oct
 2023 05:34:28 +0000
Received: from IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::e8f9:6b69:3649:212c]) by IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::e8f9:6b69:3649:212c%7]) with mapi id 15.20.6792.024; Sun, 1 Oct 2023
 05:34:27 +0000
Date:   Sun, 1 Oct 2023 01:34:22 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: Re: [PATCH] vmlinux.lds.h: remove unused CPU_KEEP and CPU_DISCARD
 macros
Message-ID: <ZRkE3q0Z9psMYVqi@windriver.com>
References: <20230930071335.1224500-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930071335.1224500-1-masahiroy@kernel.org>
X-ClientProxiedBy: YT4PR01CA0379.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::24) To IA0PR11MB7378.namprd11.prod.outlook.com
 (2603:10b6:208:432::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7378:EE_|MW4PR11MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: ffcc166e-4ba8-46be-40f9-08dbc2401376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: talDHwy4mS+tIioeHzQFTmGb+kH5TYhH2SQeF/jnM2tOssSVN8p6+ffzcjIr3kV7uik0s9ToeJO0dh2EbrxkRrS/pxaJdskIa3oAzFRcqqXB8swmbdCe5jX5vrjmD0sg7jOFFeAJwhg9Pquxb0HXJORlGDlaQ5HUj6aqIfYKPWoNUOh+khS/8uLO/v5BfGzdrWjqegw/isy5pZ6vIaxu7Z48Rsi2b/OXRXcB0fkzokLS4oI92AfLusrYlh25Yop4VPgaodOaFAl0WnWuTYr0Wf5ry4Ye8SZAex/YKmgjUFzc3x3D1OCCdKWxDCNT4Z0gtXfbabbZlzmgyXRFc/O2uC7snkAS1XTdX88rDbrv6zXQb7UcQx8ktv1zVjCOUTve+wr6+mE/Tb5H/2/SofWXDQnm7izy1FTov93dfx2YbshC4adNA+XYLO2paLozeeutsNlNDcOT1tMkqWVlTVeIHgD74XDB3VtBUh1k/CfMQ+aoKUVxOjxaEHEg1oiUfnHD3c0hNoVWs7i9xS6hLN2PQVqCkby/8A6BpFwWX7qrnr5AuYf3sAiDQvgQLqWqcwjy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7378.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39840400004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(6486002)(6666004)(36756003)(6506007)(6512007)(2616005)(26005)(83380400001)(2906002)(86362001)(5660300002)(38100700002)(316002)(4326008)(8676002)(8936002)(6916009)(66946007)(66556008)(66476007)(44832011)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ADrzzl1eiGPb7gxvXTgs35vLJQJUKXh/SkM5Skcp2RCv1VplgQF9Ut6uZFzq?=
 =?us-ascii?Q?KK8IRF+8cxF0Qay6rZeHVoRE+mwS6Hzv1qEHuKreSodqFk09iU3XOcSzV74Y?=
 =?us-ascii?Q?g+H951lnI1FlIdCV3uMBas6Y5igqxQ8n/zyOdYv1EohbOfNRKQSRL85EooSr?=
 =?us-ascii?Q?crs4IuEqKxwZXbTga5Qxh01p2uE4zoDZkFQ1ubaEUOl7eprs/q/T/k6m3aTf?=
 =?us-ascii?Q?pCHYmha3IP0+dfxlJSluTIXhd/W6PXmWMx5+3hc41QopzOui/bDvv7iPFwE3?=
 =?us-ascii?Q?/z3WHefNrTwNHU6ouV0RIFniymlbQDrVE7zhyUP9f5pRAKaOIeJpNHC6M8Nz?=
 =?us-ascii?Q?LcEjM9ZdMgf8HuV2t4WevK/Gj9x4yJ+pt8qaQCkekZ5vjgw5oElTxxi54JyH?=
 =?us-ascii?Q?xuKegmK0g0ys9jujHgkm0JIpt+RGQsce+bU+OMJEAQ8NkHtvaCUgxYAhnAvS?=
 =?us-ascii?Q?8qAyuIuHgwIU3z2tYqLLPlcVt5+d4HuwuDhgXE14xRg1sZynrsjEQL3NHzNX?=
 =?us-ascii?Q?GxEjuz6vAw32w2p0LaxrrSVcp6YYPMlTPdquBcav7MTklunD6HEvuwkaQPwp?=
 =?us-ascii?Q?zM+DOLUoOIxVPjTzu4iDl0sOorMTEu1iI/O+IwqH7subgOGCsuNSlG+SdmWF?=
 =?us-ascii?Q?j8zaIOo87ObslH/nRhGrrhllQnsjqZlOQWBq3TBV1o9BDiGKUe+ck5Z8SYsc?=
 =?us-ascii?Q?vH/lkY0PIT6g1Px5EJ3J3c9fN+InsKQYCKKgSAi9lvGsGr12VpqnoAz3+FRm?=
 =?us-ascii?Q?2On6j7p8prlCuNYc2jFKVTdszDBvAlF/7TDuHWMpe+p264ockPy7V5+gr6MZ?=
 =?us-ascii?Q?LrxcZBbKrsIOq2nOMsNEcQWzkhTZvryJWDifwOuwX56Nr72aF5Iw2OOrYiFp?=
 =?us-ascii?Q?0u+NPLXpe7ij3oKzp6VDONRZXgC2rNWrc3hPJEFHVm74Et7rEOw+sio9Kc9g?=
 =?us-ascii?Q?JmMPi4pXJ3euQA7aHJws24M/ttWlmScqXHBh4My3icPdqD+Z9lu2sL7EvBbw?=
 =?us-ascii?Q?F3x+8bcDX3Z0Wb3+rW0hQXTF++Xjaj6eWwJRg7+H8D/dH4zsxm6oNsKDZu1B?=
 =?us-ascii?Q?H6g+V0PbCxq00LpDAUpMNAcrRnXM/pkyzgAZcX4lNm3MS3Wix067o8uz5v+l?=
 =?us-ascii?Q?oWwza3Jtd9FY2X4oNkDDrEUFRyDB13f8S3GBssJa40vcLHSXjPP16r99Z4PX?=
 =?us-ascii?Q?o8VoeY7pdkjAnIW5j81w2OY++BvPkoAZ2vilw8RRyDDSAkAfJkUyCUY6vcyJ?=
 =?us-ascii?Q?BqxuprEpTXicK6WsBeqPTACDXrgdNwxMm9jabeYNMmgIDHaNuzjMRAv6Kpol?=
 =?us-ascii?Q?3z52ILMQlDXHNzjsJBImqZe/b7NBTtq3cUYQFgWaXoJMJgFlzeAS9mI/LjKK?=
 =?us-ascii?Q?UGF7kc61JtVjAiBIqhjhCFE1KDff5O5/TQfnrb1QN80e0X2xjYmAIgPoDWmD?=
 =?us-ascii?Q?ZtEELDaTlEmclN7S/fLAVDsqcDZH08MK9Uk1urVrity9S3QTDCaQbN7jcpwn?=
 =?us-ascii?Q?i2dTnLtNs5NGEgszy3HXZdvfTRdHQ+r5Pyz0tDCuEs/GukHA0ozcg1Istaij?=
 =?us-ascii?Q?iNUMQb46vu1uL7WeGlCXGfDFtQtdiIyWVPACNjfvsCgMMs51j2IrloarhPd0?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcc166e-4ba8-46be-40f9-08dbc2401376
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7378.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 05:34:27.0520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ciHJwTempwOo1/JgeM2mpycZilvF+QrcyphNDvLPtfnnrNlfPNS1KG9sRYYnJLTreG2t+6bAW0iVQiGlDtSIs5JmZK/sqptk1xesy/HneQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6983
X-Proofpoint-GUID: 1rllzaQwGGUl1UOT77LbiaLQS5Hd0mZW
X-Proofpoint-ORIG-GUID: 1rllzaQwGGUl1UOT77LbiaLQS5Hd0mZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-01_03,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 phishscore=0 spamscore=0 mlxlogscore=441 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2310010044
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[[PATCH] vmlinux.lds.h: remove unused CPU_KEEP and CPU_DISCARD macros] On 30/09/2023 (Sat 16:13) Masahiro Yamada wrote:

> Remove the left-over of commit e24f6628811e ("modpost: remove all
> traces of cpuinit/cpuexit sections").

Hard to believe that cpuinit/cpuexit removal was over 10 years ago now.

Acked-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Thanks,
Paul.
--

> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  include/asm-generic/vmlinux.lds.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 9c59409104f6..67d8dd2f1bde 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -138,13 +138,6 @@
>   * are handled as text/data or they can be discarded (which
>   * often happens at runtime)
>   */
> -#ifdef CONFIG_HOTPLUG_CPU
> -#define CPU_KEEP(sec)    *(.cpu##sec)
> -#define CPU_DISCARD(sec)
> -#else
> -#define CPU_KEEP(sec)
> -#define CPU_DISCARD(sec) *(.cpu##sec)
> -#endif
>  
>  #if defined(CONFIG_MEMORY_HOTPLUG)
>  #define MEM_KEEP(sec)    *(.mem##sec)
> -- 
> 2.39.2
> 
