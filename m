Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C34A3D15FB
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jul 2021 20:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbhGURem (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jul 2021 13:34:42 -0400
Received: from mail-co1nam11on2055.outbound.protection.outlook.com ([40.107.220.55]:32737
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237490AbhGURem (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Jul 2021 13:34:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBO1WzwjsLqcb9gEm4QKdQv6YBus625hs78bSgUzrbNCskBIN7nw9PHjKdQVo7Jzfo9E/Ae3YtOzCPYGbc8Veb3xlz48GVLWdKL6s4dpCy7uBtjxhl6LIARe0D6/sQqJQscJmBfzrDmHkwi1ocmfLdg37U/rJcECP4GiDpmfDWZRKV3KsUDfczRBIk0fqwkMibrHwOYJh8sURcBd9QFyUJPLB6sol5K/DcfgQrBcKnyrE99h8xmQX1qep3KE4pM1F4uodLGpln0CnzTF1GFqILDdYbFeS+ZNeeOPy/9L54Ce8W1ebUXOUBuJwRQ0QM0h8XnHkcXQJwvCBwBUM7OvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PovaNtHSa13eGA9HrdcIzgueia2KrIzdhR75Lh7mOxc=;
 b=PXZyQzGbRUo0ULwigRohy2hZzkUzPXH0Glgz2Uww5s/MC3HsBOOPlfNptRCnCQiCW5n1lNVj3DuK9b/H+4OtxzlqYgUwYWsPXXERMjcPsn9qGNPSGaiYkx/rTfNUkUqHYFxe/ze2IkzenfyTPt2iA4yXbAU5QN1quv+0wdraAUa/btfVswpnMWEq4SNxOxmFwT4HgOC1T9AFZ6kdgR9JhIRFhLoe24CvQOn7H89VVnaLreORgbe2C/f0U7MVe3IeiH6xJ+pQornbTSlCMEoj2z2uSU4F9zaPt84EJiqE0mQtdNztnwCcrED68X95Dqr8eyViRPfpzYqm9PleItjuGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PovaNtHSa13eGA9HrdcIzgueia2KrIzdhR75Lh7mOxc=;
 b=GRP2+nOPQlkPp6z7OtHA/Da63duRyN7+CewYc5qRHSrjXCDbTtarHNcsXhOT5jfhb3yeSCeXX3BsQEq1+L5XMnI2rshCelIj7JEHeFBjndqL/3l5ge6YbkvOr8W3JVuOk+eq/+LUk4ib6yg106+6wRUlw89lHRYFwR8pAms9YXM=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DM4PR12MB5183.namprd12.prod.outlook.com (2603:10b6:5:396::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Wed, 21 Jul
 2021 18:15:16 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::4092:5d49:d028:e0df]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::4092:5d49:d028:e0df%6]) with mapi id 15.20.4352.025; Wed, 21 Jul 2021
 18:15:15 +0000
Date:   Wed, 21 Jul 2021 13:14:56 -0500
From:   John Allen <john.allen@amd.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v27 24/31] x86/cet/shstk: Handle thread shadow stack
Message-ID: <YPhkIHJ0guc4UNoO@AUS-LX-JohALLEN.amd.com>
References: <20210521221211.29077-1-yu-cheng.yu@intel.com>
 <20210521221211.29077-25-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521221211.29077-25-yu-cheng.yu@intel.com>
