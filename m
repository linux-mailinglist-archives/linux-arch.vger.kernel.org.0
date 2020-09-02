Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F22725A40C
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 05:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgIBDaf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 23:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgIBDae (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 23:30:34 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18C4C061244;
        Tue,  1 Sep 2020 20:30:32 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id u3so3136687qkd.9;
        Tue, 01 Sep 2020 20:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qMRTb7o6tIn+KisH8T8lV1168u11aqmlDTHJpu+vCTQ=;
        b=TH5fADQT02n8Tst99kTzXf6CYfr3NTZcx0AOksGt5slcYgd9BZI5X2LIuUq+vlm4Cc
         6xjTqTf7rcMdzJI0tzNTp7cHAOIOKOlZAFoVy4xGau/ZOLobafVUEIqzK9P8v+2ea3EK
         s61PPtwdULj5Ej+PH+FzTbG9lSaYZWp5Y9K50ji24S9mE9wJrb/dXMyl3KwF8vyA7w7p
         rbpdXsaENmoF5JmYeDV4tH9plQnXjZk9lSr+SHl0Jo3BviKRnbKNNRbDw+YZNy9Itv11
         PeqykzvkVuH+BG9DoxX+Q7VRt0c59Dq/6OSw0mNYrY0E+gRaL6dfZ6e2Ldc1j0oMnCVS
         GLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qMRTb7o6tIn+KisH8T8lV1168u11aqmlDTHJpu+vCTQ=;
        b=g4YqmzViaGLpVosVIxBlToAKLQSuns/hFIvyfGr27/DDoYC4JrKAVOoLXKZ8mLMUaT
         8rI6mf+/y0KXGZA913G2lgt7fK2Bgc4Inzbzew0/H6XHB3Y7rr0C3v/jt6DJykjeQC0/
         VIxKHPJkmkP9MAPrlcC3Gxt8ql7IFsd2xrxhUojL5rM4mbSjtUwjbuH563cLF0I14awO
         8plJjXPVNLY+OvDW/9HhheReCtncbz5qwGPDyfPTgaZGKjfM0S3ECoMKu3bNmqSfRfQ1
         B0O7MJ7mS4vWpl49dXVzfGF+SF3WL0Wm1JO1XwFCZJ18asltNYhEFc202DgjwWmOP169
         L73g==
X-Gm-Message-State: AOAM530NZSyWFxlXXUtwuC73N5/1If1fb+8d70GOoaRxAsP/74AlkUE1
        ex805/LiHhia/eVWuPFaKUc=
X-Google-Smtp-Source: ABdhPJwEdn9HbPItGUvHj9yO+mznmI7gOcG1q8yS28wb6gaxPhht0Q+iGUkYabV6q6GKaEYv0gJbBA==
X-Received: by 2002:a05:620a:2096:: with SMTP id e22mr5204355qka.177.1599017431655;
        Tue, 01 Sep 2020 20:30:31 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id k48sm4335084qtk.44.2020.09.01.20.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2020 20:30:10 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id C26DE27C0054;
        Tue,  1 Sep 2020 23:30:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 01 Sep 2020 23:30:09 -0400
X-ME-Sender: <xms:wBFPX3NzlpjwtBY4EJ9Vo1DpIzeZ9djSqDYyZs3QXRCygAQueXerBg>
    <xme:wBFPXx-WwpMENqbc2cWCj3ZRbqfzMalM4Ii2yuKF6x20oKpZaEHYG-Tc71TpeHRpU
    m2NaUWLE8D4oIenrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefkedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:wBFPX2QdrvqYHYFOY5RNAO3SxklCFWCRbV4Kts2GNCQrTVDp8D9GDQ>
    <xmx:wBFPX7vHnT94bpNT8kZlxzBcWvnMxWgh19WD6BC3Fdv-tTUoPqCdSA>
    <xmx:wBFPX_fQR15FDiGU2WP5D54xIve0z8c3zQ-_lqrScj6qeCiHriYzWg>
    <xmx:wRFPX6_YnMsWOtfcnnRfKBu131T7Rsy5qclM0NqIzfqcPo8T0kIFOyaU_10>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 34A95328005A;
        Tue,  1 Sep 2020 23:30:08 -0400 (EDT)
Date:   Wed, 2 Sep 2020 11:30:06 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org, elver@google.com,
        andreyknvl@google.com, glider@google.com, dvyukov@google.com,
        cai@lca.pw, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH kcsan 18/19] bitops, kcsan: Partially revert
 instrumentation for non-atomic bitops
Message-ID: <20200902033006.GB49492@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200831181715.GA1530@paulmck-ThinkPad-P72>
 <20200831181805.1833-18-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831181805.1833-18-paulmck@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Paul and Marco,

