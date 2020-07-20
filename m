Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFFF22705F
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jul 2020 23:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgGTVb3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jul 2020 17:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgGTVb3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jul 2020 17:31:29 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2D1C061794;
        Mon, 20 Jul 2020 14:31:28 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 18so13420617otv.6;
        Mon, 20 Jul 2020 14:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=F3DG5j2CQiF9a3m3vmmNDb/y5vL9QYFQV166fB5VSyg=;
        b=Uw7fCuG0BGzW8Mq3KgbD2uF4gm1QZHMKec8OW6jPcmbf34Izl/UvJilSFuAAQIKfcu
         Gmjgqpo8XZYhnVW2P7MCH2BsDL45XBCCb1bnri4rghnvijVb3snnOkCE6POFr+gJ4Qzg
         1Trots/VNpJLPrzYrHD0GeU9goIMcp0XKukFNsui9F2RwgS/H2qq8MH9cn3PzPhkDxEK
         yE68QZpa5Qa8AMcm1WDYvVNPLKpl6k8Mc9fgHpHlnOgWsCQ8vn+jdCsYGhe251Uype/b
         Zmbn88NT76Tsf5GlZNdsnBB3Surttk0tz5E8BrWvBYm9zmDvW6tK66+tVLwrDWwamy5Q
         hDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=F3DG5j2CQiF9a3m3vmmNDb/y5vL9QYFQV166fB5VSyg=;
        b=i7geIOVJyO10mLftZXXvAcfupo07FZwwTLblainjeyNby8Fgbm2uSyQCTgCsL8I8gd
         xaA43G2NlqpDHEVRW+VbN9Z+IP1KM5xJiVV4Oi9j+B//5uJD65D9iPp/tXXag//D9KBg
         vj2Mb4N8WM9pavLdx/ZJJBwahxK61qaxmVWdMOjrwJNQFDckbUbI0FvEiXeccKbdmUMS
         vzlIfgHF7lU6B5j5ESmg8rbh+bFk3IVW0URgySTwRZtIiqJ2Auc2AUbVAUm4odQo0Whw
         I7QRgL83Glk6FlLb7+bmR95TjZ53UZ4NNNzXtmsqVv2ARvsKWm50jwdZ7cCN6sAZE6qV
         vcUg==
X-Gm-Message-State: AOAM533d8ymg5mgJSW2kytBFIlcZaaxImVsnIya2GBJ9djxxkhpw09KL
        4OJ1oCnVFXFw3uKjw+SIPFgu5I4h8mXj2v0zwfM=
X-Google-Smtp-Source: ABdhPJxX1M5v1Jnr5QqGZEDYkrNWO688vjA9QMhjA3NFxtcvrGdlSN489ePp5LJy8OQsQrrRNSZd4gh1ukV8VoLAcYE=
X-Received: by 2002:a05:6830:2081:: with SMTP id y1mr21381138otq.114.1595280688037;
 Mon, 20 Jul 2020 14:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <1593020162-9365-1-git-send-email-Dave.Martin@arm.com>
 <c17e330c-69f7-da7a-feae-cb8b8f5d7ea0@gmail.com> <20200720165205.GI30452@arm.com>
In-Reply-To: <20200720165205.GI30452@arm.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Mon, 20 Jul 2020 23:31:16 +0200
Message-ID: <CAKgNAkggayFEjHgPNu1HzvXGfSDoCq=Y-Ni4iv=RBYk2Eb6U1Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] prctl.2 man page updates for Linux 5.6
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Dave,

TL;DR: don't worry about the small stuff; I'm happy to do the minor
edits given the high quality of your patches.

On Mon, 20 Jul 2020 at 18:52, Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Mon, Jun 29, 2020 at 01:52:24PM +0200, Michael Kerrisk (man-pages) wrote:
> > Hi Dave,
> >
> > On 6/24/20 7:36 PM, Dave Martin wrote:
> > > A bunch of updates to the prctl(2) man page to fill in missing
> > > prctls (mostly) up to Linux 5.6 (along with a few other tweaks and
> > > fixes).
> > >
> > > Patches from the v2 series [1] that have been applied or rejected
> > > already have been dropped.
> > >
> > > All that remain here now are the SVE and tagged address ABI controls
> > > for arm64.
> > >
> > >
> > >
> > > [1] https://lore.kernel.org/linux-man/1590614258-24728-1-git-send-email-Dave.Martin@arm.com/
> > >
> > >
> > > Dave Martin (2):
> > >   prctl.2: Add SVE prctls (arm64)
> > >   prctl.2: Add tagged address ABI control prctls (arm64)
> > >
> > >  man2/prctl.2 | 331 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 331 insertions(+)
> > Thanks. I've pushed these changes to master now.
>
> Thanks -- btw I finally got around to reviewing master, and noted a few
> editorial changes that man-pages(7) does not make any statement about:
>
> "arg1, arg2, and arg3"
>
>         Do you strictly prefer the command before "and" here?
>
>         Conventionally, the final comma would typically be omitted in
>         prose, except where the list members are complex enough that the
>         command is required to assist parsing.  However, lists of formal
>         arguments are not quite vanilla prose.

There are two camps wrt that comma. I prefer the so-called Oxford
comma convention, as shown above. man-pages uses it generally.

> "Providing that" -> "Provided that"
>
>         Any particular rationale here?

Either would be fine; the past tense is just slightly better, to my ear.

> "error EFOO" -> "the error EFOO"
>
>         Is this a rule, in general?

I think the change that you refer to was actually: "with EFOO" to
"with the error EFOO". The former is just a little too brief, to my
ear.

> .IP \(bu 2
>
>         I assumed that specifying an explicit indentation amount would
>         be fragile.  Going with the default behaviour also tends to
>         result in a more consistent appearance.  Do you have any
>         recommandations in this area?
>
>         Do you have rules about the order to use bullet symbols?  I tend
>         to avoid \(bu if possible, since while it's "correct", nroff can
>         render it nastily as an unadorned letter "o" (e.g., with -Tascii
>         or LC_CTYPE=C).  This is particlarly annoying if the indent is
>         <= 2, since then the "o" tends to be visually swallowed by the
>         following text (i.e., to a casual glance it looks like a word,
>         particlarly if the following text is not capitalised).  Perhaps
>         this is a bad glyph substitution decision in nroff rather than
>         something that should be fixed in the man-pages source, but the
>         man-pages source may be easier to fix...
>
>         There is already inconsistency here: there are may top-level
>         lists using ".IP *" in prctl.2, and plenty of places where the
>         default indentation is used.

I must admit that I'm in the process of rethinking bulleted lists, and
I have not come to a conclusion (and that's why nothing is said in
man-pages(7), and also why there is currently inconsistency).

Using .IP with the default indent (8n) results in a very deep indent
between the glyph and the text, so it's not my preference.

Your note about the poor rendering with "-Tascii" is interesting.
Perhaps ".IP \(bu 3" may be better. But, I really do not know: do
people really render with "-Tascii" these days?

> Should any of these be written up in man-pages(7), or is there a checker
> than can detect them?

Perhaps man-pages should say something about the Oxford comma.

> I wan't to minimise the amount of tweaking you have to do when merging
> patches.

If every patch that I received was of the same quality as yours are,
my life would be much easier. The tweaks are minimal work on my part.
Don't worry. Just send me more patches :-).

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
