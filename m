Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79329254CB8
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 20:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgH0SPd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 14:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgH0SPd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 14:15:33 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9235C06121B
        for <linux-arch@vger.kernel.org>; Thu, 27 Aug 2020 11:15:32 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 185so7482610ljj.7
        for <linux-arch@vger.kernel.org>; Thu, 27 Aug 2020 11:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Ln4YDv+McQTrVSBLkYMyzgo5ffLr7W4nh7mUMFYOZo=;
        b=GjsK/u6ib7N+ctD2EUfS3Yg2gOjkfLasSaGCU/YbFFT4pm7wC/mAUjkvSP+UBZidUg
         P75Y7Q+9vqNQMjHTBy6Jwr30jghzFLvVdhlC7Nn9Ui5WCs2KOmFbugeMsgtI/Xw61N8K
         QeupHGovYgcCrHWAn29zkzD17dqNMKZTBIjAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Ln4YDv+McQTrVSBLkYMyzgo5ffLr7W4nh7mUMFYOZo=;
        b=HAqUXLhD9UCCgR27CJtG7g3DmsCGVQHe6Wngfx9q6hxStgNU6iSMuq5TEbzwJK2y6L
         w4EM4/EwD0mrXop+w0lTuZai9wnBLTWOWPY2K2p9zVW+lvY/Ov+mxbGXQou2hltRWyLv
         t5MQkma5bVWl69pqDmYCjt7Wjk6ARiMB2e3eOlfdJ+HZvODFtoIrkKja29pV4ohtuGpe
         zIvp+pSRYojiqogw0VNdpMuNb5mh0vOT9ULRCILJGZr/zd3GV2hdLRe/liEt5hGVdxY9
         iIgsbQ6lGV3EgW0fik03MbUXq74YHLopXzCjNjV2G1/BoYKO1XU849cbNGrvT+3LEjVo
         2iPw==
X-Gm-Message-State: AOAM530NpjKLloDM76vy9rpHiDQ041M9htMGvIKCEtIbJCCNxNYRIO7u
        OufguIyq8b/X7QtTWFqmWldlRwkrLJG03Q==
X-Google-Smtp-Source: ABdhPJxpNs/yBajrXSKLPmjkC+BcXdRNoPAI8KS374McQQTKxr3wYOAVQO19NKc0b1Wwwh95wKnWow==
X-Received: by 2002:a2e:7f1d:: with SMTP id a29mr10911120ljd.424.1598552130786;
        Thu, 27 Aug 2020 11:15:30 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id e14sm621450ljj.120.2020.08.27.11.15.28
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 11:15:28 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id g6so7469591ljn.11
        for <linux-arch@vger.kernel.org>; Thu, 27 Aug 2020 11:15:28 -0700 (PDT)
X-Received: by 2002:a2e:92d0:: with SMTP id k16mr9604351ljh.70.1598552128279;
 Thu, 27 Aug 2020 11:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200827150030.282762-1-hch@lst.de> <20200827150030.282762-9-hch@lst.de>
In-Reply-To: <20200827150030.282762-9-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Aug 2020 11:15:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxeN+KrCB2TyC5s2RWhz-dWWO8vbBwWcCiKb0+8ipayw@mail.gmail.com>
Message-ID: <CAHk-=wjxeN+KrCB2TyC5s2RWhz-dWWO8vbBwWcCiKb0+8ipayw@mail.gmail.com>
Subject: Re: [PATCH 08/10] x86: remove address space overrides using set_fs()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 27, 2020 at 8:00 AM Christoph Hellwig <hch@lst.de> wrote:
>
>  SYM_FUNC_START(__get_user_2)
>         add $1,%_ASM_AX
>         jc bad_get_user

This no longer makes sense, and

> -       mov PER_CPU_VAR(current_task), %_ASM_DX
> -       cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
> +       LOAD_TASK_SIZE_MAX
> +       cmp %_ASM_DX,%_ASM_AX

This should be

        LOAD_TASK_SIZE_MAX_MINUS_N(1)
        cmp %_ASM_DX,%_ASM_AX

instead (and then because we no longer modify _ASM_AX, we'd also
remove the offset on the access).

>  SYM_FUNC_START(__put_user_2)
> -       ENTER
> -       mov TASK_addr_limit(%_ASM_BX),%_ASM_BX
> +       LOAD_TASK_SIZE_MAX
>         sub $1,%_ASM_BX

It's even more obvious here. We load a constant and then immediately
do a "sub $1" on that value.

It's not a huge deal, you don't have to respin the series for this, I
just wanted to point it out so that people are aware of it and if I
forget somebody else will hopefully remember that "we should fix that
too".

                   Linus
