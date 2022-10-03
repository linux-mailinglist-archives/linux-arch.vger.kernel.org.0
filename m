Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12FB5F3664
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 21:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJCTgU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 15:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiJCTgR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 15:36:17 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FFE21E0E;
        Mon,  3 Oct 2022 12:36:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eT6RSz9VUN7L0i5Y5EXBurUtqyAYf/PpzwHo+349bUxIoEBcNi3SY4qyO6cPygCyBoGz1L2PdqwRytEUThC6DzFkjXOdeQAwZrvd/0mTGR3pPdeTVi2QxCon7Sa1cwkw78O+npy7TUqIZtyoAa9okP3qWkD7yLZ5F93TkQ28Dk8A2qM7nTRKOcMcCyC5YyMdWd2BZn6o6qJ0VkK6DN1hh73svUksw17BynhR69xIdVeIBgDufPnmCkMbrkFVW4jrnjo7SuZPX3PAthZmECoS02p8VaaKrZhWo2RkKBvTRJYfVSQ7tOCwkJYh6xYQ3w7C7UW02DcukVi1JGTdaW5uoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IW7adR8KqqmMdYe+QwFifbDvvMI85xms/1TFgIqgY6A=;
 b=mQn0jsbTHr7XaQSimY7snLD5HYC67gCZ0JGkw0GwMSVnZy9yA8y2B67cUQF73kLvptnnaSAQuZQQcJqYnRrg8o951mEawDmtRR1NiElqtBUxuFN1Ux9hJVSJekt4HXVAOjXIh85CmRk9WzarHGOP0HzCygc7TowlTv+D6mmiW0iy6G5yYmaj6Ivh5t9maXkZkChg+EMUgMSVLgQ6zCySbVs6wAUS8DFSW56KzeV1K7gBeE0nIRcKBKQ1itXVgPf92JGDAhm33F4CUC/fFwFNoNrw1vm+DD9O5stDakzZv7CCeAaVd4b2zuxmpxCrRbv1PD5j90CAzZ9ptb01yqcEJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IW7adR8KqqmMdYe+QwFifbDvvMI85xms/1TFgIqgY6A=;
 b=c5U3xoHmH5Hp8Xht+j6pPaDSM00fXr5w823EYMGHb230BUvS8sAWoArO3MDkSq7NHUILgncBKPTAZbIq8JJ6O5PqmZGRJklbTTpRMwtP9gNYM1Be6tOSrA1qZGJSof/GjM2OGQKJ3BQRCbr0hLo0UyFk91kGt4NoYQIhCAmRSmcJP1rJ26eueA9GiNKraNjXATkpWxyUo5lso2zNNJZIc4BX4Ms0RnFfdwxJs+kCvCe2jpi64nTazYI+DNczieZZ4PnXY7KJaFPpDFmc3UURJPEzfiVtjb9Rbxob/k7imzoZDHAEEWLAAPjie1KDkn5Cyh+wQoH+PNf/a2pVhuzPFw==
