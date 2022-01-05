Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C1E484BCD
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 01:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiAEAkg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 19:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbiAEAkg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 19:40:36 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1933C061761;
        Tue,  4 Jan 2022 16:40:35 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id n30so42929547eda.13;
        Tue, 04 Jan 2022 16:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fN42ziO4udJZOMwfp7U3CaF0v31ogcDT0UpfTa7XxeQ=;
        b=EGjTKa0Ym3rjGhs+OIu1mp+QfRepLT6s0RxLzvTTrxKsSkwAE9OxRjekyQvkKzf7nh
         vQivcFRIVKF1+H1lya6DEy/em2pSjTzFtfgvirj+LlqdiEFeyMjreCRWelV/p42kp7uJ
         Sf4lO2/sIDXH1zkUzZYlE8HXrCwS9triGrizzmVWoZOL2Km4s1fQWgm9aw6Su8ltQyMw
         HisOiAxs7+F25Xag0NqFBfF+lK+MrzHu8EmtGLdy2FCsd8T/MWw9y4ChwhfncbAJZPAy
         UqHc2M/3RMN7Dmkah+L+zrp9an6yYTJzKhgSMo3rdTF1jIxys74260C0BKs87SoRrygJ
         bD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fN42ziO4udJZOMwfp7U3CaF0v31ogcDT0UpfTa7XxeQ=;
        b=y4VNeX+WzepQlBC317pklLNDO79xsXNIjmbS+M+lxkv3WyHSvW1WrNx++oxjTLo6UP
         K5FMH4GtgA09aC6UYiYTWxDuaIh1nOJyzigijAn5fR9yB9W03t8q/nk95hOusn8UVyw1
         gd0DkWThnOoXb+guSCFBaf15hV/UJH02T1JpuxfsuvQ8qZnAlFFbJwoS9wNw4qybyMy6
         dSmtW/Q682yJmrwPDFJY55eN3/uqxRzwwPuWlKnErW/hFvKB0R8JR17nJWGEJU8IAlSI
         3AIqCkqBM53dyBwIXVEMeS/jPlGyCPlYCratvZ4w7UcInHh6l2Q6+9aAwBTFfQrZXU8F
         z4fw==
X-Gm-Message-State: AOAM530zdebJiwyjWdHSRyGnbdGguWH7ZKfyguPRjSkW4GODBbeDVVXW
        ltRahZ7bo4UUj7syQL6lhdw=
X-Google-Smtp-Source: ABdhPJyPBkxLWiu9fIEY9pd/2arX3HKg/G3CQ12wOwDqfECEZAZnss3CAKK7bj8OfePAzYg/Y5pShA==
X-Received: by 2002:a05:6402:5cf:: with SMTP id n15mr48741951edx.6.1641343234290;
        Tue, 04 Jan 2022 16:40:34 -0800 (PST)
Received: from gmail.com (0526F11B.dsl.pool.telekom.hu. [5.38.241.27])
        by smtp.gmail.com with ESMTPSA id k12sm11775890ejx.119.2022.01.04.16.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 16:40:33 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 5 Jan 2022 01:40:32 +0100
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
Message-ID: <YdTpAJxgI+s9Wwgi@gmail.com>
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

> > I.e. I think the bug was simply to make main.c aware of the array, now 
> > that the INIT_THREAD initialization is done there.
> 
> Yes, that seems right.
> 
> Unfortunately, while the kernel now builds, it does not boot in QEMU. I 
> tried to checkout at 9006a48618cc0cacd3f59ff053e6509a9af5cc18 to see if I 
> could reproduce that breakage there but the build errors out at that 
> change (I do see notes of bisection breakage in some of the commits) so I 
> assume that is expected.

Yeah, there's a breakage window on ARM64, I'll track down that 
bisectability bug.

Decoupling thread_info and task_struct incrementally, so that it bisects 
cleanly on all architectures, was always a big challenge. :-/

> There is no output, even with earlycon, so it seems like something is 
> going wrong in early boot code. I am not very familiar with the SCS code 
> so I will see if I can debug this with gdb later (I'll try to see if it 
> is reproducible with GCC as well; as Nick mentions, there is support 
> being added to it and I don't mind building from source).

Just to make sure: with SCS disabled the same kernel boots fine?

> Sure thing, I will continue to follow this and test it as much as I can 
> to make sure everything continues to work well!

Thank you!

	Ingo
