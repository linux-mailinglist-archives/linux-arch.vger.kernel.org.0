Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E3952FF02
	for <lists+linux-arch@lfdr.de>; Sat, 21 May 2022 21:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345284AbiEUTm4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 May 2022 15:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbiEUTmy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 May 2022 15:42:54 -0400
X-Greylist: delayed 5820 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 21 May 2022 12:42:53 PDT
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02hn2236.outbound.protection.partner.outlook.cn [139.219.146.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCD762103;
        Sat, 21 May 2022 12:42:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGbB7qSt294KY0C3Xe48IOfj1O3h0r+yNuhmXGkPQZk45Wnl7VCQ1YuLAuIj0VroGqK5ajuxe7VN+KPokLsBRZFIKHY3rDwofjl37wQrKVAsgd0CFR5AfqDeu7IcD2LErvo3huCEJU+B4gvQWZQWvXN4wu3Ld+nRIEicjq5X7/KPMLfCmK4M1I0DrYL5jKtizEAX7PvHWA4I6H/cWzdwYgIErMmdSoXgtVXzuZf5iltlp1UHpIvTMf6hb7v1/v/FVxoyc4iaWCOpPTKMTfIj/eykqybGzGn9eY9PmGdfpiSvdC+Gi/2Gh6bxGJPGY5d7/BO2qgL/XCzpwDsWKbAqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3z5uhVUtqN5OyplYkKXQ17d4OAmlRJ8nVcEl3nfclrI=;
 b=KtcYvJpSs9MztnPjpxTJFep4texRJaaJnT9GRJBu3cUzF9P73n/xzZtYOt9fHxBwrfHI9FW0ZuNwqf3q/35bi5eMpvgNZBQwKEYuO1jmTSnWB6DmyzDByT5zbML8l8OPRS+cjy3KSKVZF1S8xCQzt7Kd6dF6VtOXe3mrfMd192CQaatQVtS2UnXGysv3mE+QXYgj0jQPzNXoTEeThoS/bKjLJB0h1qqpngbQGqZrmwWWN5G8BL4EeCtNOr0nw2fTOJ+4Wyhgn0+uYh38PP+dJKpiKw7AgqRqRmrE9rC6lMez6MagE4lniuQlV/4iQu1YpYJxmO5GomQi/Tiu3LdWvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gientech.com; dmarc=pass action=none header.from=gientech.com;
 dkim=pass header.d=gientech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gientech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3z5uhVUtqN5OyplYkKXQ17d4OAmlRJ8nVcEl3nfclrI=;
 b=0UcuLXQeFr/spn1VxtQB3zwcZuwTPkQSoGlkWHLHWTOieugSZNVizOVMaWfVK0+GMb9+qwvmRauPDYPRqHyLqJREUjVF+dCkY8hebHSPgBasZySH3u0BbuScdno79CAgazWYSMMLpfIjtozbByOkve7dZ8g7MVW8jfLyy280uOmrh6uC7rtjq69FqNrbPz5Ik9o/7aTx20Fb3a7aBUitQNgKunkJWwVQe/kJGz19jTURPMoQrVRa9poWjEbTKtXcxF8AsKIUqtDUl9Zr4XPcBHtmp5T92N7c0Jk+PtP60h5RtcmtUm/SRnLXueI5jVPYMAVVW3bWOfWNaFfOxG8+/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gientech.com;
Received: from SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn (10.43.106.85) by
 SH0PR01MB0506.CHNPR01.prod.partner.outlook.cn (10.43.108.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Sat, 21 May 2022 18:05:48 +0000
Received: from SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn ([10.43.106.85])
 by SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn ([10.43.106.85]) with mapi
 id 15.20.5273.019; Sat, 21 May 2022 18:05:48 +0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE..
To:     Recipients <tianjiao.yang@gientech.com>
From:   "J Wu" <tianjiao.yang@gientech.com>
Date:   Sun, 15 May 2022 12:39:09 +0000
Reply-To: contact@jimmywu.online
X-ClientProxiedBy: SH2PR01CA006.CHNPR01.prod.partner.outlook.cn (10.41.247.16)
 To SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn (10.43.106.85)
Message-ID: <SH0PR01MB0729B155F31AC2CE0AFC44BE8ACC9@SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a8f2070-4407-431e-c0e9-08da366ff5f4
X-MS-TrafficTypeDiagnostic: SH0PR01MB0506:EE_
X-Microsoft-Antispam-PRVS: <SH0PR01MB0506E163F1B5509E32BA7B608AD29@SH0PR01MB0506.CHNPR01.prod.partner.outlook.cn>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Da5invq79gN76MrTZtNzfLcdxvmUAtpPR7attIMfvRK/l8z+RrPFTHgqIY?=
 =?iso-8859-1?Q?OcUyuBQDbeHjPJyF22kwgz4HygJCdZMcw5uK4kyTPuAvSyRyYuMKvdzDL+?=
 =?iso-8859-1?Q?4ddZY04bVMDWX8Usxh9u2hdtKRb94DCCfL0stDMHmEyfPWMh5Abj7z5P2O?=
 =?iso-8859-1?Q?JgkKQQeASOeE+UjAKv5R6Zx6Hh9c1+n96AjR4n3qAaJ7MZdylHSznP9pvw?=
 =?iso-8859-1?Q?n/FpOFWe3BXjP6XlsAJrZmGNIFiyqdChV2aMwS6nLUIJye1POZ+uF4XwjR?=
 =?iso-8859-1?Q?qrUTxbrnbHnwwrtxFMCVEddrRCADfib+GuZ8W7gZBsLbygvLqIcQixQCtG?=
 =?iso-8859-1?Q?r1LM2IxpNJhcUA4xkXQPnW00YkKYS+YISPUIdqPL1orxXV0+epNWyDFrQB?=
 =?iso-8859-1?Q?X8rAo3mB8rQ72TUfbyY7+i2sPesSH8XCbpB2N5Uerjx6+1WfJf6fqm+yKl?=
 =?iso-8859-1?Q?4PY+GvfOuws1x+0uGhJIQphJpIrPbv6NhkIprjPKSNxG1bzV3PfHqVY1JF?=
 =?iso-8859-1?Q?tRUlpWtNftc0Zm4TZ0B471v/ClhPhZs07ZxyI8O10U8p6Vjvw9sQvhQLzQ?=
 =?iso-8859-1?Q?PXQOvU84Xivrot2KqrYu1sBn8ginp+RUDSMShfEuGLSj9KlHoTmWObMh6x?=
 =?iso-8859-1?Q?9z4Co8sJxenQXGjzFEyjowjEcfHoEVNbPQgPGIbfmEsoHL6xXmpp0+FUzB?=
 =?iso-8859-1?Q?AJ7SEepEW8h0le7QXeQo6UCracaVTIiOLYAUfITI81/vijfnLc6zaZvmm7?=
 =?iso-8859-1?Q?ArH0c4nZ/ANpm5N5F2wHaNklq7bnOng5TCz7MrkxSBRjeZJtamg+py5O8K?=
 =?iso-8859-1?Q?yzrbTgIyLLdxpTU4oWnNRx8QI1kgk5o3dcCewY55UMQZN/gZGaHDlV4tRR?=
 =?iso-8859-1?Q?lq4Z+k49nh4nvtUD6wtzdWmXuCTLnQ8lP56FKQCPmIOSut3md+JUBGAdRU?=
 =?iso-8859-1?Q?9sSauLgBFxn7p92d5HA/zcW6UvNl8G+qqG+D42bHmgFIoYdS9dQnbxnotl?=
 =?iso-8859-1?Q?qUvCJ3wv8L4qFsoI4QS/9T2guEHcrdFzk8e2NaPIU9aK2WjhtpuQp9T4Bu?=
 =?iso-8859-1?Q?qA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:OSPM;SFS:(13230001)(366004)(3480700007)(52116002)(9686003)(6200100001)(508600001)(7696005)(6666004)(86362001)(38350700002)(55016003)(38100700002)(26005)(40180700001)(19618925003)(66556008)(66946007)(66476007)(6862004)(7116003)(33656002)(558084003)(2906002)(186003)(8676002)(7366002)(7406005)(7416002)(8936002)(4270600006)(40160700002)(62346012);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1MrQ24WbCu/6DCMOZBKUKmiOOC+kY0aubPZ+61I5g8SIoR3SFnCn0ZhCJX?=
 =?iso-8859-1?Q?dm1pF9nldaCOJDjZQJ5+Zh8dsWvNbC6N4BIWx+92EzZTUSjtwjBakj2Kha?=
 =?iso-8859-1?Q?KfDoSv6Yctq2ef1MPPwp7IV1x4A2bWMCEG2iX9BktLwNx2pK5l04JXhiPl?=
 =?iso-8859-1?Q?7Ostv5AWi+gTtp7dJnn9p05vrtB8/Tmt9bwIwUgnxJCDOEVn1vFU/3pj/q?=
 =?iso-8859-1?Q?fhZucC96RUl9pl0OS6OtjTiDO97Wk36yMtSQDgzrqZeCH9rs0wshBe9bsO?=
 =?iso-8859-1?Q?iCIBaV/0bonpM3IJD1ld88qFY+P7MK8+pJPMjKoxvFWzllgtgAnWhSrdBK?=
 =?iso-8859-1?Q?OsZn3O1fEKpBzUfb+SeBCT+wljut5cqEHJ92DWvVcj+JXSi/nSYCvdKT1P?=
 =?iso-8859-1?Q?bCu54LB3YCVss6FfJFDLY2RnpNt9CC1Gg/XpXQFTICR9lAAOzk4HTuRn3+?=
 =?iso-8859-1?Q?xJ5AHezTeELpnyTNSSQ2oysZwWzm/3GsLI7BstRJYuZaSjW+zCFXcbWdkm?=
 =?iso-8859-1?Q?E/fU4Jzs3aZgaHTYIglWGfn75aFMLqYSsML8aqNE8VuiSwjn98tYECt7r9?=
 =?iso-8859-1?Q?VfMy30MBiHYJM/r5D3Z1Yyr+OZsZ4F1cHX89NeR2PBv6B8A4F/bXhTudCn?=
 =?iso-8859-1?Q?Rb14LFuUqNOYdmq6Fl8F99n0M8d15IFYgI1dqLPAm8BXjjX5c4HphZgQ5Y?=
 =?iso-8859-1?Q?mLLukhc1D6cESvEHrwI3jacQkoJqMT+a2/rxavZzyIjvOSQU14y9U0K9gz?=
 =?iso-8859-1?Q?dO52qylGUVkYTEGnW9IRFDiYmXp3tTGDEZdp3RYsmq+hqQOrI54RdG67Xk?=
 =?iso-8859-1?Q?N5AtskQ1tUQTzqS4UN3nkN/gQLs0RTEhjAYOtGTA8S9uLuzZUSYwv5x6NY?=
 =?iso-8859-1?Q?NBcDcuTZABBVvQh8B5fBr57b01gF++0n+yr5+vOcTd8stVmOYm/mL/W7hw?=
 =?iso-8859-1?Q?hRPs7eUlJstR8Ma77nVBLJZqYN+e3sspDypP5JPlp1rG8F0VzUdON8pvc+?=
 =?iso-8859-1?Q?nDa2NTxeG/k/ssZnLJVDhFf9o38yC7uD3VAUQBYhbQsyX4/qggczsq0+Us?=
 =?iso-8859-1?Q?It+ezmGc6UefAWfLQbwgUYZhxrRB77dP0Ar4vYRnFfwo22+5XZD+/PNXjE?=
 =?iso-8859-1?Q?Hy88Ty6Ys5IUOQNZAAwQ71n2HbH3utXNKW/OShLrcmy3jSqpP10JJ3uo7x?=
 =?iso-8859-1?Q?PkCtleO7y1TA6Gd2lnpfyFAwF64PpY1pxkFsSJgTnY8g6StpwdjeNjgsLv?=
 =?iso-8859-1?Q?i8f1eLfMFIotN0lS3cpwzY46UHKIy0JIvA6lq6/n3f9vpo8La446A+4qXY?=
 =?iso-8859-1?Q?G9ZMnkm2K0Y4nwwY3ExyENgOuhBm+3dGDlJb7HSg+UkeAQvU3jrsEPx/LZ?=
 =?iso-8859-1?Q?/wlEfcEG9VLxUKnag2Z/G7aAK5QTLCGdzO4uI5h2DmrOrPP3t3XvDVEB9u?=
 =?iso-8859-1?Q?qmhI5ypg3blWN8Rd3d33aOagSau1gz/XWjxR72Dxe58PkbipN7OAzSmUJf?=
 =?iso-8859-1?Q?9yjkRxv58bl8x2hFOI1+lG7cJRuZ57Yp+giNQJjq1ICqbEcBNSBT1Wtn7f?=
 =?iso-8859-1?Q?1QKvXikKULtX2oLV3ypsgC9KfAzAmgawUcFdGZiPnNm8MLoV6F4u4bdUnM?=
 =?iso-8859-1?Q?XdUz9zW0KTpT56UvkuewuzfAB7oZwd2bfngqu6H1xsX2clt1wL5lRsLK+Q?=
 =?iso-8859-1?Q?dMmfxoeK0KPlvxMbu95BnepcbHQ4syMIWt+7jCkqyBmmjWcFYVTn3BUy9Z?=
 =?iso-8859-1?Q?rFqLisd0w2jMqzgL3qQ1srV8w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8f2070-4407-431e-c0e9-08da366ff5f4
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0729.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2022 12:39:32.3168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 89592e53-6f9d-4b93-82b1-9f8da689f1b4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpZX+UcjSvphz8S219P/Wrbei0WPxNw7PzTmqTzWC8kOVwh/Sr6N017LMpJ+0SHE4w3Zo4GRxzG2V9PzPw7Z37tdZQAyfAy6zohUSeIXB5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0506
X-OriginatorOrg: gientech.com
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_50,DATE_IN_PAST_96_XX,
        DKIM_INVALID,DKIM_SIGNED,NIXSPAM_IXHASH,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.0 NIXSPAM_IXHASH http://www.nixspam.org/
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4657]
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  3.4 DATE_IN_PAST_96_XX Date: is 96 hours or more before Received:
        *      date
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.1 DKIM_INVALID DKIM or DK signature exists, but is not valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Can we do this together
