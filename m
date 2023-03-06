Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F3F6ACC49
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 19:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCFSRE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 13:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCFSRA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 13:17:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ADC72030
        for <linux-arch@vger.kernel.org>; Mon,  6 Mar 2023 10:16:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01FB06106E
        for <linux-arch@vger.kernel.org>; Mon,  6 Mar 2023 18:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52824C4339B
        for <linux-arch@vger.kernel.org>; Mon,  6 Mar 2023 18:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678126526;
        bh=e9jsHK3Y3izRmScqj6Tbq8eAsCdvQQ3sYqO3uE9+g1c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X7HyX1ufkWoGU//VkDtxJVveZft2IwVqIiE6+D7boTvye2has1qPlXB+ml8GEvUOA
         SG95FrQa633Rz+KBE+jO82k021+qFZCGkmprtSskcIKsvFlGYsDAtFuQHbM0Lf9nWg
         BtYhTd1wFXGW3Livr2KSz9TzLcKQz7PJeATt5r1XSo7LtXwxJQU2P0i4kWuDwI2NSo
         jdky09uU8ZavZ46KebHBCEnp6/ZVf1dzuMKyuXcELHpHQYqs6d227Wj01VjzwEDOz6
         jyDm9IRCtkcM2mK0OeawEJWaiU4LssfCyzp2t8X9PdFy2MkWR+hhLpARkP/OnBHZCC
         QhVZmX/+DrGNQ==
Received: by mail-ed1-f49.google.com with SMTP id g3so42532641eda.1
        for <linux-arch@vger.kernel.org>; Mon, 06 Mar 2023 10:15:26 -0800 (PST)
X-Gm-Message-State: AO0yUKUa6zzGxpyfgWZxfXK5obIlDunKHxhAxCLiZLKB1E1EoqFnFYx/
        PpHYWN8lWujQ+c81xKqiGgZjcbe+a2i7p3vuocSS3A==
X-Google-Smtp-Source: AK7set8SLbHFbKu50C45V+XmZcA37AlGVkaEVMQnfhtMxcFSuf0+tBBA5TxTGatK6nCBit+HSX9pGacUV5OMJ4H5Ack=
X-Received: by 2002:a50:9318:0:b0:4ad:72b2:cf53 with SMTP id
 m24-20020a509318000000b004ad72b2cf53mr6481738eda.2.1678126524529; Mon, 06 Mar
 2023 10:15:24 -0800 (PST)
MIME-Version: 1.0
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-25-rick.p.edgecombe@intel.com> <ZAXmOZYcoR3hq/CH@zn.tnic>
In-Reply-To: <ZAXmOZYcoR3hq/CH@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 6 Mar 2023 10:15:13 -0800
X-Gmail-Original-Message-ID: <CALCETrViDpTbuBk+9wQa-PNzKZerwk=4MmKMXw2v3Ysxuv2k3A@mail.gmail.com>
Message-ID: <CALCETrViDpTbuBk+9wQa-PNzKZerwk=4MmKMXw2v3Ysxuv2k3A@mail.gmail.com>
Subject: Re: [PATCH v7 24/41] mm: Don't allow write GUPs to shadow stack memory
To:     Borislav Petkov <bp@alien8.de>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 6, 2023 at 5:10=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrote=
:
>
> On Mon, Feb 27, 2023 at 02:29:40PM -0800, Rick Edgecombe wrote:
> > The x86 Control-flow Enforcement Technology (CET) feature includes a ne=
w
> > type of memory called shadow stack. This shadow stack memory has some
> > unusual properties, which requires some core mm changes to function
> > properly.
> >
> > Shadow stack memory is writable only in very specific, controlled ways.
> > However, since it is writable, the kernel treats it as such. As a resul=
t
>                                                                          =
 ^
>                                                                          =
 ,
>
> > there remain many ways for userspace to trigger the kernel to write to
> > shadow stack's via get_user_pages(, FOLL_WRITE) operations. To make thi=
s a

Is there an alternate mechanism, or do we still want to allow
FOLL_FORCE so that debuggers can write it?

--Andy
