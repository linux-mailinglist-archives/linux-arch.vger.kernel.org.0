Return-Path: <linux-arch+bounces-455-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A01BE7F8514
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 21:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60F01C22DE4
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 20:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9C43BB20;
	Fri, 24 Nov 2023 20:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="GdlzfkCS"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2303D41;
	Fri, 24 Nov 2023 12:09:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9Kai5ty4bEwa1Wx9Gh+W6KSJUxSg1v9Zhl1sBE9UFePCaU367EXwwa9ZkhToBRjvjiUNWKOSKRa/S7C1/m979RWQpQaIAOhT2A8wdVR/s4HJ8uiD1/63P0MQa8018nF7y1JZs/Hy0gLg/ZsvZ/z8sG5xrabqYIeQUR/QT+2v8GEE2BqxNcN6/B2bu5ZNEAF2FEyJZv2Au2BOUObWKifD5KkR0i8WUPP/x9N0Yhpg/mM+Rd4CfjdPssKlHl8zxq/kC4IckNQCTghmjhO4BO3fZlc94Xroze0sLtw/1KJsxdbjR1h/HmQwiEfyrrv1E9nP/cwri/KNJyEMLWk2yBBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BtI0TpVkzYXF2pMkcuqVzyty6IMkzzIOovbyYxJHek=;
 b=kqIuXJOMr8XjyL7R5Keibljwe3QN0YsOxj1tcRklX52EW1zIkuGbqn/02hTxSqDNj5wThUcMnK3omZCllOuU75GrarsPTiBmCBred4O46nXslqzLwMb9brRnqyBLy/8Uu04OanZ5xYCQfOCivrOE4gzX4jjBFt/e9iI+YMemfSmXqh3Pv/rUNjhlk/NuMk9FGr4ioXJAky3IhuJh8wurI8mN1N9bxAk25DbstnzOZJOcobeotBUuFudM1+dlaAp/a/mYu2fwHmkUFHhVyBRLIcxYSUvAjb0Fg5d15YBZf8hmW5g0fOsKOQcNAKT2tDNC4Xk//O4HSMa5eIHVNtoq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BtI0TpVkzYXF2pMkcuqVzyty6IMkzzIOovbyYxJHek=;
 b=GdlzfkCSNqn4VmQCHg39tWGQuKehiznxQ3EUSPXpEeT1KbjXK1l9sPhf4kSWGTPn1BKxsFg5yFSDiSzaJAGwC5X5FejUxedXRdObbLfBaFMwNthEgJk9xOuzR1FITGMPNvVnXH4mzhJrT33krAephs/3m4sdJ0y7YoIzDMeH+a4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW4PR17MB4275.namprd17.prod.outlook.com (2603:10b6:303:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.14; Fri, 24 Nov
 2023 20:09:27 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7046.012; Fri, 24 Nov 2023
 20:09:26 +0000
Date: Thu, 23 Nov 2023 16:42:32 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Vinicius Petrucci <vpetrucci@gmail.com>, akpm@linux-foundation.org,
	linux-mm@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-api@vger.kernel.org, minchan@kernel.org,
	dave.hansen@linux.intel.com, x86@kernel.org,
	Jonathan.Cameron@huawei.com, aneesh.kumar@linux.ibm.com,
	ying.huang@intel.com, dan.j.williams@intel.com, fvdl@google.com,
	surenb@google.com, rientjes@google.com, hannes@cmpxchg.org,
	mhocko@suse.com, Hasan.Maruf@amd.com, jgroves@micron.com,
	ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, vtavarespetr@micron.com
Subject: Re: [RFC PATCH] mm/mbind: Introduce process_mbind() syscall for
 external memory binding
Message-ID: <ZV/HSFMmv3xwkNPL@memverge.com>
References: <ZV5zGROLefrsEcHJ@r13-u19.micron.com>
 <CACSyD1OFjROw26+2ojG37eDBParVg721x1HCROMiF2pW2aHj8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSyD1OFjROw26+2ojG37eDBParVg721x1HCROMiF2pW2aHj8A@mail.gmail.com>
X-ClientProxiedBy: BYAPR07CA0097.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::38) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW4PR17MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d933315-8f19-4ee8-a74f-08dbed294245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y6jumfXB7ypYkTt8Xc6tszyAquRGYPBRPTg+HxNiFROFC2YVWHhdO7lufaUFeCuW+Z8EI43b+XCNtvNH0jj2hw7vrK/ix/o58j5ORGjm5GoFO/cva0MXipx7XVFrW1FnRPR0QvPd0nZr4Xoo72bR7XrsKnlj0/IgnQzEV4gXeQE+n2Gu4DdSGwYczb7QFDBOt8a5TesoHUJB4ge2kS8nph+11jKkz0xEbU4Hrn8hsWT8Mj2nsfPWOaFZMiu+FRu9z6s8oio7T04ZGtSmfHaU5IK093VaQz0f0/52ebx6OqxzDlRL6l1DA/r2GJ97azx1LzCNJaYTg/aiRgo1qEeCdg0cK++CwfBeGaCUZe6Yk8rD6FBp4SICIwJgz+G0iYVnckqQqR5CyKwHHW3sQ9Y/CFCXPQY5mlSIGwmh6c2CYweE0MUZtCcVvpVhDwcWwzWW77fI7dTxbcbqyktJ2Ho19lnghvAEKTnUN+JtGVA/ZMe2P2hkNMm7mI+E1R+wfQXbKiY096pAZAaYp9LP6S4nlYfNEQo0gJbbnyj6pKRJCG3I3/LxuQrAK40/hkyzcOpn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(376002)(39840400004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(83380400001)(26005)(66556008)(66476007)(66946007)(38100700002)(2906002)(7416002)(4744005)(6916009)(316002)(8936002)(8676002)(4326008)(5660300002)(44832011)(6486002)(478600001)(66899024)(36756003)(2616005)(41300700001)(6512007)(6666004)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWR6ZC93T1ltN2ZheVZkenNXNlQwNXZSNDRWN2xGMm9IUHdSWVBKTXZCcnph?=
 =?utf-8?B?TDV2VzR0ZGJaZlF2OE15Z2hTdlovZnhsREpaUE80dWVWMWRnV0dGT0QwdnRj?=
 =?utf-8?B?am90ZHFtRDU2TWcvK1Q4amxLeHdjaFlFQzRybFZFclBrMjVPZGVvblcwR2xq?=
 =?utf-8?B?eHR1L1FmckFXN2krdGVWRkVpVERpUXRxYklWZFk0bWYxWGJwMmJRZlBWWHp1?=
 =?utf-8?B?UGxKL0g1TnFTNUVNVE41MVRkaVF0VVQwaU1NTU9UUE8vNDgzMGowaE40UnFL?=
 =?utf-8?B?VWJlSHJ5MkxHZmF4NzFrS1hTcytNclFlbFI3UWhZV2dVd0RuRnVrSkJoRS9v?=
 =?utf-8?B?cHh4NTJrREE1UE80WlMyT2tSM2xTSWR6R2dXZkJINURJUCsvaXd6RkpiZEFS?=
 =?utf-8?B?YUE2TTNTS1ZrY1dSeVJ5YWd2YmluaVFhaDFYcWZnemd2Z3ptM3NnNHU1bW05?=
 =?utf-8?B?QkpDZGh4UFZGUVROWXRVd3pjNy9nUXNLazhzTkV0c21paTVUK2FiRlZhNXVX?=
 =?utf-8?B?VjJHQXJwemlSTGx6WmUrSDU1Mm1nTEtsVmxxMmJ4K1FvUERTRFRRMDFrbnlE?=
 =?utf-8?B?K3FoZUpQNWNQU2hnQk0zTlJJV0RuSTFYa080NmVWeDcvZUttb2l3MHJoOEJO?=
 =?utf-8?B?eTRVbEhGU3E5cGwxaWZGVUJYZmphMkRtdjZuWS9OVTA2aWpuWlJ6OUhxVkph?=
 =?utf-8?B?bXoyVEtsTjNJVEFjdWpaY0Z5S0l2U2RzRmFIaXkydG54c213NkFWWlRBTitN?=
 =?utf-8?B?K2FLSjdQMDlJQjREUlB5TlB4OTVidjcvUWFnNndOZVgyWVNwVTFpY05RN2Y1?=
 =?utf-8?B?Z01qcVBaclkyOUxZc25CNExYSGF0WDlxK1BQOXNDWjF5Rm5xQkNDRHQ0T1l2?=
 =?utf-8?B?RkRMUGVVbjJxYVNqeXJ0SCtkRmxyakRicjRrTWJ4K0tnNytRb0ZsRDdiVzI4?=
 =?utf-8?B?ZExiMk16bk5HVXdBMFB2cFhYTUJEc1NaVDV5OHIvdUd0MjROT1R5WEg0TElK?=
 =?utf-8?B?cUhPYngwVkpOaVBqS2RVc1NxODFyVmNJYktkM2dJTWNrMWRBV1ZyU2hPNjh0?=
 =?utf-8?B?OEcwOTRLUExHMW1KaUJJV1ZrN3NDZ2pVY0tjSHBiYzFrWmlER1Ixb0xWSGZN?=
 =?utf-8?B?RS9Nc0htVkNHcTNXSUN5RzJ5WEZQRm5VUTk1MXFVSCtzczl0QUVFZ3lXTWtm?=
 =?utf-8?B?NUtUakZMUzVKVkk4NVdhcGo1YlA4d3d4OXBHODJwMm1NeDBRNkM0WWNwTXph?=
 =?utf-8?B?YkhUWnRVTHkyWWU5aDVBK1ZzVkkzZjUyTmF0c25JYWhaN2hXUkt5Qzh2OEht?=
 =?utf-8?B?a2RTdjJiZlhXL2IwdzBJL3RibEpUWEtWT0dFVlNLTWlDQkQyYjFmZzRpSUhM?=
 =?utf-8?B?bGZaZmRob0xpREVCZmxMTGQ4MGhtWTVpZkp4ZjFzV04xL2tjelZlV3RHZ1Zz?=
 =?utf-8?B?OVJCbWk2elgxNEc1YUZ0cTBTOFJZenlGVjRnd0RDT0ZLcXVUc1JzMlprdXN6?=
 =?utf-8?B?bEU5S3dldHNLK3dwcTE3dHd2NTZGc0VVSmZmSWE5UjA0N1ZpeDFWaThEeUt1?=
 =?utf-8?B?OUloODlOVE16UnA2TTdpajlDeHBQcmNGWnRNS1ZZYnZreG4vUGt6OHB3R1Ex?=
 =?utf-8?B?SzVtcGFRdjZKem8zZWFycEZHV2VqK1FpdTFTK1YrTDlRMUFNbTNFZzQ1bWdT?=
 =?utf-8?B?RHlTaEcwdnpxeE9yZnV2aU5hUGNFSDZCa2dmSStCMDhUVGNGTkVFcHprai85?=
 =?utf-8?B?d0hScGtQMmZEVUdsa0VZRnM3M0tncVZVSm1yYnhmdURkVmw2ZFJZUHVTWHZQ?=
 =?utf-8?B?TDMxV0IrbnA0YUcwV05kbmtZYjYvYmllMGgrbmV0Q3AyRzltREg3ajdHTjJI?=
 =?utf-8?B?M0h4S3JzeWtJZ0MrMFMxVmxBZnA0VXFJaGtTL3VZbzhxNkJnU2FHR2gzUXBI?=
 =?utf-8?B?LzJoUGZxWnlxeGZlMFIvUFh4NVJpSmgyNEZxekRmeCs4aWJsc29aQ2RxZGpl?=
 =?utf-8?B?bTJVZlpYV0dWdUlsUVB4NFdMSERLeWJGSGtxVW5XNHNPMjE0OTUranVZaFNk?=
 =?utf-8?B?ZTlVZ1lramMxVmQ1R2VCNkJZNUNpNno1WGJ1a29zS2ZqbnFRNTAyL2daODlv?=
 =?utf-8?B?Qi9KMkFhdDEyUEw1T2cwTXdYL3o0KytqYW1PMGM0VG1md2dFUUlKTkFDN1Bt?=
 =?utf-8?B?L0E9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d933315-8f19-4ee8-a74f-08dbed294245
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 20:09:26.5672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTm1IpVKJ+T0B1fNeGvqvhF2V/c2gJfirj0rIfVbueRWTmiVGMBeKaPFIUXfTfOhy/AIys6eMnIuzSG0dV5GZV6tJsbSqgW0gJQjZ/a3gBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4275

On Fri, Nov 24, 2023 at 04:13:41PM +0800, Zhongkun He wrote:
> 
> Per my understanding,  the process_mbind() is implementable without
> many difficult challenges，
> since it is always protected by mm->mmap_lock. But task mempolicy does
> not acquire any lock
> in alloc_pages().

per-vma policies are protected by the mmap lock, while the task
mempolicy is protected by the task lock on replacement, and
task->mems_allowed (protected by task_lock).

There is an update in my refactor tickets that enforces the acquisition
of task_lock on mpol_set_nodemask, which prevents the need for
alloc_pages to do anything else.  That's not present in this patch.

Basically mems_allowed deals with the majority of situations, and
mmap_lock deals with per-vma mempolicy changes and migrations.

~Gregory

