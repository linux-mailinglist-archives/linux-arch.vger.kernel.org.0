Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AC8623797
	for <lists+linux-arch@lfdr.de>; Thu, 10 Nov 2022 00:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiKIXkr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Nov 2022 18:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKIXkq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Nov 2022 18:40:46 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FE819016;
        Wed,  9 Nov 2022 15:40:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUL8AIUveIcwUPEBnlYgaqx775DGnC2Y8WzoR/NdONyj73hLR0v8MRGPZuf3q1Igz2vC+1oBty0U2cFQHvqzkryVX6GSJ00rvT+GX1cb+ftTazNNdkeH1PNWBsm2LiRA2+nv5mWUxY0MM3fRWOYofDyizaeP/aSCRxyLEk72APm2GN7eS9EnPJpmGpjFPz7XjLXMNzEQbk7LB23F4w1XHPSjnwbkcJTjLnUro4jGpDOr8Ebm2YoR2visJyBS53Vpo+BfIXUnKRzYMrmAvmzuV3ekGuB+kvEJE0vUnkrQYwkT+uloqFdvOyogfEJZy4ZuEYlmUK1r2MAkFCrGYkYiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTfm7foHzCbZec/7hfj3S/VVh0uBxftPFvfC08+naRA=;
 b=PXrIjWG+kGOZIDW6+I1+VXlOiLlxDxpgrH7l4goLrqr3ec0no1OGaYERKphMTVeLb0K+c3xHwW7EIuHBgoxbV/b1o8i2HFgN1OC/0zX2G5sIJZZSBjgy2aOaX+TOZzk1CXK0Lgc39rgnkHKVPIXz1npeLIuhoGXnj5dM2fCeJK5V1ITSrmwxlj0D6fjMJ/hLMgLFSQQ/hYChanhYFchP/08GAPxWhhCm6T0q6SsDtwbGYvqurlz6NH0GeyzevWmoVp8rB8tvb2+vw/Bcl8e8Hu7Zn13GTSCwWfFSZXjDMGohHGWMMH2pj4leyF7UtqMHQ2gjCZ02JjTemarF9Nudrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTfm7foHzCbZec/7hfj3S/VVh0uBxftPFvfC08+naRA=;
 b=PzXXQG3dMT6z0wM+NhyxcZILOabVAhowSoDHELgQdgQA/8QhcXlCntygEkOrCLYjGEkeHXNOKknwu7+Q/S2k36E1A5BPgX5PWZIXLHlRif9XuMBRFof2lhcWMJI7Muc9jOncFSPwvOQ760Wahug+WBhixNhk6TwnCqzKA0ULoXQ=
