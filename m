Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AA22054E9
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 16:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732770AbgFWOhi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Jun 2020 10:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732754AbgFWOhi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jun 2020 10:37:38 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C5DC061573;
        Tue, 23 Jun 2020 07:37:37 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id cm23so1586321pjb.5;
        Tue, 23 Jun 2020 07:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Voy94WnL+fl+utiKRLzwdCm/gpXPywr8J4kh798oT4Q=;
        b=LujaQw2HcFE9eRAfDV3oVdOt/gX3NyJS81ef4tJDc09WgbF5X7Rke48Bp8uAX2Iwkw
         lEYqMcQ4OMshLSPUXIfDlpuGtwgoFFOBE30EfcaZb6vO2P97F592ztN7GbZtipYZ9t6H
         kJLsS5XEuBB+xX8UElc/GYZZXttwDNTtNzaImiLhqiAHXtnhcEZJjZ4mfXiTsaWeVNLW
         ZKpD/ZoM+obo3bVBD1zPtpp9GpNldOfYslqDpvI3oeUMkJ6UGdFvRekCzrmg6ka4aNK3
         ddcqNOnootAG/PtsoN7MZp/8wJaeLIi0roE9axbJEzdXovrGv7e3o8nIctc36RH5oyl6
         5ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Voy94WnL+fl+utiKRLzwdCm/gpXPywr8J4kh798oT4Q=;
        b=SpRHC4ww0SsYtNfNGUf57KCYZV1CYf7s4rBYfSySu1gm0f8LUq2SoHRNR+/+Z/Z5n3
         NLhWlq4SJJhSmNjhuGOWTiiX9HNlSgdP2tl8jqPpjNEqn8/Do/0uaIGoCGVtEmJt9EWB
         qOOk14QekKMcOvbluw+Rgpt0DnNOzn8x2oWPKkhfHV6VaiG0fsuxQiK8CgB/GDJ6DxVU
         2goEkDAz0bAHcsW3xQiskU9tnFHgU0m8chr04StoRUWCJLtrEYEI9Gn7JtIfOnNKpqfA
         NiIYaX1YL7jb2AzMB/H56hkUOFYfjLuyuqbfuHqvN/UYupeeeRQNPo/IHm4NYhi+S6Rq
         rYyg==
X-Gm-Message-State: AOAM530W4vSr1mu7pJrjH8nnH0zih+ExMdqs1J/BkwY8iH6oGJgVTVQH
        2buvN9rCAszBF0QeDRngvdQ=
X-Google-Smtp-Source: ABdhPJyKrImnNb0u+fJBpH7ptp7lCt7YXy7RdHs0zwfheBq+VGiZxA5mDcmmc9zeG0YhtVAA8gbrFw==
X-Received: by 2002:a17:902:7788:: with SMTP id o8mr25480029pll.166.1592923057412;
        Tue, 23 Jun 2020 07:37:37 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 3sm7650259pfv.156.2020.06.23.07.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 07:37:36 -0700 (PDT)
Subject: Re: [PATCH tip/core/rcu 13/14] tools/memory-model/README: Expand
 dependency of klitmus7
To:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        Akira Yokosawa <akiyks@gmail.com>
References: <20200623005152.GA27459@paulmck-ThinkPad-P72>
 <20200623005231.27712-13-paulmck@kernel.org>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <e3693dec-213a-3f65-eb1c-284bf8ca6e13@gmail.com>
Date:   Tue, 23 Jun 2020 23:37:32 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623005231.27712-13-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 22 Jun 2020 17:52:30 -0700, paulmck@kernel.org wrote:
> From: Akira Yokosawa <akiyks@gmail.com>
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
> Acked-by: Andrea Parri <parri.andrea@gmail.com>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  tools/memory-model/README | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/memory-model/README b/tools/memory-model/README
> index b9c562e..90af203 100644
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

Paul,

I was planning to send an update on this one.
herdtoolds7 7.56 will be released later this week (now tagged 7.56-rc1).

Andrea tested klitmus7 7.56-rc1 against Linux 5.7 and 5.8-rc1.
I tested it against Linux 5.7.4.
klitmus7 worked fine in all these test.

So I think we can safely update the bottom row of the table as:

> +	5.6  --       7.56 --

Can you amend this one directly?
Or do you want me to send a follow-up patch?

        Thanks, Akira

>  
>  
>  ==================
> 
