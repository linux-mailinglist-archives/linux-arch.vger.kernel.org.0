Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A607109D37
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2019 12:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfKZLqf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Nov 2019 06:46:35 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39319 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfKZLqf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Nov 2019 06:46:35 -0500
Received: by mail-ot1-f65.google.com with SMTP id w24so15619133otk.6
        for <linux-arch@vger.kernel.org>; Tue, 26 Nov 2019 03:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjdzshLYgCCgwbhmOuSJ84yu2IodR1Sq0mvSDQia2nY=;
        b=c5Pahk6W4sXmZRKozu33aIaYc7PpKpPGB0sKYIs77jLfYAD1+buqI5qh3mULM8Rkos
         9hnhyuce3J9WPG/XQceQQK+Ux+eULGa32tmfyOk7FAQxZu8UGs/kumBfFSvrgqPfbIq/
         w70Qk+QIVpIAvo9LlZ6EY4DRNUdStDc6R3BIhOlwpR8japU3THUUnQlDr/9ERf+6CYw/
         1PYQJxnBkwVip0wDCW92NoYc9YDtmivr+Cj2+L/lHiDzYvaDeLyHbdwegTjUS9Fu+9CN
         u/tjC2gpyhGvJpLdRhnLDRizy0Z7bKtuTveJxaxzfVwXPrOswEQuO5SUghNNsrsIhsri
         Mi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjdzshLYgCCgwbhmOuSJ84yu2IodR1Sq0mvSDQia2nY=;
        b=CmbWK9HEi+MJewPBe+iQrpl/5lgYPAHkLMebLOg+WVRPUjTMX/+CS2LxHAilHHOqQ9
         KpBwFU6s3+feaqoGjkD+UcsLCyqsSWmSINPYRmsnIShdwD4hhOWFe31sDocVADWAFAIT
         CGzhbj651EG+ohfu4sUJsvDt/reiUlERDgbK02KBAoY5cHkE80G39WwJqJh8Z+XdMLyu
         upgR2WRgQZ8GuOaLmX2kkof7duABtjv1gXlrN1usHJnqhAqQXcrqeLnQku6uylTOF717
         92cjnXYxt/HXNAxJtCc4SJzR3NHVCXrEoFt0S1zcGMZouG7QWjH01YpKnUREvk1qKko0
         ARpg==
X-Gm-Message-State: APjAAAXQHwDH0TAz8PlNfNa/le+BDnygyR4gbkPP+q09FCz1/jwFGqGb
        L+OefkCvbjEq7kdutYj3CkW3lC2TJRL85GkXYyrLwWkRLywk/g==
X-Google-Smtp-Source: APXvYqzrjXF9x63tU7nIMUMgccRV5IqIYdZ9qQhDEb2MN8d8nab7Ed9tgrYrm6RH/peO7Z24CiyVFGoJVj9dgbSBv8o=
X-Received: by 2002:a05:6830:2308:: with SMTP id u8mr23115197ote.2.1574768791781;
 Tue, 26 Nov 2019 03:46:31 -0800 (PST)
MIME-Version: 1.0
References: <20191122154221.247680-1-elver@google.com> <20191125173756.GF32635@lakrids.cambridge.arm.com>
 <CANpmjNMLEYdW0kaLAiO9fQN1uC7bW6K08zZRG=GG7vq4fBn+WA@mail.gmail.com> <20191125183936.GG32635@lakrids.cambridge.arm.com>
