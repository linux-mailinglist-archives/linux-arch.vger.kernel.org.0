Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8E317ECDD
	for <lists+linux-arch@lfdr.de>; Tue, 10 Mar 2020 00:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgCIXwK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Mar 2020 19:52:10 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32795 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgCIXwK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2020 19:52:10 -0400
Received: by mail-oi1-f196.google.com with SMTP id q81so12081256oig.0;
        Mon, 09 Mar 2020 16:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o4lgiWH6eSguIJ+rpfWkJ3kTc3LqylAb1v0iFg82xVM=;
        b=fyg2S+K7jn/qeT9SgWQmqN2geEgL65yx1H+rp5dCEV5PiPqK6ni9UqjEfhJfsgoYaW
         OziD6jaWal/oW3ui7xlXuTch25yO5o22rGOlNiUK5YmTxJh5jehHuiLNSzBszIN6EtX3
         FrTk+Aj1ToutZgYVqlzApuoQLjLKFsmKpz/w+eMQPBcLDX1pGXaQPDHRvWEAyPktuZVD
         cmqOIzRYB0UeOH/pENt97g0eaUUAdFksLKMVrcnH4xtgwdC3a3f3j2xPzohJeWb/1dD6
         rDcMDBEK3h/W2+BvLcnxPhuhQalhW+3B2lKG9z/3a0N/RsNgVuDjidisF35y5lXkfYMW
         1loA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o4lgiWH6eSguIJ+rpfWkJ3kTc3LqylAb1v0iFg82xVM=;
        b=K9inyATudbDqwinGIwiQDFqZtLorQK8jIOIyVeMJ6Higm2UkFcZKdLTKU7sZU7+LYO
         iTGRrMPJZTdfEOFUHTaX3RR7iePHZDtuIQhO86APsOpXLPmsYzU1fvQ2SK3p0Gs1BD9l
         WF+jtsvYS2AspvkYMzKv29mzXiL/NGspHalzgRASHWPcSD14lcQIp3yX2H8U4U8IiDHJ
         bA7wogdbCri/dcD2KCTsSPjUvWGnq21WiyTFTjfOKI44epore8kBOIEgRHJGVhCWivLa
         0LcmQe1zEmgHa8Am9juxnX139oeF6CJaPeGCpS1Nk6LCpXzBIOWomlg7wOw2P2bvmGII
         YDkA==
X-Gm-Message-State: ANhLgQ0pf8OnGdWNHasf4bVn8/RaPuCWQ+zOn5rsu3yxAhn7/zOOf1Me
        A+LEeFCnrlfiTwljEWCni5LZWIn0/Z6wwv3GDbE=
X-Google-Smtp-Source: ADFU+vtEjAEHBi2r0HOKp9WNI5n1E/YGOoHJGFBrfYB7gKDnfNXOVIOjv6F5WCNaeeh2EliI2CYabh3NkPzI97TzCXc=
X-Received: by 2002:a05:6808:56:: with SMTP id v22mr1166010oic.116.1583797929940;
 Mon, 09 Mar 2020 16:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAMe9rOoRTVUzNC88Ho2XTTNJCymrd3L=XdB9xFcgxPVwAZ0FWA@mail.gmail.com>
 <AE81FEF5-ECC5-46AA-804D-9D64E656D16E@amacapital.net> <CAMe9rOoDMenvD9XRL1szR5yLQEwv9Q6f4O7CtwbdZ-cJqzezKA@mail.gmail.com>
 <0088001c-0b12-a7dc-ff2a-9d5c282fa36b@intel.com> <CAMe9rOqf0OHL9397Vikgb=UWhRMf+FmGq-9VAJNmfmzNMMDkCw@mail.gmail.com>
 <56ab33ac-865b-b37e-75f2-a489424566c3@intel.com> <CAMe9rOrzrXORQgcAwzGn+=PBvxCEgc5Km_TQq+P7uoqwiacJSA@mail.gmail.com>
 <c06073a2-6858-d5dc-d74b-ef2568bd9423@intel.com>
In-Reply-To: <c06073a2-6858-d5dc-d74b-ef2568bd9423@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 9 Mar 2020 16:51:33 -0700
Message-ID: <CAMe9rOrxM=RefftngNXhP906mrW1SMy7vp+O=yOj_WwcdQpGcg@mail.gmail.com>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 9, 2020 at 4:21 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 3/9/20 4:11 PM, H.J. Lu wrote:
> > A threaded application is loaded from disk.  The object file on disk is
> > either CET enabled or not CET enabled.
>
> Huh.  Are you saying that all instructions executed on userspace on
> Linux come off of object files on the disk?  That's an interesting
> assertion.  You might want to go take a look at the processes on your
> systems.  Here's my browser for example:
>
> # for p in $(ps aux | grep chromium | awk '{print $2}' ); do cat
> /proc/$p/maps; done | grep ' r-xp 00000000 00:00 0'
> ...
> 202f00082000-202f000bf000 r-xp 00000000 00:00 0
> 202f000c2000-202f000c3000 r-xp 00000000 00:00 0
> 202f00102000-202f00103000 r-xp 00000000 00:00 0
> 202f00142000-202f00143000 r-xp 00000000 00:00 0
> 202f00182000-202f001bf000 r-xp 00000000 00:00 0
>
> Lots of funny looking memory areas which are anonymous and executable!
> Those didn't come off the disk.  Same thing in firefox.  Weird.  Any
> idea what those are?
>
> One guess: https://en.wikipedia.org/wiki/Just-in-time_compilation

jitted code belongs to a process loaded from disk.  Enable CET in
an application which uses JIT engine means to also enable CET in
JIT engine.  Take git as an example, "git grep" crashed for me on Tiger
Lake.   It turned out that git itself was compiled with -fcf-protection and
git was linked against libpcre2-8.so.0 also compiled with -fcf-protection,
which has a JIT, sljit, which was not CET enabled.  git crashed in the
jitted codes due to missing ENDBR.  I had to enable CET in sljit to make
git working on CET enabled Tiger Lake.  So we need to enable CET in
JIT engine before enabling CET in applications which use JIT engine.


-- 
H.J.