X-ClientProxiedBy: BLAP220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::9) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-JohALLEN.amd.com (165.204.53.104) by BLAP220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Wed, 21 Jul 2021 18:15:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c52edff-828c-4829-86a5-08d94c737d0e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5183:
X-Microsoft-Antispam-PRVS: <DM4PR12MB51839F4109C3F92D9D61DCAA9AE39@DM4PR12MB5183.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vuruA/xtH10UAh8l91YbGwW2nuXhINpjv3sFtHEY3fvkvCH5Vy/2R/o9FTyo0IKfOFXQSqHC+3Y2jRCZXHopquCY2DW0vI7+G+jgsvjQ2EuGjnoATlohb+Q/gKu+j/HXOznDQe5D8H8vLsIH5CkeFA+GAe/skU2rWUxOT8/jSMARldzAQCkIyejXPqouHh6hyMthmaTTeQQZ6QG8uFuit31Tyo4QfD343HUtH2k+0Uf2SNDxyM/sNMIt5vKawBQ1zUNNG05P5lw5x+Z89o39GC4bbAoy85+tUFfuL2Nw6h+KCsgGbbRUiyO5PWKkOhfBBY34INahBgdhhrL5YLzCa4U5sMjmrSJzcYslnsu8vqczGGydNW3YF/TCyAF2fLNpga40Te+m7BE95FYD7brMU4Ma8ECnqg2qn+ZKBx9+yxJha9hUtZOaJ76AkZ0Xe3FgmVMcfL0+csQnDzVG2TLPQ+vJrWXRSWGtXHEA/pExEL2PZkpG4ZA+/OqNPlWx5ZhyZHZ/senc4P5J5F4dPLYZBnmqt8rDTMF09Jh/+gl+JHN+I/aacOOwbTLSMw0xZXXO9r/RGkAPjk8RLqrF0456E5LLZLyS6mqNHwBnGiCQlIkkpcTGrljqTKar4uCtnzK+VoG8P4zyS2/2+00xyeow3nm7zZrPCTp+1fQdNI4xFEA5rBdfXQGWJSmAlwZuDBtPME9K8HkJ0n2+6cYW+RgDKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5549.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(6916009)(66946007)(38100700002)(5660300002)(8936002)(86362001)(7416002)(4326008)(26005)(478600001)(2906002)(66556008)(38350700002)(6666004)(66476007)(7696005)(44832011)(55016002)(52116002)(7406005)(83380400001)(8676002)(316002)(54906003)(956004)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4n5JkzNkpLXIUnzjWvIbrheoH7VikL3vyiPkZ2fpbaCcRN+H0LqYb/dNDquW?=
 =?us-ascii?Q?hlvenpPR/DZ0GcPGSkhoRPWO3KAEG+EmLAJ6DTGdyPVmOZox/xLf5g2co/td?=
 =?us-ascii?Q?iiMJ5yvXklquAFUydJsEpmqDsGGYBYrDhBkeSnLgyCdLB7UTsiR9t+z/hZbM?=
 =?us-ascii?Q?G+YjLY7a1N2AWDyXPsAu+wAplEF9ZvJkAfKk7WLDVNFQf6ZVCJLrDuCjLOTd?=
 =?us-ascii?Q?5kezGXdCb6coCTskAWjtsQJFXIjVAhnieYbvyyBRi3RtxDWvvctJi8Wn/UEG?=
 =?us-ascii?Q?jzskZnYDGQe8IsccqFSqiRaWqLDzZbskdTW1FNOkeF0TkThWk7kUrvKOT6kD?=
 =?us-ascii?Q?W4NAz5dIkBeY1s5H0sU/tYflle9QzdCtve6yoPk9th69KI9IYXCFfyK8RNPm?=
 =?us-ascii?Q?oLo94+VgxDCXyn0mJ/6VETKicD3T2ODRY7cD8T4uE1kcCAp3CeYKZN0Ljvz2?=
 =?us-ascii?Q?vu0q2j8pGV5Ao3XvOlbk1/kSXW9cxw25q6KpzRtAYCUKbC3TJW9Xwz9Rtqq1?=
 =?us-ascii?Q?MzJ+Jw2nfDV0YweIKi11OU/xnEM/2kMx+BpBZ2/RaWpfnteqW5xOTFYn2N2d?=
 =?us-ascii?Q?YR+ErS8K82iyNDa0fDHJiNi/BjUf7ChskZSIlFB9V9uzXinMQMNStaRENy92?=
 =?us-ascii?Q?GOqDPBZ8lFy8rBT58Wgj7hyL0t9ZcwmgbVo+qT02TYR2oR1V/kGWUFHhQmL5?=
 =?us-ascii?Q?LOO6tINeSwEirjXkauqx97JJFmNVmohwH0/jaiAd9TsImmi3Po4GyW3ALcJY?=
 =?us-ascii?Q?ZcyabK3CcK/S6mHRbC3oku8Iz6iUIbjl+3lCJHQtJrOuMlc4ST1QqD4jL6Fi?=
 =?us-ascii?Q?/pHrusnxIupGX14anUWGgR+UkKl0nY6/L4b6PtO6DDo8OKCSJvBBfIHdGFbv?=
 =?us-ascii?Q?+DYUk/fPjzwodk3tzt+XFIzLogZAYTunoT/0x3nreGQq92TnQFiTZTY2ifvg?=
 =?us-ascii?Q?Q/C7KRpQnApk17mTRyuEjjwoeyoMJTY55WXOi1TkZE3K4dDuLwnJzG2TLtrF?=
 =?us-ascii?Q?WJwu2ZWgTi9TAJYA0iR6Fwi8iSySIhUszG6SKmLgBEXal3jX2m9vHkFqzhlY?=
 =?us-ascii?Q?4uKxOGlf63xK/UEDCVChl3EMkVgscCkXl8VnKhIapUYYOH34ORb0Ui6yDoXD?=
 =?us-ascii?Q?k+NFPe+h/ygSK6DdbJXhWX4J2u8tWxL3arE8buPcMhiog3kPpb/IQM9nFdqI?=
 =?us-ascii?Q?9zcxbMo+JVxURaRsdYn0adNWFtDlQ4xeayqHRhDwwkq4D9kwZMEMWYnLYZOj?=
 =?us-ascii?Q?jv0ZlQuo9UUKHL1+02dkGcGy6Y3DK/KhkN6rXj+000byrJkUnVD9dWcUxKcW?=
 =?us-ascii?Q?FEs629lWDwgvaTEUZmNMBg4j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c52edff-828c-4829-86a5-08d94c737d0e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 18:15:15.6921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpIW4vidlDW4AmAAHzgLvstQirSSgvmo8Os6HyNQ9arCobenPPnscFOkHU5VQ9igPPzFhSG7AsWm+BpNmZhv0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5183
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 21, 2021 at 03:12:04PM -0700, Yu-cheng Yu wrote:
> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index 5ea2b494e9f9..8e5f772181b9 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -71,6 +71,53 @@ int shstk_setup(void)
>  	return 0;
>  }
>  
> +int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
> +			     unsigned long stack_size)
> +{
> +	struct thread_shstk *shstk = &tsk->thread.shstk;
> +	struct cet_user_state *state;
> +	unsigned long addr;
> +
> +	if (!stack_size)
> +		return -EINVAL;

I've been doing some light testing on AMD hardware and I've found that
this version of the patchset doesn't boot for me. It appears that when
systemd processes start spawning, they hit the above case, return
-EINVAL, and the fork fails. In these cases, copy_thread has been passed
0 for both sp and stack_size.

For previous versions of the patchset, I can still boot. When the
stack_size check was last, the function would always return before
completing the check, hitting one of the two cases below.

At the very least, it would seem that on some systems, it isn't valid to
rely on the stack_size passed from clone3, though I'm unsure what the
correct behavior should be here. If the passed stack_size == 0 and sp ==
0, is this a case where we want to alloc a shadow stack for this thread
with some capped size? Alternatively, is this a case that isn't valid to
alloc a shadow stack and we should simply return 0 instead of -EINVAL?

I'm running Fedora 34 which satisfies the required versions of gcc,
binutils, and glibc.

Please let me know if there is any additional information I can provide.

Thanks,
John

> +
> +	if (!shstk->size)
> +		return 0;
> +
> +	/*
> +	 * For CLONE_VM, except vfork, the child needs a separate shadow
> +	 * stack.
> +	 */
> +	if ((clone_flags & (CLONE_VFORK | CLONE_VM)) != CLONE_VM)
> +		return 0;
> +
> +	state = get_xsave_addr(&tsk->thread.fpu.state.xsave, XFEATURE_CET_USER);
> +	if (!state)
> +		return -EINVAL;
> +
> +	/*
> +	 * Compat-mode pthreads share a limited address space.
> +	 * If each function call takes an average of four slots
> +	 * stack space, allocate 1/4 of stack size for shadow stack.
> +	 */
> +	if (in_compat_syscall())
> +		stack_size /= 4;
> +
> +	stack_size = round_up(stack_size, PAGE_SIZE);
> +	addr = alloc_shstk(stack_size);
> +	if (IS_ERR_VALUE(addr)) {
> +		shstk->base = 0;
> +		shstk->size = 0;
> +		return PTR_ERR((void *)addr);
> +	}
> +
> +	fpu__prepare_write(&tsk->thread.fpu);
> +	state->user_ssp = (u64)(addr + stack_size);
> +	shstk->base = addr;
> +	shstk->size = stack_size;
> +	return 0;
> +}
> +
>  void shstk_free(struct task_struct *tsk)
>  {
>  	struct thread_shstk *shstk = &tsk->thread.shstk;
> @@ -80,7 +127,13 @@ void shstk_free(struct task_struct *tsk)
>  	    !shstk->base)
>  		return;
>  
> -	if (!tsk->mm)
> +	/*
> +	 * When fork() with CLONE_VM fails, the child (tsk) already has a
> +	 * shadow stack allocated, and exit_thread() calls this function to
> +	 * free it.  In this case the parent (current) and the child share
> +	 * the same mm struct.
> +	 */
> +	if (!tsk->mm || tsk->mm != current->mm)
>  		return;
>  
>  	while (1) {
