Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC60227AAFD
	for <lists+linux-arch@lfdr.de>; Mon, 28 Sep 2020 11:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgI1Jlh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Sep 2020 05:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgI1Jlh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Sep 2020 05:41:37 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B550AC061755
        for <linux-arch@vger.kernel.org>; Mon, 28 Sep 2020 02:41:36 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z17so450729lfi.12
        for <linux-arch@vger.kernel.org>; Mon, 28 Sep 2020 02:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZVCu7z7Qfdh80dtpYoTWOuZ7uDL7n6GoxXa+kbtypQ=;
        b=ekuNYsG22huxHceVTvJlifPNoInqCCtf1OsuK8Z3cYs2SGNmiw0ZWmlvAYNIAWbubZ
         7aqEBM0E3MjkUWAoFeMFtJO2bMwrQ+Dzd3OM7NjooJzdN4baATTykcxO4dgN8rx1P/1d
         cl8/Er9Au7d9Vd+o/0HRygZ+7Is7GnryNuNeMPm4TA/WdQoWOYp/t5UNkbk3wjeYwNHn
         IG5W1IqrvpPF3v953WNic/t1//Y+CVopiTUS26MDYvVC30KJHLLEPFLgvUI2yXwp95S4
         aXoqlkpPf929Q37tPbwqi1wCNojiqOP5+ptAJ3DtXzzUY+mmxHWuOVpDLFNK8m3uOE7p
         qT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZVCu7z7Qfdh80dtpYoTWOuZ7uDL7n6GoxXa+kbtypQ=;
        b=nUP271V7wT59IxGZOcMlQlmqnjxigkood/VN4U9v+zHMUGLakHlUlyjryUxQkqkyRt
         97G0m4QimP/6WoI2ZjHo7cVaLCz9aoatqKsFigXntt3pa1aF37cMeLoFhBe5Zz+fr5QG
         mIw5zwcSOd1VG5tVOE3dsvKjI0niOiKJfzyrjUtn6fMUfOOAOIRM53sdAPy/A3N0sT8q
         Cii8bqK6ovR32RfkvcptvS/sPKbKuDzNe33mhr6pIe8BtYx7ECxPYDMdI4VYOlFoV1YD
         /8fHB+wKXDIzyv4/7q0ZOQI2qY3qNQANFb7wz6juZzCfCeJEVSs5B7QO+zY5yu4pbaUL
         Q/LA==
X-Gm-Message-State: AOAM530tBSmEGPI8xQAlR3pDjnT7XWSDgMyFHJ79w75TFjKquQHkj2pV
        Xxcc/p7pCn0pBrIYl7M4CTQuEl+3tdKEH+Hadjlhpw==
X-Google-Smtp-Source: ABdhPJyJ+3HpnJ5ROQcBj1BJr6Uk0kh/FIsy2OY0Djcl+BzwAUTCIzLs9UnE4ppTj6Cqd1mIsVLbf80kq6Ia1PW5xNQ=
X-Received: by 2002:a19:520b:: with SMTP id m11mr161552lfb.502.1601286095157;
 Mon, 28 Sep 2020 02:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200907153701.2981205-1-arnd@arndb.de> <20200907153701.2981205-5-arnd@arndb.de>
In-Reply-To: <20200907153701.2981205-5-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Sep 2020 11:41:24 +0200
Message-ID: <CACRpkdYkL2=gkBvbHO514rnppLdHgsXwi0==6Ovq43kSZqEvUQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] ARM: syscall: always store thread_info->syscall
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Russell King <rmk@arm.linux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

help me out here because I feel vaguely stupid...

On Mon, Sep 7, 2020 at 5:38 PM Arnd Bergmann <arnd@arndb.de> wrote:

>  {
> +       if (IS_ENABLED(CONFIG_OABI_COMPAT))
> +               return task_thread_info(task)->syscall & ~__NR_OABI_SYSCALL_BASE;

Where __NR_OABI_SYSCALL_BASE is
#define __NR_OABI_SYSCALL_BASE       0x900000

So you will end up with sycall number & FF6FFFFF
masking off bits 20 and 23.

I suppose this is based on this:

>         bics    r10, r10, #0xff000000
> +       str     r10, [tsk, #TI_SYSCALL]

OK we mask off bits 24-31 before we store this.

>         bic     scno, scno, #0xff000000         @ mask off SWI op-code
> +       str     scno, [tsk, #TI_SYSCALL]

And here too.

>         eor     scno, scno, #__NR_SYSCALL_BASE  @ check OS number

And then happens that which will ... I don't know really.
Exclusive or with 0x9000000 is not immediately intuitive
evident to me, I suppose it is for everyone else... :/

I need some idea how this numberspace is managed in order to
understand the code so I can review it, I guess it all makes perfect
sense but I need some background here.

Thanks,
Linus Walleij
