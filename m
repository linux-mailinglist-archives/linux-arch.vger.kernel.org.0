Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD9A73A964
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 22:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjFVURp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 16:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFVURo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 16:17:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3461BFE;
        Thu, 22 Jun 2023 13:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687465063; x=1719001063;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/9P4Z1JxasUX78KsvxpVXpRGA8I3xehHwXGpN1yU4qY=;
  b=RoGzXKBhksyiuWgE0muc6m2e/Evvj2mbXsvfn7rig7jD5/0WKveCh42O
   wL7O6EQn7iAo8EQ1RrSwykyaHUkE9elv2adRJcewoVEz+xDsKZgN6CfaG
   6zKwFy8A/g5YVOkKfLQHvOLOiOLBwozf9M6h9uKN03Dk51PsdeGXvkdmY
   //XYO1xmfGPfVkhXbu+WjutDGzHtI/aoAkfloshaNQTJU9fcrErNiY0BK
   GMAsJV75yFTWnAr8Jk3PZqUsGVtjcvdtBm+scg9F4j+1jXYYyobgP+4YX
   AX6Ndq411LqPB61DWB+6V+nJEGYfcfmMgzwALZNMiG6SBu84dOkmbsopT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="345363392"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="345363392"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 13:17:22 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="749475552"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="749475552"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2023 13:17:22 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 13:17:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 13:17:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 13:17:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THRLkDzAWmYUcAwfxRDv9LsT/C/y1qhe2oNxxxF6lcJD0S8X7hOvKOiwqkmhWctxTeGRQhmBWX0AaCtm2uAhVGoGRzhS3AS6DnWXN70imN3bvYokrQT1Q8XygJDHzyb76J8JGTYKUHG2aGvn7VJobdbE2b3qjwX/qGC5/joL8BAgFdfZIM7Pns/lyxGjp4dga4WVrmVpmBe5onKI6cakAWEKxxdzavj8NB0wer62M0H9v+Xcs21YuSU4c5ZP1XBQeHJIzgKdC5o1Hw32EQJcC5lRQXZjxy4KlsZXGwu1GO5rvV/TDuN66yX97EhmFMg3X9JAChuA5HO+pobSAFswjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0hGgO4LVzsKhdEuOUNKLHpihF8tzgOIHe5FXWZgrUA=;
 b=UhTsmuecrmZyPJgObbrzH6gRQc71qLcTHGfhr0mAOp+vdxuOqr0s2kRbrKkMYOMkUPz6xmrQDuRrZrpYnojqz4vRx4Cg+jGMHYjmj2gJfOmkkP4q2Wb3fzLUvlkJZwpTt7lc3WeNIu/g2Z6J4y74mb5LGY76KnYGWuUspcsLu0RtP+AyeMkK7dhBs+gaDqGVbVTp7gjhei11Vh/NW8BzO+L//cmkLBplNL+CaSk/YD9ts1F3ASDFGz+bCIJKDBQlrlr2kU4UiSh0rR8mhXEM07JYD19TK1DgdjABveXXVMM5C+Lj5TGMv4VF6NyFaKqyNArTlB/6HwRPvEWF2nTYVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by IA1PR11MB6417.namprd11.prod.outlook.com (2603:10b6:208:3ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 20:17:19 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::455f:e688:3955:28b2]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::455f:e688:3955:28b2%7]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 20:17:19 +0000
Message-ID: <038984b4-9e95-bc4b-e763-95bf24426f07@intel.com>
Date:   Thu, 22 Jun 2023 13:17:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] syscalls: Remove file path comments from headers
To:     Arnd Bergmann <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
References: <e1a2665d-2e11-7722-a7ae-ef534829ed37@intel.com>
 <20230621223600.1348693-1-sohil.mehta@intel.com>
 <388c9fbb-2782-4990-b432-eeb999308869@app.fastmail.com>
