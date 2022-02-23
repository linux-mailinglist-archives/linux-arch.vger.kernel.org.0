Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231554C1B1E
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 19:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244012AbiBWSr7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 13:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243938AbiBWSrw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 13:47:52 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2129B40
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 10:47:23 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id i11so32807532lfu.3
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 10:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ny/Yyfn0acnuJvT2YtBGV0/3IFWA2cjT9fj9k9ksRRI=;
        b=KNfaQOa+6QSvmFTOGqYpYeRSoiXf9wHxA/iHvB01NoLk3HfON5rfU+N9wZjLNeGR+q
         7K5xhIHDS4KQ75tEFTPXV/leGfyTtb7VkA1gOzBPe9d/fOWQz2LiWQTUZgetvkhyDQ9a
         DSuTvtVZTilVTwEjztPGWE5muzD55Epi6clu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ny/Yyfn0acnuJvT2YtBGV0/3IFWA2cjT9fj9k9ksRRI=;
        b=Ks/JF+ib3RltcAq/J1+tjJAwx9OhOcQgcRYpRcadd9K6qeCDQlNXqN/hNIfVdGH+Ib
         18+vvpWZU+gfkccYnkK4LUudUIUUdBqlnim/IPGoEIWJ762+9DU9q7kKSXdlcVLfCuxh
         YxDaF0FoKeg/cjHgC92TWHbTvfpDTamOLmGxn7WsmNtZ6zzzGVinf8VISssbwFJpSEhY
         9hFpdb4KlvrQMQOQBHkIJYI17R5inizGmMHsKzZza++cw1XLv4g2cglUhPSuZy+thmXb
         y47SzSU2p/akY3IEg/T/s4UmlIiBTpyWOUKoiv4oajTWq8Ulcov14kQNBzsHyIRDyWGe
         nYYw==
X-Gm-Message-State: AOAM533maumea+RonQXhWeZBjhRuaF0QAZaqFhykMBcEFfgG7BLBEM4b
        ASJezL+dh9uhn13RyEk7ein+tc244oZv+OHQ
X-Google-Smtp-Source: ABdhPJxveIXtw2mKi4qYJTDFx9MgzkPSf7t133N+CFtneFzMh8fkXSEIi4pJUOEC3KQW3ZoN1hAahw==
X-Received: by 2002:a05:6512:3329:b0:443:aec5:564e with SMTP id l9-20020a056512332900b00443aec5564emr673957lfe.263.1645642041712;
        Wed, 23 Feb 2022 10:47:21 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id bg40sm56164ljb.59.2022.02.23.10.47.17
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 10:47:18 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id w27so15040993lfa.5
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 10:47:17 -0800 (PST)
X-Received: by 2002:a05:6512:130b:b0:443:c2eb:399d with SMTP id
 x11-20020a056512130b00b00443c2eb399dmr648396lfu.27.1645642037279; Wed, 23 Feb
 2022 10:47:17 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com> <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com>
In-Reply-To: <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Feb 2022 10:47:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
Message-ID: <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     Jakob <jakobkoschel@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

[ Arnd was already on the participants, but I moved him from 'Cc:' to
'To:', just because I think this is once again tangentially related to
the whole "c99 base" thing ]

On Wed, Feb 23, 2022 at 6:13 AM Jakob <jakobkoschel@gmail.com> wrote:
>
> I'm sorry for having created the confusion. I made this patch to support
> the speculative safe list_for_each_entry() version but it is not actually
> related to that. I do believe that this an actual bug and *could*
> *potentially* be misused. I'll follow up with an example to illustrate that.

Ok, so this is just a regular bug, plain and simple.

The problem being that the list_for_each_entry() will iterate over
each list entry - but at the end of the loop it will not point at any
entry at all (it will have a pointer value that is related to the
*HEAD* of the list, but that is not necessarily the same kind of entry
that the list members are.

Honestly, I think this kind of fix should have been done entirely separately.

In fact, I think the change to list_for_each_entry() should have been
done not as "fix type speculation", but as a much more interesting
"fix the list iterators".

The whole reason this kind of non-speculative bug can happen is that
we historically didn't have C99-style "declare variables in loops". So
list_for_each_entry() - and all the other ones - fundamentally always
leaks the last HEAD entry out of the loop, simply because we couldn't
declare the iterator variable in the loop itself.

(And by "couldn't", I mean "without making for special syntax": we do
exactly that in "for_each_thread ()" and friends, but they have an
"end_for_each_thread()" thing at the end).

So what I'd personally *really* like to see would be for us to - once
again - look at using "-std=gnu99", and fix the whole "leak final
invalid pointer outside the loop".

Then the type speculation thing would be an entirely separate patch.

Because honestly, I kind of hate the completely random type
speculation patch. It fixes one particular type of loop, and not even
one that seems all that special.

But we still don't do "gnu99", because we had some odd problem with
some ancient gcc versions that broke documented initializers.

I honestly _thought_ we had gotten over that already. I think the
problem cases were gcc-4.9 and older, and now we require gcc-5.1, and
we could just use "--std=gnu99" for the kernel, and we could finally
start using variable declarations in for-statements.

Arnd - remind me, please.. Was there some other problem than just gcc-4.9?

                 Linus
