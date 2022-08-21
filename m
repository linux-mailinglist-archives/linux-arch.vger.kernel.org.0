Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9463959B5DA
	for <lists+linux-arch@lfdr.de>; Sun, 21 Aug 2022 20:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiHUSNy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Aug 2022 14:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiHUSNw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Aug 2022 14:13:52 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914CF1D0D8
        for <linux-arch@vger.kernel.org>; Sun, 21 Aug 2022 11:13:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id vw19so3729617ejb.1
        for <linux-arch@vger.kernel.org>; Sun, 21 Aug 2022 11:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=T2tAc2srxcwVlb+HTpoFgLBwizFpdGoX6kNWCxIqAx4=;
        b=Sb1mkjtKamB89FkwMkOmYcEpPsJ9G+rEZCuFjECQJyE5OHdIYo3sCSlmpjxltFmKmL
         EwLLI2CzPzoEICDC6JsoOvE1DjILnky1onp8Yaw17oGdMUtGBH0kRj+XtAd0nxJMkFlA
         aOUvUJfRXf02j3LTQlfS72zHjtQixpjn09QDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=T2tAc2srxcwVlb+HTpoFgLBwizFpdGoX6kNWCxIqAx4=;
        b=K0KPUKA2PUwZufO9K/Z2J8URL31vGOPzkyr6cjexx5GweB2ODmGV0HkxrWsBIzlVVX
         0pQPvYHzYdTql0iKdGnh+t5Qycq7xIkC0pQfB3uLse+jRxZyWzNu+jVMp4q/kwSzCtOn
         s6t6gluEJXaRSJJyz+kNUYGpPaSACBTlkkTAMyddAYHKxacfjVeK+7dfp5gkrpID7NtA
         tHm39+zb2+aBKgFtKz2oDFg8aQD9+jyduMUBlPlQcq4qZW4gph0UAcof56UNr2ijaKjQ
         d3xz0CRbjw4ZcfDii0fwbDVdgYKXzRzeGd+l39wg4FL3449cBWAfMhuZcqq/+RGNM90L
         Eq9Q==
X-Gm-Message-State: ACgBeo24MGS4BZtfK7gNBCGgamrYH5OVfRFfL7uTzN/doKZ+9+GABkwo
        PQZwBCdgMzOEE5r0Mrd3yBcOojbD5xklqdpx
X-Google-Smtp-Source: AA6agR6y3rei7hp7IDWyD2C7izPzIArTLyfuFo8llf3IxbmFiDJM8OhDZCyRDJKyM/cLJSpE1SaeKw==
X-Received: by 2002:a17:906:9c82:b0:6e1:1d6c:914c with SMTP id fj2-20020a1709069c8200b006e11d6c914cmr10712735ejc.769.1661105626742;
        Sun, 21 Aug 2022 11:13:46 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id s13-20020a05640217cd00b00445f660de5csm6793519edy.85.2022.08.21.11.13.45
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Aug 2022 11:13:45 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id k9so10755086wri.0
        for <linux-arch@vger.kernel.org>; Sun, 21 Aug 2022 11:13:45 -0700 (PDT)
X-Received: by 2002:a05:6000:136f:b0:225:2fad:dde7 with SMTP id
 q15-20020a056000136f00b002252faddde7mr8866613wrz.274.1661105624483; Sun, 21
 Aug 2022 11:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mtDFpaAWeGCtrfm_WPM6j-Gkt_O80=nKfp6y39aXaBr6w@mail.gmail.com>
In-Reply-To: <CAH2r5mtDFpaAWeGCtrfm_WPM6j-Gkt_O80=nKfp6y39aXaBr6w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Aug 2022 11:13:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+xbVq++uqW9YgWpHjyBHNB8a-xad+Xp23-B+eodLCEA@mail.gmail.com>
Message-ID: <CAHk-=wi+xbVq++uqW9YgWpHjyBHNB8a-xad+Xp23-B+eodLCEA@mail.gmail.com>
Subject: strlcpy() notes (was Re: [GIT PULL] smb3 client fixes)
To:     Steve French <smfrench@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
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

[ Adding Catalin Marinas because of that final note at the end of this
email, and because of the potential sub-page faults on arm64 ]

On Sat, Aug 20, 2022 at 3:34 PM Steve French <smfrench@gmail.com> wrote:
>
> - trivial strlcpy removal

Note that while I encourage this, in that thread I forgot to mention a
very subtle difference between strlcpy and strscpy.

Now strlcpy() is a completely broken interface, since it fundamentally
cannot work on untrusted source strings (which is the alleged main
reason to use it!). It's more than "the return value is broken", it's
literally "since strscpy is designed to return the length of the
source string, it can walk arbitrarily far past the end of it, if it
doesn't have a terminating NUL character".

BOOM! SIGSEGV in user space, random kernel oopses in the kernel.

