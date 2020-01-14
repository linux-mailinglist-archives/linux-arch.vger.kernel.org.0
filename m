Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E872E13B619
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jan 2020 00:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgANXqT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 18:46:19 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:47370 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbgANXqT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jan 2020 18:46:19 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irVsm-008O1i-77; Tue, 14 Jan 2020 23:46:00 +0000
Date:   Tue, 14 Jan 2020 23:46:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-snps-arc@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC 2/4] lib/strncpy_from_user: Remove redundant user space
 pointer range check
Message-ID: <20200114234600.GD8904@ZenIV.linux.org.uk>
References: <20200114200846.29434-1-vgupta@synopsys.com>
 <20200114200846.29434-3-vgupta@synopsys.com>
 <CAHk-=wgoc5DaF6=WxsAcft_Lp4XUYTiRhhCJGcmM5PwEDXY6Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgoc5DaF6=WxsAcft_Lp4XUYTiRhhCJGcmM5PwEDXY6Gw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 14, 2020 at 01:22:07PM -0800, Linus Torvalds wrote:

> The fact is, copying a string from user space is *very* different from
> copying a fixed number of bytes, and that whole dance with
> 
>         max_addr = user_addr_max();
> 
> is absolutely required and necessary.
> 
> You completely broke string copying.

BTW, a quick grep through the callers has found something odd -
static ssize_t kmemleak_write(struct file *file, const char __user *user_buf,
                              size_t size, loff_t *ppos)
{
        char buf[64];
        int buf_size;
        int ret;

        buf_size = min(size, (sizeof(buf) - 1));
        if (strncpy_from_user(buf, user_buf, buf_size) < 0)
                return -EFAULT;
        buf[buf_size] = 0;

What the hell?  If somebody is calling write(fd, buf, n) they'd
better be ready to see any byte from buf[0] up to buf[n - 1]
fetched, and if something is unmapped - deal with -EFAULT.
Is something really doing that and if so, why does kmemleak
try to accomodate that idiocy?

The same goes for several more ->write() instances - mtrr_write(),
armada_debugfs_crtc_reg_write() and cio_ignore_write(); IMO that's
seriously misguided (and cio one ought use vmemdup_user() instead
of what it's doing)...

