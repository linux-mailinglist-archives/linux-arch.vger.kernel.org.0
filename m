Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3DD4A46D4
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jan 2022 13:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376901AbiAaMVe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 07:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349077AbiAaMVd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jan 2022 07:21:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C5AC06173B;
        Mon, 31 Jan 2022 04:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3wNIYew9FTqVt8X3C3MpN6htZ5VEftQt1dS3fPy0Ox4=; b=kU5t8mrV53XE6VG7WEyBe6Ra2m
        sI3IGk6Geor2271toZ3n1TXDrnm8GPZ6KHGMIjX6PJvqrk+1xc6wMB10y6ukUj1GffqA4GowX71qG
        KyA3oiDJgA7wme1bjM7ajJzIcMhLi8pVG5TJZJm/vPz5AsDu2V4MENP9GPAmpkL4DcF3izBBIuXQO
        ZNt0XurceE3LxabmNTNaS+umGtLmbUBlGgo8a/Am8wD8ZoxKvFnWGSi94Q83b+JAZwA4r6l5pOfgt
        22HYiVhhZDGKv/dNcR03rm4PgW9myIXVHcC5qbi5gNJI1+swrGMLuU45ay6728KcdrJhkk7d98mw4
        OWUQ5yIg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEVgU-009J6Z-4J; Mon, 31 Jan 2022 12:21:26 +0000
Date:   Mon, 31 Jan 2022 04:21:26 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     guoren@kernel.org
Cc:     palmer@dabbelt.com, arnd@arndb.de, anup@brainfault.org,
        gregkh@linuxfoundation.org, liush@allwinnertech.com,
        wefu@redhat.com, drew@beagleboard.org, wangjunqiang@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V4 03/17] asm-generic: compat: Cleanup duplicate
 definitions
Message-ID: <YffURrqD0pfXnEkV@infradead.org>
References: <20220129121728.1079364-1-guoren@kernel.org>
 <20220129121728.1079364-4-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129121728.1079364-4-guoren@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 29, 2022 at 08:17:14PM +0800, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> There are 7 64bit architectures that support Linux COMPAT mode to
> run 32bit applications. A lot of definitions are duplicate:
>  - COMPAT_USER_HZ
>  - COMPAT_RLIM_INFINITY
>  - COMPAT_OFF_T_MAX
>  - __compat_uid_t, __compat_uid_t
>  - compat_dev_t
>  - compat_ipc_pid_t
>  - struct compat_flock
>  - struct compat_flock64
>  - struct compat_statfs
>  - struct compat_ipc64_perm, compat_semid64_ds,
> 	  compat_msqid64_ds, compat_shmid64_ds
> 
> Cleanup duplicate definitions and merge them into asm-generic.

The flock part seems to clash with the general compat_flock
consolidation.  Otherwise this looks like a good idea.
