Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDE11E9CBC
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jun 2020 06:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgFAEem (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Jun 2020 00:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFAEel (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jun 2020 00:34:41 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F5CC061A0E;
        Sun, 31 May 2020 21:34:41 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id k8so6265342edq.4;
        Sun, 31 May 2020 21:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7ckn9OXtDPF1Bwri75+U+nt/Q8mXQGXNRe28rXQM3kA=;
        b=mtaDVYp5eEozTqU7mkCHE30shotDAVXfZdyOaWq1x4lVIEV0FrjABspRSi00HPhkZG
         wOY6GRbI2gGzrnGk+SD4dPuBvF09yN87pSBQOZHJlzPvvLI2INql6OX0YL9A4pCLotpr
         2bjVtP/4EQuTZY3kM8Ch1t6drAUwbZQB3U4OCCg+iVN44EcsPRG3Dg+Fln95auurET2G
         KJI1XtvsLHdI9OLNrk53dZFIHajpYSxAAuTzF4FPwDB6Fua5bkSMhtokeDBdTynh7l+Y
         er7LfOmdZfSiQmLm4tJsHi9pNkc5iZtlUZGF8NcnEOoyPQWz7/pjkOKbtAoT4DVLdDLZ
         AJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7ckn9OXtDPF1Bwri75+U+nt/Q8mXQGXNRe28rXQM3kA=;
        b=a2w2WAUtTNDyHm5yiJnVvoyUUgibCGnVE8RzfldrQCaF2j6fKvfnf6ZYg3gMueW0kz
         mKg+lKEAPszo9JMqxU5CSHo3VJT4SuJ/5n8lLQ2ly+mWatcogcLoi4x8GV6sopgBwC5+
         vzFwerb5r5iI/O6L4WOzce4tz/WyK28xWDeBzda/Zjhx7l19DEhGZxlhuCAc8uBGvimt
         3xzkhPMT9vPdE835GUdvg94WtGLsme0iEdUYWyCxHcf6j00M9SIJkJvzuLouwKB3mqos
         yL+SIS2A0sgVYWZGN5E3hjHhxxtghPWMM38hgvNOeS0y2t5fL73miawxN2deFJQEjqXo
         dmaw==
X-Gm-Message-State: AOAM5317RFN83FyWv763XJabLSfdzOp/JM4rlz4QXa2sJZkmujnNEARQ
        DhJ4EhnJ5uWdjA5UxbhQU0wbWMVJvfSWMQ==
X-Google-Smtp-Source: ABdhPJzJe1wMYgBDaynrxesiOGpdYWXgKX0yn+uV/fcRWOUgm+PWxGCcOxHyNB5lx/+DUADDyWqlJw==
X-Received: by 2002:a50:f094:: with SMTP id v20mr19582121edl.77.1590986079948;
        Sun, 31 May 2020 21:34:39 -0700 (PDT)
Received: from andrea (ip-213-220-210-175.net.upcbroadband.cz. [213.220.210.175])
        by smtp.gmail.com with ESMTPSA id b21sm9210790edv.31.2020.05.31.21.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 21:34:39 -0700 (PDT)
Date:   Mon, 1 Jun 2020 06:34:33 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jade Alglave <jade.alglave@arm.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH -rcu lkmm] tools/memory-model/README: Expand
 dependency of klitmus7
Message-ID: <20200601043433.GA21675@andrea>
References: <4a05e568-aa30-423a-badc-f79f0af815a0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a05e568-aa30-423a-badc-f79f0af815a0@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 01, 2020 at 12:37:20AM +0900, Akira Yokosawa wrote:
> From 87048d7212f6cb16b0a2b85fa6d2f34c28b078c0 Mon Sep 17 00:00:00 2001
> From: Akira Yokosawa <akiyks@gmail.com>
> Date: Sun, 31 May 2020 20:04:32 +0900
> Subject: [PATCH RFC] tools/memory-model/README: Expand dependency of klitmus7
> 
> klitmus7 is independent of the memory model but depends on the
> build-target kernel release.
> It occasionally lost compatibility due to kernel API changes [1, 2, 3].
> It was remedied in a backwards-compatible manner respectively [4, 5, 6].
> 
> Reflect this fact in README.
> 
> [1]: b899a850431e ("compiler.h: Remove ACCESS_ONCE()")
> [2]: 0bb95f80a38f ("Makefile: Globally enable VLA warning")
> [3]: d56c0d45f0e2 ("proc: decouple proc from VFS with "struct proc_ops"")
> [4]: https://github.com/herd/herdtools7/commit/e87d7f9287d1
>      ("klitmus: Use WRITE_ONCE and READ_ONCE in place of deprecated ACCESS_ONCE")
> [5]: https://github.com/herd/herdtools7/commit/a0cbb10d02be
>      ("klitmus: Avoid variable length array")
> [6]: https://github.com/herd/herdtools7/commit/46b9412d3a58
>      ("klitmus: Linux kernel v5.6.x compat")
> 
> NOTE: [5] was ahead of herdtools7 7.53, which did not make an
> official release.  Code generated by klitmus7 without [5] can still be
> built targeting Linux 4.20--5.5 if you don't care VLA warnings.
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>

Acked-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea


> ---
> Hi all,
> 
> Recent struggle of Andrii with the use of klitmus7 on an up-to-date
> Linux system prompted me to add some explanation of klitmus7's dependency
> in README.
> 
> As herdtools7 7.56 is still under development, I called out just HEAD
> in the compatibility table.  Once 7.56 is released, the table can be
> updated.
> 
> I'm not sure if this is the right place to carry such info.
> Anyway, I'd be glad if this patch can trigger a meaningful update of
> README.
> 
>         Thanks, Akira
> --
>  tools/memory-model/README | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/memory-model/README b/tools/memory-model/README
> index b9c562e92981..90af203c3cf1 100644
> --- a/tools/memory-model/README
> +++ b/tools/memory-model/README
> @@ -28,8 +28,34 @@ downloaded separately:
>  See "herdtools7/INSTALL.md" for installation instructions.
>  
>  Note that although these tools usually provide backwards compatibility,
> -this is not absolutely guaranteed.  Therefore, if a later version does
> -not work, please try using the exact version called out above.
> +this is not absolutely guaranteed.
> +
> +For example, a future version of herd7 might not work with the model
> +in this release.  A compatible model will likely be made available in
> +a later release of Linux kernel.
> +
> +If you absolutely need to run the model in this particular release,
> +please try using the exact version called out above.
> +
> +klitmus7 is independent of the model provided here.  It has its own
> +dependency on a target kernel release where converted code is built
> +and executed.  Any change in kernel APIs essential to klitmus7 will
> +necessitate an upgrade of klitmus7.
> +
> +If you find any compatibility issues in klitmus7, please inform the
> +memory model maintainers.
> +
> +klitmus7 Compatibility Table
> +----------------------------
> +
> +	============  ==========
> +	target Linux  herdtools7
> +	------------  ----------
> +	     -- 4.18  7.48 --
> +	4.15 -- 4.19  7.49 --
> +	4.20 -- 5.5   7.54 --
> +	5.6  --       HEAD
> +	============  ==========
>  
>  
>  ==================
> -- 
> 2.17.1
> 
