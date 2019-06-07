Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7066F39457
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2019 20:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbfFGS3y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jun 2019 14:29:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38880 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730348AbfFGS3y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 14:29:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id v11so1582819pgl.5
        for <linux-arch@vger.kernel.org>; Fri, 07 Jun 2019 11:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iPuLGydOavIYd0+wELWGKM4fGfit4THzqki57BPPV4U=;
        b=lg7aoPtqp9Hb92R8oH6RAUOmupz6mJN7bNCFgiizfRjRxEHrih+BHeECksF/ofFo+d
         Gca1+QdVmTh/8SL4feJ1/2529qt+bY7R4DNbVPsSnXMwFEHbMKCAJeDfe5oyP784L847
         zI5icl4CBjsxAnmXBxZOgOJkC67xHD5guteumdR+SzGRAqs+zcoxpcGYvNXrcj0Kg/KR
         t0RpPZcx8kewURUpcoeCa6Q9p/SCpI/AeBa72cgZYDOsIbMIEQuIVI08rJY/7o80AFHB
         IEXTdyNxMrTM0/BtMGFhILWDJk6/oALcRhTA/U9DE1OnXw5xwpv1vVb7lzhXy22LvO+I
         cMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iPuLGydOavIYd0+wELWGKM4fGfit4THzqki57BPPV4U=;
        b=gJfCN6I8wqCxJe03pJsKSSJJMO1I5RnJTFVRhEFVdtAv5Hg77/xdisha6W/xTRl+IQ
         4qQ5nLoKRHbsbMvSCnGTTu+Y1NdJqRAkplDTNOcbpldQRDgc/EV5zqcvKqbQCklGZVMa
         I3Dj6Zvyp3faCTDiR9ZA7buUKOAIoqzVPAo4oaqOpwzmOeYaOt8lXEumxgGaN95b8Pbl
         8WgpRmhH0SrPt58rJXRlfS400Q8R+1giaxNZGqu3FQIVSOeakK/a7gvVB3u4cp6SCkFv
         swPds01x+HmnhXVn74u/ipOsj2B44kigQbuNNlUg7nbCJrgQJeT+J2bJjOQuyaBscNE2
         BYIw==
X-Gm-Message-State: APjAAAUZC64d7WipM/ohxycRrJF3Ix9Uoe0zb4ap8yfoGqh6QohnNIRK
        8kQpx4A/ytasPi6CzdUQEQlQsQ==
X-Google-Smtp-Source: APXvYqzvhAzsKyCtFsLkEsrBKKf0SyVY50xd6UzRSykGMq36ETMdxZgn9Qk9tfswhyyV5VdxrKxgCg==
X-Received: by 2002:a17:90a:cb0a:: with SMTP id z10mr7463663pjt.101.1559932193640;
        Fri, 07 Jun 2019 11:29:53 -0700 (PDT)
Received: from ?IPv6:2600:1012:b044:6f30:60ea:7662:8055:2cca? ([2600:1012:b044:6f30:60ea:7662:8055:2cca])
        by smtp.gmail.com with ESMTPSA id 139sm3061757pfw.152.2019.06.07.11.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:29:52 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup function
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <b3de4110-5366-fdc7-a960-71dea543a42f@intel.com>
Date:   Fri, 7 Jun 2019 11:29:50 -0700
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <34E0D316-552A-401C-ABAA-5584B5BC98C5@amacapital.net>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com> <20190606200926.4029-4-yu-cheng.yu@intel.com> <20190607080832.GT3419@hirez.programming.kicks-ass.net> <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com> <20190607174336.GM3436@hirez.programming.kicks-ass.net> <b3de4110-5366-fdc7-a960-71dea543a42f@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Jun 7, 2019, at 10:59 AM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
>> On 6/7/19 10:43 AM, Peter Zijlstra wrote:
>> I've no idea what the kernel should do; since you failed to answer the
>> question what happens when you point this to garbage.
>>=20
>> Does it then fault or what?
>=20
> Yeah, I think you'll fault with a rather mysterious CR2 value since
> you'll go look at the instruction that faulted and not see any
> references to the CR2 value.
>=20
> I think this new MSR probably needs to get included in oops output when
> CET is enabled.

This shouldn=E2=80=99t be able to OOPS because it only happens at CPL 3, rig=
ht?  We should put it into core dumps, though.

>=20
> Why don't we require that a VMA be in place for the entire bitmap?
> Don't we need a "get" prctl function too in case something like a JIT is
> running and needs to find the location of this bitmap to set bits itself?
>=20
> Or, do we just go whole-hog and have the kernel manage the bitmap
> itself. Our interface here could be:
>=20
>    prctl(PR_MARK_CODE_AS_LEGACY, start, size);
>=20
> and then have the kernel allocate and set the bitmap for those code
> locations.

Given that the format depends on the VA size, this might be a good idea.  I b=
et we can reuse the special mapping infrastructure for this =E2=80=94 the VM=
A could
be a MAP_PRIVATE special mapping named [cet_legacy_bitmap] or similar, and w=
e can even make special rules to core dump it intelligently if needed.  And w=
e can make mremap() on it work correctly if anyone (CRIU?) cares.

Hmm.  Can we be creative and skip populating it with zeros?  The CPU should o=
nly ever touch a page if we miss an ENDBR on it, so, in normal operation, we=
 don=E2=80=99t need anything to be there.  We could try to prevent anyone fr=
om *reading* it outside of ENDBR tracking if we want to avoid people acciden=
tally wasting lots of memory by forcing it to be fully populated when the re=
ad it.

The one downside is this forces it to be per-mm, but that seems like a gener=
ally reasonable model anyway.

This also gives us an excellent opportunity to make it read-only as seen fro=
m userspace to prevent exploits from just poking it full of ones before redi=
recting execution.=
