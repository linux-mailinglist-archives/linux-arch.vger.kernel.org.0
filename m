Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8492B2CE1
	for <lists+linux-arch@lfdr.de>; Sat, 14 Nov 2020 12:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKNLXI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 Nov 2020 06:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKNLXH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 14 Nov 2020 06:23:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2DAC0613D1;
        Sat, 14 Nov 2020 03:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WSIzGRv01oFmCn2Ex1npbSfqnCGb2bhck8coHY7VFYQ=; b=IZ0XGYO5/RVaiBZeh9lXJGJJJ/
        MXN/rVowyUDTZrwvo3RHw7FlYuXZW4ugDR+GCwGwn3N6keFXx0knFTwSKfRUAqrgHrZgWUwjoKm9f
        OohLjSa89fm03mxrQ35bVtPQWBDhVbvs2A9SJ+pqUYKPfJzd02PZnNB6lGUUUoDJE75YZsA6WW+BH
        ed7uJUwfIy9BbzlIL+8yO0BvtFpxPvEzOlATZYOmtnnMF/8PY8bsgcoWMrAMlDITccz3dkMH7VLNk
        xeDo3+FCSWJjkl3EEaE1PAHCkTAk8ouO+0kdi03bpy8szLk1TBeN2MnN6MyFCjAoy931iGDUtprxo
        GKTk1Uhw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdtdp-0005IP-TZ; Sat, 14 Nov 2020 11:22:49 +0000
Date:   Sat, 14 Nov 2020 11:22:49 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, keescook@chromium.org,
        arnd@arndb.de, luto@amacapital.net, wad@chromium.org,
        rostedt@goodmis.org, paul@paul-moore.com, eparis@redhat.com,
        oleg@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, kernel@collabora.com
Subject: Re: [PATCH 02/10] kernel: entry: Expose helpers to migrate TIF to
 SYSCALL_WORK flags
Message-ID: <20201114112249.GA20070@infradead.org>
References: <20201114032917.1205658-1-krisman@collabora.com>
 <20201114032917.1205658-3-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114032917.1205658-3-krisman@collabora.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> +#ifdef CONFIG_GENERIC_ENTRY
> +static inline void __set_task_syscall_work(struct thread_info *ti, int flag)
> +{
> +	set_bit(flag, (unsigned long *)&ti->syscall_work);
> +}
> +static inline int __test_task_syscall_work(struct thread_info *ti, int flag)
> +{
> +	return test_bit(flag, (unsigned long *)&ti->syscall_work);
> +}
> +static inline void __clear_task_syscall_work(struct thread_info *ti, int flag)
> +{
> +	return clear_bit(flag, (unsigned long *)&ti->syscall_work);

The casts here look bogus.