In-Reply-To: <20191125183936.GG32635@lakrids.cambridge.arm.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 26 Nov 2019 12:46:19 +0100
Message-ID: <CANpmjNM5tgiyFOt4jW97Dg1ot1LmJC1rcrQX+Q74B28c=t7Kzw@mail.gmail.com>
Subject: Re: [PATCH 1/2] asm-generic/atomic: Prefer __always_inline for wrappers
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 25 Nov 2019 at 19:39, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, Nov 25, 2019 at 07:22:33PM +0100, Marco Elver wrote:
> > On Mon, 25 Nov 2019 at 18:38, Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Fri, Nov 22, 2019 at 04:42:20PM +0100, Marco Elver wrote:
> > > > Prefer __always_inline for atomic wrappers. When building for size
> > > > (CC_OPTIMIZE_FOR_SIZE), some compilers appear to be less inclined to
> > > > inline even relatively small static inline functions that are assumed to
> > > > be inlinable such as atomic ops. This can cause problems, for example in
> > > > UACCESS regions.
> > >
> > > From looking at the link below, the problem is tat objtool isn't happy
> > > about non-whiteliested calls within UACCESS regions.
> > >
> > > Is that a problem here? are the kasan/kcsan calls whitelisted?
> >
> > We whitelisted all the relevant functions.
> >
> > The problem it that small static inline functions private to the
> > compilation unit do not get inlined when CC_OPTIMIZE_FOR_SIZE=y (they
> > do get inlined when CC_OPTIMIZE_FOR_PERFORMANCE=y).
> >
> > For the runtime this is easy to fix, by just making these small
> > functions __always_inline (also avoiding these function call overheads
> > in the runtime when CC_OPTIMIZE_FOR_SIZE).
> >
> > I stumbled upon the issue for the atomic ops, because the runtime uses
> > atomic_long_try_cmpxchg outside a user_access_save() region (and it
> > should not be moved inside). Essentially I fixed up the runtime, but
> > then objtool still complained about the access to
> > atomic64_try_cmpxchg. Hence this patch.
> >
> > I believe it is the right thing to do, because the final inlining
> > decision should *not* be made by wrappers. I would think this patch is
> > the right thing to do irrespective of KCSAN or not.
>
> Given the wrappers are trivial, and for !KASAN && !KCSAN, this would
> make them equivalent to the things they wrap, that sounds fine to me.
>
> > > > By using __always_inline, we let the real implementation and not the
> > > > wrapper determine the final inlining preference.
> > >
> > > That sounds reasonable to me, assuming that doesn't end up significantly
> > > bloating the kernel text. What impact does this have on code size?
> >
> > It actually seems to make it smaller.
> >
> > x86 tinyconfig:
> > - vmlinux baseline: 1316204
> > - vmlinux with patches: 1315988 (-216 bytes)
>
> Great! Fancy putting that in the commit message?

Done.

> > > > This came up when addressing UACCESS warnings with CC_OPTIMIZE_FOR_SIZE
> > > > in the KCSAN runtime:
> > > > http://lkml.kernel.org/r/58708908-84a0-0a81-a836-ad97e33dbb62@infradead.org
> > > >
> > > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > ---
> > > >  include/asm-generic/atomic-instrumented.h | 334 +++++++++++-----------
> > > >  include/asm-generic/atomic-long.h         | 330 ++++++++++-----------
> > > >  scripts/atomic/gen-atomic-instrumented.sh |   6 +-
> > > >  scripts/atomic/gen-atomic-long.sh         |   2 +-
> > > >  4 files changed, 336 insertions(+), 336 deletions(-)
> > >
> > > Do we need to do similar for gen-atomic-fallback.sh and the fallbacks
> > > defined in scripts/atomic/fallbacks/ ?
> >
> > I think they should be, but I think that's debatable. Some of them do
> > a little more than just wrap things. If we want to make this
> > __always_inline, I would do it in a separate patch independent from
> > this series to not stall the fixes here.
>
> I would expect that they would suffer the same problem if used in a
> UACCESS region, so if that's what we're trying to fix here, I think that
> we need to do likewise there.
>
> The majority are trivial wrappers (shuffling arguments or adding trivial
> barriers), so those seem fine. The rest call things that we're inlining
> here.
>
> Would you be able to give that a go?

Done in v2.

> > > > diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
> > > > index 8b8b2a6f8d68..68532d4f36ca 100755
> > > > --- a/scripts/atomic/gen-atomic-instrumented.sh
> > > > +++ b/scripts/atomic/gen-atomic-instrumented.sh
> > > > @@ -84,7 +84,7 @@ gen_proto_order_variant()
> > > >       [ ! -z "${guard}" ] && printf "#if ${guard}\n"
> > > >
> > > >  cat <<EOF
> > > > -static inline ${ret}
> > > > +static __always_inline ${ret}
> > >
> > > We should add an include of <linux/compiler.h> to the preamble if we're
> > > explicitly using __always_inline.
> >
> > Will add in v2.
> >
> > > > diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
> > > > index c240a7231b2e..4036d2dd22e9 100755
> > > > --- a/scripts/atomic/gen-atomic-long.sh
> > > > +++ b/scripts/atomic/gen-atomic-long.sh
> > > > @@ -46,7 +46,7 @@ gen_proto_order_variant()
> > > >       local retstmt="$(gen_ret_stmt "${meta}")"
> > > >
> > > >  cat <<EOF
> > > > -static inline ${ret}
> > > > +static __always_inline ${ret}
> > >
> > > Likewise here
> >
> > Will add in v2.
>
> Great; thanks!

Sent v2: http://lkml.kernel.org/r/20191126114121.85552-1-elver@google.com

Thanks,
-- Marco
