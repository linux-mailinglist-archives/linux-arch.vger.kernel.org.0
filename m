Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753A47A690C
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 18:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjISQhs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 12:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjISQhr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 12:37:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007EFD6;
        Tue, 19 Sep 2023 09:37:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Byw+xTTD1fQDPMzb83cx1XyCiuAAPJ2/9cfhjimUqjfApK+T6viMzvpUb9v40jGF2V4br8R3ajb6As25K7/dTB9Z0tRjWmmjKXS75K2AKx5AIbdDNfOn9GT1skDGawO+eMB3u8ARIodWHyrCQrh6vs9f0KdWJlHTzlYusa7KsZgFWs0YCW+mocrJqS2A98gj9YQCffSnS+BHXVfMDpwCPkgA0/qIosvzqhi/G3Dave3fFkJNDGll0iBcB7f09zBCtf0TEUUjGU7BfHEmFsHIgLQM027HAdRWqvokqhWQBRI6bMOO+HAu4hnjQj8yZNmVpoOLjQmS1Nk/avqqCmL7og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxw5CHuE1f8kyY2OQsryIBnjTaxpPJzuY7/6oWRamPU=;
 b=gvllguju0ONPPQsHlg6291kWDnibWGqUP86+wd/AClQ+3mxOHtbpSX/KWE3iZzUU/q7l+8sT09vxtCyJoYWTSDFN7YIdH4SOfh4mGDnlCA/1af1QY/gSf+E+s5hbIEo3IQsrQojhNHvB4Jitcb1rwxSB9n/nYVGQy8KqZd/h0lTq1i9yGO42+LFLA/S0oEx+eSj9SQvCtxbpZKdRecTaqIDNs9Zmc7tT9wmFhQxjXkLPVvgH2SemH6W8GOTCfaVwlxCcL5UhmG8MjkPl885FV4nHtrs0NCL/Om7FwiA2gqP0p2CYBI4m1DjPPjMhLi8gBG7whzPPNO8xtDRqEReeYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxw5CHuE1f8kyY2OQsryIBnjTaxpPJzuY7/6oWRamPU=;
 b=O+bEdwwhWVe8ZciHxy22UEx5EBF9UfS1z2nLdMiGTmlefqXjol1lt53XHUMX/Dm0SHdIkBhOSjr/IX5cFXaXlvPTLyQ2IZy8NEw8tDKl/qTNG0oxaDI4qKjCZRGAkdjNji7vwFsGZ2nNx0KYuKEwgl1ssb/747KGsgP69BbmVyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW4PR17MB4857.namprd17.prod.outlook.com (2603:10b6:303:10a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 16:37:39 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::f4e8:df0d:9be8:88cc]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::f4e8:df0d:9be8:88cc%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 16:37:39 +0000
Date:   Tue, 19 Sep 2023 12:37:35 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-cxl@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org
Subject: Re: [RFC PATCH 3/3] mm/migrate: Create move_phys_pages syscall
Message-ID: <ZQnOTzm6l8RSQquH@memverge.com>
References: <20230907075453.350554-1-gregory.price@memverge.com>
 <20230907075453.350554-4-gregory.price@memverge.com>
 <877conxbhw.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877conxbhw.ffs@tglx>
