Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A194469D4F3
	for <lists+linux-arch@lfdr.de>; Mon, 20 Feb 2023 21:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjBTUYe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Feb 2023 15:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjBTUYb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2023 15:24:31 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B732005A;
        Mon, 20 Feb 2023 12:24:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFwkzyqDJwSs+SniBWksmymVjih8ijaCUgqzX2wFOgwrzbmMLqXqiSKLV1VwVKiDco3g+DKDoXYk3rTLaz0OkJBlbLK+KAsx9IFPS85X7C6GajV3msghajOyiulEsN9GLHbO43xAWlFVP96rr2nG89ID8n+JuIsoKMmUoXkFVdZZ95eLU3WX2ZPEprvtNshnBrJZeLqWTveKAXqykhK13Ljp/VES42SlkXkhY/K05lQY4c6Vl4ukgrtusTwuABPEUYlYxBIR9iy/+F8p4yfd2PjhYKJVu05xWWAqBMqsgahIkG47YB+1rsvkTDNLB64KFF7tBGT3dQP8bIHeNep/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSarqJTVS/+y9QRSYpb2Ud58dGIJVpE1p861D3UckX8=;
 b=LQ6dzScpmEMAUIbOcSzG9ccQjbQuLU4RcRMxt4Ii7T93BexcKzk9u+0dUbzOROx5fdqdIikdMagKcLz48Q9QBq7LG3LgD3SNU+N+rxoxblAejzfN+46Ic0QceRceD/1eEeK5Bz94OuD8xLXeq7I1u+Do42fZpj4q8UUDbPle8RIYb+ZP2s/LEaQpPrppJp6hER3v3ae8q303TsZOiWA5RTAwa3hqFcLP4NeAmoqDz5KTpM7zUXJvGaFK7VLXRPNlT4zYkMA/VOEnMOe/LZ/BuTEHWa8EQw9ag62LrnoQdTJ/Dhp/VYCGRivltxupXIzxgwqsU5gluzZo6dltmgvSvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSarqJTVS/+y9QRSYpb2Ud58dGIJVpE1p861D3UckX8=;
 b=uJlVyWDAcPS3yEwzOuffNRRTfqwjsnvY+YCZKnajKp+1lr11it6iKfjs+N9hzfzzWNvzceLib1kLncP/ry5edmJLoZ+1IXCvEAGlOR9yu8TpQkjPSFdpTRjAQq5PotJnnYm8OO6MoKmsGDMHF5WwFfWn5HNCXN9D5D28TNTufxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 20:22:50 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::de95:3582:8274:ff60]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::de95:3582:8274:ff60%2]) with mapi id 15.20.6111.020; Mon, 20 Feb 2023
 20:22:50 +0000
Date:   Mon, 20 Feb 2023 14:22:36 -0600
From:   John Allen <john.allen@amd.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        akpm@linux-foundation.org, Andrew.Cooper3@citrix.com,
        christina.schimpe@intel.com, david@redhat.com, debug@rivosinc.com
