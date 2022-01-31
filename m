Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1A84A4E39
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jan 2022 19:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbiAaS10 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 13:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350686AbiAaS1Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jan 2022 13:27:25 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403B2C06173B;
        Mon, 31 Jan 2022 10:27:25 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d18so13219575plg.2;
        Mon, 31 Jan 2022 10:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4xwJBi8q1FRa6SCCAyqdRaLBggch8TnlaM4QVC5L6s=;
        b=qE9n/zRiSBommfNv+Ylzgyl4CHXyFBAjKvVHTQ792Gi4mzAtyJFsUes4Iz130ZUigW
         mhlzucT9wN07qCC60leuIX7WsKtl2ubbqHHcgny8hGXpPYTjk/UzuNfmdMPnUpyDCPzl
         +NmEdOUvimEtOUQ0qV++b0NEQdzPFbUZXbg2YaS5u2u/Tn29oOLv0c21gGugpgGWqvb5
         SEyXRORSWstaGohz48PdB2o5gcCNbO9CTp9lkJEoFm3cGM0UbLfUjK92tESxnI/YAdRN
         w8dU0sI6ubF5nsNTQjI5D91UmNRmYGPjo0K/gU3LI8oQ+k76wgyWRknu/MCR1dRtES7F
         gk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4xwJBi8q1FRa6SCCAyqdRaLBggch8TnlaM4QVC5L6s=;
        b=43grz6Mm9pGfYfgJsRzvXFMowyh8JwyvJ/C0dtJt5SYxVAMRuEISjwc1Lxbc+iB4dI
         09Z0ghzfzCqJ8tZtqb07EAJ5U4HHCgKDiiOFV4fetIBcrtrIwAseCwiUUjGrQsdA2uyX
         r+UUTVCGZzeJduE3uCY3f+R5iVBaI0GbRBLc3ll/WPJ8UmEtziOhZrYv2Yi0r36rVAK3
         zzVUDpqgbOCwGjuP8yES9p7bXFZO/b2DscEZAreso5y6ywUt+aHB8dFfdngJZP/aZftx
         uvnkdJqSAPeB4Yj7HKiNkNea76kwH4RqcIVAaOOsBtmyRS9xe6dCndBPvOjG8kuR+fE3
         leKw==
X-Gm-Message-State: AOAM5308wAyQCOFC/ffH+JhdpfieNwiocd1jozAXxvayW4PrF9waZEhi
        86OlOOWl5BAIjUo9Sx8MR9sx1asagYkMD6qYK7E=
X-Google-Smtp-Source: ABdhPJw+fHsfw5UduK45wmBxPkeMk2UrZFl5cMQOPBj0yL+xKr7ja/LjgHWM13r4g3FwaPfZ+egF5l23vsHygbdb++o=
X-Received: by 2002:a17:90b:4f83:: with SMTP id qe3mr35727324pjb.120.1643653644745;
 Mon, 31 Jan 2022 10:27:24 -0800 (PST)
MIME-Version: 1.0
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-35-rick.p.edgecombe@intel.com> <87wnig8hj6.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87wnig8hj6.fsf@oldenburg.str.redhat.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 31 Jan 2022 10:26:49 -0800
Message-ID: <CAMe9rOrVvjL1F3UgOWL-gAGRyyiG6r20TWUusEUFhZMEEAjH7w@mail.gmail.com>
Subject: Re: [PATCH 34/35] x86/cet/shstk: Support wrss for userspace
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
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
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        Kostya Serebryany <kcc@google.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 30, 2022 at 11:57 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Rick Edgecombe:
>
> > For the current shadow stack implementation, shadow stacks contents cannot
> > be arbitrarily provisioned with data. This property helps apps protect
> > themselves better, but also restricts any potential apps that may want to
> > do exotic things at the expense of a little security.
> >
> > The x86 shadow stack feature introduces a new instruction, wrss, which
> > can be enabled to write directly to shadow stack permissioned memory from
> > userspace. Allow it to get enabled via the prctl interface.
>
> Why can't this be turned on unconditionally?

WRSS can be a security risk since it defeats the whole purpose of
Shadow Stack.  If an application needs to write to shadow stack,
it can make a syscall to enable it.  After the CET patches are checked
in Linux kernel, I will make a proposal to allow applications or shared
libraries to opt-in WRSS through a linker option, a compiler option or
a function attribute.

-- 
H.J.
