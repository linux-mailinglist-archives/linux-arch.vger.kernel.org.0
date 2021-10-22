Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75324437ACD
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 18:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhJVQVG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 12:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbhJVQVF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Oct 2021 12:21:05 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2193C061766
        for <linux-arch@vger.kernel.org>; Fri, 22 Oct 2021 09:18:47 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i1so3028813plr.13
        for <linux-arch@vger.kernel.org>; Fri, 22 Oct 2021 09:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5lhA+ZEQSNRiZSSK2ZDYsgihSLI5adnMAniviex3FN0=;
        b=c4edO6NNLXV4ZKNcSOemrzitem7XRU72wAQJXGm3y3+yU9Or9+QRQeagZcJNjUSIS2
         NcogirJT/gnW79ZCA+3FELTDBkCjlJN+5hsS8vQFRiZpipqB4jh6aYKuUirHgMhro0+a
         dRW2WV+P7KbVrU5HoZbIlahTsuzCMphzwez9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5lhA+ZEQSNRiZSSK2ZDYsgihSLI5adnMAniviex3FN0=;
        b=Qc0slTG5aSXTSbgLGrt0FSgjKFUNqkiCZ3fS/bxI0meS90lV20jI6Nj0swKSRj/Mya
         sW0Huylvf28ZqjvZL0xh8kZ18xXHhBK8UuP2bnC/9pOBpoqSduPQQg91qC/h1HNh8Fk2
         U/HmWwmYh3qeiD9c1jx9hw8KDuk2oP5NWPg6ug1ij7Y5NpM6B7kTdi2k5taEhGF4AFnp
         8T2pYqk2RGI5GotongGwRgNKMZndzxYbi6qROlqLFaIH4D6C5+h03a9WFWL53ffK0I3N
         amj2BSQleF5dxwmLJ0x5Ow99xrfPzsE7GeC0KHm/f1PNX0zvqq8b3oWwblrk7xqZFScy
         ZiVA==
X-Gm-Message-State: AOAM531MGULo+J6LI3cXcZdfkAfhJvcyUq5vFMK2nrNQAJtTuLwVMtJ0
        ooiUeqSCQXdsxbHKjeTP5k7vOg==
X-Google-Smtp-Source: ABdhPJxXplxOVuLKy/nyMQfNB4RZ7adSCFGRQiz84fSzDlynTPzbyEUFIj20Xe1JMUfdk0THzlR6vg==
X-Received: by 2002:a17:902:e544:b0:13e:e863:6cd2 with SMTP id n4-20020a170902e54400b0013ee8636cd2mr685420plf.41.1634919527588;
        Fri, 22 Oct 2021 09:18:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v12sm10184384pjs.0.2021.10.22.09.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 09:18:47 -0700 (PDT)
Date:   Fri, 22 Oct 2021 09:18:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, akpm@linux-foundation.org,
        mark.rutland@arm.com, zhengqi.arch@bytedance.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-arch@vger.kernel.org, ardb@kernel.org
Subject: Re: [PATCH 3/7] ARM: implement ARCH_STACKWALK
Message-ID: <202110220918.B6056D68C@keescook>
References: <20211022150933.883959987@infradead.org>
 <20211022152104.285488044@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022152104.285488044@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 22, 2021 at 05:09:36PM +0200, Peter Zijlstra wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Implement the flavor of CONFIG_STACKTRACE that relies mostly on generic
> code, and only need a small arch_stack_walk() helper that performs the
> actual frame unwinding.
> 
> Note that this removes the SMP check that used to live in
> __save_stack_trace(), but this is no longer needed now that the generic
> version of save_stack_trace_tsk() takes care not to walk the call stack
> of tasks that are live on other CPUs.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
