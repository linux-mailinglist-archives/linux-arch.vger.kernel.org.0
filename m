Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A854C1DFD
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 22:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239391AbiBWVwj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 16:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbiBWVwi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 16:52:38 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF533C4B9;
        Wed, 23 Feb 2022 13:52:07 -0800 (PST)
Received: from mail-ej1-f51.google.com ([209.85.218.51]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mc02T-1nwrnu3KHv-00da4O; Wed, 23 Feb 2022 22:52:05 +0100
Received: by mail-ej1-f51.google.com with SMTP id r13so249489ejd.5;
        Wed, 23 Feb 2022 13:52:05 -0800 (PST)
X-Gm-Message-State: AOAM5308jvEXhpKL/w+dlKOqx/PFZZgd5JfDS6c5Bk8AtLsATnuuPNun
        FTUsSC+jEyRTsxcmRagkzksfRbiAM3ocICNcygA=
X-Google-Smtp-Source: ABdhPJxtj8uyicd8SyqQTEpI7vIdv7hPv52/WmZ5AoYWSFitVsWjSUWx5lKV5rVYc5oiMdSbMnSOL/JSvK5tIzHTFXA=
X-Received: by 2002:a5d:59aa:0:b0:1ed:9f45:c2ff with SMTP id
 p10-20020a5d59aa000000b001ed9f45c2ffmr1035641wrr.192.1645649355189; Wed, 23
 Feb 2022 12:49:15 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com> <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
 <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
 <CAK8P3a0DOC3s7x380XR_kN8UYQvkRqvE5LkHQfK2-KzwhcYqQQ@mail.gmail.com> <CAHk-=wicJ0VxEmnpb8=TJfkSDytFuf+dvQJj8kFWj0OF2FBZ9w@mail.gmail.com>
In-Reply-To: <CAHk-=wicJ0VxEmnpb8=TJfkSDytFuf+dvQJj8kFWj0OF2FBZ9w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Feb 2022 21:48:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2b_RtXkhQ2pwqbZ1zz6QtjaWwD4em_MCF_wGXRwZirKA@mail.gmail.com>
Message-ID: <CAK8P3a2b_RtXkhQ2pwqbZ1zz6QtjaWwD4em_MCF_wGXRwZirKA@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jakob <jakobkoschel@gmail.com>,
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
X-Provags-ID: V03:K1:cjkUysxlJscg26BdLEqvQDwPBkRPWuqIBWReqtQZ15RnMmjfj5A
 FReQE+scpfMJKfK1nSKyO3B+N6OnxYFTXnwyAGB2Eobvu65WBoTlkEx+RaGqyBuqmR2p2vV
 yt/yJUMtHyZBsuwj2WOWK7cq4UvbcFFPdKOLJimz3wd3kC8J5tiqJYItu3+WU41vGpRkQe8
 4AKDYq3OmeMc1vKbCm/pQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3MLiFAkrs2E=:9Tf5B1NU3+YtBT74Jx1q64
 +JNlxJdngVHLKPENxJcTq5Wy3AYtzwF4uAUGLkZluOndrX+1cQMcH770BO+fVqcqBO26KxcPT
 wyTqxnko6GWoBQTzIL9OPjmZOQvb+TK9bc4KZOoR4AA+OI3eHfw44TcIeHBxcKH+rg5L6j08Z
 byvTUW/r0foAa9S7xniGGPclGJbRAo9Rt65aRhepIR3u6cX+nBC8EGEwYbULFBSY47bjs8Tu4
 Nsftv/BOYuHaqOg5JZ9lw5GIcPpE/2TJAtJFej3Qo9qrQ/lgPE5/NL9nIK05Mdh2dwRso5NeS
 oS0lMKJlef/2jlC3KpDLdHS1l8Eh5SFjHbih8rO+PPz/bZBNgmgpbLQl4RbWZsrJK8yBgGZVz
 I+/kUp4XoILQjQus/654TzbeXD3gmbAQg7zSp90wnSwAu4IfRFQi2eexMSRXXwLDrBYimTxlf
 CD3P9+peR8lw56EoUky+dIpS65Rk5st8cXXx5toWhkRQsS3kAo1a6xfr5K0Pk2HQWQ3nAdT4A
 PT2cUspSW+Xy6SjqBHqGHhsFsaCqhURKoy+m85RfsYlyk1vsRdxek4MEKeoCvMAoEf0huRxsh
 4ipSZexpkrm2sa7rSwN1Rp0OQ0UEYleXjlooqO543a0xxEyZNXWcgP+STje3pD8NSplL27It5
 9t4EEUaO8LNjPNZrEIO0sioyXo/A+nVLBsjPas7XBp/0JEYV5buwvjqWF5TjDZAj50ZoO3krV
 l2YIuoYkD7ntHXD3AmN/5O2kzuQQLQ75/dE17re9G0hm9RC0vpflONqoAyocfXoY+NtFEvsuf
 JkpUxd7y1Nqo6vDBmavUOSrAJdldpeQXFmdSlq6SGH7U61Anp4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 23, 2022 at 9:43 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Feb 23, 2022 at 12:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > I looked at the gcc documentation for this flag, and it tells me that
> > it's default-enabled for std=c99 or higher. Turning it on for --std=gnu89
> > shows the same warning, so at least it doesn't sound like the actual
> > behavior changed, only the warning output. clang does not warn
> > for this code at all, regardless of the --std= flag.
>
> Ok, so we should be able to basically convert '--std=gnu89' into
> '--std=gnu11 -Wno-shift-negative-value' with no expected change of
> behavior.

Yes, I think that is correct.

> Of course, maybe we need to make -Wno-shift-negative-value be
> conditional on the compiler supporting it in the first place?

I think they all do. I discussed this with Nathan Chancellor on IRC, to
see what clang does, and he points out that the warning was made
conditional on -fwrapv there a while ago:

https://github.com/llvm/llvm-project/commit/59802321785b4b9fc31b10456c62ba3a06d3a631

So the normal behavior on clang is to always warn about it, but since
we explicitly ask for sane signed integer behavior, it doesn't warn for
the kernel.

        Arnd
