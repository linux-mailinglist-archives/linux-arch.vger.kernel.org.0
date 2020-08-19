Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF63724A764
	for <lists+linux-arch@lfdr.de>; Wed, 19 Aug 2020 22:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHSUC2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Aug 2020 16:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSUC1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Aug 2020 16:02:27 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8337CC061757;
        Wed, 19 Aug 2020 13:02:26 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 32B9F11E45763;
        Wed, 19 Aug 2020 12:45:37 -0700 (PDT)
Date:   Wed, 19 Aug 2020 13:02:22 -0700 (PDT)
Message-Id: <20200819.130222.1915954815957844234.davem@davemloft.net>
To:     christian.brauner@ubuntu.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, ysato@users.sourceforge.jp, tony.luck@intel.com,
        fenghua.yu@intel.com, geert@linux-m68k.org, ley.foon.tan@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        arnd@arndb.de, rostedt@goodmis.org, shorne@gmail.com,
        peterz@infradead.org, jongk@linux-m68k.org, keescook@chromium.org,
        green.hu@gmail.com, ebiederm@xmission.com,
        mchehab+huawei@kernel.org, alexandre.chartre@oracle.com,
        mhiramat@kernel.org, zanussi@kernel.org, yangx.jy@cn.fujitsu.com,
        linux-doc@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kselftest@vger.kernel.org, torvalds@linux-foundation.org,
        hch@infradead.org, willy@infradead.org
Subject: Re: [PATCH v2 06/11] sparc: switch to kernel_clone()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200819104655.436656-7-christian.brauner@ubuntu.com>
References: <20200819104655.436656-1-christian.brauner@ubuntu.com>
        <20200819104655.436656-7-christian.brauner@ubuntu.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 19 Aug 2020 12:45:38 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Wed, 19 Aug 2020 12:46:50 +0200

> The old _do_fork() helper is removed in favor of the new kernel_clone() helper.
> The latter adheres to naming conventions for kernel internal syscall helpers.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Acked-by: David S. Miller <davem@davemloft.net>
