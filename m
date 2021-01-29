Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D303090A4
	for <lists+linux-arch@lfdr.de>; Sat, 30 Jan 2021 00:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhA2XbY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 18:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhA2XbV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 18:31:21 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377C7C061573
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 15:30:41 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u11so6180149plg.13
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 15:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wQXKy21pEcRclb3wAZG5ISCNN6W5kQy6JQslnD7Vmx0=;
        b=QpFH+sYq9frbG1nqLvcOEsHB/q0UQxlaH0k6imY5kj6e1nFQjF4bMWPoSCJJNsmSjq
         TYqorWB5pdzjpJvp3tAKpSQenuvRmE4jvmPmPGfnz34LWAJqMcqmRJOhtc7hQ9M4JuG0
         9NwkrdUsFjQ6nZqCG+dVGSoTzgTuhMPhZuWJIsHUfE7M4reRjSQzJsIErsxfJx0e9Ewl
         a2eJQCVLrjVf7+3NYaa9oMpoK0rAAFE9Paps6Z4CMq82EtCQGr0OpPt47BGyhSlVXBlY
         8PqFBJt+pQcjBcBmRzgH6zaxQ4Mb77o/ZrXmg/y7FrsigvGjBCa2tPHG/9T3iQsHmIcL
         l9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQXKy21pEcRclb3wAZG5ISCNN6W5kQy6JQslnD7Vmx0=;
        b=dJkdzmX0f5TiGoA5ZNK1IMTzVtiidx5OK/OBh1ViZEVV1E/2WUOQyrfq7y2Y04kD1W
         HphP8ebwH/s9LJW/MNUmgoWrtdGsAhc0W8xYpbhY5eoWtzZZoMfmxkPMqHkAoUcEK6qr
         aAhMoLceTJ0drQKYTw/0yoewLq1C6tj+8JfVVQLm5BsPJOR327x45gDxyVd11StSefPg
         WA59sXC8gHKlWQwstx+fiRdcb1uYWKiMS+IfqZDA6yrp2KUsXDcEsbP/8HsUdkZt5S2j
         M4E5uBv2Jcg5q3eap9t6xl8eOFzD1w7kNnVF7/0pWrip2e6dXNgXuvNoI4MQbAaFGA6d
         hAxA==
X-Gm-Message-State: AOAM533Al1ww1grzpgptkVPywPSb38Ia8LkIf4mGEJ+FAZb8VVkw+K79
        9UkXIKgMPaeAAdQg3AdRc/f8JkfWcV805wScSj4+wQ==
X-Google-Smtp-Source: ABdhPJxWbqroS4GY8wD0aOcFCDcRe5dSwHiVZ5LIk65NCeueYb4W6ufs+KdY6D+ZkjIlCKZLLQzDDX7Zo/Z760ymWzg=
X-Received: by 2002:a17:902:ed94:b029:de:8844:a650 with SMTP id
 e20-20020a170902ed94b02900de8844a650mr6619051plj.56.1611963040680; Fri, 29
 Jan 2021 15:30:40 -0800 (PST)
MIME-Version: 1.0
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-3-ndesaulniers@google.com> <CA+icZUX4q-JhCo+UZ9T3FhbC_gso-oaB0OR9KdH5iEpoGZyqVw@mail.gmail.com>
 <CAKwvOdnj1Np62+eOiTOCRXSW6GLSv4hmvtWaz=0aTZEEot_dhw@mail.gmail.com>
 <20210129205702.GS4020736@tucnak> <CAKwvOdmuSaf28dOdP8Yo6+RyiviMNKcq8JY=-qgbwjbPVwHmLw@mail.gmail.com>
 <20210129211102.GT4020736@tucnak> <CAKwvOdm-+xK=diSKKXXnS2m1+W6QZ70c7cRKTbtVF=dWi1_8_w@mail.gmail.com>
 <20210129220939.GY4020736@tucnak> <CAKwvOdnte8Ck1ywodbY7ED7U046j06C+D-ZcW6kS-fqyaJbmCQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnte8Ck1ywodbY7ED7U046j06C+D-ZcW6kS-fqyaJbmCQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 Jan 2021 15:30:29 -0800
Message-ID: <CAKwvOdkx=4SZAo_pxduWG=SvDNET14eo2ad4FeHvxHUcSZGbTA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] Kbuild: implement support for DWARF v5
To:     Jakub Jelinek <jakub@redhat.com>, Nick Clifton <nickc@redhat.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 3:25 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Jan 29, 2021 at 2:10 PM Jakub Jelinek <jakub@redhat.com> wrote:
> >
> > On Fri, Jan 29, 2021 at 02:05:59PM -0800, Nick Desaulniers wrote:
> > > Ah, I see.  Then I should update the script I add
> > > (scripts/test_dwarf5_support.sh) to feature detect that bug, since
> > > it's the latest of the bunch.  Also, should update my comment to note
> > > that this requires binutils greater than 2.35.1 (which is what I have,
> > > which fails, since the backport landed in ... what?!)  How was this
> > > backported to 2.35
> > > (https://sourceware.org/bugzilla/show_bug.cgi?id=27195#c12, Jan 26
> > > 2021) when binutils-2_35_1 was tagged sept 19 2020?  Or will there be
> > > a binutils 2.35.2 point release?
> >
> > AFAIK yes, soon.
>
> Err...perhaps https://sourceware.org/bugzilla/show_bug.cgi?id=27195
> was about `.file 0`, but it looks like `.file 1 "filename" md5
> 0x7a0b65214090b6693bd1dc24dd248245` without -gdwarf-5. Specifically
> the md5 ... .
>
> So https://sourceware.org/bugzilla/show_bug.cgi?id=25611 needs a rework perhaps?

$ echo '.file 1 "filename" md5 0x7a0b65214090b6693bd1dc24dd248245' |
binutils-gdb/gas/as -
{standard input}: Assembler messages:
{standard input}:1: Error: junk at end of line, first unrecognized
character is `m'
$ echo '.file 1 "filename" md5 0x7a0b65214090b6693bd1dc24dd248245' |
binutils-gdb/gas/as -gdwarf-5 -
$

https://sourceware.org/bugzilla/show_bug.cgi?id=27280
-- 
Thanks,
~Nick Desaulniers
