Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861574F1D4D
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 23:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356048AbiDDVat (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 17:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379721AbiDDR7K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 13:59:10 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187E334BB9;
        Mon,  4 Apr 2022 10:57:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bq8so21564259ejb.10;
        Mon, 04 Apr 2022 10:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LbauJjsyWfyUgbBcVSH3nfrWUAPSnEOj9xP8Lf2uMQc=;
        b=UG944lrMDFa46xw5mJXf3ez+C/4ds1SQUW0we6U55dMyhEZZ7nlsdZThXtaE9WVYzw
         Jfy65lB6zabNtWssWwmJd9J4VR9M1BfJ3erzVCwXOfMJvwO00IoZn6aX0ZU8yKagMGIT
         m/2efF5EDkOSKH0VH5qjuwCWsiLJzSMR4adJbiFDFKN/kHS+ytNGd9JEIUJq19xGg53J
         v1ltJfw45hvtfnHqx3K3wH9zjB7RDEdktgzKQk1rnDUvWEpt6DLklfwHBAJ+DIePeLH+
         MY/AkXEjvBAlDwOi3r2ud91AVrcXv7wmi2UD5ZZ37GjYD6yw1xgCIhWoiGcMF3s7g6z7
         +EDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LbauJjsyWfyUgbBcVSH3nfrWUAPSnEOj9xP8Lf2uMQc=;
        b=rMra94lm9dtre0XiDam+8gKrQWUORlRgC2DySihnWEZwxItH7/XnCXSQEQHlsf0lf9
         Q8epiWf3Sge21TEoK+ZWNG9P9CV+Lys1KP8IMdyFq7/SoW9UtK7RCl269DH5/EslDVpE
         xcgni/1t0VMjhoj/9bAuTsQJBd1U3X/khjo6G0kyPhNa0vUYxG89K7Yb9DqXdMUM4jKj
         BXc245x4cMdvjm0Aw2BKQCQ0Mw5VRujkN7fbmGz+ItvmcsRtWD01rvB5CCAxD2c/TOWH
         IIi97y84dpuRbhA2RuMiHlwfvR1jUzRshAHzNjBtL7K7aqBAQatdBRDxX6iOZiyMpDu4
         HMCw==
X-Gm-Message-State: AOAM533SuTLde/FWYCzsJNd3zL0P/H7eAd9XFppxa2ws/r+SgezJy+34
        6MySgJYmjwrtGxORsJewxgZKrq9QdQUT97bM+vE=
X-Google-Smtp-Source: ABdhPJz6VPW+goa8wHgWwkrJ9LveFINVQNnHYtPycIFT9TB7eAJpR4uYm/cUBC6mR+k35uivnhYmWtrACl6sZDox9MU=
X-Received: by 2002:a17:906:64ca:b0:6e0:1648:571c with SMTP id
 p10-20020a17090664ca00b006e01648571cmr1191237ejn.477.1649095032585; Mon, 04
 Apr 2022 10:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <Yib9F5SqKda/nH9c@infradead.org> <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
 <YkmWh2tss8nXKqc5@infradead.org> <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 4 Apr 2022 10:57:01 -0700
Message-ID: <CAMo8BfKgn0T5RtUTb89fPvygNJJYLy7r1=RZTmTTm=jiDfx1hQ@mail.gmail.com>
Subject: Re: [RFC PULL] remove arch/h8300
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On Mon, Apr 4, 2022 at 6:07 AM Arnd Bergmann <arnd@arndb.de> wrote:
> 1. xtensa nommu has does not compile in mainline and as far as I can
> tell never did

I have a different picture here. If you look at the logs at
  https://kerneltests.org/builders/qemu-xtensa-master/

there's a line for noMMU config in every one of them:
  Building xtensa:de212:kc705-nommu:nommu_kc705_defconfig ... running
............ passed

Please let me know if you observe any specific build/runtime issues.

-- 
Thanks.
-- Max