Received: from BN7PR02CA0016.namprd02.prod.outlook.com (2603:10b6:408:20::29)
 by DS7PR12MB6286.namprd12.prod.outlook.com (2603:10b6:8:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Mon, 3 Oct
 2022 19:36:13 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::e4) by BN7PR02CA0016.outlook.office365.com
 (2603:10b6:408:20::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Mon, 3 Oct 2022 19:36:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Mon, 3 Oct 2022 19:36:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 3 Oct 2022
 12:35:56 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 3 Oct 2022
 12:35:55 -0700
Message-ID: <4102e1ef-c0da-37b7-6b54-89027fd9d080@nvidia.com>
Date:   Mon, 3 Oct 2022 12:35:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 01/39] Documentation/x86: Add CET description
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
CC:     <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arch@vger.kernel.org>, <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, "Jann Horn" <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        <joao.moreira@intel.com>, John Allen <john.allen@amd.com>,
        <kcc@google.com>, <eranian@google.com>, <rppt@kernel.org>,
        <jamorris@linux.microsoft.com>, <dethoma@microsoft.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-2-rick.p.edgecombe@intel.com>
 <YzZlT7sO56TzXgNc@debian.me>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YzZlT7sO56TzXgNc@debian.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT013:EE_|DS7PR12MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: d07ddd45-b402-4bad-49a5-08daa57687b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qE06k0FGQPbPPBSPhiXMjRnOkkCj17qIdRmN98HaNbDllwXe+GkQ8yIMCsEBmAZh7usSAPMpEa9H6Hi+hXxTaThFhB7l0CAM7HenxMlPbFFRL89WtLsiv4JgJKpN3BE9D+sLiTKeFMQ3Vp5jYnb8PO9p85kUOCVpJ0hBtBKZ5DzuJMUnU96v9krmCblpERy+TailmDQ+OXVxYjlDsY3tZ2xlbXXp77N6Cl2ng42mTCuiIPuVXD2XqeH5W/zXKqYqDZE4Gt3fE3Fwr4sPB9QVgZUYE3fCKBGzUKnGYg0UsAy1/y+9d7MtT8S4DF2n5H5T7yPxX9cgF5q/dARic5F4D/A5TnRNUV47Tmuv2vn4WluyIhBI9pSaKlXlFezE+Bs3hSWxrTe0gLX1I4arkumwcxAXdOtuFp0PRMAg1u+l73D9m7GaLFmIUZ9F540pxZWadiFAOlDqAgRR0DrWp2/KcC/yiWBRxh7VbPminXqXfxRQjH8xYaRiXWX//cj48Bj7xE8NlOEW0yTnuXzb2pQa2Xj/ASmweaU4wxfwOVW90X0FshwbnJ1DneBz+/qAU9M2f09mblEzSg1+7vz4tj5QLHtcU0UWQyA5fnVcl0EVDH8xhFf+xq0dqxuVAd3aPM3ECdqFcYBvvpKsMX2Iq0IrNMJ32p023bhrf6XhyBj+H9bGWNz0jZebodPcfI/dhJiURfM9u0sp2F6hfoyM9zkynhZOCfr4SArSRrUxvEH4JI3UQWPJh+rxCebsBtnhGWtYqG/tPPuZPIx7CZVhYncJJ3M2sjt3tiN2Zx48lPATECPu3bSWTMQmh7YoyROxfTdR
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199015)(46966006)(40470700004)(36840700001)(54906003)(7636003)(356005)(82740400003)(2906002)(110136005)(478600001)(7416002)(31696002)(86362001)(16576012)(4326008)(47076005)(16526019)(8936002)(186003)(2616005)(336012)(26005)(53546011)(40460700003)(8676002)(83380400001)(70586007)(70206006)(426003)(316002)(41300700001)(7406005)(40480700001)(5660300002)(36860700001)(31686004)(36756003)(82310400005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 19:36:12.5975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d07ddd45-b402-4bad-49a5-08daa57687b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6286
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/29/22 20:41, Bagas Sanjaya wrote:
...
> The documentation above can be improved (both grammar and formatting):
> 
> ---- >8 ----
> 
> diff --git a/Documentation/x86/cet.rst b/Documentation/x86/cet.rst
> index 6b270a24ebc3a2..f691f7995cf088 100644
> --- a/Documentation/x86/cet.rst
> +++ b/Documentation/x86/cet.rst
> @@ -15,92 +15,101 @@ in the 64-bit kernel.
>   
>   CET introduces Shadow Stack and Indirect Branch Tracking. Shadow stack is
>   a secondary stack allocated from memory and cannot be directly modified by
> -applications. When executing a CALL instruction, the processor pushes the
> +applications. When executing a ``CALL`` instruction, the processor pushes the

It's always a judgment call, as to whether to use something like ``CALL`
or just plain CALL. Here, I'd like to opine that that the benefits of
``CALL`` are very small, whereas plain text in cet.rst has been made
significantly worse. So the result is, "this is not worth it".

The same is true of pretty much all of the other literalizing changes
below, IMHO.

Just so you have some additional input on this. I tend to spend time
fussing a lot (too much, yes) over readability issues, so this jumps
right out at me. :)

thanks,
-- 
John Hubbard
NVIDIA