X-ClientProxiedBy: SJ0PR13CA0208.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::33) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW4PR17MB4857:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bfd29df-0e95-4196-6065-08dbb92ebd05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gRO0wjhP8JTlhCRyB9suf0KWttUG/NN3PP1dPn8xpb6QWKWEXRQ9dap9unVYbJ6D3LA/txAHn4kZsJ6/3i4HitCeEVK2MLGTkAABX1WnOlS5Uc89zSXp5IKin4FVa+k9T8mUXjNqfLqW7jW9RimDP8gO5E26Sl4bIK0rekW5W1Ou5yOhvZM5JuhkFK2bWxstyLeglMBOai+hWIIbH24/stPRoHD/QpQxmkUHrzptr9wbI6Q3pzYeiGtSWGy1vIC8gSriH4qDLA16x0dcZ7Eh5nPtsIkM/OZWEwijJ25Vw03TTYU/AVwa3fG4Od7mvPvIrHGbqzXM+JNIe3+wvUvEQd5NNCj0bIze3ZbCXjo+uqwuu+3o+7B4P+kC3xKwSkL2ulkUj9aATlCXf14w2kvBPg4n+9veXxaPNg76ltZy1sJCUrVH34O4Z+9DKKPJhP0pulsKwLXDzqbGaMyS++cZ1Ebd+L4fqlri1dWG6Xb9DQeSXtjJoLE2GXUoW50kBDBwf9+gbFfyFDSDcjcN1ZXotCVCQieBP7gT2iwuU+qTctYPd973iwvnI6cjfAQ008iE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39840400004)(451199024)(186009)(1800799009)(41300700001)(8936002)(2616005)(8676002)(4326008)(38100700002)(66946007)(66556008)(66476007)(6916009)(316002)(6512007)(478600001)(44832011)(5660300002)(26005)(6486002)(6506007)(6666004)(2906002)(7416002)(86362001)(4744005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mXBKVqyrk0gbNnQNNLzmL8uesIyqHeRvK/ypXjWsAUX1N6UCh9/LpAvhPbh5?=
 =?us-ascii?Q?rNI032rq7XWJ015crWya3TNxunqzBRkJHV6mhSQoaONveSCgHG42w4VwxgHk?=
 =?us-ascii?Q?RF+tbUv932VCmY7dF1NnDwjUTCfdlOUzXFdW6Z4hFaWFKYTDMJxjD+gjABv7?=
 =?us-ascii?Q?vKEEC4LJG2a+9qpp7i2kCJyVCS6zk5mjJrDy1TzwG6V5QXz/kuLj3C0YNuQ1?=
 =?us-ascii?Q?TomPK1+oxnJadwTa1GXiWEJx0b43CLmgm4prMFItz6qm+d0sPaeOqy/9cMJY?=
 =?us-ascii?Q?snxJpb23MzinaRUOqEQZkGKhYW2p06CflBVHFcLxzReVraSlp1LF+rDcjD2k?=
 =?us-ascii?Q?DPfFF1WbTRGwghcja2HX4YijoJI99zP+U2TJLGPSCkwFfTB4juPzycEkZWrs?=
 =?us-ascii?Q?rYh98tssu2i3lGwI30OISbHWScOdedDEciqgLU7R3TQnhrOfHxi6vFaSGK0X?=
 =?us-ascii?Q?VgvbUjPwAAiw5O3K6SStRbAa4W4iqCLs/eIR76m9R3jk4djKPr4iNgg0l4ro?=
 =?us-ascii?Q?YCAqmUfHij1z25ZSgpGM6JFMAau1U9HsZEEm5+zlz5SWVxSqNuOF1LTcr64b?=
 =?us-ascii?Q?43szTRlb/YWaik7j/aguycHj041wPR/gBwgagUjNjKojyo1xOYvfpxgB/v2M?=
 =?us-ascii?Q?EKjNljISoMKDVlVeT3zZGhE0zpk8qYPOnGW5rRTYhXe57feyHAU7AMorIX9I?=
 =?us-ascii?Q?F6WUkSiFl3VVk7+TY5RI/5uCamTawEy7ZNXWMgSkbwPc8FT/4sf716yaa/Eq?=
 =?us-ascii?Q?UmZjiU5pZiMUAAQEG7KTrV9cxJoi5KrOQhPD/9T0AE9FgdiWsg/dnkETh9Z7?=
 =?us-ascii?Q?SQ4/Fntzh5XuV8SYdKCfhKB6yoKInhG6QovXxbU9ALLHc1jibILm8Ul/U7RT?=
 =?us-ascii?Q?sKSh1KG+w7XL91cflZ8lR4rKEA0nIDjUuV4j1HmBiF6SeJHBKHcX7FdCzKvK?=
 =?us-ascii?Q?RBfPLiopx485JrDN8ThQ2MoDx0PhSd4fQ2n0In8fOJ3P/zB17hyNJGwCX5ti?=
 =?us-ascii?Q?zdhjlNUAX/1ST+9ujoiqyLzn9Uk2vl5+dTQAKl7GMSZOEF8fHZkYaSPuafVP?=
 =?us-ascii?Q?TEZODal9GNtKSgsc8fcVymDKN6fkCYK3/plVkXElgr3jGaEk929Z0bKOz1pZ?=
 =?us-ascii?Q?UScabAAx8rv6POLI7aidJt7kea8H8GzBl5pz+GHPMCz9hQe2+aI1TMNrJA0b?=
 =?us-ascii?Q?kD02GNlJ6tVfMiymN0uMkLXPzFxiPQG/tY3i3nfinV1qteyRsYk0qgzxqW07?=
 =?us-ascii?Q?LMr88N2G/70sa7zFRvaJ5ZpTf2HY9QF0K5hEtlLYCqzDdbqzcveIOdaAdch7?=
 =?us-ascii?Q?lknOoxY0coyvgcErVw/548rz52WC1QGHnsG2akj+hUMr27uCXxRwx7L9Nof5?=
 =?us-ascii?Q?o5DVZdeV+PfCCmhBeSLd8cML1CkmaEDFNrWjLJlXKNwezu8d5vA05TAknVqi?=
 =?us-ascii?Q?AUAH42G3UsbioF1h5D+jGQagYBWxWeexT+qkZkzQMqj6QgS0ypNe0eUefJkZ?=
 =?us-ascii?Q?/9AMLuA56NWy0FB/6VAktTY4X9uwVg4EXSsfCZ0+D70F5ZMugyRJPJuwL4G3?=
 =?us-ascii?Q?abvk4PMeLm6MNHbzzLlz3L6vODTin5TFPbSydxBcWkN0oJ1AOfI36I2zZ1/E?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfd29df-0e95-4196-6065-08dbb92ebd05
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 16:37:39.5119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFntczb89G0snSJ0KqRxTdBWtvd9i7geGV/ihVR2NnHMy2kMKfW7VcK+Zf7wLqpZf6FHjWDmf9a2EktJBea9a/un0GhMxAZC3d7BdMabcqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4857
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 19, 2023 at 02:17:15AM +0200, Thomas Gleixner wrote:
> On Thu, Sep 07 2023 at 03:54, Gregory Price wrote:
> > +	/* All tasks mapping each page is checked in phys_page_migratable */
> > +	nodes_setall(target_nodes);
> 
> How is the comment related to nodes_setall() and why is nodes_setall()
> unconditional when target_nodes is only used in the @nodes != NULL case?
> 

Short follow up, sorry for the spam.  I realized there is a better way
to do this by simply bypassing the task node check in do_pages_moves if
the mm_struct is NULL.  This removes the need for this struct
all-together.

Will simplify down for a v2 and add comments to do_pages_move
accordingly.

~Gregory