Subject: Re: [PATCH v6 00/41] Shadow stacks for userspace
Message-ID: <Y/PWjCAxKcahq98B@johallen-workstation>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: YT3PR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::26) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: d39b6967-481f-4a29-6be1-08db13803cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAXGmPAOo/wKEDOC9b/4rj6lF5I7xRiE6kkhnTqSze23Z9Pj8W9aQIZE0eSD5LG1XAyFN7y4Q1Km3JGcardeENL26UaKxfmChoY/gmIURtEz6SFDC5A7azpfacrL6jqE9LrxnbH2MXcojw3woZtvC0jPA22d/hBUslgQZ0c+Rd7KEaZ/94oufLt+axOgTY1N5X8ASeUO8dwXY9G/CxKhsQFQvhv4WI5vrQfICt0pQ3kf1MKMZOp++ocw3PJ/3lkdEoKv5pSxHezCjjM5A39Ws4hk5q6xMQqHzJXay15c8V8xCgD22T8R6Kgy5T62ER+KeXz24h5br+ah/h+58rRJrhs4fS3t7BHJnJqIMqhBqkOoptgkrKrTvUFKuKNdJl4kSKTCRO7fAvUTJmVxA2flqo9qqOzlGtZ/DMW2bPtfnKW8lFMIaD/icFvxqRaV6/F1SkVVtqoZso0EcIuiy2yKt9nfjcP2OHGHybPMvJgP6ISu1xHNzqR4sn0x0r2A/h41JOsNT+WemkvVNRaK8HGEAtWWGeY57bcYPtuPdgcVZd1COScq2O5wt+dVkZLdrkC7f9abITDUlu19iwuCfC0VroIGeWiI0d9e2On+aArUUunyD6HhJQgcuZD6H4hNJNio
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199018)(8936002)(966005)(478600001)(2906002)(7416002)(5660300002)(7406005)(44832011)(6486002)(6916009)(66476007)(66946007)(8676002)(4326008)(54906003)(316002)(66556008)(6666004)(83380400001)(26005)(186003)(6512007)(86362001)(9686003)(6506007)(41300700001)(38100700002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WtO3ZG/aw9tze9o+on2vmGykZ3t8y7XechOrWDOxCih1b79Ds0UrtfXMpTRU?=
 =?us-ascii?Q?cQimVAUiae2Z7wW3aoJRFJOIKqpKT2jpCqBWuS/DznJE1B0IbxUe1dZjBIWK?=
 =?us-ascii?Q?FJuqiMw6Y4Q6WFECdRUlJq2VsIkKp3+uT32uedD2hBGQ8u2mnIJP/ozTEX/W?=
 =?us-ascii?Q?a9SwHniMD6a5bZqqxRRNdklVBL5dTJh+TRpFR6EO4Yc8HKOxefhIdauWUgq7?=
 =?us-ascii?Q?U0c1mt6+vBhyZZMDGhY6Ji21AV2y8Ijg4IHOmdZLLxlNXXILngIMfd6WEK2e?=
 =?us-ascii?Q?obyTlaqtVGEf+OB8MsehHg+SkKdw8/OffGZnorOtCYb7WHzrj0AODdHTlr/b?=
 =?us-ascii?Q?mLWhDy7bokwgska0Rc2th8e4R+a7D7C58o+N8LCGURiJlZbi05pB6U1TjrZH?=
 =?us-ascii?Q?afG2Y6tjHREQeD6x0Zos9rQLgEwWWM1ZjukKoM2asjo0kFVIUcYDyRtjWK3Q?=
 =?us-ascii?Q?0MLzGcH/99UuTi/k5q3MUpGb964yvop930dNWMVPZo9Xc3OgnAgCW/dAJmxn?=
 =?us-ascii?Q?9G29NkLP1E8T9l43MOqL+RmNGW96kYC0JWSS5i2gO+8+olDKrO9CAa3xN8+G?=
 =?us-ascii?Q?5LGYUSbR/gemsgRj+EcFG1+4fWRLtyXtQFp4jElZRfe5sNCyQM0v1YvHw52/?=
 =?us-ascii?Q?5RiBRpBk9ZiyCNplVrEk0vG+B+AJ1+eKvmYMcwf3HXGMArhFgg+jXQRBB6oA?=
 =?us-ascii?Q?tOb56fNJt1ilyGZN1PoFyec9PEDcMD1/RrAxQIYyoW/WXGVow+vfD66sF7E0?=
 =?us-ascii?Q?egEWftDkHVoHZacoET00DCtJMIFW4FoF47FIBkWHQyIl3L9447Rc4ZtbWh79?=
 =?us-ascii?Q?xNnOrzstiX+CX4eaV5p/aw7NbzmaIw1oC8gk5Ruq+HidRk6a4P0VzjNJxI6x?=
 =?us-ascii?Q?fvs7/f2Ft5mmQmJpF+h4gZpAoAIXemVJOoGwTA0XDyNIURBd4AgXE4b8WhGN?=
 =?us-ascii?Q?yVLX18WawL8FxiYQ5ktcI117Xjdp+gFDDjMttgyefnfOwX4MrfC+Plpc/5uR?=
 =?us-ascii?Q?2klHD5yCI6ewuySYL1J0Jc5E8VRF/tXtVTVgPIsYMlwU/Wz+h3NsMHFIncwp?=
 =?us-ascii?Q?67J+hYKeRFS7Ha0ITVDOjusBtVYZLa3s3KB8laGoR+vuKCiX66TcGBCwxkcs?=
 =?us-ascii?Q?XjGHCeg3UdRsiMKB0ooBm4qWoudDvT5hsX07HVbS9uhKzrQ9F3fT51MiD5jJ?=
 =?us-ascii?Q?4gbFyWXZY9LnfYmuZcbzAjfI7Q9k508AHii0qNKf5IP/J8CkjjmvweeXxnCr?=
 =?us-ascii?Q?gOiX9K59XmDdTVHouPPRJvJ5G8moZoBIZa8ZkAQwbV+nWs21ZlsmG+g8NGKc?=
 =?us-ascii?Q?sEIVB82SMchrtREEGGl7j5vDVW3XWH1k/A2ZiDeRt5ICjVjA5Sp7rT8m5xp6?=
 =?us-ascii?Q?Cf9N6VN5OjDX3apU+gAW2TI2ab3mf5gsC93tTx5WDF7fN+uo5l28DFLxNr/P?=
 =?us-ascii?Q?z9231pKKSO7cZ5hXCNu47OLaDkRE8ttgFMhp2E8bN0/bsmBOOQOPH67hoF0w?=
 =?us-ascii?Q?+ZWryv7QO+AuLezewZ89SBiS5kTewkPN03jWaO/YOXDg54BgfVQgOApcsHDR?=
 =?us-ascii?Q?JaUjI0+jrMUf2X8Xk4PzQBll0yPp6phxJDCbS5E3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39b6967-481f-4a29-6be1-08db13803cc0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 20:22:50.1086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40oL4zPkGHpjXKldGC/2oEFCMZCpGMxDk4bHeDwNUVpDjdXnh1u+hIuztGYeAbhVooqRppegKDUzJZNxZ6cr3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 18, 2023 at 01:13:52PM -0800, Rick Edgecombe wrote:
> I left tested-by tags in place per discussion with testers. Testers, please
> retest.

v6 is still working well on my AMD system (Dell PowerEdge
R6515 w/ EPYC 7713).

The selftests run cleanly:

[INFO]  new_ssp = 7f53069ffff8, *new_ssp = 7f5306a00001
[INFO]  changing ssp from 7f53071ffff0 to 7f53069ffff8
[INFO]  ssp is now 7f5306a00000
[OK]    Shadow stack pivot
[OK]    Shadow stack faults
[INFO]  Corrupting shadow stack
[INFO]  Generated shadow stack violation successfully
[OK]    Shadow stack violation test
[INFO]  Gup read -> shstk access success
[INFO]  Gup write -> shstk access success
[INFO]  Violation from normal write
[INFO]  Gup read -> write access success
[INFO]  Violation from normal write
[INFO]  Gup write -> write access success
[INFO]  Cow gup write -> write access success
[OK]    Shadow gup test
[INFO]  Violation from shstk access
[OK]    mprotect() test
[OK]    Userfaultfd test
[OK]    32 bit test

And I can see the control protection messages in dmesg when
running the shstk violation test from here:
https://gitlab.com/cet-software/cet-smoke-test

ld-linux-x86-64[51598] control protection ip:401139 sp:7ffd68b1b7c8 ssp:7fb433578fd8 error:1(near ret) in shstk1[401000+1000]

Tested-by: John Allen <john.allen@amd.com>
