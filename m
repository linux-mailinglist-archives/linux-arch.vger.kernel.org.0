Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50D8782990
	for <lists+linux-arch@lfdr.de>; Mon, 21 Aug 2023 14:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbjHUMxl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Aug 2023 08:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjHUMxl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Aug 2023 08:53:41 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E2DCC
        for <linux-arch@vger.kernel.org>; Mon, 21 Aug 2023 05:53:39 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a3de5f231so629301b3a.0
        for <linux-arch@vger.kernel.org>; Mon, 21 Aug 2023 05:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692622418; x=1693227218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FGj7cgUeosSqTN/BBHBDpq4ZyUn/x93LQfy/ClJCFOc=;
        b=kyWX9hSLpAVOja1750OXW/QVKio4MmIVBBfRwhH6n/n9t+blozapD0mxyh02Dn7QWy
         U8B3x0hIcNQPaIOb69glmycvy9xsWk5i00uLFy3iAwWUsoCWOM/6rEmHPj/y2vPT3IR8
         43ZBusyxagmEdEWUZD7G3j1U+bUd31oBHxMETewPTlwhl4eZnvmgRfsNVeX7sZ24MDKS
         ZnAG0p/YCbCuOaQSWJFFKGXrwVU7FNSjkFB2/NsY6gya2dfvDjceZavWXbm3GGpoiUKT
         o1MCjctSze9XfjOwEWS5DFwWEZVNCzoJsJ2sMBiJ5QIwrVVxIfso+zQoUd/kQzexbAgl
         6YGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692622418; x=1693227218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGj7cgUeosSqTN/BBHBDpq4ZyUn/x93LQfy/ClJCFOc=;
        b=jsJsxHRGKjCVQ3jOKXz0g7rmbv05SSxwn6vSsf2sqsPBP6/zhIpHVKtQZG9xUJJkF3
         T3KnlcXsgTnJ8dx1vsQKfNU3ijYSRALRN1V9eF43er3dsukCO1gudjIwPtT1N0Rbkq/m
         dWgNofWv6p2EgC0mcPskIln5gsMtgvKzGj0MtPdJ0Kikapb/Fxor8f5QcH1PxbokZwOg
         cHMSPs3TK2Zv5lKxdjMDj66AUTzdX1GmdH4HcBe7TUNa8pJimfaEiHHZ8lT8Mg2TBaFN
         O4l4VkxIMRENipIjrL9vhDOECeq3mC4JTMq0Kir+IxdMaJeJntfmkrWyqBVZmIC8Qvb4
         dnEQ==
X-Gm-Message-State: AOJu0Yw9kumJPkvqfD1ag3Sb3aCHCNHI15uj55bUvJ7ZNWxJDC75NIDm
        4T6/K1AHT6tGZnl1Ffq60WuYsg==
X-Google-Smtp-Source: AGHT+IGe4iVmkOrwuPWAugYbuiVpJRW6VeHjDTj1eIWYsr7cFWnlIOuVBua0w1tuWmu3DBw6edBQmQ==
X-Received: by 2002:a05:6a20:96ce:b0:131:f3a:4020 with SMTP id hq14-20020a056a2096ce00b001310f3a4020mr3477088pzc.33.1692622418516;
        Mon, 21 Aug 2023 05:53:38 -0700 (PDT)
Received: from leoy-huanghe.lan ([94.177.131.100])
        by smtp.gmail.com with ESMTPSA id q10-20020a17090311ca00b001b83dc8649dsm6942852plh.250.2023.08.21.05.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 05:53:38 -0700 (PDT)
Date:   Mon, 21 Aug 2023 20:53:22 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Gang Li <gang.li@linux.dev>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] docs/zh_CN: add zh_CN translation for
 memory-barriers.txt
Message-ID: <20230821125322.GB57731@leoy-huanghe.lan>
References: <214aed18-5df5-1014-b73d-a1748c0cca13@linux.dev>
 <20230819162526.GA274478@leoy-huanghe.lan>
 <f7eac106-abe4-aba1-14df-6c9d1bfdf3b3@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7eac106-abe4-aba1-14df-6c9d1bfdf3b3@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 21, 2023 at 02:39:15PM +0800, Gang Li wrote:
> Thanks for your review!
> 
> Your suggestions will be integrated into the next version(v2).
> 
> On 2023/8/20 00:25, Leo Yan wrote:
> > > +		|       |   :   |        |   :   |       |
> > > +		|       |   :   |        |   :   |       |
> > > +		| CPU 1 |<----->|  内存  |<----->| CPU 2 |
> > 
> > Unalignment caused by extra space around "内存".
> > 
> If using Chinese, it is impossible to align properly no matter
> how it is modified. If strict alignment is needed, the text in the
> charts should not be translated.

In my editor (vim), a Chinese character is two-width of English
character.  So you could see in above, I can simply remove a space for
alignment.

Anyway, if you have different editor or configuration, using either
langauge is fine for me.

Please expect I will have more review.

Thanks,
Leo
