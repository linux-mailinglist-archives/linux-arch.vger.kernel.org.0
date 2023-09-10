Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B9B799FCC
	for <lists+linux-arch@lfdr.de>; Sun, 10 Sep 2023 22:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjIJUgs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Sep 2023 16:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjIJUgs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Sep 2023 16:36:48 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF7D13D;
        Sun, 10 Sep 2023 13:36:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 89A09357;
        Sun, 10 Sep 2023 20:36:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 89A09357
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1694378201; bh=uoqZ/FCvvhdz8gunfSWf8fFeeJBrqFZlRSNmgxPSAzQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hwGx1cSclZ9afbbIw1gSpof/h9mJJce5EtahbG7j4K4nRH32q4prEesk2+pmzovyR
         j51fDxg2NkcRVTh21TJH2+h851qf/+cVpiyTvIcb4xU/N9C06qyWDbqPuIxbqi2MPO
         EEcgZRJRj9EZVEzXt1wiY8R9BiOjBuRT5UkE909L02pQktt5CJz5MBLx9Uv4JdRWll
         LA1x8CBR/G7oG9QgcLtaaNLMWGYB3sQTQ8rlOJM7ElKaWSjAPnamAnWjwMJd+0yoZF
         YtVMJAvDfzpbKAsCne2QCnOrPidSWX4ADLMPFtlJ5M7COd1ZVE2e9/fhoByZjmKGj7
         pOaWsxXRdPkUQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Gregory Price <gourry.memverge@gmail.com>, linux-mm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 3/3] mm/migrate: Create move_phys_pages syscall
In-Reply-To: <20230907075453.350554-4-gregory.price@memverge.com>
References: <20230907075453.350554-1-gregory.price@memverge.com>
 <20230907075453.350554-4-gregory.price@memverge.com>
Date:   Sun, 10 Sep 2023 14:36:40 -0600
Message-ID: <878r9dzrxj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Gregory Price <gourry.memverge@gmail.com> writes:

> Similar to the move_pages system call, instead of taking a pid and
> list of virtual addresses, this system call takes a list of physical
> addresses.
>
> Because there is no task to validate the memory policy against, each
> page needs to be interrogated to determine whether the migration is
> valid, and all tasks that map it need to be interrogated.
>
> This is accomplished via an rmap_walk on the folio containing
> the page, and interrogating all tasks that map the page.
>
> Each page must be interrogated individually, which should be
> considered when using this to migrate shared regions.
>
> The remaining logic is the same as the move_pages syscall. One
> change to do_pages_move is made (to check whether an mm_struct is
> passed) in order to re-use the existing migration code.
>
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> ---
>  arch/x86/entry/syscalls/syscall_32.tbl  |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl  |   1 +
>  include/linux/syscalls.h                |   5 +
>  include/uapi/asm-generic/unistd.h       |   8 +-
>  kernel/sys_ni.c                         |   1 +
>  mm/migrate.c                            | 178 +++++++++++++++++++++++-
>  tools/include/uapi/asm-generic/unistd.h |   8 +-
>  7 files changed, 197 insertions(+), 5 deletions(-)

So this is probably a silly question, but just to be sure ... what is
the permission model for this system call?  As far as I can tell, the
ability to move pages is entirely unrestricted, with the exception of
pages that would need MPOL_MF_MOVE_ALL.  If so, that seems undesirable,
but probably I'm just missing something ... ?

Thanks,

jon
