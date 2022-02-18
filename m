Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DEF4BBD85
	for <lists+linux-arch@lfdr.de>; Fri, 18 Feb 2022 17:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbiBRQav (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Feb 2022 11:30:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237924AbiBRQaf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Feb 2022 11:30:35 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C95166A49
        for <linux-arch@vger.kernel.org>; Fri, 18 Feb 2022 08:30:18 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bu29so6578383lfb.0
        for <linux-arch@vger.kernel.org>; Fri, 18 Feb 2022 08:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eWXASLXj3ah1nUCNDDS96tbgyxj1Xh2YKJCejtR7JpU=;
        b=WMVUCdVPbIYeo3/xEorx1kLAjztWdlTVllEOBGrsepZiU52zCPd8uQ4BynBbEVR5uE
         m5niTWEKCz8uis6MH1nteqGeMvliiaoAf75dSO6UpBNIJ8fuK0S7F6Un/0BpAh+A3c9i
         cHyguq93eseiP8DHvsIeFylKcHXBEDw3zyh5EygwVmy830nskTCu2MM/tWCZokXHgkoL
         2FD7Jjl9hJZIyJLpu6wsO7A8iB/u7v5lijOGIVmp0L64lliQuSbtVGZ/COoGexZw4LLC
         ufKgv8sZ2FYySHnPJj4dldMLtf9IS3E+s1sYc1YESRdr3oypvj6KtUbpNY5s28aNxQvk
         t+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eWXASLXj3ah1nUCNDDS96tbgyxj1Xh2YKJCejtR7JpU=;
        b=FpS/0KIp8w+9XzezynOVL0mKlcXSQHDN9xYYdeQMvgEzQHGtDy2UfRDK2evyGuCB+g
         W1oz8Uwfx7xJoy93oWafXHT/SrlWxvvqE8ChOWGCP+URlHiUhaqXnhF4uL6ctlLBCRcy
         JR69QwAOVhXrl//0e6/AWAe2FMa0PfYZ1MWAAs1/ALeN/kC+8xc36zdzz7iyZWpLz903
         uRG5nPVDJJdx9ZrZ3E4d0ccWb6UFEvxX+dfqgRcR2rQKts5ENyOQ6COUEY99F2L9eYkX
         dCtdJvv1uys3aaVNQ8OEZKKu6WOSMdLeig6XeKqbrgCLZ5S7fdRZCkrau9hSp/NXfLQc
         rAmw==
X-Gm-Message-State: AOAM530q9+dUfaeHGzGPDQd9X+Ev/5fnEYfsIzfrBa+JMA7Fw5c+rfKQ
        ojS7wCeZ4YdSOHfy1Wg5rtUzxKNQZ93jSc5r+iNDQg==
X-Google-Smtp-Source: ABdhPJyojZVYnpZeZBMd1zNRVhqDB8uTHLEX5Gb/2X8vgGEVxbE8ce4CYY13oZuLKO1IoCK/cr+5vn9GXjN7FjN7+Sg=
X-Received: by 2002:ac2:5389:0:b0:443:7b0e:951a with SMTP id
 g9-20020ac25389000000b004437b0e951amr5949215lfh.288.1645201817061; Fri, 18
 Feb 2022 08:30:17 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-2-jakobkoschel@gmail.com> <Yg6iCS0XZB6EtMP7@kroah.com>
In-Reply-To: <Yg6iCS0XZB6EtMP7@kroah.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 18 Feb 2022 17:29:50 +0100
Message-ID: <CAG48ez2OgMThMd_EDA=ekFXy5=sWYmLuSshj1jiMvzpuy84M2Q@mail.gmail.com>
Subject: Re: [RFC PATCH 01/13] list: introduce speculative safe list_for_each_entry()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 17, 2022 at 8:29 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Feb 17, 2022 at 07:48:17PM +0100, Jakob Koschel wrote:
> > list_for_each_entry() selects either the correct value (pos) or a safe
> > value for the additional mispredicted iteration (NULL) for the list
> > iterator.
> > list_for_each_entry() calls select_nospec(), which performs
> > a branch-less select.
[...]
> >  #define list_for_each_entry(pos, head, member)                               \
> >       for (pos = list_first_entry(head, typeof(*pos), member);        \
> > -          !list_entry_is_head(pos, head, member);                    \
> > +         ({ bool _cond = !list_entry_is_head(pos, head, member);     \
> > +          pos = select_nospec(_cond, pos, NULL); _cond; }); \
> >            pos = list_next_entry(pos, member))
> >
>
> You are not "introducing" a new macro for this, you are modifying the
> existing one such that all users of it now have the select_nospec() call
> in it.
>
> Is that intentional?  This is going to hit a _lot_ of existing entries
> that probably do not need it at all.
>
> Why not just create list_for_each_entry_nospec()?

My understanding is that almost all uses of `list_for_each_entry()`
currently create type-confused "pos" pointers when they terminate.

(As a sidenote, I've actually seen this lead to a bug in some
out-of-tree code in the past, where someone had a construct like this:

list_for_each_entry(element, ...) {
  if (...)
    break; /* found the element we were looking for */
}
/* use element here */

and then got a "real" type confusion bug from that when no matching
element was found.)

*Every time* you have a list_for_each_entry() iteration over some list
where the list_head that you start from is not embedded in the same
struct as the element list_heads (which is the normal case), and you
don't break from the iteration early, a bogus type-confused pointer
(which might not even be part of the same object as the real list
head, but instead some random out-of-bounds memory in front of it) is
assigned to "pos" (which I think is probably already a violation of
the C standard, but whatever), and this means that almost every
list_for_each_entry() loop ends with a branch that, when
misspeculated, leads to speculative accesses to a type-confused
pointer.

And once you're speculatively accessing type-confused pointers, and
especially if you start writing to them or loading more pointers from
them, it's really hard to reason about what might happen, just like
with "normal" type confusion bugs.


If we don't want to keep this performance hit, then in the long term
it might be a good idea to refactor away the (hideous) idea that the
head of a list and its elements are exactly the same type and
everything's just one big circular thing. Then we could change the
data structures so that this speculative confusion can't happen
anymore and avoid this explicit speculation avoidance on list
iteration.

But for now, I think we probably need this.
