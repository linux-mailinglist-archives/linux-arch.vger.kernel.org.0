Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C06F28C1CA
	for <lists+linux-arch@lfdr.de>; Mon, 12 Oct 2020 21:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgJLT6N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 15:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgJLT6M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2020 15:58:12 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C49EC0613D0;
        Mon, 12 Oct 2020 12:58:12 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l2so19609538lfk.0;
        Mon, 12 Oct 2020 12:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UH3UXpfvrUNTYADvYPs2GrdsYjSWIaxmja32HFZoz98=;
        b=PA275n58J7f37URqrBTUoDFA89FhZekXMQ21Bb7CQwst5nv71BJD2xlKXU/N4lIIiV
         jD4DySJRjyBOq4YQn0WI3E0mUp0Hmn4gOhn9H6QF7AXOBQ4phxqKQ972lRqkScQ0EKLI
         gH6RzWc/8RAhqpfngv8vqC2HRT9xy5FVSEkCbBbqlKE0gw1o9NhLpqwrraZe5xEzhAH3
         uSru8TSSKGaHVLPXRIBlhgZNAeHbamAfNqWsJkPj7Os/Y/dEfbHQUpNRjRkb/rHYu+dx
         huYMlfq3W/itydIJk3pPuNhHylfpKvs4lFoVhuykm44AwS59wSt0OTLzzExVSn/rIdOX
         4Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UH3UXpfvrUNTYADvYPs2GrdsYjSWIaxmja32HFZoz98=;
        b=dvEBjJUqVafqUOnAKq1lu2aCOvQnzi+L5U6SnPqmArbsqx++lmY4fv97QEA80meVrn
         3HfypylpkMynoNHp2bVIWUpngYlMBBWIJicFlSE4d2ESxEfJSEIFQddRNzhJHrSDdiDA
         U/U2zk3maTqIARDw0AKL+/qwnOmdW4r/tqMX1WEOXDEFbTTAn8nWvo1lafH4Oh9vsv+F
         XzGqW1MMuZHN+B2+dv7TAYZKr5RmKPWlrAtQXyRkebaS7ND1KIA11C4MyBEma79SQI1+
         euB4X4LG6dWNkspzgjPPapqxJg3RKJ0INfwpvQFkA+X1DN9bLdkq5T0LATz0e9zrAna3
         rlnw==
X-Gm-Message-State: AOAM530Tl4yoNFq0kQ5PKOkUbpfRc6RwaKAK1j671eOL48t2dyixKiH9
        XjGwSylQdCWZz9BbVkYIeJE=
X-Google-Smtp-Source: ABdhPJxlvyqilgdH1o27x6VJAY1YQ0TW4Ua3qooVBz9Izd6zA7hKwEZCPS860qjC1oNhpf1U3Oe5dQ==
X-Received: by 2002:a19:c6cc:: with SMTP id w195mr1542377lff.24.1602532690551;
        Mon, 12 Oct 2020 12:58:10 -0700 (PDT)
Received: from grain.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id m11sm649927lfa.112.2020.10.12.12.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 12:58:09 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 3417A1A032A; Mon, 12 Oct 2020 22:58:08 +0300 (MSK)
Date:   Mon, 12 Oct 2020 22:58:08 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v14 03/26] x86/fpu/xstate: Introduce CET MSR XSAVES
 supervisor states
Message-ID: <20201012195808.GD14048@grain>
References: <20201012153850.26996-1-yu-cheng.yu@intel.com>
 <20201012153850.26996-4-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012153850.26996-4-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 12, 2020 at 08:38:27AM -0700, Yu-cheng Yu wrote:
...
>  /*
>   * x86-64 Task Priority Register, CR8
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 038e19c0019e..705fd9b94e31 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -38,6 +38,9 @@ static const char *xfeature_names[] =
>  	"Processor Trace (unused)"	,
>  	"Protection Keys User registers",
>  	"unknown xstate feature"	,
> +	"Control-flow User registers"	,
> +	"Control-flow Kernel registers"	,
> +	"unknown xstate feature"	,
>  };
>  
>  static short xsave_cpuid_features[] __initdata = {
> @@ -51,6 +54,9 @@ static short xsave_cpuid_features[] __initdata = {
>  	X86_FEATURE_AVX512F,
>  	X86_FEATURE_INTEL_PT,
>  	X86_FEATURE_PKU,
> +	-1,		   /* Unused */
> +	X86_FEATURE_SHSTK, /* XFEATURE_CET_USER */
> +	X86_FEATURE_SHSTK, /* XFEATURE_CET_KERNEL */
>  };

Why do you need "-1" here in the array? The only 1:1 mapping is between
the names itselves and values, not indices of arrays so i don't understand
why we need this unused value. Sorry if it is a dumb questions and
been discussed already.
