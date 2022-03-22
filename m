Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC37E4E445F
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 17:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbiCVQlZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 12:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239183AbiCVQlZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 12:41:25 -0400
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900AB6E55A;
        Tue, 22 Mar 2022 09:39:57 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id q5so24692548ljb.11;
        Tue, 22 Mar 2022 09:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+z636ynkHRELaXITIsopPF4jHcBApicZM14jpe3tGzw=;
        b=irezaqSSqLdBt2qMZCJXvCoI59MgJq1a9F0UUWvONPJshU+4JxJoVRxNyZnERccXsz
         ynHguFT4GwcBe7H7rLjmkM67Ka0G4D4uPFLWp+IAF6tfp3XKUCuWuvYDIxWiUM9q54Be
         AcGiyBiiXVzu4kI88rja0zM5kwWHelbGEjUlQESeK5Mz9HbdYDNDSn4HcVvDnsIPD9nm
         yGOxjD/dcOtueEL6l5qvqgit4rinqp140A4hwdeyNciJCmqQpZ/xeQuKoymZKEo0N7sN
         A0nUYrSHpRRyu/P5uGRFYKwf8K+yx1ubqF0qv3KJsy3iPRQ7BCLP4w65VRM3Irc87eiK
         tAPA==
X-Gm-Message-State: AOAM531YGS9h/Cg/of5kqx+sPis+bAr/FgJnrfZ3EbRQU+ZxZXcBnu+h
        29eJxY6hY8Dj2zFrgssd/PA93WPZy53mlbp7b6w=
X-Google-Smtp-Source: ABdhPJzmNwaA+S9mbxm3QKGORbTHyOH3ENafnCoDzOrBSFZyJBcREvJ28TfDn85NU4dHlg3bhXm3A16Z16QxW8c9cGY=
X-Received: by 2002:a05:651c:1549:b0:249:9448:d643 with SMTP id
 y9-20020a05651c154900b002499448d643mr1916178ljp.457.1647967195779; Tue, 22
 Mar 2022 09:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220316224548.500123-1-namhyung@kernel.org> <20220316224548.500123-3-namhyung@kernel.org>
 <YjSBRNxzaE9c+F/1@boqun-archlinux> <YjS2rlezTh9gdlDh@hirez.programming.kicks-ass.net>
 <CAM9d7cjUR6shddKM2h9uFXgQf+0F504fnJmKRSfc3+PG3TmEyg@mail.gmail.com>
 <20220318180750.744f08d4@gandalf.local.home> <CAM9d7ci-91efxreUvLBhkAcs0rpngzR9+3BnZBDb4zLai2Ewcw@mail.gmail.com>
 <CAM9d7cgCEsH6grH556Js6VX-cXAO_3hT7C+RSm+sxxBDgxHvig@mail.gmail.com> <20220322085915.6c2e7ff9@gandalf.local.home>
In-Reply-To: <20220322085915.6c2e7ff9@gandalf.local.home>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 22 Mar 2022 09:39:44 -0700
Message-ID: <CAM9d7ciG3Oq7VutnRpzDLqA0Cbkg=D8Aw_Gv1gC+F7+haSzf-g@mail.gmail.com>
Subject: Re: [PATCH 2/2] locking: Apply contention tracepoints in the slow path
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Radoslaw Burny <rburny@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 22, 2022 at 5:59 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 21 Mar 2022 22:31:30 -0700
> Namhyung Kim <namhyung@kernel.org> wrote:
>
> > > Thanks for the info.  But it's unclear to me if it provides the custom
> > > event with the same or different name.  Can I use both of the original
> > > and the custom events at the same time?
>
> Sorry, missed your previous question.

No problem!

>
> >
> > I've read the code and understood that it's a separate event that can
> > be used together.  Then I think we can leave the tracepoint with the
> > return value and let users customize it for their needs later.
>
> Right, thanks for looking deeper at it.

And thanks for your review.  I'll post a v4 soon.

Thanks,
Namhyung
