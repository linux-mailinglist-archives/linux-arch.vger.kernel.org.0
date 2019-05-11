Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE8161A8C7
	for <lists+linux-arch@lfdr.de>; Sat, 11 May 2019 19:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfEKReO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 May 2019 13:34:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43634 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfEKReO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 May 2019 13:34:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id u27so6247079lfg.10
        for <linux-arch@vger.kernel.org>; Sat, 11 May 2019 10:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D4GLGKJGBr1goNxWtth5dS3A9rH5i7tbT3DW+t/vUZM=;
        b=RiMckZqa7Pv2uJ6Jmq8WdsP1tgxvuMAA1KBrEXFSuTYRZg0dss6QUXLstX+qPl0cvi
         kW8HRPGc+o9zzUTLZU0Mhh/HlnQjlbSLAThZ8m9T+v+XaeUReplqMDf56AEvKd5qKIy7
         GzSd2O/qDYd43VAL+FXerAe7FQ27GBViWurwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4GLGKJGBr1goNxWtth5dS3A9rH5i7tbT3DW+t/vUZM=;
        b=W2rrb1SPzYD92pM0MrZUJ5eh2A2+6B4T7yjSIKIMGNU85hnzWSUJMDjkQ81tbozzbj
         85I3DmlbaiMszQPo436wSH+l+YLSkTn3L7A9h4ssLs3LqWMji6aU+80j6JBQw3FPFSUc
         sYKNVcy1PkNUMUYDX9oE4xv4OkPs/lnZuyxILX6LhG/tKsgSTVt3CPnkKK5NgJABNGDL
         d1YSAMxXTOKm+HcLvrTpc9oOzoTfjpy5EVwoucUFmLCJK1+1c8qWLOqVjI0SFaPZQq0c
         SZ0dU0A+W3TWjUvAlezSSxNMqJK/LBzZ1XU+71e+Wcjq7BY+FZm8/MZCdRb7l5omgLFu
         SbZw==
X-Gm-Message-State: APjAAAVp7TmsNjqhD01j/atFyDmzk+gTmvoIWFaziCAUA69l+pmwlrs9
        7RQPNgJLQeISDwcZkAfudKdgHR22p9s=
X-Google-Smtp-Source: APXvYqwDxnrUjMjjBCmAHMF21Q1nMe+de6qIJC7gewKoIUL7IRWZpnG5bbfAee7y0lAU73DYXmR+Lg==
X-Received: by 2002:a19:6b0e:: with SMTP id d14mr7164347lfa.137.1557596052914;
        Sat, 11 May 2019 10:34:12 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id o7sm2213358lfl.13.2019.05.11.10.34.12
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 10:34:12 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id h13so6266050lfc.7
        for <linux-arch@vger.kernel.org>; Sat, 11 May 2019 10:34:12 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr9073466lfg.88.1557595631432;
 Sat, 11 May 2019 10:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190506165439.9155-1-cyphar@cyphar.com> <20190506165439.9155-6-cyphar@cyphar.com>
 <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
 <20190506191735.nmzf7kwfh7b6e2tf@yavin> <20190510204141.GB253532@google.com>
 <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com>
 <20190510225527.GA59914@google.com> <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net>
 <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 May 2019 13:26:55 -0400
X-Gmail-Original-Message-ID: <CAHk-=whOL-NBso8X5S8s597yZEOMBoU8chkMFVTi8b-ff2qARg@mail.gmail.com>
Message-ID: <CAHk-=whOL-NBso8X5S8s597yZEOMBoU8chkMFVTi8b-ff2qARg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
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

On Sat, May 11, 2019 at 1:21 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Notice? None of the real problems are about execve or would be solved
> by any spawn API. You just think that because you've apparently been
> talking to too many MS people that think fork (and thus indirectly
> execve()) is bad process management.

Side note: a good policy has been (and remains) to make suid binaries
not be dynamically linked. And in the absence of that, the dynamic
linker at least resets the library path when it notices itself being
dynamic, and it certainly doesn't inherit any open flags from the
non-trusted environment.

And by the same logic, a suid interpreter must *definitely* should not
inherit any execve() flags from the non-trusted environment. So I
think Aleksa's patch to use the passed-in open flags is *exactly* the
wrong thing to do for security reasons. It doesn't close holes, it
opens them.

                Linus
