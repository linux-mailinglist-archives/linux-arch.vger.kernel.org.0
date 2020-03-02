Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B49176391
	for <lists+linux-arch@lfdr.de>; Mon,  2 Mar 2020 20:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgCBTNG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Mar 2020 14:13:06 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36827 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgCBTNG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 14:13:06 -0500
Received: by mail-yw1-f67.google.com with SMTP id y72so899444ywg.3;
        Mon, 02 Mar 2020 11:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mIFlxE/JySt19RIWYxwHNwb3HC9osfe3tBJbDkn0JmQ=;
        b=iOcmh9U2SpCQZTN3rtimC117PPPAOrXM93cKejEN8uXy9++sWzJTn66xD3JhKYqCdL
         Qh5RGSXLicg8ujZyzI/3arjaj5Cq8vz8r2f0b/0qzFwK3nlisCFK+c8wrSVTuykHsE+l
         geQE1XDETtuaUQoGNS5GENhfJ9b2iD1GVOZIK8xk1yojUFIErPsOzdCrxSdzFVbPJrfl
         T4HSToRmor4sVqhplq61hYLufUW3in21aiI7uah3GXruyUM9JrdRzeuRuLxcNLZIP2Fc
         njWPsZ241en0w+zf1sXdp2pbhAYq+wRp7GstKaeDTVBUY1nOBMbLAx4gA34rzuJcKBTx
         FeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mIFlxE/JySt19RIWYxwHNwb3HC9osfe3tBJbDkn0JmQ=;
        b=niIW2Pb6iKmS9pecSnHVQfvxVCpvLPx0t3Bsv1YsMydRNliSJE9Hvh4TsUAKc8XH7j
         WAgSLXnlrkXlzK+NzoZ8wqb5aWjKDMDlihnN1Srm1utXu6See9e/lCT1rdbpfc6gUVCP
         EpU5/urCld5ejYsCV36ypaLBEW4RKo4iPfXypBoVi0lG0wNU0S4K5jeYkyt46WL3im8d
         4obKBc7PEUye/XEpJkMdMD4POvMR1z+1MIeachaxj/dHCreONby85m7Wxr/3o8fscKgz
         iH7Z7KHEhaPax1n05jtdvWDq9o2ciMy/jGgI0LhKisR7H7HEmCn86L1vrNgfop8Fd8r5
         wxdw==
X-Gm-Message-State: ANhLgQ1x2HufMM1ijo3Ig4mSeB1MEjopATr8aI+46iFI4Xpv4G3M+WoN
        8ZtEGpYdDnfvOOe88N2bd2Q=
X-Google-Smtp-Source: ADFU+vv5ReJzTi86aVhORww9FNCyaLWa8W8pTYbFIN0neS6k+QGXEeT7prIhRLQJEg/UaEjl1ytVTQ==
X-Received: by 2002:a5b:7ce:: with SMTP id t14mr517562ybq.492.1583176385179;
        Mon, 02 Mar 2020 11:13:05 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id a77sm1791541ywe.5.2020.03.02.11.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 11:13:04 -0800 (PST)
Subject: Re: [PATCH v3 4/7] init: main: add KUnit to kernel init
To:     Brendan Higgins <brendanhiggins@google.com>, jdike@addtoit.com,
        richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de,
        keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20200228012036.15682-1-brendanhiggins@google.com>
 <20200228012036.15682-5-brendanhiggins@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <e5de96ed-fb76-d322-fa40-c6e870e76c36@gmail.com>
Date:   Mon, 2 Mar 2020 13:13:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200228012036.15682-5-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/27/20 7:20 PM, Brendan Higgins wrote:
> Remove KUnit from init calls entirely, instead call directly from
> kernel_init().
> 
> Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  include/kunit/test.h | 9 +++++++++
>  init/main.c          | 4 ++++
>  lib/kunit/executor.c | 4 +---
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 8a02f93a6b505..8689dd1459844 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -197,6 +197,15 @@ void kunit_init_test(struct kunit *test, const char *name);
>  
>  int kunit_run_tests(struct kunit_suite *suite);
>  
> +#if IS_BUILTIN(CONFIG_KUNIT)

I suspected this would not work if a unittest was builtin but CONFIG_KUNIT
was set to module.

So I decided to experiment a bit to verify my assumptions (before applying
this patch series).  I tried to set CONFIG_KUNIT to module, then set
CONFIG_KUNIT_EXAMPLE_TEST to built in.  Kconfig does not let me do this
because KUNIT_EXAMPLE_TEST is inside a 'if KUNIT' in lib/kunit/Kconfig,
but instead switches KUNIT_EXAMPLE_TEST to a module, and warns that it
has done so.  This was a bit of a surprise, but seems reasonable.

So my next assumption is that the architecture of KUnit expects
each individual unit test config option to depend upon CONFIG_KUNIT.
If this is the case, please clearly document that requirement in
the KUnit documentation.


> +int kunit_run_all_tests(void);
> +#else
> +static inline int kunit_run_all_tests(void)
> +{
> +	return 0;
> +}
> +#endif /* IS_BUILTIN(CONFIG_KUNIT) */
> +
>  /*
>   * If a test suite is built-in, module_init() gets translated into
>   * an initcall which we don't want as the idea is that for builtins
> diff --git a/init/main.c b/init/main.c
> index ee4947af823f3..7875a5c486dc4 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -104,6 +104,8 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/initcall.h>
>  
> +#include <kunit/test.h>
> +
>  static int kernel_init(void *);
>  
>  extern void init_IRQ(void);
> @@ -1444,6 +1446,8 @@ static noinline void __init kernel_init_freeable(void)
>  
>  	do_basic_setup();
>  
> +	kunit_run_all_tests();
> +
>  	console_on_rootfs();
>  
>  	/*
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 6429927d598a5..b75a46c560847 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -11,7 +11,7 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
>  
>  #if IS_BUILTIN(CONFIG_KUNIT)
>  
> -static int kunit_run_all_tests(void)
> +int kunit_run_all_tests(void)
>  {
>  	struct kunit_suite * const * const *suites, * const *subsuite;
>  	bool has_test_failed = false;
> @@ -31,6 +31,4 @@ static int kunit_run_all_tests(void)
>  	return 0;
>  }
>  
> -late_initcall(kunit_run_all_tests);
> -
>  #endif /* IS_BUILTIN(CONFIG_KUNIT) */
> 

