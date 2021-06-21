Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BAE3AF90F
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jun 2021 01:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhFUXSO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Jun 2021 19:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhFUXSM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jun 2021 19:18:12 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDD6C061756
        for <linux-arch@vger.kernel.org>; Mon, 21 Jun 2021 16:15:56 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id d16so25383066lfn.3
        for <linux-arch@vger.kernel.org>; Mon, 21 Jun 2021 16:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=stNy8kLF5vctj8WXK363X+Ab+aWkvJsrhuAKRgNlaFY=;
        b=IL1c66HdRAXSPTueb6HvT7WAQ+hVTgraIpPVGrRtYIIPrdMk6idOyB+d7hgkhCbE/J
         WSDn2K6/KFlAr4ZepO/VZSbAHdCjsBoc9mInrjOrnW0t0J2Sklo0eRJQKmRh1FXkY2rP
         httftVRSDPt4omCrZhGPE4bzB66yBCzHc25jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=stNy8kLF5vctj8WXK363X+Ab+aWkvJsrhuAKRgNlaFY=;
        b=kPL7Mljn3aMCQQ6ULs7HLjmu1U9wLWzcc/pq4MlwLaXw4kFeP3gV+F6M3I9JXXJ+cj
         syOVi0WgdK8ODTw8V1wCHzBjeoNgCQHXd+pY8cY0yoEJFA1SwmdImT0ABHMt15wQO4KF
         hqchFhCC5oz442DatnbK0yhs3mV/xR/r8jIrVqkSKXehUgfCNTbCkO6Pr/V10JPzdn4A
         H1wr9tz9ar5kR3861eLAoozqFHEn4X+Dss1wUjofhV6XKvobuImIPvE13kY81rOCItkk
         YcRmpf3bFtrR+APba1hWa1kUJ7WMQPU+eQcMdX0fkl283S1VMOoSFhj+AT5qoFob6RRG
         u89w==
X-Gm-Message-State: AOAM5339E8HaChxdLe1gEsxV8zfGI1d4CFrRZFYFSKJzNLYGolMUcJ0k
        z0/Ju1eDpKQ1YTmTPxu0xmwgqyI97hDwfemmkGk=
X-Google-Smtp-Source: ABdhPJwZArWk+RsDg6TZhRJQkuV8//95aE9VE62TrfYo9RW9O5FKym/1boRDdO78mnZTaPexqw0Fjg==
X-Received: by 2002:a19:8c03:: with SMTP id o3mr465253lfd.499.1624317354356;
        Mon, 21 Jun 2021 16:15:54 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id n15sm2009230lft.169.2021.06.21.16.15.53
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 16:15:53 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id a11so19804529lfg.11
        for <linux-arch@vger.kernel.org>; Mon, 21 Jun 2021 16:15:53 -0700 (PDT)
X-Received: by 2002:a05:6512:15a2:: with SMTP id bp34mr498972lfb.40.1624317352941;
 Mon, 21 Jun 2021 16:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
 <87sg1lwhvm.fsf@disp2133> <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com> <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133> <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133> <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
 <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk> <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com> <87a6njf0ia.fsf@disp2133>
In-Reply-To: <87a6njf0ia.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Jun 2021 16:15:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
Message-ID: <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 21, 2021 at 1:04 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> For other ptrace_event calls I am playing with seeing if I can split
> them in two.  Like sending a signal.  So that we can have perform all
> of the work in get_signal.

That sounds like the right model, but I don't think it works.
Particularly not for exit(). The second phase will never happen.

              Linus
