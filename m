Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100B44A46DC
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jan 2022 13:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376944AbiAaMWC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 07:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349077AbiAaMWB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jan 2022 07:22:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88562C06173B;
        Mon, 31 Jan 2022 04:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f4Y3/+mnt13M4Z9/M62N5ZCwD04W58R8ZTJkz565l8U=; b=0u1CnjxtmYRSbXpXwQeALFKTO1
        p8CPA7S/POyhrDUXoe7Q9T+q5HklpvRWMpCudZaQQUBwQbfx/2ZpD+ONHk8u3O7bHR+3MBQsjChAV
        3tmIAMd+cUuX69aq1UYA4QevllOPD3YUl5YQltKLkJi+7HWznbwJfna6wL6VMm9yxzfAvcATqoLlw
        4l/an+pWUstnjj1GJb6jTewiiinb5MPHUI2x5OCkIaXD3mjkYlPy4gCkvvbtJhd/s3vvAxzm3Lteq
        NP/m0koFsSDjGnPcH0IBpP0nQV+j/NOZjUCvza+o/hpHLpnmvXqJY+GaZVY0JHMuIyFYJNzhubjB/
        4oTn4Sqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEVgx-009JGM-DM; Mon, 31 Jan 2022 12:21:55 +0000
Date:   Mon, 31 Jan 2022 04:21:55 -0800
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
Subject: Re: [PATCH V4 04/17] syscalls: compat: Fix the missing part for
 __SYSCALL_COMPAT
Message-ID: <YffUY/l8ydK8+/70@infradead.org>
References: <20220129121728.1079364-1-guoren@kernel.org>
 <20220129121728.1079364-5-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129121728.1079364-5-guoren@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 29, 2022 at 08:17:15PM +0800, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Make "uapi asm unistd.h" could be used for architectures' COMPAT
> mode. The __SYSCALL_COMPAT is first used in riscv.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
