Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7543AD631
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jun 2021 01:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhFSABg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Jun 2021 20:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbhFSABg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jun 2021 20:01:36 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CC4C061574
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 16:59:26 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x16so8922044pfa.13
        for <linux-arch@vger.kernel.org>; Fri, 18 Jun 2021 16:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=A2BKP9Hz/hQDKmMHUFJKsMFGEzNNYGC+i0f+o2u+SM4=;
        b=ha1Gp7Ph3ralXBPLAVuLxiTDJcxpYVzGjhw4FaNU0IWnpHlF8jZKOQANYYg3wGrXhZ
         GK/M4HZNP/OEAWk4euHTRHZ03ukS5jwiML7ZbjPGMhWYt5P9bhmbWaErSzGQ2kZMiJMw
         2zNbilUYhlOj36nz2qMhIgoOWWi6sEScdS8IwGOqZfTqHtO7a/CeV8t26SIjZF8j/qZX
         q/mTutXJkxjyhkMtkn28AuyjtjGoabC3gKZmjEZZXjk6Nz/AuvrU1cUA8uuvy+CkAa+a
         4j7NrPO1RSrtc56MGHdEGnWsMc55bP73aAuew8pPjsT7YxWVEpeezBYYzrZTsY0XfK3n
         598g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=A2BKP9Hz/hQDKmMHUFJKsMFGEzNNYGC+i0f+o2u+SM4=;
        b=KtEp5R6qWy6tPM5cxOqkfqtPJZtKtV2yDyKMGRgnLgxBn8beknvWgNkJsYidmrHHRq
         vLgOVFYhqRPvI/pzK1al0WQLRmNzHqC/146oF2QKkxv0WbYizlOBkN2ljeSdMZF+VxrB
         arfCCdsFMbLiO5yAoVvRHzWRvdqE2xF8rxcxGXggFmYAQOkR2k5r7Xh4NFbB3Mn3s3Is
         WRuAgylItMCdE+DCcve81Skve036bJ78cLke3q/soQg2g451HKJW2n7ZYO9Cpjx9xJo7
         2XjHA0tnLtWRO5fgo/5MnxrNI0Giud+Rd0irA1Y8GTk5m2RaAOR6f4hXWfG87B9R/7ei
         bTKw==
X-Gm-Message-State: AOAM531no8GToG9K17gMx55ihKkLe8jCGJfAh2WkJOp3WiPySLJBLI3k
        a1twsIdAuIL+YvUTy8SlmMPM50a/4yg=
X-Google-Smtp-Source: ABdhPJx9O8hg3d+DFIxyppbV8i2nKUdbCvFAPjxcJdec13A6fcBM1uK0/3/WEXxj4co2uwlSsUpYTQ==
X-Received: by 2002:a65:568c:: with SMTP id v12mr12548150pgs.88.1624060765925;
        Fri, 18 Jun 2021 16:59:25 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id b6sm9049466pfv.16.2021.06.18.16.59.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jun 2021 16:59:25 -0700 (PDT)
Subject: Re: [PATCH v2] m68k: save extra registers on more syscall entry
 points
To:     Linus Torvalds <torvalds@linux-foundation.org>
References: <1623979642-14983-1-git-send-email-schmitzmic@gmail.com>
 <CAHk-=whTKf6UFr6YneXsPU4=8dTs+eEX_861ugESTE3CmZtFUg@mail.gmail.com>
 <91865b90-c597-6119-5e14-dfe521a33489@gmail.com>
 <CAHk-=whjJappNkdsrmsRoA4QUiu0_NNqa9Y_ct0A21m2XT5+YA@mail.gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Schwab <schwab@linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <c1e6a7a9-b7e4-c683-c751-f9d920922a9a@gmail.com>
Date:   Sat, 19 Jun 2021 11:59:19 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whjJappNkdsrmsRoA4QUiu0_NNqa9Y_ct0A21m2XT5+YA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

Am 19.06.2021 um 11:38 schrieb Linus Torvalds:
> On Fri, Jun 18, 2021 at 3:34 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>>
>> Is your patch to copy_thread() to add the extra stack frame still needed?
>
> So it's been a long time since I did any m68k assembly, but I think
> the m68k patch for the PF_IO_WORKER thread case should look something
> like the attached.

OK, that answers my question, thanks!

>
> Note: my only m68k work was ever on the 68008, and used the Motorola
> syntax, not the odd Sun assembler syntax, so my m68k asm skills really
> aren't good.
>
> Put another way: I'd be surprised if the attached patch actually
> works, but I think it's fairly close. I tried to add comments to
> explain the code at least a bit.
>
> Hmm?

I'll give it a spin (on the emulator).

Cheers,

	Michael

>
>          Linus
>
