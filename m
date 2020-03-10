Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA4C17EDEE
	for <lists+linux-arch@lfdr.de>; Tue, 10 Mar 2020 02:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgCJBVF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Mar 2020 21:21:05 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54285 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgCJBVF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2020 21:21:05 -0400
Received: by mail-pj1-f66.google.com with SMTP id np16so666416pjb.4
        for <linux-arch@vger.kernel.org>; Mon, 09 Mar 2020 18:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:mime-version:subject:from:in-reply-to:cc
         :date:message-id:references:to;
        bh=mrUxxgNRy+5E4bEZVXAZNOiHka9AVVm3vCKbU9l6fA4=;
        b=g/iv7CpG8/DiYA4NA/mKsrAq67vf66xkLwrtr0OnzjXecbrlOk01TyaasjqzOJ/cy6
         jkjE+yfOHqhIEodGUnCwDH2I67yhqD/opVoCRpcoVgu+agPVZLyJsNAcnfduPxpLnSIY
         FWAJ7VcA1vbAbasZjJHBV3szxpyaw/IjVhpRpaZZAzmlolgnoqTrx5PFTbyFCLsWL/hh
         e+FHgrtXApyn35w6Vpk1Rs7+FEhw6F26iHRoXV7X8YTvuouFOniMH3ge0MiWbLs+nVG7
         4yVzA5v9uxjBTgJSNciJkl25N5hFus4/aSfLvMtEJHuvytjNWQXk1EtEGjXwJI8TsJ8b
         Lf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:mime-version:subject
         :from:in-reply-to:cc:date:message-id:references:to;
        bh=mrUxxgNRy+5E4bEZVXAZNOiHka9AVVm3vCKbU9l6fA4=;
        b=ghhH6QZeEHOZzXi7KpUCLEKmCIIF+BNkIzQiJeZ5kc3CGH/vyArPZS1ftohb4tYOwX
         nmrPvVxdO5hrQS0ptP54q+dcvl+E6wtcCmwVkzdcuPOLrwAkuGt+gTSqis6z3DX7BdN7
         BLyEudhv0dYsZ3OIg+b/2vIJQG3ujLdMzSCmpsJN4HHMVVYkRjyZy+oGu629Ezt2ByrM
         6Xq3N1euNvcpAuL+gJCPoYTEE36yrGJWwSC/2vpjEICCyAbRVMTnNK50Nj0s4zVpg1hf
         Zl9966nynofGaqeJG2txPgZI8Z/0GF27fLW9K5DGH+IWWfUDajf9dHGNzk8DR6o1pwJH
         YtVg==
X-Gm-Message-State: ANhLgQ37HLBft6h5ckO4gwNeFAGfZz/z6wCNP5qqhjVXs6YrvNOBCOct
        LiBuNFNTXJljK1UqMU2/Da463Q==
X-Google-Smtp-Source: ADFU+vsv4okX8I4n8qmcxoYDTnfJmLGi0d3Bk5liMiDsLRDCvsApNaCvlR6NOzyOKkYBsF2RXUSNlQ==
X-Received: by 2002:a17:902:8a8f:: with SMTP id p15mr14339433plo.45.1583803264156;
        Mon, 09 Mar 2020 18:21:04 -0700 (PDT)
Received: from ?IPv6:2600:1010:b047:6b2c:4878:83f4:4223:51c6? ([2600:1010:b047:6b2c:4878:83f4:4223:51c6])
        by smtp.gmail.com with ESMTPSA id 17sm14250924pfu.166.2020.03.09.18.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2020 18:21:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
From:   Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <CAMe9rOpJjaro_qK6kghGNuSHDaP_MjVaZMbok2kbuBD48VmvXg@mail.gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
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
Date:   Mon, 9 Mar 2020 18:21:01 -0700
Message-Id: <E7E7A2AE-500A-4817-B00A-BE419E89C6F9@amacapital.net>
References: <CAMe9rOpJjaro_qK6kghGNuSHDaP_MjVaZMbok2kbuBD48VmvXg@mail.gmail.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I am baffled by this discussion.

>> On Mar 9, 2020, at 5:09 PM, H.J. Lu <hjl.tools@gmail.com> wrote:
>>=20
>> =EF=BB=BFOn Mon, Mar 9, 2020 at 4:59 PM Andy Lutomirski <luto@amacapital.=
net> wrote:
>=20
>>>> .
>> This could presumably have been fixed by having libpcre or sljit
>> disable IBT before calling into JIT code or by running the JIT code in
>> another thread.  In the other direction, a non-CET libpcre build could
>> build IBT-capable JITted code and enable JIT (by syscall if we allow
>> that or by creating a thread?) when calling it.  And IBT has this
>=20
> This is not how thread in user space works.

void create_cet_thread(void (*func)(), unsigned int cet_flags);

I could implement this using clone() if the kernel provides the requisite su=
pport. Sure, creating threads behind libc=E2=80=99s back like this is perilo=
us, but it can be done.

>=20
>> fancy legacy bitmap to allow non-instrumented code to run with IBT on,
>> although SHSTK doesn't have hardware support for a similar feature.
>=20
> All these changes are called CET enabing.

What does that mean?  If program A loads library B, and library B very caref=
ully loads CET-mismatched code, program A may be blissfully unaware.

>=20
>> So, sure, the glibc-linked ELF ecosystem needs some degree of CET
>> coordination, but it is absolutely not the case that a process MUST
>> have all CET or no CET.  Let's please support the complicated cases in
>> the kernel and the ABI too.  If glibc wants to make it annoying to do
>> complicated things, so be it.  People work behind glibc's back all the
>> time.
>=20
> CET is no different from NX in this regard.

NX is in the page tables, and CET, mostly, is not.  Also, we seriously flubb=
ed READ_IMPLIES_EXEC and made it affect far more mappings than ever should h=
ave been affected.

If a legacy program (non-NX-aware) loads a newer library, and the library op=
ens a device node and mmaps it PROT_READ, it gets RX.  This is not a good de=
sign. In fact, it=E2=80=99s actively problematic.

Let us please not take Linux=E2=80=99s NX legacy support as an example of go=
od design.=