Received: from BN7PR06CA0061.namprd06.prod.outlook.com (2603:10b6:408:34::38)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 23:39:22 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::8e) by BN7PR06CA0061.outlook.office365.com
 (2603:10b6:408:34::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 23:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 23:39:22 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 17:39:19 -0600
Date:   Wed, 9 Nov 2022 17:39:04 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Tianyu Lan <ltykernel@gmail.com>
CC:     <luto@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
        <jgross@suse.com>, <tiala@microsoft.com>, <kirill@shutemov.name>,
        <jiangshan.ljs@antgroup.com>, <peterz@infradead.org>,
        <ashish.kalra@amd.com>, <srutherford@google.com>,
        <akpm@linux-foundation.org>, <anshuman.khandual@arm.com>,
        <pawan.kumar.gupta@linux.intel.com>, <adrian.hunter@intel.com>,
        <daniel.sneddon@linux.intel.com>,
        <alexander.shishkin@linux.intel.com>, <sandipan.das@amd.com>,
        <ray.huang@amd.com>, <brijesh.singh@amd.com>,
        <thomas.lendacky@amd.com>, <venu.busireddy@oracle.com>,
        <sterritt@google.com>, <tony.luck@intel.com>,
        <samitolvanen@google.com>, <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-hyperv@vger.kernel.org>, <linux-arch@vger.kernel.org>
Subject: Re: [RFC PATCH 01/17] x86/boot: Check boot param's cc_blob_address
 for direct boot mode
Message-ID: <20221109233904.scct4fih3b3kvnyk@amd.com>
References: <20221109205353.984745-1-ltykernel@gmail.com>
 <20221109205353.984745-2-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221109205353.984745-2-ltykernel@gmail.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT023:EE_|BL1PR12MB5301:EE_
X-MS-Office365-Filtering-Correlation-Id: dad9e2f2-0aad-4603-29c6-08dac2aba106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fMGiyX0jM+C6sm/vkH//j6P/FZJ63m5OaSaYgkfzdn5qDPq1OqPVMyT1kxq0dCg8VHEotdo+9Vy2Cww3MlYhyumo5HLqPjLtNF+gB+42g5mxzmb/HIgqKNOKWNIb4wIt7Gaug3h44tnrjXyIAdzkXs+M/IfY3GHAw+LuP7Q0e7ULwt4AeZXhhIPu+/o8yk+jq8SsXFDE0S9M/876gynqF5ZhoB9Yk0xM3k8CPRX4xr65wIrV00S3RpalA+6JfDLABjjFiAGFNEhJ/PLaRIC4BjtJO6gRgo6gqNj2E7lLpTfKTZbnxOoO+ACCP479kYiOfT8UGSvUp6vCPBMEeedzlplS4DJLYtCfDVG0YMbjW0UwWduFku27bc/87F/FNr/0iV17aC5gD5AQuNjcE6T1jr+iTvT/ElCrlMwstk26t9kZW8PxsghoRj3ylcvczntQa75MFRRbKsfmQXYwMtnv50xKtZbSg0FRu84lZMFe0BObS9NZpLR9vdxUVeV3t/rK2qELjsa04hZ1BehU/tgARJSQlARxE5AV5HSTPolO+VkwiYLGb8E0O8jKD2dLkrZiD+pl+AaD+i1lhPL1pDKG9/vt0EaMFrlYPpSeLmeBtQP8yqoUBajcASsyHOo8nW7cs+OjdASKljEoKpSdu4kTyBYjB7h04wny65ZLlgQJSZxG9BEVzKcaoXp16f2R5VDfSsifyM4RibOVlnr9DXnHZOg+sk8P65eAkHYjksieIi7+YwaC0IisrlPID4jtwS5zzCGBnlRm+Zd4fW4wis8dEKDqxXqFh/FBwpZ5d+GtCJQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(81166007)(82740400003)(356005)(36756003)(36860700001)(86362001)(40480700001)(6666004)(316002)(40460700003)(45080400002)(54906003)(6916009)(70206006)(478600001)(7406005)(4326008)(70586007)(8936002)(2906002)(82310400005)(8676002)(7416002)(5660300002)(47076005)(426003)(336012)(41300700001)(44832011)(26005)(83380400001)(1076003)(186003)(16526019)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 23:39:22.2609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dad9e2f2-0aad-4603-29c6-08dac2aba106
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 09, 2022 at 03:53:36PM -0500, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
> Hypervisor may pass cc blob address directly into boot param's cc
> blob address in the direct boot mode. Check cc blcb hdr magic first
> in the sev_enable() and use it as cc blob address if check successfully.
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/boot/compressed/sev.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index c93930d5ccbd..960968f8bf75 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -272,17 +272,24 @@ static void enforce_vmpl0(void)
>  
>  void sev_enable(struct boot_params *bp)
>  {
> +	struct cc_blob_sev_info *cc_info;
>  	unsigned int eax, ebx, ecx, edx;
>  	struct msr m;
>  	bool snp;
>  
>  	/*
> -	 * bp->cc_blob_address should only be set by boot/compressed kernel.
> -	 * Initialize it to 0 to ensure that uninitialized values from
> -	 * buggy bootloaders aren't propagated.
> +	 * bp->cc_blob_address should only be set by boot/compressed
> +	 * kernel and hypervisor with direct boot mode. Initialize it
> +	 * to 0 after checking in order to ensure that uninitialized
> +	 * values from buggy bootloaders aren't propagated.
>  	 */
> -	if (bp)
> -		bp->cc_blob_address = 0;
> +	if (bp) {
> +		cc_info = (struct cc_blob_sev_info *)(unsigned long)
> +			bp->cc_blob_address;
> +
> +		if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
> +			bp->cc_blob_address = 0;

It doesn't seem great to rely on SEV_HDR_MAGIC to determine whether
bp->cc_blob_address is valid or not since it is only a 32-bit value.

Would it be possible to use a setup_data entry of type SETUP_CC_BLOB
in bp->hdr.setup_data instead? There's already handling for that in
find_cc_blob_setup_data() so it should "just work".

-Mike
