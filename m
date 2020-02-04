Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56630152229
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2020 22:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbgBDV7O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Feb 2020 16:59:14 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36331 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgBDV7O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Feb 2020 16:59:14 -0500
Received: by mail-yw1-f65.google.com with SMTP id n184so369355ywc.3;
        Tue, 04 Feb 2020 13:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EF7q5sA089XDGika52Fy1O+7Ot7CBhBKLfoQVIAAsyg=;
        b=QF3KNMZBmanFxfNF2rJXBwK8KmbYetam92nRxQP5I3z2qW4Ut1YxQbYPpb9X8biApK
         uTTNnBpxwolHD9WCUTHEevyDUFYKWmgho+wyXcZhwRiYY9c5WluLdCt7227VR6GHqnBi
         6xKx2CqHnbihTGsMNg/bnHTVaS5VFzg/5Nu/w8/ZC++ai8JWuPn3/1Zabc4Ox/ko37YV
         k7UZHE/fCJKvEM9n5dRU2VynZljRYy248RsaYZfLlRZhmcjQ1qmjCIQm33Rnx9f00vMV
         VQgxG69toSn5OWCUod9cMu8JIauYd/BwSDN+S7wgU/NFZnZ4vCHfiZfD2y/cm3YwQ00t
         jFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EF7q5sA089XDGika52Fy1O+7Ot7CBhBKLfoQVIAAsyg=;
        b=RrKtTGnDAYzLBn8parxhSE1fuAYUp21vqYoC00vV/Ev5y8DhgIt+pvZNJc6T51FP6X
         EZI9lH8YRwzfp73arqqIIlsNR/3d73aqCIQIgv6hyuiAZc5GP79DMueaANdwW8IA7vHo
         EQK0W89Rc/WQKH6jgirQHPTF9oEK1pA9s/RWXg7wPFemj+H1mOXA+vv8zOGhcqWIuuk8
         yVEKuQy57CRM86O2x8T3XvthkqeIvwZs/hJLXexyDLn1eOpgXYC+m96ztgW506pjsZ8F
         R6Ux9Yc6eV/GpqT9iJJB8pTxZPOqYXjSb+pzCRNVBMvrKQsiA1V+1DH/8upU0I8C+qGd
         W1UQ==
X-Gm-Message-State: APjAAAWRJoociRbLoa6vmuhRhfVrR6fUeAVghJRkFUXIxklZp7/QFodr
        2djn5ZVFebRDZy72pcpnliE=
X-Google-Smtp-Source: APXvYqwJ2EAsNZ9FZ2jLWATXqX9SqwVTGIuftOVn5FvI8hEdSoKXkxO/sqoUOXNjC3ah9pvXsAGSLA==
X-Received: by 2002:a81:7c07:: with SMTP id x7mr7164607ywc.291.1580853553316;
        Tue, 04 Feb 2020 13:59:13 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id d66sm10310686ywc.16.2020.02.04.13.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Feb 2020 13:59:12 -0800 (PST)
Subject: Re: [PATCH v2 2/7] arch: um: add linker section for KUnit test suites
To:     Brendan Higgins <brendanhiggins@google.com>, jdike@addtoit.com,
        richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de,
        keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20200130230812.142642-1-brendanhiggins@google.com>
 <20200130230812.142642-3-brendanhiggins@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <e060bdfc-5cdb-fb62-48b0-cc54c7bc72ce@gmail.com>
Date:   Tue, 4 Feb 2020 15:59:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200130230812.142642-3-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/30/20 5:08 PM, Brendan Higgins wrote:
> Add a linker section to UML where KUnit can put references to its test
> suites. This patch is an early step in transitioning to dispatching all
> KUnit tests from a centralized executor rather than having each as its
> own separate late_initcall.

All architectures please.

The early versions of Kunit documented reliance on UML.  Discussion lead to
the conclusion that real architectures and real hardware would be supported.

This like this are what make me reluctant to move devicetree unittests to
KUnit.

Can you please add a section to the KUnit documentation that lists things
like the expectations, requirements, limitations, etc for a test case that
is run by KUnit?  Some examples that pop to mind from recent discussions
and my own experiences:

  - Each test case is invoked after late_init is complete.
      + Exception: the possible value of being able to run a unit test
        at a specific runlevel has been expressed.  If an actual unit
        test can be shown to require running earlier, this restriction
        will be re-visited.

  - Each test case must be idempotent.  Each test case may be called
    multiple times, and must generate the same result each time it
    is called.
      + Exception 1: a test case can be declared to not be idempotent
        [[ mechanism TBD ]], in which case KUnit will not call the
        test case a second time without the kernel rebooting.
      + Exception 2: hardware may not be deterministic, so a test that
        always passes or fails when run under UML may not always to
        so on real hardware.  <--- sentence copied from
        Documentation/dev-tools/kunit/usage.rst
          [[ This item and 1st exception do not exist yet, but will exist
          in some form if the proposed proc filesystem interface is
          added. ]]

  - KUnit provides a helpful wrapper to simplify building a UML kernel
    containing the KUnit test cases, booting the UML kernel, and
    formatting the output from the test cases.  This wrapper MUST NOT
    be required to run the test cases or to determine a test result.
    The formatting may provide additional analysis and improve
    readability of a test result.

  - .... There is more that belongs here, but I'm getting side tracked
    here, when I'm trying to instead convert devicetree unittests to
    KUnit and want to get back to that.


-Frank

> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  arch/um/include/asm/common.lds.S | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
> index 7145ce6999822..eab9ceb450efd 100644
> --- a/arch/um/include/asm/common.lds.S
> +++ b/arch/um/include/asm/common.lds.S
> @@ -52,6 +52,10 @@
>  	CON_INITCALL
>    }
>  
> +  .kunit_test_suites : {
> +	KUNIT_TEST_SUITES
> +  }
> +
>    .exitcall : {
>  	__exitcall_begin = .;
>  	*(.exitcall.exit)
> 

