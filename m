Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C8B488429
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 16:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiAHPQK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 10:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiAHPQK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 10:16:10 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED92C06173F;
        Sat,  8 Jan 2022 07:16:09 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id k18so17123543wrg.11;
        Sat, 08 Jan 2022 07:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uucTvtg1YQMjIP0qoj4ZoGgmtYYbV+cou28W1zzliws=;
        b=A1k4VDrvuCebTVmunqofPKMOGmzg8ckI4u3okugvYNraxLKTbhFLXWZtX7al2ZBWel
         C2IDdncztk9+bTxGS2CMcIEC90FjXYHJsK57rvHjnmtL7dZ4ni+XGGQZqRKMDVbXwA+I
         A/qubHWE6yhjNFLpJ1nYxOZQN6lv9ZSARxmH6lAQmEFGA//nsrVdt/ZBjTWCbbpcIyiF
         AiINtrv/KEXVOYUvxi0YePELa1aR+mjbX+MyRUeN2iWv5v7zHY00adHqWoMZ1w6AIwYG
         yAdo/e6WAPwgaCMemGqmu4n6agyA3tzb2nfcWhD/PWFk808VK5QR8afc0hN0nFBbsGrl
         B0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uucTvtg1YQMjIP0qoj4ZoGgmtYYbV+cou28W1zzliws=;
        b=T5DoO3DMvaqyNN8zkuJHEiNJyimtWFn1w1AvDki8HkanFtu5FKbo81j7e4sI19dOd9
         BKH1YUAU7KPJMtSbGojc8SwDR7xX6KjN2pb5E/KfakF7FbVI1WI8hgTWHoxXlf7P49xS
         3BY2H9nvAbc7RluWdluMR8jLch0E6sqpx+nHB22GgjJQrpNFDsUXDjq30pwW+hbJwxOT
         keuTV1uzN2DCg423aqWCHbSAOEiFAiIobrK81BzgS4Ec21Drd3hBXdHUAkerwi8AwMI7
         2MGsWQZGRGyqa8xNOw9OSCCqfxd14DtaoM/GbP/x+mBm27Y/oDVwpsv4GVmwLP8qd+yS
         GxCg==
X-Gm-Message-State: AOAM532/T/E+hOk2oXp0xFFrYhHQAsxAXPEj+GMtlDxVrLd6TGQ/yU2R
        xRXX/6BZuUuxBzGw11+E2E3SIl0mlXM=
X-Google-Smtp-Source: ABdhPJwLiHYa3upjIY0klY4+zWxYl5EZgcOkEErx4i8nnXRKMGzyDpAok+0VJvZ5yqbi98eRiZYTTQ==
X-Received: by 2002:a5d:6d0a:: with SMTP id e10mr58254890wrq.65.1641654967930;
        Sat, 08 Jan 2022 07:16:07 -0800 (PST)
Received: from gmail.com (84-236-113-171.pool.digikabel.hu. [84.236.113.171])
        by smtp.gmail.com with ESMTPSA id o29sm3109607wms.3.2022.01.08.07.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 07:16:07 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 8 Jan 2022 16:16:05 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>, llvm@lists.linux.dev
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree
 -v1: Eliminate the Linux kernel's "Dependency Hell"
Message-ID: <YdmqtdqQ9Wq36tQ+@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdM4Z5a+SWV53yol@archlinux-ax161>
 <YdQlwnDs2N9a5Reh@gmail.com>
 <YdSI9LmZE+FZAi1K@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdSI9LmZE+FZAi1K@archlinux-ax161>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Nathan Chancellor <nathan@kernel.org> wrote:

> I tried to checkout at 9006a48618cc0cacd3f59ff053e6509a9af5cc18 to see if 
> I could reproduce that breakage there but the build errors out at that 
> change (I do see notes of bisection breakage in some of the commits) so I 
> assume that is expected.

Yeah, so the underlying problem is that these two commits want to be a 
single commit:

  # Commit #117
  headers/deps: Move task->thread_info to per_task()

  # Commit #106
  headers/deps: Move thread_info APIs to <linux/sched/thread_info_api.h>

As we can only switch ARM64's <asm/preempt.h> to use per_task() - which 
requires <linux/sched.h> - if we first fix & simplify <linux/sched.h>'s 
header dependencies, which is done to a sufficient level by:

  # Commit #556
  headers/deps: Optimize <linux/sched.h> dependencies, remove <linux/sched/thread_info_api_lowlevel.h> inclusion


So it's a catch-22, and quite a complication, and a bisection breakage 
distance of ~450 commits, with a lot of ordering assumptions & conflicts 
along the way, should we attempt to move the first two to later stages. :-/

But today I've restructured the tree, and the -v2-to-be tree is now fully 
bisectable on ARM64 too. :-)

There's a single, late per_cpu() conversion commit, after the first phase 
of <linux/sched.h> simplifications:

   headers/deps: Move task->thread_info to per_task()

I'd guess that either this one is that breaks SCS for you, or the ::thread 
conversion:

   headers/deps: per_task, arm64, x86: Convert task_struct::thread to a per_task() field

I've pushed out these fixes to the sched/headers branch a couple of minutes 
ago, and this will be part of the -v2 release as well.

Thanks,

	Ingo
