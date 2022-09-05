Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948FE5AD9B8
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 21:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiIEThD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 15:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiIEThB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 15:37:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A755070A
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 12:36:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gb36so18823147ejc.10
        for <linux-arch@vger.kernel.org>; Mon, 05 Sep 2022 12:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=O2DU+lG5b8y7EdeArqWJ87q1UTfo/e0aDc12mvcyfm8=;
        b=P29yBnD7GQ40f4AnWx+txwzRZ0KpX90wZtHMGAf8ZJJ2h6fpyvstil2DDR8hDCsmpq
         7ptdSkvLvHefmcVrsgvme3esqjzDTaw14yJ+gL5pJID33afB8bnjs4rmpV+DNNhJALfu
         7KxCw6T1NqTnUmk8JBn7NDfjM/0kY1ZPWZSR+HQUczueK9H8zKMEGgLtPevK1eCZb0n7
         Im3mDKIQB8IwJfzmXaWmZQtvjQmFMjt6th4ldisOxeBgx81ofhzZy6VB1vgoEUhuI44J
         2/V1tS588Tu6yhSTzSq2/J367DW3T6S7udDnzHYRVQeOyLwCuve7KE2Nmp3mqCKLwj2f
         dJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=O2DU+lG5b8y7EdeArqWJ87q1UTfo/e0aDc12mvcyfm8=;
        b=bkCIi58axsIVtXfCX9jnH6W64sjYYImwC+52nwxmfLQNx96YYsiEGlT4UZa1jIh/Gq
         oRlEWYm8VLza/+NUrEHwE51fjz3AkUVF358e4rKtuL0BlkHsZiVab7pW40vP0y5o17GC
         0y+wV2hFaw7fqDLrryTTFN5r5FXRAmjFXhxi+1XSWpEgqQ3/jAc4hBX6GZmZYr/6mKwj
         wQDvFogltQNCwIAk9W4gC5KZvaI3OF7LmW4y+4hgnyLTyqFSb5WZSOE1sLgltiNvQQWv
         Ju0wbJj6uNR9fqDz1kvnZuwAfigpG6Ixn9GL2dAFAU5ZghZWYr6Pbjpzr2i4c2orkiRR
         UuYg==
X-Gm-Message-State: ACgBeo0UFEE0dygWs9sSSP059hk5AkhvsCOn31HH6SsTYvrY4Zd2vqOm
        nzZdlbO9SDNSyImPMD2SXVF2GGoQdYoi8bkszveYwg==
X-Google-Smtp-Source: AA6agR5J15ANtu9dvLuy1kAEBMKj6rtt3G7LSxHAClbzxJvyPEjQKVrPT2inAKr8pFO4IeppvsxndwcJISbTJqlctG4=
X-Received: by 2002:a17:906:cc5a:b0:741:5240:d91a with SMTP id
 mm26-20020a170906cc5a00b007415240d91amr30533842ejb.500.1662406617460; Mon, 05
 Sep 2022 12:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220831195553.129866-1-linus.walleij@linaro.org>
In-Reply-To: <20220831195553.129866-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Sep 2022 21:36:46 +0200
Message-ID: <CACRpkdZzBu4ZmQFvkiyD8ZefZL9FNNKdWgUYTzHhH0ttStUE6g@mail.gmail.com>
Subject: Re: [PATCH v2] sparc: Fix the generic IO helpers
To:     "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     sparclinux@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-arch@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 31, 2022 at 9:57 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> This enables the Sparc to use <asm-generic/io.h> to fill in the
> missing (undefined) [read|write]sq I/O accessor functions.
>
> This is needed if Sparc[64] ever wants to uses CONFIG_REGMAP_MMIO
> which has been patches to use accelerated _noinc accessors
> such as readsq/writesq that Sparc64, while being a 64bit platform,
> as of now not yet provide.
>
> This comes with the requirement that everything the architecture
> already provides needs to be defined, rather than just being,
> say, static inline functions.
>
> Bite the bullet and just provide the definitions and make it work.
> Compile-tested on sparc32 and sparc64.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/linux-arm-kernel/202208201639.HXye3ke4-lkp@intel.com/
> Cc: David S. Miller <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:

This might be a candidate for the arch tree as well, I have seen that most
code merged into arch/sparc these days seem to come through other
trees than the sparc tree, which has not been updated for 18 months.

Yours,
Linus Walleij