So strlcpy() is completely broken-by-design, and should never be used
for anything but trusted strings, which imnsho makes it largely
pointless. It is an inefficient way to copy trusted strings into
limited destination buffers. That's all it is good for, and that's
simply not a good reason to exist.

In the kernel implementation, it is also racy wrt the data it copies,
and the return value may not even match the actual returned data in
case the source buffer changes under you.

That second thing is fixable, but it's just not worth fixing since the
first issue is fundamental.

So the source buffer has to be not only properly NUL-terminated, it
also has to be stable. Of the two, the first one is a bigger issue,
the second is not worth even worrying about at that point.

End result: strlcpy() does need to go.

But it's worth mentioning that 'strscpy()' not only fixes that "source
overrun" issue and the data race issue (the returned length is
guaranteed to actually match the returned buffer), it also has another
subtle semantic change to fix a performance issue.

strlcpy() is a broken interface not just because of the broken
interface - even if the actual design problems don't matter for you
from a correctness standpoint because your string is properly
terminated AND stable, it can also *perform* badly.

Why? Again, strlcpy() will walk the whole source string, even if you
just asked it to copy the first few bytes of it. For that same
original "this interface is completely broken" reason.

"strscpy()" doesn't do that - the maximum length also limits how far
strscpy will walk in the source string. Which is very much what you
want when you may not trust the source - you just have a buffer size,
you don't know the size of the string (and if you did know it, you'd
never use either strscpy or strlcpy, of course).

BUT.

And this is where the subtle semantic difference comes in.

"strscpy()" goes one step further, since it could start from a clean
slate with no legacy semantics. The function is defined to do copies
in "chunks" (typically one whole word at a time).

In particular, the *destination* is also written not one byte at a
time, but one "chunk" at a time. It will not overrun the destination
buffer (as defined by the size argument), but it basically does *not*
guarantee that it won't write to bytes after the final terminating NUL
character.

In other words, strscpy() may - and in the default implementation
*will* - potentially write more than one terminating NUL character in
an effort to avoid the whole "byte at a time" loop at the end.

Now, no sane user will ever care - the destination buffer is by
definition overwritten, after all. But this does mean that if you do
things like this:

        unsigned char dest[5];

        strscpy(dest, "hi", 8);

then strscpy() may actually overrun your five-byte destination buffer,
even though your source string is only three bytes in size.

You basically told it that it can access up to 8 bytes (from both
source and destination), and that is what it does (if the chunk size
is 8 - as it would be on x86-64).

So the above will basically do a single word-size load, find a zero
byte in it, clear the subsequent bytes, and do a single word-sized
store.

Efficient, yes. Also very different from what the other 'str*cpy()"
functions do.

So when you tell strscpy() that you have a maximum of N bytes, then
strscpy() really does assume that

 (a) it can always read up to N bytes from the source

 (b) it can always write up to N bytes (zero-padded) to the destination

Both of those assumption are quite reasonable and sane on their own,
but they are *different*.

In contrast, "strncpy()" basically has the rule that

 (a) it can read up to the terminating NUL but at *most* N bytes from the source

 (b) it will *always* write exactly N bytes to the destination

and "strlcpy()" has the rules

 (a) it can read up to the terminating NULL with *no* regard to N from
the source

 (b) it can write up to N bytes to the destination, but stop at the NUL

See? Very different rules, although the differences don't matter most
of the time (except for strlcpy() rule (a), which has that "no regard
for N at all" issue).

Why do I mention this? It doesn't matter for 99% of all uses, but
there are some gotchas:

 (1) sometimes "source buffer" and "destination buffer" sizes are
simply different.

The strscpy() assumption is simply that you gave the smaller of the
two buffers, but that's *different* from the traditional meaning,
which is that N is basically the destination buffer size.

So I despise strlcpy(), but I think strscpy() is kind of broken too.
For the generic case, it really should have two separate buffer sizes.

 (2) if you expect the destination buffer contents to be untouched
past the terminating NUL character, you're simply out of luck

The strscpy() assumption is that it can arbitrarily write to the
destination buffer.

So the best way to think of "strscpy()" is really as a "optimized
memcpy for strings". That's almost exactly how it acts. It will do a
memcpy(), but stop when it notices that it has copied a NUL character.

(It's a *bit* better than that, in that it will not copy random data
from beyond the string for security purposes - when it stops copying,
it *will* zeropad any excess, it won't actually copy possibly
sensitive data from past the source string, but if you think of it as
a string-optimized memcpy, you really have the right mental model).

It's also worth pointing out that the kernel implementation of
'strscpy()' will not do the chunk-sized accesses across an unaligned
page boundary. So it won't actually take a page fault past the
terminating NUL character, but if you pass it an 'N' that is bigger
than the source buffer, and you have sub-page faults in the kernel, we
might need to do some further work in this are. Catalin?

Of course, the easy solution is "don't pass a bigger N than the source
buffer size", but if you come from a 'strlcpy()' model where N only
affects the destination buffer and the NUL in the source is a cap on
the source, this may cause problems.

                   Linus
