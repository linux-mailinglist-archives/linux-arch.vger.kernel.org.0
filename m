Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8CE4B1907
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 00:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345428AbiBJXH0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Feb 2022 18:07:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345429AbiBJXHZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Feb 2022 18:07:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7185F4F
        for <linux-arch@vger.kernel.org>; Thu, 10 Feb 2022 15:07:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7F8B5CE2736
        for <linux-arch@vger.kernel.org>; Thu, 10 Feb 2022 23:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9677C340F2
        for <linux-arch@vger.kernel.org>; Thu, 10 Feb 2022 23:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644534442;
        bh=MpjbTs2AoYPM1cEieyRbZViurjwRjHJe1IjmNAem4ZQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=frdqeK/4KF+IV3STYSZSVKlCiX6dBdwDfv1jfoD8mZtW25a7X1QdmuE4+T8YS+sD5
         LUdqzu+JkD1dS9sP3/cCSPTpQM5zAjuSB1MhiKOmklankPrxt+1bh6gGsCLLjMB6bv
         B6hGYhryNuYAR+GdGsBbMlMYniiDbjMHvrKu81qj75aNUVvyFYi6BxP7LsBL3PXwvt
         mGnj7tqDVd/w6pWDDPbyk8jhYA2IWHL+8mEGXIENHmrOQtu8oKRBVlksOEqRA6by+y
         z+yDwdF1HsVPmTQFqNpgsqfoJuoavNQIu6CiFq92InULFB/KNcYmzF7omQ+hIfbqIs
         W8nNn4zy0LmTQ==
Received: by mail-ed1-f52.google.com with SMTP id eg42so13533079edb.7
        for <linux-arch@vger.kernel.org>; Thu, 10 Feb 2022 15:07:22 -0800 (PST)
X-Gm-Message-State: AOAM5307+Vb90ds6Usx1zyZBM2jU2B28tyTjoe3X1Wg157yvLz4bzyHe
        T0Q0XzkjNeB984lq+IdIIhA6+1JkCdo7ljfhPHmTfA==
X-Google-Smtp-Source: ABdhPJxS8HJLUSGJfYOhID6yYZrHkqyIQTwmdEqPryBMs8qpUzLEn5ETtQ6MUdtPgqQJ5O+pj34qGLRGx/VYU3EGO5g=
X-Received: by 2002:a05:6402:90b:: with SMTP id g11mr7368740edz.73.1644534441171;
 Thu, 10 Feb 2022 15:07:21 -0800 (PST)
MIME-Version: 1.0
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-19-rick.p.edgecombe@intel.com> <4c216532-2b68-dd95-93f1-542df4786d7a@intel.com>
In-Reply-To: <4c216532-2b68-dd95-93f1-542df4786d7a@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 10 Feb 2022 15:07:09 -0800
X-Gmail-Original-Message-ID: <CALCETrWmiNi2+sPKWDUjGtGWtP9XNryfFe-dG4fTQkXyqGqpzQ@mail.gmail.com>
Message-ID: <CALCETrWmiNi2+sPKWDUjGtGWtP9XNryfFe-dG4fTQkXyqGqpzQ@mail.gmail.com>
Subject: Re: [PATCH 18/35] mm: Add guard pages around a shadow stack.
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
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
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <dave.martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 10, 2022 at 2:44 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 1/30/22 13:18, Rick Edgecombe wrote:
> > INCSSP(Q/D) increments shadow stack pointer and 'pops and discards' the
> > first and the last elements in the range, effectively touches those memory
> > areas.
> >
> > The maximum moving distance by INCSSPQ is 255 * 8 = 2040 bytes and
> > 255 * 4 = 1020 bytes by INCSSPD.  Both ranges are far from PAGE_SIZE.
> > Thus, putting a gap page on both ends of a shadow stack prevents INCSSP,
> > CALL, and RET from going beyond.
>
> What is the downside of not applying this patch?  The shadow stack gap
> is 1MB instead of 4k?
>
> That, frankly, doesn't seem too bad.  How badly do we *need* this patch?

1MB of oer-thread guard address space in a 32-bit program may be a
show stopper.  Do we intend to support any of this for 32-bit?

--Andy