The whole update patchset looks good to me, just one question out of
curiosity fo this one, please see below:

On Mon, Aug 31, 2020 at 11:18:04AM -0700, paulmck@kernel.org wrote:
> From: Marco Elver <elver@google.com>
> 
> Previous to the change to distinguish read-write accesses, when
> CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=y is set, KCSAN would consider
> the non-atomic bitops as atomic. We want to partially revert to this
> behaviour, but with one important distinction: report racing
> modifications, since lost bits due to non-atomicity are certainly
> possible.
> 
> Given the operations here only modify a single bit, assuming
> non-atomicity of the writer is sufficient may be reasonable for certain
> usage (and follows the permissible nature of the "assume plain writes
> atomic" rule). In other words:
> 
> 	1. We want non-atomic read-modify-write races to be reported;
> 	   this is accomplished by kcsan_check_read(), where any
> 	   concurrent write (atomic or not) will generate a report.
> 
> 	2. We do not want to report races with marked readers, but -do-
> 	   want to report races with unmarked readers; this is
> 	   accomplished by the instrument_write() ("assume atomic
> 	   write" with Kconfig option set).
> 

Is there any code in kernel using the above assumption (i.e.
non-atomicity of the writer is sufficient)? IOW, have you observed
anything bad (e.g. an anoying false positive) after applying the
read_write changes but without this patch?

Regards,
Boqun

> With the above rules, when KCSAN_ASSUME_PLAIN_WRITES_ATOMIC is selected,
> it is hoped that KCSAN's reporting behaviour is better aligned with
> current expected permissible usage for non-atomic bitops.
> 
> Note that, a side-effect of not telling KCSAN that the accesses are
> read-writes, is that this information is not displayed in the access
> summary in the report. It is, however, visible in inline-expanded stack
> traces. For now, it does not make sense to introduce yet another special
> case to KCSAN's runtime, only to cater to the case here.
> 
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Daniel Axtens <dja@axtens.net>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: <linux-arch@vger.kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  .../asm-generic/bitops/instrumented-non-atomic.h   | 30 +++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/include/asm-generic/bitops/instrumented-non-atomic.h b/include/asm-generic/bitops/instrumented-non-atomic.h
> index f86234c..37363d5 100644
> --- a/include/asm-generic/bitops/instrumented-non-atomic.h
> +++ b/include/asm-generic/bitops/instrumented-non-atomic.h
> @@ -58,6 +58,30 @@ static inline void __change_bit(long nr, volatile unsigned long *addr)
>  	arch___change_bit(nr, addr);
>  }
>  
> +static inline void __instrument_read_write_bitop(long nr, volatile unsigned long *addr)
> +{
> +	if (IS_ENABLED(CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC)) {
> +		/*
> +		 * We treat non-atomic read-write bitops a little more special.
> +		 * Given the operations here only modify a single bit, assuming
> +		 * non-atomicity of the writer is sufficient may be reasonable
> +		 * for certain usage (and follows the permissible nature of the
> +		 * assume-plain-writes-atomic rule):
> +		 * 1. report read-modify-write races -> check read;
> +		 * 2. do not report races with marked readers, but do report
> +		 *    races with unmarked readers -> check "atomic" write.
> +		 */
> +		kcsan_check_read(addr + BIT_WORD(nr), sizeof(long));
> +		/*
> +		 * Use generic write instrumentation, in case other sanitizers
> +		 * or tools are enabled alongside KCSAN.
> +		 */
> +		instrument_write(addr + BIT_WORD(nr), sizeof(long));
> +	} else {
> +		instrument_read_write(addr + BIT_WORD(nr), sizeof(long));
> +	}
> +}
> +
>  /**
>   * __test_and_set_bit - Set a bit and return its old value
>   * @nr: Bit to set
> @@ -68,7 +92,7 @@ static inline void __change_bit(long nr, volatile unsigned long *addr)
>   */
>  static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
>  {
> -	instrument_read_write(addr + BIT_WORD(nr), sizeof(long));
> +	__instrument_read_write_bitop(nr, addr);
>  	return arch___test_and_set_bit(nr, addr);
>  }
>  
> @@ -82,7 +106,7 @@ static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
>   */
>  static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
>  {
> -	instrument_read_write(addr + BIT_WORD(nr), sizeof(long));
> +	__instrument_read_write_bitop(nr, addr);
>  	return arch___test_and_clear_bit(nr, addr);
>  }
>  
> @@ -96,7 +120,7 @@ static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
>   */
>  static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
>  {
> -	instrument_read_write(addr + BIT_WORD(nr), sizeof(long));
> +	__instrument_read_write_bitop(nr, addr);
>  	return arch___test_and_change_bit(nr, addr);
>  }
>  
> -- 
> 2.9.5
> 
