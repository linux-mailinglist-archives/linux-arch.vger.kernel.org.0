Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC7E3EF323
	for <lists+linux-arch@lfdr.de>; Tue, 17 Aug 2021 22:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbhHQUNq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Aug 2021 16:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbhHQUNq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Aug 2021 16:13:46 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0230AC061796
        for <linux-arch@vger.kernel.org>; Tue, 17 Aug 2021 13:13:13 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j1so966941pjv.3
        for <linux-arch@vger.kernel.org>; Tue, 17 Aug 2021 13:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Qn12Bt9lqkgM5Y8ZA32WQkTEE6ZrP4WykYQaAHbU6bw=;
        b=ZxGaRtIt0oBicK9RMeZa/zpUJ73fThIcSyHiWhc6pHKYYanyug7eKtat/O3c5kO5mw
         gHRwyxDy3AneGChipItpQ7AGbSoStDQNCgP17rEZ04NNruirntDKGQ5oArsT6Rf8l5mq
         FD6bPE7pI1gIqFgVvHXZi5ErvPUUfOpbVmxvOQPjoatcIL9hafPEs2tslUe61IOOA9Ip
         YYtM22LzKxHubSB8LayLmab6h006bJ483+BiX9MOeLdUAI384Q2kg/BSN0DCsa/q/xBh
         /bn21nVc5wPJzHgclOptUAYiOUKZWeYsx8VyLDrycaLyO5LmotQtsp+KgX+NYlupgRkS
         D4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Qn12Bt9lqkgM5Y8ZA32WQkTEE6ZrP4WykYQaAHbU6bw=;
        b=PlUxxV6siSglQQjDfdmOnCbZITR5mgKiBqr/Fzxejjk9HrWcOU44LqpIpo33Kug55F
         gGEwPqx/1xCtg3Mm/jDKNNtg1wejEoKtsNwfIwmdLkXtYJ7T8HVokUdqqj6sz0SwkDUP
         zhgZc/zchJ+YaWT2kkU5JPz2j9oJrYcPCty244+uR19TPxOUlt5YXkXprIfF3mIBi0RR
         1zt/YXLs5D+B4jiC4bTAfBpFHjLKxLfaQmy3jCWItq4L8AnVoLGL3VKgaCywrxTnapm8
         PQMAj3d55rLmKTjnx9XP7SVXs9aMsIGcO2ijR0I7jObiM2aC0QwELVzLhixbKpF8cvEn
         xpFg==
X-Gm-Message-State: AOAM530uv6Dz8812AvMSBhxyTVHTVoT4RHJQw07osjM1nfRWAu190xko
        u/NcX3bKl+oMDZdbmSGsf0mqRA==
X-Google-Smtp-Source: ABdhPJy1rQGRBW8og3iBsiEHWYdl0Z67c7meR88EwdCS+j3BmrvipKWVwAm5pIZRYgXr8OiaPjva8A==
X-Received: by 2002:a17:902:db01:b0:12d:ccb0:f8b1 with SMTP id m1-20020a170902db0100b0012dccb0f8b1mr4250158plx.43.1629231192511;
        Tue, 17 Aug 2021 13:13:12 -0700 (PDT)
Received: from smtpclient.apple ([2601:646:c200:1ef2:e1d8:e750:e609:cd1d])
        by smtp.gmail.com with ESMTPSA id a2sm4165198pgb.19.2021.08.17.13.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 13:13:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v28 09/32] x86/mm: Introduce _PAGE_COW
Date:   Tue, 17 Aug 2021 13:13:09 -0700
Message-Id: <1A27F5DF-477B-45B7-AD33-CC68D9B7CB89@amacapital.net>
References: <YRwT7XX36fQ2GWXn@zn.tnic>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
In-Reply-To: <YRwT7XX36fQ2GWXn@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: iPhone Mail (18G82)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Aug 17, 2021, at 12:53 PM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> =EF=BB=BFOn Tue, Aug 17, 2021 at 11:24:29AM -0700, Yu, Yu-cheng wrote:
>> Indeed, this can be looked at in a few ways.  We can visualize pte_write(=
)
>> as 'CPU can write to it with MOV' or 'CPU can write to it with any opcode=
s'.
>> Depending on whatever pte_write() is, copy-on-write code can be adjusted
>> accordingly.
>=20
> Can be?
>=20
> I think you should exclude shadow stack pages from being writable
> and treat them as read-only. How the CPU writes them is immaterial -
> pte/pmd_write() is used by normal kernel code to query whether the page
> is writable or not by any instruction - not by the CPU.
>=20
> And since normal kernel code cannot write shadow stack pages, then for
> that code those pages are read-only.
>=20
> If special kernel code using shadow stack management insns needs
> to modify a shadow stack, then it can check whether a page is
> pte/pmd_shstk() but that code is special anyway.
>=20
> Hell, a shadow stack page is (Write=3D0, Dirty=3D1) so calling it writable=

>                  ^^^^^^^
> is simply wrong.

But it *is* writable using WRUSS, and it=E2=80=99s also writable by CALL, WR=
SS, etc.

Now if the mm code tries to write protect it and expects sensible semantics,=
 the results could be interesting. At the very least, someone would need to v=
alidate that RET reading a read only shadow stack page does the right thing.=


>=20
> Thx.
>=20
> --=20
> Regards/Gruss,
>    Boris.
>=20
> https://people.kernel.org/tglx/notes-about-netiquette
