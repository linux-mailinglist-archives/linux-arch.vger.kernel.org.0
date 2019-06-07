Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 189FE39708
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2019 22:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbfFGUqy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jun 2019 16:46:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45777 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730242AbfFGUqy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 16:46:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id s11so1810390pfm.12
        for <linux-arch@vger.kernel.org>; Fri, 07 Jun 2019 13:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=XukHmQruicw8IlfF6jJ6jVCYF0PSAeCd61ALsjzTSpY=;
        b=VWI7VCl5285LdP7wOr87pA6+IQYIq/ZxhBxJbF1/nckLiWb00yMLQlkMSFh4MCmFIq
         /dqJBvYXqKj4YcUgfT3KURvRXmso7VPKa0tgm8V0RDBhXkf0XYt6MYFS8iutMKKpfXs1
         J2m1rqQfTl0vttXXt7TvR91asPuMao/Avd04hxQKWY3DGbO6e9kqdOSNRzrBeSbR421E
         Rf9Al37d+zkA1bJ2NtyUgJkERotLKfbY8cpTiNFxW3h5PvRE0rml/0f46+ey+IgUyxqM
         XOCqZ7ORzhd+wlc9aCrEgSryqbXOT4+W665Z56TP/EMr2yUjbSDUZKj9n9UphV69nzc1
         Elxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=XukHmQruicw8IlfF6jJ6jVCYF0PSAeCd61ALsjzTSpY=;
        b=YnT5XTfx84IWc4I1cY0/z26usI2LpjeGV8Zufov0DcXIWpXBHqcghBScq+mtdSb9YZ
         SUS8daxP7dA9q7SXA2t7n1X7B7kduYbHOmLyedbTqvniWUV8vJJf2gPcnKJAue/WKatC
         doPn8Vk5/Rcmui7yDzAezwpgBQds8GZJM2gMAfFBZUYUj+1qKgMYwGWkV8aitvoQ1e4n
         vQQm4XSqAUMlX7+iLasno4sY715uSaaKskGKQjF9FBDYJ4/fF7PcKwRiouNQF8Yk/fGc
         aGK2bXXO66/8EHYiX5eTHSuCFeRHMpLeRT9iE+nV4Ecbgyc5KDb/Jihui8csZzJO7Q/+
         u+/w==
X-Gm-Message-State: APjAAAVkQX3A4/qMv8quEWy+GFOep1vNwS98KRfjhyZdnzC4MjibpIqI
        Sk+088986WgYAVdy/joOqtivkw==
X-Google-Smtp-Source: APXvYqxhFk60QtRVzTldpmH+7yv8QONLVQH+CovTP9/QHWOvUlZZE4M5xtzQoodB8aOtHfr02eU7Pw==
X-Received: by 2002:aa7:808d:: with SMTP id v13mr60783415pff.198.1559940413359;
        Fri, 07 Jun 2019 13:46:53 -0700 (PDT)
Received: from ?IPv6:2600:1012:b018:c314:403f:c95d:60d3:b732? ([2600:1012:b018:c314:403f:c95d:60d3:b732])
        by smtp.gmail.com with ESMTPSA id 14sm3068901pgp.37.2019.06.07.13.46.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 13:46:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup function
Date:   Fri, 7 Jun 2019 13:43:15 -0700
Message-Id: <25281DB3-FCE4-40C2-BADB-B3B05C5F8DD3@amacapital.net>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com> <20190606200926.4029-4-yu-cheng.yu@intel.com> <20190607080832.GT3419@hirez.programming.kicks-ass.net> <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com> <20190607174336.GM3436@hirez.programming.kicks-ass.net> <b3de4110-5366-fdc7-a960-71dea543a42f@intel.com> <34E0D316-552A-401C-ABAA-5584B5BC98C5@amacapital.net> <7e0b97bf1fbe6ff20653a8e4e147c6285cc5552d.camel@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
In-Reply-To: <7e0b97bf1fbe6ff20653a8e4e147c6285cc5552d.camel@intel.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
X-Mailer: iPhone Mail (16F203)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Jun 7, 2019, at 12:49 PM, Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>=20
> On Fri, 2019-06-07 at 11:29 -0700, Andy Lutomirski wrote:
>>> On Jun 7, 2019, at 10:59 AM, Dave Hansen <dave.hansen@intel.com> wrote:
>>>=20
>>>> On 6/7/19 10:43 AM, Peter Zijlstra wrote:
>>>> I've no idea what the kernel should do; since you failed to answer the
>>>> question what happens when you point this to garbage.
>>>>=20
>>>> Does it then fault or what?
>>>=20
>>> Yeah, I think you'll fault with a rather mysterious CR2 value since
>>> you'll go look at the instruction that faulted and not see any
>>> references to the CR2 value.
>>>=20
>>> I think this new MSR probably needs to get included in oops output when
>>> CET is enabled.
>>=20
>> This shouldn=E2=80=99t be able to OOPS because it only happens at CPL 3, r=
ight?  We
>> should put it into core dumps, though.
>>=20
>>>=20
>>> Why don't we require that a VMA be in place for the entire bitmap?
>>> Don't we need a "get" prctl function too in case something like a JIT is=

>>> running and needs to find the location of this bitmap to set bits itself=
?
>>>=20
>>> Or, do we just go whole-hog and have the kernel manage the bitmap
>>> itself. Our interface here could be:
>>>=20
>>>   prctl(PR_MARK_CODE_AS_LEGACY, start, size);
>>>=20
>>> and then have the kernel allocate and set the bitmap for those code
>>> locations.
>>=20
>> Given that the format depends on the VA size, this might be a good idea. =
 I
>> bet we can reuse the special mapping infrastructure for this =E2=80=94 th=
e VMA could
>> be a MAP_PRIVATE special mapping named [cet_legacy_bitmap] or similar, an=
d we
>> can even make special rules to core dump it intelligently if needed.  And=
 we
>> can make mremap() on it work correctly if anyone (CRIU?) cares.
>>=20
>> Hmm.  Can we be creative and skip populating it with zeros?  The CPU shou=
ld
>> only ever touch a page if we miss an ENDBR on it, so, in normal operation=
, we
>> don=E2=80=99t need anything to be there.  We could try to prevent anyone f=
rom
>> *reading* it outside of ENDBR tracking if we want to avoid people acciden=
tally
>> wasting lots of memory by forcing it to be fully populated when the read i=
t.
>>=20
>> The one downside is this forces it to be per-mm, but that seems like a
>> generally reasonable model anyway.
>>=20
>> This also gives us an excellent opportunity to make it read-only as seen f=
rom
>> userspace to prevent exploits from just poking it full of ones before
>> redirecting execution.
>=20
> GLIBC sets bits only for legacy code, and then makes the bitmap read-only.=
  That
> avoids most issues:

How does glibc know the linear address space size?  We don=E2=80=99t want LA=
64 to break old binaries because the address calculation changed.
