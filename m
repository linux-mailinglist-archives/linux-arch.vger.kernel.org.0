Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D56641C76F
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 16:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344791AbhI2O4S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 10:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344787AbhI2O4S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Sep 2021 10:56:18 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4800C06161C
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 07:54:36 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j5so7065016lfg.8
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 07:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aNDg8rH1IqsEJHwICt9FxmmYGgFjw33LIv8Cr+MhvCs=;
        b=VFYPi4rv9wgyl4t8uz6CJR4Q7ZjHLJ2oS8yeRT8WjzQvB5Mm4tn4CqGiZi6Lcxt2FT
         Oym7hvM8rN6crEe6JMre7ZZUqaGTGI0QWaK+jC3F8ZIIwuXQ0zvyEw9PXsP/dvonGW+t
         jyPb4DeHtEtasd42m/XYhIm1KCy7sPuk6ShXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNDg8rH1IqsEJHwICt9FxmmYGgFjw33LIv8Cr+MhvCs=;
        b=J2MsMxaEiz303Ye926kSf6ZPBFurm/MbDgRene/ATZMcG26yvtCFOErYOW7nuhH8GB
         qUAh20pDcNMtpd1yok6QcVN1J398RSSIuuKbbPHMBfRJrTiMwqheIDexF8VWeix/1qzn
         vQ+L0NWBfbPjAT8Z9C08JHTrXkMC2UitxA9ZlzTEsTASKFZMHn5Xs9L37VCtOQ6qWcnm
         ZojS1CxYc366GIyKvffi/MhkQdVQWCBGyY89uicXsBFzO2sCzF6yzSmXdPTCJc8CG5eO
         hhhusoFNfdf4xVvyWJquyGm8ph1gXBPuXrxi7+46NEwYSyH5Ih1gxdkhslRAFP28R2cY
         Sfqw==
X-Gm-Message-State: AOAM530UFn0t+TRNpsUyiVUN+ojTSZlwCU6EE9iEeyxRXZWBiHDkSNvt
        4VjlujAECJiVETfU+2JrducELwguRE5IXVB6
X-Google-Smtp-Source: ABdhPJxhhtDFOPKx2lXAci1SHDlKjve3/M20bUBpHPMY1P51HvwIWczAuXj7dKBKNbEyIMWz4tV9nw==
X-Received: by 2002:a05:651c:213:: with SMTP id y19mr318077ljn.273.1632927274401;
        Wed, 29 Sep 2021 07:54:34 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id j13sm16442lfm.100.2021.09.29.07.54.31
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 07:54:32 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id i25so11908477lfg.6
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 07:54:31 -0700 (PDT)
X-Received: by 2002:a2e:5815:: with SMTP id m21mr329675ljb.95.1632927270683;
 Wed, 29 Sep 2021 07:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com> <CAHk-=wg23CqjGWjjxDQ7yxrb+eF5at2KFU03GZa18Znx=+Xvow@mail.gmail.com>
In-Reply-To: <CAHk-=wg23CqjGWjjxDQ7yxrb+eF5at2KFU03GZa18Znx=+Xvow@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Sep 2021 07:54:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjd_BJiJYZ99PAoc4mQ3QTiZrt-tRdznj3g9kU8-gYsAA@mail.gmail.com>
Message-ID: <CAHk-=wjd_BJiJYZ99PAoc4mQ3QTiZrt-tRdznj3g9kU8-gYsAA@mail.gmail.com>
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 29, 2021 at 7:47 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And if there *is* need ("look, we have that same store in both the if-
> and the else-statement" or whatever), then say so, and state that
> thing.

Side note: I'd also like the commit that introduces this to talk very
explicitly about the particular case that it is used doe and that it
fixes. No "this can happen". A "this happened, here's the _actual_
wrong code generation, and look how this new ctrl_dep() macro fixes
it".

When it's this subtle, I don't want theoretical arguments. I want
actual outstanding and real bugs.

Because I get the feeling that there were very few actual realistic
examples of this, only made-up theoretical cases that wouldn't ever
really be found in real code.

                Linus