Content-Language: en-US
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <388c9fbb-2782-4990-b432-eeb999308869@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::31) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|IA1PR11MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 194f2aeb-6539-47ad-16c5-08db735dadf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qp+ewwlR862bEozL8HNYbmACdf0o+6ADFd0Gnw/WNvFzL4wk4l/lQMIzc+do3cwdnPm02TIiiqqCxe+koqiCdoKs8vmc9tAzEuGfmrylL5HwbeT+ni0t6xOHpMh+RlzYY97k4F5UehlcAx2zWRTNLww07Fwdq3YTjG9Kt4YnWHb21+zCwteDVki0lb0gEurxS7ehOXwgD42C+Ug/y1IiASsOCs8kvrng5tsP7mn8HJXlsstTmVX+cbgxxDmb7UuFyDc4/DuHTWoqW4hNy1k/hlrMdDhT0UV47fXa1M/XTikx3bkdpu1pmpsGEqscUmC+leuuvyIlS5lDEJaORT+VqnZJWp56LM6Em75V+mwI3LwDZPJ1PfnpyMIIAB2Vt+7CK7uy0CFrrs99MsGT7nyb7ZyKw5GgXEEW6oDX8M67gxDbHClHFid8C0WbDuCaiObjmgHpZAedD0jYQlWdL7hNCZBGrMsmPv5SpVSSk0qSLoQ8FuervGi8ATtvYk0wFkXP66dQ2leGbzyRYO/gsONpd4dDaGlSKSVUSudFauqfi1tL4Ouzohq1RJlU9qMvjh8Wrs9GD9xjYVBxraCCEmRagLdGZ3aX5jIZe1l9Rb9hMZGIbUpoYn659fBDCL3qKbYwWfE2UUpXQAyogqVEdxWHvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199021)(86362001)(2616005)(478600001)(31696002)(186003)(6486002)(41300700001)(4326008)(316002)(53546011)(31686004)(66476007)(6506007)(6512007)(26005)(66556008)(6916009)(66946007)(8936002)(8676002)(36756003)(44832011)(5660300002)(38100700002)(2906002)(4744005)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWNEd0kzN285bGFhTHZxN0hWSXBDUHIrTThlZG5KM1AzMUo2RElqT016Ykk0?=
 =?utf-8?B?Z3h4RHIrbHJBNEE5TElQbG1zdUJmS0xvQ1UxVlBPRXBITzZDMEZUVWZBSk9o?=
 =?utf-8?B?WTFoMUNzUXdtNk1haEFOek1mdVd2WlY5TzJSdHpMUFlRbjFHZmtSSjVmRzgr?=
 =?utf-8?B?cTVxSTJKMDB5SVhMc2lIOHBJMFZnNmN1T3hXQ2V6QldzVE81Mll3M0NmZzlO?=
 =?utf-8?B?RWRTSXJaalVnUUZ6Ly9UUEdWeWRVcXpIMDdCSVNhYkdienhob1VIRGVuVmxa?=
 =?utf-8?B?clA1SFBibDN0Y3J5bk8zMkZBRjdpM1k2OUh6RjErdXdjK1VMeTA4c1NNbU5y?=
 =?utf-8?B?SW9TK3JydFl2QkJuMkJycjA1SzNHR1RpaW5pNkx5UHpYM1lXZE9CQVJYZmZD?=
 =?utf-8?B?bUl3eUtpRnRLbEVhOSt4aGU3eU1SeldvL3lrUU9zQkx6eWxjMEhvck90Uld4?=
 =?utf-8?B?YkEwa3N6UVNoY0Q1ZWl3TWg2aEcvcm1WMWt0WE9VMU0zaXo5TVF2N3E5WlRw?=
 =?utf-8?B?NXpZN01ZUFltRDR0VkdNdmI0andvcTlGS2RHK05CZDVvR3lrV3RPT2dXRjhs?=
 =?utf-8?B?dTljc1RZNkc0UHY3VFNsZkFQTVowNm10NkNHdU1kNy9MMTFSV2xTQmFnV0xJ?=
 =?utf-8?B?YzV5NjVHVHkwSGdyZUJMZXhuZDZCSDNkT2tzVTVOTlFEeitUTWJsdkRrK1Vw?=
 =?utf-8?B?Ym5YZ2JXTjdWWjdCdjFodk9LemFMRnBJdjR6UmtnWFIyRVlWcGM2MHVWRzJC?=
 =?utf-8?B?WGNwa2VMbms0MHgxYnUwTGQzdkpYQ2d4NTJMZ3FjLzN4cjJObTk3TUdxNlZU?=
 =?utf-8?B?RVhiQjRXMUhiejlVOC9BQ3ZzaFd5ZFJsY3RDVGZtWlZKMTh1RXRRYkVwNzdI?=
 =?utf-8?B?RjlJWU1GaTBqUzdmUW5TODBOc2xiUEdpMUxienR4T2dNVDRNbjJVS2UzY09S?=
 =?utf-8?B?SVlCZFhYVHp0bmZ2T3lSelVraVdGMmZ1aWJqeE4xR1EzUTlBTXNnUE1wZ0ln?=
 =?utf-8?B?N0JiRHFJODA4bjBWZE5pN2lSOWlmZE41WUF2NnZjZnlOQzdZS2RValkzSmsw?=
 =?utf-8?B?TXFoZy9oanZnYk51d0oxQUZXeWtER2srYVhkc2lyMWNJckg3MXcwbGxwTnNM?=
 =?utf-8?B?UlQ3UWdxUHRYMWExQXYrNEhTZjdmOHJNSDhmelNVOWtpZEZ3STQxZDhiUi9X?=
 =?utf-8?B?WmtpYlc4TXFENlpSTEJtdVFhRitYdEJqcWYyejAxRUZJNW40NlM2TkZXb0hD?=
 =?utf-8?B?WUpTckwxRzUvSnVjQndYTWo5NHM5TGNVbm1McXBjc3BCL1RYNFBwdHFPNnBO?=
 =?utf-8?B?R3VkaTRtTWFKZnBWRUlGYXBycWs1dFlrcDhIN2tmekpDa21ZM3NGRERJalR1?=
 =?utf-8?B?UjFZdCt4S0tnbDMyS0FHVVhKeVVHOGtNWkg5Y2g1a0VoQ1Z0amRmK0t3c0o2?=
 =?utf-8?B?V2ptbW5UdkVSeGxWVkQzTGR6MDVoelR2ZStVNjBha0w3emljaGJ5L0owWnlB?=
 =?utf-8?B?VXl3RVVpK0xqQ29WN0ZwaGlmMUFKci84UEZkWFcydlhXMkRMWjV0czEySzc1?=
 =?utf-8?B?ZUsrdnBSZHBJZDdCaDVPQi8zeks3cTNZM2FXKy9ZdlRtNWJLWnRmdkIwdmlH?=
 =?utf-8?B?VEZJNnY0bC92eG5RWHNEa0l0TGJuMjhkbW4xT2lnVmZ4WVBlUFpIancramE3?=
 =?utf-8?B?aU5RYkRPRkpsaklWNGFkSEFkNjBiYnl4b0VHaGNRN0lZeXBBY3ZRY3V4clhJ?=
 =?utf-8?B?MDhRZVdlZXFJenAzdTNLQjVubEdxdjUzY1VDdGEwL240R0FXTGYwcnA1bEQy?=
 =?utf-8?B?Z0sxZWl0VjNUY21TcEJzUTFycHhsamNTMndnZXlxY3pBMFZoYXNPTk1LQ3NQ?=
 =?utf-8?B?WGZ1dStkdUxnRHBzVHNickcrZSs2a3Z6K2dDa3dvek5Ud21GMk5pTVVKWnlu?=
 =?utf-8?B?S2FYb0JIY2RFYTJYQ1VKZkRhcnJ4SFBjUDhaN2QyS2JOVnJNNFZMcVlNRlBV?=
 =?utf-8?B?M241aUJuMXZ1eWd3eXZMZDZ0ZStSQVp3dWhaVENDUmJEUXJweDlVbVBrQ0ly?=
 =?utf-8?B?K3B0VlVQc1VIbUE2Y0tTSkN4R3JjNUlSVkQrbFFvdVBWais3Y3NNWGtjNmRs?=
 =?utf-8?Q?Sr1OCMYPusIEn0oJQ0Y6h3JMf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 194f2aeb-6539-47ad-16c5-08db735dadf0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:17:19.1815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8r690u2jfhrxOQBaRBr3NfwHhOhcT5lrjKzdZYtku0fRrzFgtiExrpV2QH/MtbOin2ZjFpsFtQzSKS4RByL/LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6417
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/22/2023 8:10 AM, Arnd Bergmann wrote:
> Applied to the asm-generic tree, thanks!
> 

Great, thanks for the quick response.

While going through the comments, I was wondering if we have a
definition of what constitutes a deprecated syscall vs an obsolete one?

For deprecated we have some information saying:
> /*
>  * Deprecated system calls which are still defined in
>  * include/uapi/asm-generic/unistd.h and wanted by >= 1 arch
>  */

But, I couldn't find anything for obsolete system calls.

Sohil
