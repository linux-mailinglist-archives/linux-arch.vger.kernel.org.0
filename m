Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB6E565EA3
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 22:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiGDUsV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 16:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbiGDUsU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 16:48:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EBCDF33
        for <linux-arch@vger.kernel.org>; Mon,  4 Jul 2022 13:48:19 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u12so18393409eja.8
        for <linux-arch@vger.kernel.org>; Mon, 04 Jul 2022 13:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/yAZeAbMlA0MlzGxn2hN3/XK5qxO5T7qF19l5UEr4Zc=;
        b=W2hmMHZIlVX17hX5ZnI6HTuqm3ZJ5p54D5d8aHf5QuKGwRZw6Y8EIH14PLiK5scdIY
         S9pthMsINqNnHDQkpKpYyIuOQlL07OnPavYF6D5xWccffjl/XEumDJl0Z3l2tdCrOtCA
         Dnuf6bnFzN/s3d72H3m8z7XBSeLvJTx0CJSdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/yAZeAbMlA0MlzGxn2hN3/XK5qxO5T7qF19l5UEr4Zc=;
        b=z5P1OHypIiQBT8h6AMuUHxZuZdSS+pHNhvSenXNC23mXEvJvUHDMvB5C0TMHOZck0u
         vu8msKRK62X52nx6/fS1EzvUKI+jJymAOHuS0Poh7uVHTN6W42x0iSUPLNkn+9y3qyjB
         7bzv7JbPbXhxElXze1QInx2cs831bQB8Yhf38hwSGt4sSOiZop1RaJNrCL482SODrbky
         3HqYON/+dYm0P/n6O5ZCKcCehwkeGAqkaErurQaez0nF9KEInX+jejqGZAfcMhy+rLxN
         IL8dQjuHwbhILKAPCRA077W2cbEMhm45p0U/OZEfn2jPO3A7cXcG0SPHzFlapamERdyw
         9ooA==
X-Gm-Message-State: AJIora+TiWMnqrHzq6E/rj3ExvFsNS7euP/haALTymXMU7/nw0V8ybEx
        4vyLnGFcxSu8TeIs7oXL9lcfuEUOLLCYbtAB5+A=
X-Google-Smtp-Source: AGRyM1vsz4/X5qbK1u5avAP15IptccSCQ/LZOo/nfDXT/y13B8VmO1GdDQ4XsL/hs/VCDct5wyFLAg==
X-Received: by 2002:a17:906:4ccc:b0:6fe:9155:47ae with SMTP id q12-20020a1709064ccc00b006fe915547aemr29661016ejt.246.1656967697789;
        Mon, 04 Jul 2022 13:48:17 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id ee34-20020a056402292200b0043a554818afsm2818352edb.42.2022.07.04.13.48.16
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 13:48:17 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id mf9so18535748ejb.0
        for <linux-arch@vger.kernel.org>; Mon, 04 Jul 2022 13:48:16 -0700 (PDT)
X-Received: by 2002:a5d:59a5:0:b0:21d:205b:3c5b with SMTP id
 p5-20020a5d59a5000000b0021d205b3c5bmr28828449wrr.97.1656967686356; Mon, 04
 Jul 2022 13:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-44-glider@google.com>
 <CAHk-=wgbpot7nt966qvnSR25iea3ueO90RwC2DwHH=7ZyeZzvQ@mail.gmail.com>
 <YsJWCREA5xMfmmqx@ZenIV> <CAHk-=wjxqKYHu2-m1Y1EKVpi5bvrD891710mMichfx_EjAjX4A@mail.gmail.com>
 <YsM5XHy4RZUDF8cR@ZenIV> <CAHk-=wjeEre7eeWSwCRy2+ZFH8js4u22+3JTm6n+pY-QHdhbYw@mail.gmail.com>
 <YsNFoH0+N+KCt5kg@ZenIV> <CAHk-=whp8Npc+vMcgbpM9mrPEXkhV4YnhsPxbPXSu9gfEhKWmA@mail.gmail.com>
In-Reply-To: <CAHk-=whp8Npc+vMcgbpM9mrPEXkhV4YnhsPxbPXSu9gfEhKWmA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Jul 2022 13:47:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQ2ijKVv8eV_P3c3cNaH8B4iKU0=GgwObzsJQM6cYtDg@mail.gmail.com>
Message-ID: <CAHk-=whQ2ijKVv8eV_P3c3cNaH8B4iKU0=GgwObzsJQM6cYtDg@mail.gmail.com>
Subject: Re: [PATCH v4 43/45] namei: initialize parameters passed to step_into()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Alexander Potapenko <glider@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Vitaly Buka <vitalybuka@google.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
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

On Mon, Jul 4, 2022 at 1:24 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The mount point check should go around the "check dentry mount point",
> but it's a separate issue from the whole "we are now jumping to a
> different dentry, we should check that the previous dentry hasn't
> changed".

Maybe it doesn't really matter, because we never actually end up
dereferencing the previous dentry (exactly since we're following the
mount point on it).

It feels like the sequence point checks are basically tied to the
"we're looking at the inode that the dentry pointed to", and because
the mount-point traversal doesn't need to look at the inode, the
sequence point check also isn't done.

But it feels wrong to traverse a dentry under RCU - even if we don't
then look at the inode itself - without having verified that the
dentry is still valid.

Yes, the d_seq lock protects against the inode going away (aka
"unlink()") and that cannot happen when it's a mount-point.

But it _also_ ends up changing for __d_move() when the name of the
dentry changes.

And I think that name change is relevant even to "look up a mount
point", exactly because we used that name to look up the dentry in the
first place, so if the name is changing, we shouldn't traverse that
mount point.

But I may have just confused myself terminally here.

             Linus
