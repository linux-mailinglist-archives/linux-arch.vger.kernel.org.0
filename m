Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C21A115C041
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 15:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgBMOZU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 09:25:20 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44886 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgBMOZU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 09:25:20 -0500
Received: by mail-qk1-f196.google.com with SMTP id v195so5768715qkb.11
        for <linux-arch@vger.kernel.org>; Thu, 13 Feb 2020 06:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bc0b7TzZN/NSWX0NFmEbYxGFh6qjkw/pK6nZDwFtVfU=;
        b=e72tivqYvQ7hzD1hDEOyR4fyZzUUauEuzvGQ1N6vlP9FlkxL9ARfbqgtUfkupK82HE
         QkWjAEhiFncYm+atr/0aEnCDVDNTgaMxj0/Pwg9HQmhiF5/yPOhPnh0lTZhCD+DUthjp
         efugfVtBDen1rlDtGrdP9N7pjEOdNHRqT8Rhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bc0b7TzZN/NSWX0NFmEbYxGFh6qjkw/pK6nZDwFtVfU=;
        b=mM08OGqcJ2DwYFDW6G4AWrJIlJNmgTCzuQEjmXrfzn2Pdnm5kMNdUW44pR9dkUqwKD
         FEUMZbxbVbxNHiSuj4bnSyw2ktTystiq2mSgDK5bGiCrm2RY2OkendX+UjOISf4kbpwN
         HxhwUYpClFiVJ+IXZTpIoQZGbPhT1AUtOnOdY3Lvg8cR+Dfvi755TeMGv2oQfSOKqIWd
         vZbRFKHkgz4EJsexzCsgdIQt0hahsRqg7XRVGgafIk153fTakqQVnq9WK+LhVDdyHxBY
         rmSzkcHYBJYaoCC0QvFtrFw+QtzcZ9pl71rZvyJWlQO0kt/7vRG6ygsQt/RH98GbdI48
         uvWA==
X-Gm-Message-State: APjAAAW80vii+NyhAOEsg8DREWoM5Hw2fWvhvRP2Ea2GIi63AhonCGD7
        1evpRPeT9lyhGYxWRpLqQku683PCC/09OxE6IavptA==
X-Google-Smtp-Source: APXvYqyqVlaAznCrTjgFnMS/rbNzkVZ+JXaavI7b9i3sKA5vbbQy2odANJfyMh8Z8Llpqed5LUZncN0z3LiE3my3DaQ=
X-Received: by 2002:a37:6d47:: with SMTP id i68mr16018376qkc.228.1581603919781;
 Thu, 13 Feb 2020 06:25:19 -0800 (PST)
MIME-Version: 1.0
References: <20200212210139.382424693@infradead.org> <20200212210749.915180520@infradead.org>
 <20200212223818.GA115917@google.com> <20200212204128.20f5e8ba@oasis.local.home>
In-Reply-To: <20200212204128.20f5e8ba@oasis.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 13 Feb 2020 09:25:08 -0500
Message-ID: <CAEXW_YSddXU++o7xpi-0kzg9GA6UkM5FsnoXjLQ=gAFBjPf=RA@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] rcu: Mark rcu_dynticks_curr_cpu_in_eqs() inline
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 12, 2020 at 8:41 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 12 Feb 2020 17:38:18 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > I think there are ways to turn off function inlining, such as gcc's:
> > -fkeep-inline-functions
> >
> > And just to be sure weird compilers (clang *cough*) don't screw this up,
> > could we make it static inline notrace?
>
> inline is defined as notrace, so not needed.
>
> I did that because of surprises when functions marked as inline
> suddenly became non inlined and traced, which caused issues with
> function tracing (before I finally got recursion protection working).
> But even then, I figured, if something is inlined and gcc actually
> inlines it, it wont be traced. For consistency, if something is marked
> inline, it should not be traced.

Ah I see it, thanks for the clarification Steve! That looks like a
good idea. I withdraw my previous comment.

- Joel
