Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B91E4C1E26
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 23:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242431AbiBWWBm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 17:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbiBWWBl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 17:01:41 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3750F50449
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 14:01:13 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id p14so229751ejf.11
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 14:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4TnD6jYOSsNtQKWO0JaU3gwq6Qdh6TjyUgcvqEl+K5I=;
        b=dX/Jy7+F597/hIqi/9qMzXNMQrDyhVkP3dTnhBEOAl49NjqeCD8FqayzKHmPDChTw3
         FXxIkt9v5pPo2K0sD+mRbJ2ze9fZjc9QQ0YoibAdDT8COHVHj0K4UemJxZnobNcdHhFL
         ecGrXKp1xqB580NwK5g7hNFGZEgHao6WIIXUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4TnD6jYOSsNtQKWO0JaU3gwq6Qdh6TjyUgcvqEl+K5I=;
        b=70qSKpm8DQWgEn7LDFkTpPPOVe5Ja2u2STCCsPI+ZbpVq9UL0LCLWVS190OxV+/OSP
         xPChzw6/TiliVyQfg587Kd+bANSp+ED+xmm6UILGZs7bofzrL06jjcvvDRPZipYPtG6S
         w64YG8sB9kKm8foy4iwsGdgWnEO5Gd+6+5UsyJvZ9nwtitNyZk9PJ6mUY2REJrq3gO8n
         nuctg+LAwrcQiGNxZaUyndB6vt/3o6lVdN0Jn3pEXgBiMLHPEewyLdX03+NaiiuAZgNw
         164LUl3xKsgcmsZvcghizJs20w2TNh1OnpNd8cGbkrwcCnXkjh7tcwLrht3e66CdKZGR
         08Pg==
X-Gm-Message-State: AOAM531s0Kin+WX51635aLCgs8mCBgABKDepLUCGhf9+MAfe3UPDdNVX
        NERIZ2cPfcmgxDvsHlIsSv8P7W5dqeblljCsDj4=
X-Google-Smtp-Source: ABdhPJwkxJlF7JlyzfKJS8/ys3T91Eldpp0x1Vlc6uEu6vV4aMdujTcjz5m3M0AeackqWBkl7sxxIQ==
X-Received: by 2002:a17:906:93f7:b0:6cc:6319:6c43 with SMTP id yl23-20020a17090693f700b006cc63196c43mr1342062ejb.176.1645653671373;
        Wed, 23 Feb 2022 14:01:11 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id r19sm357206ejz.139.2022.02.23.14.01.10
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 14:01:11 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id d28so112168wra.4
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 14:01:10 -0800 (PST)
X-Received: by 2002:a05:6512:2033:b0:443:3d49:dac with SMTP id
 s19-20020a056512203300b004433d490dacmr1067001lfs.52.1645653236389; Wed, 23
 Feb 2022 13:53:56 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com> <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
 <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
 <CAK8P3a0DOC3s7x380XR_kN8UYQvkRqvE5LkHQfK2-KzwhcYqQQ@mail.gmail.com>
 <CAHk-=wicJ0VxEmnpb8=TJfkSDytFuf+dvQJj8kFWj0OF2FBZ9w@mail.gmail.com> <CAK8P3a2b_RtXkhQ2pwqbZ1zz6QtjaWwD4em_MCF_wGXRwZirKA@mail.gmail.com>
In-Reply-To: <CAK8P3a2b_RtXkhQ2pwqbZ1zz6QtjaWwD4em_MCF_wGXRwZirKA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Feb 2022 13:53:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh97QY9fEQUK6zMVQwaQ_JWDvR=R+TxQ_0OYrMHQ+egvQ@mail.gmail.com>
Message-ID: <CAHk-=wh97QY9fEQUK6zMVQwaQ_JWDvR=R+TxQ_0OYrMHQ+egvQ@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jakob <jakobkoschel@gmail.com>,
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
        "Bos, H.J." <h.j.bos@vu.nl>, Nathan Chancellor <nathan@kernel.org>
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

On Wed, Feb 23, 2022 at 1:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > Ok, so we should be able to basically convert '--std=gnu89' into
> > '--std=gnu11 -Wno-shift-negative-value' with no expected change of
> > behavior.
>
> Yes, I think that is correct.

Ok, somebody please remind me, and let's just try this early in the
5.18 merge window.

Because at least for me, doing

-                  -std=gnu89
+                  -std=gnu11 -Wno-shift-negative-value

for KBUILD_CFLAGS works fine both in my gcc and clang builds. But
that's obviously just one version of each.

(I left the host compiler flags alone - I have this memory of us
having had issues with people having old host compilers and wanting
headers for tools still build with gcc-4)

                Linus
