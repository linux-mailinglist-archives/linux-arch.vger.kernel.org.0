Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA5C815F7D4
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2020 21:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbgBNUiU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Feb 2020 15:38:20 -0500
Received: from mail-eopbgr770041.outbound.protection.outlook.com ([40.107.77.41]:41175
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730043AbgBNUiT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Feb 2020 15:38:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YF2Vfu0JWAfyoBv0NbR1kcbTU4yutXS67fdG/Q9iW1G9IbTT8wDf9aX6L2AqsJIjqYJ6V1WHAjPpiF41pf1gZ9HCBFoRnyE97kxa+DS28IJJKmhHBOWl6+v0PWQmHct2MGiu+IH7+n45JKUkFHcHNbMNZ4/9jNVRJO2o4mpNrV+m7w4UOPUxHxpsGRdMg35jCpbWhZ3JVwHA6UytzplUxD9XO3p+/CUYSHno+u7AzCYfYZ0oMC4iFfcbWAY9CdfKYOHk/klc7/X/ewFNkhXQgF3nJ2QDnzsxMtTF1iqJt8X1iJVEr0LCTcaDjdMHE7fMueUKeyUjPiTMSPReIQg8nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvNiUU6gt0JTVlfR/YnxxFQBo9+afpMJYAnfIL+khFY=;
 b=FLiNMY+n5Efmc6kFCWBz5yAukj7tijh3Wy4IbmiyCR1zkLQTUm25z7b9HciY/tYmYubhjhk0hwjNckjGosoSZxrSdSAF24akzrcoePsrRDIcPyCMaQYyYKzZtP4Hq/jSrBxKPyczpoZoChhsI1s+YUAQVhG8yXIYHkF7j7zAYQvvktO3aLjPR4I4W/XIPti/po/aZAYIHPorwn7Yai89wMCMnSF7/dy5CW+v4B8JgiJwvtxwByvUMpGq/UnFcBZ32cd3SyZ4jzVGpWvq/gLw9HJl47NX2hgKNjdJwhLQODdnhkFXLah8vUtuzN8YQ0xlitcG1FrN5mzDdMxz7D+/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvNiUU6gt0JTVlfR/YnxxFQBo9+afpMJYAnfIL+khFY=;
 b=4WhpVtbpoiEr+1ZJDzNntuXqlnQCRkW+yhlUVgyAN5rW9Zb+ExWnlTU1q1D83NY+f1z2cISFu/FP0ML6F9W3F+n9YoXJ9FkupaDp44xpSbaftSYi121vqPpAvWxAMfzHYVLnAdrR3Nvhze+FEnpgmA+VKtCncrtBhr9ZaJkbS6I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (52.135.106.33) by
 SN6PR12MB2687.namprd12.prod.outlook.com (52.135.105.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Fri, 14 Feb 2020 20:38:17 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 20:38:17 +0000
Subject: Re: [PATCH v2 9/9] perf,tracing: Allow function tracing when !RCU
To:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
References: <20200212210139.382424693@infradead.org>
 <20200212210750.312024711@infradead.org>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <121a6b11-2fe1-6d9b-2861-a8ef8b42c452@amd.com>
Date:   Fri, 14 Feb 2020 14:38:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200212210750.312024711@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR20CA0044.namprd20.prod.outlook.com
 (2603:10b6:3:13d::30) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
Received: from [10.236.136.247] (165.204.77.1) by DM5PR20CA0044.namprd20.prod.outlook.com (2603:10b6:3:13d::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend Transport; Fri, 14 Feb 2020 20:38:16 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e0d6ce8-4a3a-4d64-7734-08d7b18dd23e
X-MS-TrafficTypeDiagnostic: SN6PR12MB2687:
X-Microsoft-Antispam-PRVS: <SN6PR12MB26877FFC83FB410B4A05C9A787150@SN6PR12MB2687.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(189003)(199004)(16526019)(36756003)(478600001)(53546011)(7416002)(26005)(4744005)(186003)(81156014)(86362001)(8676002)(31686004)(31696002)(4326008)(81166006)(8936002)(2616005)(16576012)(52116002)(956004)(6486002)(66946007)(5660300002)(316002)(44832011)(2906002)(66476007)(66556008)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2687;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lUuKHgcUs8KOxGSZkXT5MqdEE4XFw5veNywKynTS/GTVkWFgw+kfJaATKtdhdWqq7gwP+bTHSoJ6z9RRnGW9Au1hWF6cdAfpSi8SrcBk3yjzG0/RnK9OH7vkCBnXcsipchmIGmcVcXTZLpfHuH+IGy4Bq0DJzPNF2a0C8GIMGoRcnbUIRjdP1nMVCCCGKIqsfB9maTmd8bgPra4/Y94v5LkNCbLrwKb+owX4sBHR1aYF19EjkZ74sr/l/WNmkqSub4GXw47B2U3J9HU1aBxJz3cv6KPh6CUHs1ELyK1V0uqXsiIuGXlXfxAf17B/h32owie+qEzxYnASb5XzHZ1iB2NYi/Lk3he3MjKl3KFazQwZGuFUklZztZ4CdNWSUGpfQzjugBvzsOEZLQRSSaCZaKmB+P3aBtc6W4PKeFCfpiwLaKEGQLbr+o1GshK8pfafSn5eSJHv5fSARopM65E0eclLpUWzHeOMUOrjkvqJyVt1gTguWcTCbgXK8LybKKLK
X-MS-Exchange-AntiSpam-MessageData: LI9xBCXxPX0PRjYMsNgqaIm4nyX+0RRjPaydB+VVfhwF2n7ZIE7HGzxL1ltg8mr6fd5Lodhl0rKzKZ5/4jGaFrhXP6NtIPrCVWGS0MqZZeddjyEAhpgOBLWWLAZitZVOafeebeKmBAV08MCRHAz5xg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0d6ce8-4a3a-4d64-7734-08d7b18dd23e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 20:38:17.4267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iry6BF90gPnNjJ4U3jVdmoH/d8MwLq6gND03y5EgJr7+65mkOoYfe96CRRuVL3aQmsaEU8/AMjt6keZCBz7Qcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/12/20 3:01 PM, Peter Zijlstra wrote:
> Since perf is now able to deal with !rcu_is_watching() contexts,
> remove the restraint.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/trace/trace_event_perf.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -477,7 +477,7 @@ static int perf_ftrace_function_register
>  {
>  	struct ftrace_ops *ops = &event->ftrace_ops;
>  
> -	ops->flags   = FTRACE_OPS_FL_RCU;
> +	ops->flags   = 0;
>  	ops->func    = perf_ftrace_function_call;
>  	ops->private = (void *)(unsigned long)nr_cpu_ids;

If this is the last user of the flag, should all remaining
FTRACE_OPS_FL_RCU references be removed, too?

Thanks,

Kim
