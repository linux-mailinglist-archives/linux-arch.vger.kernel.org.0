Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB14C4D98DF
	for <lists+linux-arch@lfdr.de>; Tue, 15 Mar 2022 11:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347129AbiCOKgU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Mar 2022 06:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347110AbiCOKgT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Mar 2022 06:36:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB2E31374;
        Tue, 15 Mar 2022 03:35:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q14so28261797wrc.4;
        Tue, 15 Mar 2022 03:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=6kmDLxEDF1QGDB/FLS/358IHP43jGlaqFUhg/QX1G3A=;
        b=D23aK+AJAUiRqF+xeDEU6Ac0cb4UW/kYSNfcD3j0d3j0c/eD1FDlXzoX6wbkQB6i7E
         i4qQSMOmNpOo4bNM/p9JY8mOf7Kn7N9AMgd0FIxsvTNDidNIaIXn6+gLJ37Pl5zGacIt
         KGjxpVJPAYo7YTg1VkHyvfpMqTRa1e9xyWGKxw89FZb0OqrI2RfxGZJNiAxRYXxq72Yw
         FWmnAxmPrjz4S/HDefdlpPSMkKMQ5FcJbx7a/NFH++R9sGX9ezAoXD7oIuGZcB2PX4kY
         StPd+BA67BllpaOtoS7vWnjIUkg6kFgeVcQpmTYGaRbipVfi/sUOqoMQzmi0eD0ilVC+
         c1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:in-reply-to;
        bh=6kmDLxEDF1QGDB/FLS/358IHP43jGlaqFUhg/QX1G3A=;
        b=vS8yV/ObGBr0YCvr8+BRsVBSWS+yInjtrsnfUZ0KJf86tdywDdsGr/auE93rbXwDDT
         l7llRzrg4+6gWKG73pBQBPc1MbzyFNfm8x110EwZIsYdKxLoY0WoSkSCTGseCWvebaUP
         GMtGgDazQlg8Is+O5pQ7EHnHE2odGsc2H8lOL+/OUTeir68T+ZQ11VvB6dT8Hh2QsId0
         DgYmHj4hCLIZmAZXCSLPrR936txbCbJTPwvUFR4rtt+GuG9AxNbitDsSe5o6DmdI+d/p
         imD28JqJ89YUU6mFWNr/gmODQtz0UP4ZTsVImNZXhjsRKRhDh190dNYTWgD+81pO/IjZ
         eJuQ==
X-Gm-Message-State: AOAM532zStMLSCb/49UOCIWSF4rFoybpnqqqRK6CgWPdnbgIbq74lhgx
        x2c8g2ds5G8M5obXuyTV0bD0U24VWf4=
X-Google-Smtp-Source: ABdhPJzzazYsfRQIdWS6iPa5yy4rxV5xEbKMD6ewvXpB1bHkxSBa5gxFtgIO8l58dhPlewDO5NDl7Q==
X-Received: by 2002:a5d:6c69:0:b0:203:78af:48b2 with SMTP id r9-20020a5d6c69000000b0020378af48b2mr19842165wrz.123.1647340506260;
        Tue, 15 Mar 2022 03:35:06 -0700 (PDT)
Received: from gmail.com (0526F1FC.dsl.pool.telekom.hu. [5.38.241.252])
        by smtp.gmail.com with ESMTPSA id u7-20020a5d6da7000000b00203d9d1875bsm238154wrs.73.2022.03.15.03.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 03:35:05 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 15 Mar 2022 11:35:03 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [TREE] "Fast Kernel Headers" Tree -v3
Message-ID: <YjBr10JXLGHfEFfi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydm7ReZWQPrbIugn@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


This is -v3 of the "Fast Kernel Headers" tree, which is an ongoing rework 
of the Linux kernel's header hierarchy & header dependencies, with the dual 
goals of:

 - speeding up the kernel build (both absolute and incremental build times)
 
 - decoupling subsystem type & API definitions from each other
 
The fast-headers tree consists of over 25 sub-trees internally, spanning 
over 2,300 commits, which can be found at:

    git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master

There's various changes in -v3, and it's now ported to the latest kernel 
(v5.17-rc8).

Diffstat difference:

 -v2: 25332 files changed, 178498 insertions(+), 74790 deletions(-)
 -v3: 25513 files changed, 180947 insertions(+), 74572 deletions(-)

Thanks,

	Ingo
