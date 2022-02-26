Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC284C58A9
	for <lists+linux-arch@lfdr.de>; Sun, 27 Feb 2022 00:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiBZXEG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Feb 2022 18:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiBZXEE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Feb 2022 18:04:04 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975157EA33
        for <linux-arch@vger.kernel.org>; Sat, 26 Feb 2022 15:03:28 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b11so15319956lfb.12
        for <linux-arch@vger.kernel.org>; Sat, 26 Feb 2022 15:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=daxe4mwayP1bC/NxTK83bICRVcna++tD0VeU2H7bbus=;
        b=KrhixWl4niB53PuH6P7XtpHqxN4ASGoWFyUrFkHE15y2mxuI1jWmYiwvEVAXFwsx98
         xed5uehYbrmLVtWAe6Maz5Dcl0bm9FKqWQbYbaRWzLIhSXpzjQjfdvv3QSX6A5HSkDwY
         jMq+tM7tuV3LPlQ+6TD7pOOUh29ygcOzUTzYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=daxe4mwayP1bC/NxTK83bICRVcna++tD0VeU2H7bbus=;
        b=rfb1pGuXHJ4hgJZqlUPpMIHyRB30nB+RxrAbp/2OdbZfSU43BB/GpamQt3RFB5xQSv
         1jAXd9ws6bZnqufMOhK/F5jZlhZehTwv82FyDdz8CorgS1gRyheWHrtLKNbBSLvaLma+
         MvBtQFMEADkL8haMWHKz8vNtY/ZpzejiU67T8NuEyepBJjpwnsDD2wE+Uo43m0bhMPwj
         8fNe8lELZ2fqHfF+PwxgdY1PeVE2bLrQZrRb35l0i7sD49xZJwrEKKgv0INB8I+BWG3P
         aQu9CqzqCHMEuTHjQkhspoHOZQvwQo4yNTqzQHYHLvfFoD5pvHtWckVLVCNLHHYjxXBs
         v1RQ==
X-Gm-Message-State: AOAM53162lQ1WNIJzcS/GF0Cd36u1fUiBH12OEpkA86iHMdoZfbY7HZg
        ewDqwwHDt0hNXjD489CjEdQATlmR1Lhe9Q==
X-Google-Smtp-Source: ABdhPJw7Xi3hkIDRhp6qXO+6TJO/2qWZ8nr2gkT0zuh8O4yQ7qWA/BZ2ABM80xaMLAY+LAOpodXf1w==
X-Received: by 2002:a05:6512:22c5:b0:443:890c:a9e3 with SMTP id g5-20020a05651222c500b00443890ca9e3mr9247761lfu.662.1645916606949;
        Sat, 26 Feb 2022 15:03:26 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id n16-20020a0565120ad000b004439844469fsm543339lfu.206.2022.02.26.15.03.26
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Feb 2022 15:03:26 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id s25so12313563lji.5
        for <linux-arch@vger.kernel.org>; Sat, 26 Feb 2022 15:03:26 -0800 (PST)
X-Received: by 2002:a2e:b8cc:0:b0:246:4767:7a29 with SMTP id
 s12-20020a2eb8cc000000b0024647677a29mr9788910ljp.152.1645916606102; Sat, 26
 Feb 2022 15:03:26 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com> <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
 <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
 <20220226124249.GU614@gate.crashing.org> <CAK8P3a2Dd+ZMzn=gDnTzOW=S3RHQVmm1j3Gy=aKmFEbyD-q=rQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2Dd+ZMzn=gDnTzOW=S3RHQVmm1j3Gy=aKmFEbyD-q=rQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Feb 2022 15:03:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjAG2TZj5rEhiHyuD7KoffTLhikXy7OSj2f8QXAf7M=2A@mail.gmail.com>
Message-ID: <CAHk-=wjAG2TZj5rEhiHyuD7KoffTLhikXy7OSj2f8QXAf7M=2A@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Jakob <jakobkoschel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 26, 2022 at 2:14 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Could gcc follow the clang behavior then and skip the warning and
> sanitizer for this case when -fno-strict-overflow or -fwrapv are used?

Well, for the kernel, that horse has already left the barn, and we'd
have to use -Wno-shift-negative-value anyway.

But yes, from a sanity standpoint, it would be good to shut that
warning up automatically if compiling for a 2's complement machine (ie
"all of them") with -fwrapv.

Considering that gcc doesn't support any non-2's-complement machines
anyway afaik, and that the C standards people are also fixing the
standard, and gcc has never done anything odd in this area in the
first place, I think the warning is probably best removed entirely.
But we'll have to do it manually for the existing situation.

          Linus
