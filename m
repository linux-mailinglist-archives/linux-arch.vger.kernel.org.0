Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C94F53D5D7
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jun 2022 08:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiFDGiX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 4 Jun 2022 02:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiFDGiX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 4 Jun 2022 02:38:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B823C13CEC;
        Fri,  3 Jun 2022 23:38:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CEA060AD9;
        Sat,  4 Jun 2022 06:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E12BC3411D;
        Sat,  4 Jun 2022 06:38:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="d7u6WpIB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654324695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MFuIkM3knB2UIHMtd9NXy9Rob/skTOiBt7kbiwzBuWQ=;
        b=d7u6WpIB+eBAIBLKWeKxe/F5zf/XGJtvcGAwkmvneRUb80jqMwPWJnL35MyFoFj5KILVVs
        6W/rbl/OK0+X2HTZrIEFQzCOuJpTWIMIGG9mDJPyXdLJXczUudWyUDYzV7d7EysI0x73b5
        2cR3jPNSuCguO1A2oatul2XH8dSPCvk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 937e5903 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 4 Jun 2022 06:38:15 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-30c2f288f13so101018767b3.7;
        Fri, 03 Jun 2022 23:38:15 -0700 (PDT)
X-Gm-Message-State: AOAM532XIM/aJ/arNzLSbo0HRweXioYKrX2HyRQl6gQJmhbA00ND3wY1
        9Sn/iQeS1PkOHJhaELaWKrvyXVpYivb515afSts=
X-Google-Smtp-Source: ABdhPJxjwjWtA5f8qIVDzL92JOa+bpONq8VmGkccqIggRjkkiDlzYaoiWDbxXuFq5VkopcUJVWJHikqgmbcSWfXB3TE=
X-Received: by 2002:a0d:e28d:0:b0:30c:572b:365c with SMTP id
 l135-20020a0de28d000000b0030c572b365cmr15693818ywe.499.1654324692093; Fri, 03
 Jun 2022 23:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220603072053.35005-1-chenhuacai@loongson.cn>
 <20220603072053.35005-11-chenhuacai@loongson.cn> <YpoPZjJ/Adfu3uH9@zx2c4.com>
 <CAK8P3a0iASLd768imA8pG32Cc2RsqG8-ZyN+Obcg+PksVj1FJg@mail.gmail.com>
 <YpoURwkAbqRlr7Yi@zx2c4.com> <e78940bc-9be2-2fe7-026f-9e64a1416c9f@xen0n.name>
 <CAAhV-H6wMBV4rgbEx01+Zm+CPQxQYbe1CTuwB95B_JYwGaytFw@mail.gmail.com>
In-Reply-To: <CAAhV-H6wMBV4rgbEx01+Zm+CPQxQYbe1CTuwB95B_JYwGaytFw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 4 Jun 2022 08:38:01 +0200
X-Gmail-Original-Message-ID: <CAHmME9rpyoXkOXCedGKtX07ASZQo+nHrEPjMDyvT9Y4jZos3SQ@mail.gmail.com>
Message-ID: <CAHmME9rpyoXkOXCedGKtX07ASZQo+nHrEPjMDyvT9Y4jZos3SQ@mail.gmail.com>
Subject: Re: [PATCH V15 10/24] LoongArch: Add other common headers
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Huacai,

On Fri, Jun 3, 2022 at 4:36 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> As the PR has already been tagged before your reply, this will get
> fixed in rc2. Thanks for your review again.

Sent in a patch for that here:
https://lore.kernel.org/lkml/20220604063525.397826-1-Jason@zx2c4.com/

Jason
