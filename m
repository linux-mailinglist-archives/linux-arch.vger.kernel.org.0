Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3587A5684
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 02:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjISARY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Sep 2023 20:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjISARY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Sep 2023 20:17:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C7B10A;
        Mon, 18 Sep 2023 17:17:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695082636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KrJg2aRiBmVWOilT8MlBnMLrltQ0SE0OPhktT/W7MPw=;
        b=nFj+rUyZJbP1kkp/ES1/T6W9lRbX5HKzTav6N3kzUUxBSDBASRn7EB6ANyBkBOenRccXBG
        bK7iJrOeYTpfqOY/CiqSjBGsf/+6GeGjTFtwXs59ar7/cAu2ZVI8veSSwtkJaCFjiCauLW
        0bjgs/Z1On3LgQMmBJagUz2awqvWO+rg/Gj4UuaRaX5LGWXTSoKEXrnErmSmaB7Yuy+DbP
        bDMRs9M5RXiGljRtY5TYgNYJqHaBqL7gojfqb2vclC/tOHVulTD2urJwgGPcPViKgY4E6v
        X7JjHJbHEJpJJUJPC1wHFvtYA0BgCXYD5ZC4KBtNw9kH8fdRWhl6d6kwyQQWrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695082636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KrJg2aRiBmVWOilT8MlBnMLrltQ0SE0OPhktT/W7MPw=;
        b=9BWThgoHlhPwOVuV2mZoRpDwWcPARMCwbmk18qgjjKy6t181pUd67vbj33Mr4PMSijJ9n9
        MnxLU4KrsbTVYZDQ==
To:     Gregory Price <gourry.memverge@gmail.com>, linux-mm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, arnd@arndb.de,
        akpm@linux-foundation.org, x86@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 3/3] mm/migrate: Create move_phys_pages syscall
In-Reply-To: <20230907075453.350554-4-gregory.price@memverge.com>
References: <20230907075453.350554-1-gregory.price@memverge.com>
 <20230907075453.350554-4-gregory.price@memverge.com>
Date:   Tue, 19 Sep 2023 02:17:15 +0200
Message-ID: <877conxbhw.ffs@tglx>
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

On Thu, Sep 07 2023 at 03:54, Gregory Price wrote:
> Similar to the move_pages system call, instead of taking a pid and
> list of virtual addresses, this system call takes a list of physical
> addresses.

Silly question. Where are these physical addresses coming from?

In my naive understanding user space deals with virtual addresses for a
reason.

Exposing access to physical addresses is definitely helpful to write
more powerful exploits, so what are the restriction applied to this?

> +/*
> + * Move a list of pages in the address space of the currently executing
> + * process.
> + */
> +static int kernel_move_phys_pages(unsigned long nr_pages,
> +				  const void __user * __user *pages,
> +				  const int __user *nodes,
> +				  int __user *status, int flags)
> +{
> +	int err;
> +	nodemask_t target_nodes;
> +
> +	/* Check flags */

Documeting the obvious ...

> +	if (flags & ~(MPOL_MF_MOVE|MPOL_MF_MOVE_ALL))
> +		return -EINVAL;
> +
> +	if ((flags & MPOL_MF_MOVE_ALL) && !capable(CAP_SYS_NICE))
> +		return -EPERM;

According to this logic here MPOL_MF_MOVE is unrestricted, right?

But how is an unpriviledged process knowing which physical address the
pages have? Confused....

> +	/* All tasks mapping each page is checked in phys_page_migratable */
> +	nodes_setall(target_nodes);

How is the comment related to nodes_setall() and why is nodes_setall()
unconditional when target_nodes is only used in the @nodes != NULL case?

> +	if (nodes)
> +		err = do_pages_move(NULL, target_nodes, nr_pages, pages,
> +			nodes, status, flags);
> +	else
> +		err = do_pages_stat(NULL, nr_pages, pages, status);

Thanks,

        tglx
