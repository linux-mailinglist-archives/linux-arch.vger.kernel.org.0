Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB7451A8F0
	for <lists+linux-arch@lfdr.de>; Sat, 11 May 2019 19:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfEKRwA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 May 2019 13:52:00 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34396 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfEKRv7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 May 2019 13:51:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id j24so6852709ljg.1
        for <linux-arch@vger.kernel.org>; Sat, 11 May 2019 10:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oaeXZZDv7nk/NFiZCevhSY5ipAOiI6kKAyNxXRM162A=;
        b=gYUKeQFkZfPF+SBFGZsaxSPX55GAIAS/b1OL8l3HnOId4D1oRMFa3K7gUFrPcwRrwy
         APK5QWg5R2UiE0UN3c1Dva/PzQWGeJlJ5tHgbq3gjrlKhO0guDRYzfDmlm0/LX/2qE9B
         K7S0QKKNg6ex1rQUDLj3zMpwysbA0a21x1Q6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oaeXZZDv7nk/NFiZCevhSY5ipAOiI6kKAyNxXRM162A=;
        b=PhkprCVwQg26oa69D4ZdcV+o4YEOY+Z3ZHiVFrywCsuetw+SEZbaZQbHT9O5mEBpeS
         szZ8SXvhFtlQ0ZkJGhuEWmlObo5yBBsi46cV1t+OH7bdSHhuo4JsQjgPXxGVItdc2pzO
         p70s+0yjWgo2WJW/K5ubWVitCF2OeUbN0Wp922UfYlyN9xNyTgy8WLvzezyWVKw5E/aC
         SL+1V1HA3+0bWVqQtVtgALGn13LE0x21GWcB/DXmRh1Wlt1IHS/KwGO38yZ6D3cwk/CV
         ID4wMJDy6NkAJT5z2AM3eMpbV1dvsWBacrnH9sAxdc3PodGUdo6BDA5ZUWFlbxcLH7ls
         FkKg==
X-Gm-Message-State: APjAAAXMbQp+zu1t1UdmKkBX0aLsv8TBjABxpePC9NwjF6mmGPxrs4dX
        YftYGphuEMAHDlgBGXiGvTMmnQHnTug=
X-Google-Smtp-Source: APXvYqynJWVGlIEBLIDRJpOeE6sdTS7aGf1uiRjIaiEQfg7YTHCMAZbnhf0urXIPuqW466HoAbQVmw==
X-Received: by 2002:a2e:85d2:: with SMTP id h18mr9073671ljj.128.1557597117714;
        Sat, 11 May 2019 10:51:57 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id y25sm2418894lfj.16.2019.05.11.10.51.57
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 10:51:57 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id m20so7659940lji.2
        for <linux-arch@vger.kernel.org>; Sat, 11 May 2019 10:51:57 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr8365865ljj.79.1557596640790;
 Sat, 11 May 2019 10:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190506165439.9155-1-cyphar@cyphar.com> <20190506165439.9155-6-cyphar@cyphar.com>
 <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
 <20190506191735.nmzf7kwfh7b6e2tf@yavin> <20190510204141.GB253532@google.com>
 <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com>
 <20190510225527.GA59914@google.com> <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net>
 <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com>
 <CAHk-=whOL-NBso8X5S8s597yZEOMBoU8chkMFVTi8b-ff2qARg@mail.gmail.com> <20190511173113.qhqmv5q5f74povix@yavin>
In-Reply-To: <20190511173113.qhqmv5q5f74povix@yavin>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 May 2019 13:43:44 -0400
X-Gmail-Original-Message-ID: <CAHk-=wgo-X9pDbVf8khfDsgEKn3wSvLJkB890OxHL+42Hosypw@mail.gmail.com>
Message-ID: <CAHk-=wgo-X9pDbVf8khfDsgEKn3wSvLJkB890OxHL+42Hosypw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 11, 2019 at 1:31 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> Yup, I've dropped the patch for the next version. (To be honest, I'm not
> sure why I included any of the other flags -- the only one that would've
> been necessary to deal with CVE-2019-5736 was AT_NO_MAGICLINKS.)

I do wonder if we could try to just set AT_NO_MAGICLINKS
unconditionally for execve() (and certainly for the suid case).

I'd rather try to do these things across the board, than have "suid
binaries are treated specially" if at all possible.

The main use case for having /proc/<pid>/exe thing is for finding open
file descriptors, and for 'ps' kind of use, or to find the startup
directory when people don't populate the execve() environment fully
(ie "readlink(/proc/self/exe)" is afaik pretty common.

Sadly, googling for

    execve /proc/self/exe

does actually find hits, including one that implies that chrome does
exactly that.  So it might not be possible.

Somewhat odd, but it does just confirm the whole "users will at some
point do everything in their power to use every odd special case,
intended or not".

                  Linus
